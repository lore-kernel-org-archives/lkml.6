Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeBIABk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 19:01:40 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47536 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751786AbeBIABj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 19:01:39 -0500
Smtp-Origin-Hostprefix: devbig
From: Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig102.frc2.facebook.com
To: <linux-kernel@vger.kernel.org>, <peterz@infradead.org>
CC: <kernel-team@fb.com>, <ak@linux.intel.com>, <kan.liang@intel.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: frc2c02
Subject: [RFC perf] perf: try schedule more hw events, even when previous groups failed
Date: Thu, 8 Feb 2018 15:59:48 -0800
Message-ID: <20180208235948.2222416-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current perf event scheduling, once a hw group failed to schedule, we
will not try to schedule other hw groups in the list. This behavior is
reasonable in most cases, but it is weird with ref-cycles on Intel CPUs.

For recent Intel CPUs, ref-cycles can only be served on fixed PMC
counter2. If there are two perf_events for ref-cycles, schedule will
fail even when there are still free PMC. Then the scheduler will not
try other events. In the following example, there are always free PMC
for event "cycles", but it is only scheduled 66% of time.

[root@localhost ~] perf stat -C 0 -e cycles,ref-cycles,ref-cycles  -- sleep 1
 Performance counter stats for 'CPU(s) 0':

        50,197,136      cycles                             (66.64%)
        70,278,035      ref-cycles                         (66.67%)
        73,521,750      ref-cycles                         (33.33%)

       1.000860603 seconds time elapsed

This patch slightly change the behavior of the scheduler by always try
all event groups. With the patch, the same perf command will monitor
cycles 100% of time.

[root@localhost ~]# perf stat -C 0 -e cycles,ref-cycles,ref-cycles  -- sleep 1
 Performance counter stats for 'CPU(s) 0':

        48,737,503      cycles
        81,706,878      ref-cycles                         (66.63%)
        78,632,325      ref-cycles                         (33.37%)

       1.001283168 seconds time elapsed

I understand that this will make scheduling more expensive for some use
cases. It can be improved by exposing more information from
event_sched_in() and use different strategies for ref-cycles conflicts
and all PMC busy cases. But that would be a much bigger change, so I
would like suggestions before moving ahead with it.

Please share your comments and suggestions on this.

Thanks in advance.
---
 kernel/events/core.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5a54630..efdae82 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2159,8 +2159,7 @@ group_sched_in(struct perf_event *group_event,
  * Work out whether we can put this event group on the CPU now.
  */
 static int group_can_go_on(struct perf_event *event,
-			   struct perf_cpu_context *cpuctx,
-			   int can_add_hw)
+			   struct perf_cpu_context *cpuctx)
 {
 	/*
 	 * Groups consisting entirely of software events can always go on.
@@ -2179,11 +2178,8 @@ static int group_can_go_on(struct perf_event *event,
 	 */
 	if (event->attr.exclusive && cpuctx->active_oncpu)
 		return 0;
-	/*
-	 * Otherwise, try to add it if all previous groups were able
-	 * to go on.
-	 */
-	return can_add_hw;
+
+	return 1;
 }
 
 static void add_event_to_ctx(struct perf_event *event,
@@ -3004,7 +3000,7 @@ ctx_pinned_sched_in(struct perf_event_context *ctx,
 		if (!event_filter_match(event))
 			continue;
 
-		if (group_can_go_on(event, cpuctx, 1))
+		if (group_can_go_on(event, cpuctx))
 			group_sched_in(event, cpuctx, ctx);
 
 		/*
@@ -3021,7 +3017,6 @@ ctx_flexible_sched_in(struct perf_event_context *ctx,
 		      struct perf_cpu_context *cpuctx)
 {
 	struct perf_event *event;
-	int can_add_hw = 1;
 
 	list_for_each_entry(event, &ctx->flexible_groups, group_entry) {
 		/* Ignore events in OFF or ERROR state */
@@ -3034,10 +3029,8 @@ ctx_flexible_sched_in(struct perf_event_context *ctx,
 		if (!event_filter_match(event))
 			continue;
 
-		if (group_can_go_on(event, cpuctx, can_add_hw)) {
-			if (group_sched_in(event, cpuctx, ctx))
-				can_add_hw = 0;
-		}
+		if (group_can_go_on(event, cpuctx))
+			group_sched_in(event, cpuctx, ctx);
 	}
 }
 
-- 
2.9.5
