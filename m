Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966625AbeEJQyV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 12:54:21 -0400
Received: from foss.arm.com ([217.140.101.70]:58888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966323AbeEJQyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 12:54:19 -0400
Date: Thu, 10 May 2018 17:54:14 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH 3/3] sched/fair: schedutil: explicit update only when
 required
Message-ID: <20180510165414.GB30654@e110439-lin>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
 <20180510150553.28122-4-patrick.bellasi@arm.com>
 <20180510161515.GH12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510161515.GH12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-May 18:15, Peter Zijlstra wrote:
> On Thu, May 10, 2018 at 04:05:53PM +0100, Patrick Bellasi wrote:
> > All the above considered, let's make schedutil updates more explicit in
> > fair.c by removing the cfs_rq_util_change() wrapper function in favour
> > of the existing cpufreq_update_util() public API.
> > This can be done by calling cpufreq_update_util() explicitly in the few
> > call sites where it really makes sense and when all the (potentially)
> > required cfs_rq's information have been updated.
> 
> Aside from having to redraw my ever stale diagrams _again_ I don't think
> I object too much here. As you write tracking the exact point where we
> did do the update was fairly tedious.

Maybe we can simplify even better these diagrams if we get to the
point where schedutil updates are tirggered just from core.c...

This patch could be a first step on this directions, not entirely sure
we can get there... but, having some well defined callbacks maybe it
can make it easier to factorize up the updates in the core scheduler.

> > @@ -5397,9 +5366,27 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  		update_cfs_group(se);
> >  	}
> >  
> > +	/* The task is visible from the root cfs_rq */
> > +	if (!se) {
> > +		unsigned int flags = 0;
> 
> That one shadows the @flags argument. Some checker is bound to complain
> about it.

Ohps... right... I'll s/flags/sc_flags/ "sc_" standing for SCHED_CPUFREQ_.

> > +
> >  		add_nr_running(rq, 1);
> >  
> > +		if (p->in_iowait)
> > +			flags |= SCHED_CPUFREQ_IOWAIT;
> > +
> > +		/*
> > +		 * !last_update_time means we've passed through
> > +		 * migrate_task_rq_fair() indicating we migrated.
> > +		 *
> > +		 * IOW we're enqueueing a task on a new CPU.
> > +		 */
> > +		if (!p->se.avg.last_update_time)
> > +			flags |= SCHED_CPUFREQ_MIGRATION;
> > +
> > +		cpufreq_update_util(rq, flags);
> > +	}
> > +
> >  	hrtick_update(rq);
> >  }

-- 
#include <best/regards.h>

Patrick Bellasi
