Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92853C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5882B21904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Jm0NxIGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfBGPLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:11:17 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:28673 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfBGPLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:11:17 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5c4a920000>; Thu, 07 Feb 2019 23:11:14 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 07 Feb 2019 07:11:12 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 07 Feb 2019 07:11:12 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 7 Feb
 2019 15:11:10 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.52) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 7 Feb 2019 15:11:10 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3494.namprd12.prod.outlook.com (20.178.196.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 7 Feb 2019 15:11:07 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 15:11:07 +0000
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
Subject: RE: [PATCH V14 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V14 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvlB3grXi65/4z0qjAfijKk4nv6XUbM4AgAADlOA=
Date:   Thu, 7 Feb 2019 15:11:06 +0000
Message-ID: <BYAPR12MB3398712D185CCCB345EB2B5BC2680@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
 <a6b1acbd-9be0-62b7-29bb-081d93ee92fb@gmail.com>
In-Reply-To: <a6b1acbd-9be0-62b7-29bb-081d93ee92fb@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3494;6:/7Ze7xQSZu+XbG/haxhxv4Gf+NNEVBpnKQ7gnMm+BmYS4Escf0yXXLb3FCKN4/tmlkYpZOZUwxMlzbWp5xeyGnLnYpfIkkP+v+jCqwIL+cqaykMQ8rv4dPx7Mvya6hfTpSHl3Q/NX8Tz/orN2E1ErV+F154Ctcvb734vcx5WPhE8ym1nT7bjjk2XDAF0vwk4Yledq8y8xl+1QTilw3/oa0nFHTz2SMnk+wrQAAQ0p4maX8YocTsDSearo3VqW2aTiFL3cIuRKgznyafCrd9noVXYwah0a8HcUae2PGt2NcDCW19fLVKobP2y2bj2wt4DrseVZS5cW1lmHG3c692DgsimciX9pQXX4/ZnixcJMU/tAL9pMjrVYezj2utFrgQqFu+zONvj61E8hS0LV/7jKiUZ3HZ9EFoNyshBSsBWXSU9d50PZdF2ESsMndZEukIwaDjdtJsLqP41RojQXVFDrw==;5:ZofSVbeTcxGQB+6UDl2OYhIc3pJHSq1CW0yMdPQGhG8s5Q8DwATt2yHlZjdkTqHH06FYaPVU7pA3eErLZLuAL90Mye6gOHQL95tq527TV+Yb7MllR2TA4VS98EHGxe+vnGW1HcSe7jJoblEA3gFy+jw+1dE43+sASBejeBwxAWS7C1ENGXSzLIjAUoapLy+kYXN3ZMxO/ET6ryB1TR9FUg==;7:44dlVQcgWVZUqRBoyn0gZXGPdyFgyD3jiop0iMufKScqGTkIqvz10DDjn37iPeon/0E+9sZWhK+pUZnxkZtBizFerTHlyEAbHuvGyk8J0fmR+GdY4MFP7Pc8993w0F5HM6p3YaAKOf1Dl6U11znKQw==
x-ms-office365-filtering-correlation-id: fe0d1116-51c3-430b-adaa-08d68d0e7c3e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3494;
x-ms-traffictypediagnostic: BYAPR12MB3494:
x-microsoft-antispam-prvs: <BYAPR12MB3494A5E53D510020767E5E93C2680@BYAPR12MB3494.namprd12.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(346002)(376002)(366004)(136003)(189003)(199004)(76176011)(476003)(110136005)(106356001)(14454004)(74316002)(446003)(229853002)(486006)(2906002)(54906003)(11346002)(68736007)(6506007)(33656002)(256004)(97736004)(316002)(105586002)(71200400001)(14444005)(478600001)(305945005)(7736002)(71190400001)(26005)(81156014)(8676002)(186003)(81166006)(9686003)(55016002)(66066001)(8936002)(4744005)(102836004)(7696005)(2501003)(6636002)(6246003)(4326008)(86362001)(6116002)(3846002)(6436002)(25786009)(99286004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3494;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Lih734UKGec6el2qJHRI/546Gg10PE+PSe2zLWAMc7UECfijbQ1UYErFtOsCt2G2SGieaTVBc+BCPzQm6XPDSduHfcwKFDwtu2hiUEVi6CoViIaIhBF3UnSASE1OhkHfAi5CW8PcxwYyAi1mHR8OS7infwJagxdqKmHnEjIS+UUSFlLapL/YRnuMbenzoAUXcJKrb/I0kQXnJbPlk2qr6nrrCQLKHhmYZQPCDKJfvassCUf/Sc7oqRm0khdlstBve/BHI1RDfmOt3AjAooX0hbfKIxvVVecHM46KJQXZKHeu+pyK5+JinAN02+APECT6acm6Ma9mUfC+VVXEOsrKnuXnBBvGcowbhbu+xuYmMTvIKQnmOnygzGaWG5gvzzcnKZLr8nlUwE78Ty5kQ0oRPFsYP81OQK8OjNpONcdsJtQ=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0d1116-51c3-430b-adaa-08d68d0e7c3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 15:11:07.0433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3494
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549552274; bh=oqWAkA2A0JfguHY7lArmcLPq68sX8ySyoNmjjQRYe/8=;
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
        b=Jm0NxIGVfSHgS+oT6Z6MdPZeSU45tCzBqTnXJZ03DgPrHk1Y2xMGd0h+pnBx44uls
         G2liU0WMjPXarOtUMd+5T5dIoveUqgvUbBLcLe/dKYNno4FG5UC/p1bJYtwXvC2Bm/
         48l8Jyiw4/yDVuZqk5pIkYF1ig105K6MoncSyCHYvKsJLx4nDTU5gad79viSeHkFSS
         LcxWnWHf4gIpfb503aKEf8cdwjlCMgQM6wjFVtIsfta1We4mWaWaEZQ22VxT1BQxHI
         g+oGZLJDD5zmdrmPpEWqLa+gNBNHoj1SgYPPTQdV2yU/KOnnhbw9hIqG6R7dgBsYfG
         V8DDUtmeYR9vg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gDQo+ID4gQEAgLTExMjQsNiArMTQ1MywxMCBAQCBzdGF0aWMgaW50IHRlZ3JhX2kyY19w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJCX0NCj4gPiAgCX0NCj4g
PiAgDQo+ID4gKwlyZXQgPSB0ZWdyYV9pMmNfaW5pdF9kbWEoaTJjX2Rldik7DQo+ID4gKwlpZiAo
cmV0IDwgMCkNCj4gPiArCQlnb3RvIGRpc2FibGVfZGl2X2NsazsNCj4gPiArDQo+ID4gIAlyZXQg
PSB0ZWdyYV9pMmNfaW5pdChpMmNfZGV2KTsNCj4gPiAgCWlmIChyZXQpIHsNCj4gPiAgCQlkZXZf
ZXJyKCZwZGV2LT5kZXYsICJGYWlsZWQgdG8gaW5pdGlhbGl6ZSBpMmMgY29udHJvbGxlclxuIik7
DQo+DQo+DQo+IE1pc3NpbmcgRE1BIHJlc291cmNpbmcgcmVsZWFzZSBvbiBwcm9iZSBmYWlsdXJl
Lg0KDQpJZiBwcm9iZSBmYWlscyBkdWUgdG8gb3RoZXIgcmVhc29ucywgdGhlbiBJMkMgaW50ZXJm
YWNlIHdpbGwgbm90IGJlIGF2YWlsYWJsZSBhbmQgYm9vdCB3aWxsIG5vdCBldmVuIGhhcHBlbi4N
CkRvIHdlIG5lZWQgRE1BIHJlc291cmNpbmcgcmVsZWFzZT8NCg0K
