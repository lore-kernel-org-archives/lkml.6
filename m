Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932204AbeDCMgt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:36:49 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:54564 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932104AbeDCMgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:36:48 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 5/5] MIPS: perf: Fold vpe_id() macro into it's one last usage
Date: Tue, 3 Apr 2018 13:31:31 +0100
Message-ID: <1522758691-17003-6-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522758691-17003-1-git-send-email-matt.redfearn@mips.com>
References: <1522758691-17003-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1522758877-452060-29530-51002-9
X-BESS-VER: 2018.4.1-r1803302241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191653
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vpe_id() macro is now used only in mipsxx_pmu_enable_event when
CONFIG_CPU_BMIPS5000 is defined. Fold the one used definition of the
macro into it's usage and remove the now unused definitions.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/kernel/perf_event_mipsxx.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index bedb0d5ff3f2..44b9090a53cc 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -134,18 +134,6 @@ static int cpu_has_mipsmt_pertccounters;
 static DEFINE_SPINLOCK(core_counters_lock);
 
 static DEFINE_RWLOCK(pmuint_rwlock);
-
-#if defined(CONFIG_CPU_BMIPS5000)
-#define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
-			 0 : (smp_processor_id() & MIPS_CPUID_TO_COUNTER_MASK))
-#else
-#define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
-			 0 : cpu_vpe_id(&current_cpu_data))
-#endif
-
-#else /* !CONFIG_MIPS_PERF_SHARED_TC_COUNTERS */
-#define vpe_id()	0
-
 #endif /* CONFIG_MIPS_PERF_SHARED_TC_COUNTERS */
 
 static void resume_local_counters(void);
@@ -381,8 +369,10 @@ static void mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
 
 	if (IS_ENABLED(CONFIG_CPU_BMIPS5000)) {
 		/* enable the counter for the calling thread */
-		cpuc->saved_ctrl[idx] |=
-			(1 << (12 + vpe_id())) | BRCM_PERFCTRL_TC;
+		unsigned int vpe_id = cpu_has_mipsmt_pertccounters ? 0 :
+			(smp_processor_id() & MIPS_CPUID_TO_COUNTER_MASK);
+
+		cpuc->saved_ctrl[idx] |= BIT(12 + vpe_id) | BRCM_PERFCTRL_TC;
 	} else if (range > V) {
 		/* The counter is processor wide. Set it up to count all TCs. */
 		pr_debug("Enabling perf counter for all TCs\n");
-- 
2.7.4
