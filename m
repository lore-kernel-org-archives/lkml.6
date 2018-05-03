Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeEDCls (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 22:41:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:18423 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbeEDCln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 22:41:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="221513557"
From: kan.liang@intel.com
To: peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc: acme@kernel.org, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@intel.com>
Subject: [RESEND PATCH V7 7/8] perf/x86/intel/uncore: Expose uncore_pmu_event functions
Date: Thu,  3 May 2018 11:25:12 -0700
Message-Id: <1525371913-10597-7-git-send-email-kan.liang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525371913-10597-1-git-send-email-kan.liang@intel.com>
References: <1525371913-10597-1-git-send-email-kan.liang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

Some uncores have customized PMU. For customized PMU, it does not need
to customize everything. For example, it only needs to customize init()
function for client IMC uncore. Other functions like
add()/del()/start()/stop()/read() can use generic code.

Expose the uncore_pmu_event_add/del/start/stop functions.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kan Liang <kan.liang@intel.com>
---

No changes since V6.

 arch/x86/events/intel/uncore.c | 8 ++++----
 arch/x86/events/intel/uncore.h | 4 ++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 0a6f697..15b0737 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -451,7 +451,7 @@ static int uncore_assign_events(struct intel_uncore_box *box, int assign[], int
 	return ret ? -EINVAL : 0;
 }
 
-static void uncore_pmu_event_start(struct perf_event *event, int flags)
+void uncore_pmu_event_start(struct perf_event *event, int flags)
 {
 	struct intel_uncore_box *box = uncore_event_to_box(event);
 	int idx = event->hw.idx;
@@ -491,7 +491,7 @@ static void uncore_pmu_event_start(struct perf_event *event, int flags)
 	}
 }
 
-static void uncore_pmu_event_stop(struct perf_event *event, int flags)
+void uncore_pmu_event_stop(struct perf_event *event, int flags)
 {
 	struct intel_uncore_box *box = uncore_event_to_box(event);
 	struct hw_perf_event *hwc = &event->hw;
@@ -528,7 +528,7 @@ static void uncore_pmu_event_stop(struct perf_event *event, int flags)
 	}
 }
 
-static int uncore_pmu_event_add(struct perf_event *event, int flags)
+int uncore_pmu_event_add(struct perf_event *event, int flags)
 {
 	struct intel_uncore_box *box = uncore_event_to_box(event);
 	struct hw_perf_event *hwc = &event->hw;
@@ -600,7 +600,7 @@ static int uncore_pmu_event_add(struct perf_event *event, int flags)
 	return 0;
 }
 
-static void uncore_pmu_event_del(struct perf_event *event, int flags)
+void uncore_pmu_event_del(struct perf_event *event, int flags)
 {
 	struct intel_uncore_box *box = uncore_event_to_box(event);
 	int i;
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index eb02653..c9e1e0b 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -467,6 +467,10 @@ struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu
 u64 uncore_msr_read_counter(struct intel_uncore_box *box, struct perf_event *event);
 void uncore_pmu_start_hrtimer(struct intel_uncore_box *box);
 void uncore_pmu_cancel_hrtimer(struct intel_uncore_box *box);
+void uncore_pmu_event_start(struct perf_event *event, int flags);
+void uncore_pmu_event_stop(struct perf_event *event, int flags);
+int uncore_pmu_event_add(struct perf_event *event, int flags);
+void uncore_pmu_event_del(struct perf_event *event, int flags);
 void uncore_pmu_event_read(struct perf_event *event);
 void uncore_perf_event_update(struct intel_uncore_box *box, struct perf_event *event);
 struct event_constraint *
-- 
2.7.4
