Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753380AbeCTMfK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:35:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:3060 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753176AbeCTMdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:33:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,335,1517904000";
   d="scan'208";a="209781478"
From: kan.liang@intel.com
To: peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc: acme@kernel.org, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@intel.com>
Subject: [PATCH V7 1/8] perf/x86/intel/uncore: Customized event_read for client IMC uncore
Date: Tue, 20 Mar 2018 05:32:38 -0700
Message-Id: <1521549165-6216-1-git-send-email-kan.liang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

There are two free running counters for client IMC uncore. The custom
event_init() function hardcode their index to 'UNCORE_PMC_IDX_FIXED' and
'UNCORE_PMC_IDX_FIXED + 1'. To support the 'UNCORE_PMC_IDX_FIXED + 1'
case, the generic uncore_perf_event_update is obscurely hacked.
The code quality issue will bring problem when new counter index is
introduced into generic code. For example, free running counter index.

Introduce customized event_read function for client IMC uncore.
The customized function is exactly copied from previous generic
uncore_pmu_event_read.
The 'UNCORE_PMC_IDX_FIXED + 1' case will be isolated for client IMC
uncore only.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kan Liang <kan.liang@intel.com>
---

No changes since V6.

 arch/x86/events/intel/uncore_snb.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index aee5e84..df53521 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -450,6 +450,35 @@ static void snb_uncore_imc_event_start(struct perf_event *event, int flags)
 		uncore_pmu_start_hrtimer(box);
 }
 
+static void snb_uncore_imc_event_read(struct perf_event *event)
+{
+	struct intel_uncore_box *box = uncore_event_to_box(event);
+	u64 prev_count, new_count, delta;
+	int shift;
+
+	/*
+	 * There are two free running counters in IMC.
+	 * The index for the second one is hardcoded to
+	 * UNCORE_PMC_IDX_FIXED + 1.
+	 */
+	if (event->hw.idx >= UNCORE_PMC_IDX_FIXED)
+		shift = 64 - uncore_fixed_ctr_bits(box);
+	else
+		shift = 64 - uncore_perf_ctr_bits(box);
+
+	/* the hrtimer might modify the previous event value */
+again:
+	prev_count = local64_read(&event->hw.prev_count);
+	new_count = uncore_read_counter(box, event);
+	if (local64_xchg(&event->hw.prev_count, new_count) != prev_count)
+		goto again;
+
+	delta = (new_count << shift) - (prev_count << shift);
+	delta >>= shift;
+
+	local64_add(delta, &event->count);
+}
+
 static void snb_uncore_imc_event_stop(struct perf_event *event, int flags)
 {
 	struct intel_uncore_box *box = uncore_event_to_box(event);
@@ -472,7 +501,7 @@ static void snb_uncore_imc_event_stop(struct perf_event *event, int flags)
 		 * Drain the remaining delta count out of a event
 		 * that we are disabling:
 		 */
-		uncore_perf_event_update(box, event);
+		snb_uncore_imc_event_read(event);
 		hwc->state |= PERF_HES_UPTODATE;
 	}
 }
@@ -534,7 +563,7 @@ static struct pmu snb_uncore_imc_pmu = {
 	.del		= snb_uncore_imc_event_del,
 	.start		= snb_uncore_imc_event_start,
 	.stop		= snb_uncore_imc_event_stop,
-	.read		= uncore_pmu_event_read,
+	.read		= snb_uncore_imc_event_read,
 };
 
 static struct intel_uncore_ops snb_uncore_imc_ops = {
-- 
2.7.4
