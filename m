Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29F3C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A22620837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="fgFs7Zvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A22620837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeLGPyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:54:14 -0500
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:41616
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbeLGPyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4jdwgWZVDhZC5HbX1t7LX5xdvvac05idCXpUNrfpTE=;
 b=fgFs7ZvlYSZKOLZhxd4kige9htXmY45UYUjnMUdBYsa0BSrzrmYbnIYosaTpF+E6KPa6TGSuBTFnZt0Bai/P0uWnZ9l6KgwrvL+cgJuVb0sES7NIDQqwf1NfqjA8kcepWvG8s97bt4/JIHAmy2zyUF3bsibzNkytuWL1UepCqAY=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2176.eurprd08.prod.outlook.com (10.172.12.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Fri, 7 Dec 2018 15:54:07 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 15:54:07 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        nd <nd@arm.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: Re: [PATCH v4 0/7] lib/lzo: performance improvements
Thread-Topic: [PATCH v4 0/7] lib/lzo: performance improvements
Thread-Index: AQHUiLiqITo/LLyl1EWjCUTAJp49+6Vx5IUAgAGUMoA=
Date:   Fri, 7 Dec 2018 15:54:07 +0000
Message-ID: <fba24452-ae3a-0caa-11b4-aea69abf2fff@arm.com>
References: <20181130142600.13782-1-dave.rodgman@arm.com>
 <5C09448C.8010506@oberhumer.com>
In-Reply-To: <5C09448C.8010506@oberhumer.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0069.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::33) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2176;6:cn0EsE9j1C1kcfvdAArozLqCYU4GzaFCrpQun48sZGdQ76TsJ7LUM+ZIo+xwd0GIBk3AaRIFuY01QMG2gdpDKVT+aOGKuBIgwS49STx/00TNNkVgFYlMRjUKxvP6TWKeUDyy1CcGIrIEwF9Kaq49CDuh+6aLWkd9wt9mvVUCoaagl9O1+EyYZ0v6BETk8+dYAoh0SSOCJMqA06BPnOYdpeOKqga89S6O8K2n6Wfn1LJh0DBYOD7GuuytiPnCVZCsXQGiRaxG/1ijU1drLUGjhzwkBmvg+deCzhOwg22/bnf8SWeGKViuwSRuCwIsIOgrSrGBnuUsObyuzVK1aTQAK8pfNGcd7huOoYgE6Al0xaJrFY4g97GWY6DmSeYhwKVOYpFGKlu4aEK85lxZru7EQ9HFbK1L/w8XZ3soUz97wWEPYioZWNArIJxLBdlH5KnjQ0CXXZe2cKkeI+043b9OxQ==;5:x9UyPYZRy9IqHY1YhYwCgJuVURW9KfTGqhgt8ymB1vx/TyrvDxTuNF1lHPPuKYdgrouQpSZfjip1P4KCZ3osbHf4tWM7mHyjPttz+63/UDTniJazUOfZWAuT091rf6vDygzQOakEnR9FN1p3dlDznUUG1iPb3KR4el5IzRedY1g=;7:lW5CbnXzk0r8UCXlAHVaVNdLA7u1+XQU5WMPrISow3X0h95fnL2W2lzdF6aeY+E3AoXGagX6Fbe10xXesoIkjfuK4G1bumN4hwuChh0Az6FmGIF1EHVvTUM77s72y74+xw4ZhqGpq9P9HhMdAo0RHA==
x-ms-office365-filtering-correlation-id: c5d1aec3-f2d1-46a9-94da-08d65c5c3874
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2176;
x-ms-traffictypediagnostic: VI1PR0802MB2176:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB217687D23576FC3C0DB5A0918FAA0@VI1PR0802MB2176.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2176;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2176;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(105586002)(5660300001)(81156014)(25786009)(8676002)(4326008)(6116002)(2201001)(102836004)(3846002)(6436002)(66066001)(36756003)(14454004)(14444005)(6506007)(256004)(11346002)(86362001)(186003)(68736007)(305945005)(2616005)(44832011)(26005)(7736002)(31696002)(81166006)(2906002)(478600001)(386003)(476003)(8936002)(486006)(71190400001)(71200400001)(54906003)(31686004)(53936002)(446003)(110136005)(6512007)(7416002)(316002)(76176011)(229853002)(97736004)(2501003)(6246003)(99286004)(52116002)(6486002)(39060400002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2176;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wq39JdLG0pfa7we7YGi0GkoBkZa5kK+LYuIDXNkwBAfjtr4Z4QR7xZTUr0wXFiSvXjwT22p6gn/zSKZBVCp0DOwDjDVcUcRP9jh8IQGkU6y3rUDTbW2m/FkrVt2zg4skjThaslj7hF6phyQkr7FD9eeak3s7+9ooSUlzVGbNYvzvdfsE5JhvP0EOVCu8HRC4WYJYkrpDqhPW5cUeXOmIZayQUDwWg40Qt64WAb9GBiuwh6OMU092pu80VPOn6EfpPMTZjilauK2ZuGwEFucRKCrLX9t39uOD+d0FDRpK0Kb+UaD7fAvi+J4UWHypGeFWH5hCnrRj8mKgpkdmqSSsER+qGIS+dTDBDW6ocvkvThs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <1FBFEF6377719E42BBDC3EC64059424D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d1aec3-f2d1-46a9-94da-08d65c5c3874
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 15:54:07.5726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

On 06/12/2018 3:47 pm, Markus F.X.J. Oberhumer wrote:> Request 3 - add lzo-=
rle; *NOT* acked by me
 >
 >     [PATCH 6/8] lib/lzo: implement run-length encoding
 >     [PATCH 7/8] lib/lzo: separate lzo-rle from lzo
 >     [PATCH 8/8] zram: default to lzo-rle instead of lzo
 >
 > It (1) silently changes the compressed data format

I'm not sure this is relevant: as a separate algorithm, there's no reason
to retain the same format (although backwards compatibility can help with
migration). If you know of a way to improve the compatibility aspect
though, that would be great!

 > (2) crashes on MIPS,

Please could you provide more detail? I tested on x86-32, x86-64, arm,
arm64 and big-endian MIPS64, but if there is an issue I missed I'd like to
address it.

 > and (3) makes compression and decompression on typical data 10% slower o=
n
 > X86_64 with our internal benchmarks,

It is of course data-dependent. In my testing, as I mentioned previously, R=
LE
without the other patches does regress slightly on high-entropy data, but
offers a win on low-entropy data. For the right applications (e.g., zram),
this makes it overall beneficial.

 > and (4) has to be carefully checked for buffer overflows.

This has been reviewed prior to sharing on LKML, and of course tested,
but further review is of course welcome.

 > As a final comment, I question the quality your benchmarks - combining
 > arch-related ARM64 improvements and algorithmic changes into one
 > benchmark comparision is just unprofessional marketing.

I felt it was helpful to show overall performance with the complete patchse=
t:
this is what end-users experience. However, as you can see below, I also
previously shared a summary of the two main components of the patchset to
try and address this sort of concern:

 >> As a quick summary of the impact of these patches on bigger chunks of
 >> data, I've compared the performance of four different variants of lzo
 >> on two large (~40 MB) files. The numbers show round-trip throughput
 >> in MB/s:
 >>
 >> Variant         | Low-entropy | High-entropy
 >> Current lzo     |  242        | 157
 >> Arm opts        |  290        | 159
 >> RLE             |  876        | 151
 >> Arm opts + RLE  | 1150        | 181

cheers

Dave
