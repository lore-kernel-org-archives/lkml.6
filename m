Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbeEDXLu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 19:11:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55802 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751823AbeEDXLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 19:11:49 -0400
Smtp-Origin-Hostprefix: devbig
From: Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To: <linux-kernel@vger.kernel.org>
CC: Song Liu <songliubraving@fb.com>, <kernel-team@fb.com>,
        <tj@kernel.org>, <peterz@infradead.org>, <jolsa@kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [RFC 2/2] perf: Sharing PMU counters across compatible events
Date: Fri, 4 May 2018 16:11:02 -0700
Message-ID: <20180504231102.2850679-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180504231102.2850679-1-songliubraving@fb.com>
References: <20180504231102.2850679-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-04_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to enable PMU sharing. To make perf event scheduling
fast, we use special data structures.

An array of "struct perf_event_dup" is added to the cpuctx, to remember
all the duplicated events under this cpuctx. All the events under this
cpuctx has a "dup_id" pointing to its perf_event_dup. Compatible events
under the same cpuctx share the same perf_event_dup. The following figure
shows a simplified version of the data structure.

   cpuctx ->  perf_event_dup -> master
                     ^       -> active_dup (list)
                     |
         perf_event /|
                     |
         perf_event /

Connection among perf_event and perf_event_dup are built with function
rebuild_event_dup_list(cpuctx). This function is only called when events
are added/removed or when a task is scheduled in/out. So it is not on
critical path of perf_rotate_context().

On the critical paths, perf_events are added to/removed from the
active_dup list of the perf_event. The first event added to the list
will be the master event, and the only event that runs pmu->add().
Later events will all refer to this master for read().

   cpuctx ->  perf_event_dup -> master
                     ^       -> active_dup (list)
                     |             ^  ^
         perf_event /|  ----------/   |
                     |                |
         perf_event /   -------------/

Similarly, on event_sched_out path, only the last event calls
pmu->del().

The following functions are introduced to add/remove/move events
in the active_dup list, and update master accordingly:

    event_dup_try_add_follower();
    event_dup_setup_master();
    event_dup_sched_out().
    pdup_adjust_offsets().

Given the data structure above, all these functions have O(1) execution
time. Therefore, this change does not increase the complexity of perf
event scheduling.

Cc: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/perf_event.h |  50 +++++++++
 kernel/events/core.c       | 252 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 284 insertions(+), 18 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 4c84549..af9f269 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -702,6 +702,12 @@ struct perf_event {
 #endif
 
 	struct list_head		sb_list;
+
+	/* for PMU sharing */
+	int				dup_id;
+	struct list_head		dup_sibling_entry;
+	u64				dup_base_count;
+	u64				dup_base_child_count;
 #endif /* CONFIG_PERF_EVENTS */
 };
 
@@ -774,6 +780,47 @@ struct perf_event_context {
  */
 #define PERF_NR_CONTEXTS	4
 
+struct perf_event_dup {
+	struct perf_event	*first;		/* first event of this type */
+	struct perf_event	*master;	/* active event */
+	struct list_head	active_dup;	/* list of active events */
+
+	/*
+	 * When we switch active master, the new master will not have same
+	 * count/child_count as previous master, so future reads of these
+	 * values will not be accurate. To fix this, we add an offset to
+	 * all readings from the sensor. The offset is adjusted accordingly
+	 * when we switch master.
+	 */
+	s64			count_offset;
+	s64			child_count_offset;
+};
+
+static inline u64 pdup_read_count(struct perf_event_dup *pdup)
+{
+	return local64_read(&pdup->master->count) + pdup->count_offset;
+}
+
+static inline u64 pdup_read_child_count(struct perf_event_dup *pdup)
+{
+	return atomic64_read(&pdup->master->child_count) +
+		pdup->child_count_offset;
+}
+
+static inline void pdup_switch_master(struct perf_event_dup *pdup,
+				      struct perf_event *old_master,
+				      struct perf_event *new_master)
+{
+	/* adjust offset */
+	pdup->count_offset += local64_read(&old_master->count) -
+		local64_read(&new_master->count);
+	pdup->child_count_offset += atomic64_read(&old_master->child_count) -
+		atomic64_read(&new_master->child_count);
+	/* move data */
+	if (old_master->pmu->move_dup)
+		old_master->pmu->move_dup(old_master, new_master);
+}
+
 /**
  * struct perf_event_cpu_context - per cpu event context structure
  */
@@ -797,6 +844,9 @@ struct perf_cpu_context {
 	int				sched_cb_usage;
 
 	int				online;
+
+	struct perf_event_dup		*dup_event_list;
+	int				dup_event_count;
 };
 
 struct perf_output_handle {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index bec1840..79de462 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1982,6 +1982,94 @@ event_filter_match(struct perf_event *event)
 	       perf_cgroup_match(event) && pmu_filter_match(event);
 }
 
+static void event_dup_sync(struct perf_event *event,
+			   struct perf_cpu_context *cpuctx);
+
+/*
+ * If an dup event is already active, add this event as follower, and
+ * return 0; otherwise, return -EAGAIN
+ *
+ * RFC NOTE: this an o(1) operation
+ */
+static int event_dup_try_add_follower(struct perf_event *event,
+				      struct perf_cpu_context *cpuctx)
+{
+	struct perf_event_dup *pdup;
+
+	if (event->dup_id >= cpuctx->dup_event_count)
+		return -EAGAIN;
+
+	pdup = &cpuctx->dup_event_list[event->dup_id];
+	if (list_empty(&pdup->active_dup))
+		return -EAGAIN;
+
+	list_add_tail(&event->dup_sibling_entry, &pdup->active_dup);
+	pdup->master->pmu->read(pdup->master);
+	event->dup_base_count = pdup_read_count(pdup);
+	event->dup_base_child_count = pdup_read_child_count(pdup);
+	return 0;
+}
+
+/*
+ * make the (just pmu->add()ed) event the active master of this dup
+ *
+ * RFC NOTE: this an o(1) operation
+ */
+static void event_dup_setup_master(struct perf_event *event,
+				   struct perf_cpu_context *cpuctx)
+{
+	struct perf_event_dup *pdup;
+
+	if (event->dup_id >= cpuctx->dup_event_count)
+		return;
+
+	pdup = &cpuctx->dup_event_list[event->dup_id];
+	WARN_ON(pdup->master != NULL);
+	WARN_ON(!list_empty(&pdup->active_dup));
+
+	cpuctx->dup_event_list[event->dup_id].master = event;
+	list_add_tail(&event->dup_sibling_entry, &pdup->active_dup);
+	cpuctx->dup_event_list[event->dup_id].count_offset = 0;
+	cpuctx->dup_event_list[event->dup_id].child_count_offset = 0;
+}
+
+/*
+ * remove event from the dup list; if it is the master, and there are
+ * other active events, promote another event as the new master.
+ *
+ * return 0, if it is there are more active events in this dup;
+ * return -EAGAIN, if it is the last active event
+ *
+ * RFC NOTE: this an o(1) operation
+ */
+static int event_dup_sched_out(struct perf_event *event,
+			       struct perf_cpu_context *cpuctx)
+{
+	struct perf_event_dup *pdup;
+
+	if (event->dup_id >= cpuctx->dup_event_count)
+		return -EAGAIN;
+
+	pdup = &cpuctx->dup_event_list[event->dup_id];
+	list_del_init(&event->dup_sibling_entry);
+	if (event == pdup->master ) {
+		if (list_empty(&pdup->active_dup)) {
+			pdup->master = NULL;
+			return -EAGAIN;
+		} else {
+			struct perf_event *new_master;
+
+			new_master = list_first_entry(
+				&cpuctx->dup_event_list[event->dup_id].active_dup,
+				struct perf_event, dup_sibling_entry);
+			event_dup_sync(new_master, cpuctx);
+			pdup_switch_master(pdup, event, new_master);
+			pdup->master = new_master;
+		}
+	}
+	return 0;
+}
+
 static void
 event_sched_out(struct perf_event *event,
 		  struct perf_cpu_context *cpuctx,
@@ -2004,7 +2092,8 @@ event_sched_out(struct perf_event *event,
 
 	perf_pmu_disable(event->pmu);
 
-	event->pmu->del(event, 0);
+	if (event_dup_sched_out(event, cpuctx))
+		event->pmu->del(event, 0);
 	event->oncpu = -1;
 
 	if (event->pending_disable) {
@@ -2051,6 +2140,8 @@ group_sched_out(struct perf_event *group_event,
 		cpuctx->exclusive = 0;
 }
 
+static void rebuild_event_dup_list(struct perf_cpu_context *cpuctx);
+
 #define DETACH_GROUP	0x01UL
 
 /*
@@ -2084,6 +2175,7 @@ __perf_remove_from_context(struct perf_event *event,
 			cpuctx->task_ctx = NULL;
 		}
 	}
+	rebuild_event_dup_list(cpuctx);
 }
 
 /*
@@ -2276,11 +2368,14 @@ event_sched_in(struct perf_event *event,
 
 	perf_log_itrace_start(event);
 
-	if (event->pmu->add(event, PERF_EF_START)) {
-		perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
-		event->oncpu = -1;
-		ret = -EAGAIN;
-		goto out;
+	if (event_dup_try_add_follower(event, cpuctx)) {
+		if (event->pmu->add(event, PERF_EF_START)) {
+			perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
+			event->oncpu = -1;
+			ret = -EAGAIN;
+			goto out;
+		}
+		event_dup_setup_master(event, cpuctx);
 	}
 
 	if (!is_software_event(event))
@@ -2536,7 +2631,7 @@ static int  __perf_install_in_context(void *info)
 
 unlock:
 	perf_ctx_unlock(cpuctx, task_ctx);
-
+	rebuild_event_dup_list(cpuctx);
 	return ret;
 }
 
@@ -2919,8 +3014,10 @@ static void ctx_sched_out(struct perf_event_context *ctx,
 
 	if (ctx->task) {
 		WARN_ON_ONCE(cpuctx->task_ctx != ctx);
-		if (!ctx->is_active)
+		if (!ctx->is_active) {
 			cpuctx->task_ctx = NULL;
+			rebuild_event_dup_list(cpuctx);
+		}
 	}
 
 	/*
@@ -2995,6 +3092,49 @@ static int context_equiv(struct perf_event_context *ctx1,
 	return 0;
 }
 
+/*
+ * sync data read from dup master
+ *
+ * RFC NOTE: this an o(1) operation
+ */
+static void event_dup_sync(struct perf_event *event,
+			   struct perf_cpu_context *cpuctx)
+{
+	struct perf_event *master;
+	struct perf_event_dup *pdup;
+	u64 new_count, new_child_count;
+
+	pdup = &cpuctx->dup_event_list[event->dup_id];
+	master = pdup->master;
+	WARN_ON(master == event);
+
+	master->pmu->read(master);
+	new_count = pdup_read_count(pdup);
+	new_child_count = pdup_read_child_count(pdup);
+
+	local64_add(new_count - event->dup_base_count, &event->count);
+	atomic64_add(new_child_count - event->dup_base_child_count,
+		     &event->child_count);
+
+	event->dup_base_count = new_count;
+	event->dup_base_child_count = new_child_count;
+}
+
+static void event_pmu_read(struct perf_event *event)
+{
+	struct perf_cpu_context *cpuctx;
+
+	if (list_empty(&event->dup_sibling_entry)) {
+		event->pmu->read(event);
+	} else {
+		cpuctx = __get_cpu_context(event->ctx);
+		if (event == cpuctx->dup_event_list[event->dup_id].master)
+			event->pmu->read(event);
+		else
+			event_dup_sync(event, cpuctx);
+	}
+}
+
 static void __perf_event_sync_stat(struct perf_event *event,
 				     struct perf_event *next_event)
 {
@@ -3011,7 +3151,7 @@ static void __perf_event_sync_stat(struct perf_event *event,
 	 * don't need to use it.
 	 */
 	if (event->state == PERF_EVENT_STATE_ACTIVE)
-		event->pmu->read(event);
+		event_pmu_read(event);
 
 	perf_event_update_time(event);
 
@@ -3366,9 +3506,10 @@ ctx_sched_in(struct perf_event_context *ctx,
 
 	ctx->is_active |= (event_type | EVENT_TIME);
 	if (ctx->task) {
-		if (!is_active)
+		if (!is_active) {
 			cpuctx->task_ctx = ctx;
-		else
+			rebuild_event_dup_list(cpuctx);
+		} else
 			WARN_ON_ONCE(cpuctx->task_ctx != ctx);
 	}
 
@@ -3402,6 +3543,71 @@ static void cpu_ctx_sched_in(struct perf_cpu_context *cpuctx,
 	ctx_sched_in(ctx, cpuctx, event_type, task);
 }
 
+static void add_event_to_dup_event_list(struct perf_event *event,
+					struct perf_cpu_context *cpuctx)
+{
+	int i;
+
+	for (i = 0; i < cpuctx->dup_event_count; ++i)
+		if (memcmp(&event->attr,
+			   &cpuctx->dup_event_list[i].first->attr,
+			   sizeof(event->attr)) == 0) {
+			event->dup_id = i;
+			return;
+		}
+	i = cpuctx->dup_event_count++;
+	cpuctx->dup_event_list[i].first = event;
+	cpuctx->dup_event_list[i].master = NULL;
+	INIT_LIST_HEAD(&cpuctx->dup_event_list[i].active_dup);
+	event->dup_id = i;
+	INIT_LIST_HEAD(&event->dup_sibling_entry);
+}
+
+static int add_group_to_dup_event_list(struct perf_event *event, void *data)
+{
+	struct sched_in_data *sid = data;
+	struct perf_event *sibling;
+
+	add_event_to_dup_event_list(event, sid->cpuctx);
+	for_each_sibling_event(sibling, event)
+		add_event_to_dup_event_list(sibling, sid->cpuctx);
+
+	return 0;
+}
+
+static void rebuild_event_dup_list(struct perf_cpu_context *cpuctx)
+{
+	int dup_count = cpuctx->ctx.nr_events;
+	struct perf_event_context *ctx = cpuctx->task_ctx;
+	struct sched_in_data sid = {
+		.ctx = ctx,
+		.cpuctx = cpuctx,
+		.can_add_hw = 1,
+	};
+
+	if (ctx)
+		dup_count += ctx->nr_events;
+
+	kfree(cpuctx->dup_event_list);
+	cpuctx->dup_event_count = 0;
+
+	cpuctx->dup_event_list =
+		kzalloc(sizeof(struct perf_event_dup) * dup_count, GFP_ATOMIC);
+	if (!cpuctx->dup_event_list)
+		return;
+
+	visit_groups_merge(&cpuctx->ctx.pinned_groups, smp_processor_id(),
+			   add_group_to_dup_event_list, &sid);
+	visit_groups_merge(&cpuctx->ctx.flexible_groups, smp_processor_id(),
+			   add_group_to_dup_event_list, &sid);
+	if (ctx) {
+		visit_groups_merge(&ctx->pinned_groups, smp_processor_id(),
+				   add_group_to_dup_event_list, &sid);
+		visit_groups_merge(&ctx->flexible_groups, smp_processor_id(),
+				   add_group_to_dup_event_list, &sid);
+	}
+}
+
 static void perf_event_context_sched_in(struct perf_event_context *ctx,
 					struct task_struct *task)
 {
@@ -3867,14 +4073,14 @@ static void __perf_event_read(void *info)
 		goto unlock;
 
 	if (!data->group) {
-		pmu->read(event);
+		event_pmu_read(event);
 		data->ret = 0;
 		goto unlock;
 	}
 
 	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
 
-	pmu->read(event);
+	event_pmu_read(event);
 
 	for_each_sibling_event(sub, event) {
 		if (sub->state == PERF_EVENT_STATE_ACTIVE) {
@@ -3882,7 +4088,7 @@ static void __perf_event_read(void *info)
 			 * Use sibling's PMU rather than @event's since
 			 * sibling could be on different (eg: software) PMU.
 			 */
-			sub->pmu->read(sub);
+			event_pmu_read(sub);
 		}
 	}
 
@@ -3946,7 +4152,7 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 	 * oncpu == -1).
 	 */
 	if (event->oncpu == smp_processor_id())
-		event->pmu->read(event);
+		event_pmu_read(event);
 
 	*value = local64_read(&event->count);
 	if (enabled || running) {
@@ -6085,7 +6291,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 
 	if ((leader != event) &&
 	    (leader->state == PERF_EVENT_STATE_ACTIVE))
-		leader->pmu->read(leader);
+		event_pmu_read(leader);
 
 	values[n++] = perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
@@ -6098,7 +6304,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 
 		if ((sub != event) &&
 		    (sub->state == PERF_EVENT_STATE_ACTIVE))
-			sub->pmu->read(sub);
+			event_pmu_read(sub);
 
 		values[n++] = perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
@@ -9107,7 +9313,7 @@ static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
 	if (event->state != PERF_EVENT_STATE_ACTIVE)
 		return HRTIMER_NORESTART;
 
-	event->pmu->read(event);
+	event_pmu_read(event);
 
 	perf_sample_data_init(&data, 0, event->hw.last_period);
 	regs = get_irq_regs();
@@ -9416,6 +9622,8 @@ static struct perf_cpu_context __percpu *find_pmu_context(int ctxn)
 
 static void free_pmu_context(struct pmu *pmu)
 {
+	int cpu;
+
 	/*
 	 * Static contexts such as perf_sw_context have a global lifetime
 	 * and may be shared between different PMUs. Avoid freeing them
@@ -9425,6 +9633,12 @@ static void free_pmu_context(struct pmu *pmu)
 		return;
 
 	mutex_lock(&pmus_lock);
+	for_each_possible_cpu(cpu) {
+		struct perf_cpu_context *cpuctx;
+
+		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
+		kfree(cpuctx->dup_event_list);
+	}
 	free_percpu(pmu->pmu_cpu_context);
 	mutex_unlock(&pmus_lock);
 }
@@ -9629,6 +9843,7 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		cpuctx->ctx.pmu = pmu;
 		cpuctx->online = cpumask_test_cpu(cpu, perf_online_mask);
 
+		rebuild_event_dup_list(cpuctx);
 		__perf_mux_hrtimer_init(cpuctx, cpu);
 	}
 
@@ -9945,6 +10160,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	INIT_LIST_HEAD(&event->addr_filters.list);
 	INIT_HLIST_NODE(&event->hlist_entry);
 
+	INIT_LIST_HEAD(&event->dup_sibling_entry);
 
 	init_waitqueue_head(&event->waitq);
 	init_irq_work(&event->pending, perf_pending_event);
-- 
2.9.5
