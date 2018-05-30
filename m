Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932132AbeE3Spi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 14:45:38 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34483 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932077AbeE3Spg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 14:45:36 -0400
X-Google-Smtp-Source: ADUXVKL7JX4q92YMfHCBUcEqs7soDDOsCNHTDPZ5Bth9p2KwCBBeFwF0K+oLO756zITIEMGxL0KMDSRFYEkB0xhgiOs=
MIME-Version: 1.0
In-Reply-To: <72473e6f-8ade-8e26-3282-276fcae4c4c7@arm.com>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-8-git-send-email-vincent.guittot@linaro.org> <72473e6f-8ade-8e26-3282-276fcae4c4c7@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 30 May 2018 20:45:15 +0200
Message-ID: <CAKfTPtC8c9sP7TjefZPN2SFuNVGS7Q12WBj3BBYEbJFzxVN-2A@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] sched/irq: add irq utilization tracking
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On 30 May 2018 at 17:55, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> On 05/25/2018 03:12 PM, Vincent Guittot wrote:
>>
>> interrupt and steal time are the only remaining activities tracked by
>> rt_avg. Like for sched classes, we can use PELT to track their average
>> utilization of the CPU. But unlike sched class, we don't track when
>> entering/leaving interrupt; Instead, we take into account the time spent
>> under interrupt context when we update rqs' clock (rq_clock_task).
>> This also means that we have to decay the normal context time and account
>> for interrupt time during the update.
>>
>> That's also important to note that because
>>    rq_clock == rq_clock_task + interrupt time
>> and rq_clock_task is used by a sched class to compute its utilization, the
>> util_avg of a sched class only reflects the utilization of the time spent
>> in normal context and not of the whole time of the CPU. The utilization of
>> interrupt gives an more accurate level of utilization of CPU.
>> The CPU utilization is :
>>    avg_irq + (1 - avg_irq / max capacity) * /Sum avg_rq
>>
>> Most of the time, avg_irq is small and neglictible so the use of the
>> approximation CPU utilization = /Sum avg_rq was enough
>
>
> [...]
>
>> @@ -7362,6 +7363,7 @@ static void update_blocked_averages(int cpu)
>>         }
>>         update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
>>         update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
>> +       update_irq_load_avg(rq, 0);
>
>
> So this one decays the signals only in case the update_rq_clock_task()
> didn't call update_irq_load_avg() because 'irq_delta + steal' is 0, right?

yes

>
> [...]
>
>
>> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
>> index 3d5bd3a..d2e4f21 100644
>> --- a/kernel/sched/pelt.c
>> +++ b/kernel/sched/pelt.c
>> @@ -355,3 +355,41 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int
>> running)
>>         return 0;
>>   }
>> +
>> +/*
>> + * irq:
>> + *
>> + *   util_sum = \Sum se->avg.util_sum but se->avg.util_sum is not tracked
>> + *   util_sum = cpu_scale * load_sum
>> + *   runnable_load_sum = load_sum
>> + *
>> + */
>> +
>> +int update_irq_load_avg(struct rq *rq, u64 running)
>> +{
>> +       int ret = 0;
>> +       /*
>> +        * We know the time that has been used by interrupt since last
>> update
>> +        * but we don't when. Let be pessimistic and assume that interrupt
>> has
>> +        * happened just before the update. This is not so far from
>> reality
>> +        * because interrupt will most probably wake up task and trig an
>> update
>> +        * of rq clock during which the metric si updated.
>> +        * We start to decay with normal context time and then we add the
>> +        * interrupt context time.
>> +        * We can safely remove running from rq->clock because
>> +        * rq->clock += delta with delta >= running
>
>
> This is true as long update_irq_load_avg() with a 'running != 0' is called
> only after rq->clock moved forward (rq->clock += delta) (which is true for
> update_rq_clock()->update_rq_clock_task()).

yes

>
>> +        */
>> +       ret = ___update_load_sum(rq->clock - running, rq->cpu,
>> &rq->avg_irq,
>> +                               0,
>> +                               0,
>> +                               0);
>> +       ret += ___update_load_sum(rq->clock, rq->cpu, &rq->avg_irq,
>> +                               1,
>> +                               1,
>> +                               1);
>
>
> So you decay the signal in [sa->lut, rq->clock - running] (assumed to be the
> portion of delta used by the task scheduler) and you increase it in
> [rq->clock - running, rq->clock] (irq and virt portion of delta).
>
> That means that this signal is updated on rq->clock whereas the others are
> on rq->clock_task.
>
> What about the ever growing clock diff between them? I see e.g ~6s after
> 20min uptime and up to 1.5ms 'running'.
>
> It should be still safe to sum the sched class and irq signal in
> sugov_aggregate_util() because they are independent, I guess.

yes. the formula is explained in patch "cpufreq/schedutil: take into
account interrupt"


>
> [...]
