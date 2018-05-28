Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423734AbeE1Mji (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:39:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46786 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164053AbeE1Mjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:39:31 -0400
Date: Mon, 28 May 2018 13:33:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Song Liu <songliubraving@fb.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org,
        jolsa@kernel.org
Subject: Re: [RFC 2/2] perf: Sharing PMU counters across compatible events
Message-ID: <20180528113319.GD3452@worktop.programming.kicks-ass.net>
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
> +static void add_event_to_dup_event_list(struct perf_event *event,
> +					struct perf_cpu_context *cpuctx)
> +{
> +	int i;
> +
> +	for (i = 0; i < cpuctx->dup_event_count; ++i)
> +		if (memcmp(&event->attr,
> +			   &cpuctx->dup_event_list[i].first->attr,
> +			   sizeof(event->attr)) == 0) {
> +			event->dup_id = i;
> +			return;
> +		}
> +	i = cpuctx->dup_event_count++;
> +	cpuctx->dup_event_list[i].first = event;
> +	cpuctx->dup_event_list[i].master = NULL;
> +	INIT_LIST_HEAD(&cpuctx->dup_event_list[i].active_dup);
> +	event->dup_id = i;
> +	INIT_LIST_HEAD(&event->dup_sibling_entry);
> +}
> +
> +static int add_group_to_dup_event_list(struct perf_event *event, void *data)
> +{
> +	struct sched_in_data *sid = data;
> +	struct perf_event *sibling;
> +
> +	add_event_to_dup_event_list(event, sid->cpuctx);
> +	for_each_sibling_event(sibling, event)
> +		add_event_to_dup_event_list(sibling, sid->cpuctx);
> +
> +	return 0;
> +}
> +
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
> +	if (!cpuctx->dup_event_list)
> +		return;
> +
> +	visit_groups_merge(&cpuctx->ctx.pinned_groups, smp_processor_id(),
> +			   add_group_to_dup_event_list, &sid);
> +	visit_groups_merge(&cpuctx->ctx.flexible_groups, smp_processor_id(),
> +			   add_group_to_dup_event_list, &sid);
> +	if (ctx) {
> +		visit_groups_merge(&ctx->pinned_groups, smp_processor_id(),
> +				   add_group_to_dup_event_list, &sid);
> +		visit_groups_merge(&ctx->flexible_groups, smp_processor_id(),
> +				   add_group_to_dup_event_list, &sid);
> +	}
> +}

Oooh, wait a second, this isn't O(n), this looks like O(n^2).

We do that linear search for every single event... that's not good.
