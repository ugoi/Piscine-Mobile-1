import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  String _currentLocation = 'Heilbronn';
  String _searchLocation = '';
  String _displayLocation = '';

  final _pageViewController = PageController();

  void _onLocationClicked() {
    setState(() {
      _displayLocation = _currentLocation;
    });
  }

  void _onSearchLocationSubmitted(String value) {
    // Strip value for max length
    if (value.length > 100) {
      value = value.substring(0, 100);
    }
    setState(() {
      _searchLocation = value;
      _displayLocation = _searchLocation;
    });
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: TextField(
            decoration: const InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
            ),
            onSubmitted: (value) {
              _onSearchLocationSubmitted(value);
            },
          ),
          // PLace button after the title
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.navigation),
              onPressed: () {
                _onLocationClicked();
              },
            ),
          ]),
      body: PageView(
        controller: _pageViewController,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        children: <Widget>[
          Center(
            child: FittedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Currently', style: TextStyle(fontSize: 24)),
                  Text(_displayLocation, style: TextStyle(fontSize: 24)),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Today', style: TextStyle(fontSize: 24)),
                Text(_displayLocation, style: TextStyle(fontSize: 24)),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Weekly', style: TextStyle(fontSize: 24)),
                Text(_displayLocation, style: TextStyle(fontSize: 24)),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.sunny),
            label: 'Currently',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_week),
            label: 'Weekly',
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.primary,
        // TRY THIS: Change the color of the unselected items to a specific color
        // (to Colors.blue, perhaps?) and trigger a hot reload to see the
        // BottomNavigationBar change color while the other colors stay the same.
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        onTap: (int index) {
          _pageViewController.animateToPage(index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        },
      ),
    );
  }
}
