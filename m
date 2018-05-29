Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933373AbeE2K5O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:57:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37374 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933135AbeE2K4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:56:15 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will.deacon@arm.com,
        mark.rutland@arm.com, robin.murphy@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 3/5] arm_pmu: Add support for 64bit event counters
Date: Tue, 29 May 2018 11:55:54 +0100
Message-Id: <1527591356-10934-4-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
References: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each PMU has a set of 32bit event counters. But in some
special cases, the events could be counted using counters
which are effectively 64bit wide.

e.g, Arm V8 PMUv3 has a 64 bit cycle counter which can count
only the CPU cycles. Also, the PMU can chain the event counters
to effectively count as a 64bit counter.

Add support for tracking the events that uses 64bit counters.
This only affects the periods set for each counter in the core
driver.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v1:
 - Rename ARMPMU_EVT_LONG => ARMPMU_EVT_64BIT
---
 drivers/perf/arm_pmu.c       | 14 ++++++++------
 include/linux/perf/arm_pmu.h |  6 ++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 8962d26..ff858e6 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -28,9 +28,10 @@
 static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
 static DEFINE_PER_CPU(int, cpu_irq);
 
-static inline u64 arm_pmu_max_period(void)
+static inline u64 arm_pmu_event_max_period(struct perf_event *event)
 {
-	return (1ULL << 32) - 1;
+	return (event->hw.flags & ARMPMU_EVT_64BIT) ?
+		~0ULL : (1ULL << 32) - 1;
 }
 
 static int
@@ -122,7 +123,7 @@ int armpmu_event_set_period(struct perf_event *event)
 	u64 max_period;
 	int ret = 0;
 
-	max_period = arm_pmu_max_period();
+	max_period = arm_pmu_event_max_period(event);
 	if (unlikely(left <= -period)) {
 		left = period;
 		local64_set(&hwc->period_left, left);
@@ -148,7 +149,7 @@ int armpmu_event_set_period(struct perf_event *event)
 
 	local64_set(&hwc->prev_count, (u64)-left);
 
-	armpmu->write_counter(event, (u64)(-left) & 0xffffffff);
+	armpmu->write_counter(event, (u64)(-left) & max_period);
 
 	perf_event_update_userpage(event);
 
@@ -160,7 +161,7 @@ u64 armpmu_event_update(struct perf_event *event)
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	u64 delta, prev_raw_count, new_raw_count;
-	u64 max_period = arm_pmu_max_period();
+	u64 max_period = arm_pmu_event_max_period(event);
 
 again:
 	prev_raw_count = local64_read(&hwc->prev_count);
@@ -368,6 +369,7 @@ __hw_perf_event_init(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	int mapping;
 
+	hwc->flags = 0;
 	mapping = armpmu->map_event(event);
 
 	if (mapping < 0) {
@@ -410,7 +412,7 @@ __hw_perf_event_init(struct perf_event *event)
 		 * is far less likely to overtake the previous one unless
 		 * you have some serious IRQ latency issues.
 		 */
-		hwc->sample_period  = arm_pmu_max_period() >> 1;
+		hwc->sample_period  = arm_pmu_event_max_period(event) >> 1;
 		hwc->last_period    = hwc->sample_period;
 		local64_set(&hwc->period_left, hwc->sample_period);
 	}
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index f1cfe12..1e26b14 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -25,6 +25,12 @@
  */
 #define ARMPMU_MAX_HWEVENTS		32
 
+/*
+ * ARM PMU hw_event flags
+ */
+/* Event uses a 64bit counter */
+#define ARMPMU_EVT_64BIT		1
+
 #define HW_OP_UNSUPPORTED		0xFFFF
 #define C(_x)				PERF_COUNT_HW_CACHE_##_x
 #define CACHE_OP_UNSUPPORTED		0xFFFF
-- 
2.7.4
