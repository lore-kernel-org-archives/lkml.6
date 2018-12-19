Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DBFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F139720869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="b9e+34WO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbeLSUhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 15:37:34 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:10318 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbeLSUhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 15:37:34 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1aabef0000>; Thu, 20 Dec 2018 04:37:08 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Dec 2018 12:37:08 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 19 Dec 2018 12:37:08 -0800
Received: from DRBGMAIL103.nvidia.com (10.18.16.22) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 19 Dec
 2018 20:37:01 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by DRBGMAIL103.nvidia.com
 (10.18.16.22) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 19 Dec
 2018 20:37:00 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.53) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 19 Dec 2018 20:37:00 +0000
Received: from BYAPR12MB2759.namprd12.prod.outlook.com (20.177.125.224) by
 BYAPR12MB3431.namprd12.prod.outlook.com (20.178.196.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Wed, 19 Dec 2018 20:36:57 +0000
Received: from BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::e84a:c18d:d054:a562]) by BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::e84a:c18d:d054:a562%5]) with mapi id 15.20.1425.021; Wed, 19 Dec 2018
 20:36:54 +0000
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        "Yu-Huan Hsu" <YHsu@nvidia.com>, Sachin Nikam <Snikam@nvidia.com>,
        Pritesh Raithatha <praithatha@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Alexander Van Brunt <avanbrunt@nvidia.com>,
        "Thomas Zeng (SW-TEGRA)" <thomasz@nvidia.com>,
        "olof@lixom.net" <olof@lixom.net>,
        Juha Tukkinen <jtukkinen@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "jon.he@arm.com" <jon.he@arm.com>
Subject: RE: [PATCH v3 2/6] iommu/arm-smmu: Add support to program multiple
 ARM SMMU's identically
Thread-Topic: [PATCH v3 2/6] iommu/arm-smmu: Add support to program multiple
 ARM SMMU's identically
Thread-Index: AQHUi3HohTFTyEkkrkCvZNWsed0MjqWGdHoAgAAGqLA=
Date:   Wed, 19 Dec 2018 20:36:54 +0000
Message-ID: <BYAPR12MB2759C4AB588260ECB46046E3B3BE0@BYAPR12MB2759.namprd12.prod.outlook.com>
References: <1543887414-18209-1-git-send-email-vdumpa@nvidia.com>
 <1543887414-18209-3-git-send-email-vdumpa@nvidia.com>
 <5e1b242c-d2d5-9478-6726-2921bea9f3dc@arm.com>
In-Reply-To: <5e1b242c-d2d5-9478-6726-2921bea9f3dc@arm.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2018-12-19T20:36:52.6244647Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic;
 Sensitivity=Unrestricted
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vdumpa@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3431;6:ANFYlYbp6RdW0DQdPROWcfg3WZxQrFdG/0W42S+TBjn9mmp2GlB3imipD5X6dyrRuTxNkh6Udu8MbMA11Xfas5lWtxT9Tlq7gajYkaNs/GdUkJ5wdIBzFnjbpr+fZKl6hFYLju4mhcIR0pC7soPscpycAd4NwS9kvNJULUegagoX0NBmRTsfn7gjNbZ8KOToVZSVYqwyBhSdSCa1eXxKh0O63mCyAjyN5hfNPxBGGqtYPP8yy0bwIqxMvm7Jc+1roV+uucgU5dNsv37GVKGx8cWZ6ZKldkzwvptQ/zglljRo3DEh/LQSdRWkRPgQs8dK5mjHDnAL2XjGwH8IHK96YwM4tc0CBRdkTPxxF/apChkXCm3PexggMPedeN04QT4M5hWcPAFbA5vB7yJjc1nUA2JKSQ2OYnoaebA1Tmd4oC0YJgkLbkPZ3OZkes+VHdXHUw8C7hpF73zpV2KnITfSjg==;5:oCKStBuh3d8rk/X8ZQZFmhDjkJAb2QzD6L3C6PACtfXl/LSbXVXNKl4siBrmcDvjwNlQW2kD1bz0t+EhRTpc84CilpEmbtUr9DWEWFryeMEi0dXn2KW+SaSmmVYTKU6ylWno4KD/dFALOu/JaMrNbRETn521vlmqcx3Iz472GAU=;7:Qd4KuuSsM4InHe0Y3TqupkUxHvZ6JfcHXMh2Q+mJBQv8h8BLv54ICD8ZjQgez+vQajdDk3d+5dqhA0HQl2La2Qtui8gBHLIWlrq2egBJXGsVi7X0X353PlqbkVdBtXNHIfVTHrGQvUwmMIwK1naerw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(366004)(346002)(199004)(51914003)(189003)(66066001)(26005)(186003)(6506007)(97736004)(76176011)(2501003)(25786009)(81166006)(102836004)(8936002)(7736002)(68736007)(99286004)(110136005)(316002)(54906003)(486006)(256004)(81156014)(8676002)(476003)(106356001)(105586002)(2906002)(33656002)(2201001)(5660300001)(71200400001)(74316002)(71190400001)(86362001)(229853002)(11346002)(446003)(6116002)(7696005)(3846002)(6436002)(305945005)(55016002)(9686003)(478600001)(4326008)(6246003)(53936002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3431;H:BYAPR12MB2759.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 1231ef6d-853f-48a1-beb0-08d665f1b671
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3431;
x-ms-traffictypediagnostic: BYAPR12MB3431:
x-microsoft-antispam-prvs: <BYAPR12MB3431EFFE0574E02AAE9362DBB3BE0@BYAPR12MB3431.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR12MB3431;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB3431;
x-forefront-prvs: 0891BC3F3D
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hqCZOzFq86rtP1IOANk82Wp1MFbwkxiV6LoJ1jD4EZSPl30qnsegzccp1if7d2gI+RjH981NVsw4mAK4s7oi4VtrxCTOKunFq/2TpTMy9Pe+Kpp7PRjKewMpxtHL6bVsn/Dm9z0uioFNi60VfcezS31jSrKIR2F5EjbEYmeij+bAgoP83jNSM9Ladk6E3VSkSpE9AurRfwwRoCAMtU/zFWvwM+R2IVUA8qSHaJLx4U0BhWewS3T5vTboZJjnKcZSKAFnj/hDdJjrRu2+wORzy11Jx0icTScnMooKAh0W7MIWYkj5C6WGlqkCmDnLf6AR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1231ef6d-853f-48a1-beb0-08d665f1b671
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 20:36:54.0474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3431
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545251844; bh=aTpf7kCBBu5S3aQqnvhWBB0E2KhZ+sHEu+lCbdxes14=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:msip_labels:authentication-results:
         x-originating-ip:x-ms-publictraffictype:
         x-microsoft-exchange-diagnostics:
         x-ms-exchange-antispam-srfa-diagnostics:
         x-forefront-antispam-report:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-ms-exchange-senderadcheck:x-exchange-antispam-report-cfa-test:
         x-forefront-prvs:received-spf:x-microsoft-antispam-message-info:
         spamdiagnosticoutput:spamdiagnosticmetadata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=b9e+34WOGpvT7cHw8+hgDO5F24vF+LmuBZc+eRSytScEDKgPMii7mlTIZUXxZpkfe
         /6t+cG402rLRLWvchf04IQDgBbUv0qyhxogn9q33Y1UyqAs+Zq5iF4572Pdl3i6s4s
         EKQDcXIipr4osWEgCSr1KoT6YHhfCtx3JzWtGg49I3BkY184av845NjddBIV0m9qHr
         LjCCZONyHFlo4291gTDL3h+4IjVtHejxvqCR1QFxUVMQ57wTi1HiY8VmNbKFw5ocCH
         +Kf4WiUSgW4g/K2UCK7p/RoYMgfPAsnjOabJ6Amir659IJyLiCpeE+YWb7Q2TJaLNQ
         JMgOziNnrAgvw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iaW4sDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjayA6KQ0KDQo+VGhlIHdob2xlIHBvaW50
IG9mIHRoZSBsaWJyYXJ5IGlkZWEgd2FzIHRvIGZhY3RvciBvdXQgdGhlIGNvZGUgaW4gc3VjaCBh
IHdheSB0aGF0IGFsbCB0aGUgZGV0YWlscw0KPnNwZWNpZmljIHRvIGEgcGFydGljdWxhciBpbXBs
ZW1lbnRhdGlvbiBjYW4gYmUga2VwdCB0b2dldGhlci4gQnV0IHdoYXQgdGhpcyBwYXRjaCBkb2Vz
IGlzIGluc2VydA0KPlRlZ3JhMTk0LXNwZWNpZmljIGhhbmRsaW5nIGFsbCB0aHJvdWdoIHRoZSAn
Y29tbW9uJyBjb2RlLCB3aGljaCBpcyB0aGUgZXhhY3Qgb3Bwb3NpdGUgb2YgdGhhdCBjb25jZXB0
DQo+YW5kIGp1c3QgbWFrZXMgbW9yZSBoYXJkLXRvLW1haW50YWluIG1lc3MuDQoNCkluIGFuIGF0
dGVtcHQgdG8gcmV1c2UgbW9zdCBvZiB0aGUgQVJNIFNNTVUgaW1wbGVtZW50YXRpb24sIHdoaWNo
IGhlYXZpbHkgcmVsaWVzIG9uIGRhdGEgZnJvbSBhcm1fc21tdV9kZXZpY2UsDQpUaGUgbGlicmFy
eSBjb2RlIGhhcyBiZWVuIGFkZGVkIHdpdGggc29tZSBmdW5jdGlvbmFsaXR5IG9ubHkgdXNhYmxl
IGJ5IFRlZ3JhMTk0IFNNTVUgZHJpdmVyLiANCkluIFY0IHBhdGNoZXMsIEkgYW0gd29ya2luZyBv
biB0byBhZGQgYSBtZWNoYW5pc20gdG8gb3ZlcnJpZGUgd3JpdGVsL3JlYWRsIGZ1bmN0aW9ucyBp
biBsaWJyYXJ5IHNvIHRoYXQNClRlZ3JhIHNtbXUgZHJpdmVyIGNhbiBvdmVycmlkZSByZWFkL3dy
aXRlIGZ1bmN0aW9ucyBhbmQgaGFuZGxlIHByb2dyYW1taW5nIG9mIG11bHRpcGxlIGluc3RhbmNl
cyBvbiBpdHMgb3duLiANCg0KPlRoZSBhbW91bnQgb2YgY29weS1wYXN0ZSBkdXBsaWNhdGlvbiBp
biBwYXRjaCAjNCBoYXMgdGhlIG9wcG9zaXRlIHByb2JsZW0gLSBhYm91dCA5NSUgb2YgdGhhdCBp
c24ndCANCj5UZWdyYTE5NC1zcGVjaWZpYyBhdCBhbGwgKEkgbWVhbiwgaG93IG1hbnkgZnNsX21j
IGluc3RhbmNlcyBkb2VzIGl0IGhhdmU/KSwgYW5kIGhhdmluZyBtdWx0aXBsZSBjb3BpZXMgb2YN
Cj4gZ2VuZXJpYyBjb2RlIHdpdGggdGhlIHBvdGVudGlhbCB0byBkaXZlcmdlIGlzIGFsc28gbm90
IHdoYXQgYW55b25lIHdhbnRzLg0KDQpJIGhhdmUgc3BsaXQgdGhlIGNvZGUgaW4gYSB3YXkgdGhh
dCBsaWJyYXJ5IG9ubHkgY29udGFpbnMgdGhlIGNvZGUgdGhhdCBkZWFscyB3aXRoIHJlZ2lzdGVy
IHByb2dyYW1taW5nLg0KQW5kIGF2b2lkZWQgcGxhdGZvcm0gZHJpdmVyIGNvZGUgYW5kIERUIHBh
cnNpbmcgY29kZSBnZXR0aW5nIGludG8gbGlicmFyeSwgd2hpY2ggY2FuIGFsbG93IGRyaXZlcnMg
Y2hhbmdpbmcNCkluZGVwZW5kZW50bHkgaWYgbmVjZXNzYXJ5IGluIGZ1dHVyZS4NCg0KPiBQbHVz
IEkgZG9uJ3QgdGhpbmsgZW5kaW5nIHVwIGJ1aWxkaW5nIA0KPiBtdWx0aXBsZSBzZXBhcmF0ZSBk
cml2ZXJzIHdpbGwgZXZlbiB3b3JrIGluIGdlbmVyYWwgLSB0aGFua3MgdG8gdGhlIGN1cnJlbnQg
c3RhdGUgb2YNCj5idXNfc2V0X2lvbW11KCkgZXRjLiwgeW91IGNhbid0IHVzZSB0aGUgcmVndWxh
ciBkcml2ZXIgZm9yIHlvdXIgdGhpcmQgU01NVSBhdCB0aGUgc2FtZSB0aW1lLg0KDQpHb29kIHBv
aW50IQ0KRnJvbSBjb2RlLCBwbGF0Zm9ybV9kbWFfY29uZmlndXJlL29mX2RtYV9jb25maWd1cmUv
b2ZfaW9tbXVfY29uZmlndXJlIHRha2VzIGNhcmUNCm9mIHNldHRpbmcgcmlnaHQgaW9tbXVfb3Bz
IGZvciBkZXZpY2VzIGJhc2VkIG9uIHRoZSBpb21tdSBEVCBub2RlIHRoZXkgaGF2ZSBpbiBpb21t
dXM9PD4gZW50cnkuDQoNCklmIGlvbW11LmMgaXMgdXBkYXRlZCB0byB1c2UgZGV2LT5idXMtPmRt
YV9jb25maWd1cmUoKSwgIHRoZW4gaXQgZG9lc24ndCByZWFsbHkgbmVlZCB0byB1c2UgZGV2LT5i
dXMtPmlvbW11X29wcy4NCmRldi0+YnVzLT5kbWFfY29uZmlndXJlKCkgY2FuIGJlIHVzZWQgdG8g
c2V0IGRldi0+ZG1hX29wcyB0byB0aGUgcmlnaHQgb25lLCBpZiBkZXYtPmRtYV9vcHMgaXMgbm90
DQphbHJlYWR5IHNldC4gDQpJZiB0aGlzIGFwcHJvYWNoIGxvb2tzIGdvb2QsIEkgY2FuIG1ha2Ug
YSBwYXRjaCB0byBjbGVhbiB1cCBidXMtPmlvbW11X29wcyB1c2FnZSByZWxhdGVkIGNvZGUgdG8g
YWxsb3cNCmRldmljZXMgdG8gdXNlIHNwZWNpZmljIFNNTVUgaW5zdGFuY2UgYXMgdGhleSBuZWVk
Lg0KDQo+SSB0aGluayB3aGF0IHJlYWxseSBuZWVkcyB0byBiZSBkb25lIGlzIHRvIGNvbmNlcHR1
YWxseSBzcGxpdCB0aGUgZHJpdmVyIGludG8gImFyY2hpdGVjdHVyZSIgYW5kICJpbXBsZW1lbnRh
dGlvbiINCj4gbGF5ZXJzIC0gYXQgc29tZSBwb2ludCBhZnRlciB0aGUgaG9saWRheXMgd2UncmUg
cHJvYmFibHkgZ29pbmcgdG8gc2l0IGRvd24gYW5kIGdvIHRocm91Z2ggYWxsIHRoZSB2YXJpb3Vz
IHF1aXJrcyBhbmQNCj4gc3BlY2lmaWNzIHdlIGtub3cgYWJvdXQgdG8gdHJ5IGFuZCBmaWd1cmUg
b3V0IHdoYXQgdGhhdCBzaG91bGQgYWN0dWFsbHkgbG9vayBsaWtlLg0KDQpJZiB5b3UgY2FuIHBy
b3ZpZGUgc29tZSBoaWdoIGxldmVsIGRldGFpbHMgb24gd2hhdCB0byBrZWVwIGluIGxpYnJhcnkg
dnMgaW1wbGVtZW50YXRpb24gYWZ0ZXIgaG9saWRheXMsIEkgd291bGQgYmUNCiBoYXBweSB0byBy
ZXdvcmsgdGhlIHBhdGNoZXMuICBXaWxsIGxvb2sgZm9yd2FyZCBmb3IgZnVydGhlciBkaXNjdXNz
aW9ucyBvbiB0aGlzLg0KDQotS1INCg0K
