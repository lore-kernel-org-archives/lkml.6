Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AD0C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F44420836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F44420836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937602AbeFSKQ3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:16:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46654 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937541AbeFSKQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:16:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BE691684;
        Tue, 19 Jun 2018 03:16:17 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 386063F25D;
        Tue, 19 Jun 2018 03:16:16 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, robin.murphy@arm.com, julien.thierry@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 7/7] arm64: perf: Add support for chaining event counters
Date:   Tue, 19 Jun 2018 11:15:42 +0100
Message-Id: <1529403342-17899-8-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529403342-17899-1-git-send-email-suzuki.poulose@arm.com>
References: <1529403342-17899-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for 64bit event by using chained event counters
and 64bit cycle counters.

PMUv3 allows chaining a pair of adjacent 32-bit counters, effectively
forming a 64-bit counter. The low/even counter is programmed to count
the event of interest, and the high/odd counter is programmed to count
the CHAIN event, taken when the low/even counter overflows.

For CPU cycles, when 64bit mode is requested, the cycle counter
is used in 64bit mode. If the cycle counter is not available,
falls back to chaining.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes sinec v2:
 - Drop special allocation algorithm for chain indices
 - Since we access the counters when the PMU is stopped,
   get rid of the unncessary barriers.
 - Ensure a counter is allocated when checking for chained event
---
 arch/arm64/kernel/perf_event.c | 184 ++++++++++++++++++++++++++++++++++++-----
 drivers/perf/arm_pmu.c         |  13 ++-
 2 files changed, 169 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index eebc635..a03def7 100644
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
 
@@ -466,6 +473,20 @@ static struct attribute_group armv8_pmuv3_format_attr_group = {
 	(ARMV8_IDX_CYCLE_COUNTER + cpu_pmu->num_events - 1)
 
 /*
+ * Use chained counter for a 64bit event, if we could not allocate
+ * the 64bit cycle counter. This must be called after a counter
+ * was allocated.
+ */
+static inline bool armv8pmu_event_is_chained(struct perf_event *event)
+{
+	int idx = event->hw.idx;
+
+	return !WARN_ON(idx < 0) &&
+	       armv8pmu_event_is_64bit(event) &&
+	       (event->hw.idx != ARMV8_IDX_CYCLE_COUNTER);
+}
+
+/*
  * ARMv8 low level PMU access
  */
 
@@ -516,12 +537,28 @@ static inline u32 armv8pmu_read_evcntr(int idx)
 	return read_sysreg(pmxevcntr_el0);
 }
 
+static inline u64 armv8pmu_read_hw_counter(struct perf_event *event)
+{
+	int idx = event->hw.idx;
+	u64 val = 0;
+
+	val = armv8pmu_read_evcntr(idx);
+	/*
+	 * We always read the counter with the PMU turned off.
+	 * So we don't need special care for reading chained
+	 * counters.
+	 */
+	if (armv8pmu_event_is_chained(event))
+		val = (val << 32) | armv8pmu_read_evcntr(idx - 1);
+	return val;
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
@@ -529,7 +566,7 @@ static inline u64 armv8pmu_read_counter(struct perf_event *event)
 	else if (idx == ARMV8_IDX_CYCLE_COUNTER)
 		value = read_sysreg(pmccntr_el0);
 	else
-		value = armv8pmu_read_evcntr(idx);
+		value = armv8pmu_read_hw_counter(event);
 
 	return value;
 }
@@ -540,6 +577,19 @@ static inline void armv8pmu_write_evcntr(int idx, u32 value)
 	write_sysreg(value, pmxevcntr_el0);
 }
 
+static inline void armv8pmu_write_hw_counter(struct perf_event *event,
+					     u64 value)
+{
+	int idx = event->hw.idx;
+
+	if (armv8pmu_event_is_chained(event)) {
+		armv8pmu_write_evcntr(idx, upper_32_bits(value));
+		armv8pmu_write_evcntr(idx - 1, lower_32_bits(value));
+	} else {
+		armv8pmu_write_evcntr(idx, value);
+	}
+}
+
 static inline void armv8pmu_write_counter(struct perf_event *event, u64 value)
 {
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
@@ -551,14 +601,15 @@ static inline void armv8pmu_write_counter(struct perf_event *event, u64 value)
 			smp_processor_id(), idx);
 	else if (idx == ARMV8_IDX_CYCLE_COUNTER) {
 		/*
-		 * Set the upper 32bits as this is a 64bit counter but we only
+		 * Set the upper 32bits as this is a 64bit counter, if we only
 		 * count using the lower 32bits and we want an interrupt when
 		 * it overflows.
 		 */
-		value |= 0xffffffff00000000ULL;
+		if (!armv8pmu_event_is_64bit(event))
+			value |= 0xffffffff00000000ULL;
 		write_sysreg(value, pmccntr_el0);
 	} else
-		armv8pmu_write_evcntr(idx, value);
+		armv8pmu_write_hw_counter(event, value);
 }
 
 static inline void armv8pmu_write_evtype(int idx, u32 val)
@@ -568,6 +619,27 @@ static inline void armv8pmu_write_evtype(int idx, u32 val)
 	write_sysreg(val, pmxevtyper_el0);
 }
 
+static inline void armv8pmu_write_event_type(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	/*
+	 * For chained events, the low counter is programmed to count
+	 * the event of interest and the high counter is programmed
+	 * with CHAIN event code with filters set to count at all ELs.
+	 */
+	if (armv8pmu_event_is_chained(event)) {
+		u32 chain_evt = ARMV8_PMUV3_PERFCTR_CHAIN |
+				ARMV8_PMU_INCLUDE_EL2;
+
+		armv8pmu_write_evtype(idx - 1, hwc->config_base);
+		armv8pmu_write_evtype(idx, chain_evt);
+	} else {
+		armv8pmu_write_evtype(idx, hwc->config_base);
+	}
+}
+
 static inline int armv8pmu_enable_counter(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
@@ -575,6 +647,16 @@ static inline int armv8pmu_enable_counter(int idx)
 	return idx;
 }
 
+static inline void armv8pmu_enable_event_counter(struct perf_event *event)
+{
+	int idx = event->hw.idx;
+
+	armv8pmu_enable_counter(idx);
+	if (armv8pmu_event_is_chained(event))
+		armv8pmu_enable_counter(idx - 1);
+	isb();
+}
+
 static inline int armv8pmu_disable_counter(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
@@ -582,6 +664,16 @@ static inline int armv8pmu_disable_counter(int idx)
 	return idx;
 }
 
+static inline void armv8pmu_disable_event_counter(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	if (armv8pmu_event_is_chained(event))
+		armv8pmu_disable_counter(idx - 1);
+	armv8pmu_disable_counter(idx);
+}
+
 static inline int armv8pmu_enable_intens(int idx)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
@@ -589,6 +681,12 @@ static inline int armv8pmu_enable_intens(int idx)
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
@@ -601,6 +699,11 @@ static inline int armv8pmu_disable_intens(int idx)
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
@@ -618,10 +721,8 @@ static inline u32 armv8pmu_getreset_flags(void)
 static void armv8pmu_enable_event(struct perf_event *event)
 {
 	unsigned long flags;
-	struct hw_perf_event *hwc = &event->hw;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-	int idx = hwc->idx;
 
 	/*
 	 * Enable counter and interrupt, and set the counter to count
@@ -632,22 +733,22 @@ static void armv8pmu_enable_event(struct perf_event *event)
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
@@ -655,10 +756,8 @@ static void armv8pmu_enable_event(struct perf_event *event)
 static void armv8pmu_disable_event(struct perf_event *event)
 {
 	unsigned long flags;
-	struct hw_perf_event *hwc = &event->hw;
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct pmu_hw_events *events = this_cpu_ptr(cpu_pmu->hw_events);
-	int idx = hwc->idx;
 
 	/*
 	 * Disable counter and interrupt
@@ -668,12 +767,12 @@ static void armv8pmu_disable_event(struct perf_event *event)
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
@@ -767,6 +866,37 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 	return IRQ_HANDLED;
 }
 
+static int armv8pmu_get_single_idx(struct pmu_hw_events *cpuc,
+				    struct arm_pmu *cpu_pmu)
+{
+	int idx;
+
+	for (idx = ARMV8_IDX_COUNTER0; idx < cpu_pmu->num_events; idx++)
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
+	 * the lower idx must be even.
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
@@ -784,13 +914,21 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	/*
 	 * Otherwise use events counters
 	 */
-	for (idx = ARMV8_IDX_COUNTER0; idx < cpu_pmu->num_events; ++idx) {
-		if (!test_and_set_bit(idx, cpuc->used_mask))
-			return idx;
-	}
+	idx = armv8pmu_event_is_64bit(event) ?
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
@@ -865,6 +1003,9 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 				       &armv8_pmuv3_perf_cache_map,
 				       ARMV8_PMU_EVTYPE_EVENT);
 
+	if (armv8pmu_event_is_64bit(event))
+		event->hw.flags |= ARMPMU_EVT_64BIT;
+
 	/* Onl expose micro/arch events supported by this PMU */
 	if ((hw_event_id > 0) && (hw_event_id < ARMV8_PMUV3_MAX_COMMON_EVENTS)
 	    && test_bit(hw_event_id, armpmu->pmceid_bitmap)) {
@@ -971,6 +1112,7 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->read_counter		= armv8pmu_read_counter,
 	cpu_pmu->write_counter		= armv8pmu_write_counter,
 	cpu_pmu->get_event_idx		= armv8pmu_get_event_idx,
+	cpu_pmu->clear_event_idx	= armv8pmu_clear_event_idx,
 	cpu_pmu->start			= armv8pmu_start,
 	cpu_pmu->stop			= armv8pmu_stop,
 	cpu_pmu->reset			= armv8pmu_reset,
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 6e10e8c..a4675e4 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -674,14 +674,13 @@ static void cpu_pm_pmu_setup(struct arm_pmu *armpmu, unsigned long cmd)
 	int idx;
 
 	for (idx = 0; idx < armpmu->num_events; idx++) {
-		/*
-		 * If the counter is not used skip it, there is no
-		 * need of stopping/restarting it.
-		 */
-		if (!test_bit(idx, hw_events->used_mask))
-			continue;
-
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

