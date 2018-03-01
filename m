Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034156AbeCATxh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 14:53:37 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57378 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1033254AbeCATxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 14:53:35 -0500
Smtp-Origin-Hostprefix: devbig
From: Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig102.frc2.facebook.com
To: <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <jolsa@redhat.com>
CC: <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: frc2c02
Subject: [RFC] perf: a different approach to perf_rotate_context()
Date: Thu, 1 Mar 2018 11:53:21 -0800
Message-ID: <20180301195321.2608515-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there are more perf_event's than hardware PMCs, perf rotate events
so that all events get chance to run. Currently, the rotation works as:
  sched_out flexible_groups in cpuctx->ctx and cpuctx->task_ctx;
  rotate_left flexible_groups in cpuctx->ctx and cpuctx->task_ctx;
  try sched_in flexible_groups in cpuctx->ctx;
  try sched_in flexible_groups in cpuctx->task_ctx.

This approach has some potential issues:
  1. if different rotations of flexible_groups in cpuctx->ctx occupy
     all hardware PMC, flexible_groups in cpuctx->task_ctx cannot run
     at all.
  2. if pinned_groups occupy all hardware PMC, the rotation triggers per
     perf_event_mux_interval_ms. But it couldn't schedule any events.
  3. since flexible_groups in cpuctx->ctx and cpuctx->task_ctx are
     rotated separately, there are N x M possible combinations. It is
     difficult to remember all the rotation combinations and reuse these
     combinations. As a result, it is necessary to try sched_in the
     flexible_groups on each rotation.

This patch tries to do the rotation differently. Each perf_event in the
cpuctx (ctx and task_ctx) is assigned a rotation_id. The rotation_id's
are assigned during the first few rotations after any changes in
perf_events attached to the cpuctx. Once all the rotation_id's are
assigned for all events in the cpuctx, perf_rotate_context() simply
picks the next rotation to use, so there is no more "try to sched_in"
for future rotations.

Special rotation_id's are introduced to handle the issues above.
flexible_groups that conflicts with pinned_groups are marked as
ALWAYS_OFF, so they are not rotated (fixes issue 2). flexible_groups
in cpuctx->ctx and cpuctx->task_ctx are rotated together, so they all get
equal chance to run (improves issue 1).

With this approach, we only do complex scheduling of flexible_groups
once. This enables us to do more complex schduling, for example, Sharing
PMU counters across compatible events:
   https://lkml.org/lkml/2017/12/1/410.

There are also some potential downsides of this approach.

First, it gives all flexible_groups exactly same chance to run, so it
may waste some PMC cycles. For examples, if 5 groups, ABCDE, are assigned
to two rotations: rotation-0: ABCD and rotation-1: E, this approach will
NOT try any of ABCD in rotation-1.

Second, flexible_groups in cpuctx->ctx and cpuctx->task_ctx now have
exact same priority and equal chance to run. I am not sure whether this
will change the behavior in some use cases.

Please kindly let me know whether this approach makes sense.

Thanks in advance!
Song
---
 include/linux/perf_event.h |  23 ++++++
 kernel/events/core.c       | 194 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 185 insertions(+), 32 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7546822..3d8723e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -560,6 +560,21 @@ struct perf_event {
 	struct list_head		sibling_list;
 
 	/*
+	 * When there is more perf_event than hardware PMC, we rotate
+	 * flexible perf_event groups. Each group is assigned a
+	 * rotation_id, and the groups will run on its own rotation.
+	 * Normal rotation_id counts from 0. Special rotation_id shows
+	 * different scheduling of the event:
+	 *   -1: no rotation_id assigned;
+	 *   -2: always_on (software groups);
+	 *   -3: always_off (conflicts with pinned groups).
+	 */
+#define PERF_ROTATION_ID_NOT_ASSGINED	(-1)
+#define PERF_ROTATION_ID_ALWAYS_ON	(-2)
+#define PERF_ROTATION_ID_ALWAYS_OFF	(-3)
+	int 				rotation_id;
+
+	/*
 	 * We need storage to track the entries in perf_pmu_migrate_context; we
 	 * cannot use the event_entry because of RCU and we want to keep the
 	 * group in tact which avoids us using the other two entries.
@@ -741,6 +756,14 @@ struct perf_event_context {
 #endif
 	void				*task_ctx_data; /* pmu specific data */
 	struct rcu_head			rcu_head;
+
+	/* number of rotations and current rotation for flexible_groups */
+	int				num_rotations;
+	int				curr_rotation;
+	/* number of groups in flexible_groups */
+	int				nr_flexible;
+	/* number of groups that have been scheduled to a rotation */
+	int				nr_sched;
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5789810..373adf2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1661,6 +1661,9 @@ static void perf_group_attach(struct perf_event *event)
 		perf_event__header_size(pos);
 }
 
+static void ctx_reset_rotation(struct perf_event_context *ctx,
+			       struct perf_cpu_context *cpuctx);
+
 /*
  * Remove a event from the lists for its context.
  * Must be called with ctx->mutex and ctx->lock held.
@@ -1700,6 +1703,7 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	if (event->state > PERF_EVENT_STATE_OFF)
 		perf_event_set_state(event, PERF_EVENT_STATE_OFF);
 
+	ctx_reset_rotation(ctx, __get_cpu_context(ctx));
 	ctx->generation++;
 }
 
@@ -3016,13 +3020,74 @@ ctx_pinned_sched_in(struct perf_event_context *ctx,
 	}
 }
 
-static void
-ctx_flexible_sched_in(struct perf_event_context *ctx,
-		      struct perf_cpu_context *cpuctx)
+/* returns whether all flexible_groups have got a valid rotation_id */
+static bool flexible_sched_done(struct perf_cpu_context *cpuctx)
+{
+	struct perf_event_context *ctx;
+
+	if (cpuctx->ctx.nr_flexible != cpuctx->ctx.nr_sched)
+		return false;
+
+	ctx = cpuctx->task_ctx;
+
+	if (ctx && ctx->nr_flexible != ctx->nr_sched)
+		return false;
+	return true;
+}
+
+/* time to do the scheduling again, reset rotation_id's */
+static void ctx_reset_rotation(struct perf_event_context *ctx,
+			       struct perf_cpu_context *cpuctx)
+{
+	struct perf_event *event;
+
+	ctx->num_rotations = 0;
+	ctx->curr_rotation = 0;
+	ctx->nr_flexible = 0;
+	ctx->nr_sched = 0;
+
+	list_for_each_entry(event, &ctx->flexible_groups, group_entry) {
+		group_sched_out(event, cpuctx, ctx);
+		ctx->nr_flexible++;
+		event->rotation_id = PERF_ROTATION_ID_NOT_ASSGINED;
+	}
+}
+
+/*
+ * identify always_on and always_off groups in flexible_groups, call
+ * group_sched_in() for always_on groups
+ */
+static void ctx_pick_always_on_off_groups(struct perf_event_context *ctx,
+					  struct perf_cpu_context *cpuctx)
+{
+	struct perf_event *event;
+
+	list_for_each_entry(event, &ctx->flexible_groups, group_entry) {
+		if (event->group_caps & PERF_EV_CAP_SOFTWARE) {
+			event->rotation_id = PERF_ROTATION_ID_ALWAYS_ON;
+			ctx->nr_sched++;
+			WARN_ON(group_sched_in(event, cpuctx, ctx));
+			continue;
+		}
+		if (group_sched_in(event, cpuctx, ctx)) {
+			event->rotation_id = PERF_ROTATION_ID_ALWAYS_OFF;
+			ctx->nr_sched++;
+		}
+		group_sched_out(event, cpuctx, ctx);
+	}
+}
+
+/* add unassigned flexible_groups to new rotation_id */
+static void ctx_add_rotation(struct perf_event_context *ctx,
+			     struct perf_cpu_context *cpuctx)
 {
 	struct perf_event *event;
+	int group_added = 0;
 	int can_add_hw = 1;
 
+	ctx->curr_rotation = ctx->num_rotations;
+	ctx->num_rotations++;
+
 	list_for_each_entry(event, &ctx->flexible_groups, group_entry) {
 		/* Ignore events in OFF or ERROR state */
 		if (event->state <= PERF_EVENT_STATE_OFF)
@@ -3034,13 +3099,77 @@ ctx_flexible_sched_in(struct perf_event_context *ctx,
 		if (!event_filter_match(event))
 			continue;
 
+		if (event->rotation_id != PERF_ROTATION_ID_NOT_ASSGINED)
+			continue;
+
 		if (group_can_go_on(event, cpuctx, can_add_hw)) {
 			if (group_sched_in(event, cpuctx, ctx))
 				can_add_hw = 0;
+			else {
+				event->rotation_id = ctx->curr_rotation;
+				ctx->nr_sched++;
+				group_added++;
+			}
 		}
 	}
 }
 
+/* rotate in flexible_groups with the next rotation_id */
+static void ctx_switch_rotation_in(struct perf_event_context *ctx,
+				   struct perf_cpu_context *cpuctx)
+{
+	struct perf_event *event;
+
+	ctx->curr_rotation = (ctx->curr_rotation + 1) %
+		ctx->num_rotations;
+
+	list_for_each_entry(event, &ctx->flexible_groups, group_entry) {
+		/* Ignore events in OFF or ERROR state */
+		if (event->state <= PERF_EVENT_STATE_OFF)
+			continue;
+		/*
+		 * Listen to the 'cpu' scheduling filter constraint
+		 * of events:
+		 */
+		if (!event_filter_match(event))
+			continue;
+
+		if (event->rotation_id == ctx->curr_rotation)
+			WARN_ON(group_sched_in(event, cpuctx, ctx));
+	}
+}
+
+/* rotate out flexible_groups with current rotation_id */
+static void ctx_switch_rotation_out(struct perf_event_context *ctx,
+				    struct perf_cpu_context *cpuctx)
+{
+	struct perf_event *event;
+
+	list_for_each_entry(event, &ctx->flexible_groups, group_entry) {
+		/* Ignore events in OFF or ERROR state */
+		if (event->state <= PERF_EVENT_STATE_OFF)
+			continue;
+		/*
+		 * Listen to the 'cpu' scheduling filter constraint
+		 * of events:
+		 */
+		if (!event_filter_match(event))
+			continue;
+
+		if (event->rotation_id == ctx->curr_rotation)
+			group_sched_out(event, cpuctx, ctx);
+	}
+}
+
+static void
+ctx_flexible_sched_in(struct perf_event_context *ctx,
+		      struct perf_cpu_context *cpuctx)
+{
+	ctx_reset_rotation(ctx, cpuctx);
+	ctx_pick_always_on_off_groups(ctx, cpuctx);
+	ctx_add_rotation(ctx, cpuctx);
+}
+
 static void
 ctx_sched_in(struct perf_event_context *ctx,
 	     struct perf_cpu_context *cpuctx,
@@ -3347,34 +3476,15 @@ static void perf_adjust_freq_unthr_context(struct perf_event_context *ctx,
 	raw_spin_unlock(&ctx->lock);
 }
 
-/*
- * Round-robin a context's events:
- */
-static void rotate_ctx(struct perf_event_context *ctx)
-{
-	/*
-	 * Rotate the first entry last of non-pinned groups. Rotation might be
-	 * disabled by the inheritance code.
-	 */
-	if (!ctx->rotate_disable)
-		list_rotate_left(&ctx->flexible_groups);
-}
-
 static int perf_rotate_context(struct perf_cpu_context *cpuctx)
 {
-	struct perf_event_context *ctx = NULL;
+	struct perf_event_context *ctx = cpuctx->task_ctx;
 	int rotate = 0;
+	u64 now;
 
-	if (cpuctx->ctx.nr_events) {
-		if (cpuctx->ctx.nr_events != cpuctx->ctx.nr_active)
-			rotate = 1;
-	}
-
-	ctx = cpuctx->task_ctx;
-	if (ctx && ctx->nr_events) {
-		if (ctx->nr_events != ctx->nr_active)
-			rotate = 1;
-	}
+	if (!flexible_sched_done(cpuctx) ||
+	    cpuctx->ctx.num_rotations > 1)
+		rotate = 1;
 
 	if (!rotate)
 		goto done;
@@ -3382,15 +3492,35 @@ static int perf_rotate_context(struct perf_cpu_context *cpuctx)
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	perf_pmu_disable(cpuctx->ctx.pmu);
 
-	cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
+	update_context_time(&cpuctx->ctx);
 	if (ctx)
-		ctx_sched_out(ctx, cpuctx, EVENT_FLEXIBLE);
+		update_context_time(ctx);
+	update_cgrp_time_from_cpuctx(cpuctx);
 
-	rotate_ctx(&cpuctx->ctx);
+	ctx_switch_rotation_out(&cpuctx->ctx, cpuctx);
 	if (ctx)
-		rotate_ctx(ctx);
+		ctx_switch_rotation_out(ctx, cpuctx);
 
-	perf_event_sched_in(cpuctx, ctx, current);
+	if (flexible_sched_done(cpuctx)) {
+		/* simply repeat previous calculated rotations */
+		ctx_switch_rotation_in(&cpuctx->ctx, cpuctx);
+		if (ctx)
+			ctx_switch_rotation_in(ctx, cpuctx);
+	} else {
+		/* create new rotation */
+		ctx_add_rotation(&cpuctx->ctx, cpuctx);
+		if (ctx)
+			ctx_add_rotation(ctx, cpuctx);
+	}
+
+	now = perf_clock();
+	cpuctx->ctx.timestamp = now;
+	perf_cgroup_set_timestamp(current, &cpuctx->ctx);
+
+	if (ctx) {
+		ctx->timestamp = now;
+		perf_cgroup_set_timestamp(current, ctx);
+	}
 
 	perf_pmu_enable(cpuctx->ctx.pmu);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
-- 
2.9.5
