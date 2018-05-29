Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933334AbeE2K4Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:56:24 -0400
Received: from foss.arm.com ([217.140.101.70]:37378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933158AbeE2K4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:56:16 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will.deacon@arm.com,
        mark.rutland@arm.com, robin.murphy@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 4/5] arm_pmu: Tidy up clear_event_idx call backs
Date: Tue, 29 May 2018 11:55:55 +0100
Message-Id: <1527591356-10934-5-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
References: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The armpmu uses get_event_idx callback to allocate an event
counter for a given event, which marks the selected counter
as "used". Now, when we delete the counter, the arm_pmu goes
ahead and clears the "used" bit and then invokes the "clear_event_idx"
call back, which kind of splits the job between the core code
and the backend. Tidy this up by relying on the clear_event_idx
to do the book keeping, if available. Otherwise, let the core
driver do the default "clear" bit operation. This will be useful
for adding the chained event support, where we leave the event
idx maintenance to the backend.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/kernel/perf_event_v7.c |  2 ++
 drivers/perf/arm_pmu.c          | 15 +++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 5f342fc..5e78faa 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1638,6 +1638,7 @@ static void krait_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
 	bool venum_event = EVENT_VENUM(hwc->config_base);
 	bool krait_event = EVENT_CPU(hwc->config_base);
 
+	clear_bit(hwc->idx, cpuc->used_mask);
 	if (venum_event || krait_event) {
 		bit = krait_event_to_bit(event, region, group);
 		clear_bit(bit, cpuc->used_mask);
@@ -1967,6 +1968,7 @@ static void scorpion_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
 	bool venum_event = EVENT_VENUM(hwc->config_base);
 	bool scorpion_event = EVENT_CPU(hwc->config_base);
 
+	clear_bit(hwc->idx, cpuc->used_mask);
 	if (venum_event || scorpion_event) {
 		bit = scorpion_event_to_bit(event, region, group);
 		clear_bit(bit, cpuc->used_mask);
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index ff858e6..9ae7e68 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -226,6 +226,16 @@ static void armpmu_start(struct perf_event *event, int flags)
 	armpmu->enable(event);
 }
 
+static void armpmu_clear_event_idx(struct arm_pmu *armpmu,
+				   struct pmu_hw_events *hw_events,
+				   struct perf_event *event)
+{
+	if (armpmu->clear_event_idx)
+		armpmu->clear_event_idx(hw_events, event);
+	else
+		clear_bit(event->hw.idx, hw_events->used_mask);
+}
+
 static void
 armpmu_del(struct perf_event *event, int flags)
 {
@@ -236,10 +246,7 @@ armpmu_del(struct perf_event *event, int flags)
 
 	armpmu_stop(event, PERF_EF_UPDATE);
 	hw_events->events[idx] = NULL;
-	clear_bit(idx, hw_events->used_mask);
-	if (armpmu->clear_event_idx)
-		armpmu->clear_event_idx(hw_events, event);
-
+	armpmu_clear_event_idx(armpmu, hw_events, event);
 	perf_event_update_userpage(event);
 }
 
-- 
2.7.4
