Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753758AbeE3OkN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:40:13 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52863 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753272AbeE3OkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:40:10 -0400
X-Google-Smtp-Source: ADUXVKIa4E99q0N+7s3uxmVC/9uVJC2jSEy9IUwQNcRj0r3LkBAtJQArtUbOMtFeiQtyP9+EkgtuhFPbwW4XIYlzPPs=
MIME-Version: 1.0
In-Reply-To: <20180530110117.GJ30654@e110439-lin>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-3-git-send-email-vincent.guittot@linaro.org>
 <20180525155437.GE30654@e110439-lin> <CAKfTPtCnJKmLajbeuXe71B-g5xC1vV2krrmG1TBB=pEnApR7cQ@mail.gmail.com>
 <20180530093203.GG30654@e110439-lin> <CAKfTPtDmBHGWUpWk8SmbY=4HDDjRPCVRQ1dGAX7CK6FRuU_BQQ@mail.gmail.com>
 <20180530110117.GJ30654@e110439-lin>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 30 May 2018 16:39:48 +0200
Message-ID: <CAKfTPtCvo=qNo0Be97Ph3dGCu88_V2sm37nctVNgL+nNapH91w@mail.gmail.com>
Subject: Re: [PATCH v5 02/10] sched/rt: add rt_rq utilization tracking
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 May 2018 at 13:01, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> On 30-May 12:06, Vincent Guittot wrote:
>> On 30 May 2018 at 11:32, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>> > On 29-May 15:29, Vincent Guittot wrote:
>
> [...]
>
>> >> >> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> >> >> index ef3c4e6..b4148a9 100644
>> >> >> --- a/kernel/sched/rt.c
>> >> >> +++ b/kernel/sched/rt.c
>> >> >> @@ -5,6 +5,8 @@
>> >> >>   */
>> >> >>  #include "sched.h"
>> >> >>
>> >> >> +#include "pelt.h"
>> >> >> +
>> >> >>  int sched_rr_timeslice = RR_TIMESLICE;
>> >> >>  int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
>> >> >>
>> >> >> @@ -1572,6 +1574,9 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>> >> >>
>> >> >>       rt_queue_push_tasks(rq);
>> >> >>
>> >> >> +     update_rt_rq_load_avg(rq_clock_task(rq), rq,
>> >> >> +             rq->curr->sched_class == &rt_sched_class);
>> >> >> +
>> >> >>       return p;
>> >> >>  }
>> >> >>
>> >> >> @@ -1579,6 +1584,8 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
>> >> >>  {
>> >> >>       update_curr_rt(rq);
>> >> >>
>> >> >> +     update_rt_rq_load_avg(rq_clock_task(rq), rq, 1);
>> >> >> +
>> >> >>       /*
>> >> >>        * The previous task needs to be made eligible for pushing
>> >> >>        * if it is still active
>> >> >> @@ -2308,6 +2315,7 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
>> >> >>       struct sched_rt_entity *rt_se = &p->rt;
>> >> >>
>> >> >>       update_curr_rt(rq);
>> >> >> +     update_rt_rq_load_avg(rq_clock_task(rq), rq, 1);
>> >> >
>> >> > Mmm... not entirely sure... can't we fold
>> >> >    update_rt_rq_load_avg() into update_curr_rt() ?
>> >> >
>> >> > Currently update_curr_rt() is used in:
>> >> >    dequeue_task_rt
>> >> >    pick_next_task_rt
>> >> >    put_prev_task_rt
>> >> >    task_tick_rt
>> >> >
>> >> > while we update_rt_rq_load_avg() only in:
>> >> >    pick_next_task_rt
>> >> >    put_prev_task_rt
>> >> >    task_tick_rt
>> >> > and
>> >> >    update_blocked_averages
>> >> >
>> >> > Why we don't we need to update at dequeue_task_rt() time ?
>> >>
>> >> We are tracking rt rq and not sched entities so we want to know when
>> >> sched rt will be the running or not  sched class on the rq. Tracking
>> >> dequeue_task_rt is useless
>> >
>> > What about (push) migrations?
>>
>> it doesn't make any difference. put_prev_task_rt() says that the prev
>> task that was running, was a rt task so we can account past time at rt
>> running time
>> and pick_next_task_rt says that the next one will be a rt task so we
>> have to account elapse time either to rt or not rt time according.
>
> Right, I was missing that you are tracking RT (and DL) only at RQ
> level... not SE level, thus we will not see migrations of blocked
> utilization.
>
>> I can probably optimize the pick_next_task_rt by doing the below instead:
>>
>> if (rq->curr->sched_class == &rt_sched_class)
>>        update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
>>
>> If prev task is a rt  task, put_prev_task_rt has already done the update
>
> Right.
>
> Just one more question about non tracking SE. Once we migrate an RT
> task with the current solution we will have to wait for it's PELT
> blocked utilization to decay completely before starting to ignore that
> task contribution, which means that:
>  1. we will see an higher utilization on the original CPU
>  2. we don't immediately see the increased utilization on the
>     destination CPU
>
> I remember Juri had some patches to track SE utilization thus fixing
> the two issues above. Can you remember me why we decided to go just
> for the RQ tracking solution?

I would say that one main reason is the overhead of tracking per SE

Then, what we want to track the other class utilization to replace
current rt_avg.

And we want something to track steal time of cfs to compensate the
fact that cfs util_avg will be lower than what cfs really needs.
so we really want rt util_avg to smoothly decrease if a rt task
migrate to let time to cfs util_avg to smoothly increase itself as cfs
tasks will run more often.

Based on some discussion on IRC, I'm studying how to track more
accurately the stolen time

> Don't we expect any strange behaviors on real systems when RT tasks
> are moved around?

Which kind of strange behavior ? we don't use rt util_avg for OPP
selection when a rt task is running

>
> Perhaps we should run some tests on Android...
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
