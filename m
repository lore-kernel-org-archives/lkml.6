Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753454AbeCFLuW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 06:50:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeCFLuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 06:50:20 -0500
Date: Tue, 6 Mar 2018 12:50:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: linxiulei@gmail.com
Cc: jolsa@redhat.com, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, eranian@gmail.com, torvalds@linux-foundation.org,
        linux-perf-users@vger.kernel.org, brendan.d.gregg@gmail.com,
        yang_oliver@hotmail.com, "leilei.lin" <leilei.lin@alibaba-inc.com>
Subject: Re: [PATCH RESEND v5] perf/core: Fix installing arbitrary cgroup
 event into cpu
Message-ID: <20180306115010.GC25201@hirez.programming.kicks-ass.net>
References: <20180306093637.28247-1-linxiulei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306093637.28247-1-linxiulei@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 05:36:37PM +0800, linxiulei@gmail.com wrote:
> From: "leilei.lin" <leilei.lin@alibaba-inc.com>
> 
> Do not install cgroup event into the CPU context and schedule it
> if the cgroup is not running on this CPU

OK, so far so good, this explains the bit in
__perf_install_in_context().

> While there is no task of cgroup running specified CPU, current
> kernel still install cgroup event into CPU context that causes
> another cgroup event can't be installed into this CPU.
> 
> This patch prevent scheduling events at __perf_install_in_context()
> and installing events at list_update_cgroup_event() if cgroup isn't
> running on specified CPU.

This bit doesn't make sense, you don't in fact avoid anything in
list_update_cgroup_event(), you do more, not less.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4df5b69..f3ffa70 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -933,31 +933,45 @@ list_update_cgroup_event(struct perf_event *event,
>  {
>  	struct perf_cpu_context *cpuctx;
>  	struct list_head *cpuctx_entry;
> +	struct perf_cgroup *cgrp;
>  
>  	if (!is_cgroup_event(event))
>  		return;
>  
>  	/*
>  	 * Because cgroup events are always per-cpu events,
>  	 * this will always be called from the right CPU.
>  	 */
>  	cpuctx = __get_cpu_context(ctx);
> +	cgrp = perf_cgroup_from_task(current, ctx);
> +
> +	/*
> +	 * if only the cgroup is running on this cpu
> +	 * and cpuctx->cgrp == NULL (otherwise it would've
> +	 * been set with running cgroup), we put this cgroup
> +	 * into cpu context. Or it would case mismatch in
> +	 * following cgroup events at event_filter_match()
> +	 */

This is utterly incomprehensible, what?

> +	if (add && !cpuctx->cgrp &&
> +			cgroup_is_descendant(cgrp->css.cgroup,
> +			event->cgrp->css.cgroup)) {
> +		cpuctx->cgrp = cgrp;
> +	}

And that's just horrible coding style. Maybe something like:

	if (add && cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup)) {
		if (cpuctx->cgrp)
			WARN_ON_ONCE(cpuctx->cgrp != cgrp);
		cpuctx->cgrp = cgrp;
	}

that? But that still needs a comment to explain _why_ we do that here.
Under what condition would we fail to have cpuctx->cgrp set while
ctx->nr_cgroups. Your comment doesn't explain nor does your Changelog.

> +
> +	if (add && ctx->nr_cgroups++)
> +		return;
> +	else if (!add && --ctx->nr_cgroups)
> +		return;
>  
> +	/* no cgroup running */
> +	if (!add)
> +		cpuctx->cgrp = NULL;
> +
> +	cpuctx_entry = &cpuctx->cgrp_cpuctx_entry;
> +	if (add)
>  		list_add(cpuctx_entry, this_cpu_ptr(&cgrp_cpuctx_list));
> +	else
>  		list_del(cpuctx_entry);
>  }
>  
>  #else /* !CONFIG_CGROUP_PERF */
> @@ -2311,6 +2325,20 @@ static int  __perf_install_in_context(void *info)
>  		raw_spin_lock(&task_ctx->lock);
>  	}
>  
> +#ifdef CONFIG_CGROUP_PERF
> +	if (is_cgroup_event(event)) {
> +		/*
> +		 * Only care about cgroup events.
> +		 *

That bit is entirely spurious, if it right after if (is_cgroup_event()),
obviously this block is only for cgroup events.

> +		 * If only the task belongs to cgroup of this event,
> +		 * we will continue the installment

And that isn't really english. I think you meant to write something
like:

		/*
		 * If the current cgroup doesn't match the event's
		 * cgroup, we should not try to schedule it.
		 */

> +		 */
> +		struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
> +		reprogram = cgroup_is_descendant(cgrp->css.cgroup,
> +					event->cgrp->css.cgroup);
> +	}
> +#endif
> +
>  	if (reprogram) {
>  		ctx_sched_out(ctx, cpuctx, EVENT_TIME);
>  		add_event_to_ctx(event, ctx);
> -- 
> 2.8.4.31.g9ed660f
> 
