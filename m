Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5000C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1792173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eK+prdBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1792173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeI1M7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 08:59:39 -0400
Received: from mail-eopbgr30048.outbound.protection.outlook.com ([40.107.3.48]:21120
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbeI1M7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 08:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1393YzUFhoBCJl7xEEUAaMAmkaB7WSKQRZNo0UUCG+0=;
 b=eK+prdBGII4EC/WG2OyDWRD/Xs1jysfclT3IMJws6o9Jq0gciLwtDiax7Zy35i/oUaukSSy8kRyVseiNYtrOjOmiM1M55rDNZb4Nf4vd0xjscdIuIbDAyIOYOfDPqgFQMMBqzkpbN0Onq+gYsNoHcG0x1hyPN5dDbuTBr600sR4=
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com (52.135.167.33) by
 AM6PR04MB4455.eurprd04.prod.outlook.com (20.176.242.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.19; Fri, 28 Sep 2018 06:37:24 +0000
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::e955:4d48:f0eb:3fe]) by AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::e955:4d48:f0eb:3fe%2]) with mapi id 15.20.1143.022; Fri, 28 Sep 2018
 06:37:24 +0000
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>
Subject: RE: [PATCH 2/2] spi: spi-fsl-dspi: Fix support for XSPI transport
 mode
Thread-Topic: [PATCH 2/2] spi: spi-fsl-dspi: Fix support for XSPI transport
 mode
Thread-Index: AQHUUXmWfWxjYgYDCEmBQwAxJp+eHaUFSG3g
Date:   Fri, 28 Sep 2018 06:37:24 +0000
Message-ID: <AM6PR04MB43576D8B41B1878B0DBCD35797EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
 <20180921070628.35153-2-chuanhua.han@nxp.com>
In-Reply-To: <20180921070628.35153-2-chuanhua.han@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chuanhua.han@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4455;6:PUsV1VHTJBIKHb8zTtTq/YhbC0dhqiCO2fdJJRVs8zi+GYj+kgqEzLiGe/vgz9xmXq68Pp7Ri/IxJDFhm6dxp3Cgsr5Z+0XnY+1NRxk414JQHx3knVYZVKWGVEA3XN+y67wk7sw/ayQPg+YDYfMKGOK53ctUZq/U1zTMSxga4jQk/1Q/xzT/B/DpKp9VvGJ5DyshVtdqRbex8ognY6Havy9PQfEWVTk1GR4ndo+tP6x5RE1ypq2LrEPWXFv9uYHvsHNTUdieNODE8cZfpH0qRGiL8gCnTDASOBQN2zy/p8bajlSkF8sFuNrY30kHxfX+ki0MYqwYO7IzRqgM8xvUfluCg3unzytkd+g8QEhFUKSGJMU2n7+26SkcjE1TXCzC9jJQi8EopQ+7g3jpVjYa18Ch743WjboXdl34jRnHbfdydr3NQJrw0x5Sl9tVZihA86XJWuPF+aFaclv1BjkBig==;5:bNekjIsSiTgunwQ2HAe7qs82fXGf8ktCfaF3woQnALobQ7ZMmJBBT2Y5eQBBuRXvAQRz+JqvDDqkVC+xCw9gv2E6AaHLPVjyesq8wMrCqSEH2ndfh681ujP9ufKOBtSeBUiUpQ63giLh3PWJGUa21zJiA5i3RR+wuhrvFySkW2Y=;7:dqEsk+4T1gJCgT8qJzI6dBF4rCaxX8eqYjAwO0xHMfsreQ3VrJ2wSJVB7LxUk92tw3rQmKpBe4pOqqhZEeViDHc1D77lWcq6IEziD0WzyBOXXjx2MOXNMc2h4raW1D4dfotD1jr5DwboUMPk8sjLaPoAEDz041AU0FDHEUh84dHSrevDvT2C6N+Po61+rKGu5EwaS5yfXloYEcu9pLVzmJ3jS18u7F2/r6uHErOvXqTCPmSpOtKoic4f1kNsJSyZ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e0dbe99b-b2ce-4d40-b2f4-08d6250cd9d2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4455;
x-ms-traffictypediagnostic: AM6PR04MB4455:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR04MB4455DD0D244CADB849D02DF897EC0@AM6PR04MB4455.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM6PR04MB4455;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4455;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(39860400002)(396003)(189003)(53474002)(199004)(13464003)(54906003)(6506007)(105586002)(76176011)(5660300001)(97736004)(53546011)(4326008)(25786009)(2900100001)(478600001)(86362001)(110136005)(5250100002)(229853002)(106356001)(14444005)(33656002)(8676002)(2501003)(486006)(256004)(44832011)(55016002)(446003)(9686003)(11346002)(34290500001)(7736002)(8936002)(81166006)(81156014)(305945005)(14454004)(74316002)(3846002)(66066001)(6116002)(476003)(7696005)(6246003)(71200400001)(6436002)(71190400001)(99286004)(26005)(316002)(53936002)(68736007)(102836004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4455;H:AM6PR04MB4357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PAFNJO9plX0ew54vvVZTwfZo3QubthTKUAgRye+dOFa6ucU0/q2zsrw96IHE67pcZBonV6nRWM6FJvWxDVx4rHwUbpERFm6k1o6dZluIWnDYLsI/2AHNcNsWEVg0+mnZqth93xy5baxxhqjzEkgLk+YJ4hJx2XL/IQhGwmrSMswVKwIFiwel4zg92YKSQkyffJ2TJRGYoxqyrx5KOrHD1DXH/xx4ZzC9fcI4QAyXB+JnYwCy2Q3hBPiaKyzE/F5y/gMiEK6lnR3OZqG93SG1F0cJy+/sQNLErbAZKcXUKkt+iktqSdGX3P6y9N/J3hkTQ2YnTEpAP4KJiz+VK0hYmBggg18kpQcLkDru9ogH5CM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0dbe99b-b2ce-4d40-b2f4-08d6250cd9d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 06:37:24.2812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2h1YW5odWEgSGFuIDxj
aHVhbmh1YS5oYW5AbnhwLmNvbT4NCj4gU2VudDogMjAxOMTqOdTCMjHI1SAxNTowNg0KPiBUbzog
YnJvb25pZUBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBlaGFAZGVpZi5jb207DQo+IGJvcmlzLmJyZXppbGxv
bkBib290bGluLmNvbTsgQ2h1YW5odWEgSGFuIDxjaHVhbmh1YS5oYW5AbnhwLmNvbT4NCj4gU3Vi
amVjdDogW1BBVENIIDIvMl0gc3BpOiBzcGktZnNsLWRzcGk6IEZpeCBzdXBwb3J0IGZvciBYU1BJ
IHRyYW5zcG9ydCBtb2RlDQo+IA0KPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBwcm9ibGVtIHRoYXQg
dGhlIFhTUEkgbW9kZSBvZiB0aGUgZHNwaSBjb250cm9sbGVyIGNhbm5vdA0KPiB0cmFuc2ZlciBk
YXRhIHByb3Blcmx5Lg0KPiBJbiBYU1BJIG1vZGUsIGNtZF9maWZvIGlzIHdyaXR0ZW4gYmVmb3Jl
IHR4X2ZpZm8sIHdoaWNoIHRyYW5zZm9ybXMgdGhlIGJ5dGUNCj4gb3JkZXIgb2Ygc2VuZGluZyBh
bmQgcmVjZWl2aW5nIGRhdGEuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHVhbmh1YSBIYW4gPGNo
dWFuaHVhLmhhbkBueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc3BpL3NwaS1mc2wtZHNwaS5j
IHwgMjkgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
OSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3NwaS9zcGktZnNsLWRzcGkuYyBiL2RyaXZlcnMvc3BpL3NwaS1mc2wtZHNwaS5jIGluZGV4
DQo+IDMwODJlNzJlNGY2Yy4uNDRjYzJiZDAxMjBlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Nw
aS9zcGktZnNsLWRzcGkuYw0KPiArKysgYi9kcml2ZXJzL3NwaS9zcGktZnNsLWRzcGkuYw0KPiBA
QCAtMjIwLDkgKzIyMCwxNSBAQCBzdGF0aWMgdTMyIGRzcGlfcG9wX3R4KHN0cnVjdCBmc2xfZHNw
aSAqZHNwaSkNCj4gIAkJaWYgKGRzcGktPmJ5dGVzX3Blcl93b3JkID09IDEpDQo+ICAJCQl0eGRh
dGEgPSAqKHU4ICopZHNwaS0+dHg7DQo+ICAJCWVsc2UgaWYgKGRzcGktPmJ5dGVzX3Blcl93b3Jk
ID09IDIpDQo+IC0JCQl0eGRhdGEgPSAqKHUxNiAqKWRzcGktPnR4Ow0KPiArCQkJaWYgKGRzcGkt
PmN1cl9jaGlwLT5jdGFyX3ZhbCAmIFNQSV9DVEFSX0xTQkZFKDEpKQ0KPiArCQkJCXR4ZGF0YSA9
ICBjcHVfdG9fbGUxNigqKHUxNiAqKWRzcGktPnR4KTsNCj4gKwkJCWVsc2UNCj4gKwkJCQl0eGRh
dGEgPSAgY3B1X3RvX2JlMTYoKih1MTYgKilkc3BpLT50eCk7DQo+ICAJCWVsc2UgIC8qIGRzcGkt
PmJ5dGVzX3Blcl93b3JkID09IDQgKi8NCj4gLQkJCXR4ZGF0YSA9ICoodTMyICopZHNwaS0+dHg7
DQo+ICsJCQlpZiAoZHNwaS0+Y3VyX2NoaXAtPmN0YXJfdmFsICYgU1BJX0NUQVJfTFNCRkUoMSkp
DQo+ICsJCQkJdHhkYXRhID0gY3B1X3RvX2xlMzIoKih1MzIgKilkc3BpLT50eCk7DQo+ICsJCQll
bHNlDQo+ICsJCQkJdHhkYXRhID0gY3B1X3RvX2JlMzIoKih1MzIgKilkc3BpLT50eCk7DQo+ICAJ
CWRzcGktPnR4ICs9IGRzcGktPmJ5dGVzX3Blcl93b3JkOw0KPiAgCX0NCj4gIAlkc3BpLT5sZW4g
LT0gZHNwaS0+Ynl0ZXNfcGVyX3dvcmQ7DQo+IEBAIC0yNDMsMTUgKzI0OSwxOCBAQCBzdGF0aWMg
dm9pZCBkc3BpX3B1c2hfcngoc3RydWN0IGZzbF9kc3BpICpkc3BpLCB1MzINCj4gcnhkYXRhKQ0K
PiAgCWlmICghZHNwaS0+cngpDQo+ICAJCXJldHVybjsNCj4gDQo+IC0JLyogTWFzayBvZiB1bmRl
ZmluZWQgYml0cyAqLw0KPiAtCXJ4ZGF0YSAmPSAoMSA8PCBkc3BpLT5iaXRzX3Blcl93b3JkKSAt
IDE7DQo+IC0NCj4gIAlpZiAoZHNwaS0+Ynl0ZXNfcGVyX3dvcmQgPT0gMSkNCj4gIAkJKih1OCAq
KWRzcGktPnJ4ID0gcnhkYXRhOw0KPiAgCWVsc2UgaWYgKGRzcGktPmJ5dGVzX3Blcl93b3JkID09
IDIpDQo+IC0JCSoodTE2ICopZHNwaS0+cnggPSByeGRhdGE7DQo+ICsJCWlmIChkc3BpLT5jdXJf
Y2hpcC0+Y3Rhcl92YWwgJiBTUElfQ1RBUl9MU0JGRSgxKSkNCj4gKwkJCSoodTE2ICopZHNwaS0+
cnggPSBiZTE2X3RvX2NwdShyeGRhdGEpOw0KPiArCQllbHNlDQo+ICsJCQkqKHUxNiAqKWRzcGkt
PnJ4ID0gYmUxNl90b19jcHUocnhkYXRhKTsNCj4gIAllbHNlIC8qIGRzcGktPmJ5dGVzX3Blcl93
b3JkID09IDQgKi8NCj4gLQkJKih1MzIgKilkc3BpLT5yeCA9IHJ4ZGF0YTsNCj4gKwkJaWYgKGRz
cGktPmN1cl9jaGlwLT5jdGFyX3ZhbCAmIFNQSV9DVEFSX0xTQkZFKDEpKQ0KPiArCQkJKih1MzIg
Kilkc3BpLT5yeCA9IGxlMzJfdG9fY3B1KHJ4ZGF0YSk7DQo+ICsJCWVsc2UNCj4gKwkJCSoodTMy
ICopZHNwaS0+cnggPSBiZTMyX3RvX2NwdShyeGRhdGEpOw0KPiAgCWRzcGktPnJ4ICs9IGRzcGkt
PmJ5dGVzX3Blcl93b3JkOw0KPiAgfQ0KPiANCj4gQEAgLTU5MywxNiArNjAyLDE2IEBAIHN0YXRp
YyB2b2lkIGRzcGlfdGNmcV93cml0ZShzdHJ1Y3QgZnNsX2RzcGkgKmRzcGkpDQo+ICAJCSAqLw0K
PiAgCQl1MzIgZGF0YSA9IGRzcGlfcG9wX3R4KGRzcGkpOw0KPiANCj4gKwkJY21kX2ZpZm9fd3Jp
dGUoZHNwaSk7DQo+ICAJCWlmIChkc3BpLT5jdXJfY2hpcC0+Y3Rhcl92YWwgJiBTUElfQ1RBUl9M
U0JGRSgxKSkgew0KPiAgCQkJLyogTFNCICovDQo+IC0JCQl0eF9maWZvX3dyaXRlKGRzcGksIGRh
dGEgJiAweEZGRkYpOw0KPiAgCQkJdHhfZmlmb193cml0ZShkc3BpLCBkYXRhID4+IDE2KTsNCj4g
KwkJCXR4X2ZpZm9fd3JpdGUoZHNwaSwgZGF0YSAmIDB4RkZGRik7DQo+ICAJCX0gZWxzZSB7DQo+
ICAJCQkvKiBNU0IgKi8NCj4gLQkJCXR4X2ZpZm9fd3JpdGUoZHNwaSwgZGF0YSA+PiAxNik7DQo+
ICAJCQl0eF9maWZvX3dyaXRlKGRzcGksIGRhdGEgJiAweEZGRkYpOw0KPiArCQkJdHhfZmlmb193
cml0ZShkc3BpLCBkYXRhID4+IDE2KTsNCj4gIAkJfQ0KPiAtCQljbWRfZmlmb193cml0ZShkc3Bp
KTsNCj4gIAl9IGVsc2Ugew0KPiAgCQkvKiBXcml0ZSBvbmUgZW50cnkgdG8gYm90aCBUWCBGSUZP
IGFuZCBDTUQgRklGTw0KPiAgCQkgKiBzaW11bHRhbmVvdXNseS4NCj4gLS0NCj4gMi4xNy4xDQpI
aSxhbGwNCkNvdWxkIHlvdSBwbGVhc2UgaGVscCBtZSB0byBzZWUgdGhlIGZpeCBvZiB0aGlzIHBh
dGNoPyBXaGF0IGNoYW5nZXMgbmVlZCB0byBiZSBtYWRlPyANCkxvb2tpbmcgZm9yd2FyZCB0byB5
b3VyIHZhbHVhYmxlIGNvbW1lbnRzIGFuZCBjcml0aWNpc20sIHRoYW5rIHlvdSB2ZXJ5IG11Y2gh
ISENClRoYW5rcywNCkNodWFuaHVhDQo=
