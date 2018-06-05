Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbeFENFx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:05:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55642 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751598AbeFENFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:05:52 -0400
Date: Tue, 5 Jun 2018 14:05:48 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v5 00/10] track CPU utilization
Message-ID: <20180605130548.GB12193@e108498-lin.cambridge.arm.com>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <CAKfTPtB0MHN3=VbS4mYqVH_0fv1WwKq6N1-ogU84mNUAxfCwjw@mail.gmail.com>
 <20180605105721.GA12193@e108498-lin.cambridge.arm.com>
 <20180605121153.GD16081@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605121153.GD16081@localhost.localdomain>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 Jun 2018 at 14:11:53 (+0200), Juri Lelli wrote:
> Hi Quentin,
> 
> On 05/06/18 11:57, Quentin Perret wrote:
> 
> [...]
> 
> > What about the diff below (just a quick hack to show the idea) applied
> > on tip/sched/core ?
> > 
> > ---8<---
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index a8ba6d1f262a..23a4fb1c2c25 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -180,9 +180,12 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
> >  	sg_cpu->util_dl  = cpu_util_dl(rq);
> >  }
> >  
> > +unsigned long scale_rt_capacity(int cpu);
> >  static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> >  {
> >  	struct rq *rq = cpu_rq(sg_cpu->cpu);
> > +	int cpu = sg_cpu->cpu;
> > +	unsigned long util, dl_bw;
> >  
> >  	if (rq->rt.rt_nr_running)
> >  		return sg_cpu->max;
> > @@ -197,7 +200,14 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> >  	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
> >  	 * ready for such an interface. So, we only do the latter for now.
> >  	 */
> > -	return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
> > +	util = arch_scale_cpu_capacity(NULL, cpu) * scale_rt_capacity(cpu);
> 
> Sorry to be pedantinc, but this (ATM) includes DL avg contribution, so,
> since we use max below, we will probably have the same problem that we
> discussed on Vincent's approach (overestimation of DL contribution while
> we could use running_bw).

Ah no, you're right, this isn't great for long running deadline tasks.
We should definitely account for the running_bw here, not the dl avg...

I was trying to address the issue of RT stealing time from CFS here, but
the DL integration isn't quite right which this patch as-is, I agree ...

> 
> > +	util >>= SCHED_CAPACITY_SHIFT;
> > +	util = arch_scale_cpu_capacity(NULL, cpu) - util;
> > +	util += sg_cpu->util_cfs;
> > +	dl_bw = (rq->dl.this_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
> 
> Why this_bw instead of running_bw?

So IIUC, this_bw should basically give you the absolute reservation (== the
sum of runtime/deadline ratios of all DL tasks on that rq).

The reason I added this max is because I'm still not sure to understand
how we can safely drop the freq below that point ? If we don't guarantee
to always stay at least at the freq required by DL, aren't we risking to
start a deadline tasks stuck at a low freq because of rate limiting ? In
this case, if that tasks uses all of its runtime then you might start
missing deadlines ...

My feeling is that the only safe thing to do is to guarantee to never go
below the freq required by DL, and to optimistically add CFS tasks
without raising the OPP if we have good reasons to think that DL is
using less than it required (which is what we should get by using
running_bw above I suppose). Does that make any sense ?

Thanks !
Quentin
