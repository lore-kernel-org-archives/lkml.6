Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeA3IA5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 03:00:57 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:37133 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbeA3IAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 03:00:55 -0500
X-Google-Smtp-Source: AH8x227aGFvr98pkpjcpRIvOfB+/d+/9rf3Pk2yOZR63CVEKSu/CfQx70F4vrYUnTtZZO9H3vD8gAV/L72MoCcJ+Jb8=
MIME-Version: 1.0
In-Reply-To: <b4ccaf05-36f7-fdde-dbb4-4ee98d2ebd7a@arm.com>
References: <20171222075934.f6yenvcb2zkf2ysd@hirez.programming.kicks-ass.net>
 <CAKfTPtC0+5zjvgNXMyVcvnnyJh0giQgJHtx+5p-GEpjUW1x8eg@mail.gmail.com>
 <20171222082915.4lcb7xyyooqyjpia@hirez.programming.kicks-ass.net>
 <20171222091221.ow5vn3ydx3hj4nht@hirez.programming.kicks-ass.net>
 <CAKfTPtAzutuyA7D2qOErKPwdFaRK082YAtVn4ci8hAOUvL3zMQ@mail.gmail.com>
 <20171222185629.lysjebfifgdwvvhu@hirez.programming.kicks-ass.net>
 <20171222204247.kyc6ugyyu3ei7zhs@hirez.programming.kicks-ass.net>
 <CAKfTPtD13p-n9otxq23rQZZKUfA1r03bxYBSDtSdm5HbWX7H6Q@mail.gmail.com>
 <20180115082609.GA6320@linaro.org> <20180118103807.GD28799@e105550-lin.cambridge.arm.com>
 <20180124082536.GA32318@linaro.org> <b4ccaf05-36f7-fdde-dbb4-4ee98d2ebd7a@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 30 Jan 2018 09:00:34 +0100
Message-ID: <CAKfTPtBbQ7HXetgSfEyFYyCNypYcRuSd_=H7xVs5P6LcTthGfQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] sched: Add NOHZ_STATS_KICK
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0U813YE006932

On 29 January 2018 at 19:43, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> On 01/24/2018 09:25 AM, Vincent Guittot wrote:
>>
>> Hi,
>>
>> Le Thursday 18 Jan 2018 à 10:38:07 (+0000), Morten Rasmussen a écrit :
>>>
>>> On Mon, Jan 15, 2018 at 09:26:09AM +0100, Vincent Guittot wrote:
>>>>
>>>> Le Wednesday 03 Jan 2018 à 10:16:00 (+0100), Vincent Guittot a écrit :
>
>
> [...]
>
>
>>>>
>>>> Hi Peter,
>>>>
>>>> With the patch below on top of your branch, the blocked loads are
>>>> updated and
>>>> decayed regularly. The main differences are:
>>>> - It doesn't use a timer to trig ilb but the tick and when a cpu becomes
>>>> idle.
>>>>    The main drawback of this solution is that the load is blocked when
>>>> the
>>>>    system is fully idle with the advantage of not waking up a fully idle
>>>>    system. We have to wait for the next tick or newly idle event for
>>>> updating
>>>>    blocked load when the system leaves idle stat which can be up to a
>>>> tick long.
>>>>    If this is too long, we can check for kicking ilb when task wakes up
>>>> so the
>>>>    blocked load will be updated as soon as the system leaves idle state.
>>>>    The main advantage is that we don't wake up a fully idle system every
>>>> 32ms to
>>>>    update blocked load that will be not used.
>>>> - I'm working on one more improvement to use nohz_idle_balance in the
>>>> newly
>>>>    idle case when the system is not overloaded and
>>>>    (this_rq->avg_idle > sysctl_sched_migration_cost). In this case, we
>>>> can try to
>>>>    use nohz_idle_balance with NOHZ_STATS_KICK and abort as soon as it
>>>> exceed
>>>>    this_rq->avg_idle. This will remove some calls to kick_ilb and some
>>>> wake up
>>>>    of an idle cpus.
>>>
>>>
>>> This sound like what I meant in my other reply :-)
>>>
>>> It seems pointless to have a timer to update PELT if the system is
>>> completely idle, and when it isn't we can piggy back other events to
>>> make the updates happen.
>>
>>
>> The patch below implements what has been described above. It calls part of
>> nohz_idle_balance when a cpu becomes idle and kick a ilb if it takes too
>> much
>> time. This removes part of ilb that are kicked on an idle cpu for updating
>> the blocked load but the ratio really depends on when the tick happens
>> compared
>> to a cpu becoming idle and the 32ms boundary. I have an additionnal patch
>> that
>> enables to update the blocked loads when a cpu becomes idle 1 period
>> before
>> kicking an ilb and there is far less ilb because we give more chance to
>> the
>> newly idle case (time_after is replaced by time_after_eq in
>> idle_balance()).
>>
>> The patch also uses a function cfs_rq_has_blocked, which only checks the
>> util/load_avg, instead of the cfs_rq_is_decayed which check *_sum too.
>> This
>> reduce significantly the number of update of blocked load. the *_avg will
>> be
>> fully decayed in around 300~400ms but it's far longer for the *_sum which
>> have
>> a higher resolution and we can easily reach almost seconds. But only the
>> *_avg
>> are used to make decision so keeping some blocked *_sum is acceptable.
>>
>> ---
>>   kernel/sched/fair.c | 121
>> +++++++++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 92 insertions(+), 29 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 898785d..ed90303 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7356,6 +7356,17 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq
>> *cfs_rq)
>>         return true;
>>   }
>>   +static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
>> +{
>> +       if (cfs_rq->avg.load_avg)
>> +               return true;
>> +
>> +       if (cfs_rq->avg.util_avg)
>> +               return true;
>> +
>> +       return false;
>> +}
>> +
>
>
> Can we not change cfs_rq_is_decayed() to use avg.foo_avg instead of
> avg.foo_sum ?

I don't think so because the *_sum are used to keep coherency bewteen
cfs_rq and cgroups when task migrates and are enqueued/dequeued so wwe
can't remove it until the *_sum are null otherwise the all cfs_rq and
group will be out of sync

>
>>   #ifdef CONFIG_FAIR_GROUP_SCHED
>>     static void update_blocked_averages(int cpu)
>> @@ -7393,7 +7404,9 @@ static void update_blocked_averages(int cpu)
>>                  */
>>                 if (cfs_rq_is_decayed(cfs_rq))
>>                         list_del_leaf_cfs_rq(cfs_rq);
>> -               else
>> +
>> +               /* Don't need periodic decay once load/util_avg are null
>> */
>> +               if (cfs_rq_has_blocked(cfs_rq))
>>                         done = false;
>>         }
>>   @@ -7463,7 +7476,7 @@ static inline void update_blocked_averages(int
>> cpu)
>>         update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
>>   #ifdef CONFIG_NO_HZ_COMMON
>>         rq->last_blocked_load_update_tick = jiffies;
>> -       if (cfs_rq_is_decayed(cfs_rq))
>> +       if (cfs_rq_has_blocked(cfs_rq))
>
>
> Schouldn't this be !cfs_rq_has_blocked(cfs_rq) ?

yes. I copy/pasted too quickly from sched_group_fair to not sched_group_fair

>
>>                 rq->has_blocked_load = 0;
>>   #endif
>>         rq_unlock_irqrestore(rq, &rf);
>
>
> [...]
>
>
>> @@ -9438,7 +9451,17 @@ static bool nohz_idle_balance(struct rq *this_rq,
>> enum cpu_idle_type idle)
>>                  */
>>                 if (need_resched()) {
>>                         has_blocked_load = true;
>> -                       break;
>> +                       goto abort;
>> +               }
>> +
>> +               /*
>> +                * If the update is done while CPU becomes idle, we abort
>> +                * the update when its cost is higher than the average
>> idle
>> +                * time in orde to not delay a possible wake up.
>> +                */
>> +               if (idle == CPU_NEWLY_IDLE && this_rq->avg_idle <
>> curr_cost) {
>> +                       has_blocked_load = true;
>> +                       goto abort;
>>                 }
>>                 rq = cpu_rq(balance_cpu);
>> @@ -9453,10 +9476,10 @@ static bool nohz_idle_balance(struct rq *this_rq,
>> enum cpu_idle_type idle)
>>                 if (time_after_eq(jiffies, rq->next_balance)) {
>>                         struct rq_flags rf;
>>   -                     rq_lock_irq(rq, &rf);
>> +                       rq_lock_irqsave(rq, &rf);
>>                         update_rq_clock(rq);
>>                         cpu_load_update_idle(rq);
>> -                       rq_unlock_irq(rq, &rf);
>> +                       rq_unlock_irqrestore(rq, &rf);
>>                         if (flags & NOHZ_BALANCE_KICK)
>>                                 rebalance_domains(rq, CPU_IDLE);
>> @@ -9466,10 +9489,17 @@ static bool nohz_idle_balance(struct rq *this_rq,
>> enum cpu_idle_type idle)
>>                         next_balance = rq->next_balance;
>>                         update_next_balance = 1;
>>                 }
>
>
> Why do you do this cpu_load_update_idle(rq) even this was called with
> CPU_NEWLY_IDLE? Wouldn't it be sufficient to jump to the curr_cost
> calculation in this case?

just to keep thing similar to what happen with kick_ilb and that's an
occasion to also update the cpu_load

>
>> +
>> +               domain_cost = sched_clock_cpu(this_cpu) - t0;
>> +               curr_cost += domain_cost;
>> +
>>         }
>>   -     update_blocked_averages(this_cpu);
>> -       has_blocked_load |= this_rq->has_blocked_load;
>> +       /* Newly idle CPU doesn't need an update */
>> +       if (idle != CPU_NEWLY_IDLE) {
>> +               update_blocked_averages(this_cpu);
>> +               has_blocked_load |= this_rq->has_blocked_load;
>> +       }
>>         if (flags & NOHZ_BALANCE_KICK)
>>                 rebalance_domains(this_rq, CPU_IDLE);
>
>
> [...]
