Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeCCNjx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 08:39:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751847AbeCCNjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 08:39:52 -0500
Date: Sat, 3 Mar 2018 14:39:50 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Song Liu <songliubraving@fb.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, kernel-team@fb.com
Subject: Re: [RFC] perf: a different approach to perf_rotate_context()
Message-ID: <20180303133950.GA2704@krava>
References: <20180301195321.2608515-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301195321.2608515-1-songliubraving@fb.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 11:53:21AM -0800, Song Liu wrote:
> When there are more perf_event's than hardware PMCs, perf rotate events
> so that all events get chance to run. Currently, the rotation works as:
>   sched_out flexible_groups in cpuctx->ctx and cpuctx->task_ctx;
>   rotate_left flexible_groups in cpuctx->ctx and cpuctx->task_ctx;
>   try sched_in flexible_groups in cpuctx->ctx;
>   try sched_in flexible_groups in cpuctx->task_ctx.
> 
> This approach has some potential issues:
>   1. if different rotations of flexible_groups in cpuctx->ctx occupy
>      all hardware PMC, flexible_groups in cpuctx->task_ctx cannot run
>      at all.
>   2. if pinned_groups occupy all hardware PMC, the rotation triggers per
>      perf_event_mux_interval_ms. But it couldn't schedule any events.
>   3. since flexible_groups in cpuctx->ctx and cpuctx->task_ctx are
>      rotated separately, there are N x M possible combinations. It is
>      difficult to remember all the rotation combinations and reuse these
>      combinations. As a result, it is necessary to try sched_in the
>      flexible_groups on each rotation.
> 
> This patch tries to do the rotation differently. Each perf_event in the
> cpuctx (ctx and task_ctx) is assigned a rotation_id. The rotation_id's
> are assigned during the first few rotations after any changes in
> perf_events attached to the cpuctx. Once all the rotation_id's are
> assigned for all events in the cpuctx, perf_rotate_context() simply
> picks the next rotation to use, so there is no more "try to sched_in"
> for future rotations.
> 
> Special rotation_id's are introduced to handle the issues above.
> flexible_groups that conflicts with pinned_groups are marked as
> ALWAYS_OFF, so they are not rotated (fixes issue 2). flexible_groups
> in cpuctx->ctx and cpuctx->task_ctx are rotated together, so they all get
> equal chance to run (improves issue 1).

hum, so the improvement is that cpuctx could eventually give
up some space for task_ctx events, but both ctxs still rotate
separately no? you keep rotation ID per single context..

> 
> With this approach, we only do complex scheduling of flexible_groups
> once. This enables us to do more complex schduling, for example, Sharing
> PMU counters across compatible events:
>    https://lkml.org/lkml/2017/12/1/410.

how could this code do that?

> 
> There are also some potential downsides of this approach.
> 
> First, it gives all flexible_groups exactly same chance to run, so it
> may waste some PMC cycles. For examples, if 5 groups, ABCDE, are assigned
> to two rotations: rotation-0: ABCD and rotation-1: E, this approach will
> NOT try any of ABCD in rotation-1.
> 
> Second, flexible_groups in cpuctx->ctx and cpuctx->task_ctx now have
> exact same priority and equal chance to run. I am not sure whether this
> will change the behavior in some use cases.
> 
> Please kindly let me know whether this approach makes sense.

SNIP

> +/*
> + * identify always_on and always_off groups in flexible_groups, call
> + * group_sched_in() for always_on groups
> + */
> +static void ctx_pick_always_on_off_groups(struct perf_event_context *ctx,
> +					  struct perf_cpu_context *cpuctx)
> +{
> +	struct perf_event *event;
> +
> +	list_for_each_entry(event, &ctx->flexible_groups, group_entry) {
> +		if (event->group_caps & PERF_EV_CAP_SOFTWARE) {
> +			event->rotation_id = PERF_ROTATION_ID_ALWAYS_ON;
> +			ctx->nr_sched++;
> +			WARN_ON(group_sched_in(event, cpuctx, ctx));
> +			continue;
> +		}
> +		if (group_sched_in(event, cpuctx, ctx)) {
> +			event->rotation_id = PERF_ROTATION_ID_ALWAYS_OFF;
> +			ctx->nr_sched++;

should ctx->nr_sched be incremented in the 'else' leg?

> +		}
> +		group_sched_out(event, cpuctx, ctx);
> +	}
> +}
> +
> +/* add unassigned flexible_groups to new rotation_id */
> +static void ctx_add_rotation(struct perf_event_context *ctx,
> +			     struct perf_cpu_context *cpuctx)
>  {
>  	struct perf_event *event;
> +	int group_added = 0;
>  	int can_add_hw = 1;
>  
> +	ctx->curr_rotation = ctx->num_rotations;
> +	ctx->num_rotations++;
> +
>  	list_for_each_entry(event, &ctx->flexible_groups, group_entry) {
>  		/* Ignore events in OFF or ERROR state */
>  		if (event->state <= PERF_EVENT_STATE_OFF)
> @@ -3034,13 +3099,77 @@ ctx_flexible_sched_in(struct perf_event_context *ctx,
>  		if (!event_filter_match(event))
>  			continue;
>  
> +		if (event->rotation_id != PERF_ROTATION_ID_NOT_ASSGINED)
> +			continue;
> +
>  		if (group_can_go_on(event, cpuctx, can_add_hw)) {
>  			if (group_sched_in(event, cpuctx, ctx))
>  				can_add_hw = 0;
> +			else {
> +				event->rotation_id = ctx->curr_rotation;
> +				ctx->nr_sched++;
> +				group_added++;

group_added is not used

SNIP

>  static int perf_rotate_context(struct perf_cpu_context *cpuctx)
>  {
> -	struct perf_event_context *ctx = NULL;
> +	struct perf_event_context *ctx = cpuctx->task_ctx;
>  	int rotate = 0;
> +	u64 now;
>  
> -	if (cpuctx->ctx.nr_events) {
> -		if (cpuctx->ctx.nr_events != cpuctx->ctx.nr_active)
> -			rotate = 1;
> -	}
> -
> -	ctx = cpuctx->task_ctx;
> -	if (ctx && ctx->nr_events) {
> -		if (ctx->nr_events != ctx->nr_active)
> -			rotate = 1;
> -	}
> +	if (!flexible_sched_done(cpuctx) ||
> +	    cpuctx->ctx.num_rotations > 1)
> +		rotate = 1;
>  
>  	if (!rotate)
>  		goto done;
> @@ -3382,15 +3492,35 @@ static int perf_rotate_context(struct perf_cpu_context *cpuctx)
>  	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>  	perf_pmu_disable(cpuctx->ctx.pmu);
>  
> -	cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
> +	update_context_time(&cpuctx->ctx);
>  	if (ctx)
> -		ctx_sched_out(ctx, cpuctx, EVENT_FLEXIBLE);
> +		update_context_time(ctx);
> +	update_cgrp_time_from_cpuctx(cpuctx);
>  
> -	rotate_ctx(&cpuctx->ctx);
> +	ctx_switch_rotation_out(&cpuctx->ctx, cpuctx);
>  	if (ctx)
> -		rotate_ctx(ctx);
> +		ctx_switch_rotation_out(ctx, cpuctx);
>  
> -	perf_event_sched_in(cpuctx, ctx, current);
> +	if (flexible_sched_done(cpuctx)) {
> +		/* simply repeat previous calculated rotations */
> +		ctx_switch_rotation_in(&cpuctx->ctx, cpuctx);
> +		if (ctx)
> +			ctx_switch_rotation_in(ctx, cpuctx);
> +	} else {
> +		/* create new rotation */
> +		ctx_add_rotation(&cpuctx->ctx, cpuctx);
> +		if (ctx)
> +			ctx_add_rotation(ctx, cpuctx);
> +	}

that seems messy.. could this be done just by setting
the rotation ID and let perf_event_sched_in skip over
different IDs and sched-in/set un-assigned events?

jirka
