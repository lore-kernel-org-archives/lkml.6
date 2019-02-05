Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D624CC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882932080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Z5OXadfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfBEQAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:00:04 -0500
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:13897
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729547AbfBEQAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Be8i0dtdwI4qWrmH4Uie171wZTSNKQzPbDiI7Z0Sdg=;
 b=Z5OXadfqvXMZHeOhTkl71FLlTyqv7Wf35cu9XWhdBibfWaqqbZ7UWkVNJU2O16LgoIy10fcGSGLnwvFgT0p+AtMSzzDiCZFCyNTMMaqZIyIO2CtIYssaf94y3HkaoN6S0Pd/TWuLAHbwxGtP4i+MwbuyhpX0EGH0l0U/XfNeIZk=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2191.eurprd08.prod.outlook.com (10.172.12.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 5 Feb 2019 15:59:59 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::7446:fa53:3f15:c96c]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::7446:fa53:3f15:c96c%4]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 15:59:59 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matt Sealey <Matt.Sealey@arm.com>,
        Dave Rodgman <dave.rodgman@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
CC:     nd <nd@arm.com>
Subject: [PATCH v5 0/3]: lib/lzo: run-length encoding support 
Thread-Topic: [PATCH v5 0/3]: lib/lzo: run-length encoding support 
Thread-Index: AQHUvWvYxz+JzwKhRUekq1hW7YGD2A==
Date:   Tue, 5 Feb 2019 15:59:59 +0000
Message-ID: <20190205155944.16007-1-dave.rodgman@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [217.140.106.52]
x-clientproxiedby: CWXP265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2e::23) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2191;6:Prz1zNenaBRyXoJAxwd5OTRI/9b4w7kRVNCikhQlwRB2hCV4asl9qGCfqjKN+4vigMlKBqyC5zO9TjbKrXOz3InKvj7Z97q/lBiZF/Ohi7qCHAXfhEDLjU/YOqOdEvMPb9qTj8WZo3mPkjVQ75DLmMk4abrHORrCIo3XZV1ZGd87VTotPMw6BkJxy8TCAiSnXZrkhRh7crT3Qqnk9iqqHg3al4Zh2FV3IA3PQb9GYlOnxWHkQbDavTyOlSlCW90DBz1Dh7zcZ5dK2bwZd2vZ0ok5qGT8jazmRH53CfGpoK3aaFIsPPnpGGrmd9/ugT5iIJzuT6AnHZR01ZRB36NUMwJI8uatABeWSTbzawDRc9V0zNU4UHdJcnuXEGNYPbS4FllTMhZzfqGvnUS/fToiP6KH7WgcrbieU73U6BTumtLNFBFtHx9ellxgegx2qPNkbXRxxdCoRSfKFzWlRebp8g==;5:AzcDC078aivw6msKJJAAvkZKsZjfC98ljw8dIQzSa0C39fXXuLLfGA693fmJGCAQ0PgZIXpOQ+RK/7X59/TFCCbkoUYJOY4DmNfF8WU4vt0uLMX5gWClpST+0IqVuAlL4d7+fSwFK6T9uP9hNfDnzexKXo5LcLFX5N390ZNa51NZamcVZZga+3TMyy74lruPGQtPspfS0qRUnLFQUIPiSw==;7:brUIQV2OPKJC7BQ0S6YtwQTgHv1AKxQMOn4vInXQAlebWlZDSkT3ROPTR8Cy5S8B5KWLfPZzFbnVjwSOEUmuNHRADCQ9HFEyT9rlXBL9P0GweQhE5faoi1a2SiicIKio+C0v64/EoIhrKQKJZ3othw==
x-ms-office365-filtering-correlation-id: a81ab432-baac-4923-f9ad-08d68b82fae4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2191;
x-ms-traffictypediagnostic: VI1PR0802MB2191:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB21917EE86AF3E97C3926B0268F6E0@VI1PR0802MB2191.eurprd08.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(99286004)(110136005)(2501003)(305945005)(4326008)(26005)(4743002)(186003)(6486002)(6506007)(106356001)(36756003)(386003)(68736007)(2906002)(8676002)(52116002)(105586002)(8936002)(81166006)(81156014)(50226002)(486006)(66066001)(53936002)(3846002)(6116002)(1076003)(7416002)(25786009)(256004)(97736004)(102836004)(478600001)(44832011)(966005)(2616005)(316002)(6306002)(476003)(71190400001)(71200400001)(6436002)(2201001)(14454004)(86362001)(6512007)(7736002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2191;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2BxG270TOIv7nIM/8qXURhqTfrTaSf+28m0iofHLilQrDQYsSeXdiimWD6l3652Hq99AWiH067pnmu/ohXFCsdjsAGSpM7RJpOdrY9GfkXoqINhrSAiSH121henzyCEVyFFAXaiqMNrPQ19MC9tDv5rydeg5e7boCivrlPDSOSarAqiC/pw8PkWZeYfeW2JpMFjGgCe+ZLWO2JAP6Lt8o6ve1FGskassjihdG9OeYAqil4qza79A/TXF75EB/jPUGbyNtpsdLm6Ufw+5GFwzenej+JwL8amvZOiuV3FjjkCRSNCZM3fhFUK2P0mFo7D4TXFB/U/aMxWq/ampKF2hFUaOUH2pz3sREKIwz6tlTN6Axx5sh9t/ugPi7PDpDT31JeBvzh+UO2C75TGAPRCcyccHgaVLXw/mTb1sF9NY8G0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81ab432-baac-4923-f9ad-08d68b82fae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 15:59:58.5128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Following on from the previous lzo-rle patchset:

https://lkml.org/lkml/2018/11/30/972

This patchset contains only the RLE patches, and should be applied on top o=
f
the non-RLE patches ( https://lkml.org/lkml/2019/2/5/366 ).


Previously, some questions were raised around the RLE patches. I've done so=
me
additional benchmarking to answer these questions. In short:

 - RLE offers significant additional performance (data-dependent)
 - I didn't measure any regressions that were clearly outside the noise


One concern with this patchset was around performance - specifically, measu=
ring
RLE impact separately from Matt Sealey's patches (CTZ & fast copy). I have =
done
some additional benchmarking which I hope clarifies the benefits of each pa=
rt
of the patchset.

Firstly, I've captured some memory via /dev/fmem from a Chromebook with man=
y
tabs open which is starting to swap, and then split this into 4178 4k pages=
.
I've excluded the all-zero pages (as zram does), and also the no-zero pages
(which won't tell us anything about RLE performance). This should give a
realistic test dataset for zram. What I found was that the data is VERY
bimodal: 44% of pages in this dataset contain 5% or fewer zeros, and 44%
contain over 90% zeros (30% if you include the no-zero pages). This support=
s
the idea of special-casing zeros in zram.

Next, I've benchmarked four variants of lzo on these pages (on 64-bit Arm a=
t
max frequency): baseline LZO; baseline + Matt Sealey's patches (aka MS);
baseline + RLE only; baseline + MS + RLE. Numbers are for weighted roundtri=
p
throughput (the weighting reflects that zram does more compression than
decompression).

https://drive.google.com/file/d/1VLtLjRVxgUNuWFOxaGPwJYhl_hMQXpHe/view?usp=
=3Dsharing

Matt's patches help in all cases for Arm (and no effect on Intel), as expec=
ted.

RLE also behaves as expected: with few zeros present, it makes no differenc=
e;
above ~75%, it gives a good improvement (50 - 300 MB/s on top of the benefi=
t
from Matt's patches).

Best performance is seen with both MS and RLE patches.

Finally, I have benchmarked the same dataset on an x86-64 device. Here, the
MS patches make no difference (as expected); RLE helps, similarly as on Arm=
.
There were no definite regressions; allowing for observational error, 0.1%
(3/4178) of cases had a regression > 1 standard deviation, of which the lar=
gest
was 4.6% (1.2 standard deviations). I think this is probably within the noi=
se.

https://drive.google.com/file/d/1xCUVwmiGD0heEMx5gcVEmLBI4eLaageV/view?usp=
=3Dsharing

One point to note is that the graphs show RLE appears to help very slightly
with no zeros present! This is because the extra code causes the clang
optimiser to change code layout in a way that happens to have a significant
benefit. Taking baseline LZO and adding a do-nothing line like
"__builtin_prefetch(out_len);" immediately before the "goto next" has the s=
ame
effect. So this is a real, but basically spurious effect - it's small enoug=
h
not to upset the overall findings.

Dave


