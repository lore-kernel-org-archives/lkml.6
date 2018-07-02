Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3D1C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9752527C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9752527C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753658AbeGBWAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:00:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40206 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752715AbeGBWAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:00:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C7131529;
        Mon,  2 Jul 2018 15:00:03 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 38EFD3F2EA;
        Mon,  2 Jul 2018 15:00:02 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com, julien.thierry@arm.com, robin.murphy@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 1/7] arm_pmu: Clean up maximum period handling
Date:   Mon,  2 Jul 2018 22:59:42 +0100
Message-Id: <1530568788-26458-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530568788-26458-1-git-send-email-suzuki.poulose@arm.com>
References: <1530568788-26458-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each PMU defines their max_period of the counter as the maximum
value that can be counted. Since all the PMU backends support
32bit counters by default, let us remove the redundant field.

No functional changes.

Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
No changes since v2
---
 arch/arm/kernel/perf_event_v6.c     |  2 --
 arch/arm/kernel/perf_event_v7.c     |  1 -
 arch/arm/kernel/perf_event_xscale.c |  2 --
 arch/arm64/kernel/perf_event.c      |  1 -
 drivers/perf/arm_pmu.c              | 16 ++++++++++++----
 include/linux/perf/arm_pmu.h        |  1 -
 6 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index be42c4f..f64a6bf 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -495,7 +495,6 @@ static void armv6pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->stop		= armv6pmu_stop;
 	cpu_pmu->map_event	= armv6_map_event;
 	cpu_pmu->num_events	= 3;
-	cpu_pmu->max_period	= (1LLU << 32) - 1;
 }
 
 static int armv6_1136_pmu_init(struct arm_pmu *cpu_pmu)
@@ -546,7 +545,6 @@ static int armv6mpcore_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->stop		= armv6pmu_stop;
 	cpu_pmu->map_event	= armv6mpcore_map_event;
 	cpu_pmu->num_events	= 3;
-	cpu_pmu->max_period	= (1LLU << 32) - 1;
 
 	return 0;
 }
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 57f01e0..ecca4cd 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1170,7 +1170,6 @@ static void armv7pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->start		= armv7pmu_start;
 	cpu_pmu->stop		= armv7pmu_stop;
 	cpu_pmu->reset		= armv7pmu_reset;
-	cpu_pmu->max_period	= (1LLU << 32) - 1;
 };
 
 static void armv7_read_num_pmnc_events(void *info)
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index 88d1a76..c4f0294 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -374,7 +374,6 @@ static int xscale1pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->stop		= xscale1pmu_stop;
 	cpu_pmu->map_event	= xscale_map_event;
 	cpu_pmu->num_events	= 3;
-	cpu_pmu->max_period	= (1LLU << 32) - 1;
 
 	return 0;
 }
@@ -743,7 +742,6 @@ static int xscale2pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->stop		= xscale2pmu_stop;
 	cpu_pmu->map_event	= xscale_map_event;
 	cpu_pmu->num_events	= 5;
-	cpu_pmu->max_period	= (1LLU << 32) - 1;
 
 	return 0;
 }
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 33147aa..678ecff 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -960,7 +960,6 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->start			= armv8pmu_start,
 	cpu_pmu->stop			= armv8pmu_stop,
 	cpu_pmu->reset			= armv8pmu_reset,
-	cpu_pmu->max_period		= (1LLU << 32) - 1,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
 
 	return 0;
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index a6347d4..6ddc00d 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -28,6 +28,11 @@
 static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
 static DEFINE_PER_CPU(int, cpu_irq);
 
+static inline u64 arm_pmu_max_period(void)
+{
+	return (1ULL << 32) - 1;
+}
+
 static int
 armpmu_map_cache_event(const unsigned (*cache_map)
 				      [PERF_COUNT_HW_CACHE_MAX]
@@ -114,8 +119,10 @@ int armpmu_event_set_period(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	s64 left = local64_read(&hwc->period_left);
 	s64 period = hwc->sample_period;
+	u64 max_period;
 	int ret = 0;
 
+	max_period = arm_pmu_max_period();
 	if (unlikely(left <= -period)) {
 		left = period;
 		local64_set(&hwc->period_left, left);
@@ -136,8 +143,8 @@ int armpmu_event_set_period(struct perf_event *event)
 	 * effect we are reducing max_period to account for
 	 * interrupt latency (and we are being very conservative).
 	 */
-	if (left > (armpmu->max_period >> 1))
-		left = armpmu->max_period >> 1;
+	if (left > (max_period >> 1))
+		left = (max_period >> 1);
 
 	local64_set(&hwc->prev_count, (u64)-left);
 
@@ -153,6 +160,7 @@ u64 armpmu_event_update(struct perf_event *event)
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	u64 delta, prev_raw_count, new_raw_count;
+	u64 max_period = arm_pmu_max_period();
 
 again:
 	prev_raw_count = local64_read(&hwc->prev_count);
@@ -162,7 +170,7 @@ u64 armpmu_event_update(struct perf_event *event)
 			     new_raw_count) != prev_raw_count)
 		goto again;
 
-	delta = (new_raw_count - prev_raw_count) & armpmu->max_period;
+	delta = (new_raw_count - prev_raw_count) & max_period;
 
 	local64_add(delta, &event->count);
 	local64_sub(delta, &hwc->period_left);
@@ -402,7 +410,7 @@ __hw_perf_event_init(struct perf_event *event)
 		 * is far less likely to overtake the previous one unless
 		 * you have some serious IRQ latency issues.
 		 */
-		hwc->sample_period  = armpmu->max_period >> 1;
+		hwc->sample_period  = arm_pmu_max_period() >> 1;
 		hwc->last_period    = hwc->sample_period;
 		local64_set(&hwc->period_left, hwc->sample_period);
 	}
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index ad54444..12c30a2 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -94,7 +94,6 @@ struct arm_pmu {
 	void		(*reset)(void *);
 	int		(*map_event)(struct perf_event *event);
 	int		num_events;
-	u64		max_period;
 	bool		secure_access; /* 32-bit ARM only */
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS 0x40
 	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
-- 
2.7.4

