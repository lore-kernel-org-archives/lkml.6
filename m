Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26385C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9360025B92
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="XZL4OWlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9360025B92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754399AbeGBIrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:47:00 -0400
Received: from mail-by2nam03on0076.outbound.protection.outlook.com ([104.47.42.76]:39230
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753228AbeGBIqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHKIw7geId/xc0SQLCpGM+ZXeTV/1EPLh8YhjHjnMIk=;
 b=XZL4OWlYsed8FnSZjy6yTIb1b56b/i2Vve0Dwr39qi0EKGu+VOcKlxy0ZZCXqFA5nVzYwMktwuIVZHGnujTTh4yLonuvhXaPzVcOGyEO1qJmFN7nzwG+gy4b64n/k9IUxQ4dcMMWYhxkBs7A7Lz22JmIi6ST3S1sKTI4o+DpZIo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
Received: from localhost (195.244.36.61) by
 SN6PR07MB4381.namprd07.prod.outlook.com (2603:10b6:805:58::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Mon, 2 Jul 2018 08:46:47 +0000
Date:   Mon, 2 Jul 2018 11:46:22 +0300
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     libc-alpha@sourceware.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] Add renameat2 function [BZ #17662]
Message-ID: <20180702084622.GA15274@yury-thinkpad>
References: <20180630121447.E4C8643994575@oldenburg.str.redhat.com>
 <20180701214901.GA32498@yury-thinkpad>
 <60505ccf-a399-6320-74f5-e2e17965d25c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60505ccf-a399-6320-74f5-e2e17965d25c@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [195.244.36.61]
X-ClientProxiedBy: HE1PR0301CA0004.eurprd03.prod.outlook.com
 (2603:10a6:3:76::14) To SN6PR07MB4381.namprd07.prod.outlook.com
 (2603:10b6:805:58::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09558315-f2a5-4415-6296-08d5dff859dc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4381;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4381;3:7e/IRyqb8voerqs0r9uKlVPohwDwqGouIgNony4NDY1gRozFd2kRPNfsr08NwLUpeXCy4jfRWsYbJljnKwtuWgwmg626/8+5a5ym/wQmjCEzMOpxTLd9Oa4YWehdfkuD7yvU0qwmeRu4XmCNnSwIUElY0D2AS9l8zvYKTAzUinSjZ8B2vOBjyMU/PKD7rfkYzUjWJZ+4LH/9Xor562kfdO0gGvuhVWYtuM3yBBfyIOkG6VkGie1jyKIyr2w/fgu5;25:Y2KNYif/sOTgTiD4Eck+6D4Zk3jn3TTJLrGLtP9R6Dowy9pLyLzIh9jYucD7e23h0WxJy+dD/McQtMh3kgNl7aZnOUTDbNfNBrnz+KP2R6dHCdNaRCri3O9MApfJ0AOlERZ2vC0Iaj5Oz7uf1Rnuna2qckz9AKGIksXtOgdzOj+R0lkbODImmxxLip7jDsUTBdr6Uif4oiQL2Qfz5OTPkZUoO0Em9opJiuE4BmaNvoZUQlML0ChcJp1iEb7IZ5s0KQCzKnKhPaPvB1do6An+/hL2uRGogoR9uMuwiOkOOgG3vQZZIdV4lgR/85+97HNLlzh+BjHmI4pouDr5SONkRA==;31:pD6r7+0BDPBOXqe4UG9/Bx1W9jluK2/HZvKSpW1Jl+43Rwiz8t8uawHEGitR+rzy5CFqyN1r28cXktXaZgYjQ5ZxNKaRDMLS8lg9x0xrzaJNUNgO5xEXdb3qJv6MHWcL1hC26n2zfJKovor1oii8oi64PdnIQO3mi2FrW24089vWDM+Je4UbVUH3TIY0hhHu9XaJXbBzIiw0gNbrR2Otub3hjpn1cfMt2vdj4NJH3UQ=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4381:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4381;20:cOWdlL57gTj7P3tL5qlCrwUW0tzTWn2q/yhO0kM3cnVanzwZAx9Vy0s4wYpyYKBRLwzjKy9dqofISuo0SXsabGD2zHp5F5z/158nfx0L4BF2ChLG70ivDlG45en7WqxFkyRKGagGqAOZwRNBVanVV1fA0rGZkwHCYjrCa9Eh5Qii4MnpvVV9UVEIF//e0mlSC9faNf7sRiuhCqUpeHFuDoUfXvY0E5HlxMBhBuqUriaqAvCXGxqGztVB4655naBMZxGkO08782seuBF21fQXpu10MGWuH/JfW2hkA3aZlM3o2CLzgAvA0pQzUba+p3gN+Xd269l1ssFEZilzK/Oukf3Ml/LlLZuv00b8SILZZ8HucDauqSoBrzkgGpqO/ZmMnAGMi9tPIvSrleQpwQ4/yjmHQtHrIOoQkfJYhz+k53ysRHvDKyQk9F4iZ+hzgePbyoYLmxC5kZzHWDyitWDPm3spb0A/rkNxgq8NylVVfcZrpKykdOEcNIWSolGbssFEo0Zrt+VFLYiCsgSC3Vs1C23ICaM7MXDCTSsc6CzMqH56yD0SN+hulQH+4BSLorTvsksC8z5b/g8fbXmuJfaPimuBz/L3550Kq4FMd53TabM=;4:3BCqp6Eii/7QgwEKeRRD2LmAgFdhsDGYR+feFFmP/NNdzdS73SC3HEuMUBC+yNLe/9BsuTY0EWXRv+2aRc6GHYivlWgp4prFqq41u7JvTYBFB4S6yK8kPRpn52IaLa4Sk0kiECZFZD4rm/hlurQ4h8HRiDGJtvdooaif+IL62x8ZzCbQKYfSXO85rpZzD10MFJugnOkPHtBhqTMF1Kx5l8eYrv/b5jsjxPPPZR94N0J4kBNRT4rTU9p6MRQRT88tvzp0VwqXUZPvruH0BFTErg==
X-Microsoft-Antispam-PRVS: <SN6PR07MB438160B8B231D9F3070FC06FE3430@SN6PR07MB4381.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4381;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4381;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(346002)(396003)(376002)(39850400004)(366004)(136003)(189003)(199004)(305945005)(7736002)(2906002)(66066001)(33716001)(8676002)(53936002)(4326008)(81156014)(81166006)(47776003)(25786009)(6666003)(58126008)(6916009)(486006)(23726003)(1076002)(3846002)(9686003)(6116002)(50466002)(8936002)(6246003)(956004)(316002)(5660300001)(97736004)(476003)(16586007)(68736007)(33656002)(76506005)(11346002)(42882007)(53546011)(446003)(26005)(52116002)(6496006)(6486002)(478600001)(72206003)(186003)(229853002)(386003)(76176011)(106356001)(16526019)(33896004)(105586002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4381;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4381;23:sjXFsKRVQbcj9z2MIh/GGWpo4Qrc33bXpTk4mkbm8?=
 =?us-ascii?Q?BB4zDR5RQ3rrcluHyaWcgAxQuJmJiilxU7F93x4HZYJBa/0yq9zQ6s2pCGXY?=
 =?us-ascii?Q?bOrNEOTgp3gX75C2Oi68koN1UerJLrJdRZChUW4Nin7DjieLqAalq6xEuxea?=
 =?us-ascii?Q?206VP7HP23ZH+BWDsCRMRwuA3IkW1WkKqFuFOWiijiHyYgD0HUl5A5vF6yy6?=
 =?us-ascii?Q?K9dJFGsNFZX+12Yu4bRWdZkBgaxIhnR+0WAymjprgOgTRaTXm4Gj5L41rjEn?=
 =?us-ascii?Q?TazVbxMmzwO9DTzGk6eXd5s2OTkaZcEutCPMav9Vxs344EkAYu+RwfKJhWI/?=
 =?us-ascii?Q?s6JxPFEj6cYR5dSbg4poXe8Rxoq/k28aIaqqpb4fBkz1yBAdEtwgUPZRYd2T?=
 =?us-ascii?Q?arRQnX+MY+EKPtgYYcpdQLIodngMpj716J4EJ8Cb1wem8U987GeT5fk3jF0Z?=
 =?us-ascii?Q?kClcsjXtomxGyOc+BYUJcwswZr95LXm6TUiPMIYWVJQQ+2tvANsrzr/CJ5z5?=
 =?us-ascii?Q?UdoUQtJ7efdD/jCWElp8k9zQ+USTkieCTQg2Ihrd+0LXqDGNpaOLcvKEDbGE?=
 =?us-ascii?Q?kM/mAqvIUhHz2E9i/0ByQr6c7aEe2uGA/BBs7t2Fw7WQQGlgGtK6Wg4zmbAe?=
 =?us-ascii?Q?TCb+NTDJOlQKtaCrUu6VXM7BxWSdFWkM4cWdcSnun++Uc732d0QlMSULIj5g?=
 =?us-ascii?Q?R53DXL6zHU0oBungWg/mskJrFyotQOGP1kIocQuu+QogR8+Bu1onN68GHZLK?=
 =?us-ascii?Q?/DZAtoPArNoZt2KssnOrKNohi5Qjs4KiHcElCZ4JQH2mX0GuMVJJehZQxIdQ?=
 =?us-ascii?Q?vcveO4UWOa3XgHzT56ejRK3VI8kg23dSMn3PH7U2u7t9FurLfy89xjL+El6o?=
 =?us-ascii?Q?LeSlIOGFQyCaxFAfvyTUzky3vSfGXbgAFLRtJL1jpfEcrJ2JSF5sMfbwbGhE?=
 =?us-ascii?Q?JCQhjcNEcd7sIDDQtboi4OHx46/SqVRexhPasKlyOYhH8XtzCxPjKwr58xpJ?=
 =?us-ascii?Q?myDGbig6YtEYwXKeQBO++wIVQ3ccLzC6ijXs/DTL4E8+6PTKkio7cYNS/jDY?=
 =?us-ascii?Q?ye4Qw+Ms8kxLWJQHD8at/JBNgbq3itozARK1XN1US4NN6C2AcZi2W+8bZbn/?=
 =?us-ascii?Q?mO+bdAm9xtjXgSo6eq9ZFtZWnO49fWQna74e/WbYN0b5yVUv4abqprmHK5fj?=
 =?us-ascii?Q?8eqeCCpELbyFQ6mc6Y08fJfH2nlsp67cN4Hu8gNsS9a+MR6wxSGnNcmIOn0J?=
 =?us-ascii?Q?7LlWgT0fHI9xOQZd0qpf8S4soklene/bveei/F5Sr3amZ2NexGn5WyQ20OxB?=
 =?us-ascii?Q?dpnyW9ii99ht9MhR44xvwgD8u+3uyU1hyUtwFFZeJfW7+5gkBu7aa2b2jzNV?=
 =?us-ascii?Q?LfMiQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: ubOb4H5eeZ4jwK/H4XBU0EoXcVG4hqOhrwc5iLFES9LI9HChGA7SEoQ3LN/J2KOrXomPBquE3+pcUHFmxluOQXz76fB38Uv8EFgJ3ECz2cOka4eklAv/RuIBSjxL7hClOrKDzlq6JdaiuZC8B7NldB+BgQvgqSnVp1NthP/dmpH6lgtaP5cS/fRmERil2RBiyfwXfqlHpeTRSQY2BdQlpYo2v9GG+1sjYuML/fVV+3V44SOvp+T24KCQezqy9Jh8UT7/fssy64XyB++ymWSCECEn9CIHWWFZZX/K6HxrbXW3Qegk5ozdLoLpVdol1i/+WcEv/TPIT3A3gxoznZPTPteEo3e3Wg9y1BDRqkHV2Ds=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4381;6:2mrczX5BNc8tWEkEyu/49TVI0YcNIWRsQJAlFayma8K74KxlQrD0r7TdsnJ4oTbhTvvHdet+tiDvznUmrKfcqjwcencxN2HnkPUzR0zLpacbwaRRe+S3oxYmmJxrH8vbKtKsAmiVpoHRw71mBCSuyzyFj5X7qWDe/HJmrRv4uoBWuWJ7c+TnDK0Hl1LGuXXz0uwipyEp1iP7dpN00qTCiKi/mNkCFNsx0AslJ8fhebVMVx2eCD0n63P5TazdiTfm3bUShMvcRAeGM0a80oi4O2jGpiItCNw2l5Dwj65LEWz28q4g1ZZLwuNy74CbyKJWBxC466Typlbf1jht1ZOk/qCJK1SudsbgTY+NpdSpHuWFSAtTT3NzzHSd2hgWfy33E734UQTS2jocaEDuxwWdo+1DBPbj6irCzQS43yCuIQT22MoVMqszyjF3bKTs6crNZqTQT6xqQvIiesyt1BMI/A==;5:NOfDU7STnpmTWk5a0DFgj3FlvPSOiQ1c+p9r63PNSYR4apUv9DTgattZPHfF8l0Fro6BKvVoVOLp6LYi10vSzUSqwXpWhbg9LBrCEVnWRlhoLiMmSiIRB882PCDVRdmn7GrsOJNq1LiZooff330xJeKWaR2cQDLDzum49AplMrg=;24:qDntOAI4g1/sEXGlEYUOOjGmyIFHJjoftPeZKemSiSz9IfCzGYGtRoF/18xJ1/kFwiAhmUyGOvQWL323xPs26/rZu/KuvI4BdQE81fijcDE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4381;7:VD34/B2+aHNAWxcdA2IldPPHwnMHbzC5rpScNd6qR6/qzLoFqc1g8i7Xolp1nCWu1zLN64Qfux8h8FvUfl4ICVAH3ayYNtfFO5AogX9ZKqIBAIXcDil+dCsqTNK01yP14uFuDzbJphIlRVUuCVo31jH+7fLiXXIFHRA3QVVlVbfur8KoswewBYes5oFFt87MTZUQAQFhl/QVaP6lut7ft267aWKHkAwq9obuhFoS2UKDBZWoueJFVA8kqIc7bCqI
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 08:46:47.6385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09558315-f2a5-4415-6296-08d5dff859dc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Alexander Viro <viro@zeniv.linux.org.uk>, kernel maillists. 

On Mon, Jul 02, 2018 at 08:48:36AM +0200, Florian Weimer wrote:
> On 07/01/2018 11:49 PM, Yury Norov wrote:
> 
> > > +#ifdef __USE_GNU
> > > +/* Flags for renameat.  */
> > 
> > Flags for renameat2, right?
> 
> Thanks, fixed.
> 
> > > +# define RENAME_NOREPLACE (1 << 0)
> > > +# define RENAME_EXCHANGE (1 << 1)
> > > +# define RENAME_WHITEOUT (1 << 2)
> > 
> > I really don't understand how it works. Could you / somebody explain me?
> > 
> > include/uapi/linux/fs.h in kernel sources already defines this flags,
> > and this file is usually available in Linux distribution. So I don't
> > understand what for it is duplicated here. If you keep in mind
> > old linux headers or non-linux systems, I think it should be protected
> > with #ifndef guards.
> 
> <linux/fs.h> undefines and defines macros not mentioned in the standards
> (and it even contains a few unrelated structs), so we cannot include it
> without _GNU_SOURCE.
> 
> It might be possible to include it only for _GNU_SOURCE, but there are a
> lot of things in <linux/fs.h>, so that does not seem to be particularly
> advisable.
> 
> We still support building glibc with 3.2 kernel headers, and if the
> definitions you quoted above are not available, building the test case
> would fail.

Is my understanding correct that glibc community finds <linux/fs.h>
inappropriate for their use, and prefer to re-introduce (duplicate)
its functionality locally? I think it's wrong. The right way to go
is to make kernel headers comfortable for users instead of ignoring
it.

Are you OK to switch to kernel RENAME_* definitions if they will be
located in separated small file? Like in the patch below.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 include/uapi/linux/fs.h     |  4 +---
 include/uapi/linux/rename.h | 12 ++++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)
 create mode 100644 include/uapi/linux/rename.h

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index c27576d471c2..46c03ea31a76 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -44,9 +44,7 @@
 #define SEEK_HOLE	4	/* seek to the next hole */
 #define SEEK_MAX	SEEK_HOLE
 
-#define RENAME_NOREPLACE	(1 << 0)	/* Don't overwrite target */
-#define RENAME_EXCHANGE		(1 << 1)	/* Exchange source and dest */
-#define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
+#include <linux/rename.h>
 
 struct file_clone_range {
 	__s64 src_fd;
diff --git a/include/uapi/linux/rename.h b/include/uapi/linux/rename.h
new file mode 100644
index 000000000000..7178f0565657
--- /dev/null
+++ b/include/uapi/linux/rename.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_RENAME_H
+#define _UAPI_LINUX_RENAME_H
+
+/*
+ * Definitions for rename syscall family.
+ */
+#define RENAME_NOREPLACE	(1 << 0)	/* Don't overwrite target */
+#define RENAME_EXCHANGE		(1 << 1)	/* Exchange source and dest */
+#define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
+
+#endif /* _UAPI_LINUX_RENAME_H */
-- 
2.17.1

