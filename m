Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752B1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D52218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iFvXloF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfBGTOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:14:37 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11175 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfBGTOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:14:37 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5c838a0000>; Thu, 07 Feb 2019 11:14:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 07 Feb 2019 11:14:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 07 Feb 2019 11:14:35 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 7 Feb
 2019 19:14:34 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.55) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 7 Feb 2019 19:14:34 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3061.namprd12.prod.outlook.com (20.178.54.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 7 Feb 2019 19:14:33 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 19:14:33 +0000
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
Thread-Index: AQHUvlB3grXi65/4z0qjAfijKk4nv6XUr0UAgAAAKPCAAAN0gIAAAsXg
Date:   Thu, 7 Feb 2019 19:14:33 +0000
Message-ID: <BYAPR12MB339812565AB1C9973A934522C2680@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
 <e09062b7-9c74-6aee-477a-72fb72bbd5d3@gmail.com>
 <BYAPR12MB33980D6751904EBEFC38BBAAC2680@BYAPR12MB3398.namprd12.prod.outlook.com>
 <da8138fe-ea4b-42be-1065-c7098ac59691@gmail.com>
In-Reply-To: <da8138fe-ea4b-42be-1065-c7098ac59691@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3061;6:M13y8Siq8AcqM6ycbkvx5v0kTV8Ts4cSZQIQSk+2NoNunuXEaduLzM4rxPWeR1j/gyQNIZCPmSrQ71wtTzAjMJ0VmFMWpputAgsFTGWFVJnnTZRlxE3GYen8DuedzvsxHVWamTTsj7+E46YZi9y5XUitFgbgdUod4Hw2aml7QycQplyP88J9K/pSYX8M1ARdCS6uVC1QDpHC1+JNC+QvSMSiNCA6BGTrh9yYGZvcvPdJY39Y8PeWfOK/MA/JdLJLLfHOE9Jy5B/lmlmYo8OMx2MGNQONTNk+u/WoEad0Nb3oZCF3CzGk2LELH/7LZ4X3XuC3yK9+FPn4s4ssVfSCpSjW/IIVjo56xvSVapVDUOzwMy6Ud9/HmSI3SQs6RiL6Rax+vWijXzmHBUMsWWnUddWQb8dnv8+qS8P1Ph8Mclqx9iH8f4DIET8ueDYgNA8wrVd6xBPIoOUhZEogumMMIg==;5:gmeDEKivb9KLaqMCTsRW5QP25zL8BEtHDoxWJYHScBYQJEJBnbT6pMLNFQlBL3NJIfgmzdddlpZlOoJwgG5fYH2NDDFM8EE60XbyV7DrlfTkqHOnc+dEWpv9yotyL32ivqe6AnVW0IIMOZU7mIOd8CLOdnt2DBQ61bdRsYNq1SNIKFKT/lmVvyqROQFFTGV39AkTrlkx8B6fkRoJJJz+0g==;7:HKZxsNmDMaZ0M1Cugx9V+AvCFkffujTJv+AHaCGGyo7pC1gF60xzvYzB1iNbwJ5tCpZIfx/dUg6pwNJzVPzRNl0jU9uyF5NbGzuBRqscvnFoYekC3qk3J5A2QYIfPwqV6D2dJVpJS/Y5aWUWrnVFEQ==
x-ms-office365-filtering-correlation-id: 40d7314a-382f-4348-281d-08d68d307e3c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3061;
x-ms-traffictypediagnostic: BYAPR12MB3061:
x-microsoft-antispam-prvs: <BYAPR12MB3061882B250099EEF32E03BFC2680@BYAPR12MB3061.namprd12.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(376002)(39860400002)(189003)(199004)(305945005)(33656002)(6506007)(3846002)(74316002)(8676002)(6116002)(81166006)(81156014)(7736002)(66066001)(6436002)(8936002)(86362001)(93886005)(97736004)(68736007)(102836004)(53936002)(4326008)(256004)(14444005)(25786009)(6246003)(99286004)(446003)(486006)(476003)(186003)(71190400001)(106356001)(71200400001)(55016002)(26005)(478600001)(2906002)(54906003)(110136005)(76176011)(229853002)(6636002)(316002)(7696005)(11346002)(14454004)(105586002)(2501003)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3061;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /UqwSgjQM0Q4ZtXZL/Sea+DqXkFEXbaB7Jv+LrneCkwG3qLVZWZMhaYiWoERgyyohrPV4V5lV59kAa8GYWs7cmYFUsiO5Z8GaUVuEB1rLzLiN9EYR0QU00JHBWtBsy9xScciODNt5PGVIwSXOOXAM1M9Sni74eSdy04+/h/SZMHy+82GlmU4SX5CVluurKC+JwEiVfxvrk5UrdWSHatrXJLlHXNIUIyHXu2CVn3+f9j3STVKwAXW97hp6Wie94I/VJKtM5TIu7akXexEt+fJcX4PKpu+UJ3T5fGg5b1ajiaczgsi/P9TGgpY4EydUQYDBZF37h1TzNsv0DNLzd9Hz/N5OAJSpNz7IDjvqdTR98dPl0Fqk3l59+E7l8wU4b9q3eGRmVAQq1jt+05Lkj9VTa5CsUTXbbQJncucd+nXvMU=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d7314a-382f-4348-281d-08d68d307e3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 19:14:33.3791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3061
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549566858; bh=kwgOXvUjy405fBEJeSNFnbYFQ7mP58rNC73M0CyANtc=;
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
        b=iFvXloF+3JavMeSV0q2lTcORmftnQ72vxKmGeDR7+Oo72Kn1/KHWXQ5xrBv43stbK
         qOzdzkFYS53lioGUaqmCF3sDE1Jgg/dqwsfM9H4YBItE6vEYlfmc6aCR3PgAHtZ1RI
         Q7bIukHtCihIJbAHVst5KNE2dq6Ihv06Ztdw1I66WgMXCQRiU699YXWsdChAdqEQ25
         9sQJWdz6ePHIu8OfbIgzo6eO3tb0Ji+DZaCPPrWrBbduZ/pmVxEM1p9Ws7OGMmaw4Q
         AJv3wAxkk2gwYqQ1fF5EjFfyrwluSpqHun0ZrI0GiV4S1Nd/5uZ5pvMc5QQ+4QjTGe
         N/vtwh6V3YQQA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gPj4+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHRlZ3JhX2kyY19od19mZWF0dXJlIHRlZ3Jh
MjEwX2kyY19odyA9IHsgQEAgDQo+ID4+PiAtOTgwLDYgKzEzMDIsNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IHRlZ3JhX2kyY19od19mZWF0dXJlIHRlZ3JhMjEwX2kyY19odyA9IHsNCj4gPj4+ICAJ
Lmhhc19tc3RfZmlmbyA9IGZhbHNlLA0KPiA+Pj4gIAkucXVpcmtzID0gJnRlZ3JhX2kyY19xdWly
a3MsDQo+ID4+PiAgCS5zdXBwb3J0c19idXNfY2xlYXIgPSB0cnVlLA0KPiA+Pj4gKwkuaGFzX2Fw
Yl9kbWEgPSB0cnVlLA0KPiA+Pj4gIH07DQo+ID4+DQo+ID4+IFQxODYgaXMgbWlzc2VkIGhlcmUu
DQo+ID4gDQo+ID4gQ3VycmVudGx5IHQxODYgaHcgZmVhdHVyZSBpcyBub3QgcHJlc2VudCBpbiBl
eGlzdGluZyBsaW51eCBuZXh0IGFuZCBkZXZpY2UgdHJlZXMgdXNlIGJvdGggdDE4NiBhbmQgdDEx
NCBjb21wYXRpYmxlcywgc28gdDExNCBpcyBiZWluZyBhcHBsaWVzLg0KPiA+IEJ1dCBkbWFzIGFy
ZSBub3QgdXNlZCBmb3IgdDE4NiB5ZXQuDQo+ID4gDQo+ID4gVDE4NiBodyBmZWF0dXJlIGlzIGFk
ZGVkIGZvciBmaXJzdCB0aW1lIGFzIHBhcnQgb2YgaW50ZXJmYWNlIHRpbWluZyBhbmQgaXRzIGlu
IHBhdGNoIG5leHQgdG8gdGhpcyBwYXRjaCBpbiBzYW1lIHNlcmllcy4NCj4gPiBUaGlzIGlzIHRo
ZSBzYW1lIGZyb20gYmVnaW5uaW5nIG9mIGFsbCB0aGVzZSBzZXJpZXMuDQo+ID4NCj4gPj4NCj4g
Pj4+ICANCj4gPj4+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHRlZ3JhX2kyY19od19mZWF0dXJlIHRl
Z3JhMTk0X2kyY19odyA9IHsgQEAgDQo+ID4+PiAtOTk1LDYgKzEzMTgsNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IHRlZ3JhX2kyY19od19mZWF0dXJlIHRlZ3JhMTk0X2kyY19odyA9IHsNCj4gPj4+
ICAJLmhhc19tc3RfZmlmbyA9IHRydWUsDQo+ID4+PiAgCS5xdWlya3MgPSAmdGVncmExOTRfaTJj
X3F1aXJrcywNCj4gPj4+ICAJLnN1cHBvcnRzX2J1c19jbGVhciA9IHRydWUsDQo+ID4+PiArCS5o
YXNfYXBiX2RtYSA9IGZhbHNlLA0KPiA+Pj4gIH07DQo+ID4gDQo+DQo+IFlvdSBhZGRlZCAiaGFz
X2FwYl9kbWEiIGZvciBUMTk0IGFuZCBub3QgVDE4NiBpbiB0aGlzIHBhdGNoLCBJIGhhcHBlbmVk
IHRvIG5vdGljZSBpdCBvbmx5IHJpZ2h0IG5vdy4gUGxlYXNlLCBsZXQncyBiZSBjb25zaXN0ZW50
IGFuZCBzZXQgdGhlIG5ldyBmaWVsZCBmb3IgYWxsIG9mIHRoZSBwbGF0Zm9ybXMgaW4gdGhpcyBw
YXRjaC4NCg0KT0ssIFdpbGwgbW92ZSB0MTg2IGh3IGZlYXR1cmUgYWRkaXRpb24gdG8gdGhpcyBw
YXRoIGZyb20gaW50ZXJmYWNlIHRpbWluZyB0byByZWZsZWN0IGFwYiBkbWEgZmxhZy4NCg==
