Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932862AbeBLWWV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:22:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:64302 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932730AbeBLWVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:21:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,504,1511856000";
   d="scan'208";a="29490600"
From: kan.liang@linux.intel.com
To: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: acme@kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 3/5] perf/x86/intel/ds: Introduce read function for auto-reload event
Date: Mon, 12 Feb 2018 14:20:33 -0800
Message-Id: <1518474035-21006-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518474035-21006-1-git-send-email-kan.liang@linux.intel.com>
References: <1518474035-21006-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

There is no way to get exact auto-reload times and value which needed
for event update unless flush the PEBS buffer.

Introduce intel_pmu_auto_reload_read() to drain the PEBS buffer for
auto reload event.
To prevent the race, the drain_pebs() only be called when the PMU is
disabled.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/ds.c   | 9 +++++++++
 arch/x86/events/perf_event.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index f519ebc..406f3ba 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1303,6 +1303,15 @@ get_next_pebs_record_by_bit(void *base, void *top, int bit)
 	return NULL;
 }
 
+void intel_pmu_auto_reload_read(struct perf_event *event)
+{
+	WARN_ON(!(event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD));
+
+	perf_pmu_disable(event->pmu);
+	intel_pmu_drain_pebs_buffer();
+	perf_pmu_enable(event->pmu);
+}
+
 /*
  * Special variant of intel_pmu_save_and_restart() for auto-reload.
  */
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 805400b..f4720a9 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -923,6 +923,8 @@ void intel_pmu_pebs_disable_all(void);
 
 void intel_pmu_pebs_sched_task(struct perf_event_context *ctx, bool sched_in);
 
+void intel_pmu_auto_reload_read(struct perf_event *event);
+
 void intel_ds_init(void);
 
 void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in);
-- 
2.7.4
