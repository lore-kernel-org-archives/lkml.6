Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeEKIlY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:41:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38038 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752165AbeEKIlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:41:22 -0400
Date: Fri, 11 May 2018 09:41:17 +0100
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
Subject: Re: [PATCH 2/3] sched/fair: util_est: update before schedutil
Message-ID: <20180511084117.GC30654@e110439-lin>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
 <20180510150553.28122-3-patrick.bellasi@arm.com>
 <20180511054439.slrpscgm6ivho5qy@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511054439.slrpscgm6ivho5qy@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-May 11:14, Viresh Kumar wrote:
> On 10-05-18, 16:05, Patrick Bellasi wrote:
> > When a task is enqueue the estimated utilization of a CPU is updated
> > to better support the selection of the required frequency.
> > However, schedutil is (implicitly) updated by update_load_avg() which
> > always happens before util_est_{en,de}queue(), thus potentially
> > introducing a latency between estimated utilization updates and
> > frequency selections.
> > 
> > Let's update util_est at the beginning of enqueue_task_fair(),
> > which will ensure that all schedutil updates will see the most
> > updated estimated utilization value for a CPU.
> > 
> > Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > ---
> >  kernel/sched/fair.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Fixes and Stable ?

Good idea, will add them.

> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1f6a23a5b451..01dfc47541e6 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5356,6 +5356,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  	struct cfs_rq *cfs_rq;
> >  	struct sched_entity *se = &p->se;
> >  
> > +	/* Estimated utilization must be updated before schedutil */
> > +	util_est_enqueue(&rq->cfs, p);
> > +
> >  	/*
> >  	 * If in_iowait is set, the code below may not trigger any cpufreq
> >  	 * utilization updates, so do it here explicitly with the IOWAIT flag
> > @@ -5397,7 +5400,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  	if (!se)
> >  		add_nr_running(rq, 1);
> >  
> > -	util_est_enqueue(&rq->cfs, p);
> >  	hrtick_update(rq);
> >  }
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> -- 
> viresh

-- 
#include <best/regards.h>

Patrick Bellasi
