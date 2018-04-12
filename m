Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbeDLJkp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 05:40:45 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:40182 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752972AbeDLJko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 05:40:44 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Peter Zijlstra <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        "Paul Burton" <paul.burton@mips.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v2 6/6] MIPS: perf: Fix BMIPS5000 system mode counting
Date: Thu, 12 Apr 2018 10:36:26 +0100
Message-ID: <1523525786-29153-7-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523525786-29153-1-git-send-email-matt.redfearn@mips.com>
References: <1523525786-29153-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1523525812-452060-21719-24429-10
X-BESS-VER: 2018.4.1-r1804052329
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191914
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf is used in system mode, i.e. specifying a set of CPUs to
count (perf -a -C cpu), event->cpu is set to the CPU number on which
events should be counted. The current BMIPS500 variation of
mipsxx_pmu_enable_event only over sets the counter to count the current
CPU, so system mode does not work.

Fix this by removing this BMIPS5000 specific path and integrating it
with the generic one. Since BMIPS5000 uses specific extensions to the
perf control register, different fields must be set up to count the
relevant CPU.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

Changes in v2:
New patch to fix BMIPS5000 system mode perf.

Florian, I don't have access to a BMIPS5000 board, but from code
inspection only I suspect this patch is necessary to have system mode
work. If someone could test that would be appreciated.

---
 arch/mips/include/asm/mipsregs.h     |  1 +
 arch/mips/kernel/perf_event_mipsxx.c | 17 ++++++-----------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index a4baaaa02bc8..3e1fbb7aaa2a 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -735,6 +735,7 @@
 #define MIPS_PERFCTRL_MT_EN_TC	(_ULCAST_(2) << 20)
 
 /* PerfCnt control register MT extensions used by BMIPS5000 */
+#define BRCM_PERFCTRL_VPEID(v)	(_ULCAST_(1) << (12 + v))
 #define BRCM_PERFCTRL_TC	(_ULCAST_(1) << 30)
 
 /* PerfCnt control register MT extensions used by Netlogic XLR */
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 389e346e9cf3..37cbb93aa521 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -366,16 +366,7 @@ static void mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
 		/* Make sure interrupt enabled. */
 		MIPS_PERFCTRL_IE;
 
-#ifdef CONFIG_CPU_BMIPS5000
-	{
-		/* enable the counter for the calling thread */
-		unsigned int vpe_id;
-
-		vpe_id = smp_processor_id() & MIPS_CPUID_TO_COUNTER_MASK;
-		cpuc->saved_ctrl[idx] |= BIT(12 + vpe_id) | BRCM_PERFCTRL_TC;
-	}
-#else
-#ifdef CONFIG_MIPS_MT_SMP
+#if defined(CONFIG_MIPS_MT_SMP) && !defined(CONFIG_CPU_BMIPS5000)
 	if (range > V) {
 		/* The counter is processor wide. Set it up to count all TCs. */
 		pr_debug("Enabling perf counter for all TCs\n");
@@ -392,12 +383,16 @@ static void mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
 		 */
 		cpu = (event->cpu >= 0) ? event->cpu : smp_processor_id();
 
+#if defined(CONFIG_CPU_BMIPS5000)
+		ctrl = BRCM_PERFCTRL_VPEID(cpu & MIPS_CPUID_TO_COUNTER_MASK);
+		ctrl |= BRCM_PERFCTRL_TC;
+#else
 		ctrl = M_PERFCTL_VPEID(cpu_vpe_id(&cpu_data[cpu]));
 		ctrl |= M_TC_EN_VPE;
+#endif
 		cpuc->saved_ctrl[idx] |= ctrl;
 		pr_debug("Enabling perf counter for CPU%d\n", cpu);
 	}
-#endif /* CONFIG_CPU_BMIPS5000 */
 	/*
 	 * We do not actually let the counter run. Leave it until start().
 	 */
-- 
2.7.4
