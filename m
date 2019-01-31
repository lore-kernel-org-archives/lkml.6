Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D37EC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5C420989
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VuOs4FDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbfAaDfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:35:09 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:34224 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfAaDfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:35:08 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c526ce90000>; Thu, 31 Jan 2019 11:35:05 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 30 Jan 2019 19:35:03 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 30 Jan 2019 19:35:03 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 03:35:02 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.57) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 31 Jan 2019 03:35:01 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2888.namprd12.prod.outlook.com (20.179.91.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Thu, 31 Jan 2019 03:34:59 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 03:34:59 +0000
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
Subject: RE: [PATCH V7 3/5] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V7 3/5] i2c: tegra: Add DMA Support
Thread-Index: AQHUuLUl2B5DD2NSpkOCYYJBIhpJsKXIgAUAgAANcMCAABYegIAAAMxAgAAKb4CAAALCQA==
Date:   Thu, 31 Jan 2019 03:34:59 +0000
Message-ID: <BYAPR12MB3398C3E7C5842C698B5CA1CCC2910@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548864096-20974-1-git-send-email-skomatineni@nvidia.com>
 <1548864096-20974-3-git-send-email-skomatineni@nvidia.com>
 <1f10cb76-59a1-93c5-ae03-ccc0cd8db1a3@gmail.com>
 <BYAPR12MB3398B845E97674BE93CCD7D9C2910@BYAPR12MB3398.namprd12.prod.outlook.com>
 <f3282ada-56a8-b5c7-c400-38483eab2d06@gmail.com>
 <BYAPR12MB3398CE89D24AC71BF7DAF43CC2910@BYAPR12MB3398.namprd12.prod.outlook.com>
 <725aece7-d3f2-c26f-4af4-200d8b507123@gmail.com>
In-Reply-To: <725aece7-d3f2-c26f-4af4-200d8b507123@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2888;6:B/ZXbqsFXG0jca2NL4SE0BVNTLSknRtwn3rNdBGRWYIn3Za+t9Xs2NMx0sr3DpTd+XvYxUeRMGOCxrq8YsRCf4zuUyL655LtWtkwN9VGtg3GjmGVQttU5hClMfmrG8kjSbeUArFonmPfjaQ/IvvXZoJGMsXvaEcyU6uGIpQudDj/R3VsrTiophwtFll0p1zJQdNeBfLOd1wfUHRJEKp1FWC4k7c5V1dheSp45cp9EfgqY4pak6FykSFzOaDeezWzZUgYuIUb1KYYXxXzg3VUAwWBSrtWEK7j3JUX28PvO6lGdgUao6h0jenkThdQ6FmGzFMWvtQUg2bc20yCllGZRdQSkukFajIDC3eTBfevh5wbwtyr0GCeNf7/RgmiY8XhxsnTLMmVoJJWODjBGa0imPwCosHWsZ6fXAqgjc6jqVues2sC50zmFm6TvadyFnO6bjTTCVR+2w+dpCo6MPJ6WA==;5:nuXo49VIUL8pr2o5kyg2byNipF5wj0hH/3h8txSOE3kOrZdjfoyFI44gEbJ4X0Auomr8aK0Ay33warBxiqWzPzkscF53HGCCpNWUyxLMLD/wmk0fSi1FjzoluXCH1STzqBhsckqG4h83tR/OuGFqU//Uw2Q4j/Y8CHfZ2byQxMZq7BxR+u5IqN8FiXfbr8i4nO3JB1x8rPU2QP63LVvzTQ==;7:hfV5TPRtkod5HVOx3hTAN3tPR09i9c4AIbngh0COggmQr3GFqMWgmULqKHJkFEgucDRl+46Ll6oErN9gBLKhUGJHScux6V8dvqhA8HzzKNWnV8q1KMGfVz7n1WSobUraotEtK7leYcy/busWF+o09g==
x-ms-office365-filtering-correlation-id: be3beff1-4edc-413d-aa0f-08d6872d13c2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2888;
x-ms-traffictypediagnostic: BYAPR12MB2888:
x-microsoft-antispam-prvs: <BYAPR12MB2888E767AA66537B509915BEC2910@BYAPR12MB2888.namprd12.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(81166006)(8936002)(74316002)(81156014)(68736007)(6506007)(2906002)(186003)(6116002)(3846002)(2501003)(478600001)(26005)(25786009)(76176011)(7696005)(66066001)(8676002)(7736002)(4326008)(305945005)(102836004)(446003)(86362001)(39060400002)(476003)(14454004)(53936002)(11346002)(229853002)(14444005)(6246003)(71190400001)(316002)(486006)(33656002)(9686003)(99286004)(97736004)(106356001)(256004)(71200400001)(55016002)(93886005)(6636002)(54906003)(105586002)(6436002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2888;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XavobjSghRIIAEJ3T7SyDn5dJmoyDLfzqaaXTX44rJXaVKzJe+eeJ6HdvPfhwE3f9Fpmf9f7I27ojXJbQHeTNEbazI9b+5eEw2TOYWQrKNIRTxOmcnP2LSK+v67dur4DrcRYYNNHppay4fF8VegPqLe+nFBjbW7PGGvppCx9Sw0CYASr7JaAjmC3yloQrVYrOT4VfCdqMDejk3Mttng+N5qVWbrW+O/r44QK/6R3cizC62AbEYgmm75U3E0ufssfbJrkH9QBFK9YgeCHcn/w1lr6IaVZAjyzxz8IzIhoQOdjy2WYZBHkvewIjVFHpODBChnXCnrOloZxSv8nJ8QssOhQ5yWIU5J+Nc+I0cQfRCxayA+M3e00ka7pms2VaIIWij2+qSv7hGBbBhOB5DOKGugjwdG+8Lylhz18vJ1Z0Do=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: be3beff1-4edc-413d-aa0f-08d6872d13c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 03:34:59.2235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2888
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548905705; bh=vx2UnOZtaVdJMXSKhWoGCWWKLBbH0fm0BxNP58OJFLc=;
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
        b=VuOs4FDHQsmnFhaJokPuwkCVHUxPWoNurDFDB+fYXaIvl437P4+3IElMB4MQUDyhJ
         5Kuv1ioMIKTwFVdv7Tqs2xGhEqvuuG1dEjn6w/aBJkn9nGnHZz7FRdFBj+xGqASx8T
         lWy1k8O6lAyVnM3aeZa4aXrg0cupFkoUPh0StG/AY6RhKu9aRtyzMo8P2zzBYp/3Zz
         9FT6l/Gsd3NOZjdl5eJx/bj4jH+n5KAd3Fag2e6LRSAq/O1YXgIZBFZi3mnfTP3K9c
         0LdV/gxo37Q4ZEixMWXuw2IMEzOsyZIjm0uKFugki/mONJiwDJsnZuyK3lda9+neyu
         H/MWUu5nhsl+g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJMkNfSU5UX0FMTF9QQUNLRVRTX1hGRVJfQ09NUExFVEUgc2hhbGwgYmUgbWFza2VkIGZvciB0
aGUgUElPIG1vZGUNCj4gSTJDX0lOVF9QQUNLRVRfWEZFUl9DT01QTEVURSBzaGFsbCBiZSBtYXNr
ZWQgZm9yIHRoZSBETUEgbW9kZSwgaWYgSSdtIG5vdCBtaXNzaW5nIHNvbWV0aGluZy4NCj4NCmZv
ciBwYWNrZXRzIHdpdGggcmVwZWF0ZWQgc3RhcnQgb3IgY29udGludWUgeGZlciwgUEFDS0VUX1hG
RVJfQ09NUExFVEUgd2lsbCBiZSB0cmlnZ2Vycw0KZm9yIHBhY2tldHMgd2l0aCBzdG9wIGJpdCwg
Ym90aCBQQUNLRVRfWEZFUl9DT01QTEVURSBhbmQgQUxMX1BBQ0tFVF9YRkVSX0NPTVBMRVRFIHdp
bGwgYmUgdHJpZ2dlcmVkLg0KVG8gYmUgYWxpZ24gd2l0aCB3aGF0IFBJTyBtb2RlIGlzIGRvaW5n
LCB3aWxsIG5vdCB1c2UgQUxMX1BBQ0tFVFNfWEZFUl9DT01QTEVURSBmb3IgRE1BIGluIG5leHQg
dmVyc2lvbi4gDQoNCj4NCj4gSGFuZGxlIHRoZSBlcnJvci1jYXNlIGhlcmU6DQo+DQo+CWlmIChp
MmNfZGV2LT5tc2dfZXJyICE9IEkyQ19FUlJfTk9ORSkgew0KPgkJZGV2X2VycihpMmNfZGV2LT5k
ZXYsICJpMmMgZG1hIHRyYW5zZmVyIGZhaWxlZFxuIik7DQo+CQlnb3RvIGkyY19yZWNvdmVyOw0K
Pgl9DQo+DQo+Li4uDQo+CTwtLS0gZW5kIG9mIHRlZ3JhX2kyY194ZmVyX21zZygpIC0tPg0KPg0K
PglpZiAobGlrZWx5KGkyY19kZXYtPm1zZ19lcnIgPT0gSTJDX0VSUl9OT05FKSkNCj4JCXJldHVy
biAwOw0KPg0KPiBpMmNfcmVjb3ZlcjoNCj4JdGVncmFfaTJjX2luaXQoaTJjX2Rldik7DQo+CS8q
IHN0YXJ0IHJlY292ZXJ5IHVwb24gYXJiaXRyYXRpb24gbG9zcyBpbiBzaW5nbGUgbWFzdGVyIG1v
ZGUgKi8NCj4JaWYgKGkyY19kZXYtPm1zZ19lcnIgPT0gSTJDX0VSUl9BUkJJVFJBVElPTl9MT1NU
KSB7DQo+CQlpZiAoIWkyY19kZXYtPmlzX211bHRpbWFzdGVyX21vZGUpDQo+CQkJcmV0dXJuIHRl
Z3JhX2kyY19pc3N1ZV9idXNfY2xlYXIoaTJjX2Rldik7DQo+CQlyZXR1cm4gLUVBR0FJTjsNCj4J
fQ0KPglpZiAoaTJjX2Rldi0+bXNnX2VyciA9PSBJMkNfRVJSX05PX0FDSykgew0KPgkJaWYgKG1z
Zy0+ZmxhZ3MgJiBJMkNfTV9JR05PUkVfTkFLKQ0KPgkJCXJldHVybiAwOw0KPgkJcmV0dXJuIC1F
UkVNT1RFSU87DQo+CX0NCj4NCj4JcmV0dXJuIC1FSU87DQoNCldoZW4gRE1BIHRyYW5zZmVyIHRp
bWVvdXQsIG5vIG5lZWQgdG8gY2hlY2sgZm9yIEFSQiBMT1NUIG9yIE5PX0FDSyBhcyBpZiBhbnkg
b2YgdGhvc2UgaW50ZXJydXB0cyB0cmlnZ2VyIGludGVycnVwdCBoYW5kbGVyIHdpbGwgdGVybWlu
YXRlIGRtYWVuZ2luZSBhbmQgY29tcGxldGVzIHNvIERNQSB0aW1lb3V0IHdpbGwgbm90IGJlIHNl
ZW4gaW4gdGhvc2UgY2FzZXMgYW5kIGZhbGxzIHRocnUgbXNnX2VyciBjaGVjaw0KDQo=
