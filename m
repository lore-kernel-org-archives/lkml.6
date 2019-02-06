Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222C8C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71E42175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GdFhHc3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfBFNpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:45:35 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6392 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfBFNpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:45:35 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5ae4dd0001>; Wed, 06 Feb 2019 05:45:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 05:45:33 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 06 Feb 2019 05:45:33 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 13:45:32 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.52) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 6 Feb 2019 13:45:32 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3512.namprd12.prod.outlook.com (20.179.94.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 13:45:29 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 13:45:29 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V12 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V12 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvaSihB2vPasFV02HZ/JY13Td7aXSqkqAgAAUt4CAAAEfAIAAAXOAgAAAhsCAAAYqgIAAADAA
Date:   Wed, 6 Feb 2019 13:45:29 +0000
Message-ID: <BYAPR12MB339826EB972C5DB7957E8A82C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
 <20190206130909.GJ21676@ulmo> <20190206131310.GK21676@ulmo>
 <d16dd60a-bfb4-75e8-3d19-97b565c815b0@gmail.com>
 <BYAPR12MB33983A0E93B17808DECFD0F2C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <6edef92d-66a7-0f70-e59e-7381b82516eb@gmail.com>
In-Reply-To: <6edef92d-66a7-0f70-e59e-7381b82516eb@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3512;6:5kEonWmiCTljrKsFVV7Nc1pXFKPNGSpQVWzhBprtX32gRB1APHQ5cJEWzSZBiYzZz6rD95pt7JpXf9soqDjCarYY4GjuT3gxtMEeXGfJDaorITeP7cRv2WeRzCz8iuuN0pH0t6Xr7GArhkltnj8rhTgZqJnpqUIHG/FDRfN2GRRG23paJ4bGbWH8L7gDKg6J+79hx6INXJZZ2gUEdKsHaU8RxHC8yIPFjYm/HSl/GPijyeZ9Tpn488J5PRrGdAKHRo/lFbHHSpBZCdKvJR6JKXNKir9zU0Vi79VOu/kf74WIKnjXJGovXJyiNS0oFB9osR4OAX6vtWkfpKiaLPa8HT0LlG5R+AgiZ7fmUtGhFCQjGiSeAz1JnNufDI2gGvjrv8B4N2i9bxNdES7LgBp7Ae8ZpomVUC9geYJG4smodOOd80K4MRiKoWqgK2/L3em7TYQGUWxYjHwniKG6XzqE8w==;5:AGLzy9E4mFKjr62/SqM4J+8WkMD13U7M9RKH2FNOzupqmfBRufJXem5Gk76/BPoxHMXFKibb0LBstSGMguzKyPZBX7Ul/8sh0j+kqmruKTs8YjrYa64jrEK4diQeJQennweKxREqQSP72FHSa1iaAYRWY434on4k04iyOeCb1mvZY9sudyWz69meJ/ulFeHUjN1sxgt+5CZlFR3si9ldUw==;7:IL5dCEA9IDq2i+k056BwYicR9i7fQDjotk/3XJoXTaVmiIS/p7YFaSptHsPmAMgW8q2itnEHvLGmsqRT+0bPb9dL4qyXShb+Bn/DcuOPFUaWV9yg/kPpwq1n7MrIqcDIR5i9baLJggWMIq2VqpWi5A==
x-ms-office365-filtering-correlation-id: c6d72e4d-2c71-4f44-150b-08d68c395b7a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3512;
x-ms-traffictypediagnostic: BYAPR12MB3512:
x-microsoft-antispam-prvs: <BYAPR12MB3512EA6B23DD010C981B8C95C26F0@BYAPR12MB3512.namprd12.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(366004)(189003)(199004)(99286004)(7696005)(6506007)(25786009)(76176011)(6246003)(11346002)(486006)(476003)(74316002)(110136005)(26005)(186003)(102836004)(86362001)(446003)(316002)(71190400001)(478600001)(71200400001)(66066001)(93886005)(33656002)(8936002)(97736004)(55016002)(81166006)(6436002)(9686003)(68736007)(229853002)(256004)(4326008)(3846002)(6116002)(7736002)(106356001)(81156014)(2906002)(105586002)(14454004)(53936002)(54906003)(8676002)(305945005)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3512;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fEEFs1m1D5kzrUd4hjfSCmGe7nw1OGVTwATKqkCbNk0mbgYDmR57cbbdJSut+1FCcRRCGBsEg1G+DxSW6ThM5L4wQXe3byeG6GUNesgjmc0gXhmiSikvSZyl7doIfhqZ08ZT1C30jlNxGFmjuLUZpKvZc8MexSk+ijfH6+I0rM22z/vLvqcUto3F6h5mS1aodpAsiASZNIQgD/nrCZbqxSDS1jXIvsMZLqtcNwffIrK85M6DB+8Au/F9pTx9FbtXdISX5EKETb0/CGpoJntiMn89IF3id8Oaz4mOMxnqYaOplrj+6aLvO0AHJRk9EHJ8KJqHgS1df2vWcsM+vAH51DjhbZor9eJoBRd4MhDXUAS6/m822BzdicpyECGOvovocQNrH4z3pcvhvOlNR5qyKg67rL8AYH6/rQawsgojijg=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d72e4d-2c71-4f44-150b-08d68c395b7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 13:45:29.4064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3512
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549460701; bh=CIkzNdysgn8lzBX4aCENKrx95ip/4bW5MhFOHiJnNKU=;
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
        b=GdFhHc3YwvOtfVfMuVrS+8aLwZd3JE2mO5z3CJ10wySXUnOskWJKFiwEZen5cgZtN
         rCKPkY3TW82yZBoHm9DEOLljYFRZaZbiBWL6+8JvvMr0cdlWXGiVVTB6bcAhmH0xrB
         KNXSoWfbLJba1MfpU6Xxbj75miiIx20QF66o8EnQdPWbvwu9yXpGcsId3hhpJq4B4m
         IwaNbQ8Q0VVLoxduRD5Yj1Hp/8ZGS5CduaIdsNwcQmPpGM+l90AfDkurJI1YQgXaCj
         UG+GQNx6rSinMs4hJPC9pdchfVlZGCqWelUN+3dZPJ5vs/9cZdXiq/k8BcM2kcfaHS
         yNgiKUOjdV35A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gPj4+PiBUaGF0J3Mgb2RkIGJlY2F1c2UgaXQgc3VnZ2VzdHMgdGhhdCBETUEgYWN0dWFs
bHkgY29tcGxldGVkLCBidXQgdGhlIA0KPiA+Pj4+IG1lc3NhZ2UgZGlkbid0Lg0KPiA+Pj4+DQo+
ID4+Pj4gSSdtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCBob3cgdGhhdCBjb3VsZCBoYXBwZW4uDQo+
ID4+Pj4NCj4gPj4+PiBXaGF0J3MgYWxzbyB3ZWlyZCBhYm92ZSBpcyB0aGF0IHRoZXJlIGRvZXNu
J3Qgc2VlbSB0byBiZSBhIERNQSB0aGF0IA0KPiA+Pj4+IGlzIHN0YXJ0ZWQgZm9yIHRoYXQgcGFy
dGljdWxhciBtZXNzYWdlLiBPciBpcyB0aGUgdGltZW91dCBtZXNzYWdlIGEgDQo+ID4+Pj4gcmVz
cG9uc2UgdG8gdGhlIHByaW9yIHRyYW5zZmVyIChsZW5ndGggMTApPyBTZWVtcyBsaWtlIHRoYXQg
c2hvdWxkIA0KPiA+Pj4+IG5vdCBiZSBwb3NzaWJsZSBiZWNhdXNlIHdlIGdldCB0aGUgInRyYW5z
ZmVyIGNvbXBsZXRlIiBtZXNzYWdlLg0KPiA+Pj4NCj4gPj4+IFdhaXQsIHRob3NlIGFyZSBhY3R1
YWxseSBkaWZmZXJlbnQgaW5zdGFuY2VzIG9mIHRoZSBJMkMgY29udHJvbGxlciwgDQo+ID4+PiBz
byB0aGUgcmVsZXZhbnQgbG9nIGVudHJpZXMgYXJlIHRoZXNlOg0KPiA+Pj4NCj4gPj4+IAlbICAg
IDAuOTQ1NDQ1XSB0ZWdyYS1pMmMgNzAwMGQwMDAuaTJjOiBzdGFydGluZyBETUEgZm9yIGxlbmd0
aDogMTYNCj4gPj4+IAlbICAgIDAuOTQ1NDU2XSB0ZWdyYS1pMmMgNzAwMGQwMDAuaTJjOiB1bm1h
c2tlZCBpcnE6IDBjDQo+ID4+PiAJLi4uDQo+ID4+PiAJWyAgICAxLjA0OTIyNF0gdGVncmEtaTJj
IDcwMDBkMDAwLmkyYzogaTJjIHRyYW5zZmVyIHRpbWVkIG91dA0KPiA+Pj4NCj4gPj4+IEFuZCB0
aGVzZSBkb24ndCBoYXBwZW4gaWYgeW91IHVzZSBoaWdoZXIgYnVyc3Qgc2l6ZXMgb3IgYmVmb3Jl
IHRoZSANCj4gPj4+IERNQSBzZXJpZXM/DQo+ID4+DQo+ID4+IEkgdHJpZWQgdG8gZW5mb3JjZSBE
TUEgd2l0aG91dCBjaGFuZ2luZyBidXJzdHM6DQo+ID4+DQo+ID4+IC0tLS0tLS0tLS0NCj4gPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtdGVncmEuYyANCj4gPj4gYi9kcml2
ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3JhLmMgaW5kZXggYzUzOGVkNWY4ZTJjLi41ZDFjNTRjZTc4
MDAgDQo+ID4+IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3Jh
LmMNCj4gPj4gKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jDQo+ID4+IEBAIC02
LDYgKzYsOCBAQA0KPiA+PiAgICogQXV0aG9yOiBDb2xpbiBDcm9zcyA8Y2Nyb3NzQGFuZHJvaWQu
Y29tPg0KPiA+PiAgICovDQo+ID4+ICANCj4gPj4gKyNkZWZpbmUgREVCVUcNCj4gPj4gKw0KPiA+
PiAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiA+PiAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+
DQo+ID4+ICAjaW5jbHVkZSA8bGludXgvZG1hZW5naW5lLmg+DQo+ID4+IEBAIC0xMDQ2LDggKzEw
NDgsNyBAQCBzdGF0aWMgaW50IHRlZ3JhX2kyY194ZmVyX21zZyhzdHJ1Y3QgdGVncmFfaTJjX2Rl
diAqaTJjX2RldiwNCj4gPj4gICAgICAgICAgICAgICAgIHhmZXJfc2l6ZSA9IG1zZy0+bGVuICsg
STJDX1BBQ0tFVF9IRUFERVJfU0laRTsNCj4gPj4gIA0KPiA+PiAgICAgICAgIHhmZXJfc2l6ZSA9
IEFMSUdOKHhmZXJfc2l6ZSwgQllURVNfUEVSX0ZJRk9fV09SRCk7DQo+ID4+IC0gICAgICAgaTJj
X2Rldi0+aXNfY3Vycl9kbWFfeGZlciA9ICh4ZmVyX3NpemUgPiBJMkNfUElPX01PREVfTUFYX0xF
TikgJiYNCj4gPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaTJjX2Rldi0+
ZG1hX2J1ZjsNCj4gPj4gKyAgICAgICBpMmNfZGV2LT5pc19jdXJyX2RtYV94ZmVyID0gISFpMmNf
ZGV2LT5kbWFfYnVmOw0KPiA+PiAgICAgICAgIHRlZ3JhX2kyY19jb25maWdfZmlmb190cmlnKGky
Y19kZXYsIHhmZXJfc2l6ZSk7DQo+ID4+ICAgICAgICAgZG1hID0gaTJjX2Rldi0+aXNfY3Vycl9k
bWFfeGZlcjsNCj4gPj4gLS0tLS0tLS0tLQ0KPiA+Pg0KPiA+PiBIZXJlIGlzIHRoZSBsb2cgd2l0
aCB0aGlzIGNoYW5nZToNCj4gPj4NCj4gPj4gWyAgICAwLjc2MDc5Nl0gdGVncmFfcnRjIDcwMDBl
MDAwLnJ0YzogcmVnaXN0ZXJlZCBhcyBydGMxDQo+ID4+IFsgICAgMC43NjA4NTBdIHRlZ3JhX3J0
YyA3MDAwZTAwMC5ydGM6IFRlZ3JhIGludGVybmFsIFJlYWwgVGltZSBDbG9jaw0KPiA+PiBbICAg
IDAuNzYxMDUwXSBpMmMgL2RldiBlbnRyaWVzIGRyaXZlcg0KPiA+PiBbICAgIDAuOTE4OTI4XSB0
ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiBzdGFydGluZyBETUEgZm9yIGxlbmd0aDogMTYNCj4gPj4g
WyAgICAwLjkxODk0MF0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNrZWQgaXJxOiAwYw0K
PiA+PiBbICAgIDAuOTE5MDQwXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0cmFuc2ZlciBjb21w
bGV0ZTogMTAgMCAwDQo+ID4+IFsgICAgMC45MTkwNTBdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6
IHN0YXJ0aW5nIERNQSBmb3IgbGVuZ3RoOiA4DQo+ID4+IFsgICAgMC45MTkwNTldIHRlZ3JhLWky
YyA3MDAwYzAwMC5pMmM6IHVubWFza2VkIGlycTogMGMNCj4gPj4gWyAgICAwLjkxOTMyMl0gdGVn
cmEtaTJjIDcwMDBjMDAwLmkyYzogdHJhbnNmZXIgY29tcGxldGU6IDEwIDAgMA0KPiA+PiBbICAg
IDAuOTE5MzM1XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiBzdGFydGluZyBETUEgZm9yIGxlbmd0
aDogMTYNCj4gPj4gWyAgICAwLjkxOTM0M10gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNr
ZWQgaXJxOiAwYw0KPiA+PiBbICAgIDAuOTE5NDQwXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0
cmFuc2ZlciBjb21wbGV0ZTogMTAgMCAwDQo+ID4+IFsgICAgMC45MTk0NDhdIHRlZ3JhLWkyYyA3
MDAwYzAwMC5pMmM6IHN0YXJ0aW5nIERNQSBmb3IgbGVuZ3RoOiAxMTINCj4gPj4gWyAgICAwLjkx
OTQ1Nl0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNrZWQgaXJxOiAwYw0KPiA+PiBbICAg
IDAuOTIyODE4XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0cmFuc2ZlciBjb21wbGV0ZTogMTEg
MCAwDQo+ID4+IFsgICAgMC45MjI4MjldIGF0bWVsX214dF90cyAwLTAwNGM6IEZhbWlseTogMTYw
IFZhcmlhbnQ6IDAgRmlybXdhcmUgVjEuMC5BQSBPYmplY3RzOiAxOA0KPiA+PiBbICAgIDAuOTIy
ODg2XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiBzdGFydGluZyBETUEgZm9yIGxlbmd0aDogMTYN
Cj4gPj4gWyAgICAwLjkyMjg5NV0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNrZWQgaXJx
OiAwYw0KPiA+PiBbICAgIDAuOTIyOTkzXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0cmFuc2Zl
ciBjb21wbGV0ZTogMTAgMCAwDQo+ID4+IFsgICAgMC45MjMwMDJdIHRlZ3JhLWkyYyA3MDAwYzAw
MC5pMmM6IHN0YXJ0aW5nIERNQSBmb3IgbGVuZ3RoOiAyMjQNCj4gPj4gWyAgICAwLjkyMzAxMV0g
dGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNrZWQgaXJxOiAwYw0KPiA+PiBbICAgIDAuOTMz
MjUzXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0cmFuc2ZlciBjb21wbGV0ZTogMTEgMCAwDQo+
ID4+IFsgICAgMC45MzMyODddIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHN0YXJ0aW5nIERNQSBm
b3IgbGVuZ3RoOiAxNg0KPiA+PiBbICAgIDAuOTMzMjk3XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJj
OiB1bm1hc2tlZCBpcnE6IDBjDQo+ID4+IFsgICAgMC45MzM0NzhdIHRlZ3JhLWkyYyA3MDAwYzAw
MC5pMmM6IHRyYW5zZmVyIGNvbXBsZXRlOiAxMCAwIDANCj4gPj4gWyAgICAwLjkzMzQ4N10gdGVn
cmEtaTJjIDcwMDBjMDAwLmkyYzogc3RhcnRpbmcgRE1BIGZvciBsZW5ndGg6IDEyDQo+ID4+IFsg
ICAgMC45MzM0OTZdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHVubWFza2VkIGlycTogMGMNCj4g
Pj4gWyAgICAwLjk0NTEyMF0gdGVncmEtaTJjIDcwMDBkMDAwLmkyYzogc3RhcnRpbmcgRE1BIGZv
ciBsZW5ndGg6IDE2DQo+ID4+IFsgICAgMC45NDUxMzBdIHRlZ3JhLWkyYyA3MDAwZDAwMC5pMmM6
IHVubWFza2VkIGlycTogMGMNCj4gPj4gWyAgICAxLjAzODkxN10gdGVncmEtaTJjIDcwMDBjMDAw
LmkyYzogRE1BIHRyYW5zZmVyIHRpbWVvdXQNCj4gPj4gWyAgICAxLjAzODk4Ml0gYXRtZWxfbXh0
X3RzIDAtMDA0YzogX19teHRfcmVhZF9yZWc6IGkyYyB0cmFuc2ZlciBmYWlsZWQgKC0xMTApDQo+
ID4+IFsgICAgMS4wMzkwMDBdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHN0YXJ0aW5nIERNQSBm
b3IgbGVuZ3RoOiAxNg0KPiA+PiBbICAgIDEuMDM5MDA2XSBhdG1lbF9teHRfdHMgMC0wMDRjOiBG
YWlsZWQgdG8gcmVhZCBUNDQgYW5kIFQ1ICgtMTEwKQ0KDQoNCg0KPiA+PiBbICAgIDEuMDM5MDA5
XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB1bm1hc2tlZCBpcnE6IDBjDQo+ID4+IFsgICAgMS4w
MzkxNDhdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHRyYW5zZmVyIGNvbXBsZXRlOiAxMCAwIDAN
Cj4gPj4gWyAgICAxLjAzOTE1N10gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogc3RhcnRpbmcgRE1B
IGZvciBsZW5ndGg6IDQNCj4gPj4gWyAgICAxLjAzOTE2Nl0gdGVncmEtaTJjIDcwMDBjMDAwLmky
YzogdW5tYXNrZWQgaXJxOiAwYw0KPiA+PiBbICAgIDEuMDM5MzA0XSB0ZWdyYS1pMmMgNzAwMGMw
MDAuaTJjOiB0cmFuc2ZlciBjb21wbGV0ZTogMTAgMCAwDQo+ID4+IFsgICAgMS4wMzkzNDBdIHRl
Z3JhLWkyYyA3MDAwYzAwMC5pMmM6IHN0YXJ0aW5nIERNQSBmb3IgbGVuZ3RoOiAxNg0KPiA+PiBb
ICAgIDEuMDM5MzQ5XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB1bm1hc2tlZCBpcnE6IDBjDQo+
ID4+IFsgICAgMS4wMzk1MzVdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHRyYW5zZmVyIGNvbXBs
ZXRlOiAxMCAwIDANCj4gPj4gWyAgICAxLjAzOTU0NF0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzog
c3RhcnRpbmcgRE1BIGZvciBsZW5ndGg6IDEyDQo+ID4+IFsgICAgMS4wMzk1NTJdIHRlZ3JhLWky
YyA3MDAwYzAwMC5pMmM6IHVubWFza2VkIGlycTogMGMNCj4gPj4gWyAgICAxLjA0MDA1NV0gdGVn
cmEtaTJjIDcwMDBjMDAwLmkyYzogdHJhbnNmZXIgY29tcGxldGU6IDEwIDAgMA0KPiA+PiBbICAg
IDEuMDQwMDgzXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiBzdGFydGluZyBETUEgZm9yIGxlbmd0
aDogMTYNCj4gPj4gWyAgICAxLjA0MDA5Ml0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNr
ZWQgaXJxOiAwYw0KPiA+PiBbICAgIDEuMDQwMzAxXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0
cmFuc2ZlciBjb21wbGV0ZTogMTAgMCAwDQo+ID4+IFsgICAgMS4wNDg5MzRdIHRlZ3JhLWkyYyA3
MDAwZDAwMC5pMmM6IGkyYyB0cmFuc2ZlciB0aW1lZCBvdXQNCj4gPiANCj4gPiBUaGlzIGxvZyBz
aG93cyBETUEgdHJhbnNmZXIgdGltZW91dCBmb3IgYXRtZWwgcmVhZC4NCj4gPiBEbyB5b3Ugc2Vl
IGlzc3VlIGlmIHlvdSBkb27igJl0IGVuZm9yY2UgZG1hIGFsbCB0aW1lIGFuZCBsZXQgaXQgY2hv
b3NlIFBJTyBWcyBETUE/DQo+ID4gDQo+IA0KPiBObywgdGhlcmUgYXJlIG5vIHRpbWVvdXQgZXJy
b3JzIGluIFBJTyBtb2RlLiBJIGNvdWxkIHBvc3QgZnVsbCBsb2cgd2l0aCB0aGUgUElPLW9ubHkg
bW9kZSBpZiB5b3Ugd2FudC4NCj4NClllcyBwbGVhc2UgcG9zdCBmdWxsIGxvZyBvZiBQSU8gb25s
eSBhbmQgRE1BIG9ubHkNCg==
