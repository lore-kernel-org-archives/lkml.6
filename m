Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6626DC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2253820823
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jFO8agXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfBAEUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 23:20:15 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:50567 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfBAEUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 23:20:15 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c53c8f90000>; Fri, 01 Feb 2019 12:20:09 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 31 Jan 2019 20:20:07 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 31 Jan 2019 20:20:07 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 04:20:06 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.59) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 1 Feb 2019 04:20:05 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2904.namprd12.prod.outlook.com (20.179.91.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Fri, 1 Feb 2019 04:19:47 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 04:19:47 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        "Shardar Mohammed" <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V8 3/5] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V8 3/5] i2c: tegra: Add DMA Support
Thread-Index: AQHUuSyS8D4y2PEYbkigLw9+iOz1C6XJUwmAgADLhYCAAAH90IAAJYYAgAAQRwA=
Date:   Fri, 1 Feb 2019 04:19:46 +0000
Message-ID: <BYAPR12MB3398955CD0EDF40EB61D15B8C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
        <1548915387-28826-3-git-send-email-skomatineni@nvidia.com>
        <20190131124423.GG23438@ulmo>        <20190201035249.5b1cdfe2@dimatab>
        <BYAPR12MB33986DDF4267ED1F499317B0C2920@BYAPR12MB3398.namprd12.prod.outlook.com>
 <20190201061414.05443ea1@dimatab>
In-Reply-To: <20190201061414.05443ea1@dimatab>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2904;6:dSU8H5fAQYyN0aA/v5PekGSxHmNkxZB2z/86L17e3ME8UJayKb/NvGy532EO20WCTYKOaOX/uaARPTanwKxhkUpOjOo6TxpYf0fDYm6uoejEOlkSuG+WGgR8wKB+P0B1OWraizb5fZXA9tgNdJXfeuT6b+lM4Y180ersUvtN9brLI0Edv1xuVW7IZXM6d3qT35jDianpuuwv4QqVYxgzi1pBb8bvV0yJA1thWKBENDcDeOYy98YK5kjCJwvdV2bneXAu7YECgwQKPcxm+79rK6g7h5vIqywNSN2C1kuu9N/G5wkov79bNDSkLaSNdZTrSZKDPKwgczDL4g0DsHYr9jpzQlWsgbmbbeapghOGBtybMH3OrlQ9ZvEhDtpfVYmPHbFCQOdRUFH7c6zKh2gjtp5CWnmQgMnVbr/jkWfxpyjuPPQIU9mxz3oCMGLMCqG1ky91RIEw1oEgabiZ9ptEww==;5:NKsywjlqKPJxEYzxYsVXIUGo/uYHODvJNH44oxhVTYSxzro8AjOPRtQTTG8Dw0H7g46x3pBJzoXE18RfG1UyNyqb+fD1meepBr5IE8XrNXUsC+vYpHa/GLW8IuadlaSuHXoglnGuQKZW/J4CJWch+4NE0fmCjsfkE1RkyXkKoT2mKOllmw4RMoSJQZF6EBoSQkzzG73KdDbUC+EuxnaIMQ==;7:3fGbdopbt8igJbG2kbP833qcn5SplvcdXlvALIEynUxGFta/PYZU7PHutU0fLxZX7RFZMbMSlr7z6/hcNMG0hQxupz3E2dIORxb9LrqtCIMgioc7jHJ6mIbQ9OXctZ1uO0OgpM+6SIaQnOpVlXJagQ==
x-ms-office365-filtering-correlation-id: b75cea97-cf2d-4e5e-ec55-08d687fc802e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2904;
x-ms-traffictypediagnostic: BYAPR12MB2904:
x-microsoft-antispam-prvs: <BYAPR12MB29048AB7F131F341F4958DA3C2920@BYAPR12MB2904.namprd12.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(366004)(396003)(51444003)(189003)(199004)(446003)(316002)(11346002)(256004)(14454004)(54906003)(106356001)(4326008)(478600001)(53936002)(105586002)(9686003)(74316002)(68736007)(476003)(55016002)(14444005)(486006)(6916009)(25786009)(186003)(7696005)(76176011)(7736002)(305945005)(99286004)(3846002)(93886005)(2906002)(8936002)(33656002)(66066001)(39060400002)(6116002)(6506007)(26005)(81166006)(81156014)(102836004)(1411001)(86362001)(229853002)(71190400001)(6436002)(6246003)(97736004)(71200400001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2904;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Sn+ayyM6lSkMoaWPTxpea53o+s0PJSm9ERpBZTOMG4vsLIpR9gVgrsUysSt3COPy2CI88Zq7/2JM5GYDWVkwXVTx+XKpghNwqSBLChfP6Pu/GGFQ+DkXz5oC6Eb8yej9P9xcqZJ193psiBALO3Mue97nbQSRjAL3mzXPtTgGEKYnhmaiL5vJRMibtzVPwKl9Xl+nRZZtVvz5RNxb6H0Pl/VwWs7DkuC3MEkpBpnX+E67dnYOARFLyCc0i8vx/+9cRUU9DlphmutRWf5ylwjxoEe0Giv9vLn4ugAn6lUR3WUJPtu4FuIwcLsP2j4jBxiqDUqjI26Ku6jwhaR6l0eV/0cAuEvWshyZyExBrULv6HlQM8+3WgQ/SCnFSJx7h/aW+fmz66BgGsw6Ywzy6Azpdchnx0DEDkzIedmoni0K2DQ=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b75cea97-cf2d-4e5e-ec55-08d687fc802e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 04:19:46.9909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2904
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548994810; bh=/b2/nusaOjuxuF/IiuMTLg2CJFq2+RR4PVKIiu9HhvQ=;
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
        b=jFO8agXfdxC7Bff9nUbBIRHxTpje0hlspEfJ7SaHkWzhcafQUOLrfjwE1BsWo5TXe
         hdb/tnHD6EL2WM6The/TdkVOOowwo04BW7vPPo+4xyiRI9fUOrs/p0UzgoCOTRnMOo
         /hS7+lo+7rwHFnG0gFJuRCwTozUMzDaueKTo78zKli8fPk7IfyNv0SqRWYZ+PNBcyU
         29dqez3NQc0RaSgI9ixpNN38gdimVtUoUUt3VXRt0ZZrZVL+lw5qIxjgtaZ7PyxQd1
         msGnE9BVm3JuBsyH7GqTE785fVc/QjT+gvMjl+QtHLGpEz4W3Jr9WKzVHkVdu6Lc1C
         iXPfZUH6NoSJw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gPiA+ICsJaWYgKGRtYSkgew0KPiA+ID4gPiA+ICsJCWlmIChpMmNfZGV2LT5tc2dfcmVh
ZCkgew0KPiA+ID4gPiA+ICsJCQljaGFuID0gaTJjX2Rldi0+cnhfZG1hX2NoYW47DQo+ID4gPiA+
ID4gKwkJCXRlZ3JhX2kyY19jb25maWdfZmlmb190cmlnKGkyY19kZXYsDQo+ID4gPiA+ID4geGZl
cl9zaXplLA0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiBEQVRBX0RNQV9ESVJfUlgpOw0KPiA+ID4g
PiA+ICsNCj4gPiA+ID4gPiBkbWFfc3luY19zaW5nbGVfZm9yX2RldmljZShpMmNfZGV2LT5kZXYs
ICsgaTJjX2Rldi0+ZG1hX3BoeXMsDQo+ID4gPiA+ID4gKwkJCQkJCSAgIHhmZXJfc2l6ZSwNCj4g
PiA+ID4gPiArDQo+ID4gPiA+ID4gRE1BX0ZST01fREVWSUNFKTsNCj4gPiA+ID4gDQo+ID4gPiA+
IERvIHdlIHJlYWxseSBuZWVkIHRoaXM/IFdlJ3JlIG5vdCBhY3R1YWxseSBwYXNzaW5nIHRoZSBk
ZXZpY2UgYW55IA0KPiA+ID4gPiBkYXRhLCBzbyBubyBjYWNoZXMgdG8gZmx1c2ggaGVyZS4gSSB3
ZSdyZSBjYXV0aW91cyBhYm91dCBmbHVzaGluZyANCj4gPiA+ID4gY2FjaGVzIHdoZW4gd2UgZG8g
d3JpdGUgdG8gdGhlIGJ1ZmZlciAoYW5kIEkgdGhpbmsgd2UgZG8gdGhhdCANCj4gPiA+ID4gcHJv
cGVybHkgYWxyZWFkeSksIHRoZW4gdGhlcmUgc2hvdWxkIGJlIG5vIG5lZWQgdG8gZG8gaXQgaGVy
ZSANCj4gPiA+ID4gYWdhaW4uDQo+ID4gPg0KPiA+ID4gSUlVQywgRE1BIEFQSSBoYXMgYSBjb25j
ZXB0IG9mIGJ1ZmZlciBoYW5kaW5nIHdoaWNoIHRlbGxzIHRvIHVzZQ0KPiA+IGRtYV9zeW5jX3Np
bmdsZV9mb3JfZGV2aWNlKCkgYmVmb3JlIGlzc3VpbmcgaGFyZHdhcmUgam9iIHRoYXQgdG91Y2hl
cyANCj4gPiB0aGUgYnVmZmVyIGFuZCB0byB1c2UgZG1hX3N5bmNfc2luZ2xlX2Zvcl9jcHUoKSBh
ZnRlciBoYXJkd2FyZSBkb25lIA0KPiA+IHRoZSBleGVjdXRpb24uIEluIGZhY3QgdGhlIENQVSBj
YWNoZXMgYXJlIGdldHRpbmcgZmx1c2hlZCBvciANCj4gPiBpbnZhbGlkYXRlZCBhcyBhcHByb3By
aWF0ZSBpbiBhIHJlc3VsdC4NCj4gPiA+DQo+ID4gPiBkbWFfc3luY19zaW5nbGVfZm9yX2Rldmlj
ZShETUFfRlJPTV9ERVZJQ0UpIGludmFsaWRhdGVzIGJ1ZmZlciBpbiANCj4gPiA+IHRoZSBDUFUg
Y2FjaGUsIHByb2JhYmx5IHRvIGF2b2lkIENQVSBldmljdGluZyBkYXRhIGZyb20gY2FjaGUgdG8g
DQo+ID4gPiBEUkFNIHdoaWxlIGhhcmR3YXJlIHdyaXRlcyB0byB0aGUgYnVmZmVyLiBIZW5jZSB0
aGlzIGh1bmsgaXMgDQo+ID4gPiBjb3JyZWN0Lg0KPiA+ID4gPiA+ICsJCQllcnIgPSB0ZWdyYV9p
MmNfZG1hX3N1Ym1pdChpMmNfZGV2LA0KPiA+ID4gPiA+IHhmZXJfc2l6ZSk7DQo+ID4gPiA+ID4g
KwkJCWlmIChlcnIgPCAwKSB7DQo+ID4gPiA+ID4gKwkJCQlkZXZfZXJyKGkyY19kZXYtPmRldiwN
Cj4gPiA+ID4gPiArCQkJCQkic3RhcnRpbmcgUlggRE1BDQo+ID4gPiA+ID4gZmFpbGVkLCBlcnIg
JWRcbiIsDQo+ID4gPiA+ID4gKwkJCQkJZXJyKTsNCj4gPiA+ID4gPiArCQkJCWdvdG8gdW5sb2Nr
Ow0KPiA+ID4gPiA+ICsJCQl9DQo+ID4gPiA+ID4gKwkJfSBlbHNlIHsNCj4gPiA+ID4gPiArCQkJ
Y2hhbiA9IGkyY19kZXYtPnR4X2RtYV9jaGFuOw0KPiA+ID4gPiA+ICsJCQl0ZWdyYV9pMmNfY29u
ZmlnX2ZpZm9fdHJpZyhpMmNfZGV2LA0KPiA+ID4gPiA+IHhmZXJfc2l6ZSwNCj4gPiA+ID4gPiAr
DQo+ID4gPiA+ID4gREFUQV9ETUFfRElSX1RYKTsNCj4gPiA+ID4gPiArCQkJZG1hX3N5bmNfc2lu
Z2xlX2Zvcl9jcHUoaTJjX2Rldi0+ZGV2LA0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiBpMmNfZGV2
LT5kbWFfcGh5cywNCj4gPiA+ID4gPiArCQkJCQkJeGZlcl9zaXplLA0KPiA+ID4gPiA+ICsNCj4g
PiA+ID4gPiBETUFfVE9fREVWSUNFKTsNCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMsIG9uIHRoZSBv
dGhlciBoYW5kIHNlZW1zIGNvcnJlY3QgYmVjYXVzZSB3ZSBuZWVkIHRvIA0KPiA+ID4gPiBpbnZh
bGlkYXRlIHRoZSBjYWNoZXMgZm9yIHRoaXMgYnVmZmVyIHRvIG1ha2Ugc3VyZSB0aGUgZGF0YSB0
aGF0IA0KPiA+ID4gPiB3ZSBwdXQgdGhlcmUgZG9lc24ndCBnZXQgb3ZlcndyaXR0ZW4uDQo+ID4g
Pg0KPiA+ID4gQXMgSSBzdGF0ZWQgYmVmb3JlIGluIGEgY29tbWVudCB0byB2NiwgdGhpcyBwYXJ0
aWN1bGFyIGNhc2Ugb2YNCj4gPiA+IGRtYV9zeW5jX3NpbmdsZV9mb3JfY3B1KCkgdXNhZ2UgaXMg
aW5jb3JyZWN0IGJlY2F1c2UgQ1BVIHNob3VsZCB0YWtlIA0KPiA+ID4gb3duZXJzaGlwIG9mIHRo
ZSBidWZmZXIgYWZ0ZXIgY29tcGxldGlvbiBvZiBoYXJkd2F0ZSBqb2IuIEJ1dCBpbiANCj4gPiA+
IGZhY3QgZG1hX3N5bmNfc2luZ2xlX2Zvcl9jcHUoRE1BX1RPX0RFVklDRSkgaXMgYSBOTy1PUCBi
ZWNhdXNlIENQVSANCj4gPiA+IGRvZXNuJ3QgbmVlZCB0byBmbHVzaCBvciBpbnZhbGlkYXRlIGFu
eXRoaW5nIHRvIHRha2Ugb3duZXJzaGlwIG9mIA0KPiA+ID4gdGhlIGJ1ZmZlciBpZiBoYXJkd2Fy
ZSBkaWQgYSByZWFkLW9ubHkgYWNjZXNzLg0KPiA+ID4gPiAgIA0KPiA+ID4gPiA+ICsJaWYgKCFp
MmNfZGV2LT5tc2dfcmVhZCkgew0KPiA+ID4gPiA+ICsJCWlmIChkbWEpIHsNCj4gPiA+ID4gPiAr
CQkJbWVtY3B5KGJ1ZmZlciwgbXNnLT5idWYsIG1zZy0+bGVuKTsNCj4gPiA+ID4gPiArDQo+ID4g
PiA+ID4gZG1hX3N5bmNfc2luZ2xlX2Zvcl9kZXZpY2UoaTJjX2Rldi0+ZGV2LCArIGkyY19kZXYt
PmRtYV9waHlzLA0KPiA+ID4gPiA+ICsJCQkJCQkgICB4ZmVyX3NpemUsDQo+ID4gPiA+ID4gKw0K
PiA+ID4gPiA+IERNQV9UT19ERVZJQ0UpOw0KPiA+ID4gPiANCj4gPiA+ID4gQWdhaW4sIGhlcmUg
d2UgcHJvcGVybHkgZmx1c2ggdGhlIGNhY2hlcyB0byBtYWtlIHN1cmUgdGhlIGRhdGEgDQo+ID4g
PiA+IHRoYXQgd2UndmUgd3JpdHRlbiB0byB0aGUgRE1BIGJ1ZmZlciBpcyB2aXNpYmxlIHRvIHRo
ZSBETUEgZW5naW5lLg0KPiA+ID4gPiAgIA0KPiA+ID4NCj4gPiA+ICsxIHRoaXMgaXMgY29ycmVj
dA0KPiA+ID4NCj4gPiA+DQo+ID4gPiAgDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJCWlmIChp
MmNfZGV2LT5tc2dfcmVhZCkgew0KPiA+ID4gPiA+ICsJCQlpZiAobGlrZWx5KGkyY19kZXYtPm1z
Z19lcnIgPT0NCj4gPiA+ID4gPiBJMkNfRVJSX05PTkUpKSB7DQo+ID4gPiA+ID4gKw0KPiA+ID4g
PiA+IGRtYV9zeW5jX3NpbmdsZV9mb3JfY3B1KGkyY19kZXYtPmRldiwNCj4gPiA+ID4gPiArDQo+
ID4gPiA+ID4gaTJjX2Rldi0+ZG1hX3BoeXMsDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+IHhmZXJf
c2l6ZSwgKw0KPiA+ID4gPiA+IERNQV9GUk9NX0RFVklDRSk7DQo+ID4gPiA+IA0KPiA+ID4gPiBI
ZXJlIHdlIGludmFsaWRhdGUgdGhlIGNhY2hlcyB0byBtYWtlIHN1cmUgd2UgZG9uJ3QgZ2V0IHN0
YWxlIGRhdGEgDQo+ID4gPiA+IHRoYXQgbWF5IGJlIGluIHRoZSBjYWNoZXMgZm9yIGRhdGEgdGhh
dCB3ZSdyZSBjb3B5aW5nIG91dCBvZiB0aGUgDQo+ID4gPiA+IERNQSBidWZmZXIuIEkgdGhpbmsg
dGhhdCdzIGFib3V0IGFsbCB0aGUgY2FjaGUgbWFpbnRlbmFuY2UgdGhhdCB3ZSANCj4gPiA+ID4g
cmVhbCBuZWVkLg0KPiA+ID4NCj4gPiA+IENvcnJlY3QuDQo+ID4gPg0KPiA+ID4gQW5kIHRlY2hu
aWNhbGx5IGhlcmUgc2hvdWxkIGJlDQo+ID4gPiBkbWFfc3luY19zaW5nbGVfZm9yX2NwdShETUFf
VE9fREVWSUNFKSBmb3IgdGhlIFRYLiBCdXQgYWdhaW4sIGl0J3MgYSANCj4gPiA+IE5PLU9QLg0K
PiA+IA0KPiA+IElzIG15IGJlbG93IHVuZGVyc3RhbmRpbmcgY29ycmVjdD8gQ2FuIHlvdSBwbGVh
c2UgY29uZmlybT8NCj4gPiANCj4gPiBEdXJpbmcgVHJhbnNtaXQgdG8gZGV2aWNlOg0KPiA+IC0g
QmVmb3JlIHdyaXRpbmcgbXNnIGRhdGEgaW50byBkbWEgYnVmIGJ5IENQVSwgZ2l2aW5nIERNQSBv
d25lcnNoaXAgdG8gDQo+ID4gQ1BVIGRtYV9zeW5jX3NpbmdsZV9mb3JfY3B1IHdpdGggZGlyIERN
QV9UT19ERVZJQ0UNCj4gPiANCj4NCj4gSSB0cmllZCB0byB0YWtlIGEgbG9vayBhdCBpdCBhZ2Fp
biBhbmQgbm93IHRoaW5raW5nIHRoYXQgeW91ciB2YXJpYW50IGlzIG1vcmUgY29ycmVjdC4gU3Rp
bGwgaXQncyBhIGJpdCBkaWZmaWN1bHQgdG8ganVkZ2UgYmVjYXVzZSB0aGlzIGNhc2UgaXMgbm8t
b3AuDQo+DQo+ID4gLSBBZnRlciB3cml0aW5nIHRvIGRtYSBidWYgYnkgQ1BVLCBnaXZpbmcgYmFj
ayB0aGUgb3duZXJzaGlwIHRvIGRldmljZSANCj4gPiB0byBhY2Nlc3MgYnVmZmVyIHRvIHNlbmQg
ZHVyaW5nIERNQSB0cmFuc21pdCANCj4gPiBkbWFfc3luY19zaW5nbGVfZm9yX2RldmljZSB3aXRo
IGRpciBETUFfVE9fREVWSUNFDQo+DQo+IENvcnJlY3QuDQo+DQo+ID4gRHVyaW5nIFJlY2Vpdmlu
ZyBmcm9tIERldmljZToNCj4gPiAtIGJlZm9yZSBzdWJtaXR0aW5nIFJYIERNQSB0byBnaXZlIGJ1
ZmZlciBhY2Nlc3MgdG8gRE1BZW5naW5lDQo+ID4gCWRtYV9zeW5jX3NpbmdsZV9mb3JfRGV2aWNl
KERNQV9GUk9NX0RFVklDRSkNCj4NCj4gQ29ycmVjdC4NCj4NCj4gPiAtIGFmdGVyIERNQSBSWCBj
b21wbGV0aW9uLCBnaXZpbmcgZG1hIG93bmVyc2hpcCB0byBDUFUgZm9yIHJlYWRpbmcgDQo+ID4g
ZG1hYnVmIGRhdGEgd3JpdHRlbiBieSBETUEgZnJvbSBkZXZpY2UgZG1hX3N5bmNfc2luZ2xlX2Zv
cl9jcHUgd2l0aCANCj4gPiBkaXIgRE1BX0ZST01fREVWSUNFDQo+ID4gDQo+DQo+IENvcnJlY3Qu
DQoNClRoZW4gd2hhdCBJIGhhdmUgaXMgZXhhY3QgYXMgbWVudGlvbmVkIGFib3ZlLiBTbyBubyBj
aGFuZ2VzIG5lZWRlZCByZWxhdGVkIHRvIGRtYV9zeW5jDQpQYXN0aW5nIGFnYWluIGhlcmUgd2l0
aCBjbGVhciBjb21tZW50IHRvIGV4cGxhaW4gb24gd2h5IEkgaGF2ZSB0aG9zZSBjb3JyZXNwb25k
aW5nIGRtYV9zeW5jDQoNCiAgICAgICAgaWYgKGkyY19kZXYtPm1zZ19yZWFkKSB7DQogICAgICAg
ICAgICB0ZWdyYV9pMmNfY29uZmlnX2ZpZm9fdHJpZyhpMmNfZGV2LCB4ZmVyX3NpemUsDQogICAg
ICAgICAgICAgICAgICAgICAgICAgICBEQVRBX0RNQV9ESVJfUlgpOw0KICAgICAgICAgICAgLyog
Rm9yIFJlYWRzOiBnaXZpbmcgZG1hIGJ1ZiBvd25lcnNoaXAgdG8gZGV2aWNlIGJlZm9yZSBzdWJt
aXR0aW5nIFJYIERNQSAqLw0KICAgICAgICAgICAgZG1hX3N5bmNfc2luZ2xlX2Zvcl9kZXZpY2Uo
aTJjX2Rldi0+ZGV2LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgaTJjX2Rldi0+ZG1hX3Bo
eXMsDQogICAgICAgICAgICAgICAgICAgICAgICAgICB4ZmVyX3NpemUsDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICBETUFfRlJPTV9ERVZJQ0UpOw0KICAgICAgICAgICAgZXJyID0gdGVncmFf
aTJjX2RtYV9zdWJtaXQoaTJjX2RldiwgeGZlcl9zaXplKTsNCiAgICAgICAgICAgIGlmIChlcnIg
PCAwKSB7DQogICAgICAgICAgICAgICAgZGV2X2VycihpMmNfZGV2LT5kZXYsDQogICAgICAgICAg
ICAgICAgICAgICJzdGFydGluZyBSWCBETUEgZmFpbGVkLCBlcnIgJWRcbiIsDQogICAgICAgICAg
ICAgICAgICAgIGVycik7DQogICAgICAgICAgICAgICAgZ290byB1bmxvY2s7DQogICAgICAgICAg
ICB9DQogICAgICAgIH0gZWxzZSB7DQogICAgICAgICAgICB0ZWdyYV9pMmNfY29uZmlnX2ZpZm9f
dHJpZyhpMmNfZGV2LCB4ZmVyX3NpemUsDQogICAgICAgICAgICAgICAgICAgICAgICAgICBEQVRB
X0RNQV9ESVJfVFgpOw0KICAgICAgICAgICAgLyogRm9yIHdyaXRlczogZ2l2aW5nIGRtYSBidWYg
b3duZXJzaGlwIHRvIENQVSB0byBjb3B5IHRyYW5zbWl0IGRhdGEgdG8gRE1BIEJ1ZiAqLw0KICAg
ICAgICAgICAgZG1hX3N5bmNfc2luZ2xlX2Zvcl9jcHUoaTJjX2Rldi0+ZGV2LA0KICAgICAgICAg
ICAgICAgICAgICAgICAgaTJjX2Rldi0+ZG1hX3BoeXMsDQogICAgICAgICAgICAgICAgICAgICAg
ICB4ZmVyX3NpemUsDQogICAgICAgICAgICAgICAgICAgICAgICBETUFfVE9fREVWSUNFKTsNCiAg
ICAgICAgICAgIGJ1ZmZlciA9IGkyY19kZXYtPmRtYV9idWY7DQogICAgICAgIH0NCg0KDQoNCiAg
ICBpZiAoIW1zZy0+ZmxhZ3MgJiBJMkNfTV9SRCkgew0KICAgICAgICBpZiAoZG1hKSB7DQogICAg
ICAgICAgICBtZW1jcHkoYnVmZmVyLCBtc2ctPmJ1ZiwgbXNnLT5sZW4pOw0KICAgICAgICAgICAg
LyogRm9yIHdyaXRlczogZ2l2aW5nIG93bmVyc2hpcCB0byBkZXZpY2UgYWZ0ZXIgZG9uZSB3aXRo
IGNvcHlpbmcgZGF0YSB0byBETUEgQnVmICovDQogICAgICAgICAgICBkbWFfc3luY19zaW5nbGVf
Zm9yX2RldmljZShpMmNfZGV2LT5kZXYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICBpMmNf
ZGV2LT5kbWFfcGh5cywNCiAgICAgICAgICAgICAgICAgICAgICAgICAgIHhmZXJfc2l6ZSwNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgIERNQV9UT19ERVZJQ0UpOw0KICAgICAgICAgICAgZXJy
ID0gdGVncmFfaTJjX2RtYV9zdWJtaXQoaTJjX2RldiwgeGZlcl9zaXplKTsNCiAgICAgICAgICAg
IGlmIChlcnIgPCAwKSB7DQogICAgICAgICAgICAgICAgZGV2X2VycihpMmNfZGV2LT5kZXYsDQog
ICAgICAgICAgICAgICAgICAgICJzdGFydGluZyBUWCBETUEgZmFpbGVkLCBlcnIgJWRcbiIsDQog
ICAgICAgICAgICAgICAgICAgIGVycik7DQogICAgICAgICAgICAgICAgZ290byB1bmxvY2s7DQog
ICAgICAgICAgICB9DQogICAgICAgIH0gZWxzZSB7DQogICAgICAgICAgICB0ZWdyYV9pMmNfZmls
bF90eF9maWZvKGkyY19kZXYpOw0KICAgICAgICB9DQoNCiAgICAgICAgaWYgKGkyY19kZXYtPm1z
Z19yZWFkKSB7DQogICAgICAgICAgICBpZiAobGlrZWx5KGkyY19kZXYtPm1zZ19lcnIgPT0gSTJD
X0VSUl9OT05FKSkgew0KICAgICAgICAgICAgLyogRm9yIFJlYWRzOiBnaXZpbmcgb3duZXJzaGlw
IHRvIENQVSBhZnRlciBSWCBETUEgY29tcGxldGlvbiB0byBhY2Nlc3MgcmVhZCBkYXRhICovDQog
ICAgICAgICAgICAgICAgZG1hX3N5bmNfc2luZ2xlX2Zvcl9jcHUoaTJjX2Rldi0+ZGV2LA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGkyY19kZXYtPmRtYV9waHlzLA0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHhmZXJfc2l6ZSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBE
TUFfRlJPTV9ERVZJQ0UpOw0KDQogICAgICAgICAgICAgICAgbWVtY3B5KGkyY19kZXYtPm1zZ19i
dWYsIGkyY19kZXYtPmRtYV9idWYsDQogICAgICAgICAgICAgICAgICAgIG1zZy0+bGVuKTsNCiAg
ICAgICAgICAgIH0NCiAgICAgICAgfQ0KDQoNCg0K
