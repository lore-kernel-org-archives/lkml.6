Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeECTsj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 15:48:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42964 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751178AbeECTsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 15:48:38 -0400
Smtp-Origin-Hostprefix: devbig
From: Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To: <linux-kernel@vger.kernel.org>
CC: Song Liu <songliubraving@fb.com>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH] perf: fix group with mixed hw and sw events
Date: Thu, 3 May 2018 12:47:16 -0700
Message-ID: <20180503194716.162815-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hw and sw events are mixed in the same group, they are all attached
to the hw perf_event_context. This sometimes requires moving group of
perf_event to a different context. We found an issue in the moving. Here
is an example of it.

   perf stat -e '{faults,ref-cycles,faults}'  -I 1000

     1.005591180              1,297      faults
     1.005591180        457,476,576      ref-cycles
     1.005591180    <not supported>      faults

First, sw event "faults" is attached to the sw context, and become the
group leader. Then, hw event "ref-cycles" is attached, so both events
are moved to hw context. Last, another sw "faults" tries to attach,
but it fails because of mismatch between the new target ctx (from sw
pmu) and the group_leader's ctx (hw context, same as ref-cycles).

The broken condition is:
   group_leader is sw event;
   group_leader is on hw context;
   add a sw event to the group.

This patch fixes this scenario by checking group_leader's context
(instead of just event type). If group_leader is on hw context, use
pmu of this context to look up context for the new event.

Fixes: b04243ef7006 ("perf: Complete software pmu grouping")
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/perf_event.h |  8 ++++++++
 kernel/events/core.c       | 21 +++++++++++----------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e71e99e..def866f 100644
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
index 67612ce..ce6aa5f 100644
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
-- 
2.9.5
