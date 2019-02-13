Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4B0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C4A222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391396AbfBMTSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:18:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfBMTSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:18:20 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C73FF222D0;
        Wed, 13 Feb 2019 19:18:18 +0000 (UTC)
Date:   Wed, 13 Feb 2019 14:18:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v14 05/15] tracing: Add conditional snapshot
Message-ID: <20190213141817.3c5b80ea@gandalf.local.home>
In-Reply-To: <0bba382aea3ee9a94283c32319072938cb18bbc9.1549403369.git.tom.zanussi@linux.intel.com>
References: <cover.1549403369.git.tom.zanussi@linux.intel.com>
        <0bba382aea3ee9a94283c32319072938cb18bbc9.1549403369.git.tom.zanussi@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Feb 2019 16:41:51 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> +/**
> + * tracing_snapshot_cond_enable - enable conditional snapshot for an instance
> + * @tr:		The tracing instance
> + * @cond_data:	User data to associate with the snapshot
> + * @update:	Implementation of the cond_snapshot update function
> + *
> + * Check whether the conditional snapshot for the given instance has
> + * already been enabled, or if the current tracer is already using a
> + * snapshot; if so, return -EBUSY, else create a cond_snapshot and
> + * save the cond_data and update function inside.
> + *
> + * Returns 0 if successful, error otherwise.
> + */
> +int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data,
> +				 cond_update_fn_t update)
> +{
> +	struct cond_snapshot *cond_snapshot;
> +	int ret = 0;
> +
> +	cond_snapshot = kzalloc(sizeof(*cond_snapshot), GFP_KERNEL);
> +	if (!cond_snapshot)
> +		return -ENOMEM;
> +
> +	cond_snapshot->cond_data = cond_data;
> +	cond_snapshot->update = update;
> +
> +	mutex_lock(&trace_types_lock);
> +
> +	ret = tracing_alloc_snapshot_instance(tr);
> +	if (ret) {
> +		kfree(cond_snapshot);
> +		return ret;

Just returned while holding trace_types_lock.

Best to have:

	if (ret)
		goto fail_unlock;


> +	}
> +
> +	if (tr->current_trace->use_max_tr) {
> +		mutex_unlock(&trace_types_lock);
> +		kfree(cond_snapshot);
> +		return -EBUSY;
> +	}
> +
> +	arch_spin_lock(&tr->max_lock);
> +
> +	if (tr->cond_snapshot) {
> +		kfree(cond_snapshot);
> +		ret = -EBUSY;

Hmm, as the tr->cond_snapshot can only be set while holding the
trace_types_mutex (although it can be cleared without it), we can still
move this check up. Yeah, it may race with clearing (but do we care?)
but it makes the code a bit simpler.


	mutex_lock(&trace_types_lock);

	/*
	 * Because tr->cond_snapshot is only set to something other
	 * than NULL under the trace_types_lock, we can perform the
	 * busy test here. Worse case is that we return a -EBUSY just
	 * before it gets cleared. But do we really care about that?
	 */
	if (tr->cond_snapshot) {
		ret = -EBUSY;
		goto fail_unlock;
	}

	arch_spin_lock(&tr->max_lock);
	tr->cond_snapshot = cond_snapshot;
	arch_spin_unlock(&tr->max_lock);


> +	} else
> +		tr->cond_snapshot = cond_snapshot;
> +
> +	arch_spin_unlock(&tr->max_lock);
> +
> +	mutex_unlock(&trace_types_lock);
> +
> +	return ret;

fail_unlock:
	kfree(concd_snapshot);
	mutex_unlock(&trace_types_lock);
	return ret;

> +}
> +EXPORT_SYMBOL_GPL(tracing_snapshot_cond_enable);
> +
> +/**
> + * tracing_snapshot_cond_disable - disable conditional snapshot for an instance
> + * @tr:		The tracing instance
> + *
> + * Check whether the conditional snapshot for the given instance is
> + * enabled; if so, free the cond_snapshot associated with it,
> + * otherwise return -EINVAL.
> + *
> + * Returns 0 if successful, error otherwise.
> + */
> +int tracing_snapshot_cond_disable(struct trace_array *tr)
> +{
> +	int ret = 0;
> +
> +	arch_spin_lock(&tr->max_lock);
> +
> +	if (!tr->cond_snapshot)
> +		ret = -EINVAL;
> +	else {
> +		kfree(tr->cond_snapshot);
> +		tr->cond_snapshot = NULL;
> +	}
> +
> +	arch_spin_unlock(&tr->max_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(tracing_snapshot_cond_disable);
>  #else
>  void tracing_snapshot(void)
>  {
>  	WARN_ONCE(1, "Snapshot feature not enabled, but internal snapshot used");
>  }
>  EXPORT_SYMBOL_GPL(tracing_snapshot);
> +void tracing_snapshot_cond(struct trace_array *tr, void *cond_data)
> +{
> +	WARN_ONCE(1, "Snapshot feature not enabled, but internal conditional snapshot used");
> +}
> +EXPORT_SYMBOL_GPL(tracing_snapshot_cond);
>  int tracing_alloc_snapshot(void)
>  {
>  	WARN_ONCE(1, "Snapshot feature not enabled, but snapshot allocation used");
> @@ -1043,6 +1181,21 @@ void tracing_snapshot_alloc(void)
>  	tracing_snapshot();
>  }
>  EXPORT_SYMBOL_GPL(tracing_snapshot_alloc);
> +void *tracing_cond_snapshot_data(struct trace_array *tr)
> +{
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(tracing_cond_snapshot_data);
> +int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data, cond_update_fn_t update)
> +{
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(tracing_snapshot_cond_enable);
> +int tracing_snapshot_cond_disable(struct trace_array *tr)
> +{
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(tracing_snapshot_cond_disable);
>  #endif /* CONFIG_TRACER_SNAPSHOT */
>  
>  void tracer_tracing_off(struct trace_array *tr)
> @@ -1354,12 +1507,14 @@ __update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
>   * @tr: tracer
>   * @tsk: the task with the latency
>   * @cpu: The cpu that initiated the trace.
> + * @cond_data: User data associated with a conditional snapshot
>   *
>   * Flip the buffers between the @tr and the max_tr and record information
>   * about which task was the cause of this latency.
>   */
>  void
> -update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
> +update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
> +	      void *cond_data)
>  {
>  	if (tr->stop_count)
>  		return;
> @@ -1380,6 +1535,12 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu)
>  	else
>  		ring_buffer_record_off(tr->max_buffer.buffer);
>  
> +#ifdef CONFIG_TRACER_SNAPSHOT
> +	if (tr->cond_snapshot && !tr->cond_snapshot->update(tr, cond_data)) {

Let's make this just a "goto out_unlock;";

And add the out_unlock just before the arch_spin_unlock.


> +		arch_spin_unlock(&tr->max_lock);
> +		return;
> +	}
> +#endif
>  	swap(tr->trace_buffer.buffer, tr->max_buffer.buffer);
>  
>  	__update_max_tr(tr, tsk, cpu);
> @@ -5396,6 +5557,17 @@ static int tracing_set_tracer(struct trace_array *tr, const char *buf)
>  	if (t == tr->current_trace)
>  		goto out;
>  
> +#ifdef CONFIG_TRACER_SNAPSHOT
> +	if (t->use_max_tr) {
> +		arch_spin_lock(&tr->max_lock);
> +		if (tr->cond_snapshot) {
> +			ret = -EBUSY;
> +			arch_spin_unlock(&tr->max_lock);
> +			goto out;
> +		}
> +		arch_spin_unlock(&tr->max_lock);
> +	}

How about:

	if (t->use_max_tr) {
		arch_spin_lock(&tr->max_lock);
		if (tr->cond_snapshot)
			ret = -EBUSY;
		arch_spin_unlock(&tr->max_lock);
		if (ret)
			goto out;
	}


> +#endif
>  	/* Some tracers won't work on kernel command line */
>  	if (system_state < SYSTEM_RUNNING && t->noboot) {
>  		pr_warn("Tracer '%s' is not allowed on command line, ignored\n",
> @@ -6478,6 +6650,14 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
>  		goto out;
>  	}
>  
> +	arch_spin_lock(&tr->max_lock);
> +	if (tr->cond_snapshot) {
> +		ret = -EBUSY;
> +		arch_spin_unlock(&tr->max_lock);
> +		goto out;
> +	}
> +	arch_spin_unlock(&tr->max_lock);

Same here.

> +
>  	switch (val) {
>  	case 0:
>  		if (iter->cpu_file != RING_BUFFER_ALL_CPUS) {
> @@ -6503,7 +6683,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
>  		local_irq_disable();
>  		/* Now, we're going to swap */
>  		if (iter->cpu_file == RING_BUFFER_ALL_CPUS)
> -			update_max_tr(tr, current, smp_processor_id());
> +			update_max_tr(tr, current, smp_processor_id(), NULL);
>  		else
>  			update_max_tr_single(tr, current, iter->cpu_file);
>  		local_irq_enable();
> @@ -7095,7 +7275,7 @@ ftrace_snapshot(unsigned long ip, unsigned long parent_ip,
>  		struct trace_array *tr, struct ftrace_probe_ops *ops,
>  		void *data)
>  {
> -	tracing_snapshot_instance(tr);
> +	tracing_snapshot_instance(tr, NULL);
>  }
>  
>  static void
> @@ -7117,7 +7297,7 @@ ftrace_count_snapshot(unsigned long ip, unsigned long parent_ip,
>  		(*count)--;
>  	}
>  
> -	tracing_snapshot_instance(tr);
> +	tracing_snapshot_instance(tr, NULL);
>  }
>  
>  static int
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 08900828d282..23c1ed047868 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -194,6 +194,53 @@ struct trace_pid_list {
>  	unsigned long			*pids;
>  };
>  
> +typedef bool (*cond_update_fn_t)(struct trace_array *tr, void *cond_data);
> +
> +/**
> + * struct cond_snapshot - conditional snapshot data and callback
> + *
> + * The cond_snapshot structure encapsulates a callback function and
> + * data associated with the snapshot for a given tracing instance.
> + *
> + * When a snapshot is taken conditionally, by invoking
> + * tracing_snapshot_cond(tr, cond_data), the cond_data passed in is
> + * passed in turn to the cond_snapshot.update() function.  That data
> + * can be compared by the update() implementation with the cond_data
> + * contained wihin the struct cond_snapshot instance associated with
> + * the trace_array.  Because the tr->max_lock is held throughout the
> + * update() call, the update() function can directly retrieve the
> + * cond_snapshot and cond_data associated with the per-instance
> + * snapshot associated with the trace_array.
> + *
> + * The cond_snapshot.update() implementation can save data to be
> + * associated with the snapshot if it decides to, and returns 'true'
> + * in that case, or it returns 'false' if the conditional snapshot
> + * shouldn't be taken.
> + *
> + * The cond_snapshot instance is created and associated with the
> + * user-defined cond_data by tracing_cond_snapshot_enable().
> + * Likewise, the cond_snapshot instance is destroyed and is no longer
> + * associated with the trace instance by
> + * tracing_cond_snapshot_disable().
> + *
> + * The method below is required.
> + *
> + * @update: When a conditional snapshot is invoked, the update()
> + *	callback function is invoked with the tr->max_lock held.  The
> + *	update() implementation signals whether or not to actually
> + *	take the snapshot, by returning 'true' if so, 'false' if no
> + *	snapshot should be taken.  Because the max_lock is held for
> + *	the duration of update(), the implementation is safe to
> + *	directly retrieven and save any implementation data it needs
> + *	to in association with the snapshot.
> + */
> +#ifdef CONFIG_TRACER_SNAPSHOT
> +struct cond_snapshot {
> +	void				*cond_data;
> +	cond_update_fn_t		update;
> +};
> +#endif

This is just defining a structure, not data or text. No need for the
#ifdef.

> +
>  /*
>   * The trace array - an array of per-CPU trace arrays. This is the
>   * highest level data structure that individual tracers deal with.
> @@ -277,6 +324,9 @@ struct trace_array {
>  #endif
>  	int			time_stamp_abs_ref;
>  	struct list_head	hist_vars;
> +#ifdef CONFIG_TRACER_SNAPSHOT
> +	struct cond_snapshot	*cond_snapshot;
> +#endif
>  };
>  
>  enum {
> @@ -727,7 +777,8 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
>  		    const char __user *ubuf, size_t cnt);
>  
>  #ifdef CONFIG_TRACER_MAX_TRACE
> -void update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu);
> +void update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
> +		   void *cond_data);
>  void update_max_tr_single(struct trace_array *tr,
>  			  struct task_struct *tsk, int cpu);
>  #endif /* CONFIG_TRACER_MAX_TRACE */
> @@ -1808,6 +1859,11 @@ static inline bool event_command_needs_rec(struct event_command *cmd_ops)
>  extern int trace_event_enable_disable(struct trace_event_file *file,
>  				      int enable, int soft_disable);
>  extern int tracing_alloc_snapshot(void);
> +extern void tracing_snapshot_cond(struct trace_array *tr, void *cond_data);
> +extern int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data, cond_update_fn_t update);
> +
> +extern int tracing_snapshot_cond_disable(struct trace_array *tr);
> +extern void *tracing_cond_snapshot_data(struct trace_array *tr);
>  
>  extern const char *__start___trace_bprintk_fmt[];
>  extern const char *__stop___trace_bprintk_fmt[];
> @@ -1881,7 +1937,7 @@ static inline void trace_event_eval_update(struct trace_eval_map **map, int len)
>  #endif
>  
>  #ifdef CONFIG_TRACER_SNAPSHOT
> -void tracing_snapshot_instance(struct trace_array *tr);
> +void tracing_snapshot_instance(struct trace_array *tr, void *cond_data);
>  int tracing_alloc_snapshot_instance(struct trace_array *tr);
>  #else
>  static inline void tracing_snapshot_instance(struct trace_array *tr) { }
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index 2152d1e530cb..a77102a17046 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -1049,7 +1049,7 @@ snapshot_trigger(struct event_trigger_data *data, void *rec,
>  	struct trace_event_file *file = data->private_data;
>  
>  	if (file)
> -		tracing_snapshot_instance(file->tr);
> +		tracing_snapshot_instance(file->tr, NULL);

Hmm, with all theses added NULLs, I wounder if it wouldn't just be
better to make another function

void tracing_snapshot_instance_cond(struct trace_array *tr, void *cond_var);

void tracing_snapshot_instance(struct trace_array *tr)
{
	tracing_snapshot_instance_cond(tr, NULL);
}

Then it wont be so intrusive, as there's more calls with NULL than
something added.

-- Steve


>  	else
>  		tracing_snapshot();
>  }
> diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
> index 4ea7e6845efb..007c074fe6d6 100644
> --- a/kernel/trace/trace_sched_wakeup.c
> +++ b/kernel/trace/trace_sched_wakeup.c
> @@ -482,7 +482,7 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
>  
>  	if (likely(!is_tracing_stopped())) {
>  		wakeup_trace->max_latency = delta;
> -		update_max_tr(wakeup_trace, wakeup_task, wakeup_cpu);
> +		update_max_tr(wakeup_trace, wakeup_task, wakeup_cpu, NULL);
>  	}
>  
>  out_unlock:

