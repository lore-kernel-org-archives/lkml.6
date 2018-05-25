Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965798AbeEYJt1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:49:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58369 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965457AbeEYJtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:49:24 -0400
Date: Fri, 25 May 2018 02:48:59 -0700
From: tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-a1150c202207cc8501bebc45b63c264f91959260@git.kernel.org>
Cc: songliubraving@fb.com, eranian@google.com, peterz@infradead.org,
        hpa@zytor.com, mingo@kernel.org, kernel-team@fb.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, acme@redhat.com, vincent.weaver@maine.edu
Reply-To: vincent.weaver@maine.edu, jolsa@redhat.com, acme@redhat.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org,
        kernel-team@fb.com, peterz@infradead.org, eranian@google.com,
        songliubraving@fb.com, hpa@zytor.com
In-Reply-To: <20180503194716.162815-1-songliubraving@fb.com>
References: <20180503194716.162815-1-songliubraving@fb.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core: Fix group scheduling with mixed hw and
 sw events
Git-Commit-ID: a1150c202207cc8501bebc45b63c264f91959260
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

Commit-ID:  a1150c202207cc8501bebc45b63c264f91959260
Gitweb:     https://git.kernel.org/tip/a1150c202207cc8501bebc45b63c264f91959260
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Thu, 3 May 2018 12:47:16 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 25 May 2018 08:11:10 +0200

perf/core: Fix group scheduling with mixed hw and sw events

When hw and sw events are mixed in the same group, they are all attached
to the hw perf_event_context. This sometimes requires moving group of
perf_event to a different context.

We found a bug in how the kernel handles this, for example if we do:

   perf stat -e '{faults,ref-cycles,faults}'  -I 1000

     1.005591180              1,297      faults
     1.005591180        457,476,576      ref-cycles
     1.005591180    <not supported>      faults

First, sw event "faults" is attached to the sw context, and becomes the
group leader. Then, hw event "ref-cycles" is attached, so both events
are moved to the hw context. Last, another sw "faults" tries to attach,
but it fails because of mismatch between the new target ctx (from sw
pmu) and the group_leader's ctx (hw context, same as ref-cycles).

The broken condition is:
   group_leader is sw event;
   group_leader is on hw context;
   add a sw event to the group.

Fix this scenario by checking group_leader's context (instead of just
event type). If group_leader is on hw context, use the ->pmu of this
context to look up context for the new event.

Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <kernel-team@fb.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: b04243ef7006 ("perf: Complete software pmu grouping")
Link: http://lkml.kernel.org/r/20180503194716.162815-1-songliubraving@fb.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/perf_event.h |  8 ++++++++
 kernel/events/core.c       | 21 +++++++++++----------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e71e99eb9a4e..def866f7269b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1016,6 +1016,14 @@ static inline int is_software_event(struct perf_event *event)
 	return event->event_caps & PERF_EV_CAP_SOFTWARE;
 }
 
+/*
+ * Return 1 for event in sw context, 0 for event in hw context
+ */
+static inline int in_software_context(struct perf_event *event)
+{
+	return event->ctx->pmu->task_ctx_nr == perf_sw_context;
+}
+
 extern struct static_key perf_swevent_enabled[PERF_COUNT_SW_MAX];
 
 extern void ___perf_sw_event(u32, u64, struct pt_regs *, u64);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 67612ce359ad..ce6aa5ff3c96 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10521,19 +10521,20 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (pmu->task_ctx_nr == perf_sw_context)
 		event->event_caps |= PERF_EV_CAP_SOFTWARE;
 
-	if (group_leader &&
-	    (is_software_event(event) != is_software_event(group_leader))) {
-		if (is_software_event(event)) {
+	if (group_leader) {
+		if (is_software_event(event) &&
+		    !in_software_context(group_leader)) {
 			/*
-			 * If event and group_leader are not both a software
-			 * event, and event is, then group leader is not.
+			 * If the event is a sw event, but the group_leader
+			 * is on hw context.
 			 *
-			 * Allow the addition of software events to !software
-			 * groups, this is safe because software events never
-			 * fail to schedule.
+			 * Allow the addition of software events to hw
+			 * groups, this is safe because software events
+			 * never fail to schedule.
 			 */
-			pmu = group_leader->pmu;
-		} else if (is_software_event(group_leader) &&
+			pmu = group_leader->ctx->pmu;
+		} else if (!is_software_event(event) &&
+			   is_software_event(group_leader) &&
 			   (group_leader->group_caps & PERF_EV_CAP_SOFTWARE)) {
 			/*
 			 * In case the group is a pure software group, and we
