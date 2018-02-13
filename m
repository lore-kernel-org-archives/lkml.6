Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934753AbeBMLfw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:35:52 -0500
Received: from outbound-smtp09.blacknight.com ([46.22.139.14]:51339 "EHLO
        outbound-smtp09.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934078AbeBMLfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:35:50 -0500
Date: Tue, 13 Feb 2018 11:35:48 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Consider SD_NUMA when selecting the most
 idle group to schedule on
Message-ID: <20180213113548.tb7zxzly32oz3mfb@techsingularity.net>
References: <20180212171131.26139-1-mgorman@techsingularity.net>
 <20180212171131.26139-2-mgorman@techsingularity.net>
 <20180213104541.GG25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180213104541.GG25201@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 11:45:41AM +0100, Peter Zijlstra wrote:
> On Mon, Feb 12, 2018 at 05:11:30PM +0000, Mel Gorman wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 50442697b455..0192448e43a2 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5917,6 +5917,18 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
> >  	if (!idlest)
> >  		return NULL;
> >  
> > +	/*
> > +	 * When comparing groups across NUMA domains, it's possible for the
> > +	 * local domain to be very lightly loaded relative to the remote
> > +	 * domains but "imbalance" skews the comparison making remote CPUs
> > +	 * look much more favourable. When considering cross-domain, add
> > +	 * imbalance to the runnable load on the remote node and consider
> > +	 * staying local.
> > +	 */
> > +	if ((sd->flags & SD_NUMA) &&
> > +	    min_runnable_load + imbalance >= this_runnable_load)
> > +		return NULL;
> > +
> >  	if (min_runnable_load > (this_runnable_load + imbalance))
> >  		return NULL;
> 
> So this is basically a spread vs group decision, which we typically do
> using SD_PREFER_SIBLNG. Now that flag is a bit awkward in that its set
> on the child domain.
> 
> Now, we set it for SD_SHARE_PKG_RESOURCES (aka LLC), which means that for
> our typical modern NUMA system we indicate we want to spread between the
> lowest NUMA level. And regular load balancing will do so.
> 
> Now you modify the idlest code for initial placement to go against the
> stable behaviour, which is unfortunate.
> 

The initial placement decision is based on a domain that has SD_LOAD_BALANCE
set and fair enough, we really do want load balancing to examine more
domains for balancing.  There are instances where automatic NUMA balancing
will disagree with the load balancer but I couldn't decide whether it's
a good idea to "fix" that given that using remote domains also means more
memory channels are potentially used. There is no clear winner there so
I left it alone.

This patch is only concerned with the initial placement. If it based the
decision on SD_PREFER_SIBLING then we run a real risk of saturating one
node while others are left alone hoping that the load balancer will fix
it in the near future and automatic NUMA balancing will not get in the
way. That seemed ripe for generating bugs about saturation on one node
while others are idle. That's why I took the approach of resisting, but
not preventing, a remote node being used for initial placement.

I did try altering the second condition
"min_runnable_load > (this_runnable_load + imbalance" to alter how
imbalance is treated but it did not work very well. While a remote node may
not be used, it then had a tendency to stack the new task on top of
the parent. This patch was the one that fixed one problem without
creating others.

> However, if we have numa balancing enabled, that will counteract
> the normal spreading across nodes, so in that regard it makes sense, but
> the above code is not conditional on numa balancing.
> 

It's not conditional on NUMA balancing because one case where it mattered
was a fork-intensive workload driven by shell scripts. In that case, the
workload benefits from preferring a local node without any involvement from
NUMA balancing. I could make it conditional on it but it's not strictly
related to automatic NUMA balancing, it's about being less eager about
starting new children on remote nodes.

-- 
Mel Gorman
SUSE Labs
