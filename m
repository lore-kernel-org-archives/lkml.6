Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C22C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE93218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jiQ16i7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfAYUUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:20:47 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:17381 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfAYUUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 15:20:47 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4b6f990000>; Sat, 26 Jan 2019 04:20:41 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 25 Jan 2019 12:20:40 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 25 Jan 2019 12:20:40 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 20:20:39 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.53) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 25 Jan 2019 20:20:39 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3303.namprd12.prod.outlook.com (20.179.93.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Fri, 25 Jan 2019 20:20:36 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064%5]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 20:20:36 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V2 2/4] i2c: tegra: Update I2C transfer using buffer
Thread-Topic: [PATCH V2 2/4] i2c: tegra: Update I2C transfer using buffer
Thread-Index: AQHUtCaqSMUv+qypUUWuTCZ/iDn5aKXAZ3CAgAAFD2A=
Date:   Fri, 25 Jan 2019 20:20:36 +0000
Message-ID: <BYAPR12MB33982FC612F99AC5CAE29EDBC29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
 <1548363113-25969-2-git-send-email-skomatineni@nvidia.com>
 <185da588-1080-1589-46b6-5b63dff681eb@gmail.com>
In-Reply-To: <185da588-1080-1589-46b6-5b63dff681eb@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3303;6:wHNjsrCp1X1NXdHKeTvBJYYPfMLVMm5CrjfDR9T97vhxJ0LZtz9vvTitfmbDPGx28YG6Xh+mbkBqTxlpLtQkFFzb6crKNBzX+OA7ZS+PQRpExXLbRrXfApNZwdY3lP2Ya3teYeTsH8/d2JRH2nal6Lfac4RcubiLn++aO1ju98BtB6DsXfGeFwipj1yAZMWCV+cuICEyBGF9zoZt+5otFOLV7bDw0OCrBLqh65/W4KXnqnsvfwht1uVYeWwTidcRGfpDMfPQrTJMttO1KMtcMbCgPwFTMP7xlzC19GgWtSrAqU/l1H0KCHqmzD9/Y1al/GRNA0lGK7B0AtOwo7EMEE+OAX0Fx8qCFLmlI3W31W10nIN0VXMBSpM/OFHNvKJrKc63Wk0RmR5NzDnwPUjupQBC0k++6/MNAIy3n4qdyXVngdueDhn4d/MEvm8vT99PelT3oqCYC2l9+FYygFoDlw==;5:spajCiSA5DvhyrQPr0hAkIN5AXyqU7brca2CEJ7o/g9cMZI2FeVtvo89NCpX3fQ99g2WzXzE5yH7oyFcNnPK/9umDJzedbWHv9+D5QP+5PyEw/1do8YD1L24NB3LWif8tZpDZh2t7vnztychdnF4natn4eXZG10E2BWBvlR4oC+e/Tl9HBiN1xaiNODozBMSsOUDhKvjhF9zubalWaQVqg==;7:lZG5hpCHFwUIDJKucKR/CTd3QPjZUJbf1UMUKrIbcFmnTgdcASob1w/7DhGVBOUPK/5Zw7oYvkCAanOoZJJQnLp0t8v2y7xgH5BIR1SlH6pn/19SNJzZqU5V9P0i6P1supkeVUcC89QsfPP62TiK9Q==
x-ms-office365-filtering-correlation-id: 277f94bc-a9df-45bd-f1cc-08d683029113
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3303;
x-ms-traffictypediagnostic: BYAPR12MB3303:
x-microsoft-antispam-prvs: <BYAPR12MB3303B44CC28B5EF9A6358BE6C29B0@BYAPR12MB3303.namprd12.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(136003)(39860400002)(376002)(199004)(189003)(86362001)(74316002)(9686003)(446003)(68736007)(105586002)(486006)(3846002)(476003)(99286004)(106356001)(11346002)(81166006)(8676002)(6246003)(305945005)(6116002)(71200400001)(81156014)(53936002)(7736002)(71190400001)(478600001)(8936002)(6636002)(256004)(14444005)(97736004)(316002)(2501003)(186003)(15650500001)(26005)(7696005)(66066001)(102836004)(25786009)(33656002)(14454004)(55016002)(2906002)(6436002)(39060400002)(76176011)(4326008)(54906003)(110136005)(6506007)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3303;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SCkW2qyKnRqHz7QG+a6Av5KX7ge6N/ExBfpZwcGdMOByn47WvpQHE4VnIFE08GlBuk3J8ZSl9PvhrXiVlT/V2PhSsuAlTsUY3GB4xRCYwynBdaLaVMZhwcopERf1Z2u6bKfk/68Re9ZLXMpqlH75ZvdLpIUDaupOCmedISwY9+xTZ11llx/ERt0bs0HV+AMU5nu4P4TVo6iySCkuJ6zjN5ApBi10qx4rygqUbbO5QD4it0xBnRILkcbOWyhdp7amCHudJcIphxJta2bf9kF9EjIQsEO2/9T1AvrUJooqf4pid06RZLINdO4aW8mL3amKyYGgzS/z3tuMUZVWHzbAAKitAQDXOVxCin4YmwOtykv22G5P7gOS7gdcG8VJiAxOaRh4xpiGF/qoErkU7psT0wk0CSGceOwVn2JLaoAtcgA=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 277f94bc-a9df-45bd-f1cc-08d683029113
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 20:20:36.5029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3303
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548447641; bh=/m+4AhnMEXMX1Law/seU2NX3TayvoFOGbe/G9ZFdNZk=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=jiQ16i7OmGja9cXfGEHw2Qx8nZplIFwFsZqR1RuOmcvOCWcMfOXZkP/jcgwB5Fkt7
         I27nDs3naGljkwWpUxE19va1u6BexJv6xpGjIVwSFktbSaFERp886MKr2ZHjuOtRLu
         BSBqqJS6ogqqDEP0kBFepujD9CurAuU1dGpcuWjDv6dHc/HovsFL5R45VDYLTS3L7y
         yi+GXEu6ik+ZcOHPiJOOLj8EDyWY0XjkwYOAg+xyVd53uDmhCIXHkkp1h3CFgs+r0o
         887dB0rzbo4lUvSH/y2VyAHoCD9tCzu+02EukZCIFj18FPaiiIMlz7b2NjrrqJsEOt
         U025uK1gjojmA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gPiBUaGlzIHBhdGNoIHByZXBhcmVzIHRoZSBidWZmZXIgd2l0aCB0aGUgbWVzc2FnZSBi
eXRlcyB0byBiZSANCj4gPiB0cmFuc21pdHRlZCBhbG9uZyB3aXRoIHRoZSBwYWNrZXQgaGVhZGVy
IGluZm9ybWF0aW9uIGFuZCB0aGVuIHBlcmZvcm1zIA0KPiA+IGkyYyB0cmFuc2ZlciBpbiBQSU8g
bW9kZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTb3dqYW55YSBLb21hdGluZW5pIDxza29t
YXRpbmVuaUBudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICBbVjJdIDogRE1BIHN1cHBvcnQgY2hh
bmdlcyBpbmNsdWRlIHByZXBhcmluZyBidWZmZXIgd2l0aCBtZXNzYWdlIGJ5dGVzIGFuZA0KPiA+
IAlhbmQgaGVhZGVyIGJlZm9yZSBzZW5kaW5nIHRoZW0gdGhyb3VnaCBETUEuIFNvIHNwbGl0dGVk
IHRoZSB3aG9sZQ0KPiA+IAljaGFuZ2UgaW50byAyIHNlcGVyYXRlIHBhdGNoZXMgaW4gdGhpcyBz
ZXJpZXMuDQo+ID4gDQo+ID4gIGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtdGVncmEuYyB8IDk3IA0K
PiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNjggaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtdGVncmEuYyANCj4gPiBiL2RyaXZl
cnMvaTJjL2J1c3Nlcy9pMmMtdGVncmEuYyBpbmRleCBlZjg1NGJlNGM4MzcuLjEzYmNlMTQxMWRk
YyANCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3JhLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3JhLmMNCj4gPiBAQCAtMTE3LDYg
KzExNyw5IEBADQo+ID4gICNkZWZpbmUgSTJDX01TVF9GSUZPX1NUQVRVU19UWF9NQVNLCQkweGZm
MDAwMA0KPiA+ICAjZGVmaW5lIEkyQ19NU1RfRklGT19TVEFUVVNfVFhfU0hJRlQJCTE2DQo+ID4g
IA0KPiA+ICsvKiBQYWNrZXQgaGVhZGVyIHNpemUgaW4gYnl0ZXMgKi8NCj4gPiArI2RlZmluZSBJ
MkNfUEFDS0VUX0hFQURFUl9TSVpFCQkJMTINCj4gPiArDQo+ID4gIC8qDQo+ID4gICAqIG1zZ19l
bmRfdHlwZTogVGhlIGJ1cyBjb250cm9sIHdoaWNoIG5lZWQgdG8gYmUgc2VuZCBhdCBlbmQgb2Yg
dHJhbnNmZXIuDQo+ID4gICAqIEBNU0dfRU5EX1NUT1A6IFNlbmQgc3RvcCBwdWxzZSBhdCBlbmQg
b2YgdHJhbnNmZXIuDQo+ID4gQEAgLTY3NywzNSArNjgwLDY5IEBAIHN0YXRpYyBpcnFyZXR1cm5f
dCB0ZWdyYV9pMmNfaXNyKGludCBpcnEsIHZvaWQgKmRldl9pZCkNCj4gPiAgCXJldHVybiBJUlFf
SEFORExFRDsNCj4gPiAgfQ0KPiA+ICANCj4gPiArc3RhdGljIGludCB0ZWdyYV9pMmNfc3RhcnRf
cGlvX3hmZXIoc3RydWN0IHRlZ3JhX2kyY19kZXYgKmkyY19kZXYpIHsNCj4gPiArCXUzMiAqYnVm
ZmVyID0gKHUzMiAqKWkyY19kZXYtPm1zZ19idWY7DQo+ID4gKwl1bnNpZ25lZCBsb25nIGZsYWdz
Ow0KPiA+ICsJdTMyIGludF9tYXNrOw0KPiA+ICsNCj4gPiArCXNwaW5fbG9ja19pcnFzYXZlKCZp
MmNfZGV2LT54ZmVyX2xvY2ssIGZsYWdzKTsNCj4gPiArDQo+ID4gKwlpbnRfbWFzayA9IEkyQ19J
TlRfTk9fQUNLIHwgSTJDX0lOVF9BUkJJVFJBVElPTl9MT1NUOw0KPiA+ICsJdGVncmFfaTJjX3Vu
bWFza19pcnEoaTJjX2RldiwgaW50X21hc2spOw0KPiA+ICsNCj4gPiArCWkyY193cml0ZWwoaTJj
X2RldiwgKihidWZmZXIrKyksIEkyQ19UWF9GSUZPKTsNCj4gPiArCWkyY193cml0ZWwoaTJjX2Rl
diwgKihidWZmZXIrKyksIEkyQ19UWF9GSUZPKTsNCj4gPiArCWkyY193cml0ZWwoaTJjX2Rldiwg
KihidWZmZXIrKyksIEkyQ19UWF9GSUZPKTsNCj4gPiArDQo+ID4gKwlpMmNfZGV2LT5tc2dfYnVm
ID0gKHU4ICopIGJ1ZmZlcjsNCj4gPiArDQo+ID4gKwlpZiAoIWkyY19kZXYtPm1zZ19yZWFkKQ0K
PiA+ICsJCXRlZ3JhX2kyY19maWxsX3R4X2ZpZm8oaTJjX2Rldik7DQo+ID4gKw0KPiA+ICsJaWYg
KGkyY19kZXYtPmh3LT5oYXNfcGVyX3BrdF94ZmVyX2NvbXBsZXRlX2lycSkNCj4gPiArCQlpbnRf
bWFzayB8PSBJMkNfSU5UX1BBQ0tFVF9YRkVSX0NPTVBMRVRFOw0KPiA+ICsJaWYgKGkyY19kZXYt
Pm1zZ19yZWFkKQ0KPiA+ICsJCWludF9tYXNrIHw9IEkyQ19JTlRfUlhfRklGT19EQVRBX1JFUTsN
Cj4gPiArCWVsc2UgaWYgKGkyY19kZXYtPm1zZ19idWZfcmVtYWluaW5nKQ0KPiA+ICsJCWludF9t
YXNrIHw9IEkyQ19JTlRfVFhfRklGT19EQVRBX1JFUTsNCj4gPiArDQo+ID4gKwl0ZWdyYV9pMmNf
dW5tYXNrX2lycShpMmNfZGV2LCBpbnRfbWFzayk7DQo+ID4gKwlzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZpMmNfZGV2LT54ZmVyX2xvY2ssIGZsYWdzKTsNCj4gPiArCWRldl9kYmcoaTJjX2Rldi0+
ZGV2LCAidW5tYXNrZWQgaXJxOiAlMDJ4XG4iLA0KPiA+ICsJCWkyY19yZWFkbChpMmNfZGV2LCBJ
MkNfSU5UX01BU0spKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4g
PiAgc3RhdGljIGludCB0ZWdyYV9pMmNfeGZlcl9tc2coc3RydWN0IHRlZ3JhX2kyY19kZXYgKmky
Y19kZXYsDQo+ID4gIAlzdHJ1Y3QgaTJjX21zZyAqbXNnLCBlbnVtIG1zZ19lbmRfdHlwZSBlbmRf
c3RhdGUpICB7DQo+ID4gIAl1MzIgcGFja2V0X2hlYWRlcjsNCj4gPiAgCXUzMiBpbnRfbWFzazsN
Cj4gPiAgCXVuc2lnbmVkIGxvbmcgdGltZV9sZWZ0Ow0KPiA+IC0JdW5zaWduZWQgbG9uZyBmbGFn
czsNCj4gPiArCXUzMiAqYnVmZmVyOw0KPiA+ICsJaW50IHJldCA9IDA7DQo+ID4gKw0KPiA+ICsJ
YnVmZmVyID0ga21hbGxvYyhBTElHTihtc2ctPmxlbiwgQllURVNfUEVSX0ZJRk9fV09SRCkgKw0K
PiA+ICsJCQkJCUkyQ19QQUNLRVRfSEVBREVSX1NJWkUsIEdGUF9LRVJORUwpOw0KPiA+ICsJaWYg
KCFidWZmZXIpDQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+DQo+IElzbid0IGl0IHBvc3NpYmxl
IHRvIGF2b2lkICJidWZmZXIiIGFsbG9jYXRpb24gLyBjb3B5aW5nIG92ZXJoZWFkIGFuZCBrZWVw
IGNvZGUgYXMtaXMgZm9yIHRoZSBQSU8gbW9kZT8NCj4NCg0KS2VlcGluZyBQSU8gbW9kZSBjb2Rl
IGFzIGlzIGFuZCBhZGRpbmcgRE1BIG1vZGUgd2lsbCBoYXZlIHJlZHVuZGFudCBjb2RlIGZvciBo
ZWFkZXIgZ2VuZXJhdGlvbiBhbmQgbXNnIGNvbXBsZXRlIHRpbWVvdXQgc2VjdGlvbnMuDQpBbHNv
IGluIGV4aXN0aW5nIFBJTyBtb2RlIGltcGxlbWVudGF0aW9uLCBUWCBGSUZPIGlzIGZpbGxlZCBh
cyBzb29uIGFzIHRoZSB3b3JkIGlzIHJlYWR5IGJ1dCBmb3IgRE1BIG1vZGUgbmVlZCB0byBwdXQg
YWxsIG1zZyBieXRlcyBhbG9uZyB3aXRoIGhlYWRlciB0b2dldGhlciB0byBzZW5kIHRocnUgRE1B
Lg0KU28gY3JlYXRlZCBjb21tb24gYnVmZmVyIHRvIHBlcmZvcm0gUElPL0RNQSB0byByZWR1Y2Ug
cmVkdW5kYW5jeS4NCg==
