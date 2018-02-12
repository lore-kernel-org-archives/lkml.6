Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753104AbeBLRnK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:43:10 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:39156 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751156AbeBLRnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:43:09 -0500
Date: Mon, 12 Feb 2018 17:43:07 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] sched/fair: Do not migrate on wake_affine_weight if
 weights are equal
Message-ID: <20180212174307.ytpc4r2iy7rakh32@techsingularity.net>
References: <20180212145857.8056-1-mgorman@techsingularity.net>
 <20180212145857.8056-4-mgorman@techsingularity.net>
 <20180212172926.GY25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180212172926.GY25201@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 06:29:26PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 12, 2018 at 02:58:56PM +0000, Mel Gorman wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index c1091cb023c4..28c8d9c91955 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5747,7 +5747,16 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
> >  		prev_eff_load *= 100 + (sd->imbalance_pct - 100) / 2;
> >  	prev_eff_load *= capacity_of(this_cpu);
> >  
> > -	return this_eff_load <= prev_eff_load ? this_cpu : nr_cpumask_bits;
> > +	/*
> > +	 * If sync, adjust the weight of prev_eff_load such that if
> > +	 * prev_eff == this_eff that select_idle_sibling will consider
> > +	 * stacking the wakee on top of the waker if no other CPU is
> > +	 * idle.
> > +	 */
> > +	if (sync)
> > +		prev_eff_load += 1;
> 
> So where we had <= and would consistently favour pulling the task to the
> waking CPU when all else what equal, you now switch to <, such that when
> things are equal we do not pull.
> 
> That makes sense I suppose.
> 

Yep, with the addenum that when CPU load is equal, it does not
necessarily mean they are equal in terms of memory locality. It might
make more sense to use <= if there were more cases where we stacked
tasks on the same CPU but we avoid that as much as possible for good
reasons.

-- 
Mel Gorman
SUSE Labs
