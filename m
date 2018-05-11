Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752843AbeEKJMs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 05:12:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38376 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751406AbeEKJMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 05:12:47 -0400
Date: Fri, 11 May 2018 10:12:42 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH 1/3] sched/cpufreq: always consider blocked FAIR
 utilization
Message-ID: <20180511091242.GE30654@e110439-lin>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
 <20180510150553.28122-2-patrick.bellasi@arm.com>
 <20180511054407.qxwyyqsgyzqsf6e4@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511054407.qxwyyqsgyzqsf6e4@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-May 11:14, Viresh Kumar wrote:
> On 10-05-18, 16:05, Patrick Bellasi wrote:
> > Since the refactoring introduced by:
> > 
> >    commit 8f111bc357aa ("cpufreq/schedutil: Rewrite CPUFREQ_RT support")
> > 
> > we aggregate FAIR utilization only if this class has runnable tasks.
> > This was mainly due to avoid the risk to stay on an high frequency just
> > because of the blocked utilization of a CPU not being properly decayed
> > while the CPU was idle.
> > 
> > However, since:
> > 
> >    commit 31e77c93e432 ("sched/fair: Update blocked load when newly idle")
> > 
> > the FAIR blocked utilization is properly decayed also for IDLE CPUs.
> > 
> > This allows us to use the FAIR blocked utilization as a safe mechanism
> > to gracefully reduce the frequency only if no FAIR tasks show up on a
> > CPU for a reasonable period of time.
> > 
> > Moreover, we also reduce the frequency drops of CPUs running periodic
> > tasks which, depending on the task periodicity and the time required
> > for a frequency switch, was increasing the chances to introduce some
> > undesirable performance variations.
> > 
> > Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Joel Fernandes <joelaf@google.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> Do we need a Fixes tag and Cc stable ?

Mmm... no sure, I would say that's not a fix.

As I say in the changelog above, 8f111bc357aa was doing the correct
thing but, since the recent Vincent's commit 31e77c93e432, this is an
update worth to have, since now we can trust the decay of blocked
utilization.

Regarding stable, well... if Vincent patches are not going to be
considered for stable, then we should not consider this too, do we?

> > 
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index d2c6083304b4..a74d05160e66 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -183,22 +183,21 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
> >  static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> >  {
> >  	struct rq *rq = cpu_rq(sg_cpu->cpu);
> > -	unsigned long util;
> >  
> > -	if (rq->rt.rt_nr_running) {
> > -		util = sg_cpu->max;
> > -	} else {
> > -		util = sg_cpu->util_dl;
> > -		if (rq->cfs.h_nr_running)
> > -			util += sg_cpu->util_cfs;
> > -	}
> > +	if (rq->rt.rt_nr_running)
> > +		return sg_cpu->max;
> >  
> >  	/*
> > +	 * Utilization required by DEADLINE must always be granted while, for
> > +	 * FAIR, we use blocked utilization of IDLE CPUs as a mechanism to
> > +	 * gracefully reduce the frequency when no tasks show up for longer
> > +	 * periods of time.
> > +	 *
> >  	 * Ideally we would like to set util_dl as min/guaranteed freq and
> >  	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
> >  	 * ready for such an interface. So, we only do the latter for now.
> >  	 */
> > -	return min(util, sg_cpu->max);
> > +	return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
> >  }
> >  
> >  static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned int flags)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> -- 
> viresh

-- 
#include <best/regards.h>

Patrick Bellasi
