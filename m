Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933359AbeE2K4w (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:56:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37384 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933081AbeE2K4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:56:18 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will.deacon@arm.com,
        mark.rutland@arm.com, robin.murphy@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 5/5] arm64: perf: Add support for chaining event counters
Date: Tue, 29 May 2018 11:55:56 +0100
Message-Id: <1527591356-10934-6-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
References: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for 64bit event by using chained event counters
and 64bit cycle counters.

Arm v8 PMUv3 allows chaining a pair of adjacent PMU counters
(with the lower counter number being always "even"). The low
counter is programmed to count the event of interest and the
high counter(odd numbered) is programmed with a special event
code (0x1e - Chain). Thus we need special allocation schemes
to make the full use of available counters. So, we allocate the
counters from either ends. i.e, chained counters are allocated
from the lower end in pairs of two and the normal counters are
allocated from the higher number. Also makes necessary changes to
handle the chained events as a single event with 2 counters.

For CPU cycles, when 64bit mode is requested, the cycle counter
is used in 64bit mode. If the cycle counter is not available,
falls back to chaining.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V1:
 - Remove unnecessary isb()s
 - Fix event programming order for counters
 - Tighten chain coutner event read sequence
 - Set chain event to count in all ELs
 - Cleanup helpers to be consistent
 - Rename format to chain => bits64
 - Fix a counter allocation for single counters
 - Allow chaining on CPU cycle counters and do not promote
   the events to 64bit by default.
---
 arch/arm64/kernel/perf_event.c | 226 ++++++++++++++++++++++++++++++++++++-----
 drivers/perf/arm_pmu.c         |   6 ++
 2 files changed, 207 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 74d30d9..4f193e0 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -446,9 +446,16 @@ static struct attribute_group armv8_pmuv3_events_attr_group = {
 };
 
 PMU_FORMAT_ATTR(event, "config:0-15");
+PMU_FORMAT_ATTR(bits64, "config1:0");
+
+static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
+{
+	return event->attr.config1 & 0x1;
+}
 
 static struct attribute *armv8_pmuv3_format_attrs[] = {
 	&format_attr_event.attr,
+	&format_attr_bits64.attr,
 	NULL,
 };
 
@@ -466,6 +473,16 @@ static struct attribute_group armv8_pmuv3_format_attr_group = {
 	(ARMV8_IDX_CYCLE_COUNTER + cpu_pmu->num_events - 1)
 
 /*
+ * Use chained counter for a 64bit event, if we could not allocate
+ * the 64bit cycle counter.
+ */
+static inline bool armv8pmu_event_is_chained(struct perf_event *event)
+{
+	return armv8pmu_event_is_64bit(event) &&
+	       (event->hw.idx != ARMV8_IDX_CYCLE_COUNTER);
+}
+
+/*
  * ARMv8 low level PMU access
  */
 
@@ -512,24 +529,78 @@ static inline int armv8pmu_select_counter(int idx)
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
+	hi = armv8pmu_read_evcntr(idx);
+	do {
+		prev_hi = hi;
+		isb();
+		lo = armv8pmu_read_evcntr(idx - 1);
+		isb();
+		hi = armv8pmu_read_evcntr(idx);
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
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
-	u32 value = 0;
+	u64 value = 0;
 
 	if (!armv8pmu_counter_valid(cpu_pmu, idx))
 		pr_err("CPU%u reading wrong counter %d\n",
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
@@ -541,14 +612,14 @@ static inline void armv8pmu_write_counter(struct perf_event *event, u64 value)
 			smp_processor_id(), idx);
 	else if (idx == ARMV8_IDX_CYCLE_COUNTER) {
 		/*
-		 * Set the upper 32bits as this is a 64bit counter but we only
-		 * count using the lower 32bits and we want an interrupt when
-		 * it overflows.
+		 * Set the upper 32bits if we are counting this in
+		 * 32bit mode, as this is a 64bit counter.
 		 */
-		value |= 0xffffffff00000000ULL;
+		if (!armv8pmu_event_is_64bit(event))
+			value |= 0xffffffff00000000ULL;
 		write_sysreg(value, pmccntr_el0);
-	} else if (armv8pmu_select_counter(idx) == idx)
-		write_sysreg(value, pmxevcntr_el0);
+	} else
+		armv8pmu_write_hw_counter(event, value);
 }
 
 static inline void armv8pmu_write_evtype(int idx, u32 val)
@@ -559,6 +630,27 @@ static inline void armv8pmu_write_evtype(int idx, u32 val)
 	}
 }
 
+static inline void armv8pmu_write_event_type(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	/*
+	 * For chained events, write the the low counter event type
+	 * followed by the high counter. The high counter is programmed
+	 * with CHAIN event code with filters set to count at all ELs.
+	 */
+	if (armv8pmu_event_is_chained(event)) {
+		u32 chain_evt = ARMV8_PMUV3_PERFCTR_CHAIN |
+				ARMV8_PMU_INCLUDE_EL2;
+
+		armv8pmu_write_evtype(idx - 1, hwc->config_base);
+		isb();
+		armv8pmu_write_evtype(idx, chain_evt);
+	} else
+		armv8pmu_write_evtype(idx, hwc->config_base);
+}
+
 static inline int armv8pmu_enable_counter(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
@@ -566,6 +658,21 @@ static inline int armv8pmu_enable_counter(int idx)
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
+	if (armv8pmu_event_is_chained(event)) {
+		isb();
+		armv8pmu_enable_counter(idx - 1);
+	}
+}
+
 static inline int armv8pmu_disable_counter(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
@@ -573,6 +680,23 @@ static inline int armv8pmu_disable_counter(int idx)
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
 static inline int armv8pmu_enable_intens(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
@@ -580,6 +704,12 @@ static inline int armv8pmu_enable_intens(int idx)
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
@@ -592,6 +722,11 @@ static inline int armv8pmu_disable_intens(int idx)
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
@@ -609,10 +744,8 @@ static inline u32 armv8pmu_getreset_flags(void)
 static void armv8pmu_enable_event(struct perf_event *event)
 {
 	unsigned long flags;
-	struct hw_perf_event *hwc = &event->hw;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-	int idx = hwc->idx;
 
 	/*
 	 * Enable counter and interrupt, and set the counter to count
@@ -623,22 +756,22 @@ static void armv8pmu_enable_event(struct perf_event *event)
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
@@ -646,10 +779,8 @@ static void armv8pmu_enable_event(struct perf_event *event)
 static void armv8pmu_disable_event(struct perf_event *event)
 {
 	unsigned long flags;
-	struct hw_perf_event *hwc = &event->hw;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-	int idx = hwc->idx;
 
 	/*
 	 * Disable counter and interrupt
@@ -659,12 +790,12 @@ static void armv8pmu_disable_event(struct perf_event *event)
 	/*
 	 * Disable counter
 	 */
-	armv8pmu_disable_counter(idx);
+	armv8pmu_disable_event_counter(event);
 
 	/*
 	 * Disable interrupt for this counter
 	 */
-	armv8pmu_disable_intens(idx);
+	armv8pmu_disable_event_irq(event);
 
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
@@ -753,6 +884,39 @@ static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
+static int armv8pmu_get_single_idx(struct pmu_hw_events *cpuc,
+				    struct arm_pmu *cpu_pmu)
+{
+	int idx;
+
+	for (idx = cpu_pmu->num_events - 1; idx >= ARMV8_IDX_COUNTER0; --idx)
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
@@ -770,13 +934,21 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
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
+	int idx = event->hw.idx;
+
+	clear_bit(idx, cpuc->used_mask);
+	if (armv8pmu_event_is_chained(event))
+		clear_bit(idx - 1, cpuc->used_mask);
 }
 
 /*
@@ -851,6 +1023,9 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 				       &armv8_pmuv3_perf_cache_map,
 				       ARMV8_PMU_EVTYPE_EVENT);
 
+	if (armv8pmu_event_is_64bit(event))
+		event->hw.flags |= ARMPMU_EVT_64BIT;
+
 	/* Onl expose micro/arch events supported by this PMU */
 	if ((hw_event_id > 0) && (hw_event_id < ARMV8_PMUV3_MAX_COMMON_EVENTS)
 	    && test_bit(hw_event_id, armpmu->pmceid_bitmap)) {
@@ -957,6 +1132,7 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->read_counter		= armv8pmu_read_counter,
 	cpu_pmu->write_counter		= armv8pmu_write_counter,
 	cpu_pmu->get_event_idx		= armv8pmu_get_event_idx,
+	cpu_pmu->clear_event_idx	= armv8pmu_clear_event_idx,
 	cpu_pmu->start			= armv8pmu_start,
 	cpu_pmu->stop			= armv8pmu_stop,
 	cpu_pmu->reset			= armv8pmu_reset,
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 9ae7e68..b55382e 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -679,6 +679,12 @@ static void cpu_pm_pmu_setup(struct arm_pmu *armpmu, unsigned long cmd)
 			continue;
 
 		event = hw_events->events[idx];
+		/*
+		 * If there is no event at this idx (e.g, an idx used
+		 * by a chained event in Arm v8 PMUv3), skip it.
+		 */
+		if (!event)
+			continue;
 
 		switch (cmd) {
 		case CPU_PM_ENTER:
-- 
2.7.4
