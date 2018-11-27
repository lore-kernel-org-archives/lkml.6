Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72DDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9822086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BJCUJrUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9822086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbeK0TEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:04:53 -0500
Received: from mail-eopbgr10051.outbound.protection.outlook.com ([40.107.1.51]:53706
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727574AbeK0TEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39e3m9eQY1nq7xFGYh3vlsvPwzcoQwuJC8tgk7axfec=;
 b=BJCUJrUxOjv3op7Zum38nYSrdkW/ej05dV89HINjB5sHF4B4vb57rCHtyONslbz/9iAsWvCx2R2SYdYVJVFDLWFoZDpt2KaWDTCYK6Yf6bpYOnxuMW2CxHAs1gBXBoAEokicDNAcCzNg0rm/kLEcOPyMiq8xa3OvAGbI+xJH3Yc=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5268.eurprd04.prod.outlook.com (20.177.42.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Tue, 27 Nov 2018 08:07:43 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::31e3:2aa6:8d93:9927%2]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 08:07:43 +0000
From:   Aisheng DONG <aisheng.dong@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] can: flexcan: Implement CAN Runtime PM
Thread-Topic: [PATCH] can: flexcan: Implement CAN Runtime PM
Thread-Index: AQHUZ5CBGViPzGvSBkmCEccitD7z+6VagACAgAjzfCCAAAmWAIAAAzhw
Date:   Tue, 27 Nov 2018 08:07:43 +0000
Message-ID: <AM0PR04MB421185C8A83EE9549052A91180D00@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20181019094326.28185-1-qiangqing.zhang@nxp.com>
 <24a43a20-7302-c449-06b3-5ee8f6c051a0@pengutronix.de>
 <DB7PR04MB461851E4A4C494E8AC91AAEEE6D00@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <7449a067-e9b2-5cdf-7fae-9b9d5acdac87@pengutronix.de>
In-Reply-To: <7449a067-e9b2-5cdf-7fae-9b9d5acdac87@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5268;6:g2R0VNWnprfR8S8Hx3qe9W4IwhQFltjM7WXLcoE94hZrp3awdkN9Y//2rQpya4zmcho9CpwP+d6l10EvXzSKXErAWJG2YVgXXHqUYX5jp+UC7uIbeGo1EjK2N0W5kStwAW/Yz3Ti6ePi40iRsA4GyNGD3IjdZVuXpBILW90d897dDev5d57jBNEMo7CgUUDJsSnoRIIUKUfztkS4nNZpT56tlZtsdRv5tuCGZxnnfIw/2XPPoIMr8Gy1PxDC7QXqqu8IF+eq4iEffyag6sx9RWy7gAyGGNZRsIbkRWGL9CFtoJ1ix4+oMM/FkLrJF+Q4YK5Kx39/GNNnyDOm06650wdX8/EKh2a7IN7VVIlviQgmczuFAErlwCP6fdQ65G+AFu5TThS61+7/3+2XlVFvWq5v6g8XTCjntlN0ukqerfOi8v+UdyT66vAUZBs18ANmzBA4GLhTUD6wiY6V1rHMOw==;5:1TSl01jpvlSiRDSjiCkYdrJA8RJufMI1pjDT3LV7djw8DbNqf/z8CLdIaOUlooxbejNQe2k7EK7rHyJrSvfVc/XLQY3+VUI8gGdRMuwjcsl7qC0QqVM1CTqoag/Ku/h9Oapv1d2BIJhzEIh/mCgTq2Y853mR32qXDVu0NxbpnT4=;7:OJ9wbV72Ng6DIrh7bH1ZDENblTM/fZ4LOEEvFq+PiASGx0AYIA+UvUKOf7mlvj46/zfdO8b2073y/hZfrj88xd+WUSH8RoaIBv0iYbcKV0WK3UW0ciyUBrXj1HRYUW2ZX2pYNo58JI82lpjwZqmbuA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4477319d-fe99-4f00-e2ab-08d6543f68c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5268;
x-ms-traffictypediagnostic: AM0PR04MB5268:
x-microsoft-antispam-prvs: <AM0PR04MB52687BF9297BF9C7FFEC3F3A80D00@AM0PR04MB5268.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231443)(944501410)(4982022)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5268;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5268;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(396003)(39860400002)(23433003)(13464003)(189003)(199004)(14444005)(256004)(316002)(8676002)(478600001)(14454004)(45080400002)(6116002)(8936002)(476003)(4326008)(68736007)(6246003)(11346002)(3846002)(446003)(99286004)(229853002)(66066001)(9686003)(93886005)(2906002)(2201001)(6436002)(966005)(575784001)(81156014)(81166006)(6306002)(71190400001)(71200400001)(86362001)(76176011)(33656002)(105586002)(7736002)(305945005)(5660300001)(7696005)(186003)(486006)(102836004)(6506007)(53936002)(26005)(2501003)(97736004)(106356001)(55016002)(25786009)(54906003)(74316002)(110136005)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5268;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZxOd5LY7AroRAaQH5vQM0BHPrSQlYEVtEn2eageudS2jvBWzDjg+BCqZ6zqQcJWpI8EIuaSZSJ9pznmIuCDt8zW4axehsO/H1JEB6pbKSefLMpBDXyKSq8Sxf3ZIc5o52yrwKN3xxx4tNNrpl3+q7r2mY9BsywSYFoVGjEAcmGuxG9ZT/2s/FX2aLXQrH0BpCe4t9jApljUyyeIHAaUa2JK3YauIwGIYcrnL6Tu7AH31NXQHIu2sl9c0phpOBUUrG8uBr7Qi0rnTqv2JnwMolVT+vpXuXmKWx8+xHNZ2v9oy0djlySY7Q1p+G89Q/v4PFi2hxiaacWkCC3o543zy2mcucFm5CJE9xX58slRo0WQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4477319d-fe99-4f00-e2ab-08d6543f68c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 08:07:43.6037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5268
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSBb
bWFpbHRvOm1rbEBwZW5ndXRyb25peC5kZV0NCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMjcs
IDIwMTggMzo1MiBQTQ0KPiBUbzogSm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNv
bT47IHdnQGdyYW5kZWdnZXIuY29tOw0KPiBkYXZlbUBkYXZlbWxvZnQubmV0DQo+IENjOiBsaW51
eC1jYW5Admdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsg
QWlzaGVuZw0KPiBET05HIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gY2FuOiBmbGV4Y2FuOiBJbXBsZW1lbnQgQ0FOIFJ1bnRpbWUgUE0NCj4gDQo+IE9uIDEx
LzI3LzE4IDg6NDQgQU0sIEpvYWtpbSBaaGFuZyB3cm90ZToNCj4gPj4+IEZsZXhjYW4gd2lsbCBi
ZSBkaXNhYmxlZCBkdXJpbmcgc3VzcGVuZCBpZiBubyB3YWtldXAgZnVuY3Rpb24NCj4gPj4+IHJl
cXVpcmVkIGFuZCBlbmFibGVkIGFmdGVyIHJlc3VtZSBhY2NvcmRpbmdseS4gRHVyaW5nIHRoaXMg
cGVyaW9kLA0KPiA+Pj4gd2UgY291bGQgZXhwbGljaXRseSBkaXNhYmxlIGNsb2Nrcy4NCj4gPj4+
DQo+ID4+PiBJbXBsZW1lbnQgUnVudGltZSBQTSB3aGljaCB3aWxsOg0KPiA+Pj4gMSkgS2VlcCBk
ZXZpY2UgaW4gc3VzcGVuZCBzdGF0ZSAoY2xvY2tzIGRpc2FibGVkKSBpZiBpdCdzIG5vdA0KPiA+
Pj4gb3Blbm5lZA0KPiA+Pj4gMikgTWFrZSBQb3dlciBEb21haW4gZnJhbWV3b3JrIGJlIGFibGUg
dG8gc2h1dGRvd24gdGhlIGNvcnJlc3BvbmRpbmcNCj4gPj4+IHBvd2VyIGRvbWFpbiBvZiB0aGlz
IGRldmljZS4NCj4gPj4NCj4gPj4gV2l0aG91dCBDT05GSUdfUE0gdGhlIGRldmljZSBmYWlscyB0
byBwcm9iZToNCj4gPj4NCj4gPj4+IFsgIDIxNC40MjA2MDZdIGZsZXhjYW4gMjA5MDAwMC5mbGV4
Y2FuOiAyMDkwMDAwLmZsZXhjYW4gc3VwcGx5DQo+ID4+PiB4Y2VpdmVyIG5vdCBmb3VuZCwgdXNp
bmcgZHVtbXkgcmVndWxhdG9yIFsgIDIxNC40NDU5NTJdIGZsZXhjYW4NCj4gPj4+IDIwOTAwMDAu
ZmxleGNhbjogTGlua2VkIGFzIGEgY29uc3VtZXIgdG8gcmVndWxhdG9yLjAgWyAgMjE0LjQ1MzQ0
OF0NCj4gPj4+IGZsZXhjYW4gMjA5MDAwMC5mbGV4Y2FuOiByZWdpc3RlcmluZyBuZXRkZXYgZmFp
bGVkIFsgIDIxNC40NTk2NjZdDQo+ID4+PiBmbGV4Y2FuIDIwOTAwMDAuZmxleGNhbjogRHJvcHBp
bmcgdGhlIGxpbmsgdG8gcmVndWxhdG9yLjAgWw0KPiA+Pj4gMjE0LjQ3MjA2Nl0gZmxleGNhbjog
cHJvYmUgb2YgMjA5MDAwMC5mbGV4Y2FuIGZhaWxlZCB3aXRoIGVycm9yIC0xMTANCj4gDQo+ID4g
SSB3b3VsZCBzZW50IFYyIHJlYmFzZWQgb24gcGF0Y2ggImNhbjogZmxleGNhbjogYWRkIHNlbGYg
d2FrZXVwDQo+ID4gc3VwcG9ydCIsIGFuZCBydW50aW1lIHBtIHdvcmtzIG5vcm1hbGx5IG9uIE1Y
NlNYLVNEQiBhbmQgTVg3RC1TREIuDQo+ID4gU28sIGNvdWxkIHlvdSB0ZWxsIG1lIHdoaWNoIGJv
YXJkIHlvdSB0ZXN0ZWQgb24gdGhhdCBjYXVzZXMgdGhlIGRldmljZQ0KPiA+IHByb2JlIGZhaWxl
ZD8NCj4gDQo+IEkgdGVzdGVkIG9uIGFuIGlteDZkbCByaW90Ym9hcmQNCj4gKGh0dHBzOi8vZW1l
YTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZl
bGl4aXIuDQo+IGJvb3RsaW4uY29tJTJGbGludXglMkZsYXRlc3QlMkZzb3VyY2UlMkZhcmNoJTJG
YXJtJTJGYm9vdCUyRmR0cyUyRmkNCj4gbXg2ZGwtcmlvdGJvYXJkLmR0cyZhbXA7ZGF0YT0wMiU3
QzAxJTdDYWlzaGVuZy5kb25nJTQwbnhwLmNvbSU3QzgNCj4gNGNmZDNmM2EwOGI0Yzc5NTNmZDA4
ZDY1NDNkNDJjMSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNg0KPiAzNSU3QzAlN0Mw
JTdDNjM2Nzg5MDE5NDIwNTY5NTM0JmFtcDtzZGF0YT1ydWdLcG1WYU5uMGFqVGRjdHlpJQ0KPiAy
RiUyQm53ciUyRnFxSUJjaWtBUDdlWExwNmZjQSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiArIHBhdGNo
ZXMgdG8gZW5hYmxlIENBTjEpIHdpdGggYW4gZXh0ZXJuYWwgUEhZLg0KPiANCj4gPiBBbmQgdGhh
dCBDT05GSUdfUE0gaGFzIHNldCBpbiBpbXhfdjZfdjdfZGVmY29uZmlnIHdoaWNoIGNvbmZpZyBm
aWxlIEkNCj4gdXNlZC4NCj4gDQo+IEkgZGlzYWJsZWQgQ09ORklHX1BNIG9uIHB1cnBvc2UuDQoN
CkpvYWtpbSwNCllvdSBuZWVkIHJ1biB0aGUgc2FtZSB0ZXN0IGFzIE1hcmMuDQoNCkkgZ3Vlc3Mg
SXQgbWlnaHQgYmVjYXVzZSB3aXRob3V0IENPTkZJR19QTSwgUnVudGltZSBQTSBBUEkNClNpbXBs
eSByZXR1cm4gcG9zaXRpdmUgYnV0IHRoZSBjbG9jayBtYXkgc3RpbGwgbm90IGVuYWJsZWQsIHRo
dXMgY2F1c2UNCmEgQ0FOIGVuYWJsZSB0aW1lb3V0Lg0KDQpZb3UgY2FuIGNoZWNrIGl0Lg0KDQpS
ZWdhcmRzDQpEb25nIEFpc2hlbmcNCg0KPiANCj4gTWFyYw0KPiANCj4gLS0NCj4gUGVuZ3V0cm9u
aXggZS5LLiAgICAgICAgICAgICAgICAgIHwgTWFyYyBLbGVpbmUtQnVkZGUgICAgICAgICAgIHwN
Cj4gSW5kdXN0cmlhbCBMaW51eCBTb2x1dGlvbnMgICAgICAgIHwgUGhvbmU6ICs0OS0yMzEtMjgy
Ni05MjQgICAgIHwNCj4gVmVydHJldHVuZyBXZXN0L0RvcnRtdW5kICAgICAgICAgIHwgRmF4OiAg
ICs0OS01MTIxLTIwNjkxNy01NTU1IHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2
ODYgIHwNCj4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwJTNBJTJGJTJGd3d3Lg0KPiBwZW5ndXRyb25peC5kZSZhbXA7ZGF0YT0wMiU3QzAx
JTdDYWlzaGVuZy5kb25nJTQwbnhwLmNvbSU3Qzg0Y2ZkMw0KPiBmM2EwOGI0Yzc5NTNmZDA4ZDY1
NDNkNDJjMSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTcNCj4gQzAlN0MwJTdD
NjM2Nzg5MDE5NDIwNTY5NTM0JmFtcDtzZGF0YT1VczZjTzlRZllrdyUyQjZOaGo2OHpMcg0KPiB3
ck54VUNSamNDMFdEZG1yOU1PekhNJTNEJmFtcDtyZXNlcnZlZD0wICAgfA0K
