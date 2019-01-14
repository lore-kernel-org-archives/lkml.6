Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C29AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61D2206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tVc9g2A7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfANCKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 21:10:30 -0500
Received: from mail-eopbgr140078.outbound.protection.outlook.com ([40.107.14.78]:27361
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726660AbfANCK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 21:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/kkzlQIXE5c2wXSv7ciTyhivbz5rK8vRheCgRD8w5A=;
 b=tVc9g2A7mg+efoktgO7z86DsddRNoiaD0B0371mfYrxhrPuLuCSQSjVB1VhH7Mi7uF89iAkr0jzPo07VxKz1LaX+U0FGHI3Gn1jTNkUebBSrfq3hK1Jf0VOL2G4UPrgAmSVZUZXaWG43TuZ4Mn+y5AaXqPIAj5XqD/3yignsh5c=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3676.eurprd04.prod.outlook.com (52.134.70.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Mon, 14 Jan 2019 02:10:24 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97%6]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 02:10:24 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] rtc: snvs: make sure clock is enabled for interrupt
 handle
Thread-Topic: [PATCH] rtc: snvs: make sure clock is enabled for interrupt
 handle
Thread-Index: AQHUqXyIz6U11eu4LkGyuJrswoDOg6WqIcOAgAPfn+A=
Date:   Mon, 14 Jan 2019 02:10:24 +0000
Message-ID: <DB3PR0402MB3916EF29125AE80CB84AA480F5800@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1547190255-9388-1-git-send-email-Anson.Huang@nxp.com>
 <20190111143141.GC2547@piout.net>
In-Reply-To: <20190111143141.GC2547@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3676;6:AYmL6al4ZHQxGfWkuY1ThBex7fx5qb4rqOlBlrPEwrfPAB9ZVKFPAFjY7MtZ2bixcdzS32g9kHePSq9m+1DFE51yYOTgpjkujyjjXEVhcQqrIp5eqKdLjCNDbq+wQy/m5lyXl6btVnbuQqLqJCAj11F+R3YwUvMzu1T9PrMoHJm/rSpw+6hxZyxmxhyvdC60cg+9VLDOg0aTFaDKRToMbhyadcCU6Bl0C43ArKI4BmX+PTI6NwHQ48OlG5ZKWS0kkSAGAVVtuMDT4yErxL/o3oJlYafYT8AxZbyZEJ7T7geemnSWEy3crz2ZU4kt7yMwf694MsLLoMTVc6iTJbKrtrkBEW+RSgWD3jtG1HejGPB/OVRrmHHMqgLva2DBPKBZ0XN6fiCT6WUEUVrtb0LdGL7rH1MDZaJdeDc8153bbWpTh9Ya/Vv21r/58m4juhikOOM7TR8a++Cy5n9LMIlejA==;5:++bQq99geTKa/9tLYrAoUfxnTR1xhEeBZ1Zj6Kt1b1FCKfavXps1BF9n/GahHqJI1iGREC/xkGzK0giSfb1Gm9cMzcYIG/pe+InJSn0NAaAjkIwoIHbLF2UN2BLpWPCc7ulxZ5/t+GTrNRdKWw7h1RA/J6/ij4gCrl3Pbyyl7iJQy4/agKjGI8hQCVopH21FZ/LNx+YGo208ru4UtEpE2g==;7:lE8r2+isUrtHpjSiz4PxDChqgGj2BSAK47YtjYHx/t0ycTJnDFrKYv8GaszLiN+bAZbzcWrs6Nj+X2YhPcbQusljTSbjtk/1hmY5W0z1TBZ9WLxOSvtCizn5pMFxak0zNe1jvpTwSk67LCPZs0NzNw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cf11f803-ad1e-443d-2055-08d679c5720c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3676;
x-ms-traffictypediagnostic: DB3PR0402MB3676:
x-microsoft-antispam-prvs: <DB3PR0402MB367683D864784CD0025A749DF5800@DB3PR0402MB3676.eurprd04.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(376002)(39860400002)(52314003)(13464003)(199004)(189003)(6246003)(99286004)(6116002)(5660300001)(316002)(53936002)(446003)(476003)(11346002)(97736004)(45080400002)(478600001)(3846002)(55016002)(229853002)(54906003)(4326008)(25786009)(6436002)(81166006)(8676002)(8936002)(81156014)(6916009)(74316002)(7736002)(68736007)(305945005)(44832011)(86362001)(486006)(106356001)(105586002)(33656002)(256004)(14444005)(71190400001)(71200400001)(7696005)(14454004)(76176011)(9686003)(6306002)(102836004)(6506007)(53546011)(966005)(26005)(186003)(2906002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3676;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vv80stBystJBlMokSEsxiS9ZQz8z54uvnRj3EPwezqUCtmdDDHiotIDtu55iZbfrbipInLUPxEeSregRAGSw1kCFdwhmh4lQNCcA2mIYQwxdTIQgtWkMBSvt31FQEtQwByn97WSz6yDrGzJCVA1hogzmdlleIeHl+nGLaFoNMLPoRjLZobo+a1SnH67tBQ/c6HvzRWdB6RfeJmJZz6STYkitVxS6Tuye3jIqKg2k12cwc4+3k7ZBb4bIDjkza8d69Jx3UXqMy6kbM7FYnyf026znMDf9hTo1HRXe0tlcjPPUta7GWTgZar/hp30dJhm/w/k8PNFu6w5emhKHvTPQHv4DRjIDDXG2nI1Wefl6xpJKQlGo36WRkLoJ5bN6K/+c0o5UMeBKICUZqccEqKpumCQXrxei2evaz3slaHXbVP8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf11f803-ad1e-443d-2055-08d679c5720c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 02:10:24.7638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3676
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFsZXhhbmRyZQ0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXhhbmRyZSBCZWxsb25pIFttYWlsdG86YWxl
eGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb21dDQo+IFNlbnQ6IDIwMTnE6jHUwjExyNUgMjI6MzIN
Cj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzogYS56dW1tb0B0
b3dlcnRlY2guaXQ7IGxpbnV4LXJ0Y0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIHJ0Yzogc252czogbWFrZSBzdXJlIGNsb2NrIGlzIGVuYWJsZWQgZm9y
IGludGVycnVwdCBoYW5kbGUNCj4gDQo+IEhpLA0KPiANCj4gT24gMTEvMDEvMjAxOSAwNzowOTow
MiswMDAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiBEdXJpbmcgc3lzdGVtIHN1c3BlbmQsIHRo
ZSBTTlZTIFJUQydzIGNsb2NrIHdpbGwgYmUgZGlzYWJsZWQgaW4gbm9pcnENCj4gPiBzdXNwZW5k
IHBoYXNlLCBidXQgU05WUyBSVEMncyBhbGFybSBpbnRlcnJ1cHQgY291bGQgc3RpbGwgYXJyaXZl
LA0KPiA+IHN5c3RlbSB3aWxsIGhhbmcgaWYgU05WUyBSVEMgZHJpdmVyIHRyaWVzIHRvIGFjY2Vz
cyByZWdpc3RlciB3aXRob3V0DQo+ID4gY2xvY2sgZW5hYmxlZCwgdGhpcyBwYXRjaCBmaXhlcyB0
aGUgaXNzdWUgb2YgdGhpcyBzY2VuYXJpby4NCj4gPg0KPiANCj4gQXJlIHlvdSBzdXJlIHRoaXMg
aXMgdGhlIHJlYWwgaXNzdWU/IEkgZG9uJ3QgdGhpbmsgdGhlIGhhbmRsZXIgY2FuIGJlIGNhbGxl
ZA0KPiBiZWZvcmUgdGhlIHJlc3VtZV9ub2lycSBjYWxsYmFjay4gSXNuJ3QgdGhlIGlzc3VlIHRo
YXQgeW91ciBjbG9jayBkcml2ZXIgaGFzIG5vdA0KPiB5ZXQgcmVzdW1lZCBieSB0aGUgdGltZSB5
b3UgY2FsbCB0aGUgcnRjIGRyaXZlciByZXN1bWVfbm9pcnEgY2FsbGJhY2sgPw0KDQpZZXMsIHNp
bmNlIHRoZSBSVEMgYWxhcm0gaXMgd2FrZXVwIHNvdXJjZSwgaXQgaXMgTk9UIGJlaW5nIGRpc2Fi
bGVkIGR1cmluZyBzdXNwZW5kDQpmbG93IGF0IGFsbCwgYWZ0ZXIgcnRjIGRydmllcidzIG5vaXJx
IHN1c3BlbmQgY2FsbGJhY2sgaXMgYmVpbmcgY2FsbGVkLCBydGMgY2xvY2sgaXMgZGlzYWJsZWQN
CmluIHRoaXMgY2FsbGJhY2ssIHJ0YyBhbGFybSBjb3VsZCBhcnJpdmUgYXQgdGhpcyBwb2ludCB0
aGVuIEFSTSBJUlEgaXMgTk9UIGRpc2FibGVkIHlldCwNCnNvIHJ0YyBpcnEgaGFuZGxlciB3aWxs
IGJlIGNhbGxlZCwgc28gdGhlIGhhbmRsZXIgd2lsbCBhY2Nlc3MgUlRDIHJlZ2lzdGVyIHdpdGgg
UlRDIGNsb2NrIGRpc2FibGVkDQphbmQgY2F1c2Ugc3lzdGVtIGhhbmcuIFRoZSBwb2ludCBpcyBS
VEMgY2xvY2sgaXMgZGlzYWJsZWQgaW4gbm9pcnEgc3VzcGVuZCBjYWxsYmFjay4NCg0KDQo+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL3J0Yy9ydGMtc252cy5jIHwgNiArKysrKysNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cnRjL3J0Yy1zbnZzLmMgYi9kcml2ZXJzL3J0Yy9ydGMtc252cy5jIGluZGV4DQo+ID4gYjI0ODNh
Ny4uMGI5ZWZmMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3J0Yy9ydGMtc252cy5jDQo+ID4g
KysrIGIvZHJpdmVycy9ydGMvcnRjLXNudnMuYw0KPiA+IEBAIC0yMzksNiArMjM5LDkgQEAgc3Rh
dGljIGlycXJldHVybl90IHNudnNfcnRjX2lycV9oYW5kbGVyKGludCBpcnEsIHZvaWQNCj4gKmRl
dl9pZCkNCj4gPiAgCXUzMiBscHNyOw0KPiA+ICAJdTMyIGV2ZW50cyA9IDA7DQo+ID4NCj4gPiAr
CWlmIChkYXRhLT5jbGspDQo+ID4gKwkJY2xrX2VuYWJsZShkYXRhLT5jbGspOw0KPiA+ICsNCj4g
DQo+IEFueXdheSwgd29uJ3QgdGhhdCBuZWVkIGEgY2xrX3ByZXBhcmVfZW5hYmxlIGJlY2F1c2Ug
aXQgaGFzIGJlZW4NCj4gY2xrX2Rpc2FibGVfdW5wcmVwYXJlIGluIHN1c3BlbmRfbm9pcnE/IEFu
ZCB0aGlzIGlzIHNvbWV0aGluZyB5b3UgY2FuIG5vdA0KPiBkbyBpbiBhdG9taWMgY29udGV4dA0K
DQpZZXMsIGJ1dCB0aGUgcHJlcGFyZS91bnByZXBhcmVkIGNhbiBOT1QgYmUgY2FsbGVkIGluIGF0
b21pYyBjb250ZXh0LCBzaW5jZSB0aGUgU05WUyBSVEMNCmNsb2NrIG9uIGkuTVggU29DIGlzIGFs
d2F5cyBmcm9tIGEgY2xvY2sgc291cmNlIHdpdGhvdXQgcHJlcGFyZS91bnByZXBhcmVkIG5lZWRl
ZCwgc3VjaCBhcw0KZnJvbSBpcGcgb3IgT1NDIGV0Yy4sIHNvIGp1c3QgZG9pbmcgZW5hYmxlL2Rp
c2FibGUgaXMgZ29vZCBlbm91Z2ggZm9yIGl0Lg0KDQpBbnNvbi4NCg0KPiANCj4gLS0NCj4gQWxl
eGFuZHJlIEJlbGxvbmksIEJvb3RsaW4NCj4gRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdp
bmVlcmluZw0KPiBodHRwczovL2VtZWEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNv
bS8/dXJsPWh0dHBzJTNBJTJGJTJGYm9vdGwNCj4gaW4uY29tJmFtcDtkYXRhPTAyJTdDMDElN0Nh
bnNvbi5odWFuZyU0MG54cC5jb20lN0NhOTA2MDgxNDRlOTANCj4gNDk0YTZmMzYwOGQ2NzdkMTgx
OGElN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MNCj4gMCU3QzYzNjgy
ODEzOTA0MjEwNzkzMSZhbXA7c2RhdGE9b1glMkJxbmo0WDNuUyUyQmE4OG90ZWR0OVd5SXkNCj4g
VmhCTlZsNWVpeFZXZVY0NFRBJTNEJmFtcDtyZXNlcnZlZD0wDQo=
