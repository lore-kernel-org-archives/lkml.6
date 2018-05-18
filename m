Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeERKWl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:22:41 -0400
Received: from foss.arm.com ([217.140.101.70]:47390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752519AbeERKWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:22:37 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 5/6] arm_pmu: Tidy up clear_event_idx call backs
Date: Fri, 18 May 2018 11:22:22 +0100
Message-Id: <1526638943-2110-6-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526638943-2110-1-git-send-email-suzuki.poulose@arm.com>
References: <1526638943-2110-1-git-send-email-suzuki.poulose@arm.com>
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
index 2f3c06d..1c28b23 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1639,6 +1639,7 @@ static void krait_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
 	bool venum_event = EVENT_VENUM(hwc->config_base);
 	bool krait_event = EVENT_CPU(hwc->config_base);
 
+	clear_bit(hwc->idx, cpuc->used_mask);
 	if (venum_event || krait_event) {
 		bit = krait_event_to_bit(event, region, group);
 		clear_bit(bit, cpuc->used_mask);
@@ -1968,6 +1969,7 @@ static void scorpion_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
 	bool venum_event = EVENT_VENUM(hwc->config_base);
 	bool scorpion_event = EVENT_CPU(hwc->config_base);
 
+	clear_bit(hwc->idx, cpuc->used_mask);
 	if (venum_event || scorpion_event) {
 		bit = scorpion_event_to_bit(event, region, group);
 		clear_bit(bit, cpuc->used_mask);
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 1adabb5..7207d01 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -240,6 +240,16 @@ static void armpmu_start(struct perf_event *event, int flags)
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
@@ -250,10 +260,7 @@ armpmu_del(struct perf_event *event, int flags)
 
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
