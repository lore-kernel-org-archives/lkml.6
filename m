Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44519C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E285F2173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IN+eLt50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E285F2173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbeI1NWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:22:22 -0400
Received: from mail-eopbgr10051.outbound.protection.outlook.com ([40.107.1.51]:44010
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729040AbeI1NWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAiVxaC/lPe6i57p9N+A3F5APZeEYn74TbJlCR7chPw=;
 b=IN+eLt50SvGiEzAqg4U003o5DFAKv4Wgw8HP/lBI1GaGMlu6CfYm+HtDXILjTK7rY/fCRQlryyOVoZBw0qObriVumu7N2KDvb0SfBfBJAY29CmR9RX78TfXu2YtcMdXugm8Oe8G75cey2+cCaGV8W25Q5o31vvURhEnRxhmhfaw=
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com (52.135.167.33) by
 AM6PR04MB4949.eurprd04.prod.outlook.com (20.177.33.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Fri, 28 Sep 2018 06:59:58 +0000
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::e955:4d48:f0eb:3fe]) by AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::e955:4d48:f0eb:3fe%2]) with mapi id 15.20.1143.022; Fri, 28 Sep 2018
 06:59:58 +0000
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>
Subject: RE: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Thread-Topic: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Thread-Index: AQHUUXmVvI4Eamit80qkSTJAtq5nJ6UFSniAgAAAtKA=
Date:   Fri, 28 Sep 2018 06:59:58 +0000
Message-ID: <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
 <20180928084431.300b7bf9@bbrezillon>
In-Reply-To: <20180928084431.300b7bf9@bbrezillon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chuanhua.han@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4949;6:AuleV5a3a0ldU06qxSuqs+ErgPZHO5KXPP9NTCtpUrxKUg0+rVhPbqy6ZC9fUoXT71njA8Vi7s8QP3wlRIjRaBO/asR8RiXNyuDv+0/nYT30CaiWSp6byoW8/34dM+b9+MTfiRd/oLm55bR7v4sOYPn1KqWZrWBzYaiOrJjwoj3itBScboeQamls897hAzoAu+FDCltZF6RJPHXMwJPOVR1CInDxTD6Xj99AXUXD8OLrUlKYBlpbT7Xuh7pCtlv11wMySys3kptnpYH3zlvMZ9K87I4znBNRHuntfiCwRX/4A0em7CJfFhvD26iDiVWP85SffUEcgOJ0q1az1hpLuVMI32E1zyQS8yH4+qOYeC54bJ7oKyKLPQOp+JQph84g4C9mjflrU8VbRJZOIjUWGNfVOyOnX8axg7r0l98O/iHl87iehxH7P/fiSEe/oYzhZmBUeXCDK4ViDgoeexpPMA==;5:bKDf/0JDYMSqLrn6tTba5tf/52Kyebd5DyfHK0mYmUdZeOly6tgY1Pqehe0jtkxSZEP1yN+U5H+fz9fspxzmF2BcWDdAhPPTTxdoa3abb7H3o8JQnn3rHCoZ3CzzF7NisCSoD4nqBSpfqW+LYPEDeLYIAwebpyvAQqhsWgJKwig=;7:BxuTySWDXWxZ3ECX4dFUNo9+jHB4helNe3sLWxuJEGWDSYexqQEjzOksUjPtQ+P+ylAqurvunzBJ79AzX8c8ExxMslDIWgav6G0S5jAJAsah7kZWiMIzNkhvHmXOXr6ARxTCPn56PZ17LXKkkejzeC/twnLBIdfNCZIwe66lHU/LIivjHB/y+86N000sMjHrLP4C98uGfVAeFN7NUSYXua1QxmwK2VtX5lkoNyXO37qBSZpyGRfehaxom8ZPT5/X
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e1b78a4f-62a6-4b0b-fab1-08d6251000be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4949;
x-ms-traffictypediagnostic: AM6PR04MB4949:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR04MB4949974E7E94BC80D81C45BA97EC0@AM6PR04MB4949.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:AM6PR04MB4949;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4949;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(136003)(39860400002)(396003)(13464003)(199004)(189003)(8936002)(26005)(8676002)(33656002)(81166006)(6506007)(6116002)(3846002)(5250100002)(186003)(256004)(76176011)(44832011)(14444005)(102836004)(476003)(34290500001)(99286004)(11346002)(81156014)(446003)(54906003)(97736004)(14454004)(66066001)(486006)(2900100001)(478600001)(6436002)(53546011)(7696005)(5660300001)(7736002)(2906002)(86362001)(74316002)(9686003)(6916009)(55016002)(68736007)(71190400001)(25786009)(106356001)(229853002)(71200400001)(105586002)(53936002)(4326008)(305945005)(6246003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4949;H:AM6PR04MB4357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 11bR+584t+TH2/varX7HvBxDRuhndxev3c1QA2DCd/yiAd22lbzSvDvLP3LUgiBp82lZ2Byg79u80ceJjhRoKpueekpM7QKVHh6qFexCOOsZX8y8EQUv6Xm4Gm1J0pxTALohaEZ8VO9b57LQ7wqcGhmAaygDfaJJt2RGqOWnWpSV9yc78RknvkSdtv2/8UE+h+Va0A8X5lmJl7b3U5en4dABO2taIZ4R3fnkmlHZLwQlC0NwxW9Ph+vbmR7Z8foUibFmfQUMvIyVvKm6Sf7Sa8IeTIMl+6G/zqZMxIQhdbBJCi4DI1tPK+hbNvZQAHI/2BWZfe2v0alNA2EdimHQMTOGf+q85f0WfyPMivEh1Jg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b78a4f-62a6-4b0b-fab1-08d6251000be
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 06:59:58.1053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4949
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SEksQm9yaXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXMg
QnJlemlsbG9uIDxib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+DQo+IFNlbnQ6IDIwMTjE6jnU
wjI4yNUgMTQ6NDUNCj4gVG86IENodWFuaHVhIEhhbiA8Y2h1YW5odWEuaGFuQG54cC5jb20+DQo+
IENjOiBicm9vbmllQGtlcm5lbC5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGVoYUBkZWlmLmNvbQ0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIDEvMl0gc3BpOiBzcGktbWVtOiBBZGQgdGhlIHNwaV9zZXRfeGZlcl9icHcgZnVuY3Rp
b24NCj4gDQo+IEhpIENodWFuaHVhLA0KPiANCj4gT24gRnJpLCAyMSBTZXAgMjAxOCAxNTowNjoy
NiArMDgwMA0KPiBDaHVhbmh1YSBIYW4gPGNodWFuaHVhLmhhbkBueHAuY29tPiB3cm90ZToNCj4g
DQo+ID4gQmVmb3JlIHdlIGFkZCB0aGlzIHNwaV90cmFuc2ZlciB0byB0aGUgc3BpX21lc3NhZ2Ug
Y2hhaW4gdGFibGUsIHdlDQo+ID4gbmVlZCBiaXRzX3Blcl93b3JkX21hc2sgYmFzZWQgb24gc3Bp
X2NvbnRyb2wgdG8gc2V0IHRoZSBiaXRzX3Blcl93b3JkDQo+ID4gb2YgdGhpcyBzcGlfdHJhbnNm
ZXIuDQo+IA0KPiBJdCdzIG5vdCBjbGVhciB0byBtZSB3aGF0IHlvdSdyZSB0cnlpbmcgdG8gZml4
L2ltcHJvdmUuIENhbiB5b3UgZ2l2ZSBtb3JlDQo+IGRldGFpbHMgb24gd2hhdCB0aGUgcHJvYmxl
bSBpcz8NCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVhbmh1YSBIYW4gPGNodWFuaHVh
LmhhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3NwaS9zcGktbWVtLmMgfCAzOQ0K
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDM5IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Nw
aS9zcGktbWVtLmMgYi9kcml2ZXJzL3NwaS9zcGktbWVtLmMgaW5kZXgNCj4gPiBlYjcyZGJhNzFk
ODMuLjcxN2U3MTFjMDk1MiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktbWVtLmMN
Cj4gPiArKysgYi9kcml2ZXJzL3NwaS9zcGktbWVtLmMNCj4gPiBAQCAtMTc1LDYgKzE3NSw0MSBA
QCBib29sIHNwaV9tZW1fc3VwcG9ydHNfb3Aoc3RydWN0IHNwaV9tZW0NCj4gKm1lbSwNCj4gPiBj
b25zdCBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3ApICB9DQo+ID4gRVhQT1JUX1NZTUJPTF9HUEwoc3Bp
X21lbV9zdXBwb3J0c19vcCk7DQo+ID4NCj4gPiArLyoqDQo+ID4gKyAqIHNwaV9zZXRfeGZlcl9i
cHcoKSAtIFNldCB0aGUgYml0c19wZXJfd29yZCBmb3IgZWFjaCB0cmFuc2ZlciBiYXNlZCBvbg0K
PiA+ICsgKgkJCXRoZSBiaXRzX3Blcl93b3JkX21hc2sgb2YgdGhlIHNwaSBjb250cm9sbGVyDQo+
ID4gKyAqIEBjdHJsOiB0aGUgc3BpIGNvbnRyb2xsZXINCj4gPiArICogQHhmZXI6IHRoZSBzcGkg
dHJhbnNmZXINCj4gPiArICoNCj4gPiArICogVGhpcyBmdW5jdGlvbiBzZXRzIHRoZSBiaXRzX3Bl
cl93b3JkIGZvciBlYWNoIHRyYW5zZmVyIGJhc2VkIG9uDQo+ID4gK3RoZSBzcGkNCj4gPiArICog
Y29udHJvbGxlcidzIGJpdHNfcGVyX3dvcmRfbWFzayB0byBpbXByb3ZlIHRoZSBlZmZpY2llbmN5
IG9mIHNwaQ0KPiB0cmFuc3BvcnQuDQo+ID4gKyAqDQo+ID4gKyAqIFJldHVybjogMCBpbiBjYXNl
IG9mIHN1Y2Nlc3MsIGEgbmVnYXRpdmUgZXJyb3IgY29kZSBvdGhlcndpc2UuDQo+ID4gKyAqLw0K
PiA+ICtpbnQgc3BpX3NldF94ZmVyX2JwdyhzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0bHIsIHN0
cnVjdCBzcGlfdHJhbnNmZXINCj4gPiArKnhmZXIpIHsNCj4gPiArCWlmICghY3RsciB8fCAheGZl
cikgew0KPiA+ICsJCWRldl9lcnIoJmN0bHItPmRldiwNCj4gPiArCQkJIkZhaWwgdG8gc2V0IGJp
dHNfcGVyX3dvcmQgZm9yIHNwaSB0cmFuc2ZlclxuIik7DQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKGN0bHItPmJpdHNfcGVyX3dvcmRfbWFzaykgew0K
PiA+ICsJCWlmICghKHhmZXItPmxlbiAlIDQpKSB7DQo+ID4gKwkJCWlmIChjdGxyLT5iaXRzX3Bl
cl93b3JkX21hc2sgJiBTUElfQlBXX01BU0soMzIpKQ0KPiA+ICsJCQkJeGZlci0+Yml0c19wZXJf
d29yZCA9IDMyOw0KPiA+ICsJCX0gZWxzZSBpZiAoISh4ZmVyLT5sZW4gJSAyKSkgew0KPiA+ICsJ
CQlpZiAoY3Rsci0+Yml0c19wZXJfd29yZF9tYXNrICYgU1BJX0JQV19NQVNLKDE2KSkNCj4gPiAr
CQkJCXhmZXItPmJpdHNfcGVyX3dvcmQgPSAxNjsNCj4gPiArCQl9IGVsc2Ugew0KPiA+ICsJCQl4
ZmVyLT5iaXRzX3Blcl93b3JkID0gODsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJ
cmV0dXJuIDA7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTF9HUEwoc3BpX3NldF94ZmVyX2Jw
dyk7DQo+IA0KPiBXaHkgaXMgdGhpcyBmdW5jdGlvbiBwbGFjZWQgaW4gc3BpLW1lbS5jLCBhbmQg
bW9yZSBpbXBvcnRhbnRseSwgd2h5IGlzIGl0DQo+IGV4cG9ydGVkPw0KU2luY2UgYml0c19wZXJf
d29yZCBpcyBub3QganVkZ2VkIGJ5IHNwaSBldmVyeSB0aW1lIGl0IGlzIHRyYW5zbWl0dGVkLCB0
aGUgY29kZSBkZWZhdWx0cyB0byBiaXRzX3Blcl93b3JkPTggc28gdGhhdCBiaXRzX3Blcl93b3Jk
IGNhbm5vdCBiZSBpbXBsZW1lbnRlZCBpZiBpdCB3YW50cyB0byB0cmFuc2ZlciBhIHNwZWNpZmlj
IHNwaSBjb250cm9sbGVyLCBzbyBpdCBpcyBmbGV4aWJsZSB0byBhc3NpZ24gYml0c19wZXJfd29y
ZCBhY2NvcmRpbmcgdG8gdGhlIHNwaSBjb250cm9sbGVyJ3MgYml0c19wZXJfd29yZF9tYXNrIGJl
Zm9yZSBlYWNoIHRyYW5zZmVyIHNwaS4gQWgsIGZvciB3aGljaCBleHBvcnQsIHRoZXJlIGlzIHJl
YWxseSBubyBuZWVkIHRvIGRlbGliZXJhdGVseSByZW1vdmUuDQo+IA0KPiA+ICsNCj4gPiAgLyoq
DQo+ID4gICAqIHNwaV9tZW1fZXhlY19vcCgpIC0gRXhlY3V0ZSBhIG1lbW9yeSBvcGVyYXRpb24N
Cj4gPiAgICogQG1lbTogdGhlIFNQSSBtZW1vcnkNCj4gPiBAQCAtMjUyLDYgKzI4Nyw3IEBAIGlu
dCBzcGlfbWVtX2V4ZWNfb3Aoc3RydWN0IHNwaV9tZW0gKm1lbSwgY29uc3QNCj4gc3RydWN0IHNw
aV9tZW1fb3AgKm9wKQ0KPiA+ICAJeGZlcnNbeGZlcnBvc10udHhfYnVmID0gdG1wYnVmOw0KPiA+
ICAJeGZlcnNbeGZlcnBvc10ubGVuID0gc2l6ZW9mKG9wLT5jbWQub3Bjb2RlKTsNCj4gPiAgCXhm
ZXJzW3hmZXJwb3NdLnR4X25iaXRzID0gb3AtPmNtZC5idXN3aWR0aDsNCj4gPiArCXNwaV9zZXRf
eGZlcl9icHcoY3RsciwgJnhmZXJzW3hmZXJwb3NdKTsNCj4gDQo+IEl0J3Mgc3RpbGwgdW5jbGVh
ciB3aHkgeW91IG5lZWQgdG8gc3BlY2lmeSBhIGJpdHNfcGVyX3dvcmQgdmFsdWUsIGJ1dCBpZiB0
aGlzIGlzDQo+IG5lZWRlZCwgaXQncyBwcm9iYWJseSBzb21ldGhpbmcgeW91IHdhbnQgdG8gYWRk
IHRvIHNwaS5jLCB3aGVuIGEgbWVzc2FnZSBpcw0KPiBxdWV1ZWQuDQpUbyBzcGVjaWZ5IGEgc3Bl
Y2lmaWMgYml0c19wZXJfd29yZCB0byBiZSBhYmxlIHRvIHVzZSB0aGUgeHNwaSAoMzJiaXQpIG1v
ZGUgb2YgdGhlIGZzbF9kc3BpIG1vZHVsZSB0byB0cmFuc2ZlciBkYXRhLCB5b3UgY2FuIGxvb2sg
YXQgbXkgUEFUQ0ggMi8yLg0KIERvIG5vdCBhZGQgYSB2YWx1ZSBpbiBzcGlzLmMgdGhhdCB0YWtl
cyBpbnRvIGFjY291bnQgdGhhdCB0aGUgdmFsdWUgYXNzaWduZWQgdG8gYml0c19wZXJfd29yZCBp
cyBkZWNpZGVkIGJlZm9yZSB0aGUgdHJhbnNmZXIuIFRoYW5rcyBmb3IgeW91ciBjaGVjayBhbmQg
cmVwbHkhDQo+IA0KPiA+ICAJc3BpX21lc3NhZ2VfYWRkX3RhaWwoJnhmZXJzW3hmZXJwb3NdLCAm
bXNnKTsNCj4gPiAgCXhmZXJwb3MrKzsNCj4gPiAgCXRvdGFseGZlcmxlbisrOw0KPiA+IEBAIC0y
NjYsNiArMzAyLDcgQEAgaW50IHNwaV9tZW1fZXhlY19vcChzdHJ1Y3Qgc3BpX21lbSAqbWVtLCBj
b25zdA0KPiBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3ApDQo+ID4gIAkJeGZlcnNbeGZlcnBvc10udHhf
YnVmID0gdG1wYnVmICsgMTsNCj4gPiAgCQl4ZmVyc1t4ZmVycG9zXS5sZW4gPSBvcC0+YWRkci5u
Ynl0ZXM7DQo+ID4gIAkJeGZlcnNbeGZlcnBvc10udHhfbmJpdHMgPSBvcC0+YWRkci5idXN3aWR0
aDsNCj4gPiArCQlzcGlfc2V0X3hmZXJfYnB3KGN0bHIsICZ4ZmVyc1t4ZmVycG9zXSk7DQo+ID4g
IAkJc3BpX21lc3NhZ2VfYWRkX3RhaWwoJnhmZXJzW3hmZXJwb3NdLCAmbXNnKTsNCj4gPiAgCQl4
ZmVycG9zKys7DQo+ID4gIAkJdG90YWx4ZmVybGVuICs9IG9wLT5hZGRyLm5ieXRlczsNCj4gPiBA
QCAtMjc2LDYgKzMxMyw3IEBAIGludCBzcGlfbWVtX2V4ZWNfb3Aoc3RydWN0IHNwaV9tZW0gKm1l
bSwgY29uc3QNCj4gc3RydWN0IHNwaV9tZW1fb3AgKm9wKQ0KPiA+ICAJCXhmZXJzW3hmZXJwb3Nd
LnR4X2J1ZiA9IHRtcGJ1ZiArIG9wLT5hZGRyLm5ieXRlcyArIDE7DQo+ID4gIAkJeGZlcnNbeGZl
cnBvc10ubGVuID0gb3AtPmR1bW15Lm5ieXRlczsNCj4gPiAgCQl4ZmVyc1t4ZmVycG9zXS50eF9u
Yml0cyA9IG9wLT5kdW1teS5idXN3aWR0aDsNCj4gPiArCQlzcGlfc2V0X3hmZXJfYnB3KGN0bHIs
ICZ4ZmVyc1t4ZmVycG9zXSk7DQo+ID4gIAkJc3BpX21lc3NhZ2VfYWRkX3RhaWwoJnhmZXJzW3hm
ZXJwb3NdLCAmbXNnKTsNCj4gPiAgCQl4ZmVycG9zKys7DQo+ID4gIAkJdG90YWx4ZmVybGVuICs9
IG9wLT5kdW1teS5uYnl0ZXM7DQo+ID4gQEAgLTI5MSw2ICszMjksNyBAQCBpbnQgc3BpX21lbV9l
eGVjX29wKHN0cnVjdCBzcGlfbWVtICptZW0sIGNvbnN0DQo+IHN0cnVjdCBzcGlfbWVtX29wICpv
cCkNCj4gPiAgCQl9DQo+ID4NCj4gPiAgCQl4ZmVyc1t4ZmVycG9zXS5sZW4gPSBvcC0+ZGF0YS5u
Ynl0ZXM7DQo+ID4gKwkJc3BpX3NldF94ZmVyX2JwdyhjdGxyLCAmeGZlcnNbeGZlcnBvc10pOw0K
PiA+ICAJCXNwaV9tZXNzYWdlX2FkZF90YWlsKCZ4ZmVyc1t4ZmVycG9zXSwgJm1zZyk7DQo+ID4g
IAkJeGZlcnBvcysrOw0KPiA+ICAJCXRvdGFseGZlcmxlbiArPSBvcC0+ZGF0YS5uYnl0ZXM7DQoN
Cg==
