Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbeERKXf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:23:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47368 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752075AbeERKWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:22:33 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 2/6] arm_pmu: Change API to support 64bit counter values
Date: Fri, 18 May 2018 11:22:19 +0100
Message-Id: <1526638943-2110-3-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526638943-2110-1-git-send-email-suzuki.poulose@arm.com>
References: <1526638943-2110-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the {read/write}_counter APIs to handle 64bit values
to enable supporting chained event counters.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/kernel/perf_event_v6.c     | 4 ++--
 arch/arm/kernel/perf_event_v7.c     | 4 ++--
 arch/arm/kernel/perf_event_xscale.c | 4 ++--
 arch/arm64/kernel/perf_event.c      | 9 ++++-----
 include/linux/perf/arm_pmu.h        | 4 ++--
 5 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index d52a3fa..720c19e 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -233,7 +233,7 @@ armv6_pmcr_counter_has_overflowed(unsigned long pmcr,
 	return ret;
 }
 
-static inline u32 armv6pmu_read_counter(struct perf_event *event)
+static inline u64 armv6pmu_read_counter(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int counter = hwc->idx;
@@ -251,7 +251,7 @@ static inline u32 armv6pmu_read_counter(struct perf_event *event)
 	return value;
 }
 
-static inline void armv6pmu_write_counter(struct perf_event *event, u32 value)
+static inline void armv6pmu_write_counter(struct perf_event *event, u64 value)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int counter = hwc->idx;
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 3d8ec6a..2f3c06d 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -743,7 +743,7 @@ static inline void armv7_pmnc_select_counter(int idx)
 	isb();
 }
 
-static inline u32 armv7pmu_read_counter(struct perf_event *event)
+static inline u64 armv7pmu_read_counter(struct perf_event *event)
 {
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
@@ -763,7 +763,7 @@ static inline u32 armv7pmu_read_counter(struct perf_event *event)
 	return value;
 }
 
-static inline void armv7pmu_write_counter(struct perf_event *event, u32 value)
+static inline void armv7pmu_write_counter(struct perf_event *event, u64 value)
 {
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index 6eb0e21..3f2e398 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -317,7 +317,7 @@ static void xscale1pmu_stop(struct arm_pmu *cpu_pmu)
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
-static inline u32 xscale1pmu_read_counter(struct perf_event *event)
+static inline u64 xscale1pmu_read_counter(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int counter = hwc->idx;
@@ -338,7 +338,7 @@ static inline u32 xscale1pmu_read_counter(struct perf_event *event)
 	return val;
 }
 
-static inline void xscale1pmu_write_counter(struct perf_event *event, u32 val)
+static inline void xscale1pmu_write_counter(struct perf_event *event, u64 val)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int counter = hwc->idx;
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 408f92c..7660b7a 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -512,7 +512,7 @@ static inline int armv8pmu_select_counter(int idx)
 	return idx;
 }
 
-static inline u32 armv8pmu_read_counter(struct perf_event *event)
+static inline u64 armv8pmu_read_counter(struct perf_event *event)
 {
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
@@ -530,7 +530,7 @@ static inline u32 armv8pmu_read_counter(struct perf_event *event)
 	return value;
 }
 
-static inline void armv8pmu_write_counter(struct perf_event *event, u32 value)
+static inline void armv8pmu_write_counter(struct perf_event *event, u64 value)
 {
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
@@ -545,9 +545,8 @@ static inline void armv8pmu_write_counter(struct perf_event *event, u32 value)
 		 * count using the lower 32bits and we want an interrupt when
 		 * it overflows.
 		 */
-		u64 value64 = 0xffffffff00000000ULL | value;
-
-		write_sysreg(value64, pmccntr_el0);
+		value |= 0xffffffff00000000ULL;
+		write_sysreg(value, pmccntr_el0);
 	} else if (armv8pmu_select_counter(idx) == idx)
 		write_sysreg(value, pmxevcntr_el0);
 }
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index c8c31cf..705e8c3 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -87,8 +87,8 @@ struct arm_pmu {
 					 struct perf_event *event);
 	int		(*set_event_filter)(struct hw_perf_event *evt,
 					    struct perf_event_attr *attr);
-	u32		(*read_counter)(struct perf_event *event);
-	void		(*write_counter)(struct perf_event *event, u32 val);
+	u64		(*read_counter)(struct perf_event *event);
+	void		(*write_counter)(struct perf_event *event, u64 val);
 	void		(*start)(struct arm_pmu *);
 	void		(*stop)(struct arm_pmu *);
 	void		(*reset)(void *);
-- 
2.7.4
