Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0E5C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0912147D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VUxesg3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0912147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeKTTP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:15:59 -0500
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:49192
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725898AbeKTTP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Eh4HY2WZpwIrn0xjjyOiv7uJMIUruxRAMLwqt33e3g=;
 b=VUxesg3cFqcw4SEZQ4b3YjW1TBQYXg3p1E/vVCxPJyK+7VXepe5462hSuzxOXwqmqMuc+6JwbZPKixchH3WBlD1n95gzxfWDW+SvK8LouUySls4ovN0uc8aiygSbhAQFUf8arQghumjeKAaE0ZKHm8CFI5nIuQnY7RaN15CK5zU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3674.eurprd04.prod.outlook.com (52.134.66.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Tue, 20 Nov 2018 08:47:55 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.048; Tue, 20 Nov 2018
 08:47:55 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] thermal: imx: fix for dependency on cpu-freq
Thread-Topic: [PATCH] thermal: imx: fix for dependency on cpu-freq
Thread-Index: AQHUa2Ref+fMFTxEzkOrPUZd06/1XqVYg7oAgAAAdNA=
Date:   Tue, 20 Nov 2018 08:47:55 +0000
Message-ID: <DB3PR0402MB391662A8DA6A1F43F26F095BF5D90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1540362909-32481-1-git-send-email-Anson.Huang@nxp.com>
 <28d501b1-8016-cc1a-3f7c-ac485ab81aa2@linaro.org>
In-Reply-To: <28d501b1-8016-cc1a-3f7c-ac485ab81aa2@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3674;6:WlWggDxM2BX1k7F7EXbEo6ymt0fpXFW4wgY+oGsS20prHglnzXUhIJ2r7HraaIeT9s9qFF7sHlMsaD6e40A9BPrX50UZ/FZw9JLT5gRV2EZqe5MBcwTEN9Z5XOZR5aJCWFseQB/qQCmJ4dcMX6XlDLAlQbEdV7higOR8VsdLvMNoUenuw9y5ReE+AI1EQg7FZ+e2Z5wO75PQoFgPP0wDZ+Q//vP/blpDk4mwwwDjXOCLOk6O2XNCvLCoCAZCuFVIUaYLK23Ldk3NxsXqBPN7yuej5nRkDI5ywx8CulapaWiNdiInA3Kr/pqvTEVq7PTL0i3oZYyj1rEgheU0ud97VO3BGcpZZfI2O9fH96lDuB/SaT55FKdAbXJGYaLiUIAm/gQbExsLRkzEj6yJ4jMFsuXc/lnvbGDyMoZPev+/TgcgjHckazAOngHuXh3AWO3/oouL7aOT6ssoMa37mI69Rw==;5:ff24VxOc9v2Ae0L6RPzv7hoJabxQ83IPB6CgJrTvc/Dm8sd6AQ0XLO/9weKYSTc8JEUng1N0hyoZxNZ9U32XZeqr6+in7lsppEPCTjP1pGJ1cE1QxeTC1xIg3pPX9JwPNqkSxMCc7uFiGNL7xh2dK++8YTKytabFJ371IzxFKZE=;7:Tau/L6ZvGFoinyJ3qT3rm5Vnq/XB1u7EbXrXEyj1kYI2xjj/M4KR17FtOMD/NPYlt32GdhDI8V/Y5sl6Zvws8/SdSdoWJgJWVWIwOMKAbInlnnbC2W9OPQTT1eLFstc3tJwWNYndBhne3Bgk+zUPdA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 234c20a8-10ec-42c6-a59b-08d64ec4dd88
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3674;
x-ms-traffictypediagnostic: DB3PR0402MB3674:
x-microsoft-antispam-prvs: <DB3PR0402MB36742EDF4CE38568D56B2A22F5D90@DB3PR0402MB3674.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3674;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3674;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(366004)(396003)(136003)(189003)(199004)(13464003)(11346002)(575784001)(86362001)(2906002)(476003)(486006)(105586002)(478600001)(7736002)(66066001)(74316002)(446003)(110136005)(316002)(44832011)(305945005)(2501003)(33656002)(6116002)(3846002)(6436002)(106356001)(229853002)(68736007)(5660300001)(4326008)(53546011)(25786009)(102836004)(97736004)(6506007)(39060400002)(14454004)(2201001)(81166006)(99286004)(8676002)(8936002)(76176011)(9686003)(7696005)(6246003)(71190400001)(256004)(71200400001)(53936002)(186003)(14444005)(26005)(6306002)(55016002)(2900100001)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3674;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XpdqpUxm65lZrp8/+ohaR0LyKPiJeOufeps86BJylhJxkR5dJ2A8UDua8GUl+GGuLPXUjjrKNz4XnDkSDE3PL3U5v87HzYpq8y211bFlBhUVVweBShD9bz2SDtjEV5gxBvbL2dy9P7clPK45UcF2l5fUV82qMf00fXvoXNZp7iplO+Gm3qckrjpfm1u4qIHaFlrY/ad+w4CcMyWX4neu0C1jBADtplwFZAevw7hNO1rP297fAzx3HLOhjy6z2Dggh6YZzuVwIyFJ7YvJJN1ij44zstdD1kxdFL3ROpGXu0HxGXKlnyCo1DV5WgV7PfYvrIRTUIMtjkJG62uYJ05f3yFCo4vx/SFVkHV4hEUxP9Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234c20a8-10ec-42c6-a59b-08d64ec4dd88
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 08:47:55.5809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3674
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbmllbA0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmllbCBMZXpjYW5vIFttYWlsdG86ZGFuaWVsLmxl
emNhbm9AbGluYXJvLm9yZ10NCj4gU2VudDogMjAxOOW5tDEx5pyIMjDml6UgMTY6NDUNCj4gVG86
IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsgcnVpLnpoYW5nQGludGVsLmNvbTsN
Cj4gZWR1YmV6dmFsQGdtYWlsLmNvbTsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOw0KPiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBu
eHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSB0aGVybWFsOiBpbXg6IGZpeCBmb3IgZGVw
ZW5kZW5jeSBvbiBjcHUtZnJlcQ0KPiANCj4gT24gMjQvMTAvMjAxOCAwODozOSwgQW5zb24gSHVh
bmcgd3JvdGU6DQo+ID4gVGhlIHRoZXJtYWwgZHJpdmVyIGlzIGEgc3RhbmRhbG9uZSBkcml2ZXIg
Zm9yIG1vbml0b3JpbmcgU29DDQo+ID4gdGVtcGVyYXR1cmUgYnkgZW5hYmxpbmcgdGhlcm1hbCBz
ZW5zb3IsIHNvIGl0IGNhbiBiZSBlbmFibGVkIGV2ZW4gd2hlbg0KPiA+IENPTkZJR19DUFVfRlJF
USBpcyBOT1Qgc2V0LiBTbyByZW1vdmUgdGhlIGRlcGVuZGVuY3kgd2l0aA0KPiBDUFVfVEhFUk1B
TC4NCj4gPg0KPiA+IEFkZCBDT05GSUdfQ1BVX0ZSRVEgY2hlY2sgZm9yIGNwdS1mcmVxIHJlbGF0
ZWQgb3BlcmF0aW9uIGluIHRoZXJtYWwNCj4gPiBkcml2ZXIgdG8gbWFrZSB0aGVybWFsIGRyaXZl
ciBwcm9iZSBzdWNjZXNzZnVsbHkgd2hlbiBDT05GSUdfQ1BVX0ZSRVENCj4gPiBpcyBOT1Qgc2V0
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5j
b20+DQo+ID4gLS0tDQo+IA0KPiBXaHkgbm90IHNpbXBseSBraWxsIHRoaXMgbGVnYWN5IGNvZGUg
Pw0KDQpCZWNhdXNlIGtpbGxpbmcgbGVnYWN5IGNvZGUgd2lsbCBoYXZlIG9sZCBkdGIgY29tcGF0
aWJsZSBpc3N1ZSwgb2xkIGR0Yg0Kd2lsbCBOT1QgaGF2ZSBjcHVmcmVxIGNvb2xpbmcgZnVuY3Rp
b24uDQoNCkFuc29uLiANCg0KPiANCj4gDQo+IA0KPiA+ICBkcml2ZXJzL3RoZXJtYWwvS2NvbmZp
ZyAgICAgICB8IDIgKy0NCj4gPiAgZHJpdmVycy90aGVybWFsL2lteF90aGVybWFsLmMgfCA0ICsr
KysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZyBiL2RyaXZlcnMv
dGhlcm1hbC9LY29uZmlnIGluZGV4DQo+ID4gMTc3NWQ0NC4uYzhhNjM1MiAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9L
Y29uZmlnDQo+ID4gQEAgLTIxMiw3ICsyMTIsNyBAQCBjb25maWcgSElTSV9USEVSTUFMDQo+ID4N
Cj4gPiAgY29uZmlnIElNWF9USEVSTUFMDQo+ID4gIAl0cmlzdGF0ZSAiVGVtcGVyYXR1cmUgc2Vu
c29yIGRyaXZlciBmb3IgRnJlZXNjYWxlIGkuTVggU29DcyINCj4gPiAtCWRlcGVuZHMgb24gKEFS
Q0hfTVhDICYmIENQVV9USEVSTUFMKSB8fCBDT01QSUxFX1RFU1QNCj4gPiArCWRlcGVuZHMgb24g
QVJDSF9NWEMgfHwgQ09NUElMRV9URVNUDQo+ID4gIAlkZXBlbmRzIG9uIE5WTUVNIHx8ICFOVk1F
TQ0KPiA+ICAJZGVwZW5kcyBvbiBNRkRfU1lTQ09ODQo+ID4gIAlkZXBlbmRzIG9uIE9GDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9pbXhfdGhlcm1hbC5jDQo+ID4gYi9kcml2ZXJz
L3RoZXJtYWwvaW14X3RoZXJtYWwuYyBpbmRleCAxNTY2MTU0Li44NzM4NmQxIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9pbXhfdGhlcm1hbC5jDQo+ID4gKysrIGIvZHJpdmVycy90
aGVybWFsL2lteF90aGVybWFsLmMNCj4gPiBAQCAtNjQ4LDYgKzY0OCw3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkDQo+ID4gb2ZfaW14X3RoZXJtYWxfbWF0Y2hbXSA9IHsgIH07
ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLA0KPiA+IG9mX2lteF90aGVybWFsX21hdGNoKTsNCj4g
Pg0KPiA+ICsjaWZkZWYgQ09ORklHX0NQVV9GUkVRDQo+ID4gIC8qDQo+ID4gICAqIENyZWF0ZSBj
b29saW5nIGRldmljZSBpbiBjYXNlIG5vICNjb29saW5nLWNlbGxzIHByb3BlcnR5IGlzIGF2YWls
YWJsZSBpbg0KPiA+ICAgKiBDUFUgbm9kZQ0KPiA+IEBAIC02NjgsNiArNjY5LDcgQEAgc3RhdGlj
IGludA0KPiA+IGlteF90aGVybWFsX3JlZ2lzdGVyX2xlZ2FjeV9jb29saW5nKHN0cnVjdCBpbXhf
dGhlcm1hbF9kYXRhICpkYXRhKQ0KPiA+DQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+ICsj
ZW5kaWYNCj4gPg0KPiA+ICBzdGF0aWMgaW50IGlteF90aGVybWFsX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpICB7IEBADQo+ID4gLTc0Myw2ICs3NDUsNyBAQCBzdGF0aWMgaW50
IGlteF90aGVybWFsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ID4g
IAlyZWdtYXBfd3JpdGUobWFwLCBkYXRhLT5zb2NkYXRhLT5zZW5zb3JfY3RybCArIFJFR19TRVQs
DQo+ID4gIAkJICAgICBkYXRhLT5zb2NkYXRhLT5wb3dlcl9kb3duX21hc2spOw0KPiA+DQo+ID4g
KyNpZmRlZiBDT05GSUdfQ1BVX0ZSRVENCj4gPiAgCWRhdGEtPnBvbGljeSA9IGNwdWZyZXFfY3B1
X2dldCgwKTsNCj4gPiAgCWlmICghZGF0YS0+cG9saWN5KSB7DQo+ID4gIAkJcHJfZGVidWcoIiVz
OiBDUFVGcmVxIHBvbGljeSBub3QgZm91bmRcbiIsIF9fZnVuY19fKTsgQEAgLTc1NSw2DQo+ID4g
Kzc1OCw3IEBAIHN0YXRpYyBpbnQgaW14X3RoZXJtYWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gPiAgCQkJImZhaWxlZCB0byByZWdpc3RlciBjcHVmcmVxIGNvb2xpbmcg
ZGV2aWNlOiAlZFxuIiwgcmV0KTsNCj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+ICAJfQ0KPiA+ICsj
ZW5kaWYNCj4gPg0KPiA+ICAJZGF0YS0+dGhlcm1hbF9jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYt
PmRldiwgTlVMTCk7DQo+ID4gIAlpZiAoSVNfRVJSKGRhdGEtPnRoZXJtYWxfY2xrKSkgew0KPiA+
DQo+IA0KPiANCj4gLS0NCj4gDQo+IDxodHRwczovL2VtZWEwMS5zYWZlbGlua3MucHJvdGVjdGlv
bi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3d3cNCj4gLmxpbmFyby5vcmclMkYmYW1w
O2RhdGE9MDIlN0MwMSU3Q2Fuc29uLmh1YW5nJTQwbnhwLmNvbSU3QzZkMTA2MA0KPiBiYTMzZTI0
ZTM3YmY1NjA4ZDY0ZWM0NjY1MSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTcN
Cj4gQzAlN0MwJTdDNjM2NzgzMDAyNzY3NDMwNTg4JmFtcDtzZGF0YT1FTzB4eGttUGpaVFJlQnpK
JTJGJTJGSmoNCj4geCUyRmJsYWh0bVl4SEhvZ0R4dzV1JTJGYmpvJTNEJmFtcDtyZXNlcnZlZD0w
PiBMaW5hcm8ub3JnIOKUgiBPcGVuDQo+IHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MNCj4g
DQo+IEZvbGxvdyBMaW5hcm86DQo+IDxodHRwczovL2VtZWEwMS5zYWZlbGlua3MucHJvdGVjdGlv
bi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZ3d3cNCj4gLmZhY2Vib29rLmNvbSUyRnBh
Z2VzJTJGTGluYXJvJmFtcDtkYXRhPTAyJTdDMDElN0NhbnNvbi5odWFuZyU0MA0KPiBueHAuY29t
JTdDNmQxMDYwYmEzM2UyNGUzN2JmNTYwOGQ2NGVjNDY2NTElN0M2ODZlYTFkM2JjMmI0YzZmYQ0K
PiA5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNjc4MzAwMjc2NzQzMDU4OCZhbXA7c2RhdGE9
Z3AzQmxMbA0KPiBTWGU2UEducHA5M0slMkIwbjAzWElublJzY1hFUkdsNFQyZDBTYyUzRCZhbXA7
cmVzZXJ2ZWQ9MD4NCj4gRmFjZWJvb2sgfA0KPiA8aHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGdHdpdHQNCj4gZXIuY29tJTJG
JTIzISUyRmxpbmFyb29yZyZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5zb24uaHVhbmclNDBueHAuYw0K
PiBvbSU3QzZkMTA2MGJhMzNlMjRlMzdiZjU2MDhkNjRlYzQ2NjUxJTdDNjg2ZWExZDNiYzJiNGM2
ZmE5MmNkOQ0KPiA5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY3ODMwMDI3Njc0MzA1ODgmYW1wO3Nk
YXRhPW9HWHR6TEJpZTFaeQ0KPiA0MTlqQWg5TGMzbXc3VnUyS3NDZ2FXWWQ0czJ0dWpZJTNEJmFt
cDtyZXNlcnZlZD0wPiBUd2l0dGVyIHwNCj4gPGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnd3dw0KPiAubGluYXJvLm9yZyUy
RmxpbmFyby1ibG9nJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NhbnNvbi5odWFuZyU0MG54cC5jDQo+
IG9tJTdDNmQxMDYwYmEzM2UyNGUzN2JmNTYwOGQ2NGVjNDY2NTElN0M2ODZlYTFkM2JjMmI0YzZm
YTkyY2Q5DQo+IDljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNjc4MzAwMjc2NzQzMDU4OCZhbXA7c2Rh
dGE9QWJBMVJvZnVKV1kNCj4gdW4lMkJLWnZMc3ZwNkhua2JuJTJGMVZxakNmaUVRc0RXJTJCYzAl
M0QmYW1wO3Jlc2VydmVkPTA+IEJsb2cNCg0K
