import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/data_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DataModel> allData = [];

  String link =
      "http://123.136.26.211:8085/wholesaleclub/api/v2/departments/all";
  fetchData() async {
    var response = await http.get(Uri.parse(link));
    print("Status code is ${response.statusCode}");
    // print("${response.body}");
    if (response.statusCode == 200) {
      final item = jsonDecode(response.body);
      for (var data in item["data"]) {
        DataModel dataModel = DataModel(
          name: data["name"],
        );
        setState(() {
          allData.add(dataModel);
        });
      }
      print("Total length is ${allData.length}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data from api'),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          child: ListView.builder(
            itemCount: allData.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Card(
                  elevation: 12,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("${allData[index].banner}"),
                    ),
                    title: Text(allData[index].name.toString()),
                    subtitle: Text(allData[index].id.toString()),
                    trailing: Text(allData[index].ad.toString()),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
