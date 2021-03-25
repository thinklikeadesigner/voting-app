import 'package:firebase_auth/firebase_auth.dart';
//always
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
//always
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: 'FlutterFire Votes',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: MyHomePage(title: 'FlutterFire Votes'));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseReference dbRoot;
  String currentRoundKey;
  String option1;
  String option2;
  User user;
  void vote(value) {
    dbRoot.child('votes/${user.uid}').set(value);
  }

  _MyHomePageState();

  @override
  void initState() {
    super.initState();
// remember to go to firebase authentication and enable anonymous sign in, and add firebase auth to pub spec, and import firebase auth
    FirebaseAuth.instance.signInAnonymously().then((result) {
      setState(() {
        this.user = result.user;
      });
    });
    dbRoot = FirebaseDatabase.instance.reference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
                child: Row(
              children: <Widget>[
                Expanded(
                    child: RaisedButton(
                        child: Text('Yes'),
                        color: Colors.orange,
                        onPressed: () {
                          vote('Yes');
                        })),
                Expanded(
                    child: RaisedButton(
                        child: Text('No'),
                        color: Colors.blue,
                        onPressed: () {
                          vote('No');
                        }))
              ],
            ))));
  }
}
