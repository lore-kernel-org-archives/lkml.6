Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeDKKsb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 06:48:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47986 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751889AbeDKKs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 06:48:28 -0400
Date: Wed, 11 Apr 2018 11:48:24 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2] cpufreq/schedutil: Cleanup, document and fix iowait
 boost
Message-ID: <20180411104824.GN14248@e110439-lin>
References: <20180410155931.31973-1-patrick.bellasi@arm.com>
 <20180411043726.GJ7671@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411043726.GJ7671@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-Apr 10:07, Viresh Kumar wrote:
> On 10-04-18, 16:59, Patrick Bellasi wrote:
> > The iowait boosting code has been recently updated to add a progressive
> > boosting behavior which allows to be less aggressive in boosting tasks
> > doing only sporadic IO operations, thus being more energy efficient for
> > example on mobile platforms.
> > 
> > The current code is now however a bit convoluted. Some functionalities
> > (e.g. iowait boost reset) are replicated in different paths and their
> > documentation is slightly misaligned.
> > 
> > Moreover, from a functional stadpoint, the iowait boosting is also not
> > always reset in systems where cpufreq policies are not shared, each CPU
> > has his own policy. Indeed, when a CPU is idle for a long time we keep
> > doubling the boosting instead of resetting it to the minimum frequency,
> > as expected by the TICK_NSEC logic, whenever a task wakes up from IO.
> > 
> > Let's cleanup the code by consolidating all the IO wait boosting related
> > functionality inside the already existing functions and better define
> > their role:
> > 
> > - sugov_set_iowait_boost: is now in charge only to set/increase the IO
> >      wait boost, every time a task wakes up from an IO wait.
> > 
> > - sugov_iowait_boost: is now in charge to reset/reduce the IO wait
> >      boost, every time a sugov update is triggered, as well as
> >      to (eventually) enforce the currently required IO boost value.
> > 
> > This is possible since these two functions are already used one after
> > the other, both in single and shared frequency domains, following the
> > same template:
> > 
> >    /* Configure IO boost, if required */
> >    sugov_set_iowait_boost()
> > 
> >    /* Return here if freq change is in progress or throttled */
> > 
> >    /* Collect and aggregate utilization information */
> >    sugov_get_util()
> >    sugov_aggregate_util()
> > 
> >    /* Add IO boost if currently enabled */
> >    sugov_iowait_boost()
> > 
> > As a extra bonus, let's also add the documentation for these two
> > functions and better align the in-code documentation.
> > 
> > Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> > Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Joel Fernandes <joelaf@google.com>
> > Cc: Steve Muckle <smuckle@google.com>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > 
> > ---
> > Changes in v2:
> > - Fix return in sugov_iowait_boost()'s reset code (Viresh)
> > - Add iowait boost reset for sugov_update_single() (Viresh)
> > - Title changed to reflact the fix from previous point
> > 
> > Based on today's tip/sched/core:
> >    b720342 sched/core: Update preempt_notifier_key to modern API
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 120 ++++++++++++++++++++++++++-------------
> >  1 file changed, 81 insertions(+), 39 deletions(-)
> > 
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 2b124811947d..2a2ae3a0e41f 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -51,7 +51,7 @@ struct sugov_cpu {
> >  	bool			iowait_boost_pending;
> >  	unsigned int		iowait_boost;
> >  	unsigned int		iowait_boost_max;
> > -	u64 last_update;
> > +	u64			last_update;
> >  
> >  	/* The fields below are only needed when sharing a policy: */
> >  	unsigned long		util_cfs;
> > @@ -201,43 +201,97 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> >  	return min(util, sg_cpu->max);
> >  }
> >  
> > -static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned int flags)
> > +/**
> > + * sugov_set_iowait_boost updates the IO boost at each wakeup from IO.
> > + * @sg_cpu: the sugov data for the CPU to boost
> > + * @time:   the update time from the caller
> > + * @flags:  SCHED_CPUFREQ_IOWAIT if the task is waking up after an IO wait
> > + *
> > + * Each time a task wakes up after an IO operation, the CPU utilization can be
> > + * boosted to a certain utilization which is doubled at each wakeup
> > + * from IO, starting from the utilization of the minimum OPP to that of the
> > + * maximum one.
> > + */
> > +static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
> > +				   unsigned int flags)
> >  {
> > -	if (flags & SCHED_CPUFREQ_IOWAIT) {
> > -		if (sg_cpu->iowait_boost_pending)
> > -			return;
> > -
> > -		sg_cpu->iowait_boost_pending = true;
> > +	bool iowait = flags & SCHED_CPUFREQ_IOWAIT;
> >  
> > -		if (sg_cpu->iowait_boost) {
> > -			sg_cpu->iowait_boost <<= 1;
> > -			if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
> > -				sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
> > -		} else {
> > -			sg_cpu->iowait_boost = sg_cpu->sg_policy->policy->min;
> > -		}
> > -	} else if (sg_cpu->iowait_boost) {
> > +	/* Reset boost if the CPU appears to have been idle enough */
> > +	if (sg_cpu->iowait_boost) {
> >  		s64 delta_ns = time - sg_cpu->last_update;
> >  
> > -		/* Clear iowait_boost if the CPU apprears to have been idle. */
> >  		if (delta_ns > TICK_NSEC) {
> > -			sg_cpu->iowait_boost = 0;
> > -			sg_cpu->iowait_boost_pending = false;
> > +			sg_cpu->iowait_boost = iowait
> > +				? sg_cpu->sg_policy->policy->min : 0;
> > +			sg_cpu->iowait_boost_pending = iowait;
> > +			return;
> >  		}
> >  	}
> > +
> > +	/* Boost only tasks waking up after IO */
> > +	if (!iowait)
> > +		return;
> > +
> > +	/* Ensure IO boost doubles only one time at each frequency increase */
> > +	if (sg_cpu->iowait_boost_pending)
> > +		return;
> > +	sg_cpu->iowait_boost_pending = true;
> > +
> > +	/* Double the IO boost at each frequency increase */
> > +	if (sg_cpu->iowait_boost) {
> > +		sg_cpu->iowait_boost <<= 1;
> > +		if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
> > +			sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
> > +		return;
> > +	}
> > +
> > +	/* At first wakeup after IO, start with minimum boost */
> > +	sg_cpu->iowait_boost = sg_cpu->sg_policy->policy->min;
> >  }
> 
> The above part should be a different patch with this:
> 
> Fixes: a5a0809bc58e ("cpufreq: schedutil: Make iowait boost more energy efficient")

You mean to split out on a separate patch the fix for the iowait boost
on per-cpu policies?

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
> > +	s64 delta_ns;
> >  
> > +	/* No IOWait boost active */
> >  	if (!sg_cpu->iowait_boost)
> >  		return;
> >  
> > +	/* Clear boost if the CPU appears to have been idle enough */
> > +	delta_ns = time - sg_cpu->last_update;
> > +	if (delta_ns > TICK_NSEC) {
> > +		sg_cpu->iowait_boost = 0;
> > +		sg_cpu->iowait_boost_pending = false;
> > +		return;
> > +	}
> > +
> > +	/* An IO waiting task has just woken up, use the boost value */
> >  	if (sg_cpu->iowait_boost_pending) {
> >  		sg_cpu->iowait_boost_pending = false;
> >  	} else {
> > +		/* Reduce the boost value otherwise */
> >  		sg_cpu->iowait_boost >>= 1;
> >  		if (sg_cpu->iowait_boost < sg_cpu->sg_policy->policy->min) {
> >  			sg_cpu->iowait_boost = 0;
> > @@ -248,6 +302,10 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, unsigned long *util,
> >  	boost_util = sg_cpu->iowait_boost;
> >  	boost_max = sg_cpu->iowait_boost_max;
> >  
> > +	/*
> > +	 * A CPU is boosted only if its current utilization is smaller then
> > +	 * the current IO boost level.
> > +	 */
> >  	if (*util * boost_max < *max * boost_util) {
> >  		*util = boost_util;
> >  		*max = boost_max;
> > @@ -299,7 +357,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
> >  	sugov_get_util(sg_cpu);
> >  	max = sg_cpu->max;
> >  	util = sugov_aggregate_util(sg_cpu);
> > -	sugov_iowait_boost(sg_cpu, &util, &max);
> > +	sugov_iowait_boost(sg_cpu, time, &util, &max);
> >  	next_f = get_next_freq(sg_policy, util, max);
> >  	/*
> >  	 * Do not reduce the frequency if the CPU has not been idle
> > @@ -325,28 +383,12 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
> >  	for_each_cpu(j, policy->cpus) {
> >  		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
> >  		unsigned long j_util, j_max;
> > -		s64 delta_ns;
> >  
> >  		sugov_get_util(j_sg_cpu);
> > -
> > -		/*
> > -		 * If the CFS CPU utilization was last updated before the
> > -		 * previous frequency update and the time elapsed between the
> > -		 * last update of the CPU utilization and the last frequency
> > -		 * update is long enough, reset iowait_boost and util_cfs, as
> > -		 * they are now probably stale. However, still consider the
> > -		 * CPU contribution if it has some DEADLINE utilization
> > -		 * (util_dl).
> > -		 */
> > -		delta_ns = time - j_sg_cpu->last_update;
> > -		if (delta_ns > TICK_NSEC) {
> > -			j_sg_cpu->iowait_boost = 0;
> > -			j_sg_cpu->iowait_boost_pending = false;
> > -		}
> > -
> >  		j_max = j_sg_cpu->max;
> >  		j_util = sugov_aggregate_util(j_sg_cpu);
> > -		sugov_iowait_boost(j_sg_cpu, &j_util, &j_max);
> > +		sugov_iowait_boost(j_sg_cpu, time, &j_util, &j_max);
> > +
> >  		if (j_util * max > j_max * util) {
> >  			util = j_util;
> >  			max = j_max;
> 
> And the rest is just code rearrangement. And as Peter said, we better
> have a routine to clear boost values on delta > TICK_NSEC.

Right, already commented in reply to Peter. I'll split in two patches:
one for documentation and code re-organization and a second one for
the fix to the issue you pointed out.

> Diff LGTM otherwise. Thanks.

Thanks

-- 
#include <best/regards.h>

Patrick Bellasi
