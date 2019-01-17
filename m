Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AC2C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D511E20856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WiKpmZGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbfAQG0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:26:19 -0500
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]:13794
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730177AbfAQG0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tfsNvMgFY1nZklIutVi3nU1RDbewAfiZm5Unr16GKU=;
 b=WiKpmZGVHRgve1ggN/bVXiUo/gR2ndKhCfyVjUosoEXcFqSlCylY+UzE8Q2l6Nvwdsqw8vajkggBc6eYFzXSrzUF+7zSB/nv3QRhJsA6HnZpGYeQ2UndmK4WskC/qgopk4OLoMN2H78gX3QhkCzlIMjom+BSrCp1a2BNxL14jDE=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5483.eurprd04.prod.outlook.com (20.178.105.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Thu, 17 Jan 2019 06:26:14 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::b5b6:9a7a:7970:ffec]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::b5b6:9a7a:7970:ffec%4]) with mapi id 15.20.1516.019; Thu, 17 Jan 2019
 06:26:14 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] can: flexcan: add TX support for variable payload size
Thread-Topic: [PATCH] can: flexcan: add TX support for variable payload size
Thread-Index: AQHUkeZs7DN/5MKD9Eu238RlkbDYTKWzNv+g
Date:   Thu, 17 Jan 2019 06:26:14 +0000
Message-ID: <DB7PR04MB46185CFC0AE2641366B0A51EE6830@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20181212064419.18613-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181212064419.18613-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5483;6:K8BtkfKMJjt4NqBL05FxlHVy0GR2QlHMnnc64RrP17exexQMNGcerEWfnS1/GsitpQxiRts+DSlgWkpYBiWQk/1LuM4qEBhwQYu4bGIEzDXGoMyo5C8KAPV8qiANN6XMDdkOjj4u3TW99afQ6ZLuGA8xj/IRNuV8ziel6z4XbG3vcroY3SlU08VKYwLUH2V/kqWosN9AIeCd9rJUwgWpExBbe7fV2KoeXZ5TudwZ42Jbf3T/5+/W0Dt1ILDBHPsH1k1O7Oo6/VphECvhy6BV/UFfz9otmjkExwDPtoaq+5u6KRbSyikxD0eXhVP5LlY9OcwRqO4CP2nuZDDHRFSFrHDJBnFFTbnVzHMO8Uc0mJf6NjTu4Md3pGMYU+cDBMcjjkb8MzVrtrmJQ93HOsrva1uXUEbBmgzLdcY8UBvOvNIVCtqe/Bvi1YQzuqtEBYOQvcUnuTbeOk23NDW8e4aRYQ==;5:n2/7PWDntmcVA8L4YYx5egmJzu2aFljwKLIvRR+8YCdpeg8QPKmsjNvwyMB2vuEe1zsGeidthuXCgtV3dwCMC8AHlGmYl5RVOnrWzhycZA2fVdk+b5OAkzpfFNYLwwydRqF9Aq7M3yTjvIdVjjvCI7lSSciGgkgDgpkDnwwa5RG5lhViDYaxKrREuNtF6zDiDyHfUGb67f8jknUI2HegLA==;7:PG4TJ/q8nvqGIyv/sGMOHQl0czFaMmsQZzuMr/Sqzg8yqnPMKeqVefNWsFPzdvcYOIpQ4Sw6iaVb5mFMdSdJGGEIudNoU+RNYy3aiDAXqmYCOusyDnbKhOTkXvD+0gvv07bXBqN4+Ruwom+qFsFCeA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 57149e67-b998-4b33-9d87-08d67c44ae7f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5483;
x-ms-traffictypediagnostic: DB7PR04MB5483:
x-microsoft-antispam-prvs: <DB7PR04MB54836615A9CB2C6F6784D1A0E6830@DB7PR04MB5483.eurprd04.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(366004)(346002)(189003)(199004)(13464003)(97736004)(9686003)(486006)(102836004)(26005)(3846002)(6116002)(53546011)(186003)(4326008)(33656002)(6506007)(25786009)(6246003)(55016002)(53936002)(76176011)(569044001)(54906003)(7696005)(316002)(110136005)(99286004)(11346002)(446003)(6436002)(476003)(106356001)(478600001)(2501003)(14454004)(105586002)(5660300001)(86362001)(256004)(2906002)(8936002)(229853002)(7736002)(81156014)(81166006)(66066001)(8676002)(68736007)(71200400001)(71190400001)(305945005)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5483;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q8oS6r3MGWqqifXHbeGPfU7ZugDt7Th8UlOoKurcDxuUpIYM37m+Mo74uO6Xh08eGSGtQLu/a7vkRLC0UpNleuqrILumCfSOIMRxY8WTrKPaXVnSuNYQBi+xhPhhUEnYypaMQssfwDidyHtym4E4hgnY4NqOCqExO/l327ArTyV2xHw3Ej8EiVRVzkHOlQlZ+3/mOVyD0QgSMA+gyR7q+0aWspeA6DqJr71THRcRj6Wwa9MbZSwLx0/HVRHxK8FJLt2jnHmQG3Rn5b/ep1aIUQaDdupknHUo3MaMdyBCiPrdkdn4Bu3wh/41r3N2pKCuFErj637Y4he3p30EP21IKhnQjUvrjIWpYS/bVfvByckfHZPjIttb/RiHpKq+me8z2Yrr8avUM0NQL6N67IVRh0vJN+NL0GJCmPUtY11jTCw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57149e67-b998-4b33-9d87-08d67c44ae7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 06:26:14.5842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5483
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpLaW5kbHkgUGluZy4uLg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2FraW0gWmhhbmcNCj4gU2VudDogMjAx
OMTqMTLUwjEyyNUgMTQ6NDcNCj4gVG86IG1rbEBwZW5ndXRyb25peC5kZTsgbGludXgtY2FuQHZn
ZXIua2VybmVsLm9yZw0KPiBDYzogd2dAZ3JhbmRlZ2dlci5jb207IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGlu
dXgtaW14QG54cC5jb20+OyBKb2FraW0NCj4gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29t
Pg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGNhbjogZmxleGNhbjogYWRkIFRYIHN1cHBvcnQgZm9yIHZh
cmlhYmxlIHBheWxvYWQgc2l6ZQ0KPiANCj4gTm93IHRoZSBGbGV4Q0FOIGRyaXZlciBhbHdheXMg
dXNlIGxhc3QgbWFpbGJveCBmb3IgVFgsIGl0IHdpbGwgd29yayB3ZWxsIHdoZW4NCj4gTUIgcGF5
bG9hZCBzaXplIGlzIDgvMTYgYnl0ZXMuDQo+IFRYIG1haWxib3ggd291bGQgY2hhbmdlIHRvIDEz
IHdoZW4gTUIgcGF5bG9hZCBzaXplIGlzIDY0IGJ5dGVzIHRvIHN1cHBvcnQNCj4gQ0FORkQuIFNv
IHdlIG1heSBuZWVkIHRvIHNldCBpZmxhZyByZWdpc3RlciB0byBhZGQgc3VwcG9ydCBmb3IgdmFy
aWFibGUNCj4gcGF5bG9hZCBzaXplLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9ha2ltIFpoYW5n
IDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9jYW4vZmxl
eGNhbi5jIHwgNDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvY2FuL2ZsZXhjYW4uYyBiL2RyaXZlcnMvbmV0L2Nhbi9m
bGV4Y2FuLmMgaW5kZXgNCj4gMGYzNmVhZmUzYWMxLi4xM2ZkMDg1ZmNmODQgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvY2FuL2Zs
ZXhjYW4uYw0KPiBAQCAtMTQxLDcgKzE0MSw5IEBADQo+ICAjZGVmaW5lIEZMRVhDQU5fVFhfTUJf
UkVTRVJWRURfT0ZGX0ZJRk8JCTgNCj4gICNkZWZpbmUgRkxFWENBTl9UWF9NQl9SRVNFUlZFRF9P
RkZfVElNRVNUQU1QCTANCj4gICNkZWZpbmUgRkxFWENBTl9SWF9NQl9PRkZfVElNRVNUQU1QX0ZJ
UlNUDQo+IAkoRkxFWENBTl9UWF9NQl9SRVNFUlZFRF9PRkZfVElNRVNUQU1QICsgMSkNCj4gLSNk
ZWZpbmUgRkxFWENBTl9JRkxBR19NQih4KQkJQklUKCh4KSAmIDB4MWYpDQo+ICsjZGVmaW5lIEZM
RVhDQU5fSUZMQUcxX01CX05VTQkJMzINCj4gKyNkZWZpbmUgRkxFWENBTl9JRkxBRzFfTUIoeCkJ
CUJJVCh4KQ0KPiArI2RlZmluZSBGTEVYQ0FOX0lGTEFHMl9NQih4KQkJQklUKCh4KSAmIDB4MWYp
DQo+ICAjZGVmaW5lIEZMRVhDQU5fSUZMQUdfUlhfRklGT19PVkVSRkxPVwlCSVQoNykNCj4gICNk
ZWZpbmUgRkxFWENBTl9JRkxBR19SWF9GSUZPX1dBUk4JQklUKDYpDQo+ICAjZGVmaW5lIEZMRVhD
QU5fSUZMQUdfUlhfRklGT19BVkFJTEFCTEUJQklUKDUpDQo+IEBAIC04MjIsOSArODI0LDE1IEBA
IHN0YXRpYyBpbmxpbmUgdTY0IGZsZXhjYW5fcmVhZF9yZWdfaWZsYWdfcngoc3RydWN0DQo+IGZs
ZXhjYW5fcHJpdiAqcHJpdikNCj4gIAlzdHJ1Y3QgZmxleGNhbl9yZWdzIF9faW9tZW0gKnJlZ3Mg
PSBwcml2LT5yZWdzOw0KPiAgCXUzMiBpZmxhZzEsIGlmbGFnMjsNCj4gDQo+IC0JaWZsYWcyID0g
cHJpdi0+cmVhZCgmcmVncy0+aWZsYWcyKSAmIHByaXYtPnJlZ19pbWFzazJfZGVmYXVsdCAmDQo+
IC0JCX5GTEVYQ0FOX0lGTEFHX01CKHByaXYtPnR4X21iX2lkeCk7DQo+IC0JaWZsYWcxID0gcHJp
di0+cmVhZCgmcmVncy0+aWZsYWcxKSAmIHByaXYtPnJlZ19pbWFzazFfZGVmYXVsdDsNCj4gKwlp
ZiAocHJpdi0+dHhfbWJfaWR4ID49IEZMRVhDQU5fSUZMQUcxX01CX05VTSkgew0KPiArCQlpZmxh
ZzIgPSBwcml2LT5yZWFkKCZyZWdzLT5pZmxhZzIpICYgcHJpdi0+cmVnX2ltYXNrMl9kZWZhdWx0
ICYNCj4gKwkJCX5GTEVYQ0FOX0lGTEFHMl9NQihwcml2LT50eF9tYl9pZHgpOw0KPiArCQlpZmxh
ZzEgPSBwcml2LT5yZWFkKCZyZWdzLT5pZmxhZzEpICYgcHJpdi0+cmVnX2ltYXNrMV9kZWZhdWx0
Ow0KPiArCX0gZWxzZSB7DQo+ICsJCWlmbGFnMiA9IHByaXYtPnJlYWQoJnJlZ3MtPmlmbGFnMikg
JiBwcml2LT5yZWdfaW1hc2syX2RlZmF1bHQ7DQo+ICsJCWlmbGFnMSA9IHByaXYtPnJlYWQoJnJl
Z3MtPmlmbGFnMSkgJiBwcml2LT5yZWdfaW1hc2sxX2RlZmF1bHQgJg0KPiArCQkJfkZMRVhDQU5f
SUZMQUcxX01CKHByaXYtPnR4X21iX2lkeCk7DQo+ICsJfQ0KPiANCj4gIAlyZXR1cm4gKHU2NClp
ZmxhZzIgPDwgMzIgfCBpZmxhZzE7DQo+ICB9DQo+IEBAIC04MzYsNyArODQ0LDggQEAgc3RhdGlj
IGlycXJldHVybl90IGZsZXhjYW5faXJxKGludCBpcnEsIHZvaWQgKmRldl9pZCkNCj4gIAlzdHJ1
Y3QgZmxleGNhbl9wcml2ICpwcml2ID0gbmV0ZGV2X3ByaXYoZGV2KTsNCj4gIAlzdHJ1Y3QgZmxl
eGNhbl9yZWdzIF9faW9tZW0gKnJlZ3MgPSBwcml2LT5yZWdzOw0KPiAgCWlycXJldHVybl90IGhh
bmRsZWQgPSBJUlFfTk9ORTsNCj4gLQl1MzIgcmVnX2lmbGFnMiwgcmVnX2VzcjsNCj4gKwl1MzIg
cmVnX3R4X2lmbGFnLCB0eF9pZmxhZ19pZHgsIHJlZ19lc3I7DQo+ICsJdm9pZCBfX2lvbWVtICpy
ZWdfaWZsYWc7DQo+ICAJZW51bSBjYW5fc3RhdGUgbGFzdF9zdGF0ZSA9IHByaXYtPmNhbi5zdGF0
ZTsNCj4gDQo+ICAJLyogcmVjZXB0aW9uIGludGVycnVwdCAqLw0KPiBAQCAtODcwLDEwICs4Nzks
MTggQEAgc3RhdGljIGlycXJldHVybl90IGZsZXhjYW5faXJxKGludCBpcnEsIHZvaWQgKmRldl9p
ZCkNCj4gIAkJfQ0KPiAgCX0NCj4gDQo+IC0JcmVnX2lmbGFnMiA9IHByaXYtPnJlYWQoJnJlZ3Mt
PmlmbGFnMik7DQo+ICsJaWYgKHByaXYtPnR4X21iX2lkeCA+PSBGTEVYQ0FOX0lGTEFHMV9NQl9O
VU0pIHsNCj4gKwkJcmVnX3R4X2lmbGFnID0gcHJpdi0+cmVhZCgmcmVncy0+aWZsYWcyKTsNCj4g
KwkJdHhfaWZsYWdfaWR4ID0gRkxFWENBTl9JRkxBRzJfTUIocHJpdi0+dHhfbWJfaWR4KTsNCj4g
KwkJcmVnX2lmbGFnID0gJnJlZ3MtPmlmbGFnMjsNCj4gKwl9IGVsc2Ugew0KPiArCQlyZWdfdHhf
aWZsYWcgPSBwcml2LT5yZWFkKCZyZWdzLT5pZmxhZzEpOw0KPiArCQl0eF9pZmxhZ19pZHggPSBG
TEVYQ0FOX0lGTEFHMV9NQihwcml2LT50eF9tYl9pZHgpOw0KPiArCQlyZWdfaWZsYWcgPSAmcmVn
cy0+aWZsYWcxOw0KPiArCX0NCj4gDQo+ICAJLyogdHJhbnNtaXNzaW9uIGNvbXBsZXRlIGludGVy
cnVwdCAqLw0KPiAtCWlmIChyZWdfaWZsYWcyICYgRkxFWENBTl9JRkxBR19NQihwcml2LT50eF9t
Yl9pZHgpKSB7DQo+ICsJaWYgKHJlZ190eF9pZmxhZyAmIHR4X2lmbGFnX2lkeCkgew0KPiAgCQl1
MzIgcmVnX2N0cmwgPSBwcml2LT5yZWFkKCZwcml2LT50eF9tYi0+Y2FuX2N0cmwpOw0KPiANCj4g
IAkJaGFuZGxlZCA9IElSUV9IQU5ETEVEOw0KPiBAQCAtODg1LDcgKzkwMiw3IEBAIHN0YXRpYyBp
cnFyZXR1cm5fdCBmbGV4Y2FuX2lycShpbnQgaXJxLCB2b2lkICpkZXZfaWQpDQo+ICAJCS8qIGFm
dGVyIHNlbmRpbmcgYSBSVFIgZnJhbWUgTUIgaXMgaW4gUlggbW9kZSAqLw0KPiAgCQlwcml2LT53
cml0ZShGTEVYQ0FOX01CX0NPREVfVFhfSU5BQ1RJVkUsDQo+ICAJCQkgICAgJnByaXYtPnR4X21i
LT5jYW5fY3RybCk7DQo+IC0JCXByaXYtPndyaXRlKEZMRVhDQU5fSUZMQUdfTUIocHJpdi0+dHhf
bWJfaWR4KSwgJnJlZ3MtPmlmbGFnMik7DQo+ICsJCXByaXYtPndyaXRlKHR4X2lmbGFnX2lkeCwg
cmVnX2lmbGFnKTsNCj4gIAkJbmV0aWZfd2FrZV9xdWV1ZShkZXYpOw0KPiAgCX0NCj4gDQo+IEBA
IC0xMjQ0LDggKzEyNjEsMTMgQEAgc3RhdGljIGludCBmbGV4Y2FuX29wZW4oc3RydWN0IG5ldF9k
ZXZpY2UgKmRldikNCj4gIAlwcml2LT50eF9tYl9pZHggPSBwcml2LT5tYl9jb3VudCAtIDE7DQo+
ICAJcHJpdi0+dHhfbWIgPSBmbGV4Y2FuX2dldF9tYihwcml2LCBwcml2LT50eF9tYl9pZHgpOw0K
PiANCj4gLQlwcml2LT5yZWdfaW1hc2sxX2RlZmF1bHQgPSAwOw0KPiAtCXByaXYtPnJlZ19pbWFz
azJfZGVmYXVsdCA9IEZMRVhDQU5fSUZMQUdfTUIocHJpdi0+dHhfbWJfaWR4KTsNCj4gKwlpZiAo
cHJpdi0+dHhfbWJfaWR4ID49IEZMRVhDQU5fSUZMQUcxX01CX05VTSkgew0KPiArCQlwcml2LT5y
ZWdfaW1hc2sxX2RlZmF1bHQgPSAwOw0KPiArCQlwcml2LT5yZWdfaW1hc2syX2RlZmF1bHQgPSBG
TEVYQ0FOX0lGTEFHMl9NQihwcml2LT50eF9tYl9pZHgpOw0KPiArCX0gZWxzZSB7DQo+ICsJCXBy
aXYtPnJlZ19pbWFzazFfZGVmYXVsdCA9IEZMRVhDQU5fSUZMQUcxX01CKHByaXYtPnR4X21iX2lk
eCk7DQo+ICsJCXByaXYtPnJlZ19pbWFzazJfZGVmYXVsdCA9IDA7DQo+ICsJfQ0KPiANCj4gIAlw
cml2LT5vZmZsb2FkLm1haWxib3hfcmVhZCA9IGZsZXhjYW5fbWFpbGJveF9yZWFkOw0KPiANCj4g
LS0NCj4gMi4xNy4xDQoNCg==
