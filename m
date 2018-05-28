Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164965AbeE1Mke (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:40:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46790 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164207AbeE1Mjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:39:31 -0400
Date: Mon, 28 May 2018 13:26:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Song Liu <songliubraving@fb.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org,
        jolsa@kernel.org
Subject: Re: [RFC 2/2] perf: Sharing PMU counters across compatible events
Message-ID: <20180528112618.GC3452@worktop.programming.kicks-ass.net>
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
> +/*
> + * If an dup event is already active, add this event as follower, and
> + * return 0; otherwise, return -EAGAIN
> + *
> + * RFC NOTE: this an o(1) operation
> + */
> +static int event_dup_try_add_follower(struct perf_event *event,
> +				      struct perf_cpu_context *cpuctx)
> +{
> +	struct perf_event_dup *pdup;
> +
> +	if (event->dup_id >= cpuctx->dup_event_count)
> +		return -EAGAIN;
> +
> +	pdup = &cpuctx->dup_event_list[event->dup_id];
> +	if (list_empty(&pdup->active_dup))
> +		return -EAGAIN;
> +
> +	list_add_tail(&event->dup_sibling_entry, &pdup->active_dup);
> +	pdup->master->pmu->read(pdup->master);
> +	event->dup_base_count = pdup_read_count(pdup);
> +	event->dup_base_child_count = pdup_read_child_count(pdup);
> +	return 0;
> +}

> +/*
> + * remove event from the dup list; if it is the master, and there are
> + * other active events, promote another event as the new master.
> + *
> + * return 0, if it is there are more active events in this dup;
> + * return -EAGAIN, if it is the last active event
> + *
> + * RFC NOTE: this an o(1) operation
> + */
> +static int event_dup_sched_out(struct perf_event *event,
> +			       struct perf_cpu_context *cpuctx)
> +{
> +	struct perf_event_dup *pdup;
> +
> +	if (event->dup_id >= cpuctx->dup_event_count)
> +		return -EAGAIN;
> +
> +	pdup = &cpuctx->dup_event_list[event->dup_id];
> +	list_del_init(&event->dup_sibling_entry);
> +	if (event == pdup->master ) {
> +		if (list_empty(&pdup->active_dup)) {
> +			pdup->master = NULL;
> +			return -EAGAIN;

This one is really odd.. -EAGAIN doesn't make sense for the last event.
I see how you got here, but yuck.

> +		} else {
> +			struct perf_event *new_master;
> +
> +			new_master = list_first_entry(
> +				&cpuctx->dup_event_list[event->dup_id].active_dup,
> +				struct perf_event, dup_sibling_entry);
> +			event_dup_sync(new_master, cpuctx);
> +			pdup_switch_master(pdup, event, new_master);
> +			pdup->master = new_master;
> +		}
> +	}
> +	return 0;
> +}
