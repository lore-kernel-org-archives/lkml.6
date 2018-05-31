Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754131AbeEaIqQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 04:46:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54495 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754040AbeEaIqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 04:46:12 -0400
X-Google-Smtp-Source: ADUXVKIkEvVselM8ZR31ea3uvAYT7GZ4oQoPn16YND5pvZNARM+a6doF7vz5I5PQxRofwqHaKp4hnw==
Date: Thu, 31 May 2018 10:46:07 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Quentin Perret <quentin.perret@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com
Subject: Re: [PATCH v5 03/10] cpufreq/schedutil: add rt utilization tracking
Message-ID: <20180531084607.GB17937@localhost.localdomain>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-4-git-send-email-vincent.guittot@linaro.org>
 <20180530164601.GC2174@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530164601.GC2174@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/18 17:46, Quentin Perret wrote:
> Hi Vincent,
> 
> On Friday 25 May 2018 at 15:12:24 (+0200), Vincent Guittot wrote:
> > Add both cfs and rt utilization when selecting an OPP for cfs tasks as rt
> > can preempt and steal cfs's running time.
> > 
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 28592b6..a84b5a5 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -56,6 +56,7 @@ struct sugov_cpu {
> >  	/* The fields below are only needed when sharing a policy: */
> >  	unsigned long		util_cfs;
> >  	unsigned long		util_dl;
> > +	unsigned long		util_rt;
> >  	unsigned long		max;
> >  
> >  	/* The field below is for single-CPU policies only: */
> > @@ -178,14 +179,21 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
> >  	sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
> >  	sg_cpu->util_cfs = cpu_util_cfs(rq);
> >  	sg_cpu->util_dl  = cpu_util_dl(rq);
> > +	sg_cpu->util_rt  = cpu_util_rt(rq);
> >  }
> >  
> >  static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
> >  {
> >  	struct rq *rq = cpu_rq(sg_cpu->cpu);
> > +	unsigned long util;
> >  
> > -	if (rq->rt.rt_nr_running)
> > -		return sg_cpu->max;
> > +	if (rq->rt.rt_nr_running) {
> > +		util = sg_cpu->max;
> 
> So I understand why we want to got to max freq when a RT task is running,
> but I think there are use cases where we might want to be more conservative
> and use the util_avg of the RT rq instead. The first use case is
> battery-powered devices where going to max isn't really affordable from
> an energy standpoint. Android, for example, has been using a RT
> utilization signal to select OPPs for quite a while now, because going
> to max blindly is _very_ expensive.
> 
> And the second use-case is thermal pressure. On some modern CPUs, going to
> max freq can lead to stringent thermal capping very quickly, at the
> point where your CPUs might not have enough capacity to serve your tasks
> properly. And that can ultimately hurt the very RT tasks you originally
> tried to run fast. In these systems, in the long term, you'd be better off
> not asking for more than what you really need ...

Proposed the same at last LPC. Peter NAKed it (since RT is all about
meeting deadlines, and when using FIFO/RR we don't really know how fast
the CPU should go to meet them, so go to max is the only safe decision).

> So what about having a sched_feature to select between going to max and
> using the RT util_avg ? Obviously the default should keep the current
> behaviour.

Peter, would SCHED_FEAT make a difference? :)

Or Patrick's utilization capping applied to RT..
