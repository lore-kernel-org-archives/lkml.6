Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934300AbeBMKpv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:45:51 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58494 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933865AbeBMKpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:45:49 -0500
Date: Tue, 13 Feb 2018 11:45:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Consider SD_NUMA when selecting the most
 idle group to schedule on
Message-ID: <20180213104541.GG25201@hirez.programming.kicks-ass.net>
References: <20180212171131.26139-1-mgorman@techsingularity.net>
 <20180212171131.26139-2-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212171131.26139-2-mgorman@techsingularity.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 05:11:30PM +0000, Mel Gorman wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 50442697b455..0192448e43a2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5917,6 +5917,18 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
>  	if (!idlest)
>  		return NULL;
>  
> +	/*
> +	 * When comparing groups across NUMA domains, it's possible for the
> +	 * local domain to be very lightly loaded relative to the remote
> +	 * domains but "imbalance" skews the comparison making remote CPUs
> +	 * look much more favourable. When considering cross-domain, add
> +	 * imbalance to the runnable load on the remote node and consider
> +	 * staying local.
> +	 */
> +	if ((sd->flags & SD_NUMA) &&
> +	    min_runnable_load + imbalance >= this_runnable_load)
> +		return NULL;
> +
>  	if (min_runnable_load > (this_runnable_load + imbalance))
>  		return NULL;

So this is basically a spread vs group decision, which we typically do
using SD_PREFER_SIBLNG. Now that flag is a bit awkward in that its set
on the child domain.

Now, we set it for SD_SHARE_PKG_RESOURCES (aka LLC), which means that for
our typical modern NUMA system we indicate we want to spread between the
lowest NUMA level. And regular load balancing will do so.

Now you modify the idlest code for initial placement to go against the
stable behaviour, which is unfortunate.

However, if we have numa balancing enabled, that will counteract
the normal spreading across nodes, so in that regard it makes sense, but
the above code is not conditional on numa balancing.

I'm torn and confused...
