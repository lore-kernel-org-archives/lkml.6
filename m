Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F35C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEFB20700
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550101458;
	bh=SzD+FhFbow7k4QNv/PQ5b/ETthtqH2Mga7mrKaL+PM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=ot+oqaW0qTj/3m/HWF6TEhUM/4FxWxgFpxsz1lF3dlWUT7Xjo4hKQveexVItxBQqU
	 CMvx8FBgpDsrCZ/F9ud0x+qubWTE5NHb3xfHcS8sv/XZxc8M3Ebh3490avLF9EpDmQ
	 RTOaszi26XIhnNvwVvCKiXxqYK7MM9X0VQNRuuv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403868AbfBMXoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:44:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393068AbfBMXnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:43:12 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DC58222D0;
        Wed, 13 Feb 2019 23:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550101391;
        bh=SzD+FhFbow7k4QNv/PQ5b/ETthtqH2Mga7mrKaL+PM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=b81F9UKw/sFsSzWY/pjZPDIx89Q2WoBUxdvdbkL8dp0V37w9PWQ7+0ypwFPByaa3H
         bkpmT2RtVK5mQ4Z8ojoymFJkq/AeDzxIkkVN5Aj4d7oHsTp2zFrWvnKf+8tCeHSmBC
         Cu/6Oyki0WvvX9AeGZIdneGcktcw3gChRZXPFtec=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v15 05/15] tracing: Add conditional snapshot
Date:   Wed, 13 Feb 2019 17:42:45 -0600
Message-Id: <1bea07828d5fd6864a585f83b1eed47ce097eb45.1550100284.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1550100284.git.tom.zanussi@linux.intel.com>
References: <cover.1550100284.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1550100284.git.tom.zanussi@linux.intel.com>
References: <cover.1550100284.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Currently, tracing snapshots are context-free - they capture the ring
buffer contents at the time the tracing_snapshot() function was
invoked, and nothing else.  Additionally, they're always taken
unconditionally - the calling code can decide whether or not to take a
snapshot, but the data used to make that decision is kept separately
from the snapshot itself.

This change adds the ability to associate with each trace instance
some user data, along with an 'update' function that can use that data
to determine whether or not to actually take a snapshot.  The update
function can then update that data along with any other state (as part
of the data presumably), if warranted.

Because snapshots are 'global' per-instance, only one user can enable
and use a conditional snapshot for any given trace instance.  To
enable a conditional snapshot (see details in the function and data
structure comments), the user calls tracing_snapshot_cond_enable().
Similarly, to disable a conditional snapshot and free it up for other
users, tracing_snapshot_cond_disable() should be called.

To actually initiate a conditional snapshot, tracing_snapshot_cond()
should be called.  tracing_snapshot_cond() will invoke the update()
callback, allowing the user to decide whether or not to actually take
the snapshot and update the user-defined data associated with the
snapshot.  If the callback returns 'true', tracing_snapshot_cond()
will then actually take the snapshot and return.

This scheme allows for flexibility in snapshot implementations - for
example, by implementing slightly different update() callbacks,
snapshots can be taken in situations where the user is only interested
in taking a snapshot when a new maximum in hit versus when a value
changes in any way at all.  Future patches will demonstrate both
cases.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace.c              | 192 +++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h              |  56 ++++++++++-
 kernel/trace/trace_sched_wakeup.c |   2 +-
 3 files changed, 244 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 188c4e06c1cc..b5cabc71b62a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -894,7 +894,7 @@ int __trace_bputs(unsigned long ip, const char *str)
 EXPORT_SYMBOL_GPL(__trace_bputs);
 
 #ifdef CONFIG_TRACER_SNAPSHOT
-void tracing_snapshot_instance(struct trace_array *tr)
+void tracing_snapshot_instance_cond(struct trace_array *tr, void *cond_data)
 {
 	struct tracer *tracer = tr->current_trace;
 	unsigned long flags;
@@ -920,10 +920,15 @@ void tracing_snapshot_instance(struct trace_array *tr)
 	}
 
 	local_irq_save(flags);
-	update_max_tr(tr, current, smp_processor_id());
+	update_max_tr(tr, current, smp_processor_id(), cond_data);
 	local_irq_restore(flags);
 }
 
+void tracing_snapshot_instance(struct trace_array *tr)
+{
+	tracing_snapshot_instance_cond(tr, NULL);
+}
+
 /**
  * tracing_snapshot - take a snapshot of the current buffer.
  *
@@ -946,6 +951,54 @@ void tracing_snapshot(void)
 }
 EXPORT_SYMBOL_GPL(tracing_snapshot);
 
+/**
+ * tracing_snapshot_cond - conditionally take a snapshot of the current buffer.
+ * @tr:		The tracing instance to snapshot
+ * @cond_data:	The data to be tested conditionally, and possibly saved
+ *
+ * This is the same as tracing_snapshot() except that the snapshot is
+ * conditional - the snapshot will only happen if the
+ * cond_snapshot.update() implementation receiving the cond_data
+ * returns true, which means that the trace array's cond_snapshot
+ * update() operation used the cond_data to determine whether the
+ * snapshot should be taken, and if it was, presumably saved it along
+ * with the snapshot.
+ */
+void tracing_snapshot_cond(struct trace_array *tr, void *cond_data)
+{
+	tracing_snapshot_instance_cond(tr, cond_data);
+}
+EXPORT_SYMBOL_GPL(tracing_snapshot_cond);
+
+/**
+ * tracing_snapshot_cond_data - get the user data associated with a snapshot
+ * @tr:		The tracing instance
+ *
+ * When the user enables a conditional snapshot using
+ * tracing_snapshot_cond_enable(), the user-defined cond_data is saved
+ * with the snapshot.  This accessor is used to retrieve it.
+ *
+ * Should not be called from cond_snapshot.update(), since it takes
+ * the tr->max_lock lock, which the code calling
+ * cond_snapshot.update() has already done.
+ *
+ * Returns the cond_data associated with the trace array's snapshot.
+ */
+void *tracing_cond_snapshot_data(struct trace_array *tr)
+{
+	void *cond_data = NULL;
+
+	arch_spin_lock(&tr->max_lock);
+
+	if (tr->cond_snapshot)
+		cond_data = tr->cond_snapshot->cond_data;
+
+	arch_spin_unlock(&tr->max_lock);
+
+	return cond_data;
+}
+EXPORT_SYMBOL_GPL(tracing_cond_snapshot_data);
+
 static int resize_buffer_duplicate_size(struct trace_buffer *trace_buf,
 					struct trace_buffer *size_buf, int cpu_id);
 static void set_buffer_entries(struct trace_buffer *buf, unsigned long val);
@@ -1025,12 +1078,103 @@ void tracing_snapshot_alloc(void)
 	tracing_snapshot();
 }
 EXPORT_SYMBOL_GPL(tracing_snapshot_alloc);
+
+/**
+ * tracing_snapshot_cond_enable - enable conditional snapshot for an instance
+ * @tr:		The tracing instance
+ * @cond_data:	User data to associate with the snapshot
+ * @update:	Implementation of the cond_snapshot update function
+ *
+ * Check whether the conditional snapshot for the given instance has
+ * already been enabled, or if the current tracer is already using a
+ * snapshot; if so, return -EBUSY, else create a cond_snapshot and
+ * save the cond_data and update function inside.
+ *
+ * Returns 0 if successful, error otherwise.
+ */
+int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data,
+				 cond_update_fn_t update)
+{
+	struct cond_snapshot *cond_snapshot;
+	int ret = 0;
+
+	cond_snapshot = kzalloc(sizeof(*cond_snapshot), GFP_KERNEL);
+	if (!cond_snapshot)
+		return -ENOMEM;
+
+	cond_snapshot->cond_data = cond_data;
+	cond_snapshot->update = update;
+
+	mutex_lock(&trace_types_lock);
+
+	ret = tracing_alloc_snapshot_instance(tr);
+	if (ret)
+		goto fail_unlock;
+
+	if (tr->current_trace->use_max_tr) {
+		ret = -EBUSY;
+		goto fail_unlock;
+	}
+
+	if (tr->cond_snapshot) {
+		ret = -EBUSY;
+		goto fail_unlock;
+	}
+
+	arch_spin_lock(&tr->max_lock);
+	tr->cond_snapshot = cond_snapshot;
+	arch_spin_unlock(&tr->max_lock);
+
+	mutex_unlock(&trace_types_lock);
+
+	return ret;
+
+ fail_unlock:
+        mutex_unlock(&trace_types_lock);
+        kfree(cond_snapshot);
+        return ret;
+}
+EXPORT_SYMBOL_GPL(tracing_snapshot_cond_enable);
+
+/**
+ * tracing_snapshot_cond_disable - disable conditional snapshot for an instance
+ * @tr:		The tracing instance
+ *
+ * Check whether the conditional snapshot for the given instance is
+ * enabled; if so, free the cond_snapshot associated with it,
+ * otherwise return -EINVAL.
+ *
+ * Returns 0 if successful, error otherwise.
+ */
+int tracing_snapshot_cond_disable(struct trace_array *tr)
+{
+	int ret = 0;
+
+	arch_spin_lock(&tr->max_lock);
+
+	if (!tr->cond_snapshot)
+		ret = -EINVAL;
+	else {
+		kfree(tr->cond_snapshot);
+		tr->cond_snapshot = NULL;
+	}
+
+	arch_spin_unlock(&tr->max_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tracing_snapshot_cond_disable);
 #else
 void tracing_snapshot(void)
 {
 	WARN_ONCE(1, "Snapshot feature not enabled, but internal snapshot used");
 }
 EXPORT_SYMBOL_GPL(tracing_snapshot);
+void tracing_snapshot_cond(struct trace_array *tr, void *cond_data)
+{
+	WARN_ONCE(1, "Snapshot feature not enabled, but internal conditional snapshot used");
+}
+EXPORT_SYMBOL_GPL(tracing_snapshot_cond);
 int tracing_alloc_snapshot(void)
 {
 	WARN_ONCE(1, "Snapshot feature not enabled, but snapshot allocation used");
@@ -1043,6 +1187,21 @@ void tracing_snapshot_alloc(void)
 	tracing_snapshot();
 }
 EXPORT_SYMBOL_GPL(tracing_snapshot_alloc);
+void *tracing_cond_snapshot_data(struct trace_array *tr)
+{
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(tracing_cond_snapshot_data);
+int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data, cond_update_fn_t update)
+{
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(tracing_snapshot_cond_enable);
+int tracing_snapshot_cond_disable(struct trace_array *tr)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(tracing_snapshot_cond_disable);
 #endif /* CONFIG_TRACER_SNAPSHOT */
 
 void tracer_tracing_off(struct trace_array *tr)
@@ -1354,12 +1513,14 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
  * @tr: tracer
  * @tsk: the task with the latency
  * @cpu: The cpu that initiated the trace.
+ * @cond_data: User data associated with a conditional snapshot
  *
  * Flip the buffers between the @tr and the max_tr and record information
  * about which task was the cause of this latency.
  */
 void
-update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
+update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
+	      void *cond_data)
 {
 	if (tr->stop_count)
 		return;
@@ -1380,9 +1541,15 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
 	else
 		ring_buffer_record_off(tr->max_buffer.buffer);
 
+#ifdef CONFIG_TRACER_SNAPSHOT
+	if (tr->cond_snapshot && !tr->cond_snapshot->update(tr, cond_data))
+		goto out_unlock;
+#endif
 	swap(tr->trace_buffer.buffer, tr->max_buffer.buffer);
 
 	__update_max_tr(tr, tsk, cpu);
+
+ out_unlock:
 	arch_spin_unlock(&tr->max_lock);
 }
 
@@ -5396,6 +5563,16 @@ static int tracing_set_tracer(struct trace_array *tr, const char *buf)
 	if (t == tr->current_trace)
 		goto out;
 
+#ifdef CONFIG_TRACER_SNAPSHOT
+	if (t->use_max_tr) {
+		arch_spin_lock(&tr->max_lock);
+		if (tr->cond_snapshot)
+			ret = -EBUSY;
+		arch_spin_unlock(&tr->max_lock);
+		if (ret)
+			goto out;
+	}
+#endif
 	/* Some tracers won't work on kernel command line */
 	if (system_state < SYSTEM_RUNNING && t->noboot) {
 		pr_warn("Tracer '%s' is not allowed on command line, ignored\n",
@@ -6478,6 +6655,13 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		goto out;
 	}
 
+	arch_spin_lock(&tr->max_lock);
+	if (tr->cond_snapshot)
+		ret = -EBUSY;
+	arch_spin_unlock(&tr->max_lock);
+	if (ret)
+		goto out;
+
 	switch (val) {
 	case 0:
 		if (iter->cpu_file != RING_BUFFER_ALL_CPUS) {
@@ -6503,7 +6687,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		local_irq_disable();
 		/* Now, we're going to swap */
 		if (iter->cpu_file == RING_BUFFER_ALL_CPUS)
-			update_max_tr(tr, current, smp_processor_id());
+			update_max_tr(tr, current, smp_processor_id(), NULL);
 		else
 			update_max_tr_single(tr, current, iter->cpu_file);
 		local_irq_enable();
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 08900828d282..5585a7bf22d1 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -194,6 +194,51 @@ struct trace_pid_list {
 	unsigned long			*pids;
 };
 
+typedef bool (*cond_update_fn_t)(struct trace_array *tr, void *cond_data);
+
+/**
+ * struct cond_snapshot - conditional snapshot data and callback
+ *
+ * The cond_snapshot structure encapsulates a callback function and
+ * data associated with the snapshot for a given tracing instance.
+ *
+ * When a snapshot is taken conditionally, by invoking
+ * tracing_snapshot_cond(tr, cond_data), the cond_data passed in is
+ * passed in turn to the cond_snapshot.update() function.  That data
+ * can be compared by the update() implementation with the cond_data
+ * contained wihin the struct cond_snapshot instance associated with
+ * the trace_array.  Because the tr->max_lock is held throughout the
+ * update() call, the update() function can directly retrieve the
+ * cond_snapshot and cond_data associated with the per-instance
+ * snapshot associated with the trace_array.
+ *
+ * The cond_snapshot.update() implementation can save data to be
+ * associated with the snapshot if it decides to, and returns 'true'
+ * in that case, or it returns 'false' if the conditional snapshot
+ * shouldn't be taken.
+ *
+ * The cond_snapshot instance is created and associated with the
+ * user-defined cond_data by tracing_cond_snapshot_enable().
+ * Likewise, the cond_snapshot instance is destroyed and is no longer
+ * associated with the trace instance by
+ * tracing_cond_snapshot_disable().
+ *
+ * The method below is required.
+ *
+ * @update: When a conditional snapshot is invoked, the update()
+ *	callback function is invoked with the tr->max_lock held.  The
+ *	update() implementation signals whether or not to actually
+ *	take the snapshot, by returning 'true' if so, 'false' if no
+ *	snapshot should be taken.  Because the max_lock is held for
+ *	the duration of update(), the implementation is safe to
+ *	directly retrieven and save any implementation data it needs
+ *	to in association with the snapshot.
+ */
+struct cond_snapshot {
+	void				*cond_data;
+	cond_update_fn_t		update;
+};
+
 /*
  * The trace array - an array of per-CPU trace arrays. This is the
  * highest level data structure that individual tracers deal with.
@@ -277,6 +322,9 @@ struct trace_array {
 #endif
 	int			time_stamp_abs_ref;
 	struct list_head	hist_vars;
+#ifdef CONFIG_TRACER_SNAPSHOT
+	struct cond_snapshot	*cond_snapshot;
+#endif
 };
 
 enum {
@@ -727,7 +775,8 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 		    const char __user *ubuf, size_t cnt);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-void update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu);
+void update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
+		   void *cond_data);
 void update_max_tr_single(struct trace_array *tr,
 			  struct task_struct *tsk, int cpu);
 #endif /* CONFIG_TRACER_MAX_TRACE */
@@ -1808,6 +1857,11 @@ static inline bool event_command_needs_rec(struct event_command *cmd_ops)
 extern int trace_event_enable_disable(struct trace_event_file *file,
 				      int enable, int soft_disable);
 extern int tracing_alloc_snapshot(void);
+extern void tracing_snapshot_cond(struct trace_array *tr, void *cond_data);
+extern int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data, cond_update_fn_t update);
+
+extern int tracing_snapshot_cond_disable(struct trace_array *tr);
+extern void *tracing_cond_snapshot_data(struct trace_array *tr);
 
 extern const char *__start___trace_bprintk_fmt[];
 extern const char *__stop___trace_bprintk_fmt[];
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 4ea7e6845efb..007c074fe6d6 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -482,7 +482,7 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
 
 	if (likely(!is_tracing_stopped())) {
 		wakeup_trace->max_latency = delta;
-		update_max_tr(wakeup_trace, wakeup_task, wakeup_cpu);
+		update_max_tr(wakeup_trace, wakeup_task, wakeup_cpu, NULL);
 	}
 
 out_unlock:
-- 
2.14.1

