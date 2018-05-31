Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755075AbeEaMda (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:33:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46257 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754801AbeEaMd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:33:26 -0400
Date: Thu, 31 May 2018 05:33:06 -0700
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-5a6c9d94e9ed7410142bc6fcb638a4db1895aa0c@git.kernel.org>
Cc: peterz@infradead.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, kan.liang@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, kan.liang@intel.com
In-Reply-To: <1525371913-10597-7-git-send-email-kan.liang@intel.com>
References: <1525371913-10597-7-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/uncore: Expose uncore_pmu_event*()
 functions
Git-Commit-ID: 5a6c9d94e9ed7410142bc6fcb638a4db1895aa0c
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

Commit-ID:  5a6c9d94e9ed7410142bc6fcb638a4db1895aa0c
Gitweb:     https://git.kernel.org/tip/5a6c9d94e9ed7410142bc6fcb638a4db1895aa0c
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 3 May 2018 11:25:12 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 31 May 2018 12:36:28 +0200

perf/x86/intel/uncore: Expose uncore_pmu_event*() functions

Some uncores have customized PMU. For customized PMU, it does not need
to customize everything. For example, it only needs to customize init()
function for client IMC uncore. Other functions like
add()/del()/start()/stop()/read() can use generic code.

Expose the uncore_pmu_event_add/del/start/stop() functions.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: acme@kernel.org
Cc: eranian@google.com
Link: http://lkml.kernel.org/r/1525371913-10597-7-git-send-email-kan.liang@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore.c | 8 ++++----
 arch/x86/events/intel/uncore.h | 4 ++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 0a6f6973690b..15b07379e72d 100644
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
index eb0265359019..c9e1e0bef3c3 100644
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
