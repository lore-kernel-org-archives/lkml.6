Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752394AbeDJKn4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:43:56 -0400
Received: from foss.arm.com ([217.140.101.70]:36382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751471AbeDJKny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:43:54 -0400
Date: Tue, 10 Apr 2018 11:43:49 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH] cpufreq/schedutil: Cleanup and document iowait boost
Message-ID: <20180410104349.GE14248@e110439-lin>
References: <20180328090721.26068-1-patrick.bellasi@arm.com>
 <20180405095858.GP3572@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405095858.GP3572@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 05-Apr 15:28, Viresh Kumar wrote:
> On 28-03-18, 10:07, Patrick Bellasi wrote:
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 2b124811947d..c840b0626735 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -201,43 +201,80 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> >  	return min(util, sg_cpu->max);
> >  }
> 
> I like the general idea but there are few things which look incorrect
> to me, even in the current code.
> 
> > -static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned int flags)
> > +/**
> > + * sugov_set_iowait_boost updates the IO boost at each wakeup from IO.
> > + * @sg_cpu: the sugov data for the CPU to boost
> > + * @flags:  SCHED_CPUFREQ_IOWAIT if the task is waking up after an IO wait
> > + *
> > + * Each time a task wakes up after an IO operation, the CPU utilization can be
> > + * boosted to a certain utilization which is doubled at each wakeup
> > + * from IO, starting from the utilization of the minimum OPP to that of the
> > + * maximum one.
> 
> You may also want to write here that the doubling of boost value is
> restricted by rate_limit_us duration, its not that we double every
> time this routine is called.

Right, so we are fine to double the boost value although this is not
always translated into a frequency increase. Will add that note to v2.

> 
> > + */
> > +static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, unsigned int flags)
> >  {
> 
> >  
> > -		/* Clear iowait_boost if the CPU apprears to have been idle. */
> > -		if (delta_ns > TICK_NSEC) {
> > -			sg_cpu->iowait_boost = 0;
> > -			sg_cpu->iowait_boost_pending = false;
> > -		}
> 
> So this is the only difference in this routine, everything else is
> re-arrangement IIUC.

Yes, it's mostly code re-arrangement with the goal (not necessarily
already achieved) to make it more easy to maintain...

> There is a problem that I see in existing code as well as code after
> this commit.
> 
> Consider this sequence of events on a platform where cpufreq policies
> aren't shared, i.e. each CPU has his own policy.
> 
> sugov_set_iowait_boost() gets called multiple times for a CPU with
> IOWAIT flag set that leads us to a big boost value, like fmax. The CPU
> goes to idle then and the task wakes up after few ticks.  Because we
> are first checking the IOWAIT flag in this routine, we will double the
> iowait boost. Ideally, based on the TICK_NSEC logic we have, we should
> have first set the iowait boost to 0 and then because the flag was
> set, set the boost to fmin. So the order of this routine needs to get
> fixed in the first patch.

Yes, I agree... that sounds more logical. Moreover, I found that
moving the above check in the following function is also broken, since
we always update last_update right after sugov_set_iowait_boost()
calls...

> The same problem can happen for cases where the policy is shared as
> well, but chances are less.
> 
> > -static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, unsigned long *util,
> > -			       unsigned long *max)
> > +/**
> > + * sugov_iowait_boost boosts a CPU after a wakeup from IO.
> > + * @sg_cpu: the sugov data for the cpu to boost
> > + * @time:   the update time from the caller
> > + * @util:   the utilization to (eventually) boost
> > + * @max:    the maximum value the utilization can be boosted to
> > + *
> > + * A CPU running a task which woken up after an IO operation can have its
> > + * utilization boosted to speed up the completion of those IO operations.
> > + * The IO boost value is increased each time a task wakes up from IO, in
> > + * sugov_set_iowait_boost(), and it's instead decreased by this function,
> > + * each time an increase has not been requested (!iowait_boost_pending).
> > + *
> > + * A CPU which also appears to have been idle for at least one tick has also
> > + * its IO boost utilization reset.
> > + *
> > + * This mechanism is designed to boost high frequently IO waiting tasks, while
> > + * being more conservative on tasks which does sporadic IO operations.
> > + */
> > +static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
> > +			       unsigned long *util, unsigned long *max)
> >  {
> >  	unsigned int boost_util, boost_max;
> >  
> > -	if (!sg_cpu->iowait_boost)
> > +	/* Clear boost if the CPU appears to have been idle enough */
> > +	if (sg_cpu->iowait_boost) {
> > +		s64 delta_ns = time - sg_cpu->last_update;
> > +
> > +		if (delta_ns > TICK_NSEC) {
> > +			sg_cpu->iowait_boost = 0;
> > +			sg_cpu->iowait_boost_pending = false;
> > +		}
> >  		return;
> 
> This looks incorrect. I have read this 10 times and it looked
> incorrect every single time :(
> 
> The "return" statement should be part of the if block itself ? Else we
> will never boost.

Right...

> > +	}
> >  
> 
> Now we can reach here even on !sg_cpu->iowait_boost which wasn't the
> case earlier. Though we will eventually return from the routine
> without doing any damage, but we will waste some time running useless
> if/else expressions.
> 
> Maybe still have something like
> 
>         if (!sg_cpu->iowait_boost)
>                 return;
> 
> ??

What about this new version for the two functions,
just compile tested:

---8<---

static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
				   unsigned int flags)
{
	bool iowait = flags & SCHED_CPUFREQ_IOWAIT;

	/* Reset boost if the CPU appears to have been idle enough */
	if (sg_cpu->iowait_boost) {
		s64 delta_ns = time - sg_cpu->last_update;

		if (delta_ns > TICK_NSEC) {
			sg_cpu->iowait_boost = iowait
				? sg_cpu->sg_policy->policy->min : 0;
			sg_cpu->iowait_boost_pending = iowait;
			return;
		}
	}

	/* Boost only tasks waking up after IO */
	if (!iowait)
		return;

	/* Ensure IO boost doubles only one time at each frequency increase */
	if (sg_cpu->iowait_boost_pending)
		return;
	sg_cpu->iowait_boost_pending = true;

	/* Double the IO boost at each frequency increase */
	if (sg_cpu->iowait_boost) {
		sg_cpu->iowait_boost <<= 1;
		if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
			sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
		return;
	}

	/* At first wakeup after IO, start with minimum boost */
	sg_cpu->iowait_boost = sg_cpu->sg_policy->policy->min;
}

static void sugov_iowait_boost(struct sugov_cpu *sg_cpu,
			       unsigned long *util, unsigned long *max)
{
	unsigned int boost_util, boost_max;

        /* No IOWait boost active */
        if (!sg_cpu->iowait_boost)
                return;

	/* An IO waiting task has just woken up, use the boost value */
	if (sg_cpu->iowait_boost_pending) {
		sg_cpu->iowait_boost_pending = false;
	} else {
		/* Reduce the boost value otherwise */
		sg_cpu->iowait_boost >>= 1;
		if (sg_cpu->iowait_boost < sg_cpu->sg_policy->policy->min) {
			sg_cpu->iowait_boost = 0;
			return;
		}
	}

	boost_util = sg_cpu->iowait_boost;
	boost_max = sg_cpu->iowait_boost_max;

	/*
	 * A CPU is boosted only if its current utilization is smaller then
	 * the current IO boost level.
	 */
	if (*util * boost_max < *max * boost_util) {
		*util = boost_util;
		*max = boost_max;
	}
}

---8<---

-- 
#include <best/regards.h>

Patrick Bellasi
