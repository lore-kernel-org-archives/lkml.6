Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB913C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AD520864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dhOMt3vM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AD520864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeLCVUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:20:39 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:57548 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeLCVUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:20:39 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c059e200000>; Tue, 04 Dec 2018 05:20:32 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 03 Dec 2018 13:20:31 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 03 Dec 2018 13:20:31 -0800
Received: from DRBGMAIL103.nvidia.com (10.18.16.22) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 3 Dec
 2018 21:20:30 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by DRBGMAIL103.nvidia.com
 (10.18.16.22) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 3 Dec
 2018 21:20:29 +0000
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.59) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Mon, 3 Dec 2018 21:20:29 +0000
Received: from BYAPR12MB2712.namprd12.prod.outlook.com (20.177.124.13) by
 BYAPR12MB2757.namprd12.prod.outlook.com (20.177.125.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.21; Mon, 3 Dec 2018 21:20:27 +0000
Received: from BYAPR12MB2712.namprd12.prod.outlook.com
 ([fe80::2c34:273b:59ad:23d6]) by BYAPR12MB2712.namprd12.prod.outlook.com
 ([fe80::2c34:273b:59ad:23d6%2]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 21:20:25 +0000
From:   Alexander Van Brunt <avanbrunt@nvidia.com>
To:     Will Deacon <will.deacon@arm.com>,
        Ashish Mhetre <amhetre@nvidia.com>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Sachin Nikam <Snikam@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V3] arm64: Don't flush tlb while clearing the accessed bit
Thread-Topic: [PATCH V3] arm64: Don't flush tlb while clearing the accessed
 bit
Thread-Index: AQHUb2mK2jioXCSBXUOglXMUWPpsLKU2DOwAgABGE2iAN2VlVA==
Date:   Mon, 3 Dec 2018 21:20:25 +0000
Message-ID: <BYAPR12MB27129A4EE7BBF57B1CAB5094CFAE0@BYAPR12MB2712.namprd12.prod.outlook.com>
References: <1540805158-618-1-git-send-email-amhetre@nvidia.com>,
 <20181029105515.GD14127@arm.com>,<BN7PR12MB2708B742FD3448589AD0F259CFF30@BN7PR12MB2708.namprd12.prod.outlook.com>
In-Reply-To: <BN7PR12MB2708B742FD3448589AD0F259CFF30@BN7PR12MB2708.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=avanbrunt@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2757;6:C4XjNaICWHojDRl0DdlYmljGMtaZYaz7gg3Bs0G48oK8pZtvnGwiIPJMhuQdVVBedfmFNNkNnnZAi2BQLtc3vHjhxxchOmAYoRT8UdF04WQHflWQtR6wZ1fcNxx2cvmTJCxTFUmjGyfgEiLuHuQDR3UEvTPBpNmY5+P53HcYzIQKdIMUhKVzj454+plqtlryW+ZEhrf4Qch9FQAuK26jAokU0/k62gQEkC44DqA3YrdE+SRn6KV2iJIw/sIcaesP43iIGcaq5fLu8+2GDdCHfVpdh9YwFfjoM3mjo2Ky0Lfxb9SM6Ea8riOAhnznHiERfT4gBWKu+ccdMS5+5hgpX+9AD2lbA71w/G1GjL+Y/12pK/94isEoM4hs+aahYUg+sDb/BRDT1K26tB/bumXTmBijCEgKyUdHzR3lHHKtbvJ8jE0BBUIXZ0PPwAH5RXdHmCrLM87yUw/eC6+s82Ja0g==;5:pUXxaMT/JQUqkKnoMP8v7w8/1wEuYwI6Gyb5stXQau6T/xWV3Q0/2QXyKH8wtVEtIydMaSYkFRYbpMCjlooE3Y52iKUCMJGHMAJ0GwAztdlE2QC98t9yZnwKZS6m68LmCp2c5VN6qEWpiRvze3IscV4NOfhgCo2GCYMdkFWVrLo=;7:JXjCq3OqtejlO+Z/Y4I3ufxuu0bZcIbaazJbRSyUF7+XA8r7VExC4qphf7aPOKmjEYJZLBiDtlvyg2p+jAWuPMFBFiIprn92jrQcXcChJYVaQGNujD3DR4/AB2JPk+sK65VNbj3zINOpzttTnpP0AA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(366004)(51444003)(199004)(189003)(446003)(33656002)(105586002)(106356001)(486006)(54906003)(110136005)(71190400001)(316002)(9686003)(14454004)(4326008)(71200400001)(256004)(53936002)(7696005)(55016002)(6246003)(14444005)(76176011)(305945005)(74316002)(7736002)(229853002)(5660300001)(99286004)(6636002)(97736004)(81166006)(2906002)(66066001)(6436002)(81156014)(6506007)(8676002)(26005)(8936002)(102836004)(6116002)(3846002)(186003)(86362001)(68736007)(11346002)(476003)(561944003)(25786009)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2757;H:BYAPR12MB2712.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 1ce7ac2c-f9b2-43c2-c383-08d65965248c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2757;
x-ms-traffictypediagnostic: BYAPR12MB2757:
x-microsoft-antispam-prvs: <BYAPR12MB275796C274D94BEDD5963E5ECFAE0@BYAPR12MB2757.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR12MB2757;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2757;
x-forefront-prvs: 08756AC3C8
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HHkr2J7cbRWRydHa6BXPVsfO1BOn69lIWsQR4nr1HuMsDicO34ifLPwv+iSoX77MxczQn4naWKyudFBEisxV8SjUooAARHcLX21INh0dJnq0IdfzraA883AjZNISlOpESIjEBwWQiLnUy6D1vKt1e+7fRiI3j1X/7T2Wex5aof/7oyLWVOex6SvVQdykaXBqhAa00Rf4hrbLiXqb7ql81GhYks1WYjM4i6PX3qvDxRn+8Kox0CoV1iYHCSs+YuoPa2NSQbAsioCUJ45UO3ZTizYN4QrB9UxbFFspGvPQP3It+gV+pjyWxiRceU2DhZawEwkkZ0j3aYIuX4+LXvQ/8K9AEW0sHUSxGzUJwg+Sb54=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce7ac2c-f9b2-43c2-c383-08d65965248c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 21:20:25.8340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2757
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543872032; bh=8XVcrZ74cbcr8QY/3gqpN1SGufEF0gSNm7VPKxBZkC0=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
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
        b=dhOMt3vMXE1Ssz4Rs0nJvNmuPF0Zjn55VjLD6tWQq3GYtJjWzu0hgJBje3JTqfG6i
         f9/OPOXVjtLS0o1GlG+HhmV8xtXUtkVNFf0PWZq782XHL99dgOJPpNid78D7r47qfA
         +oJnjSxwPRCL8AOp5g/iwLb94oarWLh+ILOvPp7Fu8Ib8bfuKbntsywfQf1G24Z/91
         YuIeWUHFjvaNrL1aVnf2cZ/5WRbn58dJQV7BcyhwFMZbAC1/X6rLeFx2mwCaHQhr2n
         CJ8lgJl9vg8VWrUQgTZW7iEQhoW1L9yTRNuRK05AJGyVGDQGK1ZsPyRnyN7W2S1KaW
         5OCxILuE07yNw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=A0If we roll a TLB invalidation routine without the trailing DSB, what so=
rt of
>=A0performance does that get you?

It is not as good. In some cases, it is really bad. Skipping the invalidate=
 was
the most consistent and fast implementation.

Methodology:

We ran 6 tests on Jetson Xavier with three different implementations of
ptep_clear_flush_young: the existing version that does a TLB invalidate and=
 a
DSB, our proposal to skip the TLB invalidate, and Will's suggestion to just=
 skip
the DSB. The 6 tests are read and write versions of sequential access, rand=
om
access, and alternating between a fixed page and a random page. We ran each=
 of
the (6 tests) * (3 configs) 31 times and measured the execution time.

The Jetson Xavier platform has 8 Carmel CPUs, 16 GB of DRAM, and an NVMe ha=
rd
drive. Carmel CPUs have a unique feature where they batch up TLB invalidate=
s
until either the very large buffer overflows or it executes a DSB.

Below we report statistically significant (p < .01) differences in the mean
execution time or the variation in execution time. There are 36 comparisons
tested. Because of that, there is a 50% chance that at least one of the 36
comparisons would have a p <=3D 1 / 36. p =3D .01 should make false positiv=
es
unlikely.

Sequential Reads:

Executing a TLB invalidate but skipping the DSB had 3.5x more variation tha=
n an
invalidate and a DSB and it had 12.3x more run-to-run variation than skippi=
ng
the TLB invalidate and the DSB. The run-to-run variation when skipping the =
DSB
was 38% of the execution time. This is likely because Carmel's feature of
batching up TLB invalidates until it executes a DSB and the need to wait fo=
r
the other 7 cores to compete the invalidate.

Skipping the TLB invalidate was 8% faster than executing an invalidate and =
a
DSB. It also had 3.5x less run-to-run variation. Because the run-to-run
variation with the implementation that executed a TLB invalidate but not a =
DSB
was so much higher, its execution time could not be estimated with enough
precision to say that it is statistically different from the other two
implementations.

Random Reads:

Executing a TLB invalidate but not a DSB was the faster and had less run-to=
-run
variation than either of the other implementations. It is 8% faster and has=
 ~3x
lower run-to-run variation than either alternative. The run-to-run variatio=
n
when skipping the DSB was 1.5% of the overall execution time.

Skipping the TLB invalidate was not statistically different from the existi=
ng
implementation that does a TLB invalidate and a DSB.

Alternating Random and Hot Page Reads:

In this test, executing a TLB invalidate but not a DSB was the fastest. It =
was
12% faster than an invalidate and a DSB. It was 9% faster than executing no
invalidate. Similarly, skipping the invalidate was 4% faster than executing=
 an
invalidate and a DSB (9% + 4% !=3D 12% because of rounding).

The run-to-run variation was the lowest when executing an invalidate and a =
DSB.
Its variation was 1% of the time.  That is 64% of variation when skipping t=
he
DSB and 22% of executing no TLB invalidate (5% of the execution time).

This test was meant to test the effects of a TLB not being updated with the
newly young PTE in memory. By never executing a TLB invalidate, then the ke=
rnel
almost never gets a chance to take a page fault because the access flag is
clear. By executing an invalidate but not executing a DSB probably results =
in
the TLB usually updated with the PTE value before the page falls off the LR=
U
list. So, it makes sense that skipping the DSB is the fastest. The cases wh=
ere
the hot page erroneously evicted are likely the reason why the variation
increases with looser TLB invalidate implementations.

Sequential Writes:

There were no statistically significant results in this test. That is likel=
y
because IO was limiting the write speed. Also, the write tests had much mor=
e run
-to-run variation (about 10% of the execution time) than the read tests.

For openness, the existing implementation that executes an invalidate and D=
SB
was faster by 8% but didn't quite meet the requirements to be statistically
significant. Its p-value was .014. Since it less than 1 / 36 =3D .028, it i=
s
unlikely to be coincidental. But, every other result reported has a p < .00=
4.

Random Writes:

Skipping the invalidate was the fastest. It was 51% faster than executing a=
n
invalidate and a DSB. It was 38% faster than executing an invalidate but no=
t a
DSB. The run-to-run variations were not statistically different.

Alternating Random and Hot Page Writes:

Similar to random writes, skipping the invalidate was the fastest. It was 4=
6%
faster than executing an invalidate and a DSB and 45% faster than executing=
 an
invalidate without a DSB. The run-to-run variations were not statistically
different.

Conclusion:

There were no statistically significant results where executing a TLB inval=
idate
and a DSB was fastest. Except for the sequential write case where there wer=
e no
significant results, it was slower by 8-50% than the alternatives.

Executing a TLB invalidate but not a DSB was faster than not executing a TL=
B
invalidate in the two random read cases by about 8%. However, skipping the
invalidate was faster in the random write tests by about 40%.

The existing implementation that executes an invalidate and a DSB had 3-4x =
less
run-to-run variation than the alternatives in the one hot page read test. T=
hat
is the strongest reason to continue fully invalidating TLBs. However, at wo=
rst
it had a 5% execution time. I think that going from 1% to 5% on this test i=
s
more than made up for by reducing the variation in the sequential read test=
 from
12% to 4% by skipping the invalidates altogether.

Because these are microbenchmarks that represent small parts of real
applications, I think that we should use the worst case run-to-run variatio=
n to
choose the implementation that has the least variation. Using that metric,
skipping the invalidate has a worst case of 5% (random read), skipping just=
 the
DSB has a worst case of 38% (sequential read), and executing an invalidate =
and a
DSB has a worst case of 12% (sequential read).

