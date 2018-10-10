Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4DDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD1E214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FfDirP+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD1E214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJJSIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:08:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59706 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJJSIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6atNV9RXiMMxVJV/oL1TG0Suf+pR1kiLldIu1BqaMyY=; b=FfDirP+ZX7aGeJh6wlX6mdpRxV
        BxSl/mUwVIXpLEc4I4jRrGTXX1JPP5yIuRVwzqH5foLUGyb3+gNIqLr+0T1B4OH2fBHsRmTkYQIWo
        1yGz7ihyzWQOMeYoABLonvc6dA0JWM7IPk0JbGsg97WJzT3DBQDWzwd9D8UqhI71LzMaOvBolWPPh
        QI/bKV1b+DgYP8UreJyGW55EcI0w5vP5V06m/RHeKXypk1ht225HZOWhtwzWYW4inNDZCZKco3WN3
        nw6XVOkQKOZ7aHYZvv2LYtQk0rvlcnRE84gphDau21E86Pv2/covNRVdwd7zCLhIm80ydFLI53I8Y
        RuVmZThg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAC0D-0004c0-3h; Wed, 10 Oct 2018 10:46:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7858D20298568; Wed, 10 Oct 2018 12:45:59 +0200 (CEST)
Date:   Wed, 10 Oct 2018 12:45:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        songliubraving@fb.com, eranian@google.com, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, mark.rutland@arm.com,
        megha.dey@intel.com, frederic@kernel.org
Subject: [RFC][PATCH] perf: Rewrite core context handling
Message-ID: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

There have been various issues and limitations with the way perf uses
(task) contexts to track events. Most notable is the single hardware PMU
task context, which has resulted in a number of yucky things (both
proposed and merged).

Notably:

 - HW breakpoint PMU
 - ARM big.little PMU
 - Intel Branch Monitoring PMU

Since we now track the events in RB trees, we can 'simply' add a pmu
order to them and have them grouped that way, reducing to a single
context. Of course, reality never quite works out that simple, and below
ends up adding an intermediate data structure to bridge the context ->
pmu mapping.

Something a little like:

              ,------------------------[1:n]---------------------.
              V                                                  V
    perf_event_context <-[1:n]-> perf_event_pmu_context <--- perf_event
              ^                      ^     |                     |
              `--------[1:n]---------'     `-[n:1]-> pmu <-[1:n]-'

This patch builds (provided you disable CGROUP_PERF), boots and survives
perf-top without the machine catching fire.

There's still a fair bit of loose ends (look for XXX), but I think this
is the direction we should be going.

Comments?

Not-Quite-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/powerpc/perf/core-book3s.c |    4 
 arch/x86/events/core.c          |    4 
 arch/x86/events/intel/core.c    |    6 
 arch/x86/events/intel/ds.c      |    6 
 arch/x86/events/intel/lbr.c     |   16 
 arch/x86/events/perf_event.h    |    6 
 include/linux/perf_event.h      |   80 +-
 include/linux/sched.h           |    2 
 kernel/events/core.c            | 1412 ++++++++++++++++++++--------------------
 9 files changed, 815 insertions(+), 721 deletions(-)

--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -125,7 +125,7 @@ static unsigned long ebb_switch_in(bool
 
 static inline void power_pmu_bhrb_enable(struct perf_event *event) {}
 static inline void power_pmu_bhrb_disable(struct perf_event *event) {}
-static void power_pmu_sched_task(struct perf_event_context *ctx, bool sched_in) {}
+static void power_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in) {}
 static inline void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw) {}
 static void pmao_restore_workaround(bool ebb) { }
 #endif /* CONFIG_PPC32 */
@@ -395,7 +395,7 @@ static void power_pmu_bhrb_disable(struc
 /* Called from ctxsw to prevent one process's branch entries to
  * mingle with the other process's entries during context switch.
  */
-static void power_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
+static void power_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
 {
 	if (!ppmu->bhrb_nr)
 		return;
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2286,10 +2286,10 @@ static const struct attribute_group *x86
 	NULL,
 };
 
-static void x86_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
+static void x86_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
 {
 	if (x86_pmu.sched_task)
-		x86_pmu.sched_task(ctx, sched_in);
+		x86_pmu.sched_task(pmu_ctx, sched_in);
 }
 
 void perf_check_microcode(void)
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3537,11 +3537,11 @@ static void intel_pmu_cpu_dying(int cpu)
 		disable_counter_freeze();
 }
 
-static void intel_pmu_sched_task(struct perf_event_context *ctx,
+static void intel_pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
 				 bool sched_in)
 {
-	intel_pmu_pebs_sched_task(ctx, sched_in);
-	intel_pmu_lbr_sched_task(ctx, sched_in);
+	intel_pmu_pebs_sched_task(pmu_ctx, sched_in);
+	intel_pmu_lbr_sched_task(pmu_ctx, sched_in);
 }
 
 PMU_FORMAT_ATTR(offcore_rsp, "config1:0-63");
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -885,7 +885,7 @@ static inline bool pebs_needs_sched_cb(s
 	return cpuc->n_pebs && (cpuc->n_pebs == cpuc->n_large_pebs);
 }
 
-void intel_pmu_pebs_sched_task(struct perf_event_context *ctx, bool sched_in)
+void intel_pmu_pebs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
@@ -947,7 +947,7 @@ void intel_pmu_pebs_add(struct perf_even
 	if (hwc->flags & PERF_X86_EVENT_LARGE_PEBS)
 		cpuc->n_large_pebs++;
 
-	pebs_update_state(needed_cb, cpuc, event->ctx->pmu);
+	pebs_update_state(needed_cb, cpuc, event->pmu);
 }
 
 void intel_pmu_pebs_enable(struct perf_event *event)
@@ -991,7 +991,7 @@ void intel_pmu_pebs_del(struct perf_even
 	if (hwc->flags & PERF_X86_EVENT_LARGE_PEBS)
 		cpuc->n_large_pebs--;
 
-	pebs_update_state(needed_cb, cpuc, event->ctx->pmu);
+	pebs_update_state(needed_cb, cpuc, event->pmu);
 }
 
 void intel_pmu_pebs_disable(struct perf_event *event)
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -417,7 +417,7 @@ static void __intel_pmu_lbr_save(struct
 	cpuc->last_log_id = ++task_ctx->log_id;
 }
 
-void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
+void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct x86_perf_task_context *task_ctx;
@@ -430,7 +430,7 @@ void intel_pmu_lbr_sched_task(struct per
 	 * the task was scheduled out, restore the stack. Otherwise flush
 	 * the LBR stack.
 	 */
-	task_ctx = ctx ? ctx->task_ctx_data : NULL;
+	task_ctx = pmu_ctx ? pmu_ctx->task_ctx_data : NULL;
 	if (task_ctx) {
 		if (sched_in)
 			__intel_pmu_lbr_restore(task_ctx);
@@ -464,8 +464,8 @@ void intel_pmu_lbr_add(struct perf_event
 
 	cpuc->br_sel = event->hw.branch_reg.reg;
 
-	if (branch_user_callstack(cpuc->br_sel) && event->ctx->task_ctx_data) {
-		task_ctx = event->ctx->task_ctx_data;
+	if (branch_user_callstack(cpuc->br_sel) && event->pmu_ctx->task_ctx_data) {
+		task_ctx = event->pmu_ctx->task_ctx_data;
 		task_ctx->lbr_callstack_users++;
 	}
 
@@ -488,7 +488,7 @@ void intel_pmu_lbr_add(struct perf_event
 	 * be 'new'. Conversely, a new event can get installed through the
 	 * context switch path for the first time.
 	 */
-	perf_sched_cb_inc(event->ctx->pmu);
+	perf_sched_cb_inc(event->pmu);
 	if (!cpuc->lbr_users++ && !event->total_time_running)
 		intel_pmu_lbr_reset();
 }
@@ -502,14 +502,14 @@ void intel_pmu_lbr_del(struct perf_event
 		return;
 
 	if (branch_user_callstack(cpuc->br_sel) &&
-	    event->ctx->task_ctx_data) {
-		task_ctx = event->ctx->task_ctx_data;
+	    event->pmu_ctx->task_ctx_data) {
+		task_ctx = event->pmu_ctx->task_ctx_data;
 		task_ctx->lbr_callstack_users--;
 	}
 
 	cpuc->lbr_users--;
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
-	perf_sched_cb_dec(event->ctx->pmu);
+	perf_sched_cb_dec(event->pmu);
 }
 
 void intel_pmu_lbr_enable_all(bool pmi)
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -589,7 +589,7 @@ struct x86_pmu {
 	void		(*cpu_dead)(int cpu);
 
 	void		(*check_microcode)(void);
-	void		(*sched_task)(struct perf_event_context *ctx,
+	void		(*sched_task)(struct perf_event_pmu_context *pmu_ctx,
 				      bool sched_in);
 
 	/*
@@ -930,13 +930,13 @@ void intel_pmu_pebs_enable_all(void);
 
 void intel_pmu_pebs_disable_all(void);
 
-void intel_pmu_pebs_sched_task(struct perf_event_context *ctx, bool sched_in);
+void intel_pmu_pebs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
 
 void intel_pmu_auto_reload_read(struct perf_event *event);
 
 void intel_ds_init(void);
 
-void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in);
+void intel_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
 
 u64 lbr_from_signext_quirk_wr(u64 val);
 
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -227,6 +227,7 @@ struct hw_perf_event {
 };
 
 struct perf_event;
+struct perf_event_pmu_context;
 
 /*
  * Common implementation detail of pmu::{start,commit,cancel}_txn
@@ -263,7 +264,9 @@ struct pmu {
 	int				capabilities;
 
 	int * __percpu			pmu_disable_count;
-	struct perf_cpu_context * __percpu pmu_cpu_context;
+	struct perf_cpu_pmu_context * __percpu cpu_pmu_context;
+
+
 	atomic_t			exclusive_cnt; /* < 0: cpu; > 0: tsk */
 	int				task_ctx_nr;
 	int				hrtimer_interval_ms;
@@ -398,7 +401,7 @@ struct pmu {
 	/*
 	 * context-switches callback
 	 */
-	void (*sched_task)		(struct perf_event_context *ctx,
+	void (*sched_task)		(struct perf_event_pmu_context *ctx,
 					bool sched_in);
 	/*
 	 * PMU specific data size
@@ -619,6 +622,7 @@ struct perf_event {
 	struct hw_perf_event		hw;
 
 	struct perf_event_context	*ctx;
+	struct perf_event_pmu_context	*pmu_ctx;
 	atomic_long_t			refcount;
 
 	/*
@@ -698,6 +702,41 @@ struct perf_event {
 #endif /* CONFIG_PERF_EVENTS */
 };
 
+/*
+ *           ,------------------------[1:n]---------------------.
+ *           V                                                  V
+ * perf_event_context <-[1:n]-> perf_event_pmu_context <--- perf_event
+ *           ^                      ^     |                     |
+ *           `--------[1:n]---------'     `-[n:1]-> pmu <-[1:n]-'
+ *
+ *
+ * XXX destroy epc when empty
+ *   refcount, !rcu
+ *
+ * XXX epc locking
+ *
+ *   event->pmu_ctx		ctx->mutex && inactive
+ *   ctx->pmu_ctx_list		ctx->mutex && ctx->lock
+ *
+ */
+struct perf_event_pmu_context {
+	struct pmu			*pmu;
+	struct perf_event_context 	*ctx;
+
+	struct list_head		pmu_ctx_entry;
+
+	struct list_head		pinned_active;
+	struct list_head		flexible_active;
+
+	unsigned int			embedded : 1;
+
+	unsigned int			nr_events;
+	unsigned int			nr_active;
+
+	atomic_t			refcount; /* event <-> epc */
+
+	void				*task_ctx_data; /* pmu specific data */
+};
 
 struct perf_event_groups {
 	struct rb_root	tree;
@@ -710,7 +749,6 @@ struct perf_event_groups {
  * Used as a container for task events and CPU events as well:
  */
 struct perf_event_context {
-	struct pmu			*pmu;
 	/*
 	 * Protect the states of the events in the list,
 	 * nr_active, and the list:
@@ -723,20 +761,21 @@ struct perf_event_context {
 	 */
 	struct mutex			mutex;
 
-	struct list_head		active_ctx_list;
+	struct list_head		pmu_ctx_list;
+
 	struct perf_event_groups	pinned_groups;
 	struct perf_event_groups	flexible_groups;
 	struct list_head		event_list;
 
-	struct list_head		pinned_active;
-	struct list_head		flexible_active;
-
 	int				nr_events;
 	int				nr_active;
 	int				is_active;
+
+	int				nr_task_data;
 	int				nr_stat;
 	int				nr_freq;
 	int				rotate_disable;
+
 	atomic_t			refcount;
 	struct task_struct		*task;
 
@@ -757,7 +796,6 @@ struct perf_event_context {
 #ifdef CONFIG_CGROUP_PERF
 	int				nr_cgroups;	 /* cgroup evts */
 #endif
-	void				*task_ctx_data; /* pmu specific data */
 	struct rcu_head			rcu_head;
 };
 
@@ -767,12 +805,13 @@ struct perf_event_context {
  */
 #define PERF_NR_CONTEXTS	4
 
-/**
- * struct perf_event_cpu_context - per cpu event context structure
- */
-struct perf_cpu_context {
-	struct perf_event_context	ctx;
-	struct perf_event_context	*task_ctx;
+struct perf_cpu_pmu_context {
+	struct perf_event_pmu_context	epc;
+	struct perf_event_pmu_context	*task_epc;
+
+	struct list_head		sched_cb_entry;
+	int				sched_cb_usage;
+
 	int				active_oncpu;
 	int				exclusive;
 
@@ -780,15 +819,20 @@ struct perf_cpu_context {
 	struct hrtimer			hrtimer;
 	ktime_t				hrtimer_interval;
 	unsigned int			hrtimer_active;
+};
+
+/**
+ * struct perf_event_cpu_context - per cpu event context structure
+ */
+struct perf_cpu_context {
+	struct perf_event_context	ctx;
+	struct perf_event_context	*task_ctx;
 
 #ifdef CONFIG_CGROUP_PERF
 	struct perf_cgroup		*cgrp;
 	struct list_head		cgrp_cpuctx_entry;
 #endif
 
-	struct list_head		sched_cb_entry;
-	int				sched_cb_usage;
-
 	int				online;
 };
 
@@ -1022,7 +1066,7 @@ static inline int is_software_event(stru
  */
 static inline int in_software_context(struct perf_event *event)
 {
-	return event->ctx->pmu->task_ctx_nr == perf_sw_context;
+	return event->pmu_ctx->pmu->task_ctx_nr == perf_sw_context;
 }
 
 extern struct static_key perf_swevent_enabled[PERF_COUNT_SW_MAX];
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1000,7 +1000,7 @@ struct task_struct {
 	struct futex_pi_state		*pi_state_cache;
 #endif
 #ifdef CONFIG_PERF_EVENTS
-	struct perf_event_context	*perf_event_ctxp[perf_nr_task_contexts];
+	struct perf_event_context	*perf_event_ctxp;
 	struct mutex			perf_event_mutex;
 	struct list_head		perf_event_list;
 #endif
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -143,12 +143,6 @@ static int cpu_function_call(int cpu, re
 	return data.ret;
 }
 
-static inline struct perf_cpu_context *
-__get_cpu_context(struct perf_event_context *ctx)
-{
-	return this_cpu_ptr(ctx->pmu->pmu_cpu_context);
-}
-
 static void perf_ctx_lock(struct perf_cpu_context *cpuctx,
 			  struct perf_event_context *ctx)
 {
@@ -172,6 +166,8 @@ static bool is_kernel_event(struct perf_
 	return READ_ONCE(event->owner) == TASK_TOMBSTONE;
 }
 
+static DEFINE_PER_CPU(struct perf_cpu_context, cpu_context);
+
 /*
  * On task ctx scheduling...
  *
@@ -205,7 +201,7 @@ static int event_function(void *info)
 	struct event_function_struct *efs = info;
 	struct perf_event *event = efs->event;
 	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
 	struct perf_event_context *task_ctx = cpuctx->task_ctx;
 	int ret = 0;
 
@@ -302,7 +298,7 @@ static void event_function_call(struct p
 static void event_function_local(struct perf_event *event, event_f func, void *data)
 {
 	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
 	struct task_struct *task = READ_ONCE(ctx->task);
 	struct perf_event_context *task_ctx = NULL;
 
@@ -376,7 +372,6 @@ static DEFINE_MUTEX(perf_sched_mutex);
 static atomic_t perf_sched_count;
 
 static DEFINE_PER_CPU(atomic_t, perf_cgroup_events);
-static DEFINE_PER_CPU(int, perf_sched_cb_usages);
 static DEFINE_PER_CPU(struct pmu_event_list, pmu_sb_events);
 
 static atomic_t nr_mmap_events __read_mostly;
@@ -430,7 +425,7 @@ static void update_perf_cpu_limits(void)
 	WRITE_ONCE(perf_sample_allowed_ns, tmp);
 }
 
-static bool perf_rotate_context(struct perf_cpu_context *cpuctx);
+static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc);
 
 int perf_proc_update_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp,
@@ -555,13 +550,6 @@ void perf_sample_event_took(u64 sample_l
 
 static atomic64_t perf_event_id;
 
-static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
-			      enum event_type_t event_type);
-
-static void cpu_ctx_sched_in(struct perf_cpu_context *cpuctx,
-			     enum event_type_t event_type,
-			     struct task_struct *task);
-
 static void update_context_time(struct perf_event_context *ctx);
 static u64 perf_event_time(struct perf_event *event);
 
@@ -810,7 +798,7 @@ static void perf_cgroup_switch(struct ta
 		perf_pmu_disable(cpuctx->ctx.pmu);
 
 		if (mode & PERF_CGROUP_SWOUT) {
-			cpu_ctx_sched_out(cpuctx, EVENT_ALL);
+			ctx_sched_out(&cpuctx->ctx, EVENT_ALL);
 			/*
 			 * must not be done before ctxswout due
 			 * to event_filter_match() in event_sched_out()
@@ -827,9 +815,8 @@ static void perf_cgroup_switch(struct ta
 			 * we pass the cpuctx->ctx to perf_cgroup_from_task()
 			 * because cgorup events are only per-cpu
 			 */
-			cpuctx->cgrp = perf_cgroup_from_task(task,
-							     &cpuctx->ctx);
-			cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
+			cpuctx->cgrp = perf_cgroup_from_task(task, &cpuctx->ctx);
+			ctx_sched_in(&cpuctx->ctx, EVENT_ALL, task);
 		}
 		perf_pmu_enable(cpuctx->ctx.pmu);
 		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -1063,34 +1050,30 @@ list_update_cgroup_event(struct perf_eve
  */
 static enum hrtimer_restart perf_mux_hrtimer_handler(struct hrtimer *hr)
 {
-	struct perf_cpu_context *cpuctx;
+	struct perf_cpu_pmu_context *cpc;
 	bool rotations;
 
 	lockdep_assert_irqs_disabled();
 
-	cpuctx = container_of(hr, struct perf_cpu_context, hrtimer);
-	rotations = perf_rotate_context(cpuctx);
+	cpc = container_of(hr, struct perf_cpu_pmu_context, hrtimer);
+	rotations = perf_rotate_context(cpc);
 
-	raw_spin_lock(&cpuctx->hrtimer_lock);
+	raw_spin_lock(&cpc->hrtimer_lock);
 	if (rotations)
-		hrtimer_forward_now(hr, cpuctx->hrtimer_interval);
+		hrtimer_forward_now(hr, cpc->hrtimer_interval);
 	else
-		cpuctx->hrtimer_active = 0;
-	raw_spin_unlock(&cpuctx->hrtimer_lock);
+		cpc->hrtimer_active = 0;
+	raw_spin_unlock(&cpc->hrtimer_lock);
 
 	return rotations ? HRTIMER_RESTART : HRTIMER_NORESTART;
 }
 
-static void __perf_mux_hrtimer_init(struct perf_cpu_context *cpuctx, int cpu)
+static void __perf_mux_hrtimer_init(struct perf_cpu_pmu_context *cpc, int cpu)
 {
-	struct hrtimer *timer = &cpuctx->hrtimer;
-	struct pmu *pmu = cpuctx->ctx.pmu;
+	struct hrtimer *timer = &cpc->hrtimer;
+	struct pmu *pmu = cpc->epc.pmu;
 	u64 interval;
 
-	/* no multiplexing needed for SW PMU */
-	if (pmu->task_ctx_nr == perf_sw_context)
-		return;
-
 	/*
 	 * check default is sane, if not set then force to
 	 * default interval (1/tick)
@@ -1099,30 +1082,25 @@ static void __perf_mux_hrtimer_init(stru
 	if (interval < 1)
 		interval = pmu->hrtimer_interval_ms = PERF_CPU_HRTIMER;
 
-	cpuctx->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * interval);
+	cpc->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * interval);
 
-	raw_spin_lock_init(&cpuctx->hrtimer_lock);
+	raw_spin_lock_init(&cpc->hrtimer_lock);
 	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
 	timer->function = perf_mux_hrtimer_handler;
 }
 
-static int perf_mux_hrtimer_restart(struct perf_cpu_context *cpuctx)
+static int perf_mux_hrtimer_restart(struct perf_cpu_pmu_context *cpc)
 {
-	struct hrtimer *timer = &cpuctx->hrtimer;
-	struct pmu *pmu = cpuctx->ctx.pmu;
+	struct hrtimer *timer = &cpc->hrtimer;
 	unsigned long flags;
 
-	/* not for SW PMU */
-	if (pmu->task_ctx_nr == perf_sw_context)
-		return 0;
-
-	raw_spin_lock_irqsave(&cpuctx->hrtimer_lock, flags);
-	if (!cpuctx->hrtimer_active) {
-		cpuctx->hrtimer_active = 1;
-		hrtimer_forward_now(timer, cpuctx->hrtimer_interval);
+	raw_spin_lock_irqsave(&cpc->hrtimer_lock, flags);
+	if (!cpc->hrtimer_active) {
+		cpc->hrtimer_active = 1;
+		hrtimer_forward_now(timer, cpc->hrtimer_interval);
 		hrtimer_start_expires(timer, HRTIMER_MODE_ABS_PINNED);
 	}
-	raw_spin_unlock_irqrestore(&cpuctx->hrtimer_lock, flags);
+	raw_spin_unlock_irqrestore(&cpc->hrtimer_lock, flags);
 
 	return 0;
 }
@@ -1141,32 +1119,25 @@ void perf_pmu_enable(struct pmu *pmu)
 		pmu->pmu_enable(pmu);
 }
 
-static DEFINE_PER_CPU(struct list_head, active_ctx_list);
-
-/*
- * perf_event_ctx_activate(), perf_event_ctx_deactivate(), and
- * perf_event_task_tick() are fully serialized because they're strictly cpu
- * affine and perf_event_ctx{activate,deactivate} are called with IRQs
- * disabled, while perf_event_task_tick is called from IRQ context.
- */
-static void perf_event_ctx_activate(struct perf_event_context *ctx)
+void perf_assert_pmu_disabled(struct pmu *pmu)
 {
-	struct list_head *head = this_cpu_ptr(&active_ctx_list);
-
-	lockdep_assert_irqs_disabled();
+	WARN_ON_ONCE(*this_cpu_ptr(pmu->pmu_disable_count) == 0);
+}
 
-	WARN_ON(!list_empty(&ctx->active_ctx_list));
+void perf_ctx_disable(struct perf_event_context *ctx)
+{
+	struct perf_event_pmu_context *pmu_ctx;
 
-	list_add(&ctx->active_ctx_list, head);
+	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry)
+		perf_pmu_disable(pmu_ctx->pmu);
 }
 
-static void perf_event_ctx_deactivate(struct perf_event_context *ctx)
+void perf_ctx_enable(struct perf_event_context *ctx)
 {
-	lockdep_assert_irqs_disabled();
+	struct perf_event_pmu_context *pmu_ctx;
 
-	WARN_ON(list_empty(&ctx->active_ctx_list));
-
-	list_del_init(&ctx->active_ctx_list);
+	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry)
+		perf_pmu_enable(pmu_ctx->pmu);
 }
 
 static void get_ctx(struct perf_event_context *ctx)
@@ -1179,7 +1150,6 @@ static void free_ctx(struct rcu_head *he
 	struct perf_event_context *ctx;
 
 	ctx = container_of(head, struct perf_event_context, rcu_head);
-	kfree(ctx->task_ctx_data);
 	kfree(ctx);
 }
 
@@ -1363,7 +1333,7 @@ static u64 primary_event_id(struct perf_
  * the context could get moved to another task.
  */
 static struct perf_event_context *
-perf_lock_task_context(struct task_struct *task, int ctxn, unsigned long *flags)
+perf_lock_task_context(struct task_struct *task, unsigned long *flags)
 {
 	struct perf_event_context *ctx;
 
@@ -1379,7 +1349,7 @@ perf_lock_task_context(struct task_struc
 	 */
 	local_irq_save(*flags);
 	rcu_read_lock();
-	ctx = rcu_dereference(task->perf_event_ctxp[ctxn]);
+	ctx = rcu_dereference(task->perf_event_ctxp);
 	if (ctx) {
 		/*
 		 * If this context is a clone of another, it might
@@ -1392,7 +1362,7 @@ perf_lock_task_context(struct task_struc
 		 * can't get swapped on us any more.
 		 */
 		raw_spin_lock(&ctx->lock);
-		if (ctx != rcu_dereference(task->perf_event_ctxp[ctxn])) {
+		if (ctx != rcu_dereference(task->perf_event_ctxp)) {
 			raw_spin_unlock(&ctx->lock);
 			rcu_read_unlock();
 			local_irq_restore(*flags);
@@ -1419,12 +1389,12 @@ perf_lock_task_context(struct task_struc
  * reference count so that the context can't get freed.
  */
 static struct perf_event_context *
-perf_pin_task_context(struct task_struct *task, int ctxn)
+perf_pin_task_context(struct task_struct *task)
 {
 	struct perf_event_context *ctx;
 	unsigned long flags;
 
-	ctx = perf_lock_task_context(task, ctxn, &flags);
+	ctx = perf_lock_task_context(task, &flags);
 	if (ctx) {
 		++ctx->pin_count;
 		raw_spin_unlock_irqrestore(&ctx->lock, flags);
@@ -1528,6 +1498,11 @@ perf_event_groups_less(struct perf_event
 	if (left->cpu > right->cpu)
 		return false;
 
+	if (left->pmu_ctx->pmu < right->pmu_ctx->pmu)
+		return true;
+	if (left->pmu_ctx->pmu > right->pmu_ctx->pmu)
+		return false;
+
 	if (left->group_index < right->group_index)
 		return true;
 	if (left->group_index > right->group_index)
@@ -1610,7 +1585,7 @@ del_event_from_groups(struct perf_event
  * Get the leftmost event in the @cpu subtree.
  */
 static struct perf_event *
-perf_event_groups_first(struct perf_event_groups *groups, int cpu)
+perf_event_groups_first(struct perf_event_groups *groups, int cpu, struct pmu *pmu)
 {
 	struct perf_event *node_event = NULL, *match = NULL;
 	struct rb_node *node = groups->tree.rb_node;
@@ -1623,8 +1598,19 @@ perf_event_groups_first(struct perf_even
 		} else if (cpu > node_event->cpu) {
 			node = node->rb_right;
 		} else {
-			match = node_event;
-			node = node->rb_left;
+			if (pmu) {
+				if (pmu < node_event->pmu_ctx->pmu) {
+					node = node->rb_left;
+				} else if (pmu > node_event->pmu_ctx->pmu) {
+					node = node->rb_right;
+				} else  {
+					match = node_event;
+					node = node->rb_left;
+				}
+			} else {
+				match = node_event;
+				node = node->rb_left;
+			}
 		}
 	}
 
@@ -1635,13 +1621,17 @@ perf_event_groups_first(struct perf_even
  * Like rb_entry_next_safe() for the @cpu subtree.
  */
 static struct perf_event *
-perf_event_groups_next(struct perf_event *event)
+perf_event_groups_next(struct perf_event *event, struct pmu *pmu)
 {
 	struct perf_event *next;
 
 	next = rb_entry_safe(rb_next(&event->group_node), typeof(*event), group_node);
-	if (next && next->cpu == event->cpu)
+	if (next && next->cpu == event->cpu) {
+		if (pmu && next->pmu_ctx->pmu != pmu)
+			return NULL;
+
 		return next;
+	}
 
 	return NULL;
 }
@@ -1687,6 +1677,8 @@ list_add_event(struct perf_event *event,
 		ctx->nr_stat++;
 
 	ctx->generation++;
+
+	event->pmu_ctx->nr_events++;
 }
 
 /*
@@ -1883,6 +1875,8 @@ list_del_event(struct perf_event *event,
 		perf_event_set_state(event, PERF_EVENT_STATE_OFF);
 
 	ctx->generation++;
+
+	event->pmu_ctx->nr_events--;
 }
 
 static void perf_group_detach(struct perf_event *event)
@@ -1926,8 +1920,9 @@ static void perf_group_detach(struct per
 			add_event_to_groups(sibling, event->ctx);
 
 			if (sibling->state == PERF_EVENT_STATE_ACTIVE) {
+				struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
 				struct list_head *list = sibling->attr.pinned ?
-					&ctx->pinned_active : &ctx->flexible_active;
+					&pmu_ctx->pinned_active : &pmu_ctx->flexible_active;
 
 				list_add_tail(&sibling->active_list, list);
 			}
@@ -1983,12 +1978,14 @@ event_filter_match(struct perf_event *ev
 }
 
 static void
-event_sched_out(struct perf_event *event,
-		  struct perf_cpu_context *cpuctx,
-		  struct perf_event_context *ctx)
+event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 {
+	struct perf_event_pmu_context *epc = event->pmu_ctx;
+	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(epc->pmu->cpu_pmu_context);
 	enum perf_event_state state = PERF_EVENT_STATE_INACTIVE;
 
+	// XXX cpc serialization, probably per-cpu IRQ disabled
+
 	WARN_ON_ONCE(event->ctx != ctx);
 	lockdep_assert_held(&ctx->lock);
 
@@ -2014,41 +2011,35 @@ event_sched_out(struct perf_event *event
 	perf_event_set_state(event, state);
 
 	if (!is_software_event(event))
-		cpuctx->active_oncpu--;
+		cpc->active_oncpu--;
 	if (!--ctx->nr_active)
-		perf_event_ctx_deactivate(ctx);
+		;
+	event->pmu_ctx->nr_active--;
 	if (event->attr.freq && event->attr.sample_freq)
 		ctx->nr_freq--;
-	if (event->attr.exclusive || !cpuctx->active_oncpu)
-		cpuctx->exclusive = 0;
+	if (event->attr.exclusive || !cpc->active_oncpu)
+		cpc->exclusive = 0;
 
 	perf_pmu_enable(event->pmu);
 }
 
 static void
-group_sched_out(struct perf_event *group_event,
-		struct perf_cpu_context *cpuctx,
-		struct perf_event_context *ctx)
+group_sched_out(struct perf_event *group_event, struct perf_event_context *ctx)
 {
 	struct perf_event *event;
 
 	if (group_event->state != PERF_EVENT_STATE_ACTIVE)
 		return;
 
-	perf_pmu_disable(ctx->pmu);
+	perf_assert_pmu_disabled(group_event->pmu_ctx->pmu);
 
-	event_sched_out(group_event, cpuctx, ctx);
+	event_sched_out(group_event, ctx);
 
 	/*
 	 * Schedule out siblings (if any):
 	 */
 	for_each_sibling_event(event, group_event)
-		event_sched_out(event, cpuctx, ctx);
-
-	perf_pmu_enable(ctx->pmu);
-
-	if (group_event->attr.exclusive)
-		cpuctx->exclusive = 0;
+		event_sched_out(event, ctx);
 }
 
 #define DETACH_GROUP	0x01UL
@@ -2072,7 +2063,7 @@ __perf_remove_from_context(struct perf_e
 		update_cgrp_time_from_cpuctx(cpuctx);
 	}
 
-	event_sched_out(event, cpuctx, ctx);
+	event_sched_out(event, ctx);
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	list_del_event(event, ctx);
@@ -2139,12 +2130,16 @@ static void __perf_event_disable(struct
 		update_cgrp_time_from_event(event);
 	}
 
+	perf_pmu_disable(event->pmu_ctx->pmu);
+
 	if (event == event->group_leader)
-		group_sched_out(event, cpuctx, ctx);
+		group_sched_out(event, ctx);
 	else
-		event_sched_out(event, cpuctx, ctx);
+		event_sched_out(event, ctx);
 
 	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
+
+	perf_pmu_enable(event->pmu_ctx->pmu);
 }
 
 /*
@@ -2240,10 +2235,10 @@ static void perf_log_throttle(struct per
 static void perf_log_itrace_start(struct perf_event *event);
 
 static int
-event_sched_in(struct perf_event *event,
-		 struct perf_cpu_context *cpuctx,
-		 struct perf_event_context *ctx)
+event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
 {
+	struct perf_event_pmu_context *epc = event->pmu_ctx;
+	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(epc->pmu->cpu_pmu_context);
 	int ret = 0;
 
 	lockdep_assert_held(&ctx->lock);
@@ -2284,14 +2279,15 @@ event_sched_in(struct perf_event *event,
 	}
 
 	if (!is_software_event(event))
-		cpuctx->active_oncpu++;
+		cpc->active_oncpu++;
 	if (!ctx->nr_active++)
-		perf_event_ctx_activate(ctx);
+		;
+	event->pmu_ctx->nr_active++;
 	if (event->attr.freq && event->attr.sample_freq)
 		ctx->nr_freq++;
 
 	if (event->attr.exclusive)
-		cpuctx->exclusive = 1;
+		cpc->exclusive = 1;
 
 out:
 	perf_pmu_enable(event->pmu);
@@ -2300,21 +2296,19 @@ event_sched_in(struct perf_event *event,
 }
 
 static int
-group_sched_in(struct perf_event *group_event,
-	       struct perf_cpu_context *cpuctx,
-	       struct perf_event_context *ctx)
+group_sched_in(struct perf_event *group_event, struct perf_event_context *ctx)
 {
 	struct perf_event *event, *partial_group = NULL;
-	struct pmu *pmu = ctx->pmu;
+	struct pmu *pmu = group_event->pmu_ctx->pmu;
 
 	if (group_event->state == PERF_EVENT_STATE_OFF)
 		return 0;
 
 	pmu->start_txn(pmu, PERF_PMU_TXN_ADD);
 
-	if (event_sched_in(group_event, cpuctx, ctx)) {
+	if (event_sched_in(group_event, ctx)) {
 		pmu->cancel_txn(pmu);
-		perf_mux_hrtimer_restart(cpuctx);
+		perf_mux_hrtimer_restart(this_cpu_ptr(pmu->cpu_pmu_context));
 		return -EAGAIN;
 	}
 
@@ -2322,7 +2316,7 @@ group_sched_in(struct perf_event *group_
 	 * Schedule in siblings as one group (if any):
 	 */
 	for_each_sibling_event(event, group_event) {
-		if (event_sched_in(event, cpuctx, ctx)) {
+		if (event_sched_in(event, ctx)) {
 			partial_group = event;
 			goto group_error;
 		}
@@ -2341,13 +2335,13 @@ group_sched_in(struct perf_event *group_
 		if (event == partial_group)
 			break;
 
-		event_sched_out(event, cpuctx, ctx);
+		event_sched_out(event, ctx);
 	}
-	event_sched_out(group_event, cpuctx, ctx);
+	event_sched_out(group_event, ctx);
 
 	pmu->cancel_txn(pmu);
 
-	perf_mux_hrtimer_restart(cpuctx);
+	perf_mux_hrtimer_restart(this_cpu_ptr(pmu->cpu_pmu_context));
 
 	return -EAGAIN;
 }
@@ -2355,10 +2349,11 @@ group_sched_in(struct perf_event *group_
 /*
  * Work out whether we can put this event group on the CPU now.
  */
-static int group_can_go_on(struct perf_event *event,
-			   struct perf_cpu_context *cpuctx,
-			   int can_add_hw)
+static int group_can_go_on(struct perf_event *event, int can_add_hw)
 {
+	struct perf_event_pmu_context *epc = event->pmu_ctx;
+	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(epc->pmu->cpu_pmu_context);
+
 	/*
 	 * Groups consisting entirely of software events can always go on.
 	 */
@@ -2368,13 +2363,13 @@ static int group_can_go_on(struct perf_e
 	 * If an exclusive group is already on, no other hardware
 	 * events can go on.
 	 */
-	if (cpuctx->exclusive)
+	if (cpc->exclusive)
 		return 0;
 	/*
 	 * If this group is exclusive and there are already
 	 * events on the CPU, it can't go on.
 	 */
-	if (event->attr.exclusive && cpuctx->active_oncpu)
+	if (event->attr.exclusive && cpc->active_oncpu)
 		return 0;
 	/*
 	 * Otherwise, try to add it if all previous groups were able
@@ -2391,37 +2386,36 @@ static void add_event_to_ctx(struct perf
 }
 
 static void ctx_sched_out(struct perf_event_context *ctx,
-			  struct perf_cpu_context *cpuctx,
 			  enum event_type_t event_type);
 static void
 ctx_sched_in(struct perf_event_context *ctx,
-	     struct perf_cpu_context *cpuctx,
 	     enum event_type_t event_type,
 	     struct task_struct *task);
 
-static void task_ctx_sched_out(struct perf_cpu_context *cpuctx,
-			       struct perf_event_context *ctx,
+static void task_ctx_sched_out(struct perf_event_context *ctx,
 			       enum event_type_t event_type)
 {
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
+
 	if (!cpuctx->task_ctx)
 		return;
 
 	if (WARN_ON_ONCE(ctx != cpuctx->task_ctx))
 		return;
 
-	ctx_sched_out(ctx, cpuctx, event_type);
+	ctx_sched_out(ctx, event_type);
 }
 
 static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
 				struct perf_event_context *ctx,
 				struct task_struct *task)
 {
-	cpu_ctx_sched_in(cpuctx, EVENT_PINNED, task);
+	ctx_sched_in(&cpuctx->ctx, EVENT_PINNED, task);
 	if (ctx)
-		ctx_sched_in(ctx, cpuctx, EVENT_PINNED, task);
-	cpu_ctx_sched_in(cpuctx, EVENT_FLEXIBLE, task);
+		ctx_sched_in(ctx, EVENT_PINNED, task);
+	ctx_sched_in(&cpuctx->ctx, EVENT_FLEXIBLE, task);
 	if (ctx)
-		ctx_sched_in(ctx, cpuctx, EVENT_FLEXIBLE, task);
+		ctx_sched_in(ctx, EVENT_FLEXIBLE, task);
 }
 
 /*
@@ -2438,12 +2432,12 @@ static void perf_event_sched_in(struct p
  * This can be called after a batch operation on task events, in which case
  * event_type is a bit mask of the types of events involved. For CPU events,
  * event_type is only either EVENT_PINNED or EVENT_FLEXIBLE.
+ *
  */
 static void ctx_resched(struct perf_cpu_context *cpuctx,
 			struct perf_event_context *task_ctx,
 			enum event_type_t event_type)
 {
-	enum event_type_t ctx_event_type;
 	bool cpu_event = !!(event_type & EVENT_CPU);
 
 	/*
@@ -2453,11 +2447,13 @@ static void ctx_resched(struct perf_cpu_
 	if (event_type & EVENT_PINNED)
 		event_type |= EVENT_FLEXIBLE;
 
-	ctx_event_type = event_type & EVENT_ALL;
+	event_type &= EVENT_ALL;
 
-	perf_pmu_disable(cpuctx->ctx.pmu);
-	if (task_ctx)
-		task_ctx_sched_out(cpuctx, task_ctx, event_type);
+	perf_ctx_disable(&cpuctx->ctx);
+	if (task_ctx) {
+		perf_ctx_disable(task_ctx);
+		task_ctx_sched_out(task_ctx, event_type);
+	}
 
 	/*
 	 * Decide which cpu ctx groups to schedule out based on the types
@@ -2467,12 +2463,15 @@ static void ctx_resched(struct perf_cpu_
 	 *  - otherwise, do nothing more.
 	 */
 	if (cpu_event)
-		cpu_ctx_sched_out(cpuctx, ctx_event_type);
-	else if (ctx_event_type & EVENT_PINNED)
-		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
+		ctx_sched_out(&cpuctx->ctx, event_type);
+	else if (event_type & EVENT_PINNED)
+		ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
 
 	perf_event_sched_in(cpuctx, task_ctx, current);
-	perf_pmu_enable(cpuctx->ctx.pmu);
+
+	perf_ctx_enable(&cpuctx->ctx);
+	if (task_ctx)
+		perf_ctx_enable(task_ctx);
 }
 
 /*
@@ -2485,7 +2484,7 @@ static int  __perf_install_in_context(vo
 {
 	struct perf_event *event = info;
 	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
 	struct perf_event_context *task_ctx = cpuctx->task_ctx;
 	bool reprogram = true;
 	int ret = 0;
@@ -2527,7 +2526,7 @@ static int  __perf_install_in_context(vo
 #endif
 
 	if (reprogram) {
-		ctx_sched_out(ctx, cpuctx, EVENT_TIME);
+		ctx_sched_out(ctx, EVENT_TIME);
 		add_event_to_ctx(event, ctx);
 		ctx_resched(cpuctx, task_ctx, get_event_type(event));
 	} else {
@@ -2648,7 +2647,7 @@ static void __perf_event_enable(struct p
 		return;
 
 	if (ctx->is_active)
-		ctx_sched_out(ctx, cpuctx, EVENT_TIME);
+		ctx_sched_out(ctx, EVENT_TIME);
 
 	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
 
@@ -2656,7 +2655,7 @@ static void __perf_event_enable(struct p
 		return;
 
 	if (!event_filter_match(event)) {
-		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
+		ctx_sched_in(ctx, EVENT_TIME, current);
 		return;
 	}
 
@@ -2665,7 +2664,7 @@ static void __perf_event_enable(struct p
 	 * then don't put it on unless the group is on.
 	 */
 	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE) {
-		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
+		ctx_sched_in(ctx, EVENT_TIME, current);
 		return;
 	}
 
@@ -2889,11 +2888,46 @@ static int perf_event_modify_attr(struct
 	}
 }
 
-static void ctx_sched_out(struct perf_event_context *ctx,
-			  struct perf_cpu_context *cpuctx,
-			  enum event_type_t event_type)
+static void __pmu_ctx_sched_out(struct perf_event_pmu_context *pmu_ctx,
+				enum event_type_t event_type)
 {
+	struct perf_event_context *ctx = pmu_ctx->ctx;
 	struct perf_event *event, *tmp;
+	struct pmu *pmu = pmu_ctx->pmu;
+
+	if (ctx->task && !ctx->is_active) {
+		struct perf_cpu_pmu_context *cpc;
+
+		cpc = this_cpu_ptr(pmu->cpu_pmu_context);
+		WARN_ON_ONCE(cpc->task_epc != pmu_ctx);
+		cpc->task_epc = NULL;
+	}
+
+	if (!event_type)
+		return;
+
+	perf_pmu_disable(pmu);
+	if (event_type & EVENT_PINNED) {
+		list_for_each_entry_safe(event, tmp,
+				&pmu_ctx->pinned_active,
+				active_list)
+			group_sched_out(event, ctx);
+	}
+
+	if (event_type & EVENT_FLEXIBLE) {
+		list_for_each_entry_safe(event, tmp,
+				&pmu_ctx->flexible_active,
+				active_list)
+			group_sched_out(event, ctx);
+	}
+	perf_pmu_enable(pmu);
+}
+
+static void
+ctx_sched_out(struct perf_event_context *ctx, enum event_type_t event_type)
+{
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
+	struct perf_event_pmu_context *pmu_ctx;
 	int is_active = ctx->is_active;
 
 	lockdep_assert_held(&ctx->lock);
@@ -2936,20 +2970,8 @@ static void ctx_sched_out(struct perf_ev
 
 	is_active ^= ctx->is_active; /* changed bits */
 
-	if (!ctx->nr_active || !(is_active & EVENT_ALL))
-		return;
-
-	perf_pmu_disable(ctx->pmu);
-	if (is_active & EVENT_PINNED) {
-		list_for_each_entry_safe(event, tmp, &ctx->pinned_active, active_list)
-			group_sched_out(event, cpuctx, ctx);
-	}
-
-	if (is_active & EVENT_FLEXIBLE) {
-		list_for_each_entry_safe(event, tmp, &ctx->flexible_active, active_list)
-			group_sched_out(event, cpuctx, ctx);
-	}
-	perf_pmu_enable(ctx->pmu);
+	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry)
+		__pmu_ctx_sched_out(pmu_ctx, is_active);
 }
 
 /*
@@ -3054,10 +3076,34 @@ static void perf_event_sync_stat(struct
 	}
 }
 
-static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
-					 struct task_struct *next)
+static void perf_event_swap_task_ctx_data(struct perf_event_context *prev_ctx,
+					  struct perf_event_context *next_ctx)
+{
+	struct perf_event_pmu_context *prev_epc, *next_epc;
+
+	if (!prev_ctx->nr_task_data)
+		return;
+
+	prev_epc = list_first_entry(&prev_ctx->pmu_ctx_list,
+				    struct perf_event_pmu_context,
+				    pmu_ctx_entry);
+	next_epc = list_first_entry(&next_ctx->pmu_ctx_list,
+				    struct perf_event_pmu_context,
+				    pmu_ctx_entry);
+
+	while (&prev_epc->pmu_ctx_entry != &prev_ctx->pmu_ctx_list &&
+	       &next_epc->pmu_ctx_entry != &next_ctx->pmu_ctx_list) {
+
+		WARN_ON_ONCE(prev_epc->pmu != next_epc->pmu);
+
+		swap(prev_epc->task_ctx_data, next_epc->task_ctx_data);
+	}
+}
+
+static void
+perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 {
-	struct perf_event_context *ctx = task->perf_event_ctxp[ctxn];
+	struct perf_event_context *ctx = task->perf_event_ctxp;
 	struct perf_event_context *next_ctx;
 	struct perf_event_context *parent, *next_parent;
 	struct perf_cpu_context *cpuctx;
@@ -3066,12 +3112,12 @@ static void perf_event_context_sched_out
 	if (likely(!ctx))
 		return;
 
-	cpuctx = __get_cpu_context(ctx);
+	cpuctx = this_cpu_ptr(&cpu_context);
 	if (!cpuctx->task_ctx)
 		return;
 
 	rcu_read_lock();
-	next_ctx = next->perf_event_ctxp[ctxn];
+	next_ctx = rcu_dereference(next->perf_event_ctxp);
 	if (!next_ctx)
 		goto unlock;
 
@@ -3098,7 +3144,7 @@ static void perf_event_context_sched_out
 			WRITE_ONCE(ctx->task, next);
 			WRITE_ONCE(next_ctx->task, task);
 
-			swap(ctx->task_ctx_data, next_ctx->task_ctx_data);
+			perf_event_swap_task_ctx_data(ctx, next_ctx);
 
 			/*
 			 * RCU_INIT_POINTER here is safe because we've not
@@ -3107,8 +3153,8 @@ static void perf_event_context_sched_out
 			 * since those values are always verified under
 			 * ctx->lock which we're now holding.
 			 */
-			RCU_INIT_POINTER(task->perf_event_ctxp[ctxn], next_ctx);
-			RCU_INIT_POINTER(next->perf_event_ctxp[ctxn], ctx);
+			RCU_INIT_POINTER(task->perf_event_ctxp, next_ctx);
+			RCU_INIT_POINTER(next->perf_event_ctxp, ctx);
 
 			do_switch = 0;
 
@@ -3122,31 +3168,34 @@ static void perf_event_context_sched_out
 
 	if (do_switch) {
 		raw_spin_lock(&ctx->lock);
-		task_ctx_sched_out(cpuctx, ctx, EVENT_ALL);
+		task_ctx_sched_out(ctx, EVENT_ALL);
 		raw_spin_unlock(&ctx->lock);
 	}
 }
 
 static DEFINE_PER_CPU(struct list_head, sched_cb_list);
+static DEFINE_PER_CPU(int, perf_sched_cb_usages);
 
 void perf_sched_cb_dec(struct pmu *pmu)
 {
-	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
+	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(pmu->cpu_pmu_context);
 
 	this_cpu_dec(perf_sched_cb_usages);
+	barrier();
 
-	if (!--cpuctx->sched_cb_usage)
-		list_del(&cpuctx->sched_cb_entry);
+	if (!--cpc->sched_cb_usage)
+		list_del(&cpc->sched_cb_entry);
 }
 
 
 void perf_sched_cb_inc(struct pmu *pmu)
 {
-	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
+	struct perf_cpu_pmu_context *cpc = this_cpu_ptr(pmu->cpu_pmu_context);
 
-	if (!cpuctx->sched_cb_usage++)
-		list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
+	if (!cpc->sched_cb_usage++)
+		list_add(&cpc->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
 
+	barrier();
 	this_cpu_inc(perf_sched_cb_usages);
 }
 
@@ -3162,22 +3211,24 @@ static void perf_pmu_sched_task(struct t
 				struct task_struct *next,
 				bool sched_in)
 {
-	struct perf_cpu_context *cpuctx;
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
+	struct perf_cpu_pmu_context *cpc;
 	struct pmu *pmu;
 
 	if (prev == next)
 		return;
 
-	list_for_each_entry(cpuctx, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
-		pmu = cpuctx->ctx.pmu; /* software PMUs will not have sched_task */
+	list_for_each_entry(cpc, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
+		pmu = cpc->epc.pmu;
 
+		/* software PMUs will not have sched_task */
 		if (WARN_ON_ONCE(!pmu->sched_task))
 			continue;
 
 		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 		perf_pmu_disable(pmu);
 
-		pmu->sched_task(cpuctx->task_ctx, sched_in);
+		pmu->sched_task(cpc->task_epc, sched_in);
 
 		perf_pmu_enable(pmu);
 		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -3187,9 +3238,6 @@ static void perf_pmu_sched_task(struct t
 static void perf_event_switch(struct task_struct *task,
 			      struct task_struct *next_prev, bool sched_in);
 
-#define for_each_task_context_nr(ctxn)					\
-	for ((ctxn) = 0; (ctxn) < perf_nr_task_contexts; (ctxn)++)
-
 /*
  * Called from scheduler to remove the events of the current task,
  * with interrupts disabled.
@@ -3204,16 +3252,13 @@ static void perf_event_switch(struct tas
 void __perf_event_task_sched_out(struct task_struct *task,
 				 struct task_struct *next)
 {
-	int ctxn;
-
 	if (__this_cpu_read(perf_sched_cb_usages))
 		perf_pmu_sched_task(task, next, false);
 
 	if (atomic_read(&nr_switch_events))
 		perf_event_switch(task, next, false);
 
-	for_each_task_context_nr(ctxn)
-		perf_event_context_sched_out(task, ctxn, next);
+	perf_event_context_sched_out(task, next);
 
 	/*
 	 * if cgroup events exist on this CPU, then we need
@@ -3224,27 +3269,19 @@ void __perf_event_task_sched_out(struct
 		perf_cgroup_sched_out(task, next);
 }
 
-/*
- * Called with IRQs disabled
- */
-static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
-			      enum event_type_t event_type)
-{
-	ctx_sched_out(&cpuctx->ctx, cpuctx, event_type);
-}
-
-static int visit_groups_merge(struct perf_event_groups *groups, int cpu,
-			      int (*func)(struct perf_event *, void *), void *data)
+static int
+visit_groups_merge(struct perf_event_groups *groups, int cpu, struct pmu *pmu,
+		   int (*func)(struct perf_event *, void *), void *data)
 {
 	struct perf_event **evt, *evt1, *evt2;
 	int ret;
 
-	evt1 = perf_event_groups_first(groups, -1);
-	evt2 = perf_event_groups_first(groups, cpu);
+	evt1 = perf_event_groups_first(groups, -1, pmu);
+	evt2 = perf_event_groups_first(groups, cpu, pmu);
 
 	while (evt1 || evt2) {
 		if (evt1 && evt2) {
-			if (evt1->group_index < evt2->group_index)
+			if (perf_event_groups_less(evt1, evt2))
 				evt = &evt1;
 			else
 				evt = &evt2;
@@ -3258,7 +3295,7 @@ static int visit_groups_merge(struct per
 		if (ret)
 			return ret;
 
-		*evt = perf_event_groups_next(*evt);
+		*evt = perf_event_groups_next(*evt, pmu);
 	}
 
 	return 0;
@@ -3266,91 +3303,106 @@ static int visit_groups_merge(struct per
 
 struct sched_in_data {
 	struct perf_event_context *ctx;
-	struct perf_cpu_context *cpuctx;
+	struct perf_event_pmu_context *epc;
 	int can_add_hw;
+
+	int pinned; /* set for pinned semantics */
+	int busy;   /* set to terminate on busy */
 };
 
-static int pinned_sched_in(struct perf_event *event, void *data)
+static void __link_epc(struct perf_event_pmu_context *pmu_ctx)
 {
-	struct sched_in_data *sid = data;
+	struct perf_cpu_pmu_context *cpc;
 
-	if (event->state <= PERF_EVENT_STATE_OFF)
-		return 0;
-
-	if (!event_filter_match(event))
-		return 0;
-
-	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
-		if (!group_sched_in(event, sid->cpuctx, sid->ctx))
-			list_add_tail(&event->active_list, &sid->ctx->pinned_active);
-	}
-
-	/*
-	 * If this pinned group hasn't been scheduled,
-	 * put it in error state.
-	 */
-	if (event->state == PERF_EVENT_STATE_INACTIVE)
-		perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+	if (!pmu_ctx->ctx->task)
+		return;
 
-	return 0;
+	cpc = this_cpu_ptr(pmu_ctx->pmu->cpu_pmu_context);
+	WARN_ON_ONCE(cpc->task_epc && cpc->task_epc != pmu_ctx);
+	cpc->task_epc = pmu_ctx;
 }
 
-static int flexible_sched_in(struct perf_event *event, void *data)
+static int merge_sched_in(struct perf_event *event, void *data)
 {
 	struct sched_in_data *sid = data;
 
+	if (sid->epc != event->pmu_ctx) {
+		sid->epc = event->pmu_ctx;
+		sid->can_add_hw = 1;
+		__link_epc(event->pmu_ctx);
+
+		perf_assert_pmu_disabled(sid->epc->pmu);
+	}
+
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
 
 	if (!event_filter_match(event))
 		return 0;
 
-	if (group_can_go_on(event, sid->cpuctx, sid->can_add_hw)) {
-		if (!group_sched_in(event, sid->cpuctx, sid->ctx))
-			list_add_tail(&event->active_list, &sid->ctx->flexible_active);
-		else
+	if (group_can_go_on(event, sid->can_add_hw)) {
+		if (!group_sched_in(event, sid->ctx)) {
+			struct list_head *list;
+
+			if (sid->pinned)
+				list = &sid->epc->pinned_active;
+			else
+				list = &sid->epc->flexible_active;
+
+			list_add_tail(&event->active_list, list);
+		}
+	}
+
+	if (event->state == PERF_EVENT_STATE_INACTIVE) {
+		if (sid->pinned) {
+			/*
+			 * If this pinned group hasn't been scheduled,
+			 * put it in error state.
+			 */
+			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+		} else {
 			sid->can_add_hw = 0;
+			return sid->busy;
+		}
 	}
 
 	return 0;
 }
 
 static void
-ctx_pinned_sched_in(struct perf_event_context *ctx,
-		    struct perf_cpu_context *cpuctx)
+ctx_pinned_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
 {
 	struct sched_in_data sid = {
 		.ctx = ctx,
-		.cpuctx = cpuctx,
-		.can_add_hw = 1,
+		.pinned = 1,
 	};
 
-	visit_groups_merge(&ctx->pinned_groups,
-			   smp_processor_id(),
-			   pinned_sched_in, &sid);
+	visit_groups_merge(&ctx->pinned_groups, smp_processor_id(), pmu,
+			   merge_sched_in, &sid);
 }
 
 static void
-ctx_flexible_sched_in(struct perf_event_context *ctx,
-		      struct perf_cpu_context *cpuctx)
+ctx_flexible_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
 {
 	struct sched_in_data sid = {
 		.ctx = ctx,
-		.cpuctx = cpuctx,
-		.can_add_hw = 1,
+		.busy = pmu ? -EBUSY : 0,
 	};
 
-	visit_groups_merge(&ctx->flexible_groups,
-			   smp_processor_id(),
-			   flexible_sched_in, &sid);
+	visit_groups_merge(&ctx->flexible_groups, smp_processor_id(), pmu,
+			   merge_sched_in, &sid);
+}
+
+static void __pmu_ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
+{
+	ctx_flexible_sched_in(ctx, pmu);
 }
 
 static void
-ctx_sched_in(struct perf_event_context *ctx,
-	     struct perf_cpu_context *cpuctx,
-	     enum event_type_t event_type,
+ctx_sched_in(struct perf_event_context *ctx, enum event_type_t event_type,
 	     struct task_struct *task)
 {
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
 	int is_active = ctx->is_active;
 	u64 now;
 
@@ -3373,6 +3425,7 @@ ctx_sched_in(struct perf_event_context *
 		/* start ctx time */
 		now = perf_clock();
 		ctx->timestamp = now;
+		// XXX ctx->task =? task
 		perf_cgroup_set_timestamp(task, ctx);
 	}
 
@@ -3381,30 +3434,25 @@ ctx_sched_in(struct perf_event_context *
 	 * in order to give them the best chance of going on.
 	 */
 	if (is_active & EVENT_PINNED)
-		ctx_pinned_sched_in(ctx, cpuctx);
+		ctx_pinned_sched_in(ctx, NULL);
 
 	/* Then walk through the lower prio flexible groups */
 	if (is_active & EVENT_FLEXIBLE)
-		ctx_flexible_sched_in(ctx, cpuctx);
+		ctx_flexible_sched_in(ctx, NULL);
 }
 
-static void cpu_ctx_sched_in(struct perf_cpu_context *cpuctx,
-			     enum event_type_t event_type,
-			     struct task_struct *task)
+static void perf_event_context_sched_in(struct task_struct *task)
 {
-	struct perf_event_context *ctx = &cpuctx->ctx;
-
-	ctx_sched_in(ctx, cpuctx, event_type, task);
-}
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
+	struct perf_event_context *ctx;
 
-static void perf_event_context_sched_in(struct perf_event_context *ctx,
-					struct task_struct *task)
-{
-	struct perf_cpu_context *cpuctx;
+	rcu_read_lock();
+	ctx = rcu_dereference(task->perf_event_ctxp);
+	if (!ctx)
+		goto rcu_unlock;
 
-	cpuctx = __get_cpu_context(ctx);
 	if (cpuctx->task_ctx == ctx)
-		return;
+		goto rcu_unlock;
 
 	perf_ctx_lock(cpuctx, ctx);
 	/*
@@ -3414,7 +3462,7 @@ static void perf_event_context_sched_in(
 	if (!ctx->nr_events)
 		goto unlock;
 
-	perf_pmu_disable(ctx->pmu);
+	perf_ctx_disable(ctx);
 	/*
 	 * We want to keep the following priority order:
 	 * cpu pinned (that don't need to move), task pinned,
@@ -3423,13 +3471,21 @@ static void perf_event_context_sched_in(
 	 * However, if task's ctx is not carrying any pinned
 	 * events, no need to flip the cpuctx's events around.
 	 */
-	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree))
-		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
+	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree)) {
+		perf_ctx_disable(&cpuctx->ctx);
+		ctx_sched_out(&cpuctx->ctx, EVENT_FLEXIBLE);
+	}
+
 	perf_event_sched_in(cpuctx, ctx, task);
-	perf_pmu_enable(ctx->pmu);
+
+	if (!RB_EMPTY_ROOT(&ctx->pinned_groups.tree))
+		perf_ctx_enable(&cpuctx->ctx);
+	perf_ctx_enable(ctx);
 
 unlock:
 	perf_ctx_unlock(cpuctx, ctx);
+rcu_unlock:
+	rcu_read_unlock();
 }
 
 /*
@@ -3446,9 +3502,6 @@ static void perf_event_context_sched_in(
 void __perf_event_task_sched_in(struct task_struct *prev,
 				struct task_struct *task)
 {
-	struct perf_event_context *ctx;
-	int ctxn;
-
 	/*
 	 * If cgroup events exist on this CPU, then we need to check if we have
 	 * to switch in PMU state; cgroup event are system-wide mode only.
@@ -3459,13 +3512,7 @@ void __perf_event_task_sched_in(struct t
 	if (atomic_read(this_cpu_ptr(&perf_cgroup_events)))
 		perf_cgroup_sched_in(prev, task);
 
-	for_each_task_context_nr(ctxn) {
-		ctx = task->perf_event_ctxp[ctxn];
-		if (likely(!ctx))
-			continue;
-
-		perf_event_context_sched_in(ctx, task);
-	}
+	perf_event_context_sched_in(task);
 
 	if (atomic_read(&nr_switch_events))
 		perf_event_switch(task, prev, true);
@@ -3584,8 +3631,8 @@ static void perf_adjust_period(struct pe
  * events. At the same time, make sure, having freq events does not change
  * the rate of unthrottling as that would introduce bias.
  */
-static void perf_adjust_freq_unthr_context(struct perf_event_context *ctx,
-					   int needs_unthr)
+static void
+perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
 {
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
@@ -3597,16 +3644,16 @@ static void perf_adjust_freq_unthr_conte
 	 * - context have events in frequency mode (needs freq adjust)
 	 * - there are events to unthrottle on this cpu
 	 */
-	if (!(ctx->nr_freq || needs_unthr))
+	if (!(ctx->nr_freq || unthrottle))
 		return;
 
 	raw_spin_lock(&ctx->lock);
-	perf_pmu_disable(ctx->pmu);
 
 	list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
 		if (event->state != PERF_EVENT_STATE_ACTIVE)
 			continue;
 
+		// XXX use visit thingy to avoid the -1,cpu match
 		if (!event_filter_match(event))
 			continue;
 
@@ -3647,7 +3694,6 @@ static void perf_adjust_freq_unthr_conte
 		perf_pmu_enable(event->pmu);
 	}
 
-	perf_pmu_enable(ctx->pmu);
 	raw_spin_unlock(&ctx->lock);
 }
 
@@ -3668,71 +3714,97 @@ static void rotate_ctx(struct perf_event
 }
 
 static inline struct perf_event *
-ctx_first_active(struct perf_event_context *ctx)
+ctx_first_active(struct perf_event_pmu_context *pmu_ctx)
 {
-	return list_first_entry_or_null(&ctx->flexible_active,
+	return list_first_entry_or_null(&pmu_ctx->flexible_active,
 					struct perf_event, active_list);
 }
 
-static bool perf_rotate_context(struct perf_cpu_context *cpuctx)
+/*
+ * XXX somewhat completely buggered; this is in cpu_pmu_context, but we need
+ * event_pmu_context for rotations. We also need event_pmu_context specific
+ * scheduling routines. ARGH
+ *
+ *  - fixed the cpu_pmu_context vs event_pmu_context thingy
+ *    (cpu_pmu_context embeds an event_pmu_context)
+ *
+ *  - need nr_events/nr_active in epc to do per epc rotation
+ *    (done)
+ *
+ *  - need cpu and task pmu ctx together...
+ *    (cpc->task_epc)
+ */
+static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)
 {
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
+	struct perf_event_pmu_context *cpu_epc, *task_epc = NULL;
 	struct perf_event *cpu_event = NULL, *task_event = NULL;
 	bool cpu_rotate = false, task_rotate = false;
 	struct perf_event_context *ctx = NULL;
+	struct pmu *pmu;
 
 	/*
 	 * Since we run this from IRQ context, nobody can install new
 	 * events, thus the event count values are stable.
 	 */
 
-	if (cpuctx->ctx.nr_events) {
-		if (cpuctx->ctx.nr_events != cpuctx->ctx.nr_active)
-			cpu_rotate = true;
-	}
+	cpu_epc = &cpc->epc;
+	pmu = cpu_epc->pmu;
 
-	ctx = cpuctx->task_ctx;
-	if (ctx && ctx->nr_events) {
-		if (ctx->nr_events != ctx->nr_active)
+	if (cpu_epc->nr_events && cpu_epc->nr_events != cpu_epc->nr_active)
+		cpu_rotate = true;
+
+	task_epc = cpc->task_epc;
+	if (task_epc) {
+		WARN_ON_ONCE(task_epc->pmu != pmu);
+		if (task_epc->nr_events && task_epc->nr_events != task_epc->nr_active)
 			task_rotate = true;
 	}
 
 	if (!(cpu_rotate || task_rotate))
 		return false;
 
-	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
-	perf_pmu_disable(cpuctx->ctx.pmu);
+	perf_ctx_lock(cpuctx, ctx);
+	perf_pmu_disable(pmu);
 
 	if (task_rotate)
-		task_event = ctx_first_active(ctx);
+		task_event = ctx_first_active(task_epc);
+
 	if (cpu_rotate)
-		cpu_event = ctx_first_active(&cpuctx->ctx);
+		cpu_event = ctx_first_active(cpu_epc);
 
 	/*
 	 * As per the order given at ctx_resched() first 'pop' task flexible
 	 * and then, if needed CPU flexible.
 	 */
-	if (task_event || (ctx && cpu_event))
-		ctx_sched_out(ctx, cpuctx, EVENT_FLEXIBLE);
-	if (cpu_event)
-		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
+	if (task_event || (task_epc && cpu_event)) {
+		update_context_time(ctx);
+		__pmu_ctx_sched_out(task_epc, EVENT_FLEXIBLE);
+	}
+
+	if (cpu_event) {
+		update_context_time(&cpuctx->ctx);
+		__pmu_ctx_sched_out(cpu_epc, EVENT_FLEXIBLE);
+		rotate_ctx(&cpuctx->ctx, cpu_event);
+		__pmu_ctx_sched_in(&cpuctx->ctx, pmu);
+	}
 
 	if (task_event)
 		rotate_ctx(ctx, task_event);
-	if (cpu_event)
-		rotate_ctx(&cpuctx->ctx, cpu_event);
 
-	perf_event_sched_in(cpuctx, ctx, current);
+	if (task_event || (task_epc && cpu_event))
+		__pmu_ctx_sched_in(ctx, pmu);
 
-	perf_pmu_enable(cpuctx->ctx.pmu);
-	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
+	perf_pmu_enable(pmu);
+	perf_ctx_unlock(cpuctx, ctx);
 
 	return true;
 }
 
 void perf_event_task_tick(void)
 {
-	struct list_head *head = this_cpu_ptr(&active_ctx_list);
-	struct perf_event_context *ctx, *tmp;
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
+	struct perf_event_context *ctx;
 	int throttled;
 
 	lockdep_assert_irqs_disabled();
@@ -3741,8 +3813,13 @@ void perf_event_task_tick(void)
 	throttled = __this_cpu_xchg(perf_throttled_count, 0);
 	tick_dep_clear_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
 
-	list_for_each_entry_safe(ctx, tmp, head, active_ctx_list)
-		perf_adjust_freq_unthr_context(ctx, throttled);
+	perf_adjust_freq_unthr_context(&cpuctx->ctx, !!throttled);
+
+	rcu_read_lock();
+	ctx = rcu_dereference(current->perf_event_ctxp);
+	if (ctx)
+		perf_adjust_freq_unthr_context(ctx, !!throttled);
+	rcu_read_unlock();
 }
 
 static int event_enable_on_exec(struct perf_event *event,
@@ -3764,9 +3841,9 @@ static int event_enable_on_exec(struct p
  * Enable all of a task's events that have been marked enable-on-exec.
  * This expects task == current.
  */
-static void perf_event_enable_on_exec(int ctxn)
+static void perf_event_enable_on_exec(struct perf_event_context *ctx)
 {
-	struct perf_event_context *ctx, *clone_ctx = NULL;
+	struct perf_event_context *clone_ctx = NULL;
 	enum event_type_t event_type = 0;
 	struct perf_cpu_context *cpuctx;
 	struct perf_event *event;
@@ -3774,13 +3851,16 @@ static void perf_event_enable_on_exec(in
 	int enabled = 0;
 
 	local_irq_save(flags);
-	ctx = current->perf_event_ctxp[ctxn];
-	if (!ctx || !ctx->nr_events)
+	if (WARN_ON_ONCE(current->perf_event_ctxp != ctx))
 		goto out;
 
-	cpuctx = __get_cpu_context(ctx);
+	if (!ctx->nr_events)
+		goto out;
+
+	cpuctx = this_cpu_ptr(&cpu_context);
 	perf_ctx_lock(cpuctx, ctx);
-	ctx_sched_out(ctx, cpuctx, EVENT_TIME);
+	ctx_sched_out(ctx, EVENT_TIME);
+
 	list_for_each_entry(event, &ctx->event_list, event_entry) {
 		enabled |= event_enable_on_exec(event, ctx);
 		event_type |= get_event_type(event);
@@ -3793,7 +3873,7 @@ static void perf_event_enable_on_exec(in
 		clone_ctx = unclone_ctx(ctx);
 		ctx_resched(cpuctx, ctx, event_type);
 	} else {
-		ctx_sched_in(ctx, cpuctx, EVENT_TIME, current);
+		ctx_sched_in(ctx, EVENT_TIME, current);
 	}
 	perf_ctx_unlock(cpuctx, ctx);
 
@@ -3835,7 +3915,7 @@ static void __perf_event_read(void *info
 	struct perf_read_data *data = info;
 	struct perf_event *sub, *event = data->event;
 	struct perf_event_context *ctx = event->ctx;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
 	struct pmu *pmu = event->pmu;
 
 	/*
@@ -4050,17 +4130,25 @@ static void __perf_event_init_context(st
 {
 	raw_spin_lock_init(&ctx->lock);
 	mutex_init(&ctx->mutex);
-	INIT_LIST_HEAD(&ctx->active_ctx_list);
+	INIT_LIST_HEAD(&ctx->pmu_ctx_list);
 	perf_event_groups_init(&ctx->pinned_groups);
 	perf_event_groups_init(&ctx->flexible_groups);
 	INIT_LIST_HEAD(&ctx->event_list);
-	INIT_LIST_HEAD(&ctx->pinned_active);
-	INIT_LIST_HEAD(&ctx->flexible_active);
 	atomic_set(&ctx->refcount, 1);
 }
 
+static void
+__perf_init_event_pmu_context(struct perf_event_pmu_context *epc, struct pmu *pmu)
+{
+	epc->pmu = pmu;
+	INIT_LIST_HEAD(&epc->pmu_ctx_entry);
+	INIT_LIST_HEAD(&epc->pinned_active);
+	INIT_LIST_HEAD(&epc->flexible_active);
+	atomic_set(&epc->refcount, 1);
+}
+
 static struct perf_event_context *
-alloc_perf_context(struct pmu *pmu, struct task_struct *task)
+alloc_perf_context(struct task_struct *task)
 {
 	struct perf_event_context *ctx;
 
@@ -4073,7 +4161,6 @@ alloc_perf_context(struct pmu *pmu, stru
 		ctx->task = task;
 		get_task_struct(task);
 	}
-	ctx->pmu = pmu;
 
 	return ctx;
 }
@@ -4102,22 +4189,19 @@ find_lively_task_by_vpid(pid_t vpid)
  * Returns a matching context with refcount and pincount.
  */
 static struct perf_event_context *
-find_get_context(struct pmu *pmu, struct task_struct *task,
-		struct perf_event *event)
+find_get_context(struct task_struct *task, struct perf_event *event)
 {
 	struct perf_event_context *ctx, *clone_ctx = NULL;
 	struct perf_cpu_context *cpuctx;
-	void *task_ctx_data = NULL;
 	unsigned long flags;
-	int ctxn, err;
-	int cpu = event->cpu;
+	int err;
 
 	if (!task) {
 		/* Must be root to operate on a CPU event: */
 		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
 			return ERR_PTR(-EACCES);
 
-		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
+		cpuctx = per_cpu_ptr(&cpu_context, event->cpu);
 		ctx = &cpuctx->ctx;
 		get_ctx(ctx);
 		++ctx->pin_count;
@@ -4126,43 +4210,22 @@ find_get_context(struct pmu *pmu, struct
 	}
 
 	err = -EINVAL;
-	ctxn = pmu->task_ctx_nr;
-	if (ctxn < 0)
-		goto errout;
-
-	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
-		task_ctx_data = kzalloc(pmu->task_ctx_size, GFP_KERNEL);
-		if (!task_ctx_data) {
-			err = -ENOMEM;
-			goto errout;
-		}
-	}
-
 retry:
-	ctx = perf_lock_task_context(task, ctxn, &flags);
+	ctx = perf_lock_task_context(task, &flags);
 	if (ctx) {
 		clone_ctx = unclone_ctx(ctx);
 		++ctx->pin_count;
 
-		if (task_ctx_data && !ctx->task_ctx_data) {
-			ctx->task_ctx_data = task_ctx_data;
-			task_ctx_data = NULL;
-		}
 		raw_spin_unlock_irqrestore(&ctx->lock, flags);
 
 		if (clone_ctx)
 			put_ctx(clone_ctx);
 	} else {
-		ctx = alloc_perf_context(pmu, task);
+		ctx = alloc_perf_context(task);
 		err = -ENOMEM;
 		if (!ctx)
 			goto errout;
 
-		if (task_ctx_data) {
-			ctx->task_ctx_data = task_ctx_data;
-			task_ctx_data = NULL;
-		}
-
 		err = 0;
 		mutex_lock(&task->perf_event_mutex);
 		/*
@@ -4171,12 +4234,12 @@ find_get_context(struct pmu *pmu, struct
 		 */
 		if (task->flags & PF_EXITING)
 			err = -ESRCH;
-		else if (task->perf_event_ctxp[ctxn])
+		else if (task->perf_event_ctxp)
 			err = -EAGAIN;
 		else {
 			get_ctx(ctx);
 			++ctx->pin_count;
-			rcu_assign_pointer(task->perf_event_ctxp[ctxn], ctx);
+			rcu_assign_pointer(task->perf_event_ctxp, ctx);
 		}
 		mutex_unlock(&task->perf_event_mutex);
 
@@ -4189,14 +4252,117 @@ find_get_context(struct pmu *pmu, struct
 		}
 	}
 
-	kfree(task_ctx_data);
 	return ctx;
 
 errout:
-	kfree(task_ctx_data);
 	return ERR_PTR(err);
 }
 
+struct perf_event_pmu_context *
+find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
+		     struct perf_event *event)
+{
+	struct perf_event_pmu_context *new = NULL, *epc;
+	void *task_ctx_data = NULL;
+
+	if (!ctx->task) {
+		struct perf_cpu_pmu_context *cpc;
+
+		cpc = per_cpu_ptr(pmu->cpu_pmu_context, event->cpu);
+		epc = &cpc->epc;
+
+		if (!epc->ctx) {
+			atomic_set(&epc->refcount, 1);
+			epc->embedded = 1;
+			raw_spin_lock_irq(&ctx->lock);
+			list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
+			epc->ctx = ctx;
+			raw_spin_unlock_irq(&ctx->lock);
+		} else {
+			WARN_ON_ONCE(epc->ctx != ctx);
+			atomic_inc(&epc->refcount);
+		}
+
+		return epc;
+	}
+
+	new = kzalloc(sizeof(*epc), GFP_KERNEL);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+
+	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
+		task_ctx_data = kzalloc(pmu->task_ctx_size, GFP_KERNEL);
+		if (!task_ctx_data) {
+			kfree(new);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	__perf_init_event_pmu_context(new, pmu);
+
+	raw_spin_lock_irq(&ctx->lock);
+	list_for_each_entry(epc, &ctx->pmu_ctx_list, pmu_ctx_entry) {
+		if (epc->pmu == pmu) {
+			WARN_ON_ONCE(epc->ctx != ctx);
+			atomic_inc(&epc->refcount);
+			goto found_epc;
+		}
+	}
+
+	epc = new;
+	new = NULL;
+
+	list_add(&epc->pmu_ctx_entry, &ctx->pmu_ctx_list);
+	epc->ctx = ctx;
+
+found_epc:
+	if (task_ctx_data && !epc->task_ctx_data) {
+		epc->task_ctx_data = task_ctx_data;
+		task_ctx_data = NULL;
+		ctx->nr_task_data++;
+	}
+	raw_spin_unlock_irq(&ctx->lock);
+
+	kfree(task_ctx_data);
+	kfree(new);
+
+	return epc;
+}
+
+static void get_pmu_ctx(struct perf_event_pmu_context *epc)
+{
+	WARN_ON_ONCE(!atomic_inc_not_zero(&epc->refcount));
+}
+
+static void put_pmu_ctx(struct perf_event_pmu_context *epc)
+{
+	unsigned long flags;
+
+	if (!atomic_dec_and_test(&epc->refcount))
+		return;
+
+	if (epc->ctx) {
+		struct perf_event_context *ctx = epc->ctx;
+
+		// XXX ctx->mutex
+
+		WARN_ON_ONCE(list_empty(&epc->pmu_ctx_entry));
+		raw_spin_lock_irqsave(&ctx->lock, flags);
+		list_del_init(&epc->pmu_ctx_entry);
+		epc->ctx = NULL;
+		raw_spin_unlock_irqrestore(&ctx->lock, flags);
+	}
+
+	WARN_ON_ONCE(!list_empty(&epc->pinned_active));
+	WARN_ON_ONCE(!list_empty(&epc->flexible_active));
+
+	if (epc->embedded)
+		return;
+
+	kfree(epc->task_ctx_data);
+	kfree(epc);
+}
+
 static void perf_event_free_filter(struct perf_event *event);
 static void perf_event_free_bpf_prog(struct perf_event *event);
 
@@ -4445,6 +4611,9 @@ static void _free_event(struct perf_even
 	if (event->destroy)
 		event->destroy(event);
 
+	if (event->pmu_ctx)
+		put_pmu_ctx(event->pmu_ctx);
+
 	if (event->ctx)
 		put_ctx(event->ctx);
 
@@ -4943,7 +5112,7 @@ static void __perf_event_period(struct p
 
 	active = (event->state == PERF_EVENT_STATE_ACTIVE);
 	if (active) {
-		perf_pmu_disable(ctx->pmu);
+		perf_pmu_disable(event->pmu);
 		/*
 		 * We could be throttled; unthrottle now to avoid the tick
 		 * trying to unthrottle while we already re-started the event.
@@ -4959,7 +5128,7 @@ static void __perf_event_period(struct p
 
 	if (active) {
 		event->pmu->start(event, PERF_EF_RELOAD);
-		perf_pmu_enable(ctx->pmu);
+		perf_pmu_enable(event->pmu);
 	}
 }
 
@@ -6634,7 +6803,6 @@ perf_iterate_sb(perf_iterate_f output, v
 	       struct perf_event_context *task_ctx)
 {
 	struct perf_event_context *ctx;
-	int ctxn;
 
 	rcu_read_lock();
 	preempt_disable();
@@ -6651,11 +6819,9 @@ perf_iterate_sb(perf_iterate_f output, v
 
 	perf_iterate_sb_cpu(output, data);
 
-	for_each_task_context_nr(ctxn) {
-		ctx = rcu_dereference(current->perf_event_ctxp[ctxn]);
-		if (ctx)
-			perf_iterate_ctx(ctx, output, data, false);
-	}
+	ctx = rcu_dereference(current->perf_event_ctxp);
+	if (ctx)
+		perf_iterate_ctx(ctx, output, data, false);
 done:
 	preempt_enable();
 	rcu_read_unlock();
@@ -6696,18 +6862,12 @@ static void perf_event_addr_filters_exec
 void perf_event_exec(void)
 {
 	struct perf_event_context *ctx;
-	int ctxn;
 
 	rcu_read_lock();
-	for_each_task_context_nr(ctxn) {
-		ctx = current->perf_event_ctxp[ctxn];
-		if (!ctx)
-			continue;
-
-		perf_event_enable_on_exec(ctxn);
-
-		perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL,
-				   true);
+	ctx = rcu_dereference(current->perf_event_ctxp);
+	if (ctx) {
+		perf_event_enable_on_exec(ctx);
+		perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL, true);
 	}
 	rcu_read_unlock();
 }
@@ -6749,8 +6909,7 @@ static void __perf_event_output_stop(str
 static int __perf_pmu_output_stop(void *info)
 {
 	struct perf_event *event = info;
-	struct pmu *pmu = event->pmu;
-	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
 	struct remote_output ro = {
 		.rb	= event->rb,
 	};
@@ -7398,7 +7557,6 @@ static void __perf_addr_filters_adjust(s
 static void perf_addr_filters_adjust(struct vm_area_struct *vma)
 {
 	struct perf_event_context *ctx;
-	int ctxn;
 
 	/*
 	 * Data tracing isn't supported yet and as such there is no need
@@ -7408,13 +7566,9 @@ static void perf_addr_filters_adjust(str
 		return;
 
 	rcu_read_lock();
-	for_each_task_context_nr(ctxn) {
-		ctx = rcu_dereference(current->perf_event_ctxp[ctxn]);
-		if (!ctx)
-			continue;
-
+	ctx = rcu_dereference(current->perf_event_ctxp);
+	if (ctx)
 		perf_iterate_ctx(ctx, __perf_addr_filters_adjust, vma, true);
-	}
 	rcu_read_unlock();
 }
 
@@ -8309,10 +8463,13 @@ void perf_tp_event(u16 event_type, u64 c
 		struct trace_entry *entry = record;
 
 		rcu_read_lock();
-		ctx = rcu_dereference(task->perf_event_ctxp[perf_sw_context]);
+		ctx = rcu_dereference(task->perf_event_ctxp);
 		if (!ctx)
 			goto unlock;
 
+		// XXX iterate groups instead, we should be able to
+		// find the subtree for the perf_tracepoint pmu and CPU.
+
 		list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
 			if (event->cpu != smp_processor_id())
 				continue;
@@ -9404,25 +9561,6 @@ static int perf_event_idx_default(struct
 	return 0;
 }
 
-/*
- * Ensures all contexts with the same task_ctx_nr have the same
- * pmu_cpu_context too.
- */
-static struct perf_cpu_context __percpu *find_pmu_context(int ctxn)
-{
-	struct pmu *pmu;
-
-	if (ctxn < 0)
-		return NULL;
-
-	list_for_each_entry(pmu, &pmus, entry) {
-		if (pmu->task_ctx_nr == ctxn)
-			return pmu->pmu_cpu_context;
-	}
-
-	return NULL;
-}
-
 static void free_pmu_context(struct pmu *pmu)
 {
 	/*
@@ -9433,7 +9571,7 @@ static void free_pmu_context(struct pmu
 	if (pmu->task_ctx_nr > perf_invalid_context)
 		return;
 
-	free_percpu(pmu->pmu_cpu_context);
+	free_percpu(pmu->cpu_pmu_context);
 }
 
 /*
@@ -9497,12 +9635,12 @@ perf_event_mux_interval_ms_store(struct
 	/* update all cpuctx for this PMU */
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
-		struct perf_cpu_context *cpuctx;
-		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
-		cpuctx->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * timer);
+		struct perf_cpu_pmu_context *cpc;
+		cpc = per_cpu_ptr(pmu->cpu_pmu_context, cpu);
+		cpc->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * timer);
 
 		cpu_function_call(cpu,
-			(remote_function_f)perf_mux_hrtimer_restart, cpuctx);
+			(remote_function_f)perf_mux_hrtimer_restart, cpc);
 	}
 	cpus_read_unlock();
 	mutex_unlock(&mux_interval_mutex);
@@ -9602,44 +9740,19 @@ int perf_pmu_register(struct pmu *pmu, c
 	}
 
 skip_type:
-	if (pmu->task_ctx_nr == perf_hw_context) {
-		static int hw_context_taken = 0;
-
-		/*
-		 * Other than systems with heterogeneous CPUs, it never makes
-		 * sense for two PMUs to share perf_hw_context. PMUs which are
-		 * uncore must use perf_invalid_context.
-		 */
-		if (WARN_ON_ONCE(hw_context_taken &&
-		    !(pmu->capabilities & PERF_PMU_CAP_HETEROGENEOUS_CPUS)))
-			pmu->task_ctx_nr = perf_invalid_context;
-
-		hw_context_taken = 1;
-	}
-
-	pmu->pmu_cpu_context = find_pmu_context(pmu->task_ctx_nr);
-	if (pmu->pmu_cpu_context)
-		goto got_cpu_context;
-
 	ret = -ENOMEM;
-	pmu->pmu_cpu_context = alloc_percpu(struct perf_cpu_context);
-	if (!pmu->pmu_cpu_context)
+	pmu->cpu_pmu_context = alloc_percpu(struct perf_cpu_pmu_context);
+	if (!pmu->cpu_pmu_context)
 		goto free_dev;
 
 	for_each_possible_cpu(cpu) {
-		struct perf_cpu_context *cpuctx;
+		struct perf_cpu_pmu_context *cpc;
 
-		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
-		__perf_event_init_context(&cpuctx->ctx);
-		lockdep_set_class(&cpuctx->ctx.mutex, &cpuctx_mutex);
-		lockdep_set_class(&cpuctx->ctx.lock, &cpuctx_lock);
-		cpuctx->ctx.pmu = pmu;
-		cpuctx->online = cpumask_test_cpu(cpu, perf_online_mask);
-
-		__perf_mux_hrtimer_init(cpuctx, cpu);
+		cpc = per_cpu_ptr(pmu->cpu_pmu_context, cpu);
+		__perf_init_event_pmu_context(&cpc->epc, pmu);
+		__perf_mux_hrtimer_init(cpc, cpu);
 	}
 
-got_cpu_context:
 	if (!pmu->start_txn) {
 		if (pmu->pmu_enable) {
 			/*
@@ -10349,37 +10462,6 @@ static int perf_event_set_clock(struct p
 	return 0;
 }
 
-/*
- * Variation on perf_event_ctx_lock_nested(), except we take two context
- * mutexes.
- */
-static struct perf_event_context *
-__perf_event_ctx_lock_double(struct perf_event *group_leader,
-			     struct perf_event_context *ctx)
-{
-	struct perf_event_context *gctx;
-
-again:
-	rcu_read_lock();
-	gctx = READ_ONCE(group_leader->ctx);
-	if (!atomic_inc_not_zero(&gctx->refcount)) {
-		rcu_read_unlock();
-		goto again;
-	}
-	rcu_read_unlock();
-
-	mutex_lock_double(&gctx->mutex, &ctx->mutex);
-
-	if (group_leader->ctx != gctx) {
-		mutex_unlock(&ctx->mutex);
-		mutex_unlock(&gctx->mutex);
-		put_ctx(gctx);
-		goto again;
-	}
-
-	return gctx;
-}
-
 /**
  * sys_perf_event_open - open a performance event, associate it to a task/cpu
  *
@@ -10393,9 +10475,10 @@ SYSCALL_DEFINE5(perf_event_open,
 		pid_t, pid, int, cpu, int, group_fd, unsigned long, flags)
 {
 	struct perf_event *group_leader = NULL, *output_event = NULL;
+	struct perf_event_pmu_context *pmu_ctx;
 	struct perf_event *event, *sibling;
 	struct perf_event_attr attr;
-	struct perf_event_context *ctx, *uninitialized_var(gctx);
+	struct perf_event_context *ctx;
 	struct file *event_file = NULL;
 	struct fd group = {NULL, 0};
 	struct task_struct *task = NULL;
@@ -10506,6 +10589,8 @@ SYSCALL_DEFINE5(perf_event_open,
 		goto err_cred;
 	}
 
+	// XXX premature; what if this is allowed, but we get moved to a PMU
+	// that doesn't have this.
 	if (is_sampling_event(event)) {
 		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
 			err = -EOPNOTSUPP;
@@ -10525,50 +10610,45 @@ SYSCALL_DEFINE5(perf_event_open,
 			goto err_alloc;
 	}
 
+	if (pmu->task_ctx_nr < 0 && task) {
+		err = -EINVAL;
+		goto err_alloc;
+	}
+
 	if (pmu->task_ctx_nr == perf_sw_context)
 		event->event_caps |= PERF_EV_CAP_SOFTWARE;
 
-	if (group_leader) {
-		if (is_software_event(event) &&
-		    !in_software_context(group_leader)) {
-			/*
-			 * If the event is a sw event, but the group_leader
-			 * is on hw context.
-			 *
-			 * Allow the addition of software events to hw
-			 * groups, this is safe because software events
-			 * never fail to schedule.
-			 */
-			pmu = group_leader->ctx->pmu;
-		} else if (!is_software_event(event) &&
-			   is_software_event(group_leader) &&
-			   (group_leader->group_caps & PERF_EV_CAP_SOFTWARE)) {
-			/*
-			 * In case the group is a pure software group, and we
-			 * try to add a hardware event, move the whole group to
-			 * the hardware context.
-			 */
-			move_group = 1;
-		}
-	}
-
 	/*
 	 * Get the target context (task or percpu):
 	 */
-	ctx = find_get_context(pmu, task, event);
+	ctx = find_get_context(task, event);
 	if (IS_ERR(ctx)) {
 		err = PTR_ERR(ctx);
 		goto err_alloc;
 	}
 
-	if ((pmu->capabilities & PERF_PMU_CAP_EXCLUSIVE) && group_leader) {
-		err = -EBUSY;
-		goto err_context;
+	mutex_lock(&ctx->mutex);
+
+	if (ctx->task == TASK_TOMBSTONE) {
+		err = -ESRCH;
+		goto err_locked;
+	}
+
+	if (!task) {
+		/*
+		 * Check if the @cpu we're creating an event for is online.
+		 *
+		 * We use the perf_cpu_context::ctx::mutex to serialize against
+		 * the hotplug notifiers. See perf_event_{init,exit}_cpu().
+		 */
+		struct perf_cpu_context *cpuctx = per_cpu_ptr(&cpu_context, event->cpu);
+
+		if (!cpuctx->online) {
+			err = -ENODEV;
+			goto err_locked;
+		}
 	}
 
-	/*
-	 * Look up the group leader (we will attach this event to it):
-	 */
 	if (group_leader) {
 		err = -EINVAL;
 
@@ -10577,11 +10657,11 @@ SYSCALL_DEFINE5(perf_event_open,
 		 * becoming part of another group-sibling):
 		 */
 		if (group_leader->group_leader != group_leader)
-			goto err_context;
+			goto err_locked;
 
 		/* All events in a group should have the same clock */
 		if (group_leader->clock != event->clock)
-			goto err_context;
+			goto err_locked;
 
 		/*
 		 * Make sure we're both events for the same CPU;
@@ -10589,28 +10669,57 @@ SYSCALL_DEFINE5(perf_event_open,
 		 * you can never concurrently schedule them anyhow.
 		 */
 		if (group_leader->cpu != event->cpu)
-			goto err_context;
-
-		/*
-		 * Make sure we're both on the same task, or both
-		 * per-CPU events.
-		 */
-		if (group_leader->ctx->task != ctx->task)
-			goto err_context;
+			goto err_locked;
 
 		/*
-		 * Do not allow to attach to a group in a different task
-		 * or CPU context. If we're moving SW events, we'll fix
-		 * this up later, so allow that.
+		 * Make sure we're both on the same context; either task or cpu.
 		 */
-		if (!move_group && group_leader->ctx != ctx)
-			goto err_context;
+		if (group_leader->ctx != ctx)
+			goto err_locked;
 
 		/*
 		 * Only a group leader can be exclusive or pinned
 		 */
 		if (attr.exclusive || attr.pinned)
-			goto err_context;
+			goto err_locked;
+
+		if (is_software_event(event) &&
+		    !in_software_context(group_leader)) {
+			/*
+			 * If the event is a sw event, but the group_leader
+			 * is on hw context.
+			 *
+			 * Allow the addition of software events to hw
+			 * groups, this is safe because software events
+			 * never fail to schedule.
+			 */
+			pmu = group_leader->pmu_ctx->pmu;
+		} else if (!is_software_event(event) &&
+			   is_software_event(group_leader) &&
+			   (group_leader->group_caps & PERF_EV_CAP_SOFTWARE)) {
+			/*
+			 * In case the group is a pure software group, and we
+			 * try to add a hardware event, move the whole group to
+			 * the hardware context.
+			 */
+			move_group = 1;
+		}
+	}
+
+	/*
+	 * Now that we're certain of the pmu; find the pmu_ctx.
+	 */
+	pmu_ctx = find_get_pmu_context(pmu, ctx, event);
+	if (IS_ERR(pmu_ctx)) {
+		err = PTR_ERR(pmu_ctx);
+		goto err_locked;
+	}
+	event->pmu_ctx = pmu_ctx;
+
+	// XXX think about exclusive
+	if ((pmu->capabilities & PERF_PMU_CAP_EXCLUSIVE) && group_leader) {
+		err = -EBUSY;
+		goto err_context;
 	}
 
 	if (output_event) {
@@ -10619,71 +10728,18 @@ SYSCALL_DEFINE5(perf_event_open,
 			goto err_context;
 	}
 
-	event_file = anon_inode_getfile("[perf_event]", &perf_fops, event,
-					f_flags);
+	event_file = anon_inode_getfile("[perf_event]", &perf_fops, event, f_flags);
 	if (IS_ERR(event_file)) {
 		err = PTR_ERR(event_file);
 		event_file = NULL;
 		goto err_context;
 	}
 
-	if (move_group) {
-		gctx = __perf_event_ctx_lock_double(group_leader, ctx);
-
-		if (gctx->task == TASK_TOMBSTONE) {
-			err = -ESRCH;
-			goto err_locked;
-		}
-
-		/*
-		 * Check if we raced against another sys_perf_event_open() call
-		 * moving the software group underneath us.
-		 */
-		if (!(group_leader->group_caps & PERF_EV_CAP_SOFTWARE)) {
-			/*
-			 * If someone moved the group out from under us, check
-			 * if this new event wound up on the same ctx, if so
-			 * its the regular !move_group case, otherwise fail.
-			 */
-			if (gctx != ctx) {
-				err = -EINVAL;
-				goto err_locked;
-			} else {
-				perf_event_ctx_unlock(group_leader, gctx);
-				move_group = 0;
-			}
-		}
-	} else {
-		mutex_lock(&ctx->mutex);
-	}
-
-	if (ctx->task == TASK_TOMBSTONE) {
-		err = -ESRCH;
-		goto err_locked;
-	}
-
 	if (!perf_event_validate_size(event)) {
 		err = -E2BIG;
-		goto err_locked;
+		goto err_file;
 	}
 
-	if (!task) {
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
-			err = -ENODEV;
-			goto err_locked;
-		}
-	}
-
-
 	/*
 	 * Must be under the same ctx::mutex as perf_install_in_context(),
 	 * because we need to serialize with concurrent event creation.
@@ -10693,7 +10749,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		WARN_ON_ONCE(move_group);
 
 		err = -EBUSY;
-		goto err_locked;
+		goto err_file;
 	}
 
 	WARN_ON_ONCE(ctx->parent_ctx);
@@ -10704,25 +10760,15 @@ SYSCALL_DEFINE5(perf_event_open,
 	 */
 
 	if (move_group) {
-		/*
-		 * See perf_event_ctx_lock() for comments on the details
-		 * of swizzling perf_event::ctx.
-		 */
 		perf_remove_from_context(group_leader, 0);
-		put_ctx(gctx);
+		put_pmu_ctx(group_leader->pmu_ctx);
 
 		for_each_sibling_event(sibling, group_leader) {
 			perf_remove_from_context(sibling, 0);
-			put_ctx(gctx);
+			put_pmu_ctx(sibling->pmu_ctx);
 		}
 
 		/*
-		 * Wait for everybody to stop referencing the events through
-		 * the old lists, before installing it on new lists.
-		 */
-		synchronize_rcu();
-
-		/*
 		 * Install the group siblings before the group leader.
 		 *
 		 * Because a group leader will try and install the entire group
@@ -10733,9 +10779,10 @@ SYSCALL_DEFINE5(perf_event_open,
 		 * reachable through the group lists.
 		 */
 		for_each_sibling_event(sibling, group_leader) {
+			sibling->pmu_ctx = pmu_ctx;
+			get_pmu_ctx(pmu_ctx);
 			perf_event__state_init(sibling);
 			perf_install_in_context(ctx, sibling, sibling->cpu);
-			get_ctx(ctx);
 		}
 
 		/*
@@ -10743,9 +10790,10 @@ SYSCALL_DEFINE5(perf_event_open,
 		 * event. What we want here is event in the initial
 		 * startup state, ready to be add into new context.
 		 */
+		group_leader->pmu_ctx = pmu_ctx;
+		get_pmu_ctx(pmu_ctx);
 		perf_event__state_init(group_leader);
 		perf_install_in_context(ctx, group_leader, group_leader->cpu);
-		get_ctx(ctx);
 	}
 
 	/*
@@ -10762,8 +10810,6 @@ SYSCALL_DEFINE5(perf_event_open,
 	perf_install_in_context(ctx, event, event->cpu);
 	perf_unpin_context(ctx);
 
-	if (move_group)
-		perf_event_ctx_unlock(group_leader, gctx);
 	mutex_unlock(&ctx->mutex);
 
 	if (task) {
@@ -10785,13 +10831,12 @@ SYSCALL_DEFINE5(perf_event_open,
 	fd_install(event_fd, event_file);
 	return event_fd;
 
-err_locked:
-	if (move_group)
-		perf_event_ctx_unlock(group_leader, gctx);
-	mutex_unlock(&ctx->mutex);
-/* err_file: */
+err_file:
 	fput(event_file);
 err_context:
+	/* event->pmu_ctx freed by free_event() */
+err_locked:
+	mutex_unlock(&ctx->mutex);
 	perf_unpin_context(ctx);
 	put_ctx(ctx);
 err_alloc:
@@ -10827,8 +10872,10 @@ perf_event_create_kernel_counter(struct
 				 perf_overflow_handler_t overflow_handler,
 				 void *context)
 {
+	struct perf_event_pmu_context *pmu_ctx;
 	struct perf_event_context *ctx;
 	struct perf_event *event;
+	struct pmu *pmu;
 	int err;
 
 	/*
@@ -10844,12 +10891,28 @@ perf_event_create_kernel_counter(struct
 
 	/* Mark owner so we could distinguish it from user events. */
 	event->owner = TASK_TOMBSTONE;
+	pmu = event->pmu;
+
+	if (pmu->task_ctx_nr < 0 && task) {
+		err = -EINVAL;
+		goto err_alloc;
+	}
+
+	if (pmu->task_ctx_nr == perf_sw_context)
+		event->event_caps |= PERF_EV_CAP_SOFTWARE;
 
-	ctx = find_get_context(event->pmu, task, event);
+	ctx = find_get_context(task, event);
 	if (IS_ERR(ctx)) {
 		err = PTR_ERR(ctx);
-		goto err_free;
+		goto err_alloc;
+	}
+
+	pmu_ctx = find_get_pmu_context(pmu, ctx, event);
+	if (IS_ERR(pmu_ctx)) {
+		err = PTR_ERR(pmu_ctx);
+		goto err_ctx;
 	}
+	event->pmu_ctx = pmu_ctx;
 
 	WARN_ON_ONCE(ctx->parent_ctx);
 	mutex_lock(&ctx->mutex);
@@ -10886,9 +10949,10 @@ perf_event_create_kernel_counter(struct
 
 err_unlock:
 	mutex_unlock(&ctx->mutex);
+err_ctx:
 	perf_unpin_context(ctx);
 	put_ctx(ctx);
-err_free:
+err_alloc:
 	free_event(event);
 err:
 	return ERR_PTR(err);
@@ -10897,6 +10961,7 @@ EXPORT_SYMBOL_GPL(perf_event_create_kern
 
 void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
 {
+#if 0 // XXX buggered - cpu hotplug, who cares
 	struct perf_event_context *src_ctx;
 	struct perf_event_context *dst_ctx;
 	struct perf_event *event, *tmp;
@@ -10957,6 +11022,7 @@ void perf_pmu_migrate_context(struct pmu
 	}
 	mutex_unlock(&dst_ctx->mutex);
 	mutex_unlock(&src_ctx->mutex);
+#endif
 }
 EXPORT_SYMBOL_GPL(perf_pmu_migrate_context);
 
@@ -11038,14 +11104,14 @@ perf_event_exit_event(struct perf_event
 	put_event(parent_event);
 }
 
-static void perf_event_exit_task_context(struct task_struct *child, int ctxn)
+static void perf_event_exit_task_context(struct task_struct *child)
 {
 	struct perf_event_context *child_ctx, *clone_ctx = NULL;
 	struct perf_event *child_event, *next;
 
 	WARN_ON_ONCE(child != current);
 
-	child_ctx = perf_pin_task_context(child, ctxn);
+	child_ctx = perf_pin_task_context(child);
 	if (!child_ctx)
 		return;
 
@@ -11067,13 +11133,13 @@ static void perf_event_exit_task_context
 	 * in.
 	 */
 	raw_spin_lock_irq(&child_ctx->lock);
-	task_ctx_sched_out(__get_cpu_context(child_ctx), child_ctx, EVENT_ALL);
+	task_ctx_sched_out(child_ctx, EVENT_ALL);
 
 	/*
 	 * Now that the context is inactive, destroy the task <-> ctx relation
 	 * and mark the context dead.
 	 */
-	RCU_INIT_POINTER(child->perf_event_ctxp[ctxn], NULL);
+	RCU_INIT_POINTER(child->perf_event_ctxp, NULL);
 	put_ctx(child_ctx); /* cannot be last */
 	WRITE_ONCE(child_ctx->task, TASK_TOMBSTONE);
 	put_task_struct(current); /* cannot be last */
@@ -11108,7 +11174,6 @@ static void perf_event_exit_task_context
 void perf_event_exit_task(struct task_struct *child)
 {
 	struct perf_event *event, *tmp;
-	int ctxn;
 
 	mutex_lock(&child->perf_event_mutex);
 	list_for_each_entry_safe(event, tmp, &child->perf_event_list,
@@ -11124,8 +11189,7 @@ void perf_event_exit_task(struct task_st
 	}
 	mutex_unlock(&child->perf_event_mutex);
 
-	for_each_task_context_nr(ctxn)
-		perf_event_exit_task_context(child, ctxn);
+	perf_event_exit_task_context(child);
 
 	/*
 	 * The perf_event_exit_task_context calls perf_event_task
@@ -11168,40 +11232,34 @@ void perf_event_free_task(struct task_st
 {
 	struct perf_event_context *ctx;
 	struct perf_event *event, *tmp;
-	int ctxn;
 
-	for_each_task_context_nr(ctxn) {
-		ctx = task->perf_event_ctxp[ctxn];
-		if (!ctx)
-			continue;
+	ctx = rcu_dereference(task->perf_event_ctxp);
+	if (!ctx)
+		return;
 
-		mutex_lock(&ctx->mutex);
-		raw_spin_lock_irq(&ctx->lock);
-		/*
-		 * Destroy the task <-> ctx relation and mark the context dead.
-		 *
-		 * This is important because even though the task hasn't been
-		 * exposed yet the context has been (through child_list).
-		 */
-		RCU_INIT_POINTER(task->perf_event_ctxp[ctxn], NULL);
-		WRITE_ONCE(ctx->task, TASK_TOMBSTONE);
-		put_task_struct(task); /* cannot be last */
-		raw_spin_unlock_irq(&ctx->lock);
+	mutex_lock(&ctx->mutex);
+	raw_spin_lock_irq(&ctx->lock);
+	/*
+	 * Destroy the task <-> ctx relation and mark the context dead.
+	 *
+	 * This is important because even though the task hasn't been
+	 * exposed yet the context has been (through child_list).
+	 */
+	RCU_INIT_POINTER(task->perf_event_ctxp, NULL);
+	WRITE_ONCE(ctx->task, TASK_TOMBSTONE);
+	put_task_struct(task); /* cannot be last */
+	raw_spin_unlock_irq(&ctx->lock);
 
-		list_for_each_entry_safe(event, tmp, &ctx->event_list, event_entry)
-			perf_free_event(event, ctx);
+	list_for_each_entry_safe(event, tmp, &ctx->event_list, event_entry)
+		perf_free_event(event, ctx);
 
-		mutex_unlock(&ctx->mutex);
-		put_ctx(ctx);
-	}
+	mutex_unlock(&ctx->mutex);
+	put_ctx(ctx);
 }
 
 void perf_event_delayed_put(struct task_struct *task)
 {
-	int ctxn;
-
-	for_each_task_context_nr(ctxn)
-		WARN_ON_ONCE(task->perf_event_ctxp[ctxn]);
+	WARN_ON_ONCE(task->perf_event_ctxp);
 }
 
 struct file *perf_event_get(unsigned int fd)
@@ -11253,6 +11311,7 @@ inherit_event(struct perf_event *parent_
 	      struct perf_event_context *child_ctx)
 {
 	enum perf_event_state parent_state = parent_event->state;
+	struct perf_event_pmu_context *pmu_ctx;
 	struct perf_event *child_event;
 	unsigned long flags;
 
@@ -11273,18 +11332,12 @@ inherit_event(struct perf_event *parent_
 	if (IS_ERR(child_event))
 		return child_event;
 
-
-	if ((child_event->attach_state & PERF_ATTACH_TASK_DATA) &&
-	    !child_ctx->task_ctx_data) {
-		struct pmu *pmu = child_event->pmu;
-
-		child_ctx->task_ctx_data = kzalloc(pmu->task_ctx_size,
-						   GFP_KERNEL);
-		if (!child_ctx->task_ctx_data) {
-			free_event(child_event);
-			return NULL;
-		}
+	pmu_ctx = find_get_pmu_context(child_event->pmu, child_ctx, child_event);
+	if (!pmu_ctx) {
+		free_event(child_event);
+		return NULL;
 	}
+	child_event->pmu_ctx = pmu_ctx;
 
 	/*
 	 * is_orphaned_event() and list_add_tail(&parent_event->child_list)
@@ -11402,18 +11455,18 @@ static int inherit_group(struct perf_eve
 static int
 inherit_task_group(struct perf_event *event, struct task_struct *parent,
 		   struct perf_event_context *parent_ctx,
-		   struct task_struct *child, int ctxn,
+		   struct task_struct *child,
 		   int *inherited_all)
 {
-	int ret;
 	struct perf_event_context *child_ctx;
+	int ret;
 
 	if (!event->attr.inherit) {
 		*inherited_all = 0;
 		return 0;
 	}
 
-	child_ctx = child->perf_event_ctxp[ctxn];
+	child_ctx = child->perf_event_ctxp;
 	if (!child_ctx) {
 		/*
 		 * This is executed from the parent task context, so
@@ -11421,16 +11474,14 @@ inherit_task_group(struct perf_event *ev
 		 * First allocate and initialize a context for the
 		 * child.
 		 */
-		child_ctx = alloc_perf_context(parent_ctx->pmu, child);
+		child_ctx = alloc_perf_context(child);
 		if (!child_ctx)
 			return -ENOMEM;
 
-		child->perf_event_ctxp[ctxn] = child_ctx;
+		child->perf_event_ctxp = child_ctx;
 	}
 
-	ret = inherit_group(event, parent, parent_ctx,
-			    child, child_ctx);
-
+	ret = inherit_group(event, parent, parent_ctx, child, child_ctx);
 	if (ret)
 		*inherited_all = 0;
 
@@ -11440,7 +11491,7 @@ inherit_task_group(struct perf_event *ev
 /*
  * Initialize the perf_event context in task_struct
  */
-static int perf_event_init_context(struct task_struct *child, int ctxn)
+static int perf_event_init_context(struct task_struct *child)
 {
 	struct perf_event_context *child_ctx, *parent_ctx;
 	struct perf_event_context *cloned_ctx;
@@ -11450,14 +11501,14 @@ static int perf_event_init_context(struc
 	unsigned long flags;
 	int ret = 0;
 
-	if (likely(!parent->perf_event_ctxp[ctxn]))
+	if (likely(!parent->perf_event_ctxp))
 		return 0;
 
 	/*
 	 * If the parent's context is a clone, pin it so it won't get
 	 * swapped under us.
 	 */
-	parent_ctx = perf_pin_task_context(parent, ctxn);
+	parent_ctx = perf_pin_task_context(parent);
 	if (!parent_ctx)
 		return 0;
 
@@ -11480,7 +11531,7 @@ static int perf_event_init_context(struc
 	 */
 	perf_event_groups_for_each(event, &parent_ctx->pinned_groups) {
 		ret = inherit_task_group(event, parent, parent_ctx,
-					 child, ctxn, &inherited_all);
+					 child, &inherited_all);
 		if (ret)
 			goto out_unlock;
 	}
@@ -11496,7 +11547,7 @@ static int perf_event_init_context(struc
 
 	perf_event_groups_for_each(event, &parent_ctx->flexible_groups) {
 		ret = inherit_task_group(event, parent, parent_ctx,
-					 child, ctxn, &inherited_all);
+					 child, &inherited_all);
 		if (ret)
 			goto out_unlock;
 	}
@@ -11504,7 +11555,7 @@ static int perf_event_init_context(struc
 	raw_spin_lock_irqsave(&parent_ctx->lock, flags);
 	parent_ctx->rotate_disable = 0;
 
-	child_ctx = child->perf_event_ctxp[ctxn];
+	child_ctx = child->perf_event_ctxp;
 
 	if (child_ctx && inherited_all) {
 		/*
@@ -11540,18 +11591,16 @@ static int perf_event_init_context(struc
  */
 int perf_event_init_task(struct task_struct *child)
 {
-	int ctxn, ret;
+	int ret;
 
-	memset(child->perf_event_ctxp, 0, sizeof(child->perf_event_ctxp));
+	child->perf_event_ctxp = NULL;
 	mutex_init(&child->perf_event_mutex);
 	INIT_LIST_HEAD(&child->perf_event_list);
 
-	for_each_task_context_nr(ctxn) {
-		ret = perf_event_init_context(child, ctxn);
-		if (ret) {
-			perf_event_free_task(child);
-			return ret;
-		}
+	ret = perf_event_init_context(child);
+	if (ret) {
+		perf_event_free_task(child);
+		return ret;
 	}
 
 	return 0;
@@ -11560,6 +11609,7 @@ int perf_event_init_task(struct task_str
 static void __init perf_event_init_all_cpus(void)
 {
 	struct swevent_htable *swhash;
+	struct perf_cpu_context *cpuctx;
 	int cpu;
 
 	zalloc_cpumask_var(&perf_online_mask, GFP_KERNEL);
@@ -11567,7 +11617,6 @@ static void __init perf_event_init_all_c
 	for_each_possible_cpu(cpu) {
 		swhash = &per_cpu(swevent_htable, cpu);
 		mutex_init(&swhash->hlist_mutex);
-		INIT_LIST_HEAD(&per_cpu(active_ctx_list, cpu));
 
 		INIT_LIST_HEAD(&per_cpu(pmu_sb_events.list, cpu));
 		raw_spin_lock_init(&per_cpu(pmu_sb_events.lock, cpu));
@@ -11576,6 +11625,12 @@ static void __init perf_event_init_all_c
 		INIT_LIST_HEAD(&per_cpu(cgrp_cpuctx_list, cpu));
 #endif
 		INIT_LIST_HEAD(&per_cpu(sched_cb_list, cpu));
+
+		cpuctx = per_cpu_ptr(&cpu_context, cpu);
+		__perf_event_init_context(&cpuctx->ctx);
+		lockdep_set_class(&cpuctx->ctx.mutex, &cpuctx_mutex);
+		lockdep_set_class(&cpuctx->ctx.lock, &cpuctx_lock);
+		cpuctx->online = cpumask_test_cpu(cpu, perf_online_mask);
 	}
 }
 
@@ -11597,12 +11652,12 @@ void perf_swevent_init_cpu(unsigned int
 #if defined CONFIG_HOTPLUG_CPU || defined CONFIG_KEXEC_CORE
 static void __perf_event_exit_context(void *__info)
 {
+	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
 	struct perf_event_context *ctx = __info;
-	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
 	struct perf_event *event;
 
 	raw_spin_lock(&ctx->lock);
-	ctx_sched_out(ctx, cpuctx, EVENT_TIME);
+	ctx_sched_out(ctx, EVENT_TIME);
 	list_for_each_entry(event, &ctx->event_list, event_entry)
 		__perf_remove_from_context(event, cpuctx, ctx, (void *)DETACH_GROUP);
 	raw_spin_unlock(&ctx->lock);
@@ -11612,18 +11667,16 @@ static void perf_event_exit_cpu_context(
 {
 	struct perf_cpu_context *cpuctx;
 	struct perf_event_context *ctx;
-	struct pmu *pmu;
 
+	// XXX simplify cpuctx->online
 	mutex_lock(&pmus_lock);
-	list_for_each_entry(pmu, &pmus, entry) {
-		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
-		ctx = &cpuctx->ctx;
+	cpuctx = per_cpu_ptr(&cpu_context, cpu);
+	ctx = &cpuctx->ctx;
 
-		mutex_lock(&ctx->mutex);
-		smp_call_function_single(cpu, __perf_event_exit_context, ctx, 1);
-		cpuctx->online = 0;
-		mutex_unlock(&ctx->mutex);
-	}
+	mutex_lock(&ctx->mutex);
+	smp_call_function_single(cpu, __perf_event_exit_context, ctx, 1);
+	cpuctx->online = 0;
+	mutex_unlock(&ctx->mutex);
 	cpumask_clear_cpu(cpu, perf_online_mask);
 	mutex_unlock(&pmus_lock);
 }
@@ -11637,20 +11690,17 @@ int perf_event_init_cpu(unsigned int cpu
 {
 	struct perf_cpu_context *cpuctx;
 	struct perf_event_context *ctx;
-	struct pmu *pmu;
 
 	perf_swevent_init_cpu(cpu);
 
 	mutex_lock(&pmus_lock);
 	cpumask_set_cpu(cpu, perf_online_mask);
-	list_for_each_entry(pmu, &pmus, entry) {
-		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
-		ctx = &cpuctx->ctx;
+	cpuctx = per_cpu_ptr(&cpu_context, cpu);
+	ctx = &cpuctx->ctx;
 
-		mutex_lock(&ctx->mutex);
-		cpuctx->online = 1;
-		mutex_unlock(&ctx->mutex);
-	}
+	mutex_lock(&ctx->mutex);
+	cpuctx->online = 1;
+	mutex_unlock(&ctx->mutex);
 	mutex_unlock(&pmus_lock);
 
 	return 0;
