Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeERKWu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:22:50 -0400
Received: from foss.arm.com ([217.140.101.70]:47394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752338AbeERKWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:22:40 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 6/6] arm64: perf: Add support for chaining counters
Date: Fri, 18 May 2018 11:22:23 +0100
Message-Id: <1526638943-2110-7-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526638943-2110-1-git-send-email-suzuki.poulose@arm.com>
References: <1526638943-2110-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for chained event counters. PMUv3 allows chaining
a pair of adjacent PMU counters (with the lower counter number
being always "even"). The low counter is programmed to count
the event of interest and the high counter(odd numbered) is
programmed with a special event code (0x1e - Chain). Thus
we need special allocation schemes to make the full use of
available counters. So, we allocate the counters from either
ends. i.e, chained counters are allocated from the lower
end in pairs of two and the normal counters are allocated
from the higher number. Also makes necessary changes to
handle the chained events as a single event with 2 counters.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/perf_event.c | 226 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 202 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index ea8e060..5f81cd0 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -446,9 +446,11 @@ static struct attribute_group armv8_pmuv3_events_attr_group = {
 };
 
 PMU_FORMAT_ATTR(event, "config:0-15");
+PMU_FORMAT_ATTR(chain, "config1:0");
 
 static struct attribute *armv8_pmuv3_format_attrs[] = {
 	&format_attr_event.attr,
+	&format_attr_chain.attr,
 	NULL,
 };
 
@@ -457,6 +459,12 @@ static struct attribute_group armv8_pmuv3_format_attr_group = {
 	.attrs = armv8_pmuv3_format_attrs,
 };
 
+static bool armv8pmu_event_is_chained(struct perf_event *event)
+{
+	return event->attr.config1 & 0x1;
+}
+
+
 /*
  * Perf Events' indices
  */
@@ -512,6 +520,36 @@ static inline int armv8pmu_select_counter(int idx)
 	return idx;
 }
 
+static inline u32 armv8pmu_read_evcntr(int idx)
+{
+	return (armv8pmu_select_counter(idx) == idx) ?
+	       read_sysreg(pmxevcntr_el0) : 0;
+}
+
+static inline u64 armv8pmu_read_chain_counter(int idx)
+{
+	u64 prev_hi, hi, lo;
+
+	do {
+		prev_hi = armv8pmu_read_evcntr(idx);
+		isb();
+		lo = armv8pmu_read_evcntr(idx - 1);
+		isb();
+		hi = armv8pmu_read_evcntr(idx);
+		isb();
+	} while (prev_hi != hi);
+
+	return (hi << 32) | lo;
+}
+
+static inline u64 armv8pmu_read_hw_counter(struct perf_event *event)
+{
+	int idx = event->hw.idx;
+
+	return armv8pmu_event_is_chained(event) ?
+	       armv8pmu_read_chain_counter(idx) : armv8pmu_read_evcntr(idx);
+}
+
 static inline u64 armv8pmu_read_counter(struct perf_event *event)
 {
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
@@ -524,12 +562,37 @@ static inline u64 armv8pmu_read_counter(struct perf_event *event)
 			smp_processor_id(), idx);
 	else if (idx == ARMV8_IDX_CYCLE_COUNTER)
 		value = read_sysreg(pmccntr_el0);
-	else if (armv8pmu_select_counter(idx) == idx)
-		value = read_sysreg(pmxevcntr_el0);
+	else
+		value = armv8pmu_read_hw_counter(event);
 
 	return value;
 }
 
+static inline void armv8pmu_write_evcntr(int idx, u32 value)
+{
+	if (armv8pmu_select_counter(idx) == idx)
+		write_sysreg(value, pmxevcntr_el0);
+}
+
+static inline void armv8pmu_write_chain_counter(int idx, u64 value)
+{
+	armv8pmu_write_evcntr(idx, value >> 32);
+	isb();
+	armv8pmu_write_evcntr(idx - 1, value);
+	isb();
+}
+
+static inline void armv8pmu_write_hw_counter(struct perf_event *event,
+					     u64 value)
+{
+	int idx = event->hw.idx;
+
+	if (armv8pmu_event_is_chained(event))
+		armv8pmu_write_chain_counter(idx, value);
+	else
+		armv8pmu_write_evcntr(idx, value);
+}
+
 static inline void armv8pmu_write_counter(struct perf_event *event, u64 value)
 {
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
@@ -541,8 +604,8 @@ static inline void armv8pmu_write_counter(struct perf_event *event, u64 value)
 			smp_processor_id(), idx);
 	else if (idx == ARMV8_IDX_CYCLE_COUNTER)
 		write_sysreg(value, pmccntr_el0);
-	else if (armv8pmu_select_counter(idx) == idx)
-		write_sysreg(value, pmxevcntr_el0);
+	else
+		armv8pmu_write_hw_counter(event, value);
 }
 
 static inline void armv8pmu_write_evtype(int idx, u32 val)
@@ -553,6 +616,28 @@ static inline void armv8pmu_write_evtype(int idx, u32 val)
 	}
 }
 
+static inline void armv8pmu_write_event_type(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	/*
+	 * For chained events, write the high counter event type
+	 * followed by the low counter.
+	 */
+	if (armv8pmu_event_is_chained(event)) {
+		u32 chain_evt = ARMV8_PMUV3_PERFCTR_CHAIN;
+
+		/* Set the filters as that of the main event for chain */
+		chain_evt |= hwc->config_base & ~ARMV8_PMU_EVTYPE_EVENT;
+		armv8pmu_write_evtype(idx, chain_evt);
+		isb();
+		idx--;
+	}
+
+	armv8pmu_write_evtype(idx, hwc->config_base);
+}
+
 static inline int armv8pmu_enable_counter(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
@@ -560,6 +645,23 @@ static inline int armv8pmu_enable_counter(int idx)
 	return idx;
 }
 
+static inline void armv8pmu_enable_event_counter(struct perf_event *event)
+{
+	int idx = event->hw.idx;
+
+	/*
+	 * For chained events, we enable the high counter followed by
+	 * the low counter.
+	 */
+	armv8pmu_enable_counter(idx);
+
+	if (armv8pmu_event_is_chained(event)) {
+		isb();
+		armv8pmu_enable_counter(idx - 1);
+	}
+
+}
+
 static inline int armv8pmu_disable_counter(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
@@ -567,6 +669,24 @@ static inline int armv8pmu_disable_counter(int idx)
 	return idx;
 }
 
+static inline void armv8pmu_disable_event_counter(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	/*
+	 * Disable the low counter followed by the high counter
+	 * for chained events.
+	 */
+	if (armv8pmu_event_is_chained(event)) {
+		armv8pmu_disable_counter(idx - 1);
+		isb();
+	}
+
+	armv8pmu_disable_counter(idx);
+}
+
+
 static inline int armv8pmu_enable_intens(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
@@ -574,6 +694,12 @@ static inline int armv8pmu_enable_intens(int idx)
 	return idx;
 }
 
+static inline int armv8pmu_enable_event_irq(struct perf_event *event)
+{
+	/* For chained events, enable the interrupt for only the high counter */
+	return armv8pmu_enable_intens(event->hw.idx);
+}
+
 static inline int armv8pmu_disable_intens(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
@@ -586,6 +712,11 @@ static inline int armv8pmu_disable_intens(int idx)
 	return idx;
 }
 
+static inline int armv8pmu_disable_event_irq(struct perf_event *event)
+{
+	return armv8pmu_disable_intens(event->hw.idx);
+}
+
 static inline u32 armv8pmu_getreset_flags(void)
 {
 	u32 value;
@@ -603,10 +734,8 @@ static inline u32 armv8pmu_getreset_flags(void)
 static void armv8pmu_enable_event(struct perf_event *event)
 {
 	unsigned long flags;
-	struct hw_perf_event *hwc = &event->hw;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-	int idx = hwc->idx;
 
 	/*
 	 * Enable counter and interrupt, and set the counter to count
@@ -617,22 +746,22 @@ static void armv8pmu_enable_event(struct perf_event *event)
 	/*
 	 * Disable counter
 	 */
-	armv8pmu_disable_counter(idx);
+	armv8pmu_disable_event_counter(event);
 
 	/*
 	 * Set event (if destined for PMNx counters).
 	 */
-	armv8pmu_write_evtype(idx, hwc->config_base);
+	armv8pmu_write_event_type(event);
 
 	/*
 	 * Enable interrupt for this counter
 	 */
-	armv8pmu_enable_intens(idx);
+	armv8pmu_enable_event_irq(event);
 
 	/*
 	 * Enable counter
 	 */
-	armv8pmu_enable_counter(idx);
+	armv8pmu_enable_event_counter(event);
 
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
@@ -640,10 +769,8 @@ static void armv8pmu_enable_event(struct perf_event *event)
 static void armv8pmu_disable_event(struct perf_event *event)
 {
 	unsigned long flags;
-	struct hw_perf_event *hwc = &event->hw;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-	int idx = hwc->idx;
 
 	/*
 	 * Disable counter and interrupt
@@ -651,14 +778,14 @@ static void armv8pmu_disable_event(struct perf_event *event)
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 
 	/*
-	 * Disable counter
+	 * Disable counter for this event
 	 */
-	armv8pmu_disable_counter(idx);
+	armv8pmu_disable_event_counter(event);
 
 	/*
-	 * Disable interrupt for this counter
+	 * Disable interrupt for this event counter
 	 */
-	armv8pmu_disable_intens(idx);
+	armv8pmu_disable_event_irq(event);
 
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
@@ -747,6 +874,39 @@ static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
+static int armv8pmu_get_single_idx(struct pmu_hw_events *cpuc,
+				    struct arm_pmu *cpu_pmu)
+{
+	int idx;
+
+	for (idx = cpu_pmu->num_events - 1; idx >= ARMV8_IDX_COUNTER0; ++idx)
+		if (!test_and_set_bit(idx, cpuc->used_mask))
+			return idx;
+	return -EAGAIN;
+}
+
+static int armv8pmu_get_chain_idx(struct pmu_hw_events *cpuc,
+				   struct arm_pmu *cpu_pmu)
+{
+	int idx;
+
+	/*
+	 * Chaining requires two consecutive event counters, where
+	 * the lower idx must be even. We allocate chain events
+	 * from the lower index (i.e, counter0) and the single events
+	 * from the higher end to maximise the utilisation.
+	 */
+	for (idx = ARMV8_IDX_COUNTER0 + 1; idx < cpu_pmu->num_events; idx += 2)
+		if (!test_and_set_bit(idx, cpuc->used_mask)) {
+			/* Check if the preceding even counter is available */
+			if (!test_and_set_bit(idx - 1, cpuc->used_mask))
+				return idx;
+			/* Release the Odd counter */
+			clear_bit(idx, cpuc->used_mask);
+		}
+	return -EAGAIN;
+}
+
 static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 				  struct perf_event *event)
 {
@@ -755,7 +915,10 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned long evtype = hwc->config_base & ARMV8_PMU_EVTYPE_EVENT;
 
-	/* Always prefer to place a cycle counter into the cycle counter. */
+	/*
+	 * Always prefer to place a cycle counter into the cycle counter
+	 * irrespective of whether we are counting 32bit/64bit
+	 */
 	if (evtype == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) {
 		if (!test_and_set_bit(ARMV8_IDX_CYCLE_COUNTER, cpuc->used_mask))
 			return ARMV8_IDX_CYCLE_COUNTER;
@@ -764,13 +927,21 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	/*
 	 * Otherwise use events counters
 	 */
-	for (idx = ARMV8_IDX_COUNTER0; idx < cpu_pmu->num_events; ++idx) {
-		if (!test_and_set_bit(idx, cpuc->used_mask))
-			return idx;
-	}
+	idx = armv8pmu_event_is_chained(event) ?
+		armv8pmu_get_chain_idx(cpuc, cpu_pmu) :
+		armv8pmu_get_single_idx(cpuc, cpu_pmu);
 
-	/* The counters are all in use. */
-	return -EAGAIN;
+	return idx;
+}
+
+static void armv8pmu_clear_event_idx(struct pmu_hw_events *cpuc,
+				     struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	clear_bit(hwc->idx, cpuc->used_mask);
+	if (armv8pmu_event_is_chained(event))
+		clear_bit(hwc->idx - 1, cpuc->used_mask);
 }
 
 /*
@@ -845,8 +1016,14 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 				       &armv8_pmuv3_perf_cache_map,
 				       ARMV8_PMU_EVTYPE_EVENT);
 
-	if (hw_event_id == ARMV8_PMUV3_PERFCTR_CPU_CYCLES)
+	if (hw_event_id == ARMV8_PMUV3_PERFCTR_CPU_CYCLES) {
+		/* Prevent chaining for cycle counter */
+		if (armv8pmu_event_is_chained(event))
+			return -EINVAL;
 		event->hw.flags |= ARMPMU_EVT_LONG;
+	} else if (armv8pmu_event_is_chained(event)) {
+		event->hw.flags |= ARMPMU_EVT_LONG;
+	}
 
 	/* Onl expose micro/arch events supported by this PMU */
 	if ((hw_event_id > 0) && (hw_event_id < ARMV8_PMUV3_MAX_COMMON_EVENTS)
@@ -954,6 +1131,7 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->read_counter		= armv8pmu_read_counter,
 	cpu_pmu->write_counter		= armv8pmu_write_counter,
 	cpu_pmu->get_event_idx		= armv8pmu_get_event_idx,
+	cpu_pmu->clear_event_idx	= armv8pmu_clear_event_idx,
 	cpu_pmu->start			= armv8pmu_start,
 	cpu_pmu->stop			= armv8pmu_stop,
 	cpu_pmu->reset			= armv8pmu_reset,
-- 
2.7.4
