Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC58C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F3A2173D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Jw7DsEdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F3A2173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeHUByk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:54:40 -0400
Received: from mail-by2nam03on0110.outbound.protection.outlook.com ([104.47.42.110]:2896
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726620AbeHUByk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17oP3h7bDQFv5yGCeshAi4aDs8DfH/9WGBC/QYwJGHI=;
 b=Jw7DsEdMhGPWc6IB9pdBQu6ol+0Xl6i1NHnQmAoyBVaSa8gQlHlwZRRjDnr5HygvjQby0ka6/0EeCkhVFL4D9NMLEGJdBwidFTb6X7leB4jS0Jwv7vml/myX5yEwsUjPv2aPeZLhG0Fgv8VtezS7g6Nf0dRsCHBYIyLJolm03Rs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 DM6PR08MB4939.namprd08.prod.outlook.com (2603:10b6:5:4b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Mon, 20 Aug 2018 22:37:09 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        James Hogan <jhogan@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v9 2/2] MIPS: Workaround GCC __builtin_unreachable reordering bug
Date:   Mon, 20 Aug 2018 15:36:18 -0700
Message-Id: <20180820223618.22319-3-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180820223618.22319-1-paul.burton@mips.com>
References: <20180820183417.dejfsluih7elbclu@pburton-laptop>
 <20180820223618.22319-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: SN6PR0102CA0031.prod.exchangelabs.com (2603:10b6:805:1::44)
 To DM6PR08MB4939.namprd08.prod.outlook.com (2603:10b6:5:4b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12f00b5c-5417-4fd0-345c-08d606ed7785
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4939;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;3:YbJeqSDX1KpJaP4ekauaGhPP0SQF+HZWqWASNcqI2G+npW6ezc/Z1ok5J4FILuzBunS5l+9LY+9mVaFIIFTzzTCNypp/233R87B3Fb5mQrpS76ZxIKB+ClXWkN6+AMccdJiVIeS6+HlaJhqOmeBCfhyO9jOtSx1fAotvuF/Z4pRZZKYpAJ/u6rUOervcw2kfdfnAlxnfH7MszGR37RIPP2Z6x+NAW1DvvewAY3WJ1CjJXFt4rNaaAK9/jerjlkzb;25:zCdrqpidJJnbuHOTGtAAuLA1/lTHlF3a6fb34nqPD5vDkVNXJ8LT/tu63vAgZc+ToQw5T4CN9qMVw+V1v8KER36zGJG8juD6jDnBR3Cqg1HspvcoAf934YX+ZP+WW+7FqA8UPnk5+MOyeXeeMvfvH7wPqEAiRXBgsRo1zZFYAgm5ckS/Yu8L3jnRc6q+B6x4KJpOFYGj1lvoe7knadXoCIs3wK8d4xjAN/AflISFVMhF+LDMMG1JU582PV9UfF9Ihc/GrN5qrEkDyeTFr19WQn7/TeE7oIX+iwsdICPKDUA47G7pCBeXL6JBzshHyO7RXVqtsYtkKoX+ZXNTOxr/aA==;31:Pcr1mZAG9EA/CYzO4QaGoXuTE0KbXFajygfb6LVPkYp461g7BXAdDPHlJMQ6t+Ug4XSmIzP4ovJaD01TlMZSD1qiYX6BxbsvfqYv38GHcJLKJt92lenhYuP5jivf51MMC3zZADAskNeO1nqgQ/nM0R34/R4TK6YsFPyL0lzGNXPKLVxtssO/pQ/eg3gYQab/VAkG+2EV5+DByV7SOhBUx6evyIgu0JNUzyUPOEzY4c0=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4939:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;20:2DHv+AF2w1o6VWhNVTgZ4biDpDZ9e+tZXRr5D2zdt/rQSlz/30SogcE/u89BEXnmQ1hcOfYYEan4Y6ezkaJEG7FgH2F20dJW/I7cGZL5RkogpAro8/mP0V/q4VLsoIePOlGRFSI7qocDJFTK2kxndJAnjdJ2JP5cTPjggIO/JIZk+XXrXwN3xqg7u8XXiHTcOUHfgqvDd3aZ6kGZoE5mUAWGVTZmtG7rUY5pasvOo0W8TATdM/LhmRzvvXZAk2Wb;4:HCFjlrsx2TAWFVkWcDCF+wGdOUaL7V2RrGq4k1pVrjZrLyy4iX4O9chb3iSOQ86CbsM5TxAtpVu0DNryeTqKR+duPZ8QxKj/oEOAMIrJ+hNKpjSv7ADv/jpBOdTFd3o/6Qn6QwugZtFlzNuL28bmDPTlCEzTFkaidKuvWroj59E0oH/D4WmLbBi/mIN/UouOyXPWQYvSUWrxXB2D2gXNE7kyTPNAbaiZ92ka5T4fL4o4B1Gf3uU6dHU1RqzlaFsXri/b5OVcdAHttuTlaGd/21WDtaiGEOS8n2UEN6ZK6fLE2dw9etmtUqCcaIEavaXGv0LR0FLUTGchiHSFp71OOTYT6Oeyfc1/+6JQ9vXRyWk=
X-Microsoft-Antispam-PRVS: <DM6PR08MB4939534DB7E875D79040512CC1320@DM6PR08MB4939.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(22074186197030)(183786458502308);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:DM6PR08MB4939;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4939;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(376002)(346002)(396003)(136003)(199004)(189003)(6512007)(2351001)(2616005)(6306002)(53936002)(36756003)(25786009)(476003)(956004)(4326008)(6486002)(50226002)(44832011)(66066001)(105586002)(48376002)(11346002)(478600001)(966005)(68736007)(6916009)(6666003)(53416004)(47776003)(50466002)(486006)(69596002)(106356001)(446003)(1076002)(5660300001)(16586007)(16526019)(316002)(26005)(2906002)(8676002)(2361001)(7736002)(14444005)(8936002)(97736004)(386003)(305945005)(6506007)(6116002)(81156014)(186003)(51416003)(81166006)(76176011)(52116002)(3846002)(54906003)(42882007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4939;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4939;23:WP75s3agS+h08wmioVGJ43MicRAkTX6vk6dB1uiCS?=
 =?us-ascii?Q?GLUYJYPZfSFj1qE3pDFUSzaD7jYn5VkFfvQ6a+LjRreS7cTQEwP3COXGwHn9?=
 =?us-ascii?Q?o4brg8gOOozx3T73QI8W1X04pwWWuwg9Qs93YTiAk8txEAGpZCTuqqs9m9bH?=
 =?us-ascii?Q?9bq29npP9Motab9knIwg/nZVglFjnIifVBWROmDrDvS1DGKgvE6OT+up9ap2?=
 =?us-ascii?Q?oCH+IJpt2vrKgth6tozaSulQRYKsL+uZLomiZe4x6AnX2scw5ei3bt5ax5H4?=
 =?us-ascii?Q?ehUDxE5e98S8i8cc16LtML4PAB7exunIYm4v2lNPCjoWUDrsmWBtzXs0oTmn?=
 =?us-ascii?Q?7Vhrqb+TJ+OZgP3Zo2HII9JrBFjagw7dvg5YeDTXpRlZv4WSQvJdH8QHrg6h?=
 =?us-ascii?Q?rVmCnuB9iYwXkhhHeUcM3vKmNoHfV4Qg3dm3vf5LIsEVWXRJ7MeKp9k+eZlb?=
 =?us-ascii?Q?pB7qjBm8udqjlyJ8EDg8+nJNMUNfR1BpVvXtHzhw6xYjqGo/29u7OuS+maUx?=
 =?us-ascii?Q?FhIVeJILp31DqWNKAvcR3W1FAojpUL18Hl1xMOpC6nR6sF37BdM4oFaHhzw/?=
 =?us-ascii?Q?SR+4Xp62b1Ymp3sKiwKTE3dRvlXk65ZvFdW1aIk1SxLgC+2B0xezM30T7J8m?=
 =?us-ascii?Q?YZitAdvn8bczwStQ4BQnXRBgGQ+iWC2iC9kQ6lLPYO3BmLMYf0R6snQPZjfC?=
 =?us-ascii?Q?vdXL1WrnFbiTF6FjEFJ/QdFCYmuOigQZWddbPLaMRPOGXXVhAMdZQT+pTy02?=
 =?us-ascii?Q?pixZQ+w5VATs101BoPfUUXZU6w94C8cESbHwten80WSoZLAk/Fb+lF+QglKC?=
 =?us-ascii?Q?x94os0nUB5HyR58quAR3Gm5cKcBeHw5FjZhmMBAO7RKJtFnurNI39VGiwrPn?=
 =?us-ascii?Q?8bJNhpt5egBaY7Fc3fEcYt+Kuq4CyUXzha75L2YFGOm2UcG7GqVgdX8/T8Hx?=
 =?us-ascii?Q?mdDXqEstAr+7+ce0SqLpHzKwHF86kNCdy6JmEUDQSlwAqGOig7a7bSS6Rgqe?=
 =?us-ascii?Q?QXjKZbdVD+iNdEwU1uwrt2HI8bCeMGiWji+WRpjgXv6i5mSs7mHvJ+NlwzuI?=
 =?us-ascii?Q?wKj8O2X5EDJU5tBvybNXIOkX9PC+mgAruiwF1NP/3ZbZ8oq1LUYvxrppkHlj?=
 =?us-ascii?Q?KIrs9qNJvfC5jarVo5fGh7rQgRhwix/WOhr8auL07DUVSSVoH9c8vLYjr+KH?=
 =?us-ascii?Q?Cur9uDzxHY3+xdiHwLrIlzImTKgSAfwUH41xPj/P+dyhbrZlFvQcVRovAsMj?=
 =?us-ascii?Q?Z8tINite6b+3h3k4+c+w4JECZdRAZHKmxl65s0rLel2DM2eQVdpa+gWIGOWm?=
 =?us-ascii?Q?XhWt7PI+SJkLn96tIzkJ9FQ4IxJ67RI+TZqL7HoTgan/5/ckrTRbl7M/H891?=
 =?us-ascii?Q?AVeKg=3D=3D?=
X-Microsoft-Antispam-Message-Info: ARVvxJUZAFV2DHc/uzV9AClycKW/1kV0STqV7txdmoccKWmns33nKS3eW4faIuJrYsgV+doKBv+LCFF7VlkFEjc9CEIqVS/oS3QaFZnFmDp3HV3imuUWhBc0LJVeoB9D6Bkqgz1KsMw/xKKNxQBSHwGEdP2/qEIOCE57HoX+t2bSFFlgDeXAVHf2Ch0CKg0fMpC41OFQtXgpkocB3Q9be/iou3iNVcOQspVcqnWR8tEthRMzZZvYXrTcX6R6g8xzTsYDIxeqy+IaSk840ExGkNoE+Nud7S5rDnIFex8moBCDhzMAnBwWRWYFcF+4iSQC789TZ4Ctz2C21rYTWaoESKqVCc06HtdLT4jHiItMCrQ=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;6:RtIr+EOnuN+jSdwB88Z9vi09Z4zOzLbhD0xm2cApUVhbOpfzpIAHDWSRbiVqbTshx6OcvBufoOtDRu9wUjATnQQNP8aS8P8Xq7pzpqUoNlMEUM/7LBqGZvhV41Z9L5xS0J1xt0755iFuiV3ygtd1jUtCBZMxVykDYQL/pPssRYlntrTPojqoe93Sr2FBFg9d+Uw0ajy0f7m53gsOgnO+jr7xGqQ/lWASeLpwFtxCzvqizknioPWfgQUsDIo96whzHeaHLqrBJ3eAAqsUkuxmGu+h3QUm025PJ7W/t/mFZH9JhT/0DciobVPfExvuYxvy93CRSfRF7rllfcWnzyqXYxsmDx3K/9SwF8yVL26cI22DyiCHvU4ZAA7+iuctHW4MdoeOctU/foFX+0BcHuaHU2QXLUt1i8lwf8pxomKnVRpZSh3YfUhn+6ru/rxTSY2lHbkFnlhkh9fBfEXrSoM+oA==;5:SRWU0COopFpN/xKgVBFJS7BJ7AT5ss0nKUoJIfC10u/Xervsx9JmB3HwWRyq7DE5Qx4rzcxJg8fjtYlTK1v+AlTp9qHEvRQkkJtIEqYEFCrlI8Hw+oBI7eLt0PaxW7gw6p/Yw3kxZsnO0Vl0BsIQISkgiqOPxft72kNW4qGINFM=;7:pnV6S61Xc+Aug8QNPil5i45UEZeNG4hdzRQF9gHnXPbL3dzV55waTAHJIZDdxG5ehjPJFPlP7oe/PPW4KgW4z9AHROwb6C0IX/AA4j1J9pYz0Uurz5E+nEZebxhhSW/U/oMr8VIukA+eOS3yUXWiIaQYTxTTjd1oblG/B/uhoOjibelWG5+z+OMIanHD2JyS+xOEJhFN9yqEvGJwazkjLk/ufcWoD5qhIva895fc9QAJqDofPXqq/H6uDV2MtvSB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 22:37:09.4332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f00b5c-5417-4fd0-345c-08d606ed7785
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4939
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

We do this in asm/compiler.h & select CONFIG_HAVE_ARCH_COMPILER_H in
order to have this included by linux/compiler_types.h after
linux/compiler-gcc.h. This will result in asm/compiler.h being included
in all C compilations via the -include linux/compiler_types.h argument
in c_flags, which should be harmless.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: 173a3efd3edb ("bug.h: work around GCC PR82365 in BUG()")
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org

---

Changes in v9:
- Move back to asm/compiler.h to match changes in patch 1.
- #undef before #define since we're now including this after
  linux/compiler-gcc.h.

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

 arch/mips/Kconfig                |  1 +
 arch/mips/include/asm/compiler.h | 35 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2af13b162e5e..35511999156a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -33,6 +33,7 @@ config MIPS
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select HANDLE_DOMAIN_IRQ
+	select HAVE_ARCH_COMPILER_H
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
diff --git a/arch/mips/include/asm/compiler.h b/arch/mips/include/asm/compiler.h
index e081a265f422..cc2eb1b06050 100644
--- a/arch/mips/include/asm/compiler.h
+++ b/arch/mips/include/asm/compiler.h
@@ -8,6 +8,41 @@
 #ifndef _ASM_COMPILER_H
 #define _ASM_COMPILER_H
 
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
+#undef barrier_before_unreachable
+#define barrier_before_unreachable() asm volatile(".insn")
+
 #if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 4)
 #define GCC_IMM_ASM() "n"
 #define GCC_REG_ACCUM "$0"
-- 
2.18.0

