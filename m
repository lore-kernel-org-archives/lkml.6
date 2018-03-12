Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeCLOqk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:46:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:40845 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751232AbeCLOqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:46:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,461,1515484800";
   d="scan'208";a="36616885"
From: kan.liang@linux.intel.com
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: vincent.weaver@maine.edu, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Rename freerunning PEBS to large PEBS
Date: Mon, 12 Mar 2018 10:45:37 -0400
Message-Id: <1520865937-22910-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The freerunning PEBS and large PEBS are the same thing. Both of these
names appear in the code, which brings confusion.

Rename freerunning PEBS to large PEBS, which is more accurate.

No functional change.

Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       |  2 +-
 arch/x86/events/intel/core.c | 12 ++++++------
 arch/x86/events/intel/ds.c   |  6 +++---
 arch/x86/events/perf_event.h |  6 +++---
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9c86e10..85d2d94 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2118,7 +2118,7 @@ static int x86_pmu_event_init(struct perf_event *event)
 	}
 
 	if (READ_ONCE(x86_pmu.attr_rdpmc) &&
-	    !(event->hw.flags & PERF_X86_EVENT_FREERUNNING))
+	    !(event->hw.flags & PERF_X86_EVENT_LARGE_PEBS))
 		event->hw.flags |= PERF_X86_EVENT_RDPMC_ALLOWED;
 
 	return err;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 41c68d3..26e9c18 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2968,9 +2968,9 @@ static void intel_pebs_aliases_skl(struct perf_event *event)
 	return intel_pebs_aliases_precdist(event);
 }
 
-static unsigned long intel_pmu_free_running_flags(struct perf_event *event)
+static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 {
-	unsigned long flags = x86_pmu.free_running_flags;
+	unsigned long flags = x86_pmu.large_pebs_flags;
 
 	if (event->attr.use_clockid)
 		flags &= ~PERF_SAMPLE_TIME;
@@ -2992,8 +2992,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		if (!event->attr.freq) {
 			event->hw.flags |= PERF_X86_EVENT_AUTO_RELOAD;
 			if (!(event->attr.sample_type &
-			      ~intel_pmu_free_running_flags(event)))
-				event->hw.flags |= PERF_X86_EVENT_FREERUNNING;
+			      ~intel_pmu_large_pebs_flags(event)))
+				event->hw.flags |= PERF_X86_EVENT_LARGE_PEBS;
 		}
 		if (x86_pmu.pebs_aliases)
 			x86_pmu.pebs_aliases(event);
@@ -3476,7 +3476,7 @@ static __initconst const struct x86_pmu core_pmu = {
 	.event_map		= intel_pmu_event_map,
 	.max_events		= ARRAY_SIZE(intel_perfmon_event_map),
 	.apic			= 1,
-	.free_running_flags	= PEBS_FREERUNNING_FLAGS,
+	.large_pebs_flags	= LARGE_PEBS_FLAGS,
 
 	/*
 	 * Intel PMCs cannot be accessed sanely above 32-bit width,
@@ -3519,7 +3519,7 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.event_map		= intel_pmu_event_map,
 	.max_events		= ARRAY_SIZE(intel_perfmon_event_map),
 	.apic			= 1,
-	.free_running_flags	= PEBS_FREERUNNING_FLAGS,
+	.large_pebs_flags	= LARGE_PEBS_FLAGS,
 	/*
 	 * Intel PMCs cannot be accessed sanely above 32 bit width,
 	 * so we install an artificial 1<<31 period regardless of
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7384402..209bf7c 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -935,7 +935,7 @@ void intel_pmu_pebs_add(struct perf_event *event)
 	bool needed_cb = pebs_needs_sched_cb(cpuc);
 
 	cpuc->n_pebs++;
-	if (hwc->flags & PERF_X86_EVENT_FREERUNNING)
+	if (hwc->flags & PERF_X86_EVENT_LARGE_PEBS)
 		cpuc->n_large_pebs++;
 
 	pebs_update_state(needed_cb, cpuc, event->ctx->pmu);
@@ -975,7 +975,7 @@ void intel_pmu_pebs_del(struct perf_event *event)
 	bool needed_cb = pebs_needs_sched_cb(cpuc);
 
 	cpuc->n_pebs--;
-	if (hwc->flags & PERF_X86_EVENT_FREERUNNING)
+	if (hwc->flags & PERF_X86_EVENT_LARGE_PEBS)
 		cpuc->n_large_pebs--;
 
 	pebs_update_state(needed_cb, cpuc, event->ctx->pmu);
@@ -1623,7 +1623,7 @@ void __init intel_ds_init(void)
 			x86_pmu.pebs_record_size =
 						sizeof(struct pebs_record_skl);
 			x86_pmu.drain_pebs = intel_pmu_drain_pebs_nhm;
-			x86_pmu.free_running_flags |= PERF_SAMPLE_TIME;
+			x86_pmu.large_pebs_flags |= PERF_SAMPLE_TIME;
 			break;
 
 		default:
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 9164347..9f37114 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -69,7 +69,7 @@ struct event_constraint {
 #define PERF_X86_EVENT_RDPMC_ALLOWED	0x0100 /* grant rdpmc permission */
 #define PERF_X86_EVENT_EXCL_ACCT	0x0200 /* accounted EXCL event */
 #define PERF_X86_EVENT_AUTO_RELOAD	0x0400 /* use PEBS auto-reload */
-#define PERF_X86_EVENT_FREERUNNING	0x0800 /* use freerunning PEBS */
+#define PERF_X86_EVENT_LARGE_PEBS	0x0800 /* use large PEBS */
 
 
 struct amd_nb {
@@ -88,7 +88,7 @@ struct amd_nb {
  * REGS_USER can be handled for events limited to ring 3.
  *
  */
-#define PEBS_FREERUNNING_FLAGS \
+#define LARGE_PEBS_FLAGS \
 	(PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_ADDR | \
 	PERF_SAMPLE_ID | PERF_SAMPLE_CPU | PERF_SAMPLE_STREAM_ID | \
 	PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_IDENTIFIER | \
@@ -609,7 +609,7 @@ struct x86_pmu {
 	struct event_constraint *pebs_constraints;
 	void		(*pebs_aliases)(struct perf_event *event);
 	int 		max_pebs_events;
-	unsigned long	free_running_flags;
+	unsigned long	large_pebs_flags;
 
 	/*
 	 * Intel LBR
-- 
2.4.11
