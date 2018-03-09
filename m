Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbeCIJLH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:11:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51379 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbeCIJLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:11:04 -0500
Date: Fri, 9 Mar 2018 01:09:41 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-5bee2cc69d986e20808c93c46f7b6aef51edd827@git.kernel.org>
Cc: mingo@kernel.org, torvalds@linux-foundation.org, tglx@linutronix.de,
        jolsa@redhat.com, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, vincent.weaver@maine.edu, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, eranian@google.com,
        acme@redhat.com, peterz@infradead.org
Reply-To: kan.liang@linux.intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        torvalds@linux-foundation.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, acme@redhat.com, eranian@google.com,
        hpa@zytor.com, vincent.weaver@maine.edu
In-Reply-To: <1518474035-21006-4-git-send-email-kan.liang@linux.intel.com>
References: <1518474035-21006-4-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/ds: Introduce ->read() function for
 auto-reload events and flush the PEBS buffer there
Git-Commit-ID: 5bee2cc69d986e20808c93c46f7b6aef51edd827
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

Commit-ID:  5bee2cc69d986e20808c93c46f7b6aef51edd827
Gitweb:     https://git.kernel.org/tip/5bee2cc69d986e20808c93c46f7b6aef51edd827
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 12 Feb 2018 14:20:33 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 08:22:21 +0100

perf/x86/intel/ds: Introduce ->read() function for auto-reload events and flush the PEBS buffer there

There is no way to get exact auto-reload times and values which are needed
for event updates unless we flush the PEBS buffer.

Introduce intel_pmu_auto_reload_read() to drain the PEBS buffer for
auto reload event. To prevent races with the hardware, we can only
call drain_pebs() when the PMU is disabled.

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
Link: http://lkml.kernel.org/r/1518474035-21006-4-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/ds.c   | 9 +++++++++
 arch/x86/events/perf_event.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index f39a4df3a7bd..73844025adaf 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1306,6 +1306,15 @@ get_next_pebs_record_by_bit(void *base, void *top, int bit)
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
index d445f0026989..91643472f385 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -924,6 +924,8 @@ void intel_pmu_pebs_disable_all(void);
 
 void intel_pmu_pebs_sched_task(struct perf_event_context *ctx, bool sched_in);
 
+void intel_pmu_auto_reload_read(struct perf_event *event);
+
 void intel_ds_init(void);
 
 void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in);
