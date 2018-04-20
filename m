Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754625AbeDTK0d (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:26:33 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:58756 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754458AbeDTK0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:26:32 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v3 4/7] MIPS: perf: Fix perf with MT counting other threads
Date: Fri, 20 Apr 2018 11:23:06 +0100
Message-ID: <1524219789-31241-5-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524219789-31241-1-git-send-email-matt.redfearn@mips.com>
References: <1524219789-31241-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1524219945-321457-10557-42113-3
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

When perf is used in non-system mode, i.e. without specifying CPUs to
count on, check_and_calc_range falls into the case when it sets
M_TC_EN_ALL in the counter config_base. This has the impact of always
counting for all of the threads in a core, even when the user has not
requested it. For example this can be seen with a test program which
executes 30002 instructions and 10000 branches running on one VPE and a
busy load on the other VPE in the core. Without this commit, the
expected count is not returned:

taskset 4 dd if=/dev/zero of=/dev/null count=100000 & taskset 8 perf
stat -e instructions:u,branches:u ./test_prog

 Performance counter stats for './test_prog':

            103235      instructions:u
             17015      branches:u

In order to fix this, remove check_and_calc_range entirely and perform
all of the logic in mipsxx_pmu_enable_event. Since
mipsxx_pmu_enable_event now requires the range of the event, ensure that
it is set by mipspmu_perf_event_encode in the same circumstances as
before (i.e. #ifdef CONFIG_MIPS_MT_SMP && num_possible_cpus() > 1).

The logic of mipsxx_pmu_enable_event now becomes:
If the CPU is a BMIPS5000, then use the special vpe_id() implementation
to select which VPE to count.
If the counter has a range greater than a single VPE, i.e. it is a
core-wide counter, then ensure that the counter is set up to count
events from all TCs (though, since this is true by definition, is this
necessary? Just enabling a core-wide counter in the per-VPE case appears
experimentally to return the same counts. This is left in for now as the
logic was present before).
If the event is set up to count a particular CPU (i.e. system mode),
then the VPE ID of that CPU is used for the counter.
Otherwise, the event should be counted on the CPU scheduling this thread
(this was the critical bit missing from the previous implementation) so
the VPE ID of this CPU is used for the counter.

With this commit, the same test as before returns the counts expected:

taskset 4 dd if=/dev/zero of=/dev/null count=100000 & taskset 8 perf
stat -e instructions:u,branches:u ./test_prog

 Performance counter stats for './test_prog':

             30002      instructions:u
             10000      branches:u

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---

Changes in v3: None
Changes in v2:
Fix mipsxx_pmu_enable_event for !#ifdef CONFIG_MIPS_MT_SMP

 arch/mips/kernel/perf_event_mipsxx.c | 78 ++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 7e2b7d38a774..fe50986e83c6 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -323,7 +323,11 @@ static int mipsxx_pmu_alloc_counter(struct cpu_hw_events *cpuc,
 
 static void mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
 {
+	struct perf_event *event = container_of(evt, struct perf_event, hw);
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+#ifdef CONFIG_MIPS_MT_SMP
+	unsigned int range = evt->event_base >> 24;
+#endif /* CONFIG_MIPS_MT_SMP */
 
 	WARN_ON(idx < 0 || idx >= mipspmu.num_counters);
 
@@ -331,11 +335,37 @@ static void mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
 		(evt->config_base & M_PERFCTL_CONFIG_MASK) |
 		/* Make sure interrupt enabled. */
 		MIPS_PERFCTRL_IE;
-	if (IS_ENABLED(CONFIG_CPU_BMIPS5000))
+
+#ifdef CONFIG_CPU_BMIPS5000
+	{
 		/* enable the counter for the calling thread */
 		cpuc->saved_ctrl[idx] |=
 			(1 << (12 + vpe_id())) | BRCM_PERFCTRL_TC;
+	}
+#else
+#ifdef CONFIG_MIPS_MT_SMP
+	if (range > V) {
+		/* The counter is processor wide. Set it up to count all TCs. */
+		pr_debug("Enabling perf counter for all TCs\n");
+		cpuc->saved_ctrl[idx] |= M_TC_EN_ALL;
+	} else
+#endif /* CONFIG_MIPS_MT_SMP */
+	{
+		unsigned int cpu, ctrl;
 
+		/*
+		 * Set up the counter for a particular CPU when event->cpu is
+		 * a valid CPU number. Otherwise set up the counter for the CPU
+		 * scheduling this thread.
+		 */
+		cpu = (event->cpu >= 0) ? event->cpu : smp_processor_id();
+
+		ctrl = M_PERFCTL_VPEID(cpu_vpe_id(&cpu_data[cpu]));
+		ctrl |= M_TC_EN_VPE;
+		cpuc->saved_ctrl[idx] |= ctrl;
+		pr_debug("Enabling perf counter for CPU%d\n", cpu);
+	}
+#endif /* CONFIG_CPU_BMIPS5000 */
 	/*
 	 * We do not actually let the counter run. Leave it until start().
 	 */
@@ -649,13 +679,14 @@ static unsigned int mipspmu_perf_event_encode(const struct mips_perf_event *pev)
  * event_id.
  */
 #ifdef CONFIG_MIPS_MT_SMP
-	return ((unsigned int)pev->range << 24) |
-		(pev->cntr_mask & 0xffff00) |
-		(pev->event_id & 0xff);
-#else
-	return (pev->cntr_mask & 0xffff00) |
-		(pev->event_id & 0xff);
-#endif
+	if (num_possible_cpus() > 1)
+		return ((unsigned int)pev->range << 24) |
+			(pev->cntr_mask & 0xffff00) |
+			(pev->event_id & 0xff);
+	else
+#endif /* CONFIG_MIPS_MT_SMP */
+		return ((pev->cntr_mask & 0xffff00) |
+			(pev->event_id & 0xff));
 }
 
 static const struct mips_perf_event *mipspmu_map_general_event(int idx)
@@ -1259,33 +1290,6 @@ static const struct mips_perf_event xlp_cache_map
 },
 };
 
-#ifdef CONFIG_MIPS_MT_SMP
-static void check_and_calc_range(struct perf_event *event,
-				 const struct mips_perf_event *pev)
-{
-	struct hw_perf_event *hwc = &event->hw;
-
-	if (event->cpu >= 0) {
-		if (pev->range > V) {
-			/*
-			 * The user selected an event that is processor
-			 * wide, while expecting it to be VPE wide.
-			 */
-			hwc->config_base |= M_TC_EN_ALL;
-		} else {
-			hwc->config_base |= M_PERFCTL_VPEID(vpe_id());
-			hwc->config_base |= M_TC_EN_VPE;
-		}
-	} else
-		hwc->config_base |= M_TC_EN_ALL;
-}
-#else
-static void check_and_calc_range(struct perf_event *event,
-				 const struct mips_perf_event *pev)
-{
-}
-#endif
-
 static int __hw_perf_event_init(struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
@@ -1321,10 +1325,6 @@ static int __hw_perf_event_init(struct perf_event *event)
 	 */
 	hwc->config_base = MIPS_PERFCTRL_IE;
 
-	/* Calculate range bits and validate it. */
-	if (num_possible_cpus() > 1)
-		check_and_calc_range(event, pev);
-
 	hwc->event_base = mipspmu_perf_event_encode(pev);
 	if (PERF_TYPE_RAW == event->attr.type)
 		mutex_unlock(&raw_event_mutex);
-- 
2.7.4
