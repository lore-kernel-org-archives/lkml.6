Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4184ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B2720C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TyinZclp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B2720C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbeGQK0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:26:51 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:62080
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729060AbeGQK0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofM09YefE8mC3rFQLpJJ6V0+WI1z0waBKRIQnSKSVfc=;
 b=TyinZclpRbfdjg830Z9+L/4fCX2yf4pwbT1+Om7PVF9Bz6zHXleG4PojF10wHng4Rj/l3DJhoBFiX3z6YiqT6TILxn+za1gFup5oMBx+4HJBQejjitneFEyhiKEPM7q9RxfUrWGqyazW9xITqPoiOxBxckkzm2VoyBE2QATrP4M=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4258.eurprd04.prod.outlook.com (52.134.126.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Tue, 17 Jul 2018 09:54:04 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::64a5:e067:9a23:97ce]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::64a5:e067:9a23:97ce%2]) with mapi id 15.20.0952.021; Tue, 17 Jul 2018
 09:54:04 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "marex@denx.de" <marex@denx.de>
CC:     "A.s. Dong" <aisheng.dong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Marco Antonio Franchi <marco.franchi@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Mirela Rabulea <mirela.rabulea@nxp.com>
Subject: Re: [PATCH 1/2] drm/mxsfb: Fix runtime PM for unpowering lcdif block
Thread-Topic: [PATCH 1/2] drm/mxsfb: Fix runtime PM for unpowering lcdif block
Thread-Index: AQHT/PA5JwCr8sXVoUu8wmNVYtwOi6SNNsQAgAY3i4A=
Date:   Tue, 17 Jul 2018 09:54:03 +0000
Message-ID: <afe143888ae3c280e27884e3d98ff22f0c267006.camel@nxp.com>
References: <cd4ddc544a27915cab58a218223723eb18525c21.1528218001.git.leonard.crestez@nxp.com>
         <2024fd1b31818e5f62c779a33c6011e4@agner.ch>
In-Reply-To: <2024fd1b31818e5f62c779a33c6011e4@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4258;6:R1c1p4PEidI9wP6zlhtVBjDk/lGNGL5GoATtK7jS+eLthDgRw2RiIEapRTdeDCl2jx+DFeK3BFIjJh3EYPLCB1dClWWR2hWy4dBku0IJ7nlnmQpoAOZJuD5O9A/sRC6ZLyBea+//68XYGbzbAHJlsqR2Csj8WiDQxvx7o8ZpZv3zcRtWIh/yi2SNRPFrS3ilzbk5vLsh9/t6n1CEgPnhDaws3eRfAdo2d64MePYTUgSYMzV0UzB2FVRoYF9UJOGaJHfLe0a7b1dcDY+53F0osUJtL/uI2wHWU8QxJXF4DwVE2WJUfOlDNFCjpxn/ifbfT8MfMF6HFMvhcXI8ZiG5hSOAhOQZR4b8vTaEaDZqZDJWqHMGKifRytMHHwDBHn26NydnTrSHW832/kxnqmp8ayzXS0egv6J/MvAIk/mAtp6xPP4/zFKaQC+SpUOA/N+bdtxmw3dvMRBWGIe0HwD53A==;5:ekXZzj2PB8+eR/rz8ImPVMnNLe2dTy+HW0VnXXYZWEsIG+K1wLbI3g0mVu0YhbEbyrf+v9rnmj8mXNOVEChVvRyu3bKiBuEDjuyVJQiVzwYOSJhmSTJregSId6T9IJi0ha5D3Jok2cJaZvhnpsunYton7ltEFTDze4Er7nNDo/Y=;7:mW6bqdpXaoEmIppbfQ1QEILh2yrNAfGIO+hIkWCSAgGkH07dLO9WOmvULh9On3ztBiU/6vWQEVzYsxqGLCYmrYaV0jS6/t3066K11PQwTnozqNykF//noySybUEPpLqJa2REu88Eeshvs4FxorMIAKn2NmoAkQ1SPfFuhlwgWJo2QhU4TSQQ36e2TixCGaKcketynDSrpcSjBCBiv8fDlW95WtbgLGwgXiU869HZYGo4hpOmwZXKy/DdWJzk4M8S
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5d7b7f41-3564-4cd6-940b-08d5ebcb3acb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4258;
x-ms-traffictypediagnostic: AM0PR04MB4258:
x-microsoft-antispam-prvs: <AM0PR04MB42588E79221A7986ED436223EE5C0@AM0PR04MB4258.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4258;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4258;
x-forefront-prvs: 073631BD3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(366004)(189003)(199004)(54906003)(44832011)(99286004)(2201001)(6512007)(86362001)(305945005)(7736002)(486006)(110136005)(105586002)(106356001)(118296001)(102836004)(186003)(26005)(53546011)(6506007)(11346002)(446003)(2616005)(50226002)(476003)(8936002)(8676002)(68736007)(81166006)(81156014)(14454004)(97736004)(6246003)(53936002)(76176011)(4326008)(66066001)(478600001)(256004)(5250100002)(5660300001)(2501003)(25786009)(14444005)(36756003)(6486002)(229853002)(6436002)(316002)(3846002)(6116002)(2900100001)(2906002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4258;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 96WO/DSxnrnQTkMvjRh+291P+3Dm+2gszudaS38w42y0+2pyfHaalIAirnImB/3dhiXZSLiV63F6H9sSUHMlXG9XhQjG+7VN1tZVoh2cEWZfV2c7A1cjGrzUGxFzLGGIf1jtT4HdzhbEfZnFCMYGvRUeTDxSrZWzBAhxfthYxNA8yRio2DLY55796uxTv2ASLtQ9dwwj+J9TCy6bymZnp8qeyLEncHuGaJUy/3I9wokHu5pw18BgpG45dyMd5XjM2mizA+P9KvBdVWsb62zLfZ9B11ALLZ+VXlK5Ngh0ObtrDE2BRrFT97zDX2MAFa4qxwKBOVbWz+3KZ5LhW2cz6AY92oSJpBNAN6fQofeo3Cg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <48892218F7CCEF40A53D69A76AF244E1@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7b7f41-3564-4cd6-940b-08d5ebcb3acb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2018 09:54:03.8851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA3LTEzIGF0IDEyOjU3ICswMjAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IE9uIDA1LjA2LjIwMTggMTk6MTEsIExlb25hcmQgQ3Jlc3RleiB3cm90ZToNCj4gPiBBZGRpbmcg
aW14NnNsL3N4IGxjZGlmIG5vZGVzIGluIGEgcG93ZXIgZG9tYWluIGN1cnJlbnRseSBkb2VzIHdv
cmssIGl0DQo+ID4gcmVzdWx0cyBpbiBibGFjay9jb3JydXB0ZWQgc2NyZWVucyBvciBoYW5ncy4g
V2hpbGUgdGhlIGRyaXZlciBkb2VzDQo+ID4gZW5hYmxlIHJ1bnRpbWUgcG0gaXQgZG9lcyBub3Qg
ZGVhbCBjb3JyZWN0bHkgd2l0aCB0aGUgYmxvY2sgYmVpbmcNCj4gPiB1bnBvd2VyZWQuDQo+ID4g
DQo+ID4gRml4IGJ5IGFkZGluZyBwbV9ydW50aW1lX2dldC9wdXRfc3luYyB0byBteHNmYl9waXBl
X2VuYWJsZS9kaXNhYmxlLg0KPiA+IA0KPiA+IFRoZSBteHNmYl9wbGFuZV9hdG9taWNfdXBkYXRl
IGZ1bmN0aW9uIGNhbiBnZXQgY2FsbGVkIGJlZm9yZQ0KPiA+IG14c2ZiX3BpcGVfZW5hYmxlIHdo
aWxlIHRoZSBibG9jayBpcyBub3QgcG93ZXJlZC4gV2hlbiB0aGlzIGhhcHBlbnMgdGhlDQo+ID4g
d3JpdGUgdG8gTENESUZfTkVYVF9CVUYgaXMgbG9zdCBjYXVzaW5nIHJhbmRvbSBjb3JydXB0ZWQg
cGl4ZWxzIG9uDQo+ID4gdW5ibGFuay4NCj4gPiANCj4gPiBGaXggdGhpcyBieSBzcGxpdHRpbmcg
dGhlIHdyaXRpbmcgb2YgZ2VtLT5wYWRkciB0byBuZXh0YnVmIGludG8gYQ0KPiA+IG14c2ZiX3Vw
ZGF0ZV9od19uZXh0X2J1ZiBmdW5jdGlvbmEgYW5kIGFsc28gY2FsbGluZyBpdCBmcm9tDQo+ID4g
bXhzZmJfY3J0Y19tb2RlX3NldF9ub2ZiLg0KPiA+IA0KPiA+IEFsc28gYWRkIGZpZWxkcyB0byBt
eHNmYl9kcnYgdG8ga2VlcCB0cmFjayBvZiBlbmFibGVkL3N1c3BlbmRlZCBzdGF0ZXMuDQoNCj4g
PiArc3RhdGljIHZvaWQgbXhzZmJfdXBkYXRlX2h3X25leHRfYnVmKHN0cnVjdCBteHNmYl9kcm1f
cHJpdmF0ZSAqbXhzZmIpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBkcm1fZnJhbWVidWZmZXIgKmZi
ID0gbXhzZmItPnBpcGUucGxhbmUuc3RhdGUtPmZiOw0KPiA+ICsJc3RydWN0IGRybV9nZW1fY21h
X29iamVjdCAqZ2VtOw0KPiA+ICsNCj4gPiArCWlmICghZmIpDQo+ID4gKwkJcmV0dXJuOw0KPiA+
ICsNCj4gPiArCWdlbSA9IGRybV9mYl9jbWFfZ2V0X2dlbV9vYmooZmIsIDApOw0KPiA+ICsJaWYg
KCFnZW0pDQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsNCj4gPiArCXdyaXRlbChnZW0tPnBhZGRyLCBt
eHNmYi0+YmFzZSArIG14c2ZiLT5kZXZkYXRhLT5uZXh0X2J1Zik7DQo+ID4gK30NCj4gPiArDQo+
ID4gIHN0YXRpYyB2b2lkIG14c2ZiX2NydGNfbW9kZV9zZXRfbm9mYihzdHJ1Y3QgbXhzZmJfZHJt
X3ByaXZhdGUgKm14c2ZiKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSAq
bSA9ICZteHNmYi0+cGlwZS5jcnRjLnN0YXRlLT5hZGp1c3RlZF9tb2RlOw0KPiA+ICAJY29uc3Qg
dTMyIGJ1c19mbGFncyA9IG14c2ZiLT5jb25uZWN0b3IuZGlzcGxheV9pbmZvLmJ1c19mbGFnczsN
Cj4gPiAgCXUzMiB2ZGN0cmwwLCB2c3luY19wdWxzZV9sZW4sIGhzeW5jX3B1bHNlX2xlbjsNCj4g
PiBAQCAtMjY4LDM1ICsyODMsNDEgQEAgc3RhdGljIHZvaWQgbXhzZmJfY3J0Y19tb2RlX3NldF9u
b2ZiKHN0cnVjdA0KPiA+IG14c2ZiX2RybV9wcml2YXRlICpteHNmYikNCj4gPiAgCSAgICAgICBt
eHNmYi0+YmFzZSArIExDRENfVkRDVFJMMyk7DQo+ID4gIA0KPiA+ICAJd3JpdGVsKFNFVF9ET1RD
TEtfSF9WQUxJRF9EQVRBX0NOVChtLT5oZGlzcGxheSksDQo+ID4gIAkgICAgICAgbXhzZmItPmJh
c2UgKyBMQ0RDX1ZEQ1RSTDQpOw0KPiA+ICANCj4gPiArCW14c2ZiX3VwZGF0ZV9od19uZXh0X2J1
ZihteHNmYik7DQo+ID4gIAlteHNmYl9kaXNhYmxlX2F4aV9jbGsobXhzZmIpOw0KPiA+ICB9DQo+
ID4gIA0KPiA+ICB2b2lkIG14c2ZiX2NydGNfZW5hYmxlKHN0cnVjdCBteHNmYl9kcm1fcHJpdmF0
ZSAqbXhzZmIpDQo+ID4gIHsNCj4gPiArCWlmIChteHNmYi0+ZW5hYmxlZCkNCj4gPiArCQlyZXR1
cm47DQo+ID4gKw0KPiA+ICAJbXhzZmJfY3J0Y19tb2RlX3NldF9ub2ZiKG14c2ZiKTsNCj4gPiAg
CW14c2ZiX2VuYWJsZV9jb250cm9sbGVyKG14c2ZiKTsNCj4gPiArDQo+ID4gKwlteHNmYi0+ZW5h
YmxlZCA9IHRydWU7DQo+IA0KPiBJcyB0aGlzIHN0YXRlIGtlZXBpbmcgcmVhbGx5IG5lY2Vzc2Fy
eT8NCg0KU29ydCBvZi4gVGhlIGNvZGUgaXMgaW5kZWVkIGEgYml0IGNvbXBsaWNhdGVkLCB0aGVy
ZSBhcmUgMyBwb3NzaWJsZQ0Kc3RhdGVzOiAiZGlzYWJsZWQiLCAiZW5hYmxlZCIsICJlbmFibGVk
IGJ1dCBzdXNwZW5kZWQiDQoNCldoZW4gdGhlIGRldmljZSByZXN1bWVzIGl0IHNob3VsZCBlbmFi
bGUgdGhlIGNvbnRyb2xsZXIgb25seSBpZiBpdCB3YXMNCmVuYWJsZWQgYmVmb3JlIChub3QgaWYg
c2NyZWVuIGlzIGJsYW5rZWQpLiBBZnRlciBzb21lIGRpZ2dpbmcgSSBmb3VuZA0KdGhhdCBzdXNw
ZW5kL3Jlc3VtZSBjb3VsZCBiZSBiZXR0ZXIgaW1wbGVtZW50ZWQgdXNpbmcNCmRybV9tb2RlX2Nv
bmZpZ19oZWxwZXJfc3VzcGVuZC9yZXN1bWUuIFRoaXMgc2hvdWxkIGF1dG9tYXRpY2FsbHkNCnJl
bWVtYmVyIHRoZSBjcnRjIHN0YXRlICJwcm9wZXJseSIgd2l0aG91dCBrZWVwaW5nIHN0YXRlIGlu
IHRoZSBkcml2ZXIuDQoNCk9uZSBub3RhYmxlIGlzc3VlIGlzIHRoYXQgdGhlIGxjZGlmIGJsb2Nr
IGlzIG9ubHkgcG93ZXJlZCB3aGlsZSB0aGUNCmNydGMgaXMgZW5hYmxlZCBidXQgbXhzZmJfcGxh
bmVfYXRvbWljX3VwZGF0ZSBjYW4gYmUgY2FsbGVkIG91dHNpZGUNCnRoYXQuIFNvIHdlIG5lZWQg
dG8gY2hlY2sgaWYgdGhlIENSVEMgaXMgZW5hYmxlZCBpbnNpZGUNCm14c2ZiX3BsYW5lX2F0b21p
Y191cGRhdGUgYW5kIGF2b2lkIHdyaXRpbmcgdG8gaGFyZHdhcmUuIEluc3RlYWQgdGhlIEhXDQp3
cml0ZSBmb3IgbmV4dCBpcyBkZWxheWVkIGZvciB0aGUgbmV4dCBteHNmYl9jcnRjX21vZGVfc2V0
X25vZmIuDQoNCkRvZXMgdGhpcyBtYWtlIHNlbnNlPyBCZWluZyB1bmFibGUgdG8gdXBkYXRlIHRo
ZSBwbGFuZSBpZiB0aGUgY3J0YyBpcw0Kbm90IGVuYWJsZWQgc2VlbXMgbGlrZSBpdCB3b3VsZCBi
ZSBhIGNvbW1vbiBsaW1pdGF0aW9uIG9mIHNpbXBsZQ0KZGlzcGxheSBjb250cm9sbGVycy4NCg0K
V3JpdGluZyB0aGUgRkIgcGFkZHIgZnJvbSBteHNmYl9jcnRjX21vZGVfc2V0X25vZmIgZmVlbHMg
d3JvbmcgYW5kIEknbQ0Kbm90IHN1cmUgaXQgYmVoYXZlcyBjb3JyZWN0bHk6IHdoZW4gdGhlIGRp
c3BsYXkgaXMgcmVzdW1lZCBpdCBzZWVtcyB0bw0Kb3V0cHV0IGFuIGluaXRpYWwgZnJhbWUgb2Yg
aW5jb3JyZWN0IGRhdGEuIEl0J3MgcG9zc2libGUgdGhlIGVuYWJsZQ0Kc2VxdWVuY2UgbmVlZHMg
dG8gYmUgYWRqdXN0ZWQu
