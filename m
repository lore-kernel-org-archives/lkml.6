Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934446AbeE2NaW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:30:22 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:56183 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934084AbeE2NaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:30:19 -0400
X-Google-Smtp-Source: ADUXVKKFnh5kX2UXOaizaJ7LXe464+uMw4Ib2WhMkAqnqSe22iK/RaoutQt6d6oT2KqXtuJ803rzaszDc1VzF8vMNKI=
MIME-Version: 1.0
In-Reply-To: <20180525155437.GE30654@e110439-lin>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-3-git-send-email-vincent.guittot@linaro.org> <20180525155437.GE30654@e110439-lin>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 29 May 2018 15:29:57 +0200
Message-ID: <CAKfTPtCnJKmLajbeuXe71B-g5xC1vV2krrmG1TBB=pEnApR7cQ@mail.gmail.com>
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

Hi Patrick,

On 25 May 2018 at 17:54, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> On 25-May 15:12, Vincent Guittot wrote:
>> schedutil governor relies on cfs_rq's util_avg to choose the OPP when cfs
>                                                                        ^
>                                                                      only
> otherwise, while RT tasks are running we go to max.
>
>> tasks are running.
>> When the CPU is overloaded by cfs and rt tasks, cfs tasks
>                   ^^^^^^^^^^
> I would say we always have the provlem whenever an RT task preempt a
> CFS one, even just for few ms, isn't it?

The problem only happens when there is not enough time to run all
tasks (rt and cfs). If the cfs task is preempted few ms and the main
impact is only a delay in its execution but there is still enough time
to do cfs jobs (cpu goes back to idle from time to time), there is no
"real" problem. At now, it means that it's not a problem as long as
the rt task doesn't take more than the margin that schedutil uses to
select a frequency : (max freq + max freq >> 2) util /max capacity

>
>> are preempted by rt tasks and in this case util_avg reflects the remaining
>> capacity but not what cfs want to use. In such case, schedutil can select a
>> lower OPP whereas the CPU is overloaded. In order to have a more accurate
>> view of the utilization of the CPU, we track the utilization that is
>> "stolen" by rt tasks.
>>
>> rt_rq uses rq_clock_task and cfs_rq uses cfs_rq_clock_task but they are
>> the same at the root group level, so the PELT windows of the util_sum are
>> aligned.
>>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> ---
>>  kernel/sched/fair.c  | 15 ++++++++++++++-
>>  kernel/sched/pelt.c  | 23 +++++++++++++++++++++++
>>  kernel/sched/pelt.h  |  7 +++++++
>>  kernel/sched/rt.c    |  8 ++++++++
>>  kernel/sched/sched.h |  7 +++++++
>>  5 files changed, 59 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 6390c66..fb18bcc 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7290,6 +7290,14 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
>>       return false;
>>  }
>>
>> +static inline bool rt_rq_has_blocked(struct rq *rq)
>> +{
>> +     if (rq->avg_rt.util_avg)
>
> Should use READ_ONCE?

I was expecting that there will be only one read by default but I can
add READ_ONCE

>
>> +             return true;
>> +
>> +     return false;
>
> What about just:
>
>        return READ_ONCE(rq->avg_rt.util_avg);
>
> ?

This function is renamed and extended with others tracking in the
following patches so we have to test several values in the function.
That's also why there is the if test because additional if test are
going to be added

>
>> +}
>> +
>>  #ifdef CONFIG_FAIR_GROUP_SCHED
>>
>>  static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>> @@ -7349,6 +7357,10 @@ static void update_blocked_averages(int cpu)
>>               if (cfs_rq_has_blocked(cfs_rq))
>>                       done = false;
>>       }
>> +     update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
>> +     /* Don't need periodic decay once load/util_avg are null */
>> +     if (rt_rq_has_blocked(rq))
>> +             done = false;
>>
>>  #ifdef CONFIG_NO_HZ_COMMON
>>       rq->last_blocked_load_update_tick = jiffies;
>> @@ -7414,9 +7426,10 @@ static inline void update_blocked_averages(int cpu)
>>       rq_lock_irqsave(rq, &rf);
>>       update_rq_clock(rq);
>>       update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
>> +     update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
>>  #ifdef CONFIG_NO_HZ_COMMON
>>       rq->last_blocked_load_update_tick = jiffies;
>> -     if (!cfs_rq_has_blocked(cfs_rq))
>> +     if (!cfs_rq_has_blocked(cfs_rq) && !rt_rq_has_blocked(rq))
>>               rq->has_blocked_load = 0;
>>  #endif
>>       rq_unlock_irqrestore(rq, &rf);
>> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
>> index e6ecbb2..213b922 100644
>> --- a/kernel/sched/pelt.c
>> +++ b/kernel/sched/pelt.c
>> @@ -309,3 +309,26 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq)
>>
>>       return 0;
>>  }
>> +
>> +/*
>> + * rt_rq:
>> + *
>> + *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
>> + *   util_sum = cpu_scale * load_sum
>> + *   runnable_load_sum = load_sum
>> + *
>> + */
>> +
>> +int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
>> +{
>> +     if (___update_load_sum(now, rq->cpu, &rq->avg_rt,
>> +                             running,
>> +                             running,
>> +                             running)) {
>> +
>
> Not needed empty line?

yes probably.

This empty is coming from the copy/paste of __update_load_avg_cfs_rq()
I will consolidate this in the next version

>
>> +             ___update_load_avg(&rq->avg_rt, 1, 1);
>> +             return 1;
>> +     }
>> +
>> +     return 0;
>> +}
>> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
>> index 9cac73e..b2983b7 100644
>> --- a/kernel/sched/pelt.h
>> +++ b/kernel/sched/pelt.h
>> @@ -3,6 +3,7 @@
>>  int __update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se);
>>  int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_entity *se);
>>  int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
>> +int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
>>
>>  /*
>>   * When a task is dequeued, its estimated utilization should not be update if
>> @@ -38,6 +39,12 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>>       return 0;
>>  }
>>
>> +static inline int
>> +update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
>> +{
>> +     return 0;
>> +}
>> +
>>  #endif
>>
>>
>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index ef3c4e6..b4148a9 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -5,6 +5,8 @@
>>   */
>>  #include "sched.h"
>>
>> +#include "pelt.h"
>> +
>>  int sched_rr_timeslice = RR_TIMESLICE;
>>  int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
>>
>> @@ -1572,6 +1574,9 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>>
>>       rt_queue_push_tasks(rq);
>>
>> +     update_rt_rq_load_avg(rq_clock_task(rq), rq,
>> +             rq->curr->sched_class == &rt_sched_class);
>> +
>>       return p;
>>  }
>>
>> @@ -1579,6 +1584,8 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
>>  {
>>       update_curr_rt(rq);
>>
>> +     update_rt_rq_load_avg(rq_clock_task(rq), rq, 1);
>> +
>>       /*
>>        * The previous task needs to be made eligible for pushing
>>        * if it is still active
>> @@ -2308,6 +2315,7 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
>>       struct sched_rt_entity *rt_se = &p->rt;
>>
>>       update_curr_rt(rq);
>> +     update_rt_rq_load_avg(rq_clock_task(rq), rq, 1);
>
> Mmm... not entirely sure... can't we fold
>    update_rt_rq_load_avg() into update_curr_rt() ?
>
> Currently update_curr_rt() is used in:
>    dequeue_task_rt
>    pick_next_task_rt
>    put_prev_task_rt
>    task_tick_rt
>
> while we update_rt_rq_load_avg() only in:
>    pick_next_task_rt
>    put_prev_task_rt
>    task_tick_rt
> and
>    update_blocked_averages
>
> Why we don't we need to update at dequeue_task_rt() time ?

We are tracking rt rq and not sched entities so we want to know when
sched rt will be the running or not  sched class on the rq. Tracking
dequeue_task_rt is useless

>
>>
>>       watchdog(rq, p);
>>
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 757a3ee..7a16de9 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -592,6 +592,7 @@ struct rt_rq {
>>       unsigned long           rt_nr_total;
>>       int                     overloaded;
>>       struct plist_head       pushable_tasks;
>> +
>>  #endif /* CONFIG_SMP */
>>       int                     rt_queued;
>>
>> @@ -847,6 +848,7 @@ struct rq {
>>
>>       u64                     rt_avg;
>>       u64                     age_stamp;
>> +     struct sched_avg        avg_rt;
>>       u64                     idle_stamp;
>>       u64                     avg_idle;
>>
>> @@ -2205,4 +2207,9 @@ static inline unsigned long cpu_util_cfs(struct rq *rq)
>>
>>       return util;
>>  }
>> +
>> +static inline unsigned long cpu_util_rt(struct rq *rq)
>> +{
>> +     return rq->avg_rt.util_avg;
>
> READ_ONCE?
>
>> +}
>>  #endif
>> --
>> 2.7.4
>>
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
