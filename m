Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193E3C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD6220869
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="F96X0sU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfAaVq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:46:57 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:32621 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfAaVq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:46:57 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c536ccc0000>; Fri, 01 Feb 2019 05:46:52 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 31 Jan 2019 13:46:52 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 31 Jan 2019 13:46:52 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 21:46:51 +0000
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.51) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 31 Jan 2019 21:46:50 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3528.namprd12.prod.outlook.com (20.179.94.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Thu, 31 Jan 2019 21:46:48 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 21:46:48 +0000
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
Subject: RE: [PATCH V8 3/5] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V8 3/5] i2c: tegra: Add DMA Support
Thread-Index: AQHUuSyS8D4y2PEYbkigLw9+iOz1C6XJfImAgAADNwCAABXfQIAACAqAgAAEBwCAAEf/wA==
Date:   Thu, 31 Jan 2019 21:46:48 +0000
Message-ID: <BYAPR12MB3398D3DCD0DEACD67A58C75FC2910@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
 <1548915387-28826-3-git-send-email-skomatineni@nvidia.com>
 <4663c7b9-d306-1cd4-1bdc-f7be84af0667@gmail.com>
 <8a88f8ee-24d3-00ac-f1fa-c43b576ed82c@gmail.com>
 <BYAPR12MB3398CFEE7E912513AE48DD2FC2910@BYAPR12MB3398.namprd12.prod.outlook.com>
 <e50a353c-94c4-1a47-92a4-5f41f4f64aa7@gmail.com>
 <c2676c08-83d7-2ac9-ce34-c7c7f86d798e@gmail.com>
In-Reply-To: <c2676c08-83d7-2ac9-ce34-c7c7f86d798e@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3528;6:V+RaWRVLcgcbq2VzVBu69Sax4uEbmHQ3iZbarNATwA7pJXkhWREjZBI0KPayRTbmFGzv8UXM/cG58s3PqTI1gvzYLgAgIvL5QQ2ZgvalNox3DRGetf11Vq1eIfsWuFzdkpcj/O2PfaYcq1OvMxmcmOFHdjTJSqvGwtVNi/EDZ/8yEmod0jeEn3XujZb8gID4eHnMSdjhn6xqq6OVt5lOdYSj5ggogBckfGErcqXb9CgPpSFyC+r+UNsCrGI5RsHfs0WQgzor3O1oto2d6LKYJ7GdaRhXSQI8vj23uSop/pS6dHvBFq/iObZCsn65/Iev638a1256oTtBWS5cEkam94/o41rddEN18Xf8h5vBwQ2qKIdHydLuzDPr3UMOYxpJV4PiAGdxSaybE/9i0+tp8vdtaiYqhvFTWHVZNu/AmeMuerlOtbrGov5wy+dOWmep8W491KDbc7qP49MgGL6ZXA==;5:yrOy/+CyHbSsmQ9IDZLnSY1Nd0TAnPdsZbOlH0jG7KXnwl4RGDIwZIeqHpFcriRMPTMigZgEpfFc7aZisZDxqpjNWcQshVwm/tg+49S/AMkA2iLOKajDVHaJzxVRMtbgQ9rpLJkxCzYZQxI0YNcsznLpOBOTrC5t3nVCndcqE7CCBji+NmCuT1CCmKYRgGp8UNNXODiuHMfFud7+M9MKog==;7:IhZUO/SHgLhPRX/ogKuKEUzYkf6M2ZNT9ckHsgP6M9AOyQez5SRm4hCm6WG41ieadQ3yV60dor8yDcw+SI1V0x8p2nDYtuhCsyr0/Fc8U53qqq/pNj2zj1bg2GtzaQlUfLXxS6UJjoR5SyTDKjhVhg==
x-ms-office365-filtering-correlation-id: 53c3fb9a-7997-43d1-dff0-08d687c59a2c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3528;
x-ms-traffictypediagnostic: BYAPR12MB3528:
x-microsoft-antispam-prvs: <BYAPR12MB3528659989060315030BA6F1C2910@BYAPR12MB3528.namprd12.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(136003)(346002)(376002)(189003)(199004)(446003)(6506007)(476003)(26005)(11346002)(33656002)(102836004)(14454004)(68736007)(2906002)(486006)(186003)(7696005)(229853002)(478600001)(316002)(76176011)(110136005)(54906003)(4744005)(2501003)(74316002)(7736002)(81166006)(81156014)(6436002)(99286004)(305945005)(8936002)(93886005)(8676002)(106356001)(4326008)(39060400002)(66066001)(6246003)(105586002)(71190400001)(6116002)(3846002)(71200400001)(25786009)(86362001)(9686003)(55016002)(256004)(53936002)(6636002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3528;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I7vHPSE1nzqWSOrn2kERSJQdXl8lYNFYl7E9NiLuKPyUswQujBM2VUNsMiyEI7fDLF7QY9igHlb+4Z5B71pdC4bW9jklzF1+kpRdg5Zr/rr0hOKw/PHCTwa91ZE8yyP+5uMKOhzjy3ulEcNFydt77U5Ymjfcp4ezbmFszewTZSI0cwwQ2ssJ235ZN8fF8MtVscajrBRi6ETpTLI1IJh019PuoJAyMvmvXwyEeceZ2E1N1nDbc9M/0Hv1bsVo9Xzaqb1zIi48exkN4Zype58AlkFvMvLWbAoSCO6jqCxkMwvSKvuI6JVKp/xgqwUZ7lllsugsMp93WePVEUGLDJ2dy/uKewjv+FiIqa8ROVaeyui+662GgFrRY9zyKQtIxiOiEzO600F1ZNcz4m5xHsZWzqeYltZgPSRmWFzlP8lPmhQ=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c3fb9a-7997-43d1-dff0-08d687c59a2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 21:46:48.2942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3528
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548971212; bh=Agb1uLvAVDjo8gyNr3UZSzvoX4XhRlZ66LALCBvGsWk=;
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
        b=F96X0sU05V52n13lXKb2kMLOK95jln81/pgsD53yUUKJA8MScx9dMnA7IUHNrX+u/
         VdI0rUgzuv4XghS9wiK6rhTe7T7n/eDzU9Ip0EXeo8b6qfnNT1Jx3eegFB1r2/KAkM
         BVrCi3YUyg6Rl0jYrTjjnK6p+jwdN7jY3gjtvCDoisziz06uu0cPYmLLxd930axpuK
         gqEfp56JE0WIM56BXtJBHYpBuJR69lE8OEeJ0bfgwBUJpBLvpm+bdCBoAa/8Tn3NgC
         dePYLbzMoysgHnFynWCdUk01zKkKDvNxNqwg2fPv3WAJm8o6Bz7LvDpJYOdFYjpRXI
         3MeAZJoUXX6Bw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJdCB3b3JrcyB3aXRoIHRoaXMgY2hhbmdlOg0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
MmMvYnVzc2VzL2kyYy10ZWdyYS5jIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jIGlu
ZGV4IGZlNWI4OWFiYzU3Ni4uOGUwNTllOTRiOTRlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2ky
Yy9idXNzZXMvaTJjLXRlZ3JhLmMNCj4gKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy10ZWdy
YS5jDQo+IEBAIC0xMTcwLDEwICsxMTcwLDExIEBAIHN0YXRpYyBpbnQgdGVncmFfaTJjX3hmZXJf
bXNnKHN0cnVjdCB0ZWdyYV9pMmNfZGV2ICppMmNfZGV2LA0KPiAgICAgICAgICAgICAgICAgdGlt
ZV9sZWZ0LCBjb21wbGV0aW9uX2RvbmUoJmkyY19kZXYtPm1zZ19jb21wbGV0ZSksDQo+ICAgICAg
ICAgICAgICAgICBpMmNfZGV2LT5tc2dfZXJyKTsNCj4NCj4gKyAgICAgICB0ZWdyYV9pMmNfaW5p
dChpMmNfZGV2LCB0cnVlKTsNCj4gKw0KPiAgICAgICAgIGlmIChsaWtlbHkoaTJjX2Rldi0+bXNn
X2VyciA9PSBJMkNfRVJSX05PTkUpKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICAN
Cj4gLSAgICAgICB0ZWdyYV9pMmNfaW5pdChpMmNfZGV2LCB0cnVlKTsNCj4gICAgICAgICAvKiBz
dGFydCByZWNvdmVyeSB1cG9uIGFyYml0cmF0aW9uIGxvc3MgaW4gc2luZ2xlIG1hc3RlciBtb2Rl
ICovDQo+ICAgICAgICAgaWYgKGkyY19kZXYtPm1zZ19lcnIgPT0gSTJDX0VSUl9BUkJJVFJBVElP
Tl9MT1NUKSB7DQo+ICAgICAgICAgICAgICAgICBpZiAoIWkyY19kZXYtPmlzX211bHRpbWFzdGVy
X21vZGUpDQo+DQo+DQo+IFdoaWNoIG1lYW5zIHRoYXQgSFcgc3RhdGUgaXMga2VwdCBkaXJ0eSBh
ZnRlciBETUEgdHJhbnNmZXIuIFBsZWFzZSBjaGVjayBldmVyeXRoaW5nIGNhcmVmdWxseS4NCg0K
SWRlbnRpZmllZCBpc3N1ZSwgV2hlbiBJIG1vdmVkIGxvZ2ljIGFyb3VuZCBmb3IgZGlmZiBjaGFu
Z2VzLCBJTlQgZW5hYmxlIGlzbuKAmXQgY29ycmVjdCBmb3IgRklGTyBEQVRBIFJFUS4gV2lsbCBo
YXZlIHByb3BlciBmaXggaW4gbmV4dCB2ZXJzaW9uLiANCg0K
