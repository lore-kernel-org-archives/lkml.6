Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbeEDClr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 22:41:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:18428 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751214AbeEDClp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 22:41:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="221513562"
From: kan.liang@intel.com
To: peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc: acme@kernel.org, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@intel.com>
Subject: [RESEND PATCH V7 8/8] perf/x86/intel/uncore: Clean up client IMC uncore
Date: Thu,  3 May 2018 11:25:13 -0700
Message-Id: <1525371913-10597-8-git-send-email-kan.liang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525371913-10597-1-git-send-email-kan.liang@intel.com>
References: <1525371913-10597-1-git-send-email-kan.liang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

The counters in client IMC uncore are free running counters, not fixed
counters. It should be corrected. The new infrastructure for free
running counter should be applied.

Introducing a new type SNB_PCI_UNCORE_IMC_DATA for client IMC free
running counters.

Keeping the customized event_init() function to compatible with old
event encoding.

Cleaning up other customized event_* functions.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kan Liang <kan.liang@intel.com>
---

No changes since V6.

 arch/x86/events/intel/uncore_snb.c | 132 ++++++-------------------------------
 1 file changed, 20 insertions(+), 112 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index df53521..8527c3e 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -285,6 +285,15 @@ static struct uncore_event_desc snb_uncore_imc_events[] = {
 #define SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE	0x5054
 #define SNB_UNCORE_PCI_IMC_CTR_BASE		SNB_UNCORE_PCI_IMC_DATA_READS_BASE
 
+enum perf_snb_uncore_imc_freerunning_types {
+	SNB_PCI_UNCORE_IMC_DATA		= 0,
+	SNB_PCI_UNCORE_IMC_FREERUNNING_TYPE_MAX,
+};
+
+static struct freerunning_counters snb_uncore_imc_freerunning[] = {
+	[SNB_PCI_UNCORE_IMC_DATA]     = { SNB_UNCORE_PCI_IMC_DATA_READS_BASE, 0x4, 0x0, 2, 32 },
+};
+
 static struct attribute *snb_uncore_imc_formats_attr[] = {
 	&format_attr_event.attr,
 	NULL,
@@ -341,9 +350,8 @@ static u64 snb_uncore_imc_read_counter(struct intel_uncore_box *box, struct perf
 }
 
 /*
- * custom event_init() function because we define our own fixed, free
- * running counters, so we do not want to conflict with generic uncore
- * logic. Also simplifies processing
+ * Keep the custom event_init() function compatible with old event
+ * encoding for free running counters.
  */
 static int snb_uncore_imc_event_init(struct perf_event *event)
 {
@@ -405,11 +413,11 @@ static int snb_uncore_imc_event_init(struct perf_event *event)
 	switch (cfg) {
 	case SNB_UNCORE_PCI_IMC_DATA_READS:
 		base = SNB_UNCORE_PCI_IMC_DATA_READS_BASE;
-		idx = UNCORE_PMC_IDX_FIXED;
+		idx = UNCORE_PMC_IDX_FREERUNNING;
 		break;
 	case SNB_UNCORE_PCI_IMC_DATA_WRITES:
 		base = SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE;
-		idx = UNCORE_PMC_IDX_FIXED + 1;
+		idx = UNCORE_PMC_IDX_FREERUNNING;
 		break;
 	default:
 		return -EINVAL;
@@ -430,104 +438,6 @@ static int snb_uncore_imc_hw_config(struct intel_uncore_box *box, struct perf_ev
 	return 0;
 }
 
-static void snb_uncore_imc_event_start(struct perf_event *event, int flags)
-{
-	struct intel_uncore_box *box = uncore_event_to_box(event);
-	u64 count;
-
-	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
-		return;
-
-	event->hw.state = 0;
-	box->n_active++;
-
-	list_add_tail(&event->active_entry, &box->active_list);
-
-	count = snb_uncore_imc_read_counter(box, event);
-	local64_set(&event->hw.prev_count, count);
-
-	if (box->n_active == 1)
-		uncore_pmu_start_hrtimer(box);
-}
-
-static void snb_uncore_imc_event_read(struct perf_event *event)
-{
-	struct intel_uncore_box *box = uncore_event_to_box(event);
-	u64 prev_count, new_count, delta;
-	int shift;
-
-	/*
-	 * There are two free running counters in IMC.
-	 * The index for the second one is hardcoded to
-	 * UNCORE_PMC_IDX_FIXED + 1.
-	 */
-	if (event->hw.idx >= UNCORE_PMC_IDX_FIXED)
-		shift = 64 - uncore_fixed_ctr_bits(box);
-	else
-		shift = 64 - uncore_perf_ctr_bits(box);
-
-	/* the hrtimer might modify the previous event value */
-again:
-	prev_count = local64_read(&event->hw.prev_count);
-	new_count = uncore_read_counter(box, event);
-	if (local64_xchg(&event->hw.prev_count, new_count) != prev_count)
-		goto again;
-
-	delta = (new_count << shift) - (prev_count << shift);
-	delta >>= shift;
-
-	local64_add(delta, &event->count);
-}
-
-static void snb_uncore_imc_event_stop(struct perf_event *event, int flags)
-{
-	struct intel_uncore_box *box = uncore_event_to_box(event);
-	struct hw_perf_event *hwc = &event->hw;
-
-	if (!(hwc->state & PERF_HES_STOPPED)) {
-		box->n_active--;
-
-		WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
-		hwc->state |= PERF_HES_STOPPED;
-
-		list_del(&event->active_entry);
-
-		if (box->n_active == 0)
-			uncore_pmu_cancel_hrtimer(box);
-	}
-
-	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
-		/*
-		 * Drain the remaining delta count out of a event
-		 * that we are disabling:
-		 */
-		snb_uncore_imc_event_read(event);
-		hwc->state |= PERF_HES_UPTODATE;
-	}
-}
-
-static int snb_uncore_imc_event_add(struct perf_event *event, int flags)
-{
-	struct intel_uncore_box *box = uncore_event_to_box(event);
-	struct hw_perf_event *hwc = &event->hw;
-
-	if (!box)
-		return -ENODEV;
-
-	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
-	if (!(flags & PERF_EF_START))
-		hwc->state |= PERF_HES_ARCH;
-
-	snb_uncore_imc_event_start(event, 0);
-
-	return 0;
-}
-
-static void snb_uncore_imc_event_del(struct perf_event *event, int flags)
-{
-	snb_uncore_imc_event_stop(event, PERF_EF_UPDATE);
-}
-
 int snb_pci2phy_map_init(int devid)
 {
 	struct pci_dev *dev = NULL;
@@ -559,11 +469,11 @@ int snb_pci2phy_map_init(int devid)
 static struct pmu snb_uncore_imc_pmu = {
 	.task_ctx_nr	= perf_invalid_context,
 	.event_init	= snb_uncore_imc_event_init,
-	.add		= snb_uncore_imc_event_add,
-	.del		= snb_uncore_imc_event_del,
-	.start		= snb_uncore_imc_event_start,
-	.stop		= snb_uncore_imc_event_stop,
-	.read		= snb_uncore_imc_event_read,
+	.add		= uncore_pmu_event_add,
+	.del		= uncore_pmu_event_del,
+	.start		= uncore_pmu_event_start,
+	.stop		= uncore_pmu_event_stop,
+	.read		= uncore_pmu_event_read,
 };
 
 static struct intel_uncore_ops snb_uncore_imc_ops = {
@@ -581,12 +491,10 @@ static struct intel_uncore_type snb_uncore_imc = {
 	.name		= "imc",
 	.num_counters   = 2,
 	.num_boxes	= 1,
-	.fixed_ctr_bits	= 32,
-	.fixed_ctr	= SNB_UNCORE_PCI_IMC_CTR_BASE,
+	.num_freerunning_types	= SNB_PCI_UNCORE_IMC_FREERUNNING_TYPE_MAX,
+	.freerunning	= snb_uncore_imc_freerunning,
 	.event_descs	= snb_uncore_imc_events,
 	.format_group	= &snb_uncore_imc_format_group,
-	.perf_ctr	= SNB_UNCORE_PCI_IMC_DATA_READS_BASE,
-	.event_mask	= SNB_UNCORE_PCI_IMC_EVENT_MASK,
 	.ops		= &snb_uncore_imc_ops,
 	.pmu		= &snb_uncore_imc_pmu,
 };
-- 
2.7.4
