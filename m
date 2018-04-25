Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753503AbeDYMur (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:50:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:14629 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753880AbeDYMum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:50:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="223229219"
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v2]: perf/x86: expose user space frame-pointer value on a
 sample
Organization: Intel Corp.
Message-ID: <fe1861c8-fa47-1011-0210-eb6e33d24bba@linux.intel.com>
Date: Wed, 25 Apr 2018 15:50:34 +0300
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

Test executable for the example below was compiled with frame pointer 
support enabled:

g++ -o futex-fp -fpermissive --no-omit-frame-pointer futex.c

and profiled using:

tools/perf/perf record --user-regs=IP,SP,BP \
	-g --call-graph=dwarf,1024 -e cycles -- ./futex-fp

Output of

tools/perf/perf report -i perf.data --stdio 

demonstrates the effect of the patch change so before saving BP 
value on a sample we have several frames missing above main 
function frame:

# Samples: 138K of event 'cpu-cycles'
# Event count (approx.): 92713835335
#
# Children      Self  Command   Shared Object     Symbol                                        
# ........  ........  ........  ................  ..........................
#
    96.15%     0.72%  futex-fp  futex-fp          [.] main
            |          
            |--95.43%--main
            |          |          
            |          |--71.56%--syscall
            |          |          |          
            |          |          |--57.28%--entry_SYSCALL_64_after_hwframe
            |          |          |          |          
            |          |          |           --56.95%--do_syscall_64
            |          |          |                     |          
            |          |          |                      --55.77%--sys_futex

and after saving BP value on a sample we have expected 

	_start
	__libc_start_main 

frames unwound:

# Samples: 128K of event 'cpu-cycles'
# Event count (approx.): 85349981034
#
# Children      Self  Command   Shared Object     Symbol                                        
# ........  ........  ........  ................  ..................
#
    95.83%     0.00%  futex-fp  futex-fp          [.] _start
            |
==>         ---_start
==>            __libc_start_main
               main
               |          
               |--71.28%--syscall
               |          |          
               |          |--55.67%--entry_SYSCALL_64
               |          |          |          
               |          |           --55.40%--do_syscall_64
               |          |                     |          
               |          |                      --54.21%--sys_futex


Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v2:
- lifted restriction on frame pointer architecture so it's value is provided
  as for i386 as for x86_64 processes

MAINTAINERS file lacks references to appropriate folks for reviewing 
  changes at arch/x86/kernel/perf_regs.c so probably it makes sense to 
  update the file as well in this respect. 
---
 arch/x86/kernel/perf_regs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index e47b2dbbdef3..8d68658eff7f 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -156,7 +156,13 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 	 * Most system calls don't save these registers, don't report them.
 	 */
 	regs_user_copy->bx = -1;
-	regs_user_copy->bp = -1;
+	/*
+	 * Store user space frame-pointer value on sample
+	 * to facilitate stack unwinding for cases when
+	 * user space executable code has such support
+	 * enabled at compile time;
+	 */
+	regs_user_copy->bp = user_regs->bp;
 	regs_user_copy->r12 = -1;
 	regs_user_copy->r13 = -1;
 	regs_user_copy->r14 = -1;
