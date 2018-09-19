Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1BBECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8C0214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WYbAkFst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8C0214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbeISO5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:57:41 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:14560
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730392AbeISO5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5dgmLmC+9Zp3MDssJcebUhXGQ6F5jMuB0gQS66JYsc=;
 b=WYbAkFstegFAt2TQ7ke2HaKbCZvb3ZCwnTEpEUT8l2qKojkKXhyMc083Iu3MmNwpk7CaDFSYInh+YlY2mDDbdCrid2qPSysaB1pTidlK7pmEGEwP7UsvVm00KBz7Cmd+T6TFewAtyjvQ4Uw7RtaqJHiqlI0+YrBC4335ROSk77Q=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB1551.eurprd04.prod.outlook.com (10.164.84.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Wed, 19 Sep 2018 09:20:36 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::29f3:ce9:e7f4:6ee0]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::29f3:ce9:e7f4:6ee0%5]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 09:20:36 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>, Vinod Koul <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>
Subject: RE: [PATCH v2 3/4] dmaengine: imx-sdma: implement channel termination
 via worker
Thread-Topic: [PATCH v2 3/4] dmaengine: imx-sdma: implement channel
 termination via worker
Thread-Index: AQHUTE1B9pm1TCdc00eRQryEFM/8DqT0FpeQgAA9DoCAAv/rkA==
Date:   Wed, 19 Sep 2018 09:20:35 +0000
Message-ID: <VI1PR04MB4543445C54A4F6E30590CDC6891C0@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <20180914170615.12659-1-l.stach@pengutronix.de>
         <20180914170615.12659-3-l.stach@pengutronix.de>
         <VI1PR04MB4543E64752FFE550250A7A09891E0@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <1537182235.3362.127.camel@pengutronix.de>
In-Reply-To: <1537182235.3362.127.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1551;6:wBTdOejqx4ndvwGi97ElpOgu6lec9maggxOkJj/24KDFnVpsKMP0eMO+qrLRD+MyQ6OCWf6H7wJZ8TrnoXiS3DS2H424w+rVJfXniqGFuZ3XQ9NEMrCio3FxVoDAP8W1zurrMOQkhTpDb0OqaRVyGHigEQVItlQeBonrbESSDhbu9ui/o1p5zTsG7sXY6lECy10Ib1rTnxEeZs6FhdEvPET87XBTD2262rracW1tFICGJEbZEe2UVspvmwUpkvHU5H72ji3KFV8T2gt/uOlroB+dPSNP1qqAUTIN5OCHV4Fb7fhMUuErEmoD+RVE10kfdbHhtWK1w3gYyzxuBpE5KhtWslD9ZZNloy3oPqqStf0TOFf9u/HIR+PXFH5Vy66AfEWYxJiox0LW/MLpa8ozX642kPIFAG87X7e3LFW9bg02jz/mSGNn6BjfVknXJ7kcq+/nMvHWZXfx5rQwu6M8aQ==;5:8lwYmkr9fnnJJiM4Kuj7lqd8cDYK4lPON+KuZ6QIDTEFEHwYLGKW7ZY+Q8UJGsJSKn6Ag78nGMkzJLZleeveTb+PwRH5MPTW/GTGZvx259A0NM9mX7zfxrijSaKWYcQ7et1SFz/OBiwPZrEAv+DkJhI5q92WHDlM7O1bsXRcUJY=;7:F7Px3McjoMRWzg7JsWE+5R66/QDYFeIqI4pxKH+ERLpO+cNRg6YL74r6hdPeJa+O6NEA8NwUEnXuQU7Zyc71gNGjrIbxjKN9LXd3yYxgJEDrWkTQh2MdKklQbSj2wUIFB1KK6xRdvt1nWLn8/mhUDTBO7p6sTdWE3gihMqwDIfxFw5XZk9vYVvHfw9Dg638Hb0H3kSFB6+Q7fV4dq1d+QCin0xYkpWM2l6iNxypANAyojhTlLVYrLceaFGtGQ+z7
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ddf59631-700b-49d0-6183-08d61e11285f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1551;
x-ms-traffictypediagnostic: VI1PR04MB1551:
x-microsoft-antispam-prvs: <VI1PR04MB155147B9962AC5E92D2C7859891C0@VI1PR04MB1551.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:VI1PR04MB1551;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1551;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(136003)(346002)(376002)(13464003)(199004)(189003)(86362001)(66066001)(6116002)(26005)(446003)(99286004)(476003)(25786009)(229853002)(11346002)(110136005)(3846002)(5660300001)(54906003)(106356001)(186003)(486006)(105586002)(2900100001)(7736002)(5250100002)(14454004)(68736007)(6246003)(6436002)(93886005)(74316002)(316002)(102836004)(4326008)(55016002)(9686003)(53936002)(478600001)(256004)(14444005)(305945005)(81166006)(2906002)(53546011)(81156014)(6506007)(8936002)(8676002)(76176011)(33656002)(7696005)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1551;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uGmpS5LboAjC4qP6THlB7jZqR5WFe97FgaRGkuTXFH0hHMJjtv7QImqYdXCTp9knt7Lt6aS8l2lDMyWoguY9iNtg72KvR4bk7m8PoXpMIF2ZNhGMJFoIMKlkiGgXqejsWy5c4lQLLbwbyZNO1UzLls4HD5SDhjBmEf9ijLyowIplW9fjNfNQie5pifl5SIVRWGISy/71cCIgSlqQmRGpaSzuAZmI2HM5VlBtTwTGoAcsobms9HQYmLp5d9OgK2mUdGCAGRyIBQDTfBoluwiXrOPSJDO9vTB4xCAVE5zh2ZDeWXG4n1vbclH1OdH3Y1EdQXIDiokiYhEPVXdDhMTDczKwwdHWtQx4szbNaLjIAO0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf59631-700b-49d0-6183-08d61e11285f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 09:20:35.8119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAxOOW5tDnmnIgxN+aXpSAxOTowNA0KPiBUbzog
Um9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPjsgVmlub2QgS291bCA8dmtvdWxAa2VybmVs
Lm9yZz4NCj4gQ2M6IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBrZXJuZWxA
cGVuZ3V0cm9uaXguZGU7DQo+IHBhdGNod29yay1sc3RAcGVuZ3V0cm9uaXguZGUNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MiAzLzRdIGRtYWVuZ2luZTogaW14LXNkbWE6IGltcGxlbWVudCBjaGFu
bmVsDQo+IHRlcm1pbmF0aW9uIHZpYSB3b3JrZXINCj4gDQo+IEhpIFJvYmluLA0KPiANCj4gQW0g
TW9udGFnLCBkZW4gMTcuMDkuMjAxOCwgMDc6NTEgKzAwMDAgc2NocmllYiBSb2JpbiBHb25nOg0K
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBMdWNhcyBT
dGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4NCj4gPiA+IFNlbnQ6IDIwMTjlubQ55pyIMTXm
l6UgMTowNg0KPiA+ID4gPiA+IFRvOiBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPg0KPiA+
ID4gPiA+ID4gPiBDYzogZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4gPiA+ID4gPiA+ID4gUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAu
Y29tPjsgZGwtbGludXgtaW14DQo+ID4gPiA+ID4gPiA+IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+
ID4gPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IHBhdGNod29yay1sc3RAcGVuZ3V0cm9uaXguZGUN
Cj4gPiA+IFN1YmplY3Q6IFtQQVRDSCB2MiAzLzRdIGRtYWVuZ2luZTogaW14LXNkbWE6IGltcGxl
bWVudCBjaGFubmVsDQo+ID4gPiB0ZXJtaW5hdGlvbiB2aWEgd29ya2VyDQo+ID4gPg0KPiA+ID4g
VGhlIGRtYWVuZ2luZSBkb2N1bWVudGF0aW9uIHN0YXRlcyB0aGF0IGRldmljZV90ZXJtaW5hdGVf
YWxsIG1heSBiZQ0KPiA+ID4gYXN5bmNocm9ub3VzIGFuZCBuZWVkIG5vdCB3YWl0IGZvciB0aGUg
YWN0aXZlIHRyYW5zZmVycyBoYXZlIHN0b3BwZWQuDQo+ID4gPg0KPiA+ID4gVGhpcyBhbGxvd3Mg
dXMgdG8gbW92ZSBtb3N0IG9mIHRoZSBmdW5jdGlvbmFsaXR5IGN1cnJlbnRseQ0KPiA+ID4gaW1w
bGVtZW50ZWQgaW4gdGhlIHNkbWEgY2hhbm5lbCB0ZXJtaW5hdGlvbiBmdW5jdGlvbiB0byBydW4g
aW4gYQ0KPiA+ID4gd29ya2VyLCBvdXRzaWRlIG9mIGFueSBhdG9taWMgY29udGV4dC4gTW92aW5n
IHRoaXMgb3V0IG9mIGF0b21pYw0KPiA+ID4gY29udGV4dCBoYXMgdHdvDQo+ID4gPiBiZW5lZml0
czogd2UgY2FuIG5vdyBzbGVlcCB3aGlsZSB3YWl0aW5nIGZvciB0aGUgY2hhbm5lbCB0bw0KPiA+
ID4gdGVybWluYXRlLCBpbnN0ZWFkIG9mIGJ1c3kgd2FpdGluZyBhbmQgdGhlIGZyZWVpbmcgb2Yg
dGhlIGRtYQ0KPiA+ID4gZGVzY3JpcHRvcnMgaGFwcGVucyB3aXRoIElSUXMgZW5hYmxlZCwgZ2V0
dGluZyByaWQgb2YgYSB3YXJuaW5nIGluIHRoZSBkbWENCj4gbWFwcGluZyBjb2RlLg0KPiA+ID4N
Cj4gPiA+IEFzIHRoZSB0ZXJtaW5hdGlvbiBpcyBub3cgYXNuYywgd2UgbmVlZCB0byBpbXBsZW1l
bnQgdGhlDQo+ID4gPiBkZXZpY2Vfc3luY2hyb25pemUgZG1hIGVuZ2luZSBmdW5jdGlvbiwgd2hp
Y2ggc2ltcGx5IHdhaXRzIGZvciB0aGUgd29ya2VyDQo+IHRvIGZpbmlzaCBpdHMgZXhlY3V0aW9u
Lg0KPiA+ID4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBw
ZW5ndXRyb25peC5kZT4NCj4gPiA+IC0tLQ0KPiA+ID4gdjI6IEtlZXAgdmNoYW5fZ2V0X2FsbF9k
ZXNjcmlwdG9ycyBpbiB0aGUgdGVybWluYXRlX2FsbCBjYWxsLCBzbyB0aGUNCj4gPiA+IMKgwqDC
oMKgd29ya2VyIGRvZXNuJ3QgY29ycnVwdCB0aGUgbmV4dCB0cmFuc2ZlciBpZiB0aGF0J3MgYWxy
ZWFkeSBpbg0KPiA+ID4gwqDCoMKgwqB0aGUgc2V0dXAgcHJvY2Vzcy4NCj4gPiA+IC0tLQ0KPiA+
ID4gwqBkcml2ZXJzL2RtYS9pbXgtc2RtYS5jIHwgNDINCj4gPiA+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMzIgaW5z
ZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZG1hL2lteC1zZG1hLmMgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jIGluZGV4DQo+ID4g
PiA4ZDJmZWM4YjE2Y2MuLmRhNDFlOGZiZjE1MSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMv
ZG1hL2lteC1zZG1hLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCj4gPiA+
IEBAIC0zMiw2ICszMiw3IEBADQo+ID4gPiDCoCNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+
DQo+ID4gPiDCoCNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gPiA+IMKgI2luY2x1ZGUg
PGxpbnV4L29mX2RtYS5oPg0KPiA+ID4gKyNpbmNsdWRlIDxsaW51eC93b3JrcXVldWUuaD4NCj4g
PiA+DQo+ID4gPiDCoCNpbmNsdWRlIDxhc20vaXJxLmg+DQo+ID4gPiDCoCNpbmNsdWRlIDxsaW51
eC9wbGF0Zm9ybV9kYXRhL2RtYS1pbXgtc2RtYS5oPg0KPiA+ID4gQEAgLTM3NSw2ICszNzYsOCBA
QCBzdHJ1Y3Qgc2RtYV9jaGFubmVsIHsNCj4gPiA+ID4gPiA+ID4gwqAJdTMyCQkJCXNocF9hZGRy
LCBwZXJfYWRkcjsNCj4gPiA+ID4gPiA+ID4gwqAJZW51bSBkbWFfc3RhdHVzCQkJc3RhdHVzOw0K
PiA+ID4gPiA+ID4gPiDCoAlzdHJ1Y3QgaW14X2RtYV9kYXRhCQlkYXRhOw0KPiA+ID4gPiA+ID4g
PiArCXN0cnVjdCB3b3JrX3N0cnVjdAkJdGVybWluYXRlX3dvcmtlcjsNCj4gPiA+ID4gPiA+ID4g
KwlzdHJ1Y3QgbGlzdF9oZWFkCQlkZWZlcnJlZF9kZXNjX2xpc3Q7DQo+ID4gPiDCoH07DQo+ID4g
Pg0KPiA+ID4gPiA+IMKgI2RlZmluZSBJTVhfRE1BX1NHX0xPT1AJCUJJVCgwKQ0KPiA+ID4gQEAg
LTEwMjUsMzEgKzEwMjgsNDcgQEAgc3RhdGljIGludCBzZG1hX2Rpc2FibGVfY2hhbm5lbChzdHJ1
Y3QNCj4gPiA+IGRtYV9jaGFuDQo+ID4gPiAqY2hhbikNCj4gPiA+DQo+ID4gPiA+ID4gwqAJcmV0
dXJuIDA7DQo+ID4gPiDCoH0NCj4gPiA+ICtzdGF0aWMgdm9pZCBzZG1hX2NoYW5uZWxfdGVybWlu
YXRlKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykgew0KPiA+ID4gPiA+ICsJc3RydWN0IHNkbWFf
Y2hhbm5lbCAqc2RtYWMgPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0DQo+IHNkbWFfY2hhbm5l
bCwNCj4gPiA+ID4gPiArCQkJCQkJwqDCoHRlcm1pbmF0ZV93b3JrZXIpOw0KPiA+ID4gKw0KPiA+
ID4gPiA+ICsJLyoNCj4gPiA+ID4gPiArCcKgKiBBY2NvcmRpbmcgdG8gTlhQIFImRCB0ZWFtIGEg
ZGVsYXkgb2Ygb25lIEJEIFNETUEgY29zdCB0aW1lDQo+ID4gPiA+ID4gKwnCoCogKG1heGltdW0g
aXMgMW1zKSBzaG91bGQgYmUgYWRkZWQgYWZ0ZXIgZGlzYWJsZSBvZiB0aGUgY2hhbm5lbA0KPiA+
ID4gPiA+ICsJwqAqIGJpdCwgdG8gZW5zdXJlIFNETUEgY29yZSBoYXMgcmVhbGx5IGJlZW4gc3Rv
cHBlZCBhZnRlciBTRE1BDQo+ID4gPiA+ID4gKwnCoCogY2xpZW50cyBjYWxsIC5kZXZpY2VfdGVy
bWluYXRlX2FsbC4NCj4gPiA+ID4gPiArCcKgKi8NCj4gPiA+ID4gPiArCXVzbGVlcF9yYW5nZSgx
MDAwLCAyMDAwKTsNCj4gPiA+ICsNCj4gPiA+ID4gPiArCXZjaGFuX2RtYV9kZXNjX2ZyZWVfbGlz
dCgmc2RtYWMtPnZjLA0KPiAmc2RtYWMtPmRlZmVycmVkX2Rlc2NfbGlzdCk7DQo+ID4gPiA+ID4g
KwlJTklUX0xJU1RfSEVBRCgmc2RtYWMtPmRlZmVycmVkX2Rlc2NfbGlzdCk7DQo+ID4gPiArfQ0K
PiA+ID4NCj4gPiA+IMKgc3RhdGljIGludCBzZG1hX2Rpc2FibGVfY2hhbm5lbF93aXRoX2RlbGF5
KHN0cnVjdCBkbWFfY2hhbiAqY2hhbikNCj4gPiA+IHsNCj4gPiA+ID4gPiDCoAlzdHJ1Y3Qgc2Rt
YV9jaGFubmVsICpzZG1hYyA9IHRvX3NkbWFfY2hhbihjaGFuKTsNCj4gPiA+ID4gPiDCoAl1bnNp
Z25lZCBsb25nIGZsYWdzOw0KPiA+ID4gPiA+IC0JTElTVF9IRUFEKGhlYWQpOw0KPiA+ID4NCj4g
PiA+ID4gPiDCoAlzZG1hX2Rpc2FibGVfY2hhbm5lbChjaGFuKTsNCj4gPiA+ICsNCj4gPiA+ID4g
PiDCoAlzcGluX2xvY2tfaXJxc2F2ZSgmc2RtYWMtPnZjLmxvY2ssIGZsYWdzKTsNCj4gPiA+ID4g
PiAtCXZjaGFuX2dldF9hbGxfZGVzY3JpcHRvcnMoJnNkbWFjLT52YywgJmhlYWQpOw0KPiA+ID4g
PiA+ICsJdmNoYW5fZ2V0X2FsbF9kZXNjcmlwdG9ycygmc2RtYWMtPnZjLA0KPiA+ID4gPiA+ICsm
c2RtYWMtPmRlZmVycmVkX2Rlc2NfbGlzdCk7DQo+ID4gPiA+ID4gwqAJc2RtYWMtPmRlc2MgPSBO
VUxMOw0KPiA+ID4gPiA+IMKgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnNkbWFjLT52Yy5sb2Nr
LCBmbGFncyk7DQo+ID4gPiA+ID4gLQl2Y2hhbl9kbWFfZGVzY19mcmVlX2xpc3QoJnNkbWFjLT52
YywgJmhlYWQpOw0KPiA+ID4NCj4gPiA+ID4gPiAtCS8qDQo+ID4gPiA+ID4gLQnCoCogQWNjb3Jk
aW5nIHRvIE5YUCBSJkQgdGVhbSBhIGRlbGF5IG9mIG9uZSBCRCBTRE1BIGNvc3QgdGltZQ0KPiA+
ID4gPiA+IC0JwqAqIChtYXhpbXVtIGlzIDFtcykgc2hvdWxkIGJlIGFkZGVkIGFmdGVyIGRpc2Fi
bGUgb2YgdGhlIGNoYW5uZWwNCj4gPiA+ID4gPiAtCcKgKiBiaXQsIHRvIGVuc3VyZSBTRE1BIGNv
cmUgaGFzIHJlYWxseSBiZWVuIHN0b3BwZWQgYWZ0ZXIgU0RNQQ0KPiA+ID4gPiA+IC0JwqAqIGNs
aWVudHMgY2FsbCAuZGV2aWNlX3Rlcm1pbmF0ZV9hbGwuDQo+ID4gPiA+ID4gLQnCoCovDQo+ID4g
PiA+ID4gLQltZGVsYXkoMSk7DQo+ID4gPiA+ID4gKwlzY2hlZHVsZV93b3JrKCZzZG1hYy0+dGVy
bWluYXRlX3dvcmtlcik7DQo+ID4gPg0KPiA+ID4gPiA+IMKgCXJldHVybiAwOw0KPiA+ID4gwqB9
DQo+ID4gPg0KPiA+ID4gK3N0YXRpYyB2b2lkIHNkbWFfY2hhbm5lbF9zeW5jaHJvbml6ZShzdHJ1
Y3QgZG1hX2NoYW4gKmNoYW4pIHsNCj4gPiA+ID4gPiArCXN0cnVjdCBzZG1hX2NoYW5uZWwgKnNk
bWFjID0gdG9fc2RtYV9jaGFuKGNoYW4pOw0KPiA+ID4gKw0KPiA+DQo+ID4gUGxlYXNlIGFkZCB0
aGUgYmVsb3cgdG8gbWFrZSBzdXJlIGludGVybmFsIHZpcnQgZG1hIHRhc2tsZXQga2lsbGVkIHRv
by4NCj4gPiB0YXNrbGV0X2tpbGwoJnNkbWFjLT52Yy50YXNrKTsNCj4gDQo+IFRoaXMgaXMgbm90
IHBvc3NpYmxlLiBXZSBjYW4gbm90IGRvIGFueXRoaW5nIHRoYXQgYWx0ZXJzIHRoZSBjdXJyZW50
IHN0YXRlIG9mIHRoZQ0KPiBWQyBpbiB0aGUgc3luY2hyb25pemUgY2FsbC4gT3RoZXJ3aXNlIHdl
IGNvdWxkIGJlIHJ1bm5pbmcgaW50byB0aGUgdGhlIHNhbWUNCj4gY2xhc3Mgb2YgaXNzdWVzIGFz
IHRoZSB2MSBoYWQsIHdpdGggY29ycnVwdGluZyB0aGUgc3RhdGUgb2YgdGhlIG5leHQgc2V0IHVw
DQo+IHRyYW5zZmVyLg0KdGFza2xldF9raWxsIG5ldmVyIGFsdGVyIHRoZSBjdXJyZW50IHN0YXRl
LCBqdXN0IHdhaXQgZm9yIHRoZSB0YXNrbGV0IHJ1bm5pbmcgb3Zlci4NCkJ1dCBoZXJlICd2Y2hh
bl9zeW5jaHJvbml6ZSgpJyBtYXliZSBiZXR0ZXIgdGhhbiAndGFza2xldF9raWxsJyBkaXJlY3Rs
eS4gDQoNCkZvciB0aGUgdjEgSXNzdWUsIEkgaW52ZXN0aWdhdGUgaXQgdG9kYXkgYW5kIGZvdW5k
IHRoYXQgY2F1c2VkIGJ5IHVhcnQgZHJpdmVyIGNhbGwgZmx1c2hfYnVmZmVyIGJlZm9yZQ0KVFgg
c3RhcnQgYW5kIHRoZW4gdGVybWluYXRlIGRtYSBjaGFubmVsIGRpcmVjdGx5IHdoaWNoIGlzIG5v
dCBzZXR1cCBkbWEgY2hhbm5lbCB5ZXQuIEJ1dCBpbiB2MSwNCmRtYSBjaGFubmVsIHRlcm1pbmF0
ZWQgaW4gd29ya2VyIGluc3RlYWQsIHRodXMsIHdoZW4gdHggZG1hIGZpbmlzaCBzZXR1cCB0cmFu
c2ZlciBhbmQgd2FpdGluZw0KZm9yIHRoZSBkbWEgZG9uZSBpbnRlcnJ1cHQsIHRoZSB3b3JrZXIg
c2NoZWR1bGVkIGFuZCBzZXQgJ3NkbWFjLT5kZXNjPU5VTEwnLCB3aGljaCBjYXVzZQ0KZG1hIGNo
YW5uZWwgc3RvcHBlZCBmb3JldmVyIG9uY2UgdGhlIGRtYSBkb25lIGludGVycnVwdCBjb21pbmcu
IE9ubHkgb25lIGxpbmUgY29kZSBhcyBiZWxvdyANCmNvdWxkIGZpeCB5b3VyIFYxIGlzc3VlOg0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvaW14LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1z
ZG1hLmMNCmluZGV4IDJmMmU1YWYuLjU2ZDU0MmIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2RtYS9p
bXgtc2RtYS5jDQorKysgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQpAQCAtMTA1NCw3ICsxMDU0
LDkgQEAgc3RhdGljIGludCBzZG1hX2Rpc2FibGVfY2hhbm5lbF93aXRoX2RlbGF5KHN0cnVjdCBk
bWFfY2hhbiAqY2hhbikNCiAgICAgICAgc3RydWN0IHNkbWFfY2hhbm5lbCAqc2RtYWMgPSB0b19z
ZG1hX2NoYW4oY2hhbik7DQoNCiAgICAgICAgc2RtYV9kaXNhYmxlX2NoYW5uZWwoY2hhbik7DQot
ICAgICAgIHNjaGVkdWxlX3dvcmsoJnNkbWFjLT50ZXJtaW5hdGVfd29ya2VyKTsNCisNCisgICAg
ICAgaWYgKHNkbWFjLT5kZXNjKQ0KKyAgICAgICAgICAgICAgIHNjaGVkdWxlX3dvcmsoJnNkbWFj
LT50ZXJtaW5hdGVfd29ya2VyKTsNCg0KICAgICAgICByZXR1cm4gMDsNCj4gDQo+IFJlZ2FyZHMs
DQo+IEx1Y2FzDQo=
