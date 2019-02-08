Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CCEC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDA62086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SmKekwhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfBHPzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:55:12 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:61384 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbfBHPzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:55:11 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5da6590000>; Fri, 08 Feb 2019 23:55:05 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 Feb 2019 07:55:05 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 08 Feb 2019 07:55:05 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 15:55:04 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.59) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 8 Feb 2019 15:55:04 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3589.namprd12.prod.outlook.com (20.178.197.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Fri, 8 Feb 2019 15:55:01 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 15:55:01 +0000
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
Subject: RE: [PATCH V15 4/6] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V15 4/6] i2c: tegra: Add DMA support
Thread-Index: AQHUvy64ygjLqqj+r0yzTYtI5VJ73KXV2pEAgAAvldCAAARMAA==
Date:   Fri, 8 Feb 2019 15:55:01 +0000
Message-ID: <BYAPR12MB3398382FF9052AE466CE29ECC2690@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549576040-15907-1-git-send-email-skomatineni@nvidia.com>
 <1549576040-15907-4-git-send-email-skomatineni@nvidia.com>
 <7806f2cd-72b4-6ae3-b75f-0fc74fb62b95@gmail.com>
 <BYAPR12MB3398BE6DA6F1E82E5F2525C2C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB3398BE6DA6F1E82E5F2525C2C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3589;6:9vkbsIuWpOxwNUBI2y4I/RT78QKC+uiaDMzY8fa8R2ZcPrxjb+NIWetOhrU+S1GPSGcxLGiVtfqBOwTAiHMd+tTb2BOmX/KrnhFEV+T9dwkTAPQ3CGy4QUZi/3vpr6aG+vYjg/ErzUN4pY6p8T3mcGhosa13YDBfKQAhQjJ4LEXyEf62pRJSMvNMtpce26oiSBeyEomLo1+uPROYR2/sWJWQWAbMiduleZ3rx6LWL+7PnP+U4NX1ri9WJdk5mkpPlx8q7qpONt4tLrF+k9UUyHDWnH/7R9yHidCVHf25TQ1YhoQrfEZeTf9OaVKe12s5el74VdGsfUyycmrHmHv8W6CifIFXa6Fp0OMvYqSOq6AT8QXfDsKOOfD/EPqX17oIn5YSj22wV1UIi1GVVWMkRwj+YLikNKDZ1Tp6HLl5Q835Vl7aVGC1xjJpsD3ueWYkPwase9ujUv5bYkOsc4DwMQ==;5:2rRDErI2myUYcObg8lhwOHDnpwM2see1GPFTGLPEbRBUBKiBTJoX7LXxh+lJOR85DOV3UgT1BfcCCViSs63z2tenRMei007114jj1wCCmvxA7H5BIS7fjhgbqxuqwIRGq/QDJHpH39nV9xCb+141qD2cRiSO5dD7jAGuBRDT4zDCC6rZCAPsENsTyDE0ldc/7FPmaZiOAdbzLvs0IaGp1Q==;7:Jm4H/VoR1oNVCuDU/JrkqOc27nO0BbopeCGmW2fWpNFO9pWk1w7CAm4jIIZXGHCnphvpxhXTtSL3VS8E3o0Rb9I8sMaHj+FuVrOCyJCBCEm8hJ+JN7C0N8TEXQIF6vDqX86zV7VkwWT30CI9AxDZfA==
x-ms-office365-filtering-correlation-id: 6c79cce3-2d61-4c86-a9ff-08d68dddc8ce
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3589;
x-ms-traffictypediagnostic: BYAPR12MB3589:
x-microsoft-antispam-prvs: <BYAPR12MB3589DDE0309C19278147CAF3C2690@BYAPR12MB3589.namprd12.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(376002)(346002)(366004)(39860400002)(396003)(189003)(199004)(2501003)(8936002)(25786009)(81166006)(8676002)(81156014)(93886005)(2906002)(66066001)(102836004)(446003)(97736004)(26005)(4326008)(186003)(11346002)(476003)(106356001)(105586002)(486006)(86362001)(71200400001)(71190400001)(68736007)(6506007)(9686003)(99286004)(6636002)(7696005)(76176011)(3846002)(6116002)(229853002)(478600001)(2940100002)(55016002)(14444005)(256004)(33656002)(305945005)(53936002)(93156006)(6246003)(110136005)(54906003)(7736002)(316002)(14454004)(74316002)(6436002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3589;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kqFJV20DnBhTcUzjYIJNsC8UZzOfoL42TkXe93hxkzNsMUz4iZstad1yA6PlkpyaL5oNBD89E8wLIaTx7oT2UN7Sn17/H5dON7XvxFoIcIv1aAnbzlR/qpPSp6iND+oXlz6JziJqHGxGS+TlqP36Kf0JUqWM/sWq4ihhI+xSjXbQMxVl/sn5nfFKBNmE1J2kOK5QOVhdQ3qomH/oep3p1IyHQ+XRj3F1RjpeIbkAj/hBDWusHPAtxCLHxtTHjvRfRaKXrYmEpI+WK6KNL5sRadMJv81ZC6BpeYuAGlN2IIM3lt0yj33QrOyoVJ/4BY8qSWXQhv6qw631CoULsKpAVswwx8b7jloo/yc7rkNYsl2TxwZezSBaQCKBPrO827Eau68UZSDiCceWYUeGRGxTijncnskuMGr3wv8eQxytuEo=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c79cce3-2d61-4c86-a9ff-08d68dddc8ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 15:55:01.3978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3589
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549641305; bh=tifPBQpCfvX8g+5KiRnbsE7bvCtbFVObxCy6tNsjp/0=;
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
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=SmKekwhgfHKR8QtLFPgYAB5dJK/b+LObothL/7SxMphCQtWBjrqlad5kMI9M7nfBv
         vYknIEgXG/n6ULWU1bpzTTJ+Ce6NmuAuSEpcLGfiEb6rntqyiFq1zWriK47kh4jvp0
         kzhKeASVo62x5yD0S5FVp4tHmfHcOxpfaK3GKWrCW0+iAhwCbZTO+n8mYPPkSPKHII
         z3HD+iKlIf4qtKqEn7+qJmVjnIskDk8butuB09TJ3RJ3zlDFf90jvFPSHMmdH941to
         AhtzaJmMTdA7YLJyNOsSpRH6i1iEARk+H+wxC7jE1c2AVlx04my/2tumAhiLMBNwFh
         JPGmnMSiqz7NA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gUGxlYXNlIHVzZSAicmVsZWFzZV9kbWE6IiB2YXJpYW50IHRoYXQgSSBzdWdnZXN0ZWQg
aW4gdGhlIGNvbW1lbnQgdG8gdjE0IGJlY2F1c2U6DQo+ID4NCj4gPiAxKSBJdCdzIGp1c3QgYSBn
b29kIChhbmQgY29tbW9uLXN0eWxlIGluIGtlcm5lbCkgdG9uZSB0byB1bndpbmQgZXJyb3JzIGhh
bmRsaW5nIGluIHRoZSBvcHBvc2l0ZSBvcmRlciwgaXQgbWFrZXMgY29kZSBtb3JlIHN0cmFpZ2h0
IGZvcndhcmQgYW5kIGhlbHBzIHRvIGF2b2lkIHNpbGx5IG1pc3Rha2VzLg0KPiA+DQo+ID4gMikg
SXQga2VlcHMgdGhlIGN1cnJlbnQgY29kZSBjb25zaXN0ZW50IGluIHJlZ2FyZHMgdG8gcHJvYmUg
ZXJyb3ItaGFuZGxpbmcuDQo+ID4NCj4NCj4gQ2FuIG1vdmUgdGVncmFfaTJjX3JlbGVhc2VfZG1h
IHVuZGVyIHRoZSBzYW1lIGRpc2FibGVfZGl2X2NsayBsYWJlbCBiZWZvcmUgY2xrX2Rpc2FibGUN
Cj4NCj4gT3JkZXIgaW4gcHJvYmUgaXMNCgljbGtfcHJlcGFyZQ0KCWkyY19ydW50aW1lX3Jlc3Vt
ZQ0KCWNsa19lbmFibGUgaW4gY2FzZSBvZiBtdWx0aW1hc3RlciBtb2RlDQoJaTJjX2luaXRfZG1h
DQo+DQo+IHVud2luZGluZyBzaG91bGQgYmUgb3JkZXIgaXMNCglyZWxlYXNlX2RtYQ0KCWRpc2Fi
bGVfZGl2X2Nsaw0KCWRpc2FibGVfcnBtDQoJdW5wcmVwYXJlZA0KPg0KPiBQcm9iZSBmYWlsdXJl
IGZyb20gdGVncmFfaTJjX2luaXRfZG1hLCB0ZWdyYV9pMmNfaW5pdCwgZGV2bV9yZXF1ZXN0X2ly
cSwgaTJjX2FkZF9udW1iZXJlZF9hZGFwdGVyIGFsbCBvZiB0aGVtIHBlcmZvcm0gZ290byBkaXNh
YmxlX2Rpdl9jbGsNCj4NCj4gSSBjYW4gYWRkIHRlZ3JhX2kyY19yZWxlYXNlX2RtYSBiZWZvcmUg
cGVyZm9ybWluZyBjbG9jayBkaXNhYmxlIHVuZGVyIHNhbWUgZGlzYWJsZV9kaXZfY2xrIHNvIGFs
bCBleGlzdGluZyBkaXNhYmxlX2Rpdl9jbGsgbGFiZWxzIHJlbWFpbiBzYW1lLg0KPiBPdGhlcndp
c2UgYWRkaW5nIG5ldyBsYWJlbCByZWxlYXNlX2RtYSBjYXVzZXMgYWxsIGdvdG8gZGlzYWJsZV9k
aXZfY2xrIHN0YXRlbWVudCBhbHNvIHRvIGJlIGNoYW5nZWQgYnV0IGl0cyBzYW1lIGFzIGFkZGlu
ZyByZWxlYXNlX2RtYSB1bmRlciBkaXNhYmxlX2Rpdl9jbGsgYWJvdmUgdGhlIGNsa19kaXNhYmxl
Lg0KPg0KDQpPSywgcGxlYXNlIGlnbm9yZSBhYm92ZS4gd2lsbCBhZGQgcmVsZWFzZV9kbWEgdG8g
c2hvdyBleHBsaWNpdGx5IGZvciByZWFkYWJpbGl0eS4NCg0KPiA+ID4gIA0KPiA+ID4gIGRpc2Fi
bGVfcnBtOg0KPiA+ID4gIAlwbV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7DQo+ID4NCj4g
Pg0KPiA+IFtzbmlwXQ0KPiA+DQo+ID4gUGxlYXNlIGFsc28gYWRkcmVzcyBteSBjb21tZW50IHRv
IHRoZSAiZml4IG1heGltdW0gdHJhbnNmZXIgc2l6ZSIgcGF0Y2guIEFuZCBwbGVhc2UgYWRkIFdv
bGZyYW0gU2FuZyB0byB0aGUgQ0MgbGlzdC4NCj4gPg0KPiA+IExvb2tzIGxpa2UgdjE2IHNob3Vs
ZCBiZSB0aGUgZmluYWwsIHNvIHdpdGggZXZlcnl0aGluZyBiZWluZyBhZGRyZXNzZWQ6DQo+ID4N
Cj4gPiBSZXZpZXdlZC1ieTogRG1pdHJ5IE9zaXBlbmtvIDxkaWdldHhAZ21haWwuY29tPg0KPiA+
IFRlc3RlZC1ieTogRG1pdHJ5IE9zaXBlbmtvIDxkaWdldHhAZ21haWwuY29tPg0KDQoNCg==
