Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60398C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2605C218AE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="NVu9EcJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfAHK46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:56:58 -0500
Received: from mail-eopbgr780041.outbound.protection.outlook.com ([40.107.78.41]:15679
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbfAHK45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogn0B863yWmxHcgILIk5xqFjG9BZII0RK/9N0/Q8oIQ=;
 b=NVu9EcJ5Mv4k+tWX0c/xbgfkzXRuYXBQAgWmb0K1PJcxhMVtd/7hdV24nS7U983sfYYp2LupgH7EDjl3FRkHQMRcST+zpqIYzfVSMce1HCdtgk2HyGAu4O9TgrOB9sOBatC2YLaug0hOvh4TVE2GgeZ8X5MnrygpT0lIh1HcrIs=
Received: from BYAPR05MB5592.namprd05.prod.outlook.com (20.177.186.153) by
 BYAPR05MB6103.namprd05.prod.outlook.com (20.178.54.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.3; Tue, 8 Jan 2019 10:56:47 +0000
Received: from BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::4a1:2561:2487:5919]) by BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::4a1:2561:2487:5919%4]) with mapi id 15.20.1516.010; Tue, 8 Jan 2019
 10:56:47 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH 4/4] drm/vmwgfx: unwind spaghetti code in
 vmw_dma_select_mode
Thread-Topic: [PATCH 4/4] drm/vmwgfx: unwind spaghetti code in
 vmw_dma_select_mode
Thread-Index: AQHUpMzftKaccRYMP0+T6ddYvyW1tqWlOBaA
Date:   Tue, 8 Jan 2019 10:56:47 +0000
Message-ID: <92880e1e58f38332ac7ece81cde2c791465b18a2.camel@vmware.com>
References: <20190105080108.14837-1-hch@lst.de>
         <20190105080108.14837-5-hch@lst.de>
In-Reply-To: <20190105080108.14837-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB6103;20:Ysa+8f7uOHnZJ5BOge3+7z78uvkrHPHpWMGc3HpBb/jnxI8V2rUrt9Tg3UTtihgD7Z505Ia4HpnSCvOweKjE/P55HLlahFdAq2PRDcoXuHP9HuPp4rwGYRMG7l+M7ADOR/aZqWWEdLPG675uhPXyMqXJ+F4evrn1VKScidkDr0w=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d6832958-9d0a-4312-08d4-08d67557fc79
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB6103;
x-ms-traffictypediagnostic: BYAPR05MB6103:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BYAPR05MB61039CAC7772EB3EB6BB016AA18A0@BYAPR05MB6103.namprd05.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(366004)(199004)(189003)(1730700003)(6512007)(2351001)(53936002)(6916009)(478600001)(14454004)(68736007)(2501003)(5660300001)(97736004)(2616005)(446003)(11346002)(76176011)(186003)(26005)(102836004)(6506007)(106356001)(3846002)(6116002)(305945005)(7736002)(486006)(118296001)(99286004)(36756003)(476003)(256004)(316002)(71190400001)(71200400001)(54906003)(6436002)(86362001)(2906002)(8936002)(5640700003)(229853002)(6246003)(6486002)(81166006)(105586002)(81156014)(25786009)(4326008)(8676002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6103;H:BYAPR05MB5592.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xUbFdGrtRN16+dplkDxyK0eZWX/44x2+rzQNAyTAR4orjI7HCgPCrlY/D8IiIFcQGs98OjreS24haxv7tHBY/Y4EO+M3gAxdca8y8yweOttf3aRSjZKwV+4iAwj3uNayuu+2jNLcwX+FLr0bagPX/i9laA7DdJeb6JqJ1lrewseNTom8QhgHiYixkL8i+o3dbUdwJqqA8DvDPmIxyZt/G56uW2QRsiCU8kIRMHthtMOAGYP3Iplq7JiFavbET19z4900qYKP2PfBk0LNB7YlDyX+3qkQ7Lnswn3pBgQ/f6bEhY2wWrJZ51R8RPwJPl9g
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A53589A84A5D9E4E8641EB49A502A1FA@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6832958-9d0a-4312-08d4-08d67557fc79
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 10:56:47.6698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDE5LTAxLTA1IGF0IDA5OjAxICswMTAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gSnVzdCB1c2UgYSBzaW1wbGUgaWYvZWxzZSBjaGFpbiB0byBzZWxlY3QgdGhlIERNQSBt
b2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+
DQoNClJldmlld2VkLWJ5OiBUaG9tYXMgSGVsbHN0cm9tIDx0aGVsbHN0cm9tQHZtd2FyZS5jb20+
DQoNCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2Rydi5jIHwgMjUg
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKSwgMTkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L3Ztd2dmeC92bXdnZnhfZHJ2LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9k
cnYuYw0KPiBpbmRleCBjMjA2MGY2Y2M5ZTguLjg2Mzg3NzM1YTkwYiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3Ztd2dmeC92bXdnZnhfZHJ2LmMNCj4gQEAgLTU2NiwzNCArNTY2LDIxIEBAIHN0YXRpYyBp
bnQgdm13X2RtYV9zZWxlY3RfbW9kZShzdHJ1Y3QNCj4gdm13X3ByaXZhdGUgKmRldl9wcml2KQ0K
PiAgCQlbdm13X2RtYV9tYXBfcG9wdWxhdGVdID0gIktlZXBpbmcgRE1BIG1hcHBpbmdzLiIsDQo+
ICAJCVt2bXdfZG1hX21hcF9iaW5kXSA9ICJHaXZpbmcgdXAgRE1BIG1hcHBpbmdzIGVhcmx5LiJ9
Ow0KPiAgDQo+IC0JaWYgKGludGVsX2lvbW11X2VuYWJsZWQpIHsNCj4gKwlpZiAodm13X2ZvcmNl
X2NvaGVyZW50KQ0KPiArCQlkZXZfcHJpdi0+bWFwX21vZGUgPSB2bXdfZG1hX2FsbG9jX2NvaGVy
ZW50Ow0KPiArCWVsc2UgaWYgKGludGVsX2lvbW11X2VuYWJsZWQpDQo+ICAJCWRldl9wcml2LT5t
YXBfbW9kZSA9IHZtd19kbWFfbWFwX3BvcHVsYXRlOw0KPiAtCQlnb3RvIG91dF9maXh1cDsNCj4g
LQl9DQo+IC0NCj4gLQlpZiAoISh2bXdfZm9yY2VfaW9tbXUgfHwgdm13X2ZvcmNlX2NvaGVyZW50
KSkgew0KPiArCWVsc2UgaWYgKCF2bXdfZm9yY2VfaW9tbXUpDQo+ICAJCWRldl9wcml2LT5tYXBf
bW9kZSA9IHZtd19kbWFfcGh5czsNCj4gLQkJRFJNX0lORk8oIkRNQSBtYXAgbW9kZTogJXNcbiIs
IG5hbWVzW2Rldl9wcml2LQ0KPiA+bWFwX21vZGVdKTsNCj4gLQkJcmV0dXJuIDA7DQo+IC0JfQ0K
PiAtDQo+IC0jaWZkZWYgQ09ORklHX1NXSU9UTEINCj4gLQlpZiAoc3dpb3RsYl9ucl90YmwoKSkN
Cj4gKwllbHNlIGlmIChJU19FTkFCTEVEKENPTkZJR19TV0lPVExCKSAmJiBzd2lvdGxiX25yX3Ri
bCgpKQ0KPiAgCQlkZXZfcHJpdi0+bWFwX21vZGUgPSB2bXdfZG1hX2FsbG9jX2NvaGVyZW50Ow0K
PiAgCWVsc2UNCj4gLSNlbmRpZg0KPiAgCQlkZXZfcHJpdi0+bWFwX21vZGUgPSB2bXdfZG1hX21h
cF9wb3B1bGF0ZTsNCj4gIA0KPiAtb3V0X2ZpeHVwOg0KPiAtCWlmIChkZXZfcHJpdi0+bWFwX21v
ZGUgPT0gdm13X2RtYV9tYXBfcG9wdWxhdGUgJiYNCj4gLQkgICAgdm13X3Jlc3RyaWN0X2lvbW11
KQ0KPiArCWlmIChkZXZfcHJpdi0+bWFwX21vZGUgPT0gdm13X2RtYV9tYXBfcG9wdWxhdGUgJiYN
Cj4gdm13X3Jlc3RyaWN0X2lvbW11KQ0KPiAgCQlkZXZfcHJpdi0+bWFwX21vZGUgPSB2bXdfZG1h
X21hcF9iaW5kOw0KPiAgDQo+IC0JaWYgKHZtd19mb3JjZV9jb2hlcmVudCkNCj4gLQkJZGV2X3By
aXYtPm1hcF9tb2RlID0gdm13X2RtYV9hbGxvY19jb2hlcmVudDsNCj4gLQ0KPiAgCURSTV9JTkZP
KCJETUEgbWFwIG1vZGU6ICVzXG4iLCBuYW1lc1tkZXZfcHJpdi0+bWFwX21vZGVdKTsNCj4gLQ0K
PiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo=
