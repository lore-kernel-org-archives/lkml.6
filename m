Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753975AbeBLUUn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:20:43 -0500
Received: from outbound-smtp23.blacknight.com ([81.17.249.191]:58434 "EHLO
        outbound-smtp23.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752111AbeBLUUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:20:41 -0500
Date: Mon, 12 Feb 2018 20:20:40 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] sched/fair: Do not migrate on wake_affine_weight if
 weights are equal
Message-ID: <20180212202040.hebvzfpdzglx4miq@techsingularity.net>
References: <20180212145857.8056-1-mgorman@techsingularity.net>
 <20180212145857.8056-4-mgorman@techsingularity.net>
 <20180212172926.GY25201@hirez.programming.kicks-ass.net>
 <1518462889.7104.78.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518462889.7104.78.camel@gmx.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 08:14:49PM +0100, Mike Galbraith wrote:
> On Mon, 2018-02-12 at 18:29 +0100, Peter Zijlstra wrote:
> > On Mon, Feb 12, 2018 at 02:58:56PM +0000, Mel Gorman wrote:
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index c1091cb023c4..28c8d9c91955 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -5747,7 +5747,16 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
> > >  		prev_eff_load *= 100 + (sd->imbalance_pct - 100) / 2;
> > >  	prev_eff_load *= capacity_of(this_cpu);
> > >  
> > > -	return this_eff_load <= prev_eff_load ? this_cpu : nr_cpumask_bits;
> > > +	/*
> > > +	 * If sync, adjust the weight of prev_eff_load such that if
> > > +	 * prev_eff == this_eff that select_idle_sibling will consider
> > > +	 * stacking the wakee on top of the waker if no other CPU is
> > > +	 * idle.
> > > +	 */
> > > +	if (sync)
> > > +		prev_eff_load += 1;
> > 
> > So where we had <= and would consistently favour pulling the task to the
> > waking CPU when all else what equal, you now switch to <, such that when
> > things are equal we do not pull.
> > 
> > That makes sense I suppose.
> > 
> > Except for sync wakeups, where you say, if everything else is equal,
> > pull, which also makes sense, because sync says 'current' promises to go
> > away.
> > 
> > OK.
> 
> Tasks tend to not honor that promise.. a lot.  Even if the sync hint
> were a golden promise, it wouldn't be bullet proof: migrating a compute
> hog based on a single "phoned home" wakeup remains a bad idea whether
> schedule() is called immediately after the wakeup or not.  It's a pain,
> only useful informational content is "this is a communication wakeup".
> 

Agreed and I'm aware of the hazard of sync wakeups being no guarantee
that the task will immediately sleep. If there is any delay at all then
stacking incurs a wakeup latency penalty but in many cases, it'll be an
idle sibling that is used. The sync hint does give a stronger hint that the
tasks are closely related though which is why I special-cased it slightly
and I feel it's justified. I think in all cases where it mattered, it was
due to pref_eff_load and this_eff_load begin equal to 0 when waking a task
via a socket.

-- 
Mel Gorman
SUSE Labs
