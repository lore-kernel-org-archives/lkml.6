Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751029AbeBIKLr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 05:11:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52662 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbeBIKLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 05:11:45 -0500
Date: Fri, 9 Feb 2018 11:11:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: linxiulei@gmail.com
Cc: jolsa@redhat.com, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        eranian@gmail.com, torvalds@linux-foundation.org,
        brendan.d.gregg@gmail.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, yang_oliver@hotmail.com,
        jinli.zjl@alibaba-inc.com, "leilei.lin" <leilei.lin@alibaba-inc.com>
Subject: Re: [PATCH RESEND v4] perf/core: Fix installing cgroup event into cpu
Message-ID: <20180209101128.GF25181@hirez.programming.kicks-ass.net>
References: <20180208033344.71933-1-linxiulei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208033344.71933-1-linxiulei@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 11:33:44AM +0800, linxiulei@gmail.com wrote:
> From: "leilei.lin" <leilei.lin@alibaba-inc.com>
> 
> Do not install cgroup event into the CPU context and schedule it
> if the cgroup is not running on this CPU
> 
> While there is no task of cgroup running specified CPU, current
> kernel still install cgroup event into CPU context that causes
> another cgroup event can't be installed into this CPU.
> 
> This patch prevent scheduling events at __perf_install_in_context()
> and installing events at list_update_cgroup_event() if cgroup isn't
> running on specified CPU.
> 
> Signed-off-by: leilei.lin <leilei.lin@alibaba-inc.com>
> ---
>  v2: Set cpuctx->cgrp only if the same cgroup is running on this
>    CPU otherwise following events couldn't be activated immediately
>  v3: Enhance the comments and commit message
>  v4: Adjust to config
> 
>  kernel/events/core.c | 50 +++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4df5b69..fd28d61 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -933,31 +933,41 @@ list_update_cgroup_event(struct perf_event *event,
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
>  
> +	/*
> +	 * if only the cgroup is running on this cpu,
> +	 * we put/remove this cgroup into cpu context.
> +	 * Or it would case mismatch in following cgroup
> +	 * events at event_filter_match()
> +	 */
> +	if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup)) {
> +		if (add)
>  			cpuctx->cgrp = cgrp;
> +		else
> +			cpuctx->cgrp = NULL;
>  	}

I am still not convinced this is correct.

Suppose we have

   R
  / \
 A   B
    / \
   C

And our current task is of B, and B has an event.

We then install an event in C, if we then destroy our event in C, it
would clear cpuctx->cgrp, which is wrong, since there is still an event
in B.

Simpler still, if B were to have 2 events, and we'd remove one, that
would still clear cpuctx->cgrp, even though there is an event left.

This is the exact issue I pointed out last time, and I still don't see
how it would now be correct.

Northing explains why its ok to have NULL cpuctx->cgrp when there are in
fact still cgroup events on the CPU.
