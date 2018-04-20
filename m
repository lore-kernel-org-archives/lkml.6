Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754682AbeDTK1W (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:27:22 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:54569 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754458AbeDTK1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:27:20 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v3 6/7] MIPS: perf: Fold vpe_id() macro into it's one last usage
Date: Fri, 20 Apr 2018 11:23:08 +0100
Message-ID: <1524219789-31241-7-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524219789-31241-1-git-send-email-matt.redfearn@mips.com>
References: <1524219789-31241-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1524219945-321457-10557-42113-5
X-BESS-VER: 2018.5-r1804181636
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192194
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vpe_id() macro is now used only in mipsxx_pmu_enable_event when
CONFIG_CPU_BMIPS5000 is defined. Fold the one used definition of the
macro into it's usage and remove the now unused definitions.

Since we know that cpu_has_mipsmt_pertccounters == 0 on BMIPS5000,
remove the test on it and just set the counter to count the relevant
VPE.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---

Changes in v3: None
Changes in v2:
Since BMIPS5000 does not implement per TC counters, we can remove the
check on cpu_has_mipsmt_pertccounters.

 arch/mips/kernel/perf_event_mipsxx.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index a07777aa1b79..5b8811643e60 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -132,18 +132,6 @@ static struct mips_pmu mipspmu;
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
@@ -379,8 +367,10 @@ static void mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
 #ifdef CONFIG_CPU_BMIPS5000
 	{
 		/* enable the counter for the calling thread */
-		cpuc->saved_ctrl[idx] |=
-			(1 << (12 + vpe_id())) | BRCM_PERFCTRL_TC;
+		unsigned int vpe_id;
+
+		vpe_id = smp_processor_id() & MIPS_CPUID_TO_COUNTER_MASK;
+		cpuc->saved_ctrl[idx] |= BIT(12 + vpe_id) | BRCM_PERFCTRL_TC;
 	}
 #else
 #ifdef CONFIG_MIPS_MT_SMP
-- 
2.7.4
