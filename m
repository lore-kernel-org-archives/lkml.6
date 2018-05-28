Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164899AbeE1Mka (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:40:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46788 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163875AbeE1Mjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:39:31 -0400
Date: Mon, 28 May 2018 13:15:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Song Liu <songliubraving@fb.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org,
        jolsa@kernel.org
Subject: Re: [RFC 2/2] perf: Sharing PMU counters across compatible events
Message-ID: <20180528111549.GA3452@worktop.programming.kicks-ass.net>
References: <20180504231102.2850679-1-songliubraving@fb.com>
 <20180504231102.2850679-3-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504231102.2850679-3-songliubraving@fb.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 04:11:02PM -0700, Song Liu wrote:
> Connection among perf_event and perf_event_dup are built with function
> rebuild_event_dup_list(cpuctx). This function is only called when events
> are added/removed or when a task is scheduled in/out. So it is not on
> critical path of perf_rotate_context().

Why is perf_rotate_context() the only critical path? I would say the
context switch path is rather critical too.

> @@ -2919,8 +3014,10 @@ static void ctx_sched_out(struct perf_event_context *ctx,
>  
>  	if (ctx->task) {
>  		WARN_ON_ONCE(cpuctx->task_ctx != ctx);
> -		if (!ctx->is_active)
> +		if (!ctx->is_active) {
>  			cpuctx->task_ctx = NULL;
> +			rebuild_event_dup_list(cpuctx);
> +		}
>  	}
>  
>  	/*

> +static void rebuild_event_dup_list(struct perf_cpu_context *cpuctx)
> +{
> +	int dup_count = cpuctx->ctx.nr_events;
> +	struct perf_event_context *ctx = cpuctx->task_ctx;
> +	struct sched_in_data sid = {
> +		.ctx = ctx,
> +		.cpuctx = cpuctx,
> +		.can_add_hw = 1,
> +	};
> +
> +	if (ctx)
> +		dup_count += ctx->nr_events;
> +
> +	kfree(cpuctx->dup_event_list);
> +	cpuctx->dup_event_count = 0;
> +
> +	cpuctx->dup_event_list =
> +		kzalloc(sizeof(struct perf_event_dup) * dup_count, GFP_ATOMIC);


__schedule()
  local_irq_disable()
  raw_spin_lock(rq->lock)
  context_switch()
    prepare_task_switch()
      perf_event_task_sched_out()
        __perf_event_task_sched_out()
	  perf_event_context_sched_out()
	    task_ctx_sched_out()
	      ctx_sched_out()
	        rebuild_event_dup_list()
		  kzalloc()
		    ...
		      spin_lock()

Also, as per the above, this nests a regular spin lock inside the
(raw) rq->lock, which is a no-no.

Not to mention that whole O(n) crud in the scheduling path...
