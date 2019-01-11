Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6232FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2117D20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hs5eUGuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbfAKAfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:35:07 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:55076 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbfAKAfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:35:07 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c37e4b90000>; Fri, 11 Jan 2019 08:35:05 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 10 Jan 2019 16:35:02 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 10 Jan 2019 16:35:02 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 11 Jan
 2019 00:35:01 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.52) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 11 Jan 2019 00:35:01 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com (20.176.178.161) by
 BN7PR12MB2658.namprd12.prod.outlook.com (20.176.176.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Fri, 11 Jan 2019 00:34:59 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::4024:c208:f331:505e]) by BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::4024:c208:f331:505e%3]) with mapi id 15.20.1516.015; Fri, 11 Jan 2019
 00:34:57 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH V7 2/2] mmc: tegra: HW Command Queue Support for Tegra
 SDMMC
Thread-Topic: [PATCH V7 2/2] mmc: tegra: HW Command Queue Support for Tegra
 SDMMC
Thread-Index: AQHUotKSxBXfHJPe7kWiv8CqukYPGKWoiBQAgAC77dA=
Date:   Fri, 11 Jan 2019 00:34:57 +0000
Message-ID: <BN7PR12MB2836750BAFFAEAF8436C7C58C2850@BN7PR12MB2836.namprd12.prod.outlook.com>
References: <1546457808-18270-1-git-send-email-skomatineni@nvidia.com>
 <1546457808-18270-3-git-send-email-skomatineni@nvidia.com>
 <5722018a-7654-c6f9-c2aa-2817b39b1a35@intel.com>
In-Reply-To: <5722018a-7654-c6f9-c2aa-2817b39b1a35@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2658;6:61UPAuOZTR2URwyFs/IMcK79yJkiqjuZfxS5LFKYZtFXSNwwk5h3aczpTlkKmdBYzfoSWalC4U4OWugyGZtUrPoq7Czzf+H+j65AvlzIpp+r/+qpxXQ2E6WGJOI93g3qbgUfThUMLL4d4PaveQooRJT+a6MoqB+9xYqihiX4uLKSuLiEHAyVwOJsc3Rs2shOTBzwWIGwX505UTGtMuQCbj+yHO5XeyK9guV/qNc3oqluom2J9OAC9aUDevMGoHqXG2xkqhkJZdHiIrTD3pIzdwi284qrA+WmAYsNPpMXCoBOnHX+kDnkGy2K4u8b8dw+X0vpzMUN6eQU0N1g2/QZoJnU9+hlqlgTIkgbKKYBUOIPlnRpdhSKRhbEpmxM6khNPDzABXZlPLPfl2vK08Qw5Tj6VHCXl8hS8ZBzD6+T4nNaKrXutNDhdTALaHT7xCG3LSeobZvfhPbJ9sur0wzh6w==;5:w4kCEm6D3jRrfgdjmn+slK1q/lUkB5D8tS06uUDrWkMloR0haj1lCHM/HnTh8I88jYD/BNizu8C1OjSh3sM/IEFudcdEKLx5g4grvH4ejrwyjo3WJEGu9olytp8tpP2mAMcG0KO6CK/jVm6QMA+zSaktfvSD3ztYzw0BDegBLAB4KOIPvUKvHtU0neUtEOAZ2YYMvus1IStaqfO5MZFH5Q==;7:ja2LtuLW+MAP6OCNKYPcMoXPHETYSAocCb8SWOatRmHHAIDdRPgNvd1RmLmsYhXQ3NGkrnWF4spXN+oVRr2zdXc1qddTdWrLOyd2DMk8fJ/8c24C3KHxsjBP749UiMnU1ExW52c4Ru0E0wuuNUAfkw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(366004)(346002)(189003)(199004)(256004)(4744005)(229853002)(8676002)(11346002)(66066001)(446003)(6506007)(54906003)(33656002)(110136005)(316002)(478600001)(86362001)(486006)(25786009)(8936002)(6116002)(6436002)(55016002)(3846002)(7696005)(81156014)(81166006)(4326008)(476003)(9686003)(76176011)(71200400001)(71190400001)(14454004)(53936002)(68736007)(186003)(106356001)(99286004)(305945005)(26005)(105586002)(39060400002)(7736002)(2906002)(74316002)(2501003)(97736004)(5660300001)(102836004)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2658;H:BN7PR12MB2836.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: f9f42590-a643-439e-cf73-08d6775c9d2e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2658;
x-ms-traffictypediagnostic: BN7PR12MB2658:
x-microsoft-antispam-prvs: <BN7PR12MB2658D72509BF322C6A2F53C5C2850@BN7PR12MB2658.namprd12.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: osBcLpWnpVxTJopUT1fyqNqFIMOfcQIUBRxCqiQ7+UJEiJ9bdIcicZMehSb5fFfHk2GYtboySHkjWPwr9XjDV8N7XX79Qi6jbAPQVREnY4JNT//diRwg5wyDCQfNmQtIaoc0fVU4zFFvTKbe16Vr+5o2r0nu3Nt6iUyf1bsQsHAaQHxKTqApzL7p/IVyVil9kgcZ6rW1DGozlt+dtemJTo9HHIK7UcWv8QBDdrFdlJkO/hu0cgIseK+0bbwAvaxYnIwYqy9SKjD1ShQuzg/Fl0+SEie0hSVaxA1YkjEHgFuhn/75JwCdfGbXng/Haw2xHE6XPUecr3DQoZHEdCObxNUTcuspz534YnJA6AW4O8P0SLf5pzIasqFfkYMneW1W/DU80ILqhIMrj/RwG3KYNR3EvXSwpxB5VVXqMxkFZeI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f42590-a643-439e-cf73-08d6775c9d2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 00:34:57.5109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2658
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547166905; bh=7C7WH+0hAYrI/zp8dwLu3FBNHvlgtaE5nB7jLgrRN2k=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-exchange-antispam-srfa-diagnostics:
         x-forefront-antispam-report:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:received-spf:x-ms-exchange-senderadcheck:
         x-microsoft-antispam-message-info:spamdiagnosticoutput:
         spamdiagnosticmetadata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=hs5eUGuCWCf07Hc5/lxZH5CoFjSC8FMXn8v8LaJ57xzrBlXEVRJ8zEaQsK96BnN75
         G55HleCUY3zuXiXAXuK8JVKDGDtAFRj6UNPmOSTB07uhpyapvroGrmUnKrU/5hPBvF
         et54HXZOWr7ylh7Fe3BWFTJQdr/1HyYgmnuPXj5igLdfz2zV4DVK1uisMhxEPPGbEI
         q2FCb9qf74mOBeJv7QIoJ3TuhinbGAU9yTby0GogBF+KUMbuiOWmQRnsz5VMRwnBEM
         t2i/hLv0aHNN+tivrSpqmF0jwLUWp6znvQeZ0hPyvjx/iP0r7xx0i2HG+CjfFcXmPT
         1nGAmhCjqL0Dg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gK3N0YXRpYyBpbnQgc2RoY2lfdGVncmFfYWRkX2hvc3Qoc3RydWN0IHNkaGNpX2hvc3QgKmhv
c3QpIHsNCj4+ICsJc3RydWN0IHNkaGNpX3BsdGZtX2hvc3QgKnBsdGZtX2hvc3QgPSBzZGhjaV9w
cml2KGhvc3QpOw0KPj4gKwlzdHJ1Y3Qgc2RoY2lfdGVncmEgKnRlZ3JhX2hvc3QgPSBzZGhjaV9w
bHRmbV9wcml2KHBsdGZtX2hvc3QpOw0KPj4gKwlzdHJ1Y3QgY3FoY2lfaG9zdCAqY3FfaG9zdDsN
Cj4+ICsJYm9vbCBkbWE2NDsNCj4+ICsJaW50IHJldDsNCj4+ICsNCj4+ICsJaWYgKCF0ZWdyYV9o
b3N0LT5lbmFibGVfaHdjcSkNCj4+ICsJCXJldHVybiBzZGhjaV9hZGRfaG9zdChob3N0KTsNCj4+
ICsNCj4+ICsJaG9zdC0+djRfbW9kZSA9IHRydWU7DQo+DQo+Q2FuIHlvdSB1c2Ugc2RoY2lfZW5h
YmxlX3Y0X21vZGUoKSBoZXJlPw0KDQpIaSBBZHJpYW4sDQpzZGhjaV9yZWFkX2NhcHMgc2V0cyB2
NCBtb2RlIHRocnUgc2RoY2lfZG9fZW5hYmxlX3Y0X21vZGUgaWYgdjRfbW9kZSBpcyB0cnVlDQpz
ZGhjaV9zZXR1cF9ob3N0IGNhbGxzIHNkaGNpX3JlYWRfY2FwcyBzbyBJIHdhcyBzZXR0aW5nIHY0
X21vZGUgdG8gdHJ1ZSBzbyB2NCBtb2RlIGdldHMgZW5hYmxlZCBkdXJpbmcgcmVhZCBjYXBzLg0K
DQpUaGFua3MNCnNvd2phbnlhDQoNCg==
