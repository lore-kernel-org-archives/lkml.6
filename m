Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3C6ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9B5208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qDfq27TE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9B5208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeGMJUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:20:43 -0400
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:26882
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbeGMJUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5ltks5e9xQgy+sb8q17WSCT9jtXRdWeqDTYNRp+97g=;
 b=qDfq27TEhaepQ+aisCLuRrISKoZffchwPlduaCMxViiBo26Nwc1H/UD0hC3swj1wCEtb5yFaDAOUiJvuUi80NwmMjITF0Xoqp6GdsIRObWxuM9Pu8p3no1LaiDWulwLgLK19m+RAnMjoYokmcA3kfa0JTlPFEsJJl/ar0U0gtZI=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB1394.eurprd04.prod.outlook.com (10.163.185.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Fri, 13 Jul 2018 09:06:55 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%7]) with mapi id 15.20.0952.017; Fri, 13 Jul 2018
 09:06:55 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Marek Vasut <marex@denx.de>, "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] drm: mxsfb: fix runtime PM handling
Thread-Topic: [PATCH] drm: mxsfb: fix runtime PM handling
Thread-Index: AQHUGofRmMxulp8rKEm6VKR8ciiJ3aSM25uAgAAAQpA=
Date:   Fri, 13 Jul 2018 09:06:55 +0000
Message-ID: <AM3PR04MB1315E2F345752D0A64A0E2C8F5580@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1531472085-25174-1-git-send-email-Anson.Huang@nxp.com>
 <ea029b69-f853-4a5f-e798-70a04b02ac1d@denx.de>
In-Reply-To: <ea029b69-f853-4a5f-e798-70a04b02ac1d@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1394;7:nA/iK8TqbYOSeIHhF9POSVMXNcr9DN53chzjDBk9+fcyKhBNwOp8GASorphjowhDlOqG6+d7kTmpeKBaO0gtnqF0RvEV6e56MwMQ7fuROlpJacISbC+Y8dnIxp4nGL/ZTfBK/vYyO/cdv+74aCxUJd8v0jg0XmmQojvPUu8RIB5m46uaP2GEDja9s1peb+Q1zM6sLMfzKfmI7yLbqQrQJ3NA8i4e3qJl0meSzIqg6dxW5ra/kRlhWBGUgw/I1abN
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c5311498-14d4-46a1-d47a-08d5e89ffb13
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1394;
x-ms-traffictypediagnostic: AM3PR04MB1394:
x-microsoft-antispam-prvs: <AM3PR04MB1394D9192521FEE0E9855E1CF5580@AM3PR04MB1394.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(217544274631240);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1394;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1394;
x-forefront-prvs: 07326CFBC4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(376002)(136003)(346002)(13464003)(189003)(199004)(186003)(5250100002)(11346002)(446003)(44832011)(476003)(26005)(6506007)(7696005)(2501003)(76176011)(53546011)(102836004)(486006)(9686003)(6436002)(2201001)(55016002)(229853002)(105586002)(2906002)(106356001)(86362001)(8936002)(14444005)(33656002)(53936002)(25786009)(81166006)(81156014)(6116002)(3846002)(256004)(99286004)(478600001)(6246003)(68736007)(2900100001)(7736002)(110136005)(305945005)(14454004)(316002)(66066001)(97736004)(8676002)(4326008)(5660300001)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1394;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mucf5aWx3EvMXyWkM4orR9opuO2lg8XB/15K3Q9nuYftfQ7m+qicF4ttOWwdVYVHlvBmT1zCpdC4Jl9Hb/ghw0Tqj069I12zywGJY6EYJxw5wZuhf6HlbMI3eBkr5VZgefl13cjqVoFYd/TkXjKcnMo3WG3u8f/gCQl5aS3a2CWzaYym+apSvRqRlJiD1wrRgcgKBmR0R83n2OcHJqJlxOS8LUrbEUSTg8DszyMXJPVejEslKmKcpSTUwK1fbXuyjJTzwSwCGQPZWlNfb/XHRFrSKkIxUN5AdhcrCQxQ57Nln7cIHo8pXIOYk036TUQS/R9blJ7RbIad3iceaLnedK329vfZFV8fTFgyvmbJWGA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5311498-14d4-46a1-d47a-08d5e89ffb13
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2018 09:06:55.2157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1394
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkFuc29uIEh1YW5nDQpCZXN0IFJlZ2FyZHMhDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBNYXJlayBWYXN1dCBbbWFpbHRvOm1hcmV4QGRlbnguZGVdDQo+IFNl
bnQ6IEZyaWRheSwgSnVseSAxMywgMjAxOCA1OjAzIFBNDQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5z
b24uaHVhbmdAbnhwLmNvbT47IGFpcmxpZWRAbGludXguaWU7DQo+IGRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGRsLWxp
bnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybTog
bXhzZmI6IGZpeCBydW50aW1lIFBNIGhhbmRsaW5nDQo+IA0KPiBPbiAwNy8xMy8yMDE4IDEwOjU0
IEFNLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiBBcyBkaXNwbGF5IHBvd2VyIGRvbWFpbiBpcyBj
b21iaW5lZCB3aXRoIGxjZGlmIG5vZGUgb24gc29tZSBpLk1YDQo+ID4gcGxhdGZvcm1zIGxpa2Ug
aS5NWDZTTCwgd2hlbiBsY2RpZiBkcml2ZXIgaXMgZW5hYmxlZCwgdGhlIG14c2ZiX2xvYWQNCj4g
PiBpcyBjYWxsZWQgdG8gZW5hYmxlIHJ1bnRpbWUgcG0sIGFuZCBhIHBhaXIgb2YgcG1fcnVudGlt
ZV9nZXRfc3luYyBhbmQNCj4gPiBwbV9ydW50aW1lX3B1dF9zeW5jIGFyZSBhbHNvIGNhbGxlZCwg
dGhhdCB3aWxsIGNhdXNlIGdlbmVyaWMgcG93ZXINCj4gPiBkb21haW4gZHJpdmVyIHRvIGRpc2Fi
bGUgbGNkaWYgcG93ZXIgZG9tYWluIGFuZCBsY2RpZiBpcyBubyBsb25nZXINCj4gPiB3b3JraW5n
LCB0aGUgbGNkaWYgcG93ZXIgc2hvdWxkIE9OTFkgYmUgdHVybmVkIG9mZiB3aGVuIGRpc3BsYXkg
aXMNCj4gPiBkaXNhYmxlZCwgc28gbW92ZSB0aGUgcG1fcnVudGltZV9wdXRfc3luYyB0byBteHNm
Yl91bmxvYWQgYW5kIHJlbW92ZQ0KPiA+IHRoZSBwbV9ydW50aW1lX2dldF9zeW5jIGluIG14c2Zi
X3VubG9hZCBhcyB3ZWxsLCBpbiB0aGlzIHdheSwgd2hlbg0KPiA+IGRpc3BsYXkgaXMgZW5hYmxl
ZCwgdGhlIGxjZGlmIHBvd2VyIHdpbGwgYmUgYWx3YXlzIE9OIHVudGlsIHRoZQ0KPiA+IGRpc3Bs
YXkgaXMgZGlzYWJsZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5z
b24uSHVhbmdAbnhwLmNvbT4NCj4gDQo+IERvZXNuJ3QgdGhpcyBhbHNvIG1lYW4gdGhlIGJsb2Nr
IHdpbGwgYWx3YXlzIGJlIG9uLCB0aHVzIHdhc3RpbmcgcG93ZXIgPw0KIA0KSSB0aGluayBkcm0g
ZHJpdmVyIHNob3VsZCBoYXZlIHNvbWV3aGVyZSB0byBpbXBsZW1lbnQgdGhlIGRpc3BsYXkNCmRp
c2FibGUgY2FzZSwgbGlrZSB3aGVuIGZiMCBpcyBibGFuayAoZWNobyAxID4gL3N5cy9jbGFzcy9n
cmFwaGljcy9mYjAvYmxhbmspLA0KdGhlbiBsY2RpZiBjYW4gYmUgcG93ZXJlZCBnYXRlZCwgYW5k
DQp3aGVuIGRpc3BsYXkgaXMgYmFjayBvbiAodW5ibGFuayksIGxjZGlmIG5lZWRzIHRvIGJlIHJl
LWluaXRpYWxpemF0aW9uIGFuZCBkaXNwbGF5IHdpbGwNCmJlIG9uLCBjdXJyZW50IGltcGxlbWVu
dGF0aW9uIGlzIGluY29ycmVjdCwgd2l0aCBrZXJuZWwgYm9vdGluZyB1cCwgbGNkaWYNCmlzIE5P
VCB3b3JraW5nIGF0IGFsbC4NCg0KVGhlIHJ1bnRpbWUgcG93ZXIgZ2F0aW5nIGNhc2UgY2FuIGJl
IGltcGxlbWVudGVkIGxhdGVyIHRvIHNhdmUgcG93ZXIsDQpuZWVkIGxjZGlmIGV4cGVydHMgdG8g
ZG8gaXQuIFRoYW5rcy4NCg0KQW5zb24uDQoNCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1
L2RybS9teHNmYi9teHNmYl9kcnYuYyB8IDMgKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbXhzZmIvbXhzZmJfZHJ2LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9teHNmYi9t
eHNmYl9kcnYuYw0KPiA+IGluZGV4IGZmZTUxMzcuLjFiYTE3OWIgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL214c2ZiL214c2ZiX2Rydi5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL214c2ZiL214c2ZiX2Rydi5jDQo+ID4gQEAgLTIzNSw3ICsyMzUsNiBAQCBzdGF0aWMgaW50
IG14c2ZiX2xvYWQoc3RydWN0IGRybV9kZXZpY2UgKmRybSwNCj4gPiB1bnNpZ25lZCBsb25nIGZs
YWdzKQ0KPiA+DQo+ID4gIAlwbV9ydW50aW1lX2dldF9zeW5jKGRybS0+ZGV2KTsNCj4gPiAgCXJl
dCA9IGRybV9pcnFfaW5zdGFsbChkcm0sIHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCkpOw0KPiA+
IC0JcG1fcnVudGltZV9wdXRfc3luYyhkcm0tPmRldik7DQo+ID4NCj4gPiAgCWlmIChyZXQgPCAw
KSB7DQo+ID4gIAkJZGV2X2Vycihkcm0tPmRldiwgIkZhaWxlZCB0byBpbnN0YWxsIElSUSBoYW5k
bGVyXG4iKTsgQEAgLTI2NCw2DQo+ID4gKzI2Myw3IEBAIHN0YXRpYyBpbnQgbXhzZmJfbG9hZChz
dHJ1Y3QgZHJtX2RldmljZSAqZHJtLCB1bnNpZ25lZCBsb25nDQo+ID4gZmxhZ3MpDQo+ID4gIGVy
cl9pcnE6DQo+ID4gIAlkcm1fcGFuZWxfZGV0YWNoKG14c2ZiLT5wYW5lbCk7DQo+ID4gIGVycl92
Ymxhbms6DQo+ID4gKwlwbV9ydW50aW1lX3B1dF9zeW5jKGRybS0+ZGV2KTsNCj4gPiAgCXBtX3J1
bnRpbWVfZGlzYWJsZShkcm0tPmRldik7DQo+ID4NCj4gPiAgCXJldHVybiByZXQ7DQo+ID4gQEAg
LTI3OSw3ICsyNzksNiBAQCBzdGF0aWMgdm9pZCBteHNmYl91bmxvYWQoc3RydWN0IGRybV9kZXZp
Y2UgKmRybSkNCj4gPiAgCWRybV9rbXNfaGVscGVyX3BvbGxfZmluaShkcm0pOw0KPiA+ICAJZHJt
X21vZGVfY29uZmlnX2NsZWFudXAoZHJtKTsNCj4gPg0KPiA+IC0JcG1fcnVudGltZV9nZXRfc3lu
Yyhkcm0tPmRldik7DQo+ID4gIAlkcm1faXJxX3VuaW5zdGFsbChkcm0pOw0KPiA+ICAJcG1fcnVu
dGltZV9wdXRfc3luYyhkcm0tPmRldik7DQo+ID4NCj4gPg0KPiANCj4gDQo+IC0tDQo+IEJlc3Qg
cmVnYXJkcywNCj4gTWFyZWsgVmFzdXQNCg==
