Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752883AbeDLJjv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 05:39:51 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:43093 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeDLJjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 05:39:49 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v2 4/6] MIPS: perf: Allocate per-core counters on demand
Date: Thu, 12 Apr 2018 10:36:24 +0100
Message-ID: <1523525786-29153-5-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523525786-29153-1-git-send-email-matt.redfearn@mips.com>
References: <1523525786-29153-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1523525812-452060-21719-24429-7
X-BESS-VER: 2018.4.1-r1804052329
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 1.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191914
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        1.00 BSF_SC0_MV0713_2       META:  
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
        0.50 BSF_SC0_MV0713         META: Custom rule MV0713
X-BESS-Outbound-Spam-Status: SCORE=1.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MV0713_2, BSF_BESS_OUTBOUND, BSF_SC0_MV0713
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously when performance counters are per-core, rather than
per-thread, the number available were divided by 2 on detection, and the
counters used by each thread in a core were "swizzled" to ensure
separation. However, this solution is suboptimal since it relies on a
couple of assumptions:
a) Always having 2 VPEs / core (number of counters was divided by 2)
b) Always having a number of counters implemented in the core that is
   divisible by 2. For instance if an SoC implementation had a single
   counter and 2 VPEs per core, then this logic would fail and no
   performance counters would be available.
The mechanism also does not allow for one VPE in a core using more than
it's allocation of the per-core counters to count multiple events even
though other VPEs may not be using them.

Fix this situation by instead allocating (and releasing) per-core
performance counters when they are requested. This approach removes the
above assumptions and fixes the shortcomings.

In order to do this:
Add additional logic to mipsxx_pmu_alloc_counter() to detect if a
sibling is using a per-core counter, and to allocate a per-core counter
in all sibling CPUs.
Similarly, add a mipsxx_pmu_free_counter() function to release a
per-core counter in all sibling CPUs when it is finished with.
A new spinlock, core_counters_lock, is introduced to ensure exclusivity
when allocating and releasing per-core counters.
Since counters are now allocated per-core on demand, rather than being
reserved per-thread at boot, all of the "swizzling" of counters is
removed.

The upshot is that in an SoC with 2 counters / thread, counters are
reported as:
Performance counters: mips/interAptiv PMU enabled, 2 32-bit counters
available to each CPU, irq 18

Running an instance of a test program on each of 2 threads in a
core, both threads can use their 2 counters to count 2 events:

taskset 4 perf stat -e instructions:u,branches:u ./test_prog & taskset 8
perf stat -e instructions:u,branches:u ./test_prog

 Performance counter stats for './test_prog':

             30002      instructions:u
             10000      branches:u

       0.005164264 seconds time elapsed
 Performance counter stats for './test_prog':

             30002      instructions:u
             10000      branches:u

       0.006139975 seconds time elapsed

In an SoC with 2 counters / core (which can be forced by setting
cpu_has_mipsmt_pertccounters = 0), counters are reported as:
Performance counters: mips/interAptiv PMU enabled, 2 32-bit counters
available to each core, irq 18

Running an instance of a test program on each of 2 threads in a
core, now only one thread manages to secure the performance counters to
count 2 events. The other thread does not get any counters.

taskset 4 perf stat -e instructions:u,branches:u ./test_prog & taskset 8
perf stat -e instructions:u,branches:u ./test_prog

 Performance counter stats for './test_prog':

     <not counted>       instructions:u
     <not counted>       branches:u

       0.005179533 seconds time elapsed

 Performance counter stats for './test_prog':

             30002      instructions:u
             10000      branches:u

       0.005179467 seconds time elapsed

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

Changes in v2:
- Fix !#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS build
- re-use cpuc variable in mipsxx_pmu_alloc_counter,
  mipsxx_pmu_free_counter rather than having sibling_ version.

 arch/mips/kernel/perf_event_mipsxx.c | 127 +++++++++++++++++++++++------------
 1 file changed, 85 insertions(+), 42 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 0373087abee8..6c9b5d64a9ef 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -131,6 +131,8 @@ static struct mips_pmu mipspmu;
 #ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
 static int cpu_has_mipsmt_pertccounters;
 
+static DEFINE_SPINLOCK(core_counters_lock);
+
 static DEFINE_RWLOCK(pmuint_rwlock);
 
 #if defined(CONFIG_CPU_BMIPS5000)
@@ -141,20 +143,6 @@ static DEFINE_RWLOCK(pmuint_rwlock);
 			 0 : cpu_vpe_id(&current_cpu_data))
 #endif
 
-/* Copied from op_model_mipsxx.c */
-static unsigned int vpe_shift(void)
-{
-	if (num_possible_cpus() > 1)
-		return 1;
-
-	return 0;
-}
-
-static unsigned int counters_total_to_per_cpu(unsigned int counters)
-{
-	return counters >> vpe_shift();
-}
-
 #else /* !CONFIG_MIPS_PERF_SHARED_TC_COUNTERS */
 #define vpe_id()	0
 
@@ -165,17 +153,8 @@ static void pause_local_counters(void);
 static irqreturn_t mipsxx_pmu_handle_irq(int, void *);
 static int mipsxx_pmu_handle_shared_irq(void);
 
-static unsigned int mipsxx_pmu_swizzle_perf_idx(unsigned int idx)
-{
-	if (vpe_id() == 1)
-		idx = (idx + 2) & 3;
-	return idx;
-}
-
 static u64 mipsxx_pmu_read_counter(unsigned int idx)
 {
-	idx = mipsxx_pmu_swizzle_perf_idx(idx);
-
 	switch (idx) {
 	case 0:
 		/*
@@ -197,8 +176,6 @@ static u64 mipsxx_pmu_read_counter(unsigned int idx)
 
 static u64 mipsxx_pmu_read_counter_64(unsigned int idx)
 {
-	idx = mipsxx_pmu_swizzle_perf_idx(idx);
-
 	switch (idx) {
 	case 0:
 		return read_c0_perfcntr0_64();
@@ -216,8 +193,6 @@ static u64 mipsxx_pmu_read_counter_64(unsigned int idx)
 
 static void mipsxx_pmu_write_counter(unsigned int idx, u64 val)
 {
-	idx = mipsxx_pmu_swizzle_perf_idx(idx);
-
 	switch (idx) {
 	case 0:
 		write_c0_perfcntr0(val);
@@ -236,8 +211,6 @@ static void mipsxx_pmu_write_counter(unsigned int idx, u64 val)
 
 static void mipsxx_pmu_write_counter_64(unsigned int idx, u64 val)
 {
-	idx = mipsxx_pmu_swizzle_perf_idx(idx);
-
 	switch (idx) {
 	case 0:
 		write_c0_perfcntr0_64(val);
@@ -256,8 +229,6 @@ static void mipsxx_pmu_write_counter_64(unsigned int idx, u64 val)
 
 static unsigned int mipsxx_pmu_read_control(unsigned int idx)
 {
-	idx = mipsxx_pmu_swizzle_perf_idx(idx);
-
 	switch (idx) {
 	case 0:
 		return read_c0_perfctrl0();
@@ -275,8 +246,6 @@ static unsigned int mipsxx_pmu_read_control(unsigned int idx)
 
 static void mipsxx_pmu_write_control(unsigned int idx, unsigned int val)
 {
-	idx = mipsxx_pmu_swizzle_perf_idx(idx);
-
 	switch (idx) {
 	case 0:
 		write_c0_perfctrl0(val);
@@ -296,7 +265,7 @@ static void mipsxx_pmu_write_control(unsigned int idx, unsigned int val)
 static int mipsxx_pmu_alloc_counter(struct cpu_hw_events *cpuc,
 				    struct hw_perf_event *hwc)
 {
-	int i;
+	int i, cpu = smp_processor_id();
 
 	/*
 	 * We only need to care the counter mask. The range has been
@@ -315,14 +284,85 @@ static int mipsxx_pmu_alloc_counter(struct cpu_hw_events *cpuc,
 		 * they can be dynamically swapped, they both feel happy.
 		 * But here we leave this issue alone for now.
 		 */
-		if (test_bit(i, &cntr_mask) &&
-			!test_and_set_bit(i, cpuc->used_mask))
+		if (!test_bit(i, &cntr_mask))
+			continue;
+
+#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
+		/*
+		 * When counters are per-core, check for use and allocate
+		 * them in all sibling CPUs.
+		 */
+		if (!cpu_has_mipsmt_pertccounters) {
+			int sibling_cpu, allocated = 0;
+			unsigned long flags;
+
+			spin_lock_irqsave(&core_counters_lock, flags);
+
+			for_each_cpu(sibling_cpu, &cpu_sibling_map[cpu]) {
+				cpuc = per_cpu_ptr(&cpu_hw_events, sibling_cpu);
+
+				if (test_bit(i, cpuc->used_mask)) {
+					pr_debug("CPU%d already using core counter %d\n",
+						 sibling_cpu, i);
+					goto next_counter;
+				}
+			}
+
+			/* Counter i is not used by any siblings - use it */
+			allocated = 1;
+			for_each_cpu(sibling_cpu, &cpu_sibling_map[cpu]) {
+				cpuc = per_cpu_ptr(&cpu_hw_events, sibling_cpu);
+
+				set_bit(i, cpuc->used_mask);
+				/* sibling is using the counter */
+				pr_debug("CPU%d now using core counter %d\n",
+					 sibling_cpu, i);
+			}
+next_counter:
+			spin_unlock_irqrestore(&core_counters_lock, flags);
+			if (allocated)
+				return i;
+		}
+		else
+#endif
+		if (!test_and_set_bit(i, cpuc->used_mask)) {
+			pr_debug("CPU%d now using counter %d\n", cpu, i);
 			return i;
+		}
 	}
 
 	return -EAGAIN;
 }
 
+static void mipsxx_pmu_free_counter(struct cpu_hw_events *cpuc,
+				    struct hw_perf_event *hwc)
+{
+	int cpu = smp_processor_id();
+
+#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
+	/* When counters are per-core, free them in all sibling CPUs */
+	if (!cpu_has_mipsmt_pertccounters) {
+		unsigned long flags;
+		int sibling_cpu;
+
+		spin_lock_irqsave(&core_counters_lock, flags);
+
+		for_each_cpu(sibling_cpu, &cpu_sibling_map[cpu]) {
+			cpuc = per_cpu_ptr(&cpu_hw_events, sibling_cpu);
+
+			clear_bit(hwc->idx, cpuc->used_mask);
+			pr_debug("CPU%d released core counter %d\n",
+				 sibling_cpu, hwc->idx);
+		}
+
+		spin_unlock_irqrestore(&core_counters_lock, flags);
+		return;
+	}
+#endif
+	pr_debug("CPU%d released counter %d\n", cpu, hwc->idx);
+	clear_bit(hwc->idx, cpuc->used_mask);
+}
+
 static void mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
 {
 	struct perf_event *event = container_of(evt, struct perf_event, hw);
@@ -519,7 +559,7 @@ static void mipspmu_del(struct perf_event *event, int flags)
 
 	mipspmu_stop(event, PERF_EF_UPDATE);
 	cpuc->events[idx] = NULL;
-	clear_bit(idx, cpuc->used_mask);
+	mipsxx_pmu_free_counter(cpuc, hwc);
 
 	perf_event_update_userpage(event);
 }
@@ -1743,8 +1783,6 @@ init_hw_perf_events(void)
 
 #ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
 	cpu_has_mipsmt_pertccounters = probe_mipsmt_pertccounters();
-	if (!cpu_has_mipsmt_pertccounters)
-		counters = counters_total_to_per_cpu(counters);
 #endif
 
 	if (get_c0_perfcount_int)
@@ -1868,9 +1906,14 @@ init_hw_perf_events(void)
 
 	on_each_cpu(reset_counters, (void *)(long)counters, 1);
 
-	pr_cont("%s PMU enabled, %d %d-bit counters available to each "
-		"CPU, irq %d%s\n", mipspmu.name, counters, counter_bits, irq,
-		irq < 0 ? " (share with timer interrupt)" : "");
+	pr_cont("%s PMU enabled, %d %d-bit counters available to each %s, irq %d%s\n",
+		mipspmu.name, counters, counter_bits,
+#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
+		cpu_has_mipsmt_pertccounters ? "CPU" : "core",
+#else
+		"CPU",
+#endif
+		irq, irq < 0 ? " (share with timer interrupt)" : "");
 
 	perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
 
-- 
2.7.4
