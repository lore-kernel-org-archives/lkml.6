Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CEDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D2B21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="T4cku3fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D2B21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbeKUWkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:40:15 -0500
Received: from mail-eopbgr50065.outbound.protection.outlook.com ([40.107.5.65]:26176
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727069AbeKUWkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDI+TE3uoArN257qBdo8XH1HRuwZOVn43uDONJJOd/g=;
 b=T4cku3fztcc4OLcyeHzIRaZGMvvpZ8euGTe35h0r/2rbWQ3rDhLMWGGtNvlMRi1qNM9+4gZwUzyDdRqRF9YJv7GTKrA6/nyi2HyjzLjkZrzepeoonPzFnkvwDEYoTeeGWqdAijUrPMkB5+O2zr5Z8lWd9ZUrPaneKuG2V6zBZLU=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2142.eurprd08.prod.outlook.com (10.172.12.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Wed, 21 Nov 2018 12:06:02 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%9]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 12:06:02 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        Sonny Rao <sonnyrao@google.com>
Subject: [PATCH 0/6] lib/lzo: performance improvements
Thread-Topic: [PATCH 0/6] lib/lzo: performance improvements
Thread-Index: AQHUgZI88EDtuaHmFU63dmJG+DkKOw==
Date:   Wed, 21 Nov 2018 12:06:02 +0000
Message-ID: <VI1PR0802MB25289788BFADB136CE08AADA8FDA0@VI1PR0802MB2528.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2142;6:JHb9DIFMSOxSWPeX4bImgxLHtV1g6h4XiIKX+EJRafbRHQkR9psmI/XCBJGzVK9PdJPdnk4afUH2Ip2DR2HztyWuOImvMLS9FCzTXeGerw1hwgE+Zy8pOpeGcrDs/VWhVg1TvGmRdKettI45uE0DdLrZsg9sTvAd0M060GiiuDRkIqkrK9zK6Rtt3YMM6jLcnO6Fov9nFdx7vFFqSz66zC6GrdXnHiWbSsCMi3H8xhA+MLdyP1KN75I7IAvgHv0AJGHelJ3InjFuuDnUV8QNDcs/e1l+bidqm0VfPVkPicxPtVKJ3JYDO+7U0WgZABAzGfDc+rO3LuIzXXwmPtn/NSk1vNttGwW3jG7EEu5E5LPvm/JdISbLRFMAR0HLGAwLWF3RtuxGM2iHM2NuUoRZEUyxw57mW0wSjqq3TozZI7uH5BY2uiwi5NFceYMG7I/rM+P2ZyE6oW2UbbTi5uZmhg==;5:GS4RxUCmhk6OUAixGVwifvj5Ij9fyqdRN55CmgswG5XIIfR+lV69c4Wi5tDUc8bWBkisqRAhMZFARZfB7Mum0A0CRXqO6bxwFXGC0xJ8y7u4C0QLP7bc5FMQU71qSjjl+JFuluqzSvhEh+TV5BHwbvx/oE4WisrEQUJXSE+vcHw=;7:pihB+y+FEMLUxF9DkOQQg/ac4RTRwbnRonZkvwXjymGWpDhO6j+lqxgJSBUIsF1tUwFiInblCokj5nYlGypT1Qwu+9R6T1t+naKhYgXVFl9QRePxHduwYpNeOjV9uW+ple2vms/fc8Wp36056jbmvg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 1e5f8151-fb79-49fd-15a7-08d64fa9b540
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2142;
x-ms-traffictypediagnostic: VI1PR0802MB2142:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2142E7FF7B6834D360CD74A28FDA0@VI1PR0802MB2142.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2142;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2142;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(376002)(39860400002)(189003)(199004)(81166006)(2900100001)(14454004)(6116002)(3846002)(39060400002)(5640700003)(86362001)(97736004)(4326008)(2906002)(9686003)(6306002)(55016002)(53936002)(54906003)(7696005)(68736007)(316002)(26005)(6506007)(2351001)(81156014)(99286004)(476003)(102836004)(186003)(486006)(105586002)(5660300001)(966005)(106356001)(478600001)(44832011)(6916009)(74316002)(71200400001)(71190400001)(66066001)(14444005)(8936002)(25786009)(7736002)(2501003)(305945005)(33656002)(8676002)(256004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2142;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FkjE/+ZIm4lY2zyU/QWDVGKpqqckJ0wocDwW1C8s6qu2Cq2o4WhY/vX4bT6kbBhpNvnA5Oi4SUlft9pPONwa+vnvMGnlt0o3WyWshQtZyXXJa/8hW5aMPSGFSN8vXaDAhsWigBDAp+vK2YyRnagrl5ijuPHQMMOptrOsWO1F5HWJxqwGOuKI8wYSH8pMroF2ONhtWPHo8ZLrTOpuIEt+dISCZ0Uc7DvhDAavjU/5cXIHCxFafvtIx/5d2IPUT2CAyc+TBQPYW5L17JxO6dQtmbA8v//29/AUPbNC1kIsGk85elmsHGDtaiIYvIrQzaaRokkJ08UYS24YtIERJpW/6ErNO3HmgDT5vg6xahWJXbE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5f8151-fb79-49fd-15a7-08d64fa9b540
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 12:06:02.7197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces performance improvements for lzo.

The improvements fall into two categories: general Arm-specific optimisatio=
ns
(e.g., more efficient memory access); and the introduction of a special cas=
e=A0
for handling runs of zeros (which is a common case for zram) using run-leng=
th
encoding.

The introduction of RLE modifies the bitstream such that it can't be decode=
d
by old versions of lzo (the new lzo-rle can correctly decode old bitstreams=
).
To avoid possible issues where data is persisted on disk (e.g., squashfs), =
the=A0
final patch in this series separates lzo-rle into a separate algorithm
alongside lzo, so that the new lzo-rle is (by default) only used for zram a=
nd
must be explicitly selected for other use-cases. This final patch could be
omitted if the consensus is that we'd rather avoid proliferation of lzo
variants.

Overall, performance is improved by around 1.1 - 4.8x (data-dependent: data
with many zero runs shows higher improvement). Under real-world testing wit=
h
zram, time spent in (de)compression during swapping is reduced by around 27=
%.
The graph below shows the weighted round-trip throughput of lzo, lz4 and
lzo-rle, for randomly generated 4k chunks of data with varying levels of
entropy. (To calculate weighted round-trip throughput, compression performa=
nce
is emphasised to reflect the fact that zram does around 2.25x more compress=
ion
than decompression. (Results and overall trends are fairly similar for
unweighted).

https://drive.google.com/file/d/18GU4pgRVCLNN7wXxynz-8R2ygrY2IdyE/view

Contributors:
Dave Rodgman <dave.rodgman@arm.com>
Matt Sealey <matt.sealey@arm.com>=
