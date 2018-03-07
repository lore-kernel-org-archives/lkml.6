Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754333AbeCGLcA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 06:32:00 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49098 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbeCGLb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 06:31:59 -0500
Date: Wed, 7 Mar 2018 11:31:49 +0000
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
Subject: Re: [PATCH v5 1/4] sched/fair: add util_est on top of PELT
Message-ID: <20180307113149.GA2211@e110439-lin>
References: <20180222170153.673-1-patrick.bellasi@arm.com>
 <20180222170153.673-2-patrick.bellasi@arm.com>
 <20180306185851.GG25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306185851.GG25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-Mar 19:58, Peter Zijlstra wrote:
> On Thu, Feb 22, 2018 at 05:01:50PM +0000, Patrick Bellasi wrote:
> > +static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
> > +				    struct task_struct *p)
> > +{
> > +	unsigned int enqueued;
> > +
> > +	if (!sched_feat(UTIL_EST))
> > +		return;
> > +
> > +	/* Update root cfs_rq's estimated utilization */
> > +	enqueued  = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> > +	enqueued += _task_util_est(p);
> > +	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
> > +}
> 
> > +static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
> > +				    struct task_struct *p,
> > +				    bool task_sleep)
> > +{
> > +	long last_ewma_diff;
> > +	struct util_est ue;
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
> > +	ue.enqueued = 0;
> > +	if (cfs_rq->nr_running) {
> > +		ue.enqueued  = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> > +		ue.enqueued -= min_t(unsigned int, ue.enqueued,
> > +				     _task_util_est(p));
> > +	}
> > +	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);
> 
> It appears to me this isn't a stable situation and completely relies on
> the !nr_running case to recalibrate. If we ensure that doesn't happen
> for a significant while the sum can run-away, right?

By away you mean go over 1024 or overflow the unsigned int storage?

In the first case, I think we don't care about exceeding 1024 since:
- we cap to capacity_orig_of in cpu_util_est
- by directly reading the cfs_rq->avg.util_est.enqueued we can
  actually detect conditions in which a CPU is over-saturated.

In the second case, with an unsigned int we can enqueue up to few
millions of 100% tasks on a single CPU without overflowing.

> Should we put a max in enqueue to avoid this?

IMO the capping from the cpu_util_est getter should be enough...

Maybe I'm missing your point here?

-- 
#include <best/regards.h>

Patrick Bellasi
