Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031040AbeEXOMI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:12:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:5108 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970415AbeEXOL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:11:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,436,1520924400";
   d="scan'208";a="53528433"
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v3]: perf/x86: store user space frame-pointer value on a
 sample
Message-ID: <311d4a34-f81b-5535-3385-01427ac73b41@linux.intel.com>
Date: Thu, 24 May 2018 17:11:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Store user space frame-pointer value (BP register) into Perf trace 
on a sample for a process so the value becomes available when 
unwinding call stacks for functions gaining event samples.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v3:
- adjusted comment regarding saved registers on system call after 
  recent KPTI improvements

Changes in v2:
- lifted restriction on frame pointer architecture so it's value is provided
  as for i386 as for x86_64 processes

MAINTAINERS file lacks references to appropriate folks for reviewing 
  changes at arch/x86/kernel/perf_regs.c so probably it makes sense to 
  update the file as well in this respect.
---
 arch/x86/kernel/perf_regs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index e47b2dbbdef3..f54348a72add 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -151,17 +151,19 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 	regs_user_copy->sp = user_regs->sp;
 	regs_user_copy->cs = user_regs->cs;
 	regs_user_copy->ss = user_regs->ss;
-
 	/*
-	 * Most system calls don't save these registers, don't report them.
+	 * Store user space frame-pointer value on sample
+	 * to facilitate stack unwinding for cases when
+	 * user space executable code has such support
+	 * enabled at compile time;
 	 */
+	regs_user_copy->bp = user_regs->bp;
+
 	regs_user_copy->bx = -1;
-	regs_user_copy->bp = -1;
 	regs_user_copy->r12 = -1;
 	regs_user_copy->r13 = -1;
 	regs_user_copy->r14 = -1;
 	regs_user_copy->r15 = -1;
-
 	/*
 	 * For this to be at all useful, we need a reasonable guess for
 	 * the ABI.  Be careful: we're in NMI context, and we're
