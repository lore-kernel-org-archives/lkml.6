Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeCIJKj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:10:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49597 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbeCIJKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:10:37 -0500
Date: Fri, 9 Mar 2018 01:10:14 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-ceb90d9e0248947839a0ff4bee98cf28695a6020@git.kernel.org>
Cc: vincent.weaver@maine.edu, kan.liang@linux.intel.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        eranian@google.com, acme@redhat.com, jolsa@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, tglx@linutronix.de
Reply-To: torvalds@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, vincent.weaver@maine.edu,
        kan.liang@linux.intel.com, acme@redhat.com, eranian@google.com,
        peterz@infradead.org, jolsa@redhat.com, mingo@kernel.org
In-Reply-To: <1518474035-21006-5-git-send-email-kan.liang@linux.intel.com>
References: <1518474035-21006-5-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Fix PMU read for auto-reload
Git-Commit-ID: ceb90d9e0248947839a0ff4bee98cf28695a6020
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ceb90d9e0248947839a0ff4bee98cf28695a6020
Gitweb:     https://git.kernel.org/tip/ceb90d9e0248947839a0ff4bee98cf28695a6020
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 12 Feb 2018 14:20:34 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 08:22:22 +0100

perf/x86/intel: Fix PMU read for auto-reload

Auto-reload events needs to be specially handled in event count read.

Auto-reload is only available for intel_pmu.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Fixes: b8241d20699e ("perf/x86/intel: Implement batched PEBS interrupt handling (large PEBS interrupt threshold)")
Link: http://lkml.kernel.org/r/1518474035-21006-5-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1ba7ca7b675d..41c68d337e84 100644
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
@@ -3503,6 +3511,7 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.disable		= intel_pmu_disable_event,
 	.add			= intel_pmu_add_event,
 	.del			= intel_pmu_del_event,
+	.read			= intel_pmu_read_event,
 	.hw_config		= intel_pmu_hw_config,
 	.schedule_events	= x86_schedule_events,
 	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
