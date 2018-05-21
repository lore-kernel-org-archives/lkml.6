Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeEUKLR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 06:11:17 -0400
Received: from foss.arm.com ([217.140.101.70]:46128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751075AbeEUKLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 06:11:13 -0400
Date: Mon, 21 May 2018 11:11:08 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v3 2/2] cpufreq: schedutil: Cleanup and document iowait
 boost
Message-ID: <20180521101108.GP30654@e110439-lin>
References: <20180521085120.7902-1-patrick.bellasi@arm.com>
 <20180521085120.7902-3-patrick.bellasi@arm.com>
 <20180521095255.h62pdcf34bh344wu@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521095255.h62pdcf34bh344wu@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-May 15:22, Viresh Kumar wrote:
> On 21-05-18, 09:51, Patrick Bellasi wrote:
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > +static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
> > +			       unsigned int flags)
> > +{
> > +	bool set_iowait_boost = flags & SCHED_CPUFREQ_IOWAIT;
> > +
> > +	/* Reset boost if the CPU appears to have been idle enough */
> > +	if (sg_cpu->iowait_boost &&
> > +	    sugov_iowait_reset(sg_cpu, time, set_iowait_boost))
> > +		return;
> > +
> > +	/* Boost only tasks waking up after IO */
> > +	if (!set_iowait_boost)
> > +		return;
> > +
> > +	/* Ensure boost doubles only one time at each request */
> > +	if (sg_cpu->iowait_boost_pending)
> > +		return;
> > +	sg_cpu->iowait_boost_pending = true;
> > +
> > +	/* Double the boost at each request */
> > +	if (sg_cpu->iowait_boost) {
> > +		sg_cpu->iowait_boost <<= 1;
> > +		if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
> > +			sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
> > +		return;
> 
> Maybe add "else" part of the if block and drop the "return" statement
> here ?

If not "mandatory", I would prefer as it is: I'm running with a small
stack size in my mind. :)

This "bail out of a function as soon as possible" template allows me
to see immediately that, for example in this function, once we decided
to double the boost value there is anything more to do here.

At the same time, the statement below it reads as the function
default action.

Does it make any sense?

[...]

> > +	/*
> > +	 * Apply the current boost value: a CPU is boosted only if its current
> > +	 * utilization is smaller then the current IO boost level.
> > +	 */
> >  	boost_util = sg_cpu->iowait_boost;
> >  	boost_max = sg_cpu->iowait_boost_max;
> > -
> 
> Maybe keep this blank line as is ?

I've removed it because the above comment now refers to all these
lines together.

> >  	if (*util * boost_max < *max * boost_util) {
> >  		*util = boost_util;
> >  		*max = boost_max;
> 
> Otherwise looks good.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Cheers

-- 
#include <best/regards.h>

Patrick Bellasi
