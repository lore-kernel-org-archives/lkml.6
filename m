Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB099C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870372081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ivweYYUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870372081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeK2V0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:26:05 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:13552 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbeK2V0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:26:04 -0500
X-IronPort-AV: E=Sophos;i="5.56,294,1539673200"; 
   d="scan'208";a="23348105"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Nov 2018 03:21:12 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 29 Nov 2018 03:21:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUhS/ysPWiw0poDRX/lqX58Ox28n/vyQ5moQ9qjT/30=;
 b=ivweYYUbvBw3XEzIGVQ3zw9/AWnmg5raojfAQaDukdL8GihuefFUW4PO4danquj1E4NlmwIY+9ur5rZAfE2OCSu/Ie8HtJ8i9DxZW+7oiT2Its9DWv2tp0gUCNfvi9bmVL+zt161w5Vi2DqXAXfpxu1WobUyjjGjcdHLkXSJsHs=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0568.namprd11.prod.outlook.com (10.163.159.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.18; Thu, 29 Nov 2018 10:21:08 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 10:21:08 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <harini.katakam@xilinx.com>, <Nicolas.Ferre@microchip.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>
Subject: Re: [RFC PATCH] net: macb: Apply RXUBR workaround only to versions
 with errata
Thread-Topic: [RFC PATCH] net: macb: Apply RXUBR workaround only to versions
 with errata
Thread-Index: AQHUh804bu3Co8uTGEqCd0JItPQ7vA==
Date:   Thu, 29 Nov 2018 10:21:08 +0000
Message-ID: <b838b826-9395-fbe9-1b4c-34be574b33cf@microchip.com>
References: <1542967157-8053-1-git-send-email-harini.katakam@xilinx.com>
In-Reply-To: <1542967157-8053-1-git-send-email-harini.katakam@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0063.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::16) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0568;6:WK8g+Iceo06LagAohajtn9OHnExtmTpq0oCo1a7ISwPWAIASWOz4LT24ZaP/HCyjeagE1qqHgLMMEdkf3/xoddSo+LSWwSf9t2u9rx602U9DsmCV7EcSfjcNsfNnEL/Ava7mAj2pir1GHcAddLr8CMT+M7fNUXfhLPb3Hcy/IJoWbNp4GXCPplfe81h0Gwes5Q3GCxgW8LSiAQuQ5R6Q+8nKadWYa+apgqzlykkrePw0WmTh6wdoYkIcjP3WZJV+6HPoq6MCTXTLmG2W4nPv+FoL7n9WJ7/a4vKQTmABdPoL8+Zyq1NbIzoUhNV8AA72DKWwruhJTdLOO1QZ31eYNf5FtMQ/Z6MVGMdOxyPm5ypRdUip6Z0zyZ/q8Lq5Atyn0NwO9hY+SMHSP6hG9gZQBHGWWK3Kp4Sj4sG3d+6IfKoYlSUX81N2GHYK11+3UEO5abzof/mePEuNCfxw59s41Q==;5:b8KreTcjcrR68HZc4jh+CMJA0QOOVtEVIqohIPHXtSYmeHBFvjydr+IocpTBaO9vO7FCRX+Hro86e9tdHppFvgai9lMlIk203glj22wmRjS4aJN7g9HKgvpYdOHytgkmJoCC6QOvLg5sy++OZPGI0einzLwws0UqpOwdbS8Ktlg=;7:bK9R+Lyb4teZap4Di7kQKd1tos4U9Db1ZtXgt/tfIrE3QIA4pjTvhbZNxMVq40FhfTuY3NW72WfKkH7c36yCYojsMMhpGak+FQNO4GBDlxD76CQAtZAM6dt/qc59WaQZ5miQ55RIXzt2QWiYWvAoGg==
x-ms-office365-filtering-correlation-id: 041cc4ea-6c6a-4ce4-cde2-08d655e46068
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0568;
x-ms-traffictypediagnostic: BY2PR11MB0568:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-microsoft-antispam-prvs: <BY2PR11MB05688513002981897168C00287D20@BY2PR11MB0568.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231453)(999002)(944501447)(4982022)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0568;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0568;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(136003)(396003)(199004)(189003)(11346002)(2616005)(25786009)(476003)(446003)(478600001)(2501003)(316002)(39060400002)(54906003)(110136005)(8676002)(229853002)(106356001)(256004)(81156014)(8936002)(81166006)(186003)(486006)(4326008)(105586002)(6486002)(6246003)(5660300001)(68736007)(53936002)(99286004)(97736004)(72206003)(6436002)(6512007)(31686004)(966005)(6306002)(102836004)(6116002)(3846002)(26005)(71190400001)(71200400001)(7736002)(2906002)(31696002)(53546011)(52116002)(6506007)(14454004)(66066001)(386003)(305945005)(76176011)(36756003)(575784001)(86362001)(562404015);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0568;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TrbnSi/AZkIvo9xE/CD8/i88myzz8pOG2H7FRZTsHS/Ye2aule3qkFtqclKFW0VknEwN+giWYbd5jpG/vXy3HYCzlykMO/jMKGnpQOZWRFA49MNXGLL0vLUhSvXa1wstZ3rlsFHm14Y8m1073T5Alg47V4HkiBPeSA7kkmtnGX036k5Pv4SArPvv1OvNxXTxoAgSqmjjFaskTCh/xGJl2mfT0qbjzTD1X0PvkZBOiYCROdKUloCSZIvwAXKnUYKUAkWqwple30rDutuWQ2rGwhVgC6SW9Kup8iTXkzqK9X//zGqLEEqyEqlgL/KELahb9rvHuFARzN4es2sg2elUhNuT6Ltc7oedMRfr0RvyuN0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D0586D210AD2F4395F29CE408DBD453@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 041cc4ea-6c6a-4ce4-cde2-08d655e46068
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 10:21:08.1412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0568
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIzLjExLjIwMTggMTE6NTksIEhhcmluaSBLYXRha2FtIHdyb3RlOg0KPiBUaGUgaW50
ZXJydXB0IGhhbmRsZXIgY29udGFpbnMgYSB3b3JrYXJvdW5kIGZvciBSWCBoYW5nIGFwcGxpY2Fi
bGUNCj4gdG8gWnlucSBhbmQgQVQ5MSBvbmx5LiBTdWJzZXF1ZW50IHZlcnNpb25zIGRvIG5vdCBu
ZWVkIHRoaXMNCj4gd29ya2Fyb3VuZC4gVGhpcyB3b3JrYXJvdW5kIHVuZWNlc3NhcmlseSByZXNl
dCBSWCB3aGVuZXZlciBSWCB1c2VkDQo+IGJpdCByZWFkIGlzIG9ic2VydmVkLCB3aGljaCBjYW4g
YmUgb2Z0ZW4gdW5kZXIgaGVhdnkgdHJhZmZpYy5IZW5jZQ0KPiBpbnRyb2R1Y2UgYW4gZXJyYXRh
IGZpZWxkIGFuZCBhIGNoZWNrIHRvIGVuYWJsZSB0aGlzIHdvcmthcm91bmQuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBIYXJpbmkgS2F0YWthbSA8aGFyaW5pLmthdGFrYW1AeGlsaW54LmNvbT4NCj4g
LS0tDQo+IE5vdGU6IEVuYWJsZWQgdGhlIGVycmF0YSBpbiB6eW5xIGFuZCBhdDkxIGNvbmZpZ3Mg
b25seS4NCj4gUGxlYXNlIGFkdmlzZSBpZiBhbnkgb3RoZXIgdmVyc2lvbnMgYXJlIGFmZmVjdGVk
IGJ5IHRoaXMgZXJyYXRhLg0KPiANCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVuY2UvbWFj
Yi5oICAgICAgfCA2ICsrKysrKw0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNi
X21haW4uYyB8IDkgKysrKysrKy0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvY2FkZW5jZS9tYWNiLmggYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2IuaA0K
PiBpbmRleCAzZDQ1ZjRjLi5mNjkwM2Q2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9jYWRlbmNlL21hY2IuaA0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNl
L21hY2IuaA0KPiBAQCAtNjQ4LDYgKzY0OCw5IEBADQo+ICAjZGVmaW5lIE1BQ0JfQ0FQU19TR19E
SVNBQkxFRAkJCTB4NDAwMDAwMDANCj4gICNkZWZpbmUgTUFDQl9DQVBTX01BQ0JfSVNfR0VNCQkJ
MHg4MDAwMDAwMA0KPiAgDQo+ICsvKiBFcnJhdGEgbWFzayBiaXRzICovDQo+ICsjZGVmaW5lIE1B
Q0JfRVJSQVRBX1JYTE9DS1VQCQkJMHgwMDAwMDAwMQ0KPiArDQo+ICAvKiBMU08gc2V0dGluZ3Mg
Ki8NCj4gICNkZWZpbmUgTUFDQl9MU09fVUZPX0VOQUJMRQkJCTB4MDENCj4gICNkZWZpbmUgTUFD
Ql9MU09fVFNPX0VOQUJMRQkJCTB4MDINCj4gQEAgLTEwODUsNiArMTA4OCw3IEBAIHN0cnVjdCBt
YWNiX2NvbmZpZyB7DQo+ICAJCQkgICAgc3RydWN0IGNsayAqKnJ4X2Nsayk7DQo+ICAJaW50CSgq
aW5pdCkoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldik7DQo+ICAJaW50CWp1bWJvX21heF9s
ZW47DQo+ICsJdTMyCWVycmF0YTsNCj4gIH07DQo+ICANCj4gIHN0cnVjdCB0c3VfaW5jciB7DQo+
IEBAIC0xMjE0LDYgKzEyMTgsOCBAQCBzdHJ1Y3QgbWFjYiB7DQo+ICANCj4gIAlpbnQJcnhfYmRf
cmRfcHJlZmV0Y2g7DQo+ICAJaW50CXR4X2JkX3JkX3ByZWZldGNoOw0KPiArDQo+ICsJdTMyIGVy
cmF0YTsNCj4gIH07DQo+ICANCj4gICNpZmRlZiBDT05GSUdfTUFDQl9VU0VfSFdTVEFNUA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNiX21haW4uYyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2NhZGVuY2UvbWFjYl9tYWluLmMNCj4gaW5kZXggMWQ4NmI0ZC4u
ZjBiYjhhNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNi
X21haW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5j
DQo+IEBAIC0xMzc5LDcgKzEzNzksOCBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgbWFjYl9pbnRlcnJ1
cHQoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0KPiAgCQkgKiB0aGUgYXQ5MSBtYW51YWwsIHNlY3Rp
b24gNDEuMy4xIG9yIHRoZSBaeW5xIG1hbnVhbA0KPiAgCQkgKiBzZWN0aW9uIDE2LjcuNCBmb3Ig
ZGV0YWlscy4NCj4gIAkJICovDQo+IC0JCWlmIChzdGF0dXMgJiBNQUNCX0JJVChSWFVCUikpIHsN
Cj4gKwkJaWYgKChicC0+ZXJyYXRhICYgTUFDQl9FUlJBVEFfUlhMT0NLVVApICYmDQo+ICsJCSAg
ICAoc3RhdHVzICYgTUFDQl9CSVQoUlhVQlIpKSkgew0KDQpKdXN0IGFza2luZywgZGlkIHlvdSBt
YW5hZ2UgdG8gdGVzdCB0aGlzIG9uIG90aGVyIHBsYXRmb3JtcyB0aGF0IGhhdmVuJ3QNCnRoaXMg
aXNzdWU/DQpTQU1BNUQyIGRhdGFzaGVldCBbMV0gc3RhdGVzIHRoaXM6DQoiV2hlbiBpbiBwYWNr
ZXQgYnVmZmVyIGZ1bGwgc3RvcmUgYW5kIGZvcndhcmQgbW9kZSwgb25seSBnb29kIHJlY2VpdmVk
DQpmcmFtZXMgYXJlIHdyaXR0ZW4gb3V0IG9mIHRoZSBETUEsIHNvIG5vDQogZnJhZ21lbnRzIHdp
bGwgZXhpc3QgaW4gdGhlIEFIQiBidWZmZXJzIGR1ZSB0byBNQUMgcmVjZWl2ZXIgZXJyb3JzLiBU
aGVyZQ0KaXMgc3RpbGwgdGhlIHBvc3NpYmlsaXR5IG9mIGZyYWdtZW50cyBkdWUgdG8NCiBETUEg
ZXJyb3JzLCBmb3IgZXhhbXBsZSB1c2VkIGJpdCByZWFkIG9uIHRoZSBzZWNvbmQgYnVmZmVyIG9m
IGENCm11bHRpYnVmZmVyIGZyYW1lLiINCg0KQnV0IGl0IGlzIHRydWUgdGhhdCBub3doZXJlIGlz
IHByZXNlbnRlZCB0aGF0IHRoaXMgbXVzdCBiZSBzcGVjaWFsIHRyZWF0ZWQuDQoNCk1vcmVvdmVy
LCBpZiB5b3UgZG8gdGhpcyBvbmx5IGZvciBNQUNCX0VSUkFUQV9SWExPQ0tVUCBhbmQgc3RpbGwg
aGF2ZSBSWFVCUg0KaW50ZXJydXB0IGVuYWJsZWQgZXZlcnkgdGltZSBpdCB3b3VsZCBub3QgbWFr
ZSBzZW5zZSB0byBzdGlsbCBlbmFibGUgaXQuDQpPciwgaWYgeW91IHdhbnQgaXQgZW5hYmxlZCBl
dmVyeSB0aW1lLCB5b3Ugc2hvdWxkIGNsZWFyIGl0IG5vIG1hdHRlciB0aGUNCk1BQ0JfRVJSQVRB
X1JYTE9DS1VQIGlzIHNldCBvciBub3QsIHdpdGggc29tZXRoaW5nIGxpa2UgdGhpczoNCg0KICAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKGJwLT5jYXBzICYgTUFDQl9DQVBTX0lTUl9DTEVBUl9P
Tl9XUklURSkNCg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBxdWV1ZV93cml0ZWwo
cXVldWUsIElTUiwgTUFDQl9CSVQoUlhVQlIpKTsNCg0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJl
em5lYQ0KDQpbMV0gaHR0cDovL3d3MS5taWNyb2NoaXAuY29tL2Rvd25sb2Fkcy9lbi9kZXZpY2Vk
b2MvZHM2MDAwMTQ3NmIucGRmDQoNCj4gIAkJCWN0cmwgPSBtYWNiX3JlYWRsKGJwLCBOQ1IpOw0K
PiAgCQkJbWFjYl93cml0ZWwoYnAsIE5DUiwgY3RybCAmIH5NQUNCX0JJVChSRSkpOw0KPiAgCQkJ
d21iKCk7DQo+IEBAIC0zODM1LDYgKzM4MzYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG1hY2Jf
Y29uZmlnIGF0OTFzYW05MjYwX2NvbmZpZyA9IHsNCj4gIAkuY2FwcyA9IE1BQ0JfQ0FQU19VU1JJ
T19IQVNfQ0xLRU4gfCBNQUNCX0NBUFNfVVNSSU9fREVGQVVMVF9JU19NSUlfR01JSSwNCj4gIAku
Y2xrX2luaXQgPSBtYWNiX2Nsa19pbml0LA0KPiAgCS5pbml0ID0gbWFjYl9pbml0LA0KPiArCS5l
cnJhdGEgPSBNQUNCX0VSUkFUQV9SWExPQ0tVUCwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbWFjYl9jb25maWcgc2FtYTVkM21hY2JfY29uZmlnID0gew0KPiBAQCAtMzkwMCw2
ICszOTAyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtYWNiX2NvbmZpZyB6eW5xX2NvbmZpZyA9
IHsNCj4gIAkuZG1hX2J1cnN0X2xlbmd0aCA9IDE2LA0KPiAgCS5jbGtfaW5pdCA9IG1hY2JfY2xr
X2luaXQsDQo+ICAJLmluaXQgPSBtYWNiX2luaXQsDQo+ICsJLmVycmF0YSA9IE1BQ0JfRVJSQVRB
X1JYTE9DS1VQLA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2Vf
aWQgbWFjYl9kdF9pZHNbXSA9IHsNCj4gQEAgLTQwMDUsOCArNDAwOCwxMCBAQCBzdGF0aWMgaW50
IG1hY2JfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlicC0+aGNsayA9
IGhjbGs7DQo+ICAJYnAtPnR4X2NsayA9IHR4X2NsazsNCj4gIAlicC0+cnhfY2xrID0gcnhfY2xr
Ow0KPiAtCWlmIChtYWNiX2NvbmZpZykNCj4gKwlpZiAobWFjYl9jb25maWcpIHsNCj4gIAkJYnAt
Pmp1bWJvX21heF9sZW4gPSBtYWNiX2NvbmZpZy0+anVtYm9fbWF4X2xlbjsNCj4gKwkJYnAtPmVy
cmF0YSA9IG1hY2JfY29uZmlnLT5lcnJhdGE7DQo+ICsJfQ0KPiAgDQo+ICAJYnAtPndvbCA9IDA7
DQo+ICAJaWYgKG9mX2dldF9wcm9wZXJ0eShucCwgIm1hZ2ljLXBhY2tldCIsIE5VTEwpKQ0KPiAN
Cg==
