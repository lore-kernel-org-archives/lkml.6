Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C7DC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331E1206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BIR5l9bF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331E1206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeI3Qus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 12:50:48 -0400
Received: from mail-ve1eur01on0050.outbound.protection.outlook.com ([104.47.1.50]:28108
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728015AbeI3Qur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 12:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8gueePBxoWjnKkmPbKQ2mMWh6nW+hLWAekc+qJ5aHA=;
 b=BIR5l9bFmTBC3P36PR6rSsyyYAzW4kZHuwASj5kidVnDtE0OJGuYekWEbgZAPCxXmr7I88Ri5yJ2MIZg5gGpBwIou4HyrGV5Og9dY67SDuqatIoRdk2gt5HxKLwT0Kuj8wWu/iedDQyofprbeW8f8/bZd30gxCH8bO9UsO5cnfE=
Received: from AM0PR04MB4353.eurprd04.prod.outlook.com (52.134.125.146) by
 AM0PR04MB4164.eurprd04.prod.outlook.com (52.134.126.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Sun, 30 Sep 2018 10:18:18 +0000
Received: from AM0PR04MB4353.eurprd04.prod.outlook.com
 ([fe80::a5b0:6887:b5b8:671b]) by AM0PR04MB4353.eurprd04.prod.outlook.com
 ([fe80::a5b0:6887:b5b8:671b%2]) with mapi id 15.20.1185.024; Sun, 30 Sep 2018
 10:18:18 +0000
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>
Subject: RE: [PATCH v2 1/4] spi: spi-mem: Add the spi_set_xfer_bpw function
Thread-Topic: [PATCH v2 1/4] spi: spi-mem: Add the spi_set_xfer_bpw function
Thread-Index: AQHUWJ+Hb3OQQDlcbEOvxAqFr7DrO6UImK+AgAAAnjA=
Date:   Sun, 30 Sep 2018 10:18:18 +0000
Message-ID: <AM0PR04MB4353635C85F0D744D090A14C97EE0@AM0PR04MB4353.eurprd04.prod.outlook.com>
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
 <20180930120425.7715cb29@bbrezillon>
In-Reply-To: <20180930120425.7715cb29@bbrezillon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chuanhua.han@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4164;6:r1whfDYKB0BMad0BGf8tJy6n37KU4FVANjlajj1nS0ciL3ua0MMJXKr2n/0kChVT//eQ95oR3JB5e2+Jyu9xVOi/QKJjEwbDUdb/LQ6uD4+ki9Qj2kCRrr9GAFQQR8HmVZfc4wBAJ8cuoCXBZuwOzqSZLxKNZQQzxQbYe7WbxkRfCYb2MjFklP1VTkkSvSRF7HUcVx65KeO0fnvcFhiyUFJMCtYPL2hRmV/AEvhJQ2q1Jpi6a65H1VVs1+wmiACGf/Awpvgx/CPJ1cPTcqgjUQq9peyS28KjFMPI7AlJ7OnnCBJ7PKxOxknwZYPZYU4OygFF4d3TXPPR/z8lpVasSqEO7kVHFDXaKZk78QcVyZib1mewINtXUzK1AfcnKif4a2fbAj4/MPMJBL+0GUDxrl2C57RayOzh3SnkTtl3GQcrQOU1b7ts8/hjgLuRqIOJr0HzB8z5f4HGLumQlkvtcA==;5:17EVucESUGs8d9VylwJX4Vf6Mz2lf5D9moW0giXBcem3BwbQ1SC5DlLtjsee9xarOqsrJA06ZUoDVot3BKKKCZHdt6BIhzs46tTev/Losafw9ypBUlTYp+egRodHzT8dKKY5wlVTHjqWTL3SMgxh4gnzWgdbNvJNyfhAObxm7Ms=;7:O7V1I8mJzLW5o9jmzX1VkjAbxE8Fn6Ti/uJZnnBIL6bElS39nITD6H/8xuUmIz6oNJorXeIPPqooKLxy5R2sH3kX7Nhfg3IQZVw4sdELWp4ShtQD4vyLPkxHzk3tM26LvlV9pb3nBdF00SB7Y5RWwPunngIoiaysIMof8nKmn6GapCHOshvIxfXsQghP3oo0k/T2uZl5jYWVjeAvsBqluJN0uyic6e8c1MsVcKLwk4gD6bVAp4rboISYgjuBkdzP
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 20d3cc78-d0c4-40b8-bc71-08d626be0abc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4164;
x-ms-traffictypediagnostic: AM0PR04MB4164:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB41646DF987153E50873DFBC497EE0@AM0PR04MB4164.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:AM0PR04MB4164;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4164;
x-forefront-prvs: 08118EFC2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(346002)(376002)(199004)(13464003)(189003)(76176011)(8936002)(99286004)(14454004)(3846002)(6116002)(316002)(106356001)(5250100002)(476003)(25786009)(53546011)(6506007)(33656002)(229853002)(34290500001)(97736004)(256004)(105586002)(54906003)(7696005)(2906002)(446003)(478600001)(11346002)(71190400001)(71200400001)(53936002)(86362001)(4326008)(66066001)(55016002)(74316002)(305945005)(186003)(486006)(6916009)(9686003)(7736002)(2900100001)(6246003)(26005)(6436002)(8676002)(81156014)(68736007)(81166006)(44832011)(102836004)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4164;H:AM0PR04MB4353.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kElPvF7VmRFuLV+rkHpShsZfsixGTW9+Q1x8ztMp/D5YeaUYxq3cNg7mY53jrOa2A4vk1M2DXuFJXNXPJXQXXaSDLgB71ttK+aC3+TcRRQ0qqAdYkm6aJH0uTM2dEw/xdfxpcAvP9e33jgTuCWxNBhSonAFDsop/810UTSeSbXpd1HVqNN8mooJ3Vvzd0UvpTs+m09VdgNw1lcu/dcNpbWSMcLegRN66YcENYUnPiypAxZeg5w0P8yP4vB2ON7C5V1Blxk2I6m3NxGb1u6WD6bwvPVqRLKuLcKo5ELlFOxPoYnZI4cMkCuN7PxLeZvRTDiN8TnsbSSDQkuKEjLUqi/Hax2Ju4TX/ROquI3nYj9w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d3cc78-d0c4-40b8-bc71-08d626be0abc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2018 10:18:18.4349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXMgQnJlemlsbG9u
IDxib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+DQo+IFNlbnQ6IDIwMTjE6jnUwjMwyNUgMTg6
MDQNCj4gVG86IENodWFuaHVhIEhhbiA8Y2h1YW5odWEuaGFuQG54cC5jb20+DQo+IENjOiBicm9v
bmllQGtlcm5lbC5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGVoYUBkZWlmLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDEvNF0gc3BpOiBzcGktbWVtOiBBZGQgdGhlIHNwaV9zZXRfeGZlcl9icHcgZnVuY3Rpb24NCj4g
DQo+IEhpIENodWFuaHVhLA0KPiANCj4gT24gU3VuLCAzMCBTZXAgMjAxOCAxNzoyNTozMiArMDgw
MA0KPiBDaHVhbmh1YSBIYW4gPGNodWFuaHVhLmhhbkBueHAuY29tPiB3cm90ZToNCj4gDQo+ID4g
QmVmb3JlIHdlIGFkZCB0aGlzIHNwaV90cmFuc2ZlciB0byB0aGUgc3BpX21lc3NhZ2UgY2hhaW4g
dGFibGUsIHdlDQo+ID4gbmVlZCBiaXRzX3Blcl93b3JkX21hc2sgYmFzZWQgb24gc3BpX2NvbnRy
b2wgdG8gc2V0IHRoZSBiaXRzX3Blcl93b3JkDQo+ID4gb2YgdGhpcyBzcGlfdHJhbnNmZXIuDQo+
IA0KPiBMZXQncyBtYWtlIGl0IGNsZWFyZXI6IHRoaXMgaXMgd3JvbmcuIFRoZSBzcGktbWVtIHBy
b3RvY29sIGlzIGp1c3QgdXNpbmcgYnl0ZXMsDQo+IG5vdCBjdXN0b20gc2l6ZSB3b3Jkcy4gRml4
IHRoZSBmc2wtZHNwaSBkcml2ZXIgaWYgbmVlZGVkLCBidXQgZG9uJ3QgdHJ5IHRvIGFkanVzdA0K
PiB4ZmVyLT5iaXRzX3Blcl93b3JkIGluIHNwaS1tZW0uYywgYmVjYXVzZSB0aGlzIGlzIGluYXBw
cm9wcmlhdGUuDQpUaGUgdmFsdWUgb2YgYml0c19wZXJfd29yZCBpcyBvbmx5IGtub3duIGJlZm9y
ZSB0aGUgc3BpX21lc3NhZ2VfYWRkX3RhaWwgZnVuY3Rpb24gaXMgY2FsbGVkLCANCmFuZCBkc3Bp
IGNvbnRyb2xsZXJzIG9ubHkgZGVjaWRlIHdoaWNoIG1vZGUgKDhiaXQsIDE2Yml0LCBvciAzMmJp
dCkgdG8gdXNlIGZvciBkYXRhDQp0cmFuc2ZlciBiYXNlZCBvbiB0aGUgdmFsdWUgb2YgdGhlIHRy
YW5zZmVyLT5iaXRzX3Blcl93b3JkLg0KDQo+IA0KPiBSZWdhcmRzLA0KPiANCj4gQm9yaXMNCj4g
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVhbmh1YSBIYW4gPGNodWFuaHVhLmhhbkBueHAu
Y29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gIC1UaGUgb3JpZ2luYWwgcGF0
Y2ggaXMgZGl2aWRlZCBpbnRvIG11bHRpcGxlIHBhdGNoZXModGhlIG9yaWdpbmFsDQo+ID4gcGF0
Y2ggdGhlbWUgaXMgInNwaTogc3BpLWZzbC1kc3BpOiBGaXggc3VwcG9ydCBmb3IgWFNQSSB0cmFu
c3BvcnQNCj4gPiBtb2RlIiksb25lIG9mIHdoaWNoIGlzIHNlZ21lbnRlZC4NCj4gPg0KPiA+ICBk
cml2ZXJzL3NwaS9zcGktbWVtLmMgfCAzOQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktbWVtLmMgYi9kcml2ZXJzL3NwaS9zcGkt
bWVtLmMgaW5kZXgNCj4gPiBlYjcyZGJhNzFkODMuLjcxN2U3MTFjMDk1MiAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL3NwaS9zcGktbWVtLmMNCj4gPiArKysgYi9kcml2ZXJzL3NwaS9zcGktbWVt
LmMNCj4gPiBAQCAtMTc1LDYgKzE3NSw0MSBAQCBib29sIHNwaV9tZW1fc3VwcG9ydHNfb3Aoc3Ry
dWN0IHNwaV9tZW0NCj4gKm1lbSwNCj4gPiBjb25zdCBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3ApICB9
DQo+ID4gRVhQT1JUX1NZTUJPTF9HUEwoc3BpX21lbV9zdXBwb3J0c19vcCk7DQo+ID4NCj4gPiAr
LyoqDQo+ID4gKyAqIHNwaV9zZXRfeGZlcl9icHcoKSAtIFNldCB0aGUgYml0c19wZXJfd29yZCBm
b3IgZWFjaCB0cmFuc2ZlciBiYXNlZCBvbg0KPiA+ICsgKgkJCXRoZSBiaXRzX3Blcl93b3JkX21h
c2sgb2YgdGhlIHNwaSBjb250cm9sbGVyDQo+ID4gKyAqIEBjdHJsOiB0aGUgc3BpIGNvbnRyb2xs
ZXINCj4gPiArICogQHhmZXI6IHRoZSBzcGkgdHJhbnNmZXINCj4gPiArICoNCj4gPiArICogVGhp
cyBmdW5jdGlvbiBzZXRzIHRoZSBiaXRzX3Blcl93b3JkIGZvciBlYWNoIHRyYW5zZmVyIGJhc2Vk
IG9uDQo+ID4gK3RoZSBzcGkNCj4gPiArICogY29udHJvbGxlcidzIGJpdHNfcGVyX3dvcmRfbWFz
ayB0byBpbXByb3ZlIHRoZSBlZmZpY2llbmN5IG9mIHNwaQ0KPiB0cmFuc3BvcnQuDQo+ID4gKyAq
DQo+ID4gKyAqIFJldHVybjogMCBpbiBjYXNlIG9mIHN1Y2Nlc3MsIGEgbmVnYXRpdmUgZXJyb3Ig
Y29kZSBvdGhlcndpc2UuDQo+ID4gKyAqLw0KPiA+ICtpbnQgc3BpX3NldF94ZmVyX2JwdyhzdHJ1
Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0bHIsIHN0cnVjdCBzcGlfdHJhbnNmZXINCj4gPiArKnhmZXIp
IHsNCj4gPiArCWlmICghY3RsciB8fCAheGZlcikgew0KPiA+ICsJCWRldl9lcnIoJmN0bHItPmRl
diwNCj4gPiArCQkJIkZhaWwgdG8gc2V0IGJpdHNfcGVyX3dvcmQgZm9yIHNwaSB0cmFuc2Zlclxu
Iik7DQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKGN0
bHItPmJpdHNfcGVyX3dvcmRfbWFzaykgew0KPiA+ICsJCWlmICghKHhmZXItPmxlbiAlIDQpKSB7
DQo+ID4gKwkJCWlmIChjdGxyLT5iaXRzX3Blcl93b3JkX21hc2sgJiBTUElfQlBXX01BU0soMzIp
KQ0KPiA+ICsJCQkJeGZlci0+Yml0c19wZXJfd29yZCA9IDMyOw0KPiA+ICsJCX0gZWxzZSBpZiAo
ISh4ZmVyLT5sZW4gJSAyKSkgew0KPiA+ICsJCQlpZiAoY3Rsci0+Yml0c19wZXJfd29yZF9tYXNr
ICYgU1BJX0JQV19NQVNLKDE2KSkNCj4gPiArCQkJCXhmZXItPmJpdHNfcGVyX3dvcmQgPSAxNjsN
Cj4gPiArCQl9IGVsc2Ugew0KPiA+ICsJCQl4ZmVyLT5iaXRzX3Blcl93b3JkID0gODsNCj4gPiAr
CQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArRVhQT1JU
X1NZTUJPTF9HUEwoc3BpX3NldF94ZmVyX2Jwdyk7DQo+ID4gKw0KPiA+ICAvKioNCj4gPiAgICog
c3BpX21lbV9leGVjX29wKCkgLSBFeGVjdXRlIGEgbWVtb3J5IG9wZXJhdGlvbg0KPiA+ICAgKiBA
bWVtOiB0aGUgU1BJIG1lbW9yeQ0KPiA+IEBAIC0yNTIsNiArMjg3LDcgQEAgaW50IHNwaV9tZW1f
ZXhlY19vcChzdHJ1Y3Qgc3BpX21lbSAqbWVtLCBjb25zdA0KPiBzdHJ1Y3Qgc3BpX21lbV9vcCAq
b3ApDQo+ID4gIAl4ZmVyc1t4ZmVycG9zXS50eF9idWYgPSB0bXBidWY7DQo+ID4gIAl4ZmVyc1t4
ZmVycG9zXS5sZW4gPSBzaXplb2Yob3AtPmNtZC5vcGNvZGUpOw0KPiA+ICAJeGZlcnNbeGZlcnBv
c10udHhfbmJpdHMgPSBvcC0+Y21kLmJ1c3dpZHRoOw0KPiA+ICsJc3BpX3NldF94ZmVyX2Jwdyhj
dGxyLCAmeGZlcnNbeGZlcnBvc10pOw0KPiA+ICAJc3BpX21lc3NhZ2VfYWRkX3RhaWwoJnhmZXJz
W3hmZXJwb3NdLCAmbXNnKTsNCj4gPiAgCXhmZXJwb3MrKzsNCj4gPiAgCXRvdGFseGZlcmxlbisr
Ow0KPiA+IEBAIC0yNjYsNiArMzAyLDcgQEAgaW50IHNwaV9tZW1fZXhlY19vcChzdHJ1Y3Qgc3Bp
X21lbSAqbWVtLCBjb25zdA0KPiBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3ApDQo+ID4gIAkJeGZlcnNb
eGZlcnBvc10udHhfYnVmID0gdG1wYnVmICsgMTsNCj4gPiAgCQl4ZmVyc1t4ZmVycG9zXS5sZW4g
PSBvcC0+YWRkci5uYnl0ZXM7DQo+ID4gIAkJeGZlcnNbeGZlcnBvc10udHhfbmJpdHMgPSBvcC0+
YWRkci5idXN3aWR0aDsNCj4gPiArCQlzcGlfc2V0X3hmZXJfYnB3KGN0bHIsICZ4ZmVyc1t4ZmVy
cG9zXSk7DQo+ID4gIAkJc3BpX21lc3NhZ2VfYWRkX3RhaWwoJnhmZXJzW3hmZXJwb3NdLCAmbXNn
KTsNCj4gPiAgCQl4ZmVycG9zKys7DQo+ID4gIAkJdG90YWx4ZmVybGVuICs9IG9wLT5hZGRyLm5i
eXRlczsNCj4gPiBAQCAtMjc2LDYgKzMxMyw3IEBAIGludCBzcGlfbWVtX2V4ZWNfb3Aoc3RydWN0
IHNwaV9tZW0gKm1lbSwgY29uc3QNCj4gc3RydWN0IHNwaV9tZW1fb3AgKm9wKQ0KPiA+ICAJCXhm
ZXJzW3hmZXJwb3NdLnR4X2J1ZiA9IHRtcGJ1ZiArIG9wLT5hZGRyLm5ieXRlcyArIDE7DQo+ID4g
IAkJeGZlcnNbeGZlcnBvc10ubGVuID0gb3AtPmR1bW15Lm5ieXRlczsNCj4gPiAgCQl4ZmVyc1t4
ZmVycG9zXS50eF9uYml0cyA9IG9wLT5kdW1teS5idXN3aWR0aDsNCj4gPiArCQlzcGlfc2V0X3hm
ZXJfYnB3KGN0bHIsICZ4ZmVyc1t4ZmVycG9zXSk7DQo+ID4gIAkJc3BpX21lc3NhZ2VfYWRkX3Rh
aWwoJnhmZXJzW3hmZXJwb3NdLCAmbXNnKTsNCj4gPiAgCQl4ZmVycG9zKys7DQo+ID4gIAkJdG90
YWx4ZmVybGVuICs9IG9wLT5kdW1teS5uYnl0ZXM7DQo+ID4gQEAgLTI5MSw2ICszMjksNyBAQCBp
bnQgc3BpX21lbV9leGVjX29wKHN0cnVjdCBzcGlfbWVtICptZW0sIGNvbnN0DQo+IHN0cnVjdCBz
cGlfbWVtX29wICpvcCkNCj4gPiAgCQl9DQo+ID4NCj4gPiAgCQl4ZmVyc1t4ZmVycG9zXS5sZW4g
PSBvcC0+ZGF0YS5uYnl0ZXM7DQo+ID4gKwkJc3BpX3NldF94ZmVyX2JwdyhjdGxyLCAmeGZlcnNb
eGZlcnBvc10pOw0KPiA+ICAJCXNwaV9tZXNzYWdlX2FkZF90YWlsKCZ4ZmVyc1t4ZmVycG9zXSwg
Jm1zZyk7DQo+ID4gIAkJeGZlcnBvcysrOw0KPiA+ICAJCXRvdGFseGZlcmxlbiArPSBvcC0+ZGF0
YS5uYnl0ZXM7DQoNCg==
