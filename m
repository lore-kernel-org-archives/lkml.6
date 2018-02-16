Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbeBPUkH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:40:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58944 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeBPUkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:40:03 -0500
Date: Fri, 16 Feb 2018 21:39:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Raghavendra Rao Ananta <rananta@codeaurora.org>
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mingo@redhat.com, cme@kernel.org,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        tsoni@codeaurora.org, skannan@codeaurora.org
Subject: Re: [PATCH 1/1] perf: Add CPU hotplug support for events
Message-ID: <20180216203953.GL25201@hirez.programming.kicks-ass.net>
References: <1518735701-7014-1-git-send-email-rananta@codeaurora.org>
 <1518735701-7014-2-git-send-email-rananta@codeaurora.org>
 <20180216082139.GF25181@hirez.programming.kicks-ass.net>
 <361ffd6f-3eec-4be6-de2f-40beb588c65e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <361ffd6f-3eec-4be6-de2f-40beb588c65e@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 10:06:29AM -0800, Raghavendra Rao Ananta wrote:
> > No this is absolutely disguisting. You can simply keep the events in the
> > dead CPU's context. It's really not that hard.
> Keeping the events in the dead CPU's context was also an idea that we had.
> However, detaching that event from the PMU when the CPU is offline would be
> a pain. Consider the scenario in which an event is about to be destroyed
> when the CPU is offline (yet still attached to the CPU). During it's
> destruction, a cross-cpu call is made (from perf_remove_from_context()) to
> the offlined CPU to detach the event from the CPU's PMU. As the CPU is
> offline, that would not be possible, and again a separate logic has to be
> written for cleaning up the events whose CPUs are offlined.

That is actually really simple to deal with. The real problems are with
semantics, is an event enabled when the CPU is dead? Can you
disable/enable an event on a dead CPU.

The below patch (_completely_ untested) should do most of it, but needs
help with the details. I suspect we want to allow enable/disable on
events that are on a dead CPU, and equally I think we want to account
the time an enabled event spends on a dead CPU to go towards the
'enabled' bucket.

> > Also, you _still_ don't explain why you care about dead CPUs.
> > 
> 
> It's just not only about dead CPUs. It's the fact that the CPUs can come and
> go online. The embedded world, specifically Android mobile SoCs, rely on CPU
> hotplugs to manage power and thermal constraints. These hotplugs can happen
> at a very rapid pace.

That's batshit insane... and that sounds like the primary thing you
should be fixing.


---
 include/linux/perf_event.h |   2 +
 kernel/events/core.c       | 109 ++++++++++++++++++++++++++++-----------------
 2 files changed, 69 insertions(+), 42 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7546822a1d74..c7a50fe26672 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -495,6 +495,8 @@ enum perf_event_state {
 	PERF_EVENT_STATE_OFF		= -1,
 	PERF_EVENT_STATE_INACTIVE	=  0,
 	PERF_EVENT_STATE_ACTIVE		=  1,
+
+	PERF_EVENT_STATE_HOTPLUG_OFFSET	= -32,
 };
 
 struct file;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 57898102847f..26dae8afe57d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -265,17 +265,17 @@ static void event_function_call(struct perf_event *event, event_f func, void *da
 		lockdep_assert_held(&ctx->mutex);
 	}
 
-	if (!task) {
-		cpu_function_call(event->cpu, event_function, &efs);
-		return;
-	}
-
 	if (task == TASK_TOMBSTONE)
 		return;
 
 again:
-	if (!task_function_call(task, event_function, &efs))
-		return;
+	if (task) {
+		if (!task_function_call(task, event_function, &efs))
+			return;
+	} else {
+		if (!cpu_function_call(event->cpu, event_function, &efs))
+			return;
+	}
 
 	raw_spin_lock_irq(&ctx->lock);
 	/*
@@ -2110,7 +2110,7 @@ group_sched_in(struct perf_event *group_event,
 	struct perf_event *event, *partial_group = NULL;
 	struct pmu *pmu = ctx->pmu;
 
-	if (group_event->state == PERF_EVENT_STATE_OFF)
+	if (group_event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
 	pmu->start_txn(pmu, PERF_PMU_TXN_ADD);
@@ -2189,6 +2189,14 @@ static int group_can_go_on(struct perf_event *event,
 static void add_event_to_ctx(struct perf_event *event,
 			       struct perf_event_context *ctx)
 {
+	if (!ctx->task) {
+		struct perf_cpu_context *cpuctx =
+			container_of(ctx, struct perf_cpu_context, ctx);
+
+		if (!cpuctx->online)
+			event->state += PERF_EVENT_STATE_HOTPLUG_OFFSET;
+	}
+
 	list_add_event(event, ctx);
 	perf_group_attach(event);
 }
@@ -2352,11 +2360,6 @@ perf_install_in_context(struct perf_event_context *ctx,
 	 */
 	smp_store_release(&event->ctx, ctx);
 
-	if (!task) {
-		cpu_function_call(cpu, __perf_install_in_context, event);
-		return;
-	}
-
 	/*
 	 * Should not happen, we validate the ctx is still alive before calling.
 	 */
@@ -2395,8 +2398,14 @@ perf_install_in_context(struct perf_event_context *ctx,
 	 */
 	smp_mb();
 again:
-	if (!task_function_call(task, __perf_install_in_context, event))
-		return;
+	if (task) {
+		if (!task_function_call(task, __perf_install_in_context, event))
+			return;
+	} else {
+		if (!cpu_function_call(cpu, __perf_install_in_context, event))
+			return;
+	}
+
 
 	raw_spin_lock_irq(&ctx->lock);
 	task = ctx->task;
@@ -10280,16 +10289,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	}
 
 	if (!task) {
-		/*
-		 * Check if the @cpu we're creating an event for is online.
-		 *
-		 * We use the perf_cpu_context::ctx::mutex to serialize against
-		 * the hotplug notifiers. See perf_event_{init,exit}_cpu().
-		 */
-		struct perf_cpu_context *cpuctx =
-			container_of(ctx, struct perf_cpu_context, ctx);
-
-		if (!cpuctx->online) {
+		if (!cpu_possible(cpu)) {
 			err = -ENODEV;
 			goto err_locked;
 		}
@@ -10473,15 +10473,7 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 	}
 
 	if (!task) {
-		/*
-		 * Check if the @cpu we're creating an event for is online.
-		 *
-		 * We use the perf_cpu_context::ctx::mutex to serialize against
-		 * the hotplug notifiers. See perf_event_{init,exit}_cpu().
-		 */
-		struct perf_cpu_context *cpuctx =
-			container_of(ctx, struct perf_cpu_context, ctx);
-		if (!cpuctx->online) {
+		if (!cpu_possible(cpu)) {
 			err = -ENODEV;
 			goto err_unlock;
 		}
@@ -11201,17 +11193,48 @@ void perf_swevent_init_cpu(unsigned int cpu)
 }
 
 #if defined CONFIG_HOTPLUG_CPU || defined CONFIG_KEXEC_CORE
+
+static void __perf_event_init_cpu_context(void *__info)
+{
+	struct perf_cpu_context *cpuctx = __info;
+	struct perf_event_context *ctx = &cpuctx->ctx;
+	struct perf_event_context *task_ctx = cpuctx->task_ctx;
+	struct perf_event *event;
+
+	perf_ctx_lock(cpuctx, task_ctx);
+	ctx_sched_out(ctx, cpuctx, EVENT_ALL);
+	if (task_ctx)
+		ctx_sched_out(task_ctx, cpuctx, EVENT_ALL);
+
+	list_for_each_entry_rcu(event, &ctx->event_list, event_entry)
+		perf_event_set_state(event, event->state - PERF_EVENT_STATE_HOTPLUG_OFFSET);
+
+	perf_event_sched_in(cpuctx, task_ctx, current);
+	perf_ctx_unlock(cpuctx, task_ctx);
+}
+
+static void _perf_event_init_cpu_context(int cpu, struct perf_cpu_context *cpuctx)
+{
+	smp_call_function_single(cpu, __perf_event_init_cpu_context, cpuctx, 1);
+}
+
 static void __perf_event_exit_context(void *__info)
 {
-	struct perf_event_context *ctx = __info;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+	struct perf_cpu_context *cpuctx = __info;
+	struct perf_event_context *ctx = &cpuctx->ctx;
+	struct perf_event_context *task_ctx = cpuctx->task_ctx;
 	struct perf_event *event;
 
-	raw_spin_lock(&ctx->lock);
-	ctx_sched_out(ctx, cpuctx, EVENT_TIME);
-	list_for_each_entry(event, &ctx->event_list, event_entry)
-		__perf_remove_from_context(event, cpuctx, ctx, (void *)DETACH_GROUP);
-	raw_spin_unlock(&ctx->lock);
+	perf_ctx_lock(cpuctx, task_ctx);
+	ctx_sched_out(ctx, cpuctx, EVENT_ALL);
+	if (task_ctx)
+		ctx_sched_out(task_ctx, cpuctx, EVENT_ALL);
+
+	list_for_each_entry_rcu(event, &ctx->event_list, event_entry)
+		perf_event_set_state(event, event->state + PERF_EVENT_STATE_HOTPLUG_OFFSET);
+
+	perf_event_sched_in(cpuctx, task_ctx, current);
+	perf_ctx_unlock(cpuctx, task_ctx);
 }
 
 static void perf_event_exit_cpu_context(int cpu)
@@ -11226,7 +11249,7 @@ static void perf_event_exit_cpu_context(int cpu)
 		ctx = &cpuctx->ctx;
 
 		mutex_lock(&ctx->mutex);
-		smp_call_function_single(cpu, __perf_event_exit_context, ctx, 1);
+		smp_call_function_single(cpu, __perf_event_exit_context, cpuctx, 1);
 		cpuctx->online = 0;
 		mutex_unlock(&ctx->mutex);
 	}
@@ -11235,6 +11258,7 @@ static void perf_event_exit_cpu_context(int cpu)
 }
 #else
 
+static void _perf_event_init_cpu_context(int cpu, struct perf_cpu_context *cpuctx) { }
 static void perf_event_exit_cpu_context(int cpu) { }
 
 #endif
@@ -11255,6 +11279,7 @@ int perf_event_init_cpu(unsigned int cpu)
 
 		mutex_lock(&ctx->mutex);
 		cpuctx->online = 1;
+		_perf_event_init_cpu_context(cpu, cpuctx);
 		mutex_unlock(&ctx->mutex);
 	}
 	mutex_unlock(&pmus_lock);
