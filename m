Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D780BECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8341120856
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QuEkQyf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8341120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeGPGkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:40:25 -0400
Received: from mail-eopbgr20088.outbound.protection.outlook.com ([40.107.2.88]:2291
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727214AbeGPGkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aU50FEspaQlurFQ9OThHtBRNfOSSSkY4NeOiQkrdmy4=;
 b=QuEkQyf3wEq7Ul8a/n5fwvU4oO49TSA3qPeUHBwraYSkgQynBu8BjQlqoFKgW0JD1sgcs81YqhKpy4oUEtJhAx6niAfP00Rxm9OwecsVnuCrl6PDEPlpa9314djSGR/Vj8IRgmU9YOlfS0Sq+XM+2OFpDHinn1mlgTyvRAfyflE=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB1412.eurprd04.prod.outlook.com (10.163.185.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.20; Mon, 16 Jul 2018 06:14:33 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%7]) with mapi id 15.20.0952.021; Mon, 16 Jul 2018
 06:14:33 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] gpio: mxc: add power management support
Thread-Topic: [PATCH] gpio: mxc: add power management support
Thread-Index: AQHUGCMO6gaWWTJtjkmf4RNIPMA6nKSNf7wAgAB6AnCAAPEPAIACfIig
Date:   Mon, 16 Jul 2018 06:14:33 +0000
Message-ID: <AM3PR04MB13153EB5ADEBCD57A7122B61F55D0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1531208921-23342-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BSt4jdLWmXjNmTDAegGwtRWjbMuVAwdrnRyHWvSBuU5A@mail.gmail.com>
 <AM3PR04MB131577674FDF0BC65BEF518EF55F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5DCsdwXK0eftcpwzT4my30HZLR7-H2c+V=ro+_fOMAWCw@mail.gmail.com>
In-Reply-To: <CAOMZO5DCsdwXK0eftcpwzT4my30HZLR7-H2c+V=ro+_fOMAWCw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1412;7:C/oWl3GfaCHxwJUkbkr5J8OjI6mlhnjrg+3Dy7wQDgJd/LCMEMsVuey/as1E3QiBXE170RArIYBCO9ZUk+Rx3waeqzFL318YmkmjSve2VNj1KDtNlI27qIMG7iyIX/LW6jYf7DugLecQlGBf1Kd3Re5nxVhjhMWYo04ceY9H9lImclBhtdKjH+T8T5m1bCu//sruNR3blY7Iei8E4MLDUufPpPWN5w2D5xVUL7B4ajnEYZY3uaAtqyCkywkn2kbr
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f4dde05-a6d0-4f54-74fb-08d5eae3663e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1412;
x-ms-traffictypediagnostic: AM3PR04MB1412:
x-microsoft-antispam-prvs: <AM3PR04MB1412FC610B1A733773638BE6F55D0@AM3PR04MB1412.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1412;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1412;
x-forefront-prvs: 073515755F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(366004)(13464003)(199004)(189003)(6116002)(86362001)(25786009)(478600001)(26005)(3846002)(5250100002)(66066001)(7736002)(102836004)(8936002)(1411001)(68736007)(8676002)(97736004)(14444005)(54906003)(81166006)(106356001)(186003)(6916009)(93886005)(105586002)(256004)(81156014)(229853002)(5660300001)(305945005)(44832011)(99286004)(76176011)(486006)(4326008)(9686003)(316002)(33656002)(6436002)(14454004)(476003)(7696005)(6246003)(11346002)(39060400002)(55016002)(53936002)(6506007)(74316002)(53546011)(2900100001)(2906002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1412;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +WMPnb/GuFwYApshsdUfuCUFkfmcqiR6GmLSAlqiOfCJqbJR+Tvnd/yrZ6HaOXNSb8iE92zFiG7nz8M50m37Cy+Xft9cnCC8c3gwq8FbrQ8M6EwmwyXC7sECjZ5lkQtZWOOTLvmLF0IhWhFHu3y57KFUYbA33A+iTxvnhr9ymhgVOfdNYBuQ5ArIvP5w/NC2vHj2WgApOJkS9kP4lwULwvfN1Hr/BfR6EcDq5ezIuU3w5TYoxcEgV3E4oW1UuuWS9xGOXnJDxjvReR7xobuj99aM6D21JhsL8IYwY29iqd1SrIdiBJDKkRNz0WlRM0x65gHvzISbnDUdew7MXFdJdKyxYXg63cWm2ZAYgUge+Ds=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4dde05-a6d0-4f54-74fb-08d5eae3663e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2018 06:14:33.5807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1412
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCkFuc29uIEh1YW5nDQpCZXN0IFJlZ2FyZHMhDQoNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWlsdG86ZmVzdGV2YW1A
Z21haWwuY29tXQ0KPiBTZW50OiBTdW5kYXksIEp1bHkgMTUsIDIwMTggMTI6MTMgQU0NCj4gVG86
IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzogTGludXMgV2FsbGVpaiA8
bGludXMud2FsbGVpakBsaW5hcm8ub3JnPjsgb3BlbiBsaXN0OkdQSU8gU1VCU1lTVEVNDQo+IDxs
aW51eC1ncGlvQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbCA8bGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZz47DQo+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGdwaW86IG14YzogYWRkIHBvd2VyIG1hbmFnZW1lbnQgc3VwcG9y
dA0KPiANCj4gSGkgQW5zb24sDQo+IA0KPiBPbiBGcmksIEp1bCAxMywgMjAxOCBhdCAxMDo1MyBQ
TSwgQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IHdyb3RlOg0KPiANCj4gPiBI
ZXJlIGFyZSB0aGUgZGV0YWlscywgaS5NWDdEIExQU1IgbW9kZSBhbmQgaS5NWDhRTS84UVhQIGV0
Yy4nDQo+ID4gc3VzcGVuZC9yZXN1bWUgbWF5IGNhdXNlIEdQSU8gYmFuayBsb3NlIHBvd2VyLCBz
byBuZWVkIHRvDQo+ID4gc2F2ZS9yZXN0b3JlLCBmb3Igb3RoZXIgaS5NWCBTb0NzLCBhbHRob3Vn
aCBubyBuZWVkIHRvIGRvDQo+ID4gc2F2ZS9yZXN0b3JlLCBidXQgZG9pbmcgaXQgaXMgTk9UIGhh
cm1mdWwsIHNvIGRvIHlvdSB0aGluayB3ZSBzaG91bGQgYWRkIFNvQw0KPiB0eXBlIGNoZWNrIGhl
cmU/DQo+IA0KPiBJIHRoaW5rIGl0IHdvdWxkIGJlIHNhZmVyIHRvIHJlc3RyaWN0IHRoZSBzYXZl
L3Jlc3RvcmUgb3BlcmF0aW9ucyB0byBteDcvbXg4Lg0KPiANCj4gWW91IGNhbiBhZGQgYSBmc2ws
aW14N2QtZ3BpbyBjb21wYXRpYmxlIGVudHJ5IGluIHRoZSBkcml2ZXIuDQo+IA0KPiBUaGFua3MN
Ck9LLCBzaW5jZSBpLk1YN0QgaGFzIHNhbWUgR1BJTyB0eXBlIGFzIGkuTVgzNSwgdG8gbWFrZSBp
dCBzaW1wbGUsIEkganVzdCBhZGRlZA0KYSBmbGFnIHRvIGluZGljYXRlIHdoZXRoZXIgaXQgc3Vw
cG9ydHMgc2F2ZS9yZXN0b3JlLCBvbmx5IGkuTVg3RCBlbmFibGVzDQp0aGUgZmxhZyBub3csIHNp
bmNlIG90aGVyIGkuTVg4IFNvQ3MnIGR0cyBpcyBOT1QgdXBzdHJlYW1lZCB5ZXQsIHNvIEkgZGlk
IE5PVCBhZGQNCnN1cHBvcnQgZm9yIGkuTVg4IFNvQ3MsIHBsZWFzZSBoZWxwIHJldmlldyBWMiBw
YXRjaCwgdGhhbmtzLg0KDQpBbnNvbi4gDQoNCg0K
