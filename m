Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754898AbeDMOCb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 10:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754858AbeDMOC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 10:02:28 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F5D2183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 17/17] perf annotate: Handle variables in 'sub', 'or' and many other instructions
Date: Fri, 13 Apr 2018 11:01:11 -0300
Message-Id: <20180413140111.25313-18-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180413140111.25313-1-acme@kernel.org>
References: <20180413140111.25313-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just like is done for 'mov' and others that can have as source or
targets variables resolved by objdump, to make them more compact:

-               orb    $0x4,0x224d71(%rip)        # 226ca4 <_rtld_global+0xca4>
+               orb    $0x4,_rtld_global+0xca4

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-efex7746id4w4wa03nqxvh3m@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/annotate/instructions.c | 67 ++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 5bd1ba8c0282..44f5aba78210 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -1,21 +1,43 @@
 // SPDX-License-Identifier: GPL-2.0
 static struct ins x86__instructions[] = {
+	{ .name = "adc",	.ops = &mov_ops,  },
+	{ .name = "adcb",	.ops = &mov_ops,  },
+	{ .name = "adcl",	.ops = &mov_ops,  },
 	{ .name = "add",	.ops = &mov_ops,  },
 	{ .name = "addl",	.ops = &mov_ops,  },
 	{ .name = "addq",	.ops = &mov_ops,  },
+	{ .name = "addsd",	.ops = &mov_ops,  },
 	{ .name = "addw",	.ops = &mov_ops,  },
 	{ .name = "and",	.ops = &mov_ops,  },
+	{ .name = "andb",	.ops = &mov_ops,  },
+	{ .name = "andl",	.ops = &mov_ops,  },
+	{ .name = "andpd",	.ops = &mov_ops,  },
+	{ .name = "andps",	.ops = &mov_ops,  },
+	{ .name = "andq",	.ops = &mov_ops,  },
+	{ .name = "andw",	.ops = &mov_ops,  },
+	{ .name = "bsr",	.ops = &mov_ops,  },
+	{ .name = "bt",		.ops = &mov_ops,  },
+	{ .name = "btr",	.ops = &mov_ops,  },
 	{ .name = "bts",	.ops = &mov_ops,  },
+	{ .name = "btsq",	.ops = &mov_ops,  },
 	{ .name = "call",	.ops = &call_ops, },
 	{ .name = "callq",	.ops = &call_ops, },
+	{ .name = "cmovbe",	.ops = &mov_ops,  },
+	{ .name = "cmove",	.ops = &mov_ops,  },
+	{ .name = "cmovae",	.ops = &mov_ops,  },
 	{ .name = "cmp",	.ops = &mov_ops,  },
 	{ .name = "cmpb",	.ops = &mov_ops,  },
 	{ .name = "cmpl",	.ops = &mov_ops,  },
 	{ .name = "cmpq",	.ops = &mov_ops,  },
 	{ .name = "cmpw",	.ops = &mov_ops,  },
 	{ .name = "cmpxch",	.ops = &mov_ops,  },
+	{ .name = "cmpxchg",	.ops = &mov_ops,  },
+	{ .name = "cs",		.ops = &mov_ops,  },
 	{ .name = "dec",	.ops = &dec_ops,  },
 	{ .name = "decl",	.ops = &dec_ops,  },
+	{ .name = "divsd",	.ops = &mov_ops,  },
+	{ .name = "divss",	.ops = &mov_ops,  },
+	{ .name = "gs",		.ops = &mov_ops,  },
 	{ .name = "imul",	.ops = &mov_ops,  },
 	{ .name = "inc",	.ops = &dec_ops,  },
 	{ .name = "incl",	.ops = &dec_ops,  },
@@ -57,25 +79,68 @@ static struct ins x86__instructions[] = {
 	{ .name = "lea",	.ops = &mov_ops,  },
 	{ .name = "lock",	.ops = &lock_ops, },
 	{ .name = "mov",	.ops = &mov_ops,  },
+	{ .name = "movapd",	.ops = &mov_ops,  },
+	{ .name = "movaps",	.ops = &mov_ops,  },
 	{ .name = "movb",	.ops = &mov_ops,  },
 	{ .name = "movdqa",	.ops = &mov_ops,  },
+	{ .name = "movdqu",	.ops = &mov_ops,  },
 	{ .name = "movl",	.ops = &mov_ops,  },
 	{ .name = "movq",	.ops = &mov_ops,  },
+	{ .name = "movsd",	.ops = &mov_ops,  },
 	{ .name = "movslq",	.ops = &mov_ops,  },
+	{ .name = "movss",	.ops = &mov_ops,  },
+	{ .name = "movupd",	.ops = &mov_ops,  },
+	{ .name = "movups",	.ops = &mov_ops,  },
+	{ .name = "movw",	.ops = &mov_ops,  },
 	{ .name = "movzbl",	.ops = &mov_ops,  },
 	{ .name = "movzwl",	.ops = &mov_ops,  },
+	{ .name = "mulsd",	.ops = &mov_ops,  },
+	{ .name = "mulss",	.ops = &mov_ops,  },
 	{ .name = "nop",	.ops = &nop_ops,  },
 	{ .name = "nopl",	.ops = &nop_ops,  },
 	{ .name = "nopw",	.ops = &nop_ops,  },
 	{ .name = "or",		.ops = &mov_ops,  },
+	{ .name = "orb",	.ops = &mov_ops,  },
 	{ .name = "orl",	.ops = &mov_ops,  },
+	{ .name = "orps",	.ops = &mov_ops,  },
+	{ .name = "orq",	.ops = &mov_ops,  },
+	{ .name = "pand",	.ops = &mov_ops,  },
+	{ .name = "paddq",	.ops = &mov_ops,  },
+	{ .name = "pcmpeqb",	.ops = &mov_ops,  },
+	{ .name = "por",	.ops = &mov_ops,  },
+	{ .name = "rclb",	.ops = &mov_ops,  },
+	{ .name = "rcll",	.ops = &mov_ops,  },
+	{ .name = "retq",	.ops = &ret_ops,  },
+	{ .name = "sbb",	.ops = &mov_ops,  },
+	{ .name = "sbbl",	.ops = &mov_ops,  },
+	{ .name = "sete",	.ops = &mov_ops,  },
+	{ .name = "sub",	.ops = &mov_ops,  },
+	{ .name = "subl",	.ops = &mov_ops,  },
+	{ .name = "subq",	.ops = &mov_ops,  },
+	{ .name = "subsd",	.ops = &mov_ops,  },
+	{ .name = "subw",	.ops = &mov_ops,  },
 	{ .name = "test",	.ops = &mov_ops,  },
 	{ .name = "testb",	.ops = &mov_ops,  },
 	{ .name = "testl",	.ops = &mov_ops,  },
+	{ .name = "ucomisd",	.ops = &mov_ops,  },
+	{ .name = "ucomiss",	.ops = &mov_ops,  },
+	{ .name = "vaddsd",	.ops = &mov_ops,  },
+	{ .name = "vandpd",	.ops = &mov_ops,  },
+	{ .name = "vmovdqa",	.ops = &mov_ops,  },
+	{ .name = "vmovq",	.ops = &mov_ops,  },
+	{ .name = "vmovsd",	.ops = &mov_ops,  },
+	{ .name = "vmulsd",	.ops = &mov_ops,  },
+	{ .name = "vorpd",	.ops = &mov_ops,  },
+	{ .name = "vsubsd",	.ops = &mov_ops,  },
+	{ .name = "vucomisd",	.ops = &mov_ops,  },
 	{ .name = "xadd",	.ops = &mov_ops,  },
 	{ .name = "xbeginl",	.ops = &jump_ops, },
 	{ .name = "xbeginq",	.ops = &jump_ops, },
-	{ .name = "retq",	.ops = &ret_ops,  },
+	{ .name = "xchg",	.ops = &mov_ops,  },
+	{ .name = "xor",	.ops = &mov_ops, },
+	{ .name = "xorb",	.ops = &mov_ops, },
+	{ .name = "xorpd",	.ops = &mov_ops, },
+	{ .name = "xorps",	.ops = &mov_ops, },
 };
 
 static bool x86__ins_is_fused(struct arch *arch, const char *ins1,
-- 
2.14.3
