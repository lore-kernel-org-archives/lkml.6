Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968818AbeE3JcP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:32:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52946 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965350AbeE3JcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:32:08 -0400
Date: Wed, 30 May 2018 10:32:03 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v5 02/10] sched/rt: add rt_rq utilization tracking
Message-ID: <20180530093203.GG30654@e110439-lin>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-3-git-send-email-vincent.guittot@linaro.org>
 <20180525155437.GE30654@e110439-lin>
 <CAKfTPtCnJKmLajbeuXe71B-g5xC1vV2krrmG1TBB=pEnApR7cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCnJKmLajbeuXe71B-g5xC1vV2krrmG1TBB=pEnApR7cQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-May 15:29, Vincent Guittot wrote:
> Hi Patrick,
> >> +static inline bool rt_rq_has_blocked(struct rq *rq)
> >> +{
> >> +     if (rq->avg_rt.util_avg)
> >
> > Should use READ_ONCE?
> 
> I was expecting that there will be only one read by default but I can
> add READ_ONCE

I would say here it's required mainly for "documentation" purposes,
since we can use this function from non rq-locked paths, e.g.

   update_sg_lb_stats()
      update_nohz_stats()
         update_blocked_averages()
            rt_rq_has_blocked()

Thus, AFAIU, we should use READ_ONCE to "flag" that the value can
potentially be updated concurrently?

> >
> >> +             return true;
> >> +
> >> +     return false;
> >
> > What about just:
> >
> >        return READ_ONCE(rq->avg_rt.util_avg);
> >
> > ?
> 
> This function is renamed and extended with others tracking in the
> following patches so we have to test several values in the function.
> That's also why there is the if test because additional if test are
> going to be added

Right, makes sense.

[...]

> >> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> >> index ef3c4e6..b4148a9 100644
> >> --- a/kernel/sched/rt.c
> >> +++ b/kernel/sched/rt.c
> >> @@ -5,6 +5,8 @@
> >>   */
> >>  #include "sched.h"
> >>
> >> +#include "pelt.h"
> >> +
> >>  int sched_rr_timeslice = RR_TIMESLICE;
> >>  int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
> >>
> >> @@ -1572,6 +1574,9 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >>
> >>       rt_queue_push_tasks(rq);
> >>
> >> +     update_rt_rq_load_avg(rq_clock_task(rq), rq,
> >> +             rq->curr->sched_class == &rt_sched_class);
> >> +
> >>       return p;
> >>  }
> >>
> >> @@ -1579,6 +1584,8 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
> >>  {
> >>       update_curr_rt(rq);
> >>
> >> +     update_rt_rq_load_avg(rq_clock_task(rq), rq, 1);
> >> +
> >>       /*
> >>        * The previous task needs to be made eligible for pushing
> >>        * if it is still active
> >> @@ -2308,6 +2315,7 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
> >>       struct sched_rt_entity *rt_se = &p->rt;
> >>
> >>       update_curr_rt(rq);
> >> +     update_rt_rq_load_avg(rq_clock_task(rq), rq, 1);
> >
> > Mmm... not entirely sure... can't we fold
> >    update_rt_rq_load_avg() into update_curr_rt() ?
> >
> > Currently update_curr_rt() is used in:
> >    dequeue_task_rt
> >    pick_next_task_rt
> >    put_prev_task_rt
> >    task_tick_rt
> >
> > while we update_rt_rq_load_avg() only in:
> >    pick_next_task_rt
> >    put_prev_task_rt
> >    task_tick_rt
> > and
> >    update_blocked_averages
> >
> > Why we don't we need to update at dequeue_task_rt() time ?
> 
> We are tracking rt rq and not sched entities so we want to know when
> sched rt will be the running or not  sched class on the rq. Tracking
> dequeue_task_rt is useless

What about (push) migrations?

-- 
#include <best/regards.h>

Patrick Bellasi
