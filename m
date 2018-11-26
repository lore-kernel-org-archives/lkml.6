Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C590BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588B720817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="hyJJhzOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588B720817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeK0BkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:40:25 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:9946 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbeK0BkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:40:25 -0500
X-IronPort-AV: E=Sophos;i="5.56,282,1539673200"; 
   d="scan'208";a="20789382"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Nov 2018 07:46:04 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 26 Nov 2018 07:46:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHfPcYSDg2mmxPtiZUnqpBBpSVsoE0m1C3Xz6PvnFx8=;
 b=hyJJhzOTDufh2N7adsSlEstpZjL/OIc5b0kTZp7S6MF4K8YhVcv4w327O7gyxGhQJi3MeTWct2JVUK8rlDRZk+TUgeiXyKXNgZj4uX70PW5Xuqj1pIfgTfZKYKZMSfYbXbZwfW0uGPM1xAI5pRiI0sslYmhNSe3+P9QqbHMdWKU=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0645.namprd11.prod.outlook.com (10.163.159.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Mon, 26 Nov 2018 14:46:01 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 14:46:01 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <harini.katakam@xilinx.com>, <Nicolas.Ferre@microchip.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harinik@xilinx.com>, <shubhrajyoti.datta@xilinx.com>,
        <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v2 1/4] net: macb: Check MDIO state before read/write and
 use timeouts
Thread-Topic: [PATCH v2 1/4] net: macb: Check MDIO state before read/write and
 use timeouts
Thread-Index: AQHUhZa7v3Zh+jBG9kSdXfX2qosMHA==
Date:   Mon, 26 Nov 2018 14:46:01 +0000
Message-ID: <5de882e3-65ac-7ff1-bb55-7537666dfc77@microchip.com>
References: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
 <1543216072-9623-2-git-send-email-harini.katakam@xilinx.com>
In-Reply-To: <1543216072-9623-2-git-send-email-harini.katakam@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0052.eurprd09.prod.outlook.com
 (2603:10a6:802:28::20) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0645;6:GNTqOFJmi7MP1n0vU4u7LI9/8pDCx7hd4jibVgQcbiDTwtLIr8HXorioGSKKKSkkh2gTr4nkpI2Zu5EzLnwdADjLwTP8smtAkYiPcdrLF3deNIs3BC47C5lzXkt29waO3gFlzuIIKBJeubWRlhX2dwSuAB309yoCXnf7/t5YRKHE7/1p6Jql3cCEyVuG12eqGJOHMnYEF/h7vj7cms12J9fkTYefFtlGugF3GOFP8gG7eBNghgQnTzY8uIx6JRuBe47cWQh5E/0NVbOObAePMc/o1z3CYXfDUBxMmui7vIuXE6ImoWCrqWZcYI+G9Mr6UBismom4Q8cJBmDKJcpPhfH3uFrgFJkWOXLOq3UGS1E+nE6LdgHH8QlxtQHQWp7z7kLle4Uzm4J3ofwLch1eZAiQ6glV+G73ltKsiq+CGfjIXepO1iL9FYTzNFJW42XIaPt1jKXHGn82YKz63AmcYw==;5:rScU1I/VD1iKj6W4z9EfCNg+NARTe21QHVKG3SDIn91/8mZQkZC2gcwJ5WSu3kCcCUk+kQbG+jVacOVBI8mdzBjP+tNf8XEYAgWRb/FBldPHtpTF8DWLCn2C0ENjI/xv2mVfH0UYAw1ysQ7ZI0NhZJE+ig9zhF+xAVkj5GFhg5E=;7:7ucqsOdKhsfP2KhIVMF8eEvkTLzz3MAPpxsALf5DMT4sGmSqh1GMEejcYEzlr5W2WKloD6+DelxutlaKLrBUuaL/8V/hcEd8nub5uIPpcLKTees/nDZg0HBVVSRhNiZX7CmrVQkN2pf6VaBUYE39IA==
x-ms-office365-filtering-correlation-id: 7b0ebc02-c2b9-45a7-f253-08d653ade258
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0645;
x-ms-traffictypediagnostic: BY2PR11MB0645:
x-microsoft-antispam-prvs: <BY2PR11MB06455C113DDC81B60D426EA887D70@BY2PR11MB0645.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231443)(944501410)(52105112)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0645;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0645;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(105586002)(106356001)(446003)(53546011)(11346002)(386003)(6506007)(102836004)(81166006)(476003)(71190400001)(71200400001)(81156014)(2616005)(68736007)(66066001)(316002)(8936002)(99286004)(54906003)(110136005)(2501003)(36756003)(31686004)(3846002)(76176011)(6116002)(52116002)(486006)(229853002)(5660300001)(6512007)(72206003)(2906002)(256004)(39060400002)(4326008)(478600001)(305945005)(6486002)(53936002)(6436002)(7736002)(6246003)(186003)(25786009)(31696002)(97736004)(26005)(14454004)(8676002)(86362001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0645;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0BJKM1aFsMdbdNVoslZyJVfGyH36U1EpEX0R0fYlLh8Kc97v/tZahSewGG0Iok7oPnfiCbkBPtsRIwLorvNt7jscUkXv64RvhtbzzxZDOGtHgKZvdGFh29lQwtG+0QSealiSR3EhJKnLXI4p29Pp6KAMynKRGz5872T2bb+U08xgnE76IzDZbrlY029+GfxqhVzkjImg/IxOyLp+/z0npPT0wKQDbczJ6lYtA+izs19nEx51aLizwjhp5JKmxFLhjvLJZLtXYEJ/qbqJJbxsKFE3PN6Qs3ywNFcKa6hDlj9Ri4tDzanHsKHBUKMykRZqXiWJ7NWdqMGllXmcWfNKe4/XQ7f3UKKye6kBNsvj9Gg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB5A04BE6929CF49935B3E98B7804440@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0ebc02-c2b9-45a7-f253-08d653ade258
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 14:46:01.6155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0645
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFyaW5pLA0KDQpPbiAyNi4xMS4yMDE4IDA5OjA3LCBIYXJpbmkgS2F0YWthbSB3cm90ZToN
Cj4gRnJvbTogSGFyaW5pIEthdGFrYW0gPGhhcmluaWtAeGlsaW54LmNvbT4NCj4gDQo+IFJlcGxh
Y2UgdGhlIHdoaWxlIGxvb3AgaW4gTURJTyByZWFkL3dyaXRlIGZ1bmN0aW9ucyB3aXRoIGEgdGlt
ZW91dC4NCj4gSW4gYWRkaXRpb24sIGFkZCBhIGNoZWNrIGZvciBNRElPIGJ1cyBidXN5IGJlZm9y
ZSBpbml0aWF0aW5nIGEgbmV3DQo+IG9wZXJhdGlvbiBhcyB3ZWxsIHRvIG1ha2Ugc3VyZSB0aGVy
ZSBpcyBubyBvbmdvaW5nIE1ESU8gb3BlcmF0aW9uLg0KDQpJcyB0aGlzIE1ESU8gYnVzIGJ1c3kg
Y2hlY2sgbmVjZXNzYXJ5PyBUaGUgY2FsbGVyIG9mDQptYWNiX21kaW9fcmVhZC9tYWNiX21kaW9f
d3JpdGUgbG9ja3MgdGhlIG1kaW8gYnVzIG11dGV4IGJlZm9yZSBjYWxsaW5nIGl0DQooZS5nLiBt
ZGlvYnVzX3JlYWQpLg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaHViaHJhanlvdGkgRGF0dGEg
PHNodWJocmFqeW90aS5kYXR0YUB4aWxpbnguY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTYWkgUGF2
YW4gQm9kZHUgPHNhaS5wYXZhbi5ib2RkdUB4aWxpbnguY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBI
YXJpbmkgS2F0YWthbSA8aGFyaW5pa0B4aWxpbnguY29tPg0KPiAtLS0NCj4gdjIgY2hhbmdlczoN
Cj4gVXNlIHJlYWR4X3BvbGxfdGltZW91dA0KPiANCj4gQ2hhbmdlcyBmb3JtIFJGQzoNCj4gQ2xl
YW5lZCB1cCB0aW1lb3V0IGltcGxlbWVudGF0aW9uIGFuZCBtb3ZlZCBpdCB0byBhIGhlbHBlci4N
Cj4gDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2IuaCAgICAgIHwgIDMgKysr
DQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jIHwgMzMgKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9jYWRlbmNlL21hY2IuaCBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVuY2UvbWFj
Yi5oDQo+IGluZGV4IDNkNDVmNGMuLmRmN2JlZTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0
L2V0aGVybmV0L2NhZGVuY2UvbWFjYi5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Nh
ZGVuY2UvbWFjYi5oDQo+IEBAIC03MTQsNiArNzE0LDkgQEANCj4gIAkJX192OyBcDQo+ICAJfSkN
Cj4gIA0KPiArI2RlZmluZSBNQUNCX0lETEVfTUFTSwkJKDEgPDwgTUFDQl9JRExFX09GRlNFVCkN
Cg0KWW91IGNvdWxkIHVzZSBNQUNCX0JJVChJRExFKSBpbnN0ZWFkLg0KDQo+ICsjZGVmaW5lIE1B
Q0JfUkVBRF9OU1IoYnApCW1hY2JfcmVhZGwoYnAsIE5TUikNCg0KSXMgdGhpcyBuZWNlc3Nhcnk/
DQoNCg0KPiArDQo+ICAvKiBzdHJ1Y3QgbWFjYl9kbWFfZGVzYyAtIEhhcmR3YXJlIERNQSBkZXNj
cmlwdG9yDQo+ICAgKiBAYWRkcjogRE1BIGFkZHJlc3Mgb2YgZGF0YSBidWZmZXINCj4gICAqIEBj
dHJsOiBDb250cm9sIGFuZCBzdGF0dXMgYml0cw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvY2FkZW5jZS9tYWNiX21haW4uYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2NhZGVu
Y2UvbWFjYl9tYWluLmMNCj4gaW5kZXggMWQ4NmI0ZC4uZmQ4NmVjZSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvY2FkZW5jZS9tYWNiX21haW4uYw0KPiArKysgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9jYWRlbmNlL21hY2JfbWFpbi5jDQo+IEBAIC0zNiw2ICszNiw3IEBADQo+
ICAjaW5jbHVkZSA8bGludXgvaXAuaD4NCj4gICNpbmNsdWRlIDxsaW51eC91ZHAuaD4NCj4gICNp
bmNsdWRlIDxsaW51eC90Y3AuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCj4gICNp
bmNsdWRlICJtYWNiLmgiDQo+ICANCj4gICNkZWZpbmUgTUFDQl9SWF9CVUZGRVJfU0laRQkxMjgN
Cj4gQEAgLTc5LDYgKzgwLDggQEANCj4gICAqLw0KPiAgI2RlZmluZSBNQUNCX0hBTFRfVElNRU9V
VAkxMjMwDQo+ICANCj4gKyNkZWZpbmUgTUFDQl9NRElPX1RJTUVPVVQJMTAwMDAwMCAvKiBpbiB1
c2VjcyAqLw0KPiArDQo+ICAvKiBETUEgYnVmZmVyIGRlc2NyaXB0b3IgbWlnaHQgYmUgZGlmZmVy
ZW50IHNpemUNCj4gICAqIGRlcGVuZHMgb24gaGFyZHdhcmUgY29uZmlndXJhdGlvbjoNCj4gICAq
DQo+IEBAIC0zMTgsMTAgKzMyMSwyMyBAQCBzdGF0aWMgdm9pZCBtYWNiX2dldF9od2FkZHIoc3Ry
dWN0IG1hY2IgKmJwKQ0KPiAgCWV0aF9od19hZGRyX3JhbmRvbShicC0+ZGV2KTsNCj4gIH0NCj4g
IA0KPiArc3RhdGljIGludCBtYWNiX21kaW9fd2FpdF9mb3JfaWRsZShzdHJ1Y3QgbWFjYiAqYnAp
DQo+ICt7DQo+ICsJdTMyIHZhbDsNCj4gKw0KPiArCXJldHVybiByZWFkeF9wb2xsX3RpbWVvdXQo
TUFDQl9SRUFEX05TUiwgYnAsIHZhbCwgdmFsICYgTUFDQl9JRExFX01BU0ssDQo+ICsJCQkJICAx
LCBNQUNCX01ESU9fVElNRU9VVCk7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgbWFjYl9tZGlv
X3JlYWQoc3RydWN0IG1paV9idXMgKmJ1cywgaW50IG1paV9pZCwgaW50IHJlZ251bSkNCj4gIHsN
Cj4gIAlzdHJ1Y3QgbWFjYiAqYnAgPSBidXMtPnByaXY7DQo+ICAJaW50IHZhbHVlOw0KPiArCWlu
dCBlcnI7DQo+ICsNCj4gKwllcnIgPSBtYWNiX21kaW9fd2FpdF9mb3JfaWRsZShicCk7DQo+ICsJ
aWYgKGVyciA8IDApDQo+ICsJCXJldHVybiBlcnI7DQo+ICANCj4gIAltYWNiX3dyaXRlbChicCwg
TUFOLCAoTUFDQl9CRihTT0YsIE1BQ0JfTUFOX1NPRikNCj4gIAkJCSAgICAgIHwgTUFDQl9CRihS
VywgTUFDQl9NQU5fUkVBRCkNCj4gQEAgLTMyOSw5ICszNDUsOSBAQCBzdGF0aWMgaW50IG1hY2Jf
bWRpb19yZWFkKHN0cnVjdCBtaWlfYnVzICpidXMsIGludCBtaWlfaWQsIGludCByZWdudW0pDQo+
ICAJCQkgICAgICB8IE1BQ0JfQkYoUkVHQSwgcmVnbnVtKQ0KPiAgCQkJICAgICAgfCBNQUNCX0JG
KENPREUsIE1BQ0JfTUFOX0NPREUpKSk7DQo+ICANCj4gLQkvKiB3YWl0IGZvciBlbmQgb2YgdHJh
bnNmZXIgKi8NCj4gLQl3aGlsZSAoIU1BQ0JfQkZFWFQoSURMRSwgbWFjYl9yZWFkbChicCwgTlNS
KSkpDQo+IC0JCWNwdV9yZWxheCgpOw0KPiArCWVyciA9IG1hY2JfbWRpb193YWl0X2Zvcl9pZGxl
KGJwKTsNCj4gKwlpZiAoZXJyIDwgMCkNCj4gKwkJcmV0dXJuIGVycjsNCj4gIA0KPiAgCXZhbHVl
ID0gTUFDQl9CRkVYVChEQVRBLCBtYWNiX3JlYWRsKGJwLCBNQU4pKTsNCj4gIA0KPiBAQCAtMzQy
LDYgKzM1OCwxMSBAQCBzdGF0aWMgaW50IG1hY2JfbWRpb193cml0ZShzdHJ1Y3QgbWlpX2J1cyAq
YnVzLCBpbnQgbWlpX2lkLCBpbnQgcmVnbnVtLA0KPiAgCQkJICAgdTE2IHZhbHVlKQ0KPiAgew0K
PiAgCXN0cnVjdCBtYWNiICpicCA9IGJ1cy0+cHJpdjsNCj4gKwlpbnQgZXJyOw0KPiArDQo+ICsJ
ZXJyID0gbWFjYl9tZGlvX3dhaXRfZm9yX2lkbGUoYnApOw0KPiArCWlmIChlcnIgPCAwKQ0KPiAr
CQlyZXR1cm4gZXJyOw0KPiAgDQo+ICAJbWFjYl93cml0ZWwoYnAsIE1BTiwgKE1BQ0JfQkYoU09G
LCBNQUNCX01BTl9TT0YpDQo+ICAJCQkgICAgICB8IE1BQ0JfQkYoUlcsIE1BQ0JfTUFOX1dSSVRF
KQ0KPiBAQCAtMzUwLDkgKzM3MSw5IEBAIHN0YXRpYyBpbnQgbWFjYl9tZGlvX3dyaXRlKHN0cnVj
dCBtaWlfYnVzICpidXMsIGludCBtaWlfaWQsIGludCByZWdudW0sDQo+ICAJCQkgICAgICB8IE1B
Q0JfQkYoQ09ERSwgTUFDQl9NQU5fQ09ERSkNCj4gIAkJCSAgICAgIHwgTUFDQl9CRihEQVRBLCB2
YWx1ZSkpKTsNCj4gIA0KPiAtCS8qIHdhaXQgZm9yIGVuZCBvZiB0cmFuc2ZlciAqLw0KPiAtCXdo
aWxlICghTUFDQl9CRkVYVChJRExFLCBtYWNiX3JlYWRsKGJwLCBOU1IpKSkNCj4gLQkJY3B1X3Jl
bGF4KCk7DQo+ICsJZXJyID0gbWFjYl9tZGlvX3dhaXRfZm9yX2lkbGUoYnApOw0KPiArCWlmIChl
cnIgPCAwKQ0KPiArCQlyZXR1cm4gZXJyOw0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IA0K
