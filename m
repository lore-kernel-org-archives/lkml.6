Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933939AbeCGPhi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:37:38 -0500
Received: from foss.arm.com ([217.140.101.70]:53028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933487AbeCGPhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:37:37 -0500
Date: Wed, 7 Mar 2018 15:37:32 +0000
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
Message-ID: <20180307153732.GF2211@e110439-lin>
References: <20180222170153.673-1-patrick.bellasi@arm.com>
 <20180222170153.673-2-patrick.bellasi@arm.com>
 <20180306185851.GG25201@hirez.programming.kicks-ass.net>
 <20180307093937.GZ25235@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307093937.GZ25235@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-Mar 10:39, Peter Zijlstra wrote:
> On Tue, Mar 06, 2018 at 07:58:51PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 22, 2018 at 05:01:50PM +0000, Patrick Bellasi wrote:
> > > +static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
> > > +				    struct task_struct *p)
> > > +{
> > > +	unsigned int enqueued;
> > > +
> > > +	if (!sched_feat(UTIL_EST))
> > > +		return;
> > > +
> > > +	/* Update root cfs_rq's estimated utilization */
> > > +	enqueued  = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> > > +	enqueued += _task_util_est(p);
> > > +	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
> > > +}
> 
> > It appears to me this isn't a stable situation and completely relies on
> > the !nr_running case to recalibrate. If we ensure that doesn't happen
> > for a significant while the sum can run-away, right?
> > 
> > Should we put a max in enqueue to avoid this?
> 
> Thinking about this a bit more; would it make sense to adjust the
> running sum/avg on migration? Something along the lines of:
> 
>   util_avg = se->load_avg / (cfs_rq->load_avg + se->load_avg);
> 
> (which disregards cgroups), because that should more or less be the time
> it ends up running, given the WFQ rule.

I would say it makes sense from a purely mechanism stanpoing, but I'm
not entirely convinced it can be useful from a practical stanpoint.

First of all, that should be applied only when we migrate to a more
saturated CPU. Otherwise, when migrating on an empty CPU we would set
util_avg = 100%

Secondly, when we migrate to a saturated CPU, this adjustment will
contribute to under-estimate the task utilization.
Let say the task was running on a completely empty CPU, and thus we
was able to ramp up without being preempted. This value represents a
good estimation of the (most recent) task CPU demands.

Now, if on a following activation, we wakeup the task on an IDLE CPU
with a lot of blocked load, then we will scale down its util_avg
and assume the task will be smaller.
But:

a) if the blocked load does not turns into some task waking up again,
   underestimated the task introduces only further ramp-up latencies

b) if the load it due to really active tasks, the task will be
   preempted and it's utilization smaller... but we are already in a
   domain where utilization does not tell us anything useful for a
   task... and thus, why bothering to make it converging sooner?


> That way the disparity between tasks migrating into the CPU at u=1 and
> them going to sleep at u<1 is much smaller and the above sum doesn't run
> away nearly as wild (it still needs some upper bound though).

-- 
#include <best/regards.h>

Patrick Bellasi
