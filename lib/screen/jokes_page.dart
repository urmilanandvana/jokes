import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apihelper/apihelper.dart';

class JokesPage extends StatefulWidget {
  const JokesPage({Key? key}) : super(key: key);

  @override
  State<JokesPage> createState() => _JokesPageState();
}

class _JokesPageState extends State<JokesPage> {
  DateTime currentDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();

  List addJokes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff25316D),
        title: const Text("Jokes"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('addJokes', true);
            },
            icon: const Icon(
              Icons.add_circle,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: APIHelper.apiHelper.fetchSingleJokesDate(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("error :- ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            return Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Date: ${snapshot.data!.createdAt.year}-${snapshot.data!.createdAt.month}-${snapshot.data!.createdAt.day}",
                        style: const TextStyle(
                          color: Color(0xff25316D),
                          letterSpacing: 1,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Time: ${snapshot.data!.createdAt.hour}-${snapshot.data!.createdAt.minute}-${snapshot.data!.createdAt.second}",
                        style: const TextStyle(
                          color: Color(0xff25316D),
                          letterSpacing: 1,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage(snapshot.data!.iconUrl),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [],
                  ),
                  Container(
                    height: 300,
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xff25316D),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        textAlign: TextAlign.center,
                        snapshot.data!.value,
                        style: const TextStyle(
                          color: Colors.white,
                          letterSpacing: 1,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
