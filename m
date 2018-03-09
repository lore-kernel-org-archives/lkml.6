Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbeCICQw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:16:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:11779 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751025AbeCICQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:16:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,443,1515484800";
   d="scan'208";a="23704415"
From: kan.liang@linux.intel.com
To: peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com,
        vincent.weaver@maine.edu, jolsa@redhat.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/4] perf/x86/intel/ds: Handle PEBS overflow for fixed counters
Date: Thu,  8 Mar 2018 18:15:41 -0800
Message-Id: <20180309021542.11374-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180309021542.11374-1-kan.liang@linux.intel.com>
References: <20180309021542.11374-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The pebs_drain() need to support fixed counters. The DS Save Area now
include "counter reset value" fields for each fixed counters.

Extend the related variables (e.g. mask, counters, error) to support
fixed counters. There is no extended PEBS in PEBS v2 and earlier PEBS
format. Only need to change the code for PEBS v3 and later PEBS format.

Extend the pebs_event_reset to support new "counter reset value" fields.

Increase the reserve space for fixed counters.

Based-on-code-from: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c    |  5 ++++-
 arch/x86/events/intel/ds.c      | 36 +++++++++++++++++++++++++++---------
 arch/x86/events/perf_event.h    |  3 +++
 arch/x86/include/asm/intel_ds.h |  3 ++-
 4 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ef47a418d819..86149b87cce8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2280,7 +2280,10 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	 * counters from the GLOBAL_STATUS mask and we always process PEBS
 	 * events via drain_pebs().
 	 */
-	status &= ~(cpuc->pebs_enabled & PEBS_COUNTER_MASK);
+	if (x86_pmu.flags & PMU_FL_PEBS_ALL)
+		status &= ~(cpuc->pebs_enabled & EXTENDED_PEBS_COUNTER_MASK);
+	else
+		status &= ~(cpuc->pebs_enabled & PEBS_COUNTER_MASK);
 
 	/*
 	 * PEBS overflow sets bit 62 in the global status register
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 4fa43f65835e..48b31319e401 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -901,10 +901,16 @@ static inline void pebs_update_threshold(struct cpu_hw_events *cpuc)
 {
 	struct debug_store *ds = cpuc->ds;
 	u64 threshold;
+	int reserved;
+
+	if (x86_pmu.flags & PMU_FL_PEBS_ALL)
+		reserved = x86_pmu.max_pebs_events + x86_pmu.num_counters_fixed;
+	else
+		reserved = x86_pmu.max_pebs_events;
 
 	if (cpuc->n_pebs == cpuc->n_large_pebs) {
 		threshold = ds->pebs_absolute_maximum -
-			x86_pmu.max_pebs_events * x86_pmu.pebs_record_size;
+			reserved * x86_pmu.pebs_record_size;
 	} else {
 		threshold = ds->pebs_buffer_base + x86_pmu.pebs_record_size;
 	}
@@ -968,7 +974,11 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 	 * This must be done in pmu::start(), because PERF_EVENT_IOC_PERIOD.
 	 */
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
-		ds->pebs_event_reset[hwc->idx] =
+		unsigned int idx = hwc->idx;
+
+		if (idx >= INTEL_PMC_IDX_FIXED)
+			idx = MAX_PEBS_EVENTS + (idx - INTEL_PMC_IDX_FIXED);
+		ds->pebs_event_reset[idx] =
 			(u64)(-hwc->sample_period) & x86_pmu.cntval_mask;
 	} else {
 		ds->pebs_event_reset[hwc->idx] = 0;
@@ -1466,9 +1476,10 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
 	struct debug_store *ds = cpuc->ds;
 	struct perf_event *event;
 	void *base, *at, *top;
-	short counts[MAX_PEBS_EVENTS] = {};
-	short error[MAX_PEBS_EVENTS] = {};
-	int bit, i;
+	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
+	short error[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
+	int bit, i, size;
+	u64 mask;
 
 	if (!x86_pmu.pebs_active)
 		return;
@@ -1478,6 +1489,13 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
 
 	ds->pebs_index = ds->pebs_buffer_base;
 
+	mask = (1ULL << x86_pmu.max_pebs_events) - 1;
+	size = x86_pmu.max_pebs_events;
+	if (x86_pmu.flags & PMU_FL_PEBS_ALL) {
+		mask |= ((1ULL << x86_pmu.num_counters_fixed) - 1) << INTEL_PMC_IDX_FIXED;
+		size = INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed;
+	}
+
 	if (unlikely(base >= top)) {
 		/*
 		 * The drain_pebs() could be called twice in a short period
@@ -1487,7 +1505,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
 		 * update the event->count for this case.
 		 */
 		for_each_set_bit(bit, (unsigned long *)&cpuc->pebs_enabled,
-				 x86_pmu.max_pebs_events) {
+				 size) {
 			event = cpuc->events[bit];
 			if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
 				intel_pmu_save_and_restart_reload(event, 0);
@@ -1500,12 +1518,12 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
 		u64 pebs_status;
 
 		pebs_status = p->status & cpuc->pebs_enabled;
-		pebs_status &= (1ULL << x86_pmu.max_pebs_events) - 1;
+		pebs_status &= mask;
 
 		/* PEBS v3 has more accurate status bits */
 		if (x86_pmu.intel_cap.pebs_format >= 3) {
 			for_each_set_bit(bit, (unsigned long *)&pebs_status,
-					 x86_pmu.max_pebs_events)
+					 size)
 				counts[bit]++;
 
 			continue;
@@ -1553,7 +1571,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
 		counts[bit]++;
 	}
 
-	for (bit = 0; bit < x86_pmu.max_pebs_events; bit++) {
+	for (bit = 0; bit < size; bit++) {
 		if ((counts[bit] == 0) && (error[bit] == 0))
 			continue;
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 598892e001b5..b4564c01f394 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -80,6 +80,9 @@ struct amd_nb {
 };
 
 #define PEBS_COUNTER_MASK	((1ULL << MAX_PEBS_EVENTS) - 1)
+#define EXTENDED_PEBS_COUNTER_MASK	\
+	(PEBS_COUNTER_MASK |		\
+	(((1ULL << MAX_FIXED_PEBS_EVENTS) - 1) << INTEL_PMC_IDX_FIXED))
 
 /*
  * Flags PEBS can handle without an PMI.
diff --git a/arch/x86/include/asm/intel_ds.h b/arch/x86/include/asm/intel_ds.h
index 62a9f4966b42..ae26df1c2789 100644
--- a/arch/x86/include/asm/intel_ds.h
+++ b/arch/x86/include/asm/intel_ds.h
@@ -8,6 +8,7 @@
 
 /* The maximal number of PEBS events: */
 #define MAX_PEBS_EVENTS		8
+#define MAX_FIXED_PEBS_EVENTS	3
 
 /*
  * A debug store configuration.
@@ -23,7 +24,7 @@ struct debug_store {
 	u64	pebs_index;
 	u64	pebs_absolute_maximum;
 	u64	pebs_interrupt_threshold;
-	u64	pebs_event_reset[MAX_PEBS_EVENTS];
+	u64	pebs_event_reset[MAX_PEBS_EVENTS + MAX_FIXED_PEBS_EVENTS];
 } __aligned(PAGE_SIZE);
 
 DECLARE_PER_CPU_PAGE_ALIGNED(struct debug_store, cpu_debug_store);
-- 
2.14.3
