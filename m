Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932822AbeBLWWU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:22:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:64299 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932737AbeBLWVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:21:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,504,1511856000";
   d="scan'208";a="29490602"
From: kan.liang@linux.intel.com
To: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: acme@kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 4/5] perf/x86/intel: Fix pmu read for auto-reload
Date: Mon, 12 Feb 2018 14:20:34 -0800
Message-Id: <1518474035-21006-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518474035-21006-1-git-send-email-kan.liang@linux.intel.com>
References: <1518474035-21006-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Auto-reload event needs to be specially handled in event count read.

Auto-reload is only available for intel_pmu.

Fixes: b8241d20699e ("perf/x86/intel: Implement batched PEBS interrupt
handling (large PEBS interrupt threshold)")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 731153a..6461a4a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2060,6 +2060,14 @@ static void intel_pmu_del_event(struct perf_event *event)
 		intel_pmu_pebs_del(event);
 }
 
+static void intel_pmu_read_event(struct perf_event *event)
+{
+	if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
+		intel_pmu_auto_reload_read(event);
+	else
+		x86_perf_event_update(event);
+}
+
 static void intel_pmu_enable_fixed(struct hw_perf_event *hwc)
 {
 	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
@@ -3495,6 +3503,7 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.disable		= intel_pmu_disable_event,
 	.add			= intel_pmu_add_event,
 	.del			= intel_pmu_del_event,
+	.read			= intel_pmu_read_event,
 	.hw_config		= intel_pmu_hw_config,
 	.schedule_events	= x86_schedule_events,
 	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
-- 
2.7.4
