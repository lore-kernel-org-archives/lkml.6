Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeERKXO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:23:14 -0400
Received: from foss.arm.com ([217.140.101.70]:47386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751971AbeERKWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:22:36 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 4/6] arm64: perf: Make the cycle counter 64bit by default
Date: Fri, 18 May 2018 11:22:21 +0100
Message-Id: <1526638943-2110-5-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526638943-2110-1-git-send-email-suzuki.poulose@arm.com>
References: <1526638943-2110-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the cycle counter by setting the ARPMU_EVT_LONG flag
to indicate that it uses 64bit counter.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/perf_event.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 7660b7a..ea8e060 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -517,7 +517,7 @@ static inline u64 armv8pmu_read_counter(struct perf_event *event)
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
-	u32 value = 0;
+	u64 value = 0;
 
 	if (!armv8pmu_counter_valid(cpu_pmu, idx))
 		pr_err("CPU%u reading wrong counter %d\n",
@@ -539,15 +539,9 @@ static inline void armv8pmu_write_counter(struct perf_event *event, u64 value)
 	if (!armv8pmu_counter_valid(cpu_pmu, idx))
 		pr_err("CPU%u writing wrong counter %d\n",
 			smp_processor_id(), idx);
-	else if (idx == ARMV8_IDX_CYCLE_COUNTER) {
-		/*
-		 * Set the upper 32bits as this is a 64bit counter but we only
-		 * count using the lower 32bits and we want an interrupt when
-		 * it overflows.
-		 */
-		value |= 0xffffffff00000000ULL;
+	else if (idx == ARMV8_IDX_CYCLE_COUNTER)
 		write_sysreg(value, pmccntr_el0);
-	} else if (armv8pmu_select_counter(idx) == idx)
+	else if (armv8pmu_select_counter(idx) == idx)
 		write_sysreg(value, pmxevcntr_el0);
 }
 
@@ -851,6 +845,9 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 				       &armv8_pmuv3_perf_cache_map,
 				       ARMV8_PMU_EVTYPE_EVENT);
 
+	if (hw_event_id == ARMV8_PMUV3_PERFCTR_CPU_CYCLES)
+		event->hw.flags |= ARMPMU_EVT_LONG;
+
 	/* Onl expose micro/arch events supported by this PMU */
 	if ((hw_event_id > 0) && (hw_event_id < ARMV8_PMUV3_MAX_COMMON_EVENTS)
 	    && test_bit(hw_event_id, armpmu->pmceid_bitmap)) {
-- 
2.7.4
