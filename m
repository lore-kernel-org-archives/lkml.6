Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B23C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260BC20821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cqxdZ23E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbfBFNEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:04:16 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:13302 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbfBFNEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:04:02 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5adb3f0000>; Wed, 06 Feb 2019 21:03:59 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 05:03:58 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 06 Feb 2019 05:03:58 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 13:03:57 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.51) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 6 Feb 2019 13:03:57 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3256.namprd12.prod.outlook.com (20.179.93.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.23; Wed, 6 Feb 2019 13:03:54 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 13:03:54 +0000
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
Subject: RE: [PATCH V12 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V12 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvaSihB2vPasFV02HZ/JY13Td7aXSqkqAgAAR9ACAAADL4A==
Date:   Wed, 6 Feb 2019 13:03:54 +0000
Message-ID: <BYAPR12MB3398E50ED1C6909D6BCB0DDFC26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
 <c4f67e39-df72-cc56-216b-8e6014891b52@gmail.com>
In-Reply-To: <c4f67e39-df72-cc56-216b-8e6014891b52@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3256;6:zRcSX39aJWFPQuGRALyGuqp0x5XmASWJ58cqp/wKkabA9Yq+qXFmtu4xOFPqs0gKTmckOdyozZmv+pjUTRqxOnX/avPSWPbLBblPcrs2rW6xE0om+Vh2tng4IYIOFXSns0Fb3y22HXCNqGGRdSgk502HIPB0gtEhBL6GXE43fA2LIjiFerulHmcZhPRq7cDUgaUp03rhE6U75o3MEsWT0fcSuaJtyi4SItEDV6fWj84OBqrVKPGr+bakUYlzOQ81F8gw6MTCFP/dxpYriES3n4yxuZdTZbUKoV7ZadrW04UEc3TqSjW0TRKsjOpY7bWYgUjVAqBxaNZzEBGuok5bp4XwzXbJ5eCwtdI16bDyTyeyi8QPAKEXNV5SKfz2P9XA//taYmu0RVqQm/0alXufLgcgmzCTA7FU8qCXRI68bjktgJDA22JN/VWt1Qpop54ZpYIRvxDbaB2MfukW0wH2PA==;5:RQqbld/tE0sH/RA16piTmtUfc1+LW6KmlAeu4NwCzFaVKpTwt8HlJ/zjRP9OjvTOXWE8qF1YD70A7kNumnF9PZ520TzlVYrqv83vrkyIKVXh2cPm9z5+I+FUylb/iaNeRrCX5KrMpCHQ7qOWF2is6me/6m2DqI+Sb6y1lcepHAVyqwoJd6OBoQDVTuUWQPGAuMv0jUbL2+7zgwwqhgC6uA==;7:BNfenHuqWQ+ci6gFBRvywwXLpl5ldV/agTM/x/MZnYwjfQ6ImfRqvi47sCdAknAF5/h62iPnrAQrwwjjiJpmANF7ZBtPS+VjkqnwOfTHlhucRGmbFbGQYQL/uxcW8qeWDGcytRHsnUS+BVt9jjk4Qw==
x-ms-office365-filtering-correlation-id: 3323da91-c7d8-4b71-6f0e-08d68c338c30
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3256;
x-ms-traffictypediagnostic: BYAPR12MB3256:
x-microsoft-antispam-prvs: <BYAPR12MB32564F78166856CFA99C29B8C26F0@BYAPR12MB3256.namprd12.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39850400004)(346002)(136003)(199004)(189003)(55016002)(68736007)(7736002)(26005)(8936002)(81166006)(81156014)(53936002)(8676002)(54906003)(6506007)(102836004)(486006)(93886005)(110136005)(76176011)(7696005)(97736004)(446003)(105586002)(4744005)(14454004)(33656002)(106356001)(476003)(99286004)(6636002)(186003)(478600001)(14444005)(256004)(9686003)(6246003)(2501003)(86362001)(6436002)(74316002)(25786009)(4326008)(316002)(6116002)(71190400001)(71200400001)(229853002)(305945005)(2906002)(3846002)(66066001)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3256;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RQJIiYH3xiej17eH4JeXu2H28C0f93JEEcyXBc2kH5yFdtkAGbn9GQ4dTczrfxW8tteDvAzgLJ8z7+ZNUkQ//gZGev05IIe9lBTyIc/oSRPgQWA+PkJ1VIaikC/Y26ErCFQ4tHcu2KEs7Pf4wEr0KeQyLRWsUP9HFf4u79ULj01U7ngUAG4oxz+S+WhexJa5PjKYVmkxyljnDiYWvWvyKkbkbQ+LNOu4xPRWLIh6lwEcRizIGTlosrC/8snNgaJwGotoEAP8aC/bo+U4Is6t2OkQkVpivZ6tGHSoRoBXKSalluFVskRCQEEN68rEVqwzH0EuU7ijc7vYitQGukDXbWklldKAumcL36wY5CkHILHpjH6L/mEQ6C7FU31Ikjcs1vakZHapfby2+XCYdw8vI+0K4twuhxqLrt6U/9xWIso=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3323da91-c7d8-4b71-6f0e-08d68c338c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 13:03:54.1488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3256
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549458239; bh=OIQKk5JMAOgClI7zmtUxvMJto0XXFxSvAZ/QpsedA88=;
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
        b=cqxdZ23E1kNtTUGxYrQxIJlSJ/hssFKGmzzRXHed3vqHBS4f9RPo98GV7gLzscHAy
         t4+sJOXp1hiedLmxSUbnFLM/7I6fYEW0YiuF0hMecbm7WYfXxDyAvAF6UwmfIK6lAU
         4L/PdBQZrf9hGb6JzRiYXOg5Y4V303MY3o+SAvJ8JVQRQ0chgsuDcpF3DCbZTJ/yn5
         EmtJG92/LtZV22NAnGlvqNfOF9N9f9m4H2oQBj8i/OeYBm7OBCMHrUDm5YpLIKxQcN
         FsdbS+Szr0fU72zuD4eE1Ib4WzjYRuXF16KqmQ8oR1SCJUFoJHz/wR8OAn6yc6OPOf
         0R8ow4MYNkmpw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBCVFcsIEknbSBzZWVpbmcgImF0bWVsX214dF90cyAwLTAwNGM6IFdhcm5pbmc6IEluZm8gQ1JD
IGVycm9yIC0gZGV2aWNlPTB4RjQzNkRDIGZpbGU9MHgwMDAwMDAiIHdoaXRob3V0IG1ha2luZyBh
bnkgbW9kaWZpY2F0aW9ucyB0byB0aGUgb3JpZ2luYWwgcGF0Y2ggYXMgd2VsbCBhbmQgaXQgc2hh
bGwgbm90IGhhcHBlbiwgaGVuY2UgdGhlcmUgaXMgYnVnIHNvbWV3aGVyZS4gUHJvYmFibHkgRklG
TyB0cmlnZ2VycyBhcmUgc3RpbGwgbm90IHNldCB1cCBjb3JyZWN0bHkuLi4gPw0KPg0KPg0KSW4g
c25pcHBldCB5b3Ugc2VudCwgSSBzZWUgeW91IGFyZSBmb3JjaW5nIGRtYV9idXJzdCB0byAxIGFs
d2F5cyB3aGljaCBpcyB3aGF0IHNldCBmb3IgZmlmbyB0cmlnZ2VyIGxldmVscyBhcyB3ZWxsIGFu
ZCBhbHNvIHlvdSBhcmUgZm9yY2luZyBkbWEgYWxsIHRoZSB0aW1lLg0KU28gYWx3YXlzIGl0IHdp
bGwgYmUgMSB3b3JkIGRtYSBidXJzdCBhbmQgMSB3b3JkIHRyaWdnZXIgbGV2ZWwgYW5kIHRoYXQg
c2hvdWxkIG5vdCBiZSBhbiBpc3N1ZS4NCg0K
