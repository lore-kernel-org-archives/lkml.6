Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeA3Mqj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:46:39 -0500
Received: from foss.arm.com ([217.140.101.70]:53368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751822AbeA3Mqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:46:38 -0500
Date: Tue, 30 Jan 2018 12:46:33 +0000
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v3 1/3] sched/fair: add util_est on top of PELT
Message-ID: <20180130124632.GC5739@e110439-lin>
References: <20180123180847.4477-1-patrick.bellasi@arm.com>
 <20180123180847.4477-2-patrick.bellasi@arm.com>
 <20180129163642.GF2228@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129163642.GF2228@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-Jan 17:36, Peter Zijlstra wrote:
> On Tue, Jan 23, 2018 at 06:08:45PM +0000, Patrick Bellasi wrote:
> > +static inline void util_est_dequeue(struct task_struct *p, int flags)
> > +{
> > +	struct cfs_rq *cfs_rq = &task_rq(p)->cfs;
> > +	unsigned long util_last = task_util(p);
> > +	bool sleep = flags & DEQUEUE_SLEEP;
> > +	unsigned long ewma;
> > +	long util_est = 0;
> > +
> > +	if (!sched_feat(UTIL_EST))
> > +		return;
> > +
> > +	/*
> > +	 * Update root cfs_rq's estimated utilization
> > +	 *
> > +	 * If *p is the last task then the root cfs_rq's estimated utilization
> > +	 * of a CPU is 0 by definition.
> > +	 */
> > +	if (cfs_rq->nr_running) {
> > +		util_est  = READ_ONCE(cfs_rq->util_est_runnable);
> > +		util_est -= min_t(long, util_est, task_util_est(p));
> > +	}
> > +	WRITE_ONCE(cfs_rq->util_est_runnable, util_est);
> > +
> > +	/*
> > +	 * Skip update of task's estimated utilization when the task has not
> > +	 * yet completed an activation, e.g. being migrated.
> > +	 */
> > +	if (!sleep)
> > +		return;
> > +
> 
> Since you only use sleep once, you might as well write it out there.

Right, will move the flag check right here.

> Also, does GCC lower the task_util() eval to here?

Good point, kind-of... on ARM64 it generates a register load just before
the above if condition. I guess it does that to speculatively trigger a
load from memory in case the above check should pass?

Anyway, looks more it can be also a micro-arch optimization.
Thus, even just for better readability of the following chunk, it's
better to move the util_last definition here.

> > +        /*
> > +         * Skip update of task's estimated utilization when its EWMA is already
> > +         * ~1% close to its last activation value.
> > +         */
> > +        util_est = p->util_est.ewma;
> > +        if (abs(util_est - util_last) <= (SCHED_CAPACITY_SCALE / 100))
> > +                return;
> 
> Aside from that being whitespace challenged, did you also try:
> 
> 	if ((unsigned)((util_est - util_last) + LIM - 1) < (2 * LIM - 1))

No, since the above code IMO is so much "easy to parse for humans" :)
But, mainly because since the cache alignment update, also while testing on a
"big" Intel machine I cannot see regressions on hackbench.

This is the code I get on my Xeon E5-2690 v2:

       if (abs(util_est - util_last) <= (SCHED_CAPACITY_SCALE / 100))
   6ba0:       8b 86 7c 02 00 00       mov    0x27c(%rsi),%eax
   6ba6:       48 29 c8                sub    %rcx,%rax
   6ba9:       48 99                   cqto
   6bab:       48 31 d0                xor    %rdx,%rax
   6bae:       48 29 d0                sub    %rdx,%rax
   6bb1:       48 83 f8 0a             cmp    $0xa,%rax
   6bb5:       7e 1d                   jle    6bd4 <dequeue_task_fair+0x7e4>

Does it look so bad?

> Also, since we only care about the absolute value; we could use:
> 
> 	util_last - ewma
> 
> here (note the above also forgets to use READ_ONCE), and reuse the result:
> 
> > +
> > +	/*
> > +	 * Update Task's estimated utilization
> > +	 *
> > +	 * When *p completes an activation we can consolidate another sample
> > +	 * about the task size. This is done by storing the last PELT value
> > +	 * for this task and using this value to load another sample in the
> > +	 * exponential weighted moving average:
> > +	 *
> > +	 *      ewma(t) = w *  task_util(p) + (1 - w) ewma(t-1)
> > +	 *              = w *  task_util(p) + ewma(t-1) - w * ewma(t-1)
> > +	 *              = w * (task_util(p) + ewma(t-1) / w - ewma(t-1))
> > +	 *
> > +	 * Where 'w' is the weight of new samples, which is configured to be
> > +	 * 0.25, thus making w=1/4
> > +	 */
> > +	p->se.avg.util_est.last = util_last;
> > +	ewma = READ_ONCE(p->se.avg.util_est.ewma);
> > +	ewma   = util_last + (ewma << UTIL_EST_WEIGHT_SHIFT) - ewma;
> 
> here.

Right! +1

> 
> > +	ewma >>= UTIL_EST_WEIGHT_SHIFT;
> > +	WRITE_ONCE(p->se.avg.util_est.ewma, ewma);
> > +}
> 
> So something along these lines:
> 
> 	ewma = READ_ONCE(p->se.avg.util_est.ewma);
> 	diff = util_last - ewma;
> 	if ((unsigned)(diff + LIM - 1) < (2 * LIM - 1))
> 		return;
> 
> 	p->se.avg.util_est.last = util_last;
> 	ewma = (diff + (ewma << EWMA_SHIFT)) >> EWMA_SHIFT;
> 	WRITE_ONCE(p->se.avg.util_est.ewma, ewma);
> 
> Make sense?

Looks ok to me, I will for sure update to reuse the difference.

Regarding the comparison, I'll try your formula to check again if there is any
noticeable difference on hackbench.

Thanks Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
