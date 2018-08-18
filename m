Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8BAC04AB9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F131121748
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="UXiGruUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F131121748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeHRVT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 17:19:58 -0400
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com ([104.47.37.134]:49386
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726265AbeHRVT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 17:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axr3lji30FelzXcjd45bcsbNzC0X1BTnSuI1Dn8YaJk=;
 b=UXiGruUm9nTHiSUvXW3711HQRxyKQ33DARkiV8OQW93SkqJQJOg39Zf9a7Mqoin4bpFZ0jIT0hRr/iAGUk1J6VVSlm6EbzBMNfnTOlO5srLQcMlvMCN88X0JHHkaFf3Mghm59qa4ywk5R1OvWjgMTOndL9kBkHO4nrveVSThh1c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BYAPR08MB4935.namprd08.prod.outlook.com (2603:10b6:a03:6a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.22; Sat, 18 Aug 2018 18:11:14 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        James Hogan <jhogan@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v8 2/2] MIPS: Workaround GCC __builtin_unreachable reordering bug
Date:   Sat, 18 Aug 2018 11:10:17 -0700
Message-Id: <20180818181017.1246-3-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818181017.1246-1-paul.burton@mips.com>
References: <20180818181017.1246-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR21CA0035.namprd21.prod.outlook.com
 (2603:10b6:3:ed::21) To BYAPR08MB4935.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f39ce75a-adca-46cd-59f4-08d60535fcd0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4935;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;3:q0ToXm9KHYmsJNDYWLbwOEPvyQ/bvSw0GOptKD8/0NLekdIzGsZEaXWw4NQPnkbUn1wWxAigeQUEC1EUJP6eKJwWh7aYqFlFEpiNZCnZtNMKvcGM8v+Mdug7G80VJxMvUaIvPrWMMan4BhwZl1Xbu9HD4tDnZU9nBCD0xcl544hM44GDheRam8KE51SuqWkPoQrS8R+i1IxeVM+SFJzNUvuQjyVvEi54kIb25Mj/gakWYrMqXT9I3N6skM5cngnq;25:uwVG1Lng0YmCZqe1dW0G/nQr6IOrplLIZ4K+BdQaFJRRMVooqixyda3szVaZ5bS/hj/ERngbmd3wOA/8H9SuIx0mZ9ok/4TaE2O0QWVqM2nEZJYk6LnSF+7fSsMU5W9+UcGKrXudyMKdsgt2RR/KjrC55OSXUUsyACj5xaXztvOqX9GptaeupP+CM0pPKyRloActB44q6+oRGoavYUamoAr6PjLzDkSegl6H2rYCD/fMNHoqp5oibaMy8LkA5ouRakzXxBzcXz+vYzN+fFIv/a4HMSI2We9TckJcqh68d7BbMVo3DO6kGLQ9s/Rki5CvwUXESs6a6w95wrJnWfIoug==;31:7A3cFLN4uA0rNya1uFoJjxIGT8YERe6v+RSPwB64PibLFZ6xRXGzpcY39adX6PzQ+cTjWUaqcAf6D1dgr1O0K+bQh4/AMcao+Ivt+5qG/cOZShy81ALEvkKxN1A8jgA9qKsYsiSZcxAQ0//nwxKg8ki2l2OyT2+G0ke5+9KopAt9P6SzrAZaPvZcqpJpoXuMUITox5MdZY3Ys2usjASuj4WIzqZRistBD9mwa/2lZhg=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4935:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;20:XBTae1Xb//EsnJRA1t8Dr6bav3L0f1lyycs9mwzUgbFtWJJ1ML1LZKCrgsAy1Nha+ZWrsa63d5eSo3Nnv8uZcpQNLVeSgLAxnUsPNmzD6i06vbCRRwdLvj+br2TLGYS7oc8TdKu99UOUJk4tIkR3o5OdhuzenPOQ3LYDaz2wL5o57hifCxYb/DBFvsnYUhOaKJC0y3H8wiLAOxt0GTUBAElVZtNsbse9KGNjSGIqpWogtbDZtR6TELmguOiqPbI5;4:sEYLW98pK5r554VnW1HegkVvLlFlMcLj0epSd0W5B/BPnub5iBllfTvFTjW7k26pvkyOoX4oU6yR/6V9CbPnQllWeMhNYHEVjCIP1vb5IZZit/hqoWkdtkL1tgwpz9dQZRNt+eY49eSD2nt6nWJX82MxIWBCoxijOLTxz4mLKgOLr7670JQ5lp0TmEwB8k6ZTE/R/D85EndSrrgLhkencivSvfr9XmBOtwW9xiWTN1UzmsauSEbcMa9T9KSBmvfsIIJ81coNnE8rXEhT/mzw3s9/CK2Jhbm+2EWWJ8tmcTGjX68RyPo6+ax1JjnPYEOpYOOBVtUNusv0kgU011WpjN7Ymf3gT9cVjUVza1z8Jwg=
X-Microsoft-Antispam-PRVS: <BYAPR08MB49354163BB2E6A3654A522A9C13C0@BYAPR08MB4935.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(22074186197030)(183786458502308);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699016);SRVR:BYAPR08MB4935;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4935;
X-Forefront-PRVS: 076804FE30
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39840400004)(199004)(189003)(53416004)(47776003)(106356001)(105586002)(14444005)(50466002)(6486002)(6916009)(48376002)(386003)(6506007)(11346002)(956004)(476003)(2906002)(2616005)(8936002)(42882007)(16586007)(486006)(316002)(446003)(2351001)(36756003)(68736007)(66066001)(54906003)(966005)(50226002)(186003)(16526019)(478600001)(26005)(1076002)(51416003)(52116002)(53936002)(97736004)(76176011)(69596002)(6306002)(6512007)(81166006)(8676002)(81156014)(305945005)(44832011)(3846002)(6116002)(7736002)(4326008)(2361001)(5660300001)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4935;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4935;23:v7Ls6GU5X+Q+laqXeNssfS01t+PB4M2jEdN7N8lk+?=
 =?us-ascii?Q?3nKlpnGXs/9DcHBVCDCVc/3AkTMLae4QI8FqRz87wPGDzLB5TTPKvxU1FwhN?=
 =?us-ascii?Q?FlWPo6WYj+3rF+HUbctiSZhAy27/p0aaDzl2UPrFwUqzbMGNEjZ8tGAsOF5L?=
 =?us-ascii?Q?G1JoGf26YErmioxk0dx7lqzd3p7Wr8OfrHFJhc3ON3t6w18JJnfz7bnpPYXx?=
 =?us-ascii?Q?yb+FkDe4VhtIWSrjTTJpBjRuO6JZ65qF20MR16krx/dxfd9I7N8Dhsz0WY5T?=
 =?us-ascii?Q?T5o8t0PDf++QS4xqM2YHJpMG4mNx577/lRVmJEeh1uduVmV/mXgBCNEeQuZw?=
 =?us-ascii?Q?YPVVSRkNjE4Z0taUcHcE6jQ5gUckiJqJG0+yyFeUYiH7/bfLacbTfTpQrvfP?=
 =?us-ascii?Q?1Fdng/tET8p8ZMW1JDLjVNzp7kWJIMorGDdtKqgkO39278rJ+NfCqoo+9js9?=
 =?us-ascii?Q?L63yIxxEfZt9+0qZsemgabUhCf9P5lXmPgqlnLn+9JMETqIujaipsY877FBz?=
 =?us-ascii?Q?fh2sU/wvpjgc1VhT/d1B55CKxzazhtgaZwS2goCO4SxplF3vImF/10EKnWfl?=
 =?us-ascii?Q?G6hUIwia9wjZsTHHMMPIRt7S81oP4v32d0xZtKDARvcqr474CVY3ikTvGKv+?=
 =?us-ascii?Q?+HX7UlGKijADZkQb2/f7HGMKfKcaAXQoCCjcbi2ujy9etZP4VZ9KqVGyUd65?=
 =?us-ascii?Q?guhcCurM2eu1KUswBRilSFsOxb9gGfJo/5NiJUm0Y8siRayAIyYedH4Netbg?=
 =?us-ascii?Q?PT7x+rjshekizxM+Wpr2pDyLc1BvNWeLIFDYzXC5x7P+Zpo7/WgX9/HUyWWs?=
 =?us-ascii?Q?+hBmS50uKrOZKYHbtzGYJgNQG2FUTZhNDSJQpW6lxjbbzspkjTiqVGGGEApU?=
 =?us-ascii?Q?+sXaDQSmNQJCeVcAJeX9D4ghbpYtThSI4Uzw3ObMQeXnkFjq/5O5dKcu43FE?=
 =?us-ascii?Q?9XEzoxd92rN+IGE9zLrsTGAeRU4yPJRAk2+lEA4gFY4SE/5Vn/gjthycoT/Z?=
 =?us-ascii?Q?SWHjtYO9ERkmMGLi7E1bvyLDAa+OTgrq+vnE7MUcVbeOCLGCNqfqfd8SsLX2?=
 =?us-ascii?Q?M88Szw/c1/D+MIvdvUQsUVStzDcJmgydlb6EEM5mCRTp+KpAMFKokj/a0E5G?=
 =?us-ascii?Q?aOlWew1MtSoWYUDMUiyNTj93DeBWUIhMjsax9EUh80a+MlV6JYU+KqNmo9xI?=
 =?us-ascii?Q?5I4sBb7i32+GLKxv/X9ZKl606CoWo3jLXG/G7soQ1DAdpElmwCsPfJHAYlQV?=
 =?us-ascii?Q?y/25LMg6IERxg1KGGp9sTSOJajwuv2NFPwBfBxQz2MA/C/zF1SozwS+8ztn0?=
 =?us-ascii?Q?lQH+t1bfp3VT8JUHSg/wlA05o6UqwmKBsEeNqwRyJrX?=
X-Microsoft-Antispam-Message-Info: UR0jU1NgSCPCXXjYjc60g5SvbBn/XYRaMKRaEOP//lbNPt3w/Sbr4Mnfugs0z+HzeK1pu9fB/9uWCdGl1w+VxgwjpeAx/5xpowxQyIuJnb4n/bxfmKjQ1Q0B0caqJUJ4SIrsN86u1eorJpF7Ji5MNamv7JfN2GiBMH52pBR31cjugXGKUWrTVxH1pumRzDui3FI8lNnymctDq7AwlmPXFNKzJAasAe6oIxO85abPi2g6N4FE7oRGvYXUfx7lgiYPiDhampTegQ6z9Kg47dHlzHRrM8xer4sjRe0GVWCmzEtOwXxFW9ohRKEoF2Zz2v31EmSswjmNGx4n9KqQymtXAeihFaLh5TPhgetDZepyx4c=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;6:BTLH8r8XJ1JDqJVpygfZnmFe6NZY/zUSbgd0eUmV6QehVQU/gigcsllHglVqCHDtJBNHMBhIsSbYe0fM57BeG3sOpPqd7u55u9jUSiFndhHqAJVr2lFWxhXwSy02BIGNwUGJW9YzNdnm7xVFOYX7JWeAdI/SjGrlwBkg8kXfQNNP2PAVdiTLCLwKIKgaLdHun+qtELyrD6RN0cJa/N0UMuaWa6ECqIuijZtcZ/y2QvqHKyF//0/L/S+um0hNpdkOio/dMcvy+S/MvN9iDaXOlWMiNnrLno40XTyk1vVbQh36MgT+Pfv15QbJ7aEYUvLw64OK7drdlPfobX63yWy3o1tXoVI0fsdpDICY/6nEMRkrfGUb5uuTZloiR2qcn8NPRGShCJAR3pCpVXYPo9ahrbEQdaO4IPjDahYhE/UeS8gdC/mUQxaarLvUqpP3EiEv+COprjPxTvwDiuDPIpvX9g==;5:3VMgwSHmFmtvHlVUWnsIK4w4GiAce8SwppsfXnGyqGdUdE9bvSO3z/S87k1CduI9Ym3pQAXVjwvcsP/Y8hOZKnNDDrJ/gZNjX2w+6znoeOs7QA25MXhbFoD3bmJRoTadbY+9via9z8YA3hcCkyYdzp0Wk/SEO1XQamflWGwnG8g=;7:ip+IF6kX3+m+k5ggbV9rb4yt4XrrbyTFEvx1TsgTJOpD+bTBuwjmdWZntJfYLGu1D9jVrOM9s5DkbTyDxOsbmSxKLIfP7iT/w4XdswoTA1E1np9B+rqBnIUttNW7fCid/uBMXLYuMUcBkW8Z8ekkf2u764C5HbnfRBLbtbPeL5nSBPknjVjD8KcgtJs5s3nI7ImqFrdMvPmBdnpCFgqZIjiFXUx9pW9u5lPI7ayWSWjl3YV07ezmwDFDbkpRGNbN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2018 18:11:14.2891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f39ce75a-adca-46cd-59f4-08d60535fcd0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4935
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some versions of GCC for the MIPS architecture suffer from a bug which
can lead to instructions from beyond an unreachable statement being
incorrectly reordered into earlier branch delay slots if the unreachable
statement is the only content of a case in a switch statement. This can
lead to seemingly random behaviour, such as invalid memory accesses from
incorrectly reordered loads or stores, and link failures on microMIPS
builds.

See this potential GCC fix for details:

    https://gcc.gnu.org/ml/gcc-patches/2015-09/msg00360.html

Runtime problems resulting from this bug were initially observed using a
maltasmvp_defconfig v4.4 kernel built using GCC 4.9.2 (from a Codescape
SDK 2015.06-05 toolchain), with the result being an address exception
taken after log messages about the L1 caches (during probe of the L2
cache):

    Initmem setup node 0 [mem 0x0000000080000000-0x000000009fffffff]
    VPE topology {2,2} total 4
    Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
    Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 32 bytes
    <AdEL exception here>

This is early enough that the kernel exception vectors are not in use,
so any further output depends upon the bootloader. This is reproducible
in QEMU where no further output occurs - ie. the system hangs here.
Given the nature of the bug it may potentially be hit with differing
symptoms. The bug is known to affect GCC versions as recent as 7.3, and
it is unclear whether GCC 8 fixed it or just happens not to encounter
the bug in the testcase found at the link above due to differing
optimizations.

This bug can be worked around by placing a volatile asm statement, which
GCC is prevented from reordering past, prior to the
__builtin_unreachable call.

That was actually done already for other reasons by commit 173a3efd3edb
("bug.h: work around GCC PR82365 in BUG()"), but creates problems for
microMIPS builds due to the lack of a .insn directive. The microMIPS ISA
allows for interlinking with regular MIPS32 code by repurposing bit 0 of
the program counter as an ISA mode bit. To switch modes one changes the
value of this bit in the PC. However typical branch instructions encode
their offsets as multiples of 2-byte instruction halfwords, which means
they cannot change ISA mode - this must be done using either an indirect
branch (a jump-register in MIPS terminology) or a dedicated jalx
instruction. In order to ensure that regular branches don't attempt to
target code in a different ISA which they can't actually switch to, the
linker will check that branch targets are code in the same ISA as the
branch.

Unfortunately our empty asm volatile statements don't qualify as code,
and the link for microMIPS builds fails with errors such as:

    arch/mips/mm/dma-default.s:3265: Error: branch to a symbol in another ISA mode
    arch/mips/mm/dma-default.s:5027: Error: branch to a symbol in another ISA mode

Resolve this by adding a .insn directive within the asm statement which
declares that what comes next is code. This may or may not be true,
since we don't really know what comes next, but as this code is in an
unreachable path anyway that doesn't matter since we won't execute it.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: 173a3efd3edb ("bug.h: work around GCC PR82365 in BUG()")
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org

---

Changes in v8:
- Move to asm/compiler_types.h to suit patch 1.
- Commit message improvements.
- Drop James' SoB since this changed a fair bit since he added it.

Changes in v7:
- Elaborate on affected GCC versions in comment.

Changes in v6: None

Changes in v5:
- Comment & commit message tweaks.

Changes in v4: None

Changes in v3:
- Forward port to v4.17-rc and update commit message.
- Drop stable tag for now.

Changes in v2:
- Remove generic-y entry.

 arch/mips/include/asm/compiler_types.h | 39 ++++++++++++++++++++++++++
 include/linux/compiler-gcc.h           |  2 ++
 2 files changed, 41 insertions(+)
 create mode 100644 arch/mips/include/asm/compiler_types.h

diff --git a/arch/mips/include/asm/compiler_types.h b/arch/mips/include/asm/compiler_types.h
new file mode 100644
index 000000000000..cecd5dc48ce2
--- /dev/null
+++ b/arch/mips/include/asm/compiler_types.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_COMPILER_TYPES_H__
+#define __ASM_COMPILER_TYPES_H__
+
+/*
+ * With GCC 4.5 onwards we can use __builtin_unreachable to indicate to the
+ * compiler that a particular code path will never be hit. This allows it to be
+ * optimised out of the generated binary.
+ *
+ * Unfortunately at least GCC 4.6.3 through 7.3.0 inclusive suffer from a bug
+ * that can lead to instructions from beyond an unreachable statement being
+ * incorrectly reordered into earlier delay slots if the unreachable statement
+ * is the only content of a case in a switch statement. This can lead to
+ * seemingly random behaviour, such as invalid memory accesses from incorrectly
+ * reordered loads or stores. See this potential GCC fix for details:
+ *
+ *   https://gcc.gnu.org/ml/gcc-patches/2015-09/msg00360.html
+ *
+ * It is unclear whether GCC 8 onwards suffer from the same issue - nothing
+ * relevant is mentioned in GCC 8 release notes and nothing obviously relevant
+ * stands out in GCC commit logs, but these newer GCC versions generate very
+ * different code for the testcase which doesn't exhibit the bug.
+ *
+ * GCC also handles stack allocation suboptimally when calling noreturn
+ * functions or calling __builtin_unreachable():
+ *
+ *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82365
+ *
+ * We work around both of these issues by placing a volatile asm statement,
+ * which GCC is prevented from reordering past, prior to __builtin_unreachable
+ * calls.
+ *
+ * The .insn statement is required to ensure that any branches to the
+ * statement, which sadly must be kept due to the asm statement, are known to
+ * be branches to code and satisfy linker requirements for microMIPS kernels.
+ */
+#define barrier_before_unreachable() asm volatile(".insn")
+
+#endif /* __ASM_COMPILER_TYPES_H__ */
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index f1a7492a5cc8..354d40f7bf80 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -218,7 +218,9 @@
  *
  * Adding an empty inline assembly before it works around the problem
  */
+#ifndef barrier_before_unreachable
 #define barrier_before_unreachable() asm volatile("")
+#endif
 
 /*
  * Mark a position in code as unreachable.  This can be used to
-- 
2.18.0

