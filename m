Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1486C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748ED206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 01:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jCOLnCM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748ED206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389148AbeKVMQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:16:23 -0500
Received: from mail-eopbgr40063.outbound.protection.outlook.com ([40.107.4.63]:36124
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727253AbeKVMQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbieawrY45ThYcjyRNTJawnTFauyqGfm23Xjgh1hzXc=;
 b=jCOLnCM9ywqOQmbZ4/mN994tiX9MlpBkLrI0jcUpzgRS9OeO3xJsO7eO/SUNqGQUZk0VLSScdlP4/f3Q+8f5woQNO4FDgC8vC/CpYwSarkk49Gy33SL2unOsgBV4ESK9Sv8ccepX2XFk93qzKmtPt00r6FvDJtjeeLozGRgPGMo=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4731.eurprd04.prod.outlook.com (20.176.233.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Thu, 22 Nov 2018 01:39:20 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b%3]) with mapi id 15.20.1339.029; Thu, 22 Nov 2018
 01:39:20 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng DONG <aisheng.dong@nxp.com>
Subject: RE: [PATCH] can: flexcan: Implement CAN Runtime PM
Thread-Topic: [PATCH] can: flexcan: Implement CAN Runtime PM
Thread-Index: AQHUZ5CBGViPzGvSBkmCEccitD7z+6VagACAgAC2uCA=
Date:   Thu, 22 Nov 2018 01:39:20 +0000
Message-ID: <DB7PR04MB461837E511EEF64497EB4A83E6DB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20181019094326.28185-1-qiangqing.zhang@nxp.com>
 <24a43a20-7302-c449-06b3-5ee8f6c051a0@pengutronix.de>
In-Reply-To: <24a43a20-7302-c449-06b3-5ee8f6c051a0@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4731;6:hj+b+pMYRTQj75Sh7XexhAhGpMHsee1GM9YFxI2ilMCTN7D34BDFHEHePXC3un4naU6sQFEiAYC5mUW9DIc82C8jJxU+tPpoE2pzLbzrFDqU+pyAE3T4iqWvYYgF3QuwXXATpWeg7NPlVn115ZZhDmiNljQxWpLNSbbTw4mRlhnXUareC5PSfAYux3Qs9OXwqARMA5DgjVy44vW46cvrFBEJCQ2qDQSpvTVmQACBuWXBy+hSi0cSJaDqSJkzeN1VsohH3eVbVfOsIzj/uKcPd+lh8eu5SR474IHq7OTP2Wq/QKV7Hd0N8RKEX7bTgzrhsvzNCs3FA6iAON0LqZfLR6uuxdMqNNhiibImY8D8jIg4ysjdD51iQotOUJPYvl0Hd+xYkO1y63JJrCRb6HK/Na2fJtFrQqJIFF/uJgxc0TlORYD6jq1snKwAjzyTNQ1ReVtgsOUUZ2Fgk7E4YSK55w==;5:4zvLvyuLrOS2mbAqqCQvw7oWmxQ0eQofnUE5zFX493Gylq38Bvqa46Gf5jlkNlIFv/dsoDvZiAAVMy2O2iypZptQH6HuLoONhoEXWWrRszxna+BY04dNnrTovTDpyshEslo64VlCI2ol4hJrAV/BNVW+/2HkiIRiU7Upg9QXHwQ=;7:nFxye6SLSyGjpeI0hbUT9yKpIHnCuF+d+kl8GNIuXB65cXf+UfwOTrjlzWZmwoWRvUQrzOqvllkVB4yYQWvwmkk8kVEmuBPpYTZMiDenX1XGRSuzsh6vIo629lsvzZff9jGl0MNL3aW7J0xwoRRazw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1e2f5553-11cd-4799-e427-08d6501b5300
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4731;
x-ms-traffictypediagnostic: DB7PR04MB4731:
x-microsoft-antispam-prvs: <DB7PR04MB4731E083FEBB9765151BAA24E6DB0@DB7PR04MB4731.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231442)(944501410)(4982022)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4731;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4731;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(136003)(346002)(13464003)(199004)(189003)(23433003)(9686003)(6116002)(5660300001)(8936002)(3846002)(305945005)(6306002)(53386004)(6246003)(53936002)(26005)(4326008)(316002)(74316002)(86362001)(11346002)(446003)(2906002)(14454004)(2201001)(229853002)(7736002)(6436002)(54906003)(476003)(81166006)(486006)(81156014)(110136005)(8676002)(66066001)(97736004)(2501003)(71190400001)(33656002)(25786009)(14444005)(76176011)(99286004)(7696005)(71200400001)(966005)(478600001)(55016002)(105586002)(186003)(256004)(53546011)(68736007)(102836004)(6506007)(106356001)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4731;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vG2U9d17qBExUjY9C7VDEOkGZiQNss8hu6ApP09PmU0muINWaTbm69mM4Uh199L87qQKTt0ZH4d+xNrv42hlcJocqXHaQpmkA8Un+YBW7AnHQHltZePcdTsrxS8S8sddxOklI7MzJ9N5YIcJh3DVgrScO7orNMWS7BSi35YyGegy8Ab85hM0aBVdxPCQw//JavzGuXp6PCxRl6834sM1zAjb8ox/ZLm1HovgAi6pkFSKPg6mM6hzmNzUILkFAXW/gm9La+QaSRyuc5dMnIery+ie8CtJMEWh8XKOCD0pc/S7F+AFdKsc03BXzipKSnbTPFcJEm794dMN8710AkmhOCbB7b8VCjK18O48wLZ5S94=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2f5553-11cd-4799-e427-08d6501b5300
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 01:39:20.5160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4731
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYywNCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBLbGVpbmUtQnVkZGUgPG1rbEBwZW5ndXRyb25p
eC5kZT4NCj4gU2VudDogMjAxOOW5tDEx5pyIMjHml6UgMjI6MzYNCj4gVG86IEpvYWtpbSBaaGFu
ZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+OyB3Z0BncmFuZGVnZ2VyLmNvbTsNCj4gZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldA0KPiBDYzogbGludXgtY2FuQHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgt
aW14IDxsaW51eC1pbXhAbnhwLmNvbT47IEFpc2hlbmcNCj4gRE9ORyA8YWlzaGVuZy5kb25nQG54
cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGNhbjogZmxleGNhbjogSW1wbGVtZW50IENB
TiBSdW50aW1lIFBNDQo+IA0KPiBPbiAxMC8xOS8xOCAxMTo0NSBBTSwgSm9ha2ltIFpoYW5nIHdy
b3RlOg0KPiA+IEZyb206IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQo+ID4N
Cj4gPiBGbGV4Y2FuIHdpbGwgYmUgZGlzYWJsZWQgZHVyaW5nIHN1c3BlbmQgaWYgbm8gd2FrZXVw
IGZ1bmN0aW9uIHJlcXVpcmVkDQo+ID4gYW5kIGVuYWJsZWQgYWZ0ZXIgcmVzdW1lIGFjY29yZGlu
Z2x5LiBEdXJpbmcgdGhpcyBwZXJpb2QsIHdlIGNvdWxkDQo+ID4gZXhwbGljaXRseSBkaXNhYmxl
IGNsb2Nrcy4NCj4gPg0KPiA+IEltcGxlbWVudCBSdW50aW1lIFBNIHdoaWNoIHdpbGw6DQo+ID4g
MSkgS2VlcCBkZXZpY2UgaW4gc3VzcGVuZCBzdGF0ZSAoY2xvY2tzIGRpc2FibGVkKSBpZiBpdCdz
IG5vdCBvcGVubmVkDQo+ID4gMikgTWFrZSBQb3dlciBEb21haW4gZnJhbWV3b3JrIGJlIGFibGUg
dG8gc2h1dGRvd24gdGhlIGNvcnJlc3BvbmRpbmcNCj4gPiBwb3dlciBkb21haW4gb2YgdGhpcyBk
ZXZpY2UuDQo+IA0KPiBXaXRob3V0IENPTkZJR19QTSB0aGUgZGV2aWNlIGZhaWxzIHRvIHByb2Jl
Og0KPiANCj4gPiBbICAyMTQuNDIwNjA2XSBmbGV4Y2FuIDIwOTAwMDAuZmxleGNhbjogMjA5MDAw
MC5mbGV4Y2FuIHN1cHBseSB4Y2VpdmVyDQo+ID4gbm90IGZvdW5kLCB1c2luZyBkdW1teSByZWd1
bGF0b3IgWyAgMjE0LjQ0NTk1Ml0gZmxleGNhbg0KPiA+IDIwOTAwMDAuZmxleGNhbjogTGlua2Vk
IGFzIGEgY29uc3VtZXIgdG8gcmVndWxhdG9yLjAgWyAgMjE0LjQ1MzQ0OF0NCj4gPiBmbGV4Y2Fu
IDIwOTAwMDAuZmxleGNhbjogcmVnaXN0ZXJpbmcgbmV0ZGV2IGZhaWxlZCBbICAyMTQuNDU5NjY2
XQ0KPiA+IGZsZXhjYW4gMjA5MDAwMC5mbGV4Y2FuOiBEcm9wcGluZyB0aGUgbGluayB0byByZWd1
bGF0b3IuMCBbDQo+ID4gMjE0LjQ3MjA2Nl0gZmxleGNhbjogcHJvYmUgb2YgMjA5MDAwMC5mbGV4
Y2FuIGZhaWxlZCB3aXRoIGVycm9yIC0xMTANCg0KSSB3aWxsIGZpcnN0bHkgc2VuZCB0aGUgcGF0
Y2ggdG8gZG8gRmxleENBTiB3YWtldXAgdXBzdHJlYW0sIHlvdSBjb3VsZCByZXZpZXcgdGhlIHBh
dGNoICJjYW46IGZsZXhjYW46IGFkZCBzZWxmIHdha2V1cCBzdXBwb3J0IiB3aGVuIHlvdSBhcmUg
ZnJlZS4NCkFmdGVyIHlvdSBoYXZlIHJldmlld2VkLCB0aGVuIEkgd2lsbCBzZW5kIHBhdGNoIHRv
IGRvIEZsZXhDQU4gcnVudGltZSBQTSB1cHN0cmVhbS4gSXQgd2lsbCBiZSBjb252ZW5pZW50IGZv
ciB5b3UgdG8gcmV2aWV3IHRoZSBwYXRjaC4NCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIHJldmll
dy4NCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQoNCj4gTWFyYw0KPiANCj4gLS0NCj4g
UGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUgICAg
ICAgICAgIHwNCj4gSW5kdXN0cmlhbCBMaW51eCBTb2x1dGlvbnMgICAgICAgIHwgUGhvbmU6ICs0
OS0yMzEtMjgyNi05MjQgICAgIHwNCj4gVmVydHJldHVuZyBXZXN0L0RvcnRtdW5kICAgICAgICAg
IHwgRmF4OiAgICs0OS01MTIxLTIwNjkxNy01NTU1IHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVp
bSwgSFJBIDI2ODYgIHwgaHR0cDovL3d3dy5wZW5ndXRyb25peC5kZSAgIHwNCg0K
