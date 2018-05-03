Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbeEDCmX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 22:42:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:18423 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751355AbeEDCle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 22:41:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="221513542"
From: kan.liang@intel.com
To: peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc: acme@kernel.org, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@intel.com>
Subject: [RESEND PATCH V7 5/8] perf/x86/intel/uncore: Add infrastructure for free running counter
Date: Thu,  3 May 2018 11:25:10 -0700
Message-Id: <1525371913-10597-5-git-send-email-kan.liang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525371913-10597-1-git-send-email-kan.liang@intel.com>
References: <1525371913-10597-1-git-send-email-kan.liang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

There are a number of free running counters introduced for uncore, which
provide highly valuable information to a wide array of customers.
However, the generic uncore code doesn't support them yet.

The free running counters will be specially handled based on their
unique attributes
 - They are read-only. They cannot be enable/disable.
 - The event and the counter are always 1:1 mapped. It doesn't need to
   be assigned nor tracked by event_list.
 - They are always active. It doesn't need to check the availability.
 - They have different bit width.

Also, using inline helpers to replace the check for fixed counter and
free running counter.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kan Liang <kan.liang@intel.com>
---

No changes since V6.

 arch/x86/events/intel/uncore.c | 68 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 3b0f93e..0a6f697 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -203,7 +203,7 @@ static void uncore_assign_hw_event(struct intel_uncore_box *box,
 	hwc->idx = idx;
 	hwc->last_tag = ++box->tags[idx];
 
-	if (hwc->idx == UNCORE_PMC_IDX_FIXED) {
+	if (uncore_pmc_fixed(hwc->idx)) {
 		hwc->event_base = uncore_fixed_ctr(box);
 		hwc->config_base = uncore_fixed_ctl(box);
 		return;
@@ -218,7 +218,9 @@ void uncore_perf_event_update(struct intel_uncore_box *box, struct perf_event *e
 	u64 prev_count, new_count, delta;
 	int shift;
 
-	if (event->hw.idx == UNCORE_PMC_IDX_FIXED)
+	if (uncore_pmc_freerunning(event->hw.idx))
+		shift = 64 - uncore_freerunning_bits(box, event);
+	else if (uncore_pmc_fixed(event->hw.idx))
 		shift = 64 - uncore_fixed_ctr_bits(box);
 	else
 		shift = 64 - uncore_perf_ctr_bits(box);
@@ -454,10 +456,25 @@ static void uncore_pmu_event_start(struct perf_event *event, int flags)
 	struct intel_uncore_box *box = uncore_event_to_box(event);
 	int idx = event->hw.idx;
 
-	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
+	if (WARN_ON_ONCE(idx == -1 || idx >= UNCORE_PMC_IDX_MAX))
 		return;
 
-	if (WARN_ON_ONCE(idx == -1 || idx >= UNCORE_PMC_IDX_MAX))
+	/*
+	 * Free running counter is read-only and always active.
+	 * Use the current counter value as start point.
+	 * There is no overflow interrupt for free running counter.
+	 * Use hrtimer to periodically poll the counter to avoid overflow.
+	 */
+	if (uncore_pmc_freerunning(event->hw.idx)) {
+		list_add_tail(&event->active_entry, &box->active_list);
+		local64_set(&event->hw.prev_count,
+			    uncore_read_counter(box, event));
+		if (box->n_active++ == 0)
+			uncore_pmu_start_hrtimer(box);
+		return;
+	}
+
+	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
 		return;
 
 	event->hw.state = 0;
@@ -479,6 +496,15 @@ static void uncore_pmu_event_stop(struct perf_event *event, int flags)
 	struct intel_uncore_box *box = uncore_event_to_box(event);
 	struct hw_perf_event *hwc = &event->hw;
 
+	/* Cannot disable free running counter which is read-only */
+	if (uncore_pmc_freerunning(hwc->idx)) {
+		list_del(&event->active_entry);
+		if (--box->n_active == 0)
+			uncore_pmu_cancel_hrtimer(box);
+		uncore_perf_event_update(box, event);
+		return;
+	}
+
 	if (__test_and_clear_bit(hwc->idx, box->active_mask)) {
 		uncore_disable_event(box, event);
 		box->n_active--;
@@ -512,6 +538,17 @@ static int uncore_pmu_event_add(struct perf_event *event, int flags)
 	if (!box)
 		return -ENODEV;
 
+	/*
+	 * The free funning counter is assigned in event_init().
+	 * The free running counter event and free running counter
+	 * are 1:1 mapped. It doesn't need to be tracked in event_list.
+	 */
+	if (uncore_pmc_freerunning(hwc->idx)) {
+		if (flags & PERF_EF_START)
+			uncore_pmu_event_start(event, 0);
+		return 0;
+	}
+
 	ret = n = uncore_collect_events(box, event, false);
 	if (ret < 0)
 		return ret;
@@ -570,6 +607,14 @@ static void uncore_pmu_event_del(struct perf_event *event, int flags)
 
 	uncore_pmu_event_stop(event, PERF_EF_UPDATE);
 
+	/*
+	 * The event for free running counter is not tracked by event_list.
+	 * It doesn't need to force event->hw.idx = -1 to reassign the counter.
+	 * Because the event and the free running counter are 1:1 mapped.
+	 */
+	if (uncore_pmc_freerunning(event->hw.idx))
+		return;
+
 	for (i = 0; i < box->n_events; i++) {
 		if (event == box->event_list[i]) {
 			uncore_put_event_constraint(box, event);
@@ -603,6 +648,10 @@ static int uncore_validate_group(struct intel_uncore_pmu *pmu,
 	struct intel_uncore_box *fake_box;
 	int ret = -EINVAL, n;
 
+	/* The free running counter is always active. */
+	if (uncore_pmc_freerunning(event->hw.idx))
+		return 0;
+
 	fake_box = uncore_alloc_box(pmu->type, NUMA_NO_NODE);
 	if (!fake_box)
 		return -ENOMEM;
@@ -690,6 +739,17 @@ static int uncore_pmu_event_init(struct perf_event *event)
 
 		/* fixed counters have event field hardcoded to zero */
 		hwc->config = 0ULL;
+	} else if (is_freerunning_event(event)) {
+		if (!check_valid_freerunning_event(box, event))
+			return -EINVAL;
+		event->hw.idx = UNCORE_PMC_IDX_FREERUNNING;
+		/*
+		 * The free running counter event and free running counter
+		 * are always 1:1 mapped.
+		 * The free running counter is always active.
+		 * Assign the free running counter here.
+		 */
+		event->hw.event_base = uncore_freerunning_counter(box, event);
 	} else {
 		hwc->config = event->attr.config &
 			      (pmu->type->event_mask | ((u64)pmu->type->event_mask_ext << 32));
-- 
2.7.4
