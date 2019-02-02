Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DC9C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 18:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C94720857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 18:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oYm2jVxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfBBScX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 13:32:23 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:63632 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbfBBScW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 13:32:22 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c55e2340000>; Sun, 03 Feb 2019 02:32:20 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Sat, 02 Feb 2019 10:32:17 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Sat, 02 Feb 2019 10:32:17 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 2 Feb
 2019 18:32:15 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.56) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Sat, 2 Feb 2019 18:32:15 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3397.namprd12.prod.outlook.com (20.178.196.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 18:32:11 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1580.019; Sat, 2 Feb 2019
 18:32:11 +0000
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
Subject: RE: [PATCH V9 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V9 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUulC5gnNOlUi0AEWt0UGRYeTykqXMixaAgABKVTA=
Date:   Sat, 2 Feb 2019 18:32:11 +0000
Message-ID: <BYAPR12MB33982BC5A58A000A0CB84F6AC2930@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
 <1549040867-18149-3-git-send-email-skomatineni@nvidia.com>
 <d37e901b-1c26-3d9c-7f68-29e06f4ff993@gmail.com>
In-Reply-To: <d37e901b-1c26-3d9c-7f68-29e06f4ff993@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3397;6:Siff3Z38OYdqg6OiHchTHUhFss/RoxVTvIx+D/kqSpEtoKP5NvfwJqvEPgzLyGnKnDD0RNRdDQnlUTHReAEPHd4iLTgNp5EZiNaMH0OBvUJ/YocWcbhjfAQ9aSI/Q65l5hT5jES596OOwBORqdww0JJrF29c56t4jv2U114lqBC0G2+leAN724irciDadamJgPA6zTrXimi1Fu3dnI1v7y3N0aNR4Ed5gMMOaiOdNGIiUluK3f42ZaJHWzDLkO161z4V696mSZnxMMQ3Fg0vqlOJPnHxk/Wq2lpXYv1K2c8LLxcWZAVuLK8SLhmqOGome39SL8I1KkKRPBsvC1+p/K5vJIzVI7Ja8bkTTNFm7AubreYeumXSUtk3avDeqt/6ESNXHHz4JGFlMMka9hsS2KC9UJNhDrOVzRkHQ1eh8ozHFGMOapovri4zGafQ646eqsG+IG1z5+bYrbxB4+vJ2g==;5:+BXHJEMTA3utfE+dcsvQ+Sgi+nYv/Y4JojMP55xZfnoQ6PpXEKnjWt47M8k8yZYS7tWmMrMOtKUwmUdKsNHG8Lns1BWGBOwqoWgfXkDR05COtvL4WVZvKCF5uU7XNcS7WA9SbDkwXUbxbbKsAbS3UBahJ+VbI+WKiSXOPVimE1yyz56IGlxmfzpaCZGE29PhWr9wmSbIPTh32ZLU5INQLg==;7:v2CxciZercd38QGErcb4WJNkAxgMwq7FMyLB/Qxi3FQUnhpPjZOQDuAPHbHHGHhZa1DswJMta8qDsr9QSmMJCPxvT9sjgQdCwFYvQkjQlwLg/Pxr0NGvQNdGaRSOS13On4FmQxEeFyPvSu+EtL9fvQ==
x-ms-office365-filtering-correlation-id: 9b48cef0-f603-4187-c715-08d6893cbee6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3397;
x-ms-traffictypediagnostic: BYAPR12MB3397:
x-microsoft-antispam-prvs: <BYAPR12MB3397A3B280159B2C8FA2C99DC2930@BYAPR12MB3397.namprd12.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(136003)(376002)(346002)(189003)(199004)(97736004)(6636002)(76176011)(71190400001)(71200400001)(8676002)(256004)(229853002)(81166006)(81156014)(25786009)(7696005)(68736007)(74316002)(66066001)(2906002)(7736002)(305945005)(6436002)(102836004)(8936002)(4326008)(53936002)(9686003)(486006)(86362001)(6116002)(106356001)(3846002)(55016002)(99286004)(26005)(54906003)(6506007)(110136005)(2501003)(14454004)(478600001)(476003)(39060400002)(186003)(105586002)(6246003)(11346002)(316002)(446003)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3397;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dPmKnDajDr7OpDFy7cn93YWsHx1hEPyZna4DDiD9okDrmFkGgsftXm7MUpNyo3JfeWb1YlEf8dFmEoUrjRa/tjiSgLc0oCETw5N27MPiXW4na5q2l3+K8KF0Te/C0kKtZgzarOUxh3Oq97ckjgAZKS/zcgx+vWtcc9ugVfBAkT3Rszru0aw2yk5l1zJ1CLHV1RPbyGqfYDb9ZfUSNZJ8lToTjkjA0cBHoQ0P0SIe/jQ5FaxHkJcLVLCJoxyc2C+Z0nBkh4whVAAufPY4s/sZDl746Js+iUnueXyU6m1KyP90tDlYOjxLTan70qrKF+vmjppHIJnTvnWZygLifYk0qP3fY/cNxfjLkhBtZRQQv1SHjAKBmwf84gdx2OfdhTJMHIqS3fMQHTP6lmuEva6HF3jfISqGXeTQIzrq4XavHWk=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b48cef0-f603-4187-c715-08d6893cbee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 18:32:11.1490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3397
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549132340; bh=G/5PHvFP2M9m7VR/SZuoCVggHJeXSq4tSBq4ScVnMpQ=;
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
        b=oYm2jVxaxQJa/8wlt1W/cFCDbUCB8rZTP8mWK0UPNnMWqEoBRhXyXbEf2Da4Vm3Go
         njImUAMXNzL29Ov7Pqx3wZMpZbuyPVHcoU0NAHE0iqQJzXSbyJh2mRP3KRI6FRI75Z
         EIYou3p228lCexDcLksG3rBCViwPG9avcmPPVjwE9OdTKf6wrOnYz/dFOaAFk3T7ay
         U42Sc9enPlo4B8RbbXG2y+kRM3hVfyTElaX5EzsgphWy8a6IcH4VYBLUUmm60I7gks
         d4dujP/pPPUissFhYwpwFwJMVv1fx8NxEdjVnasShmFYer5XJUz9pUWmk3RWRuvX5n
         POqQRZeEzwfhA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFRoaXMgcGF0Y2ggYWRkcyBETUEgc3VwcG9ydCBmb3IgVGVncmEgSTJDLg0KPiA+IA0KPiA+
IFRlZ3JhIEkyQyBUWCBhbmQgUlggRklGTyBkZXB0aCBpcyA4IHdvcmRzLiBQSU8gbW9kZSBpcyB1
c2VkIGZvciANCj4gPiB0cmFuc2ZlciBzaXplIG9mIHRoZSBtYXggRklGTyBkZXB0aCBhbmQgRE1B
IG1vZGUgaXMgdXNlZCBmb3IgdHJhbnNmZXIgDQo+ID4gc2l6ZSBoaWdoZXIgdGhhbiBtYXggRklG
TyBkZXB0aCB0byBzYXZlIENQVSBvdmVyaGVhZC4NCj4gPiANCj4gPiBQSU8gbW9kZSBuZWVkcyBm
dWxsIGludGVydmVudGlvbiBvZiBDUFUgdG8gZmlsbCBvciBlbXB0eSBGSUZPJ3MgYW5kIA0KPiA+
IGFsc28gbmVlZCB0byBzZXJ2aWNlIG11bHRpcGxlIGRhdGEgcmVxdWVzdHMgaW50ZXJydXB0IGZv
ciB0aGUgc2FtZSANCj4gPiB0cmFuc2FjdGlvbi4gVGhpcyBhZGRzIGRlbGF5IGJldHdlZW4gZGF0
YSBieXRlcyBvZiB0aGUgc2FtZSB0cmFuc2ZlciANCj4gPiB3aGVuIENQVSBpcyBmdWxseSBsb2Fk
ZWQgYW5kIHNvbWUgc2xhdmUgZGV2aWNlcyBoYXMgaW50ZXJuYWwgdGltZW91dCANCj4gPiBmb3Ig
bm8gYnVzIGFjdGl2aXR5IGFuZCBzdG9wcyB0cmFuc2FjdGlvbiB0byBhdm9pZCBidXMgaGFuZy4g
RE1BIG1vZGUgDQo+ID4gaXMgaGVscGZ1bCBpbiBzdWNoIGNhc2VzLg0KPiA+IA0KPiA+IERNQSBt
b2RlIGlzIGFsc28gaGVscGZ1bCBmb3IgTGFyZ2UgdHJhbnNmZXJzIGR1cmluZyBkb3dubG9hZGlu
ZyBvciANCj4gPiB1cGxvYWRpbmcgRlcgb3ZlciBJMkMgdG8gc29tZSBleHRlcm5hbCBkZXZpY2Vz
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFNvd2phbnlhIEtvbWF0aW5lbmkgPHNrb21hdGlu
ZW5pQG52aWRpYS5jb20+DQo+ID4gLS0tDQo+DQo+DQo+ID4gK3N0YXRpYyBpbnQgdGVncmFfaTJj
X2luaXRfZG1hKHN0cnVjdCB0ZWdyYV9pMmNfZGV2ICppMmNfZGV2KSB7DQo+ID4gKwlzdHJ1Y3Qg
ZG1hX2NoYW4gKmRtYV9jaGFuOw0KPiA+ICsJdTMyICpkbWFfYnVmOw0KPiA+ICsJZG1hX2FkZHJf
dCBkbWFfcGh5czsNCj4gPiArCWludCBlcnIgPSAwOw0KPiA+ICsNCj4gPiArCWlmICghSVNfRU5B
QkxFRChDT05GSUdfVEVHUkEyMF9BUEJfRE1BKSkNCj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4N
Cj4gQW5vdGhlciBkZXRhaWwgaXMgdGhhdCB3ZSBuZWVkIHRvIGtlZXAgb2xkZXIga2VybmVscyB3
b3JraW5nIG9uIFQxODYrIGFmdGVyIGl0cyBkZXZpY2UtdHJlZSB3aWxsIGdldCB0aGUgImRtYXMi
IHByb3BlcnR5LCBkZXZpY2UtdHJlZSBjaGFuZ2VzIHNoYWxsIGJlIGJhY2t3YXJkcy1jb21wYXRp
YmxlIHdpdGggb2xkZXIga2VybmVscy4gSGVuY2Ugd2UgbmVlZCB0byBjaGVjayB0aGF0IHBsYXRm
b3JtIGFjdHVhbGx5IHdhbnRzIHRoZSBBUEIgRE1BIGRyaXZlciwgb3RoZXJ3aXNlIFQxODYrIHdp
bGwgYmUgZmFpbGluZyB3aXRoIC1FUFJPQkVfREVGRVIuDQoNClllcywgdGhhdCB3aWxsIGJlIGEg
c2VwYXJhdGUgcGF0Y2ggbGF0ZXIgZm9yIGFkZGluZyBETUEgc3VwcG9ydCBmb3IgVGVncmExODYg
YW5kIGxhdGVyIGNoaXBzIG9uY2Ugd2UgY2hlY2sgb24gR1BDRE1BIHVwc3RyZWFtDQoNCg0K
