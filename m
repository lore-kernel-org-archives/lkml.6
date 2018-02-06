Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752746AbeBFQRz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:17:55 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:35545 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752222AbeBFQRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:17:46 -0500
X-Google-Smtp-Source: AH8x224VERHTJ0XPHCi9WhzHtSZXnZqcSbqz9y7rpcgian++g4Gen0hd+r0G9oVEAQ2CfrxOw+dhuUxIRQzuW9HgkKc=
MIME-Version: 1.0
In-Reply-To: <2e84ae36-9fb7-2fc5-3acd-45b362b6fb94@arm.com>
References: <20180201181041.GF2269@hirez.programming.kicks-ass.net>
 <1517905943-24528-1-git-send-email-vincent.guittot@linaro.org>
 <1517905943-24528-3-git-send-email-vincent.guittot@linaro.org> <2e84ae36-9fb7-2fc5-3acd-45b362b6fb94@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 6 Feb 2018 17:17:25 +0100
Message-ID: <CAKfTPtB4Te+CvCZx2HwuZKX-HOyCgJryFq8300dZTMCW=jtKqA@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched: update blocked load when newly idle
To: Valentin Schneider <valentin.schneider@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 February 2018 at 15:32, Valentin Schneider
<valentin.schneider@arm.com> wrote:
> Hi Vincent,
>
> On 02/06/2018 08:32 AM, Vincent Guittot wrote:
>> When NEWLY_IDLE load balance is not triggered, we might need to update the
>> blocked load anyway. We can kick an ilb so an idle CPU will take care of
>> updating blocked load or we can try to update them locally before entering
>> idle. In the latter case, we reuse part of the nohz_idle_balance.
>>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> ---
>>  kernel/sched/fair.c | 102 ++++++++++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 84 insertions(+), 18 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 6998528..256defe 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8829,6 +8829,9 @@ update_next_balance(struct sched_domain *sd, unsigned long *next_balance)
>>               *next_balance = next;
>>  }
>>
>> +static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags, enum cpu_idle_type idle);
>> +static void kick_ilb(unsigned int flags);
>> +
>>  /*
>>   * idle_balance is called by schedule() if this_cpu is about to become
>>   * idle. Attempts to pull tasks from other CPUs.
>> @@ -8863,12 +8866,26 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>>
>>       if (this_rq->avg_idle < sysctl_sched_migration_cost ||
>>           !this_rq->rd->overload) {
>> +             unsigned long has_blocked = READ_ONCE(nohz.has_blocked);
>> +             unsigned long next = READ_ONCE(nohz.next_blocked);
>
> Ditto on 'next' - there's next_balance referenced in here so it'd be nice to make clear which is which.
>
>> +
>>               rcu_read_lock();
>>               sd = rcu_dereference_check_sched_domain(this_rq->sd);
>>               if (sd)
>>                       update_next_balance(sd, &next_balance);
>>               rcu_read_unlock();
>>
>> +             /*
>> +              * Update blocked idle load if it has not been done for a
>> +              * while. Try to do it locally before entering idle but kick a
>> +              * ilb if it takes too much time and/or might delay next local
>> +              * wake up
>> +              */
>> +             if (has_blocked && time_after_eq(jiffies, next) &&
>> +                             (this_rq->avg_idle < sysctl_sched_migration_cost ||
>> +                             !_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE)))
>
> "this_rq->avg_idle < sysctl_sched_migration_cost" is used twice now, how about storing it in an "idle_too_short" variable ?

In fact it's already the 3rd time
Why do you want it to be stored in an "idle_too_short" variable ?

>
>> +                     kick_ilb(NOHZ_STATS_KICK);
>> +
>>               goto out;
>>       }
>>
>> @@ -9393,30 +9410,24 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
>>
>>  #ifdef CONFIG_NO_HZ_COMMON
>>  /*
>> - * In CONFIG_NO_HZ_COMMON case, the idle balance kickee will do the
>> - * rebalancing for all the cpus for whom scheduler ticks are stopped.
>> + * Internal function that runs load balance for all idle cpus. The load balance
>> + * can be a simple update of blocked load or a complete load balance with
>> + * tasks movement depending of flags.
>> + * For newly idle mode, we abort the loop if it takes too much time and return
>> + * false to notify that the loop has not be completed and a ilb should be kick.
>>   */
>> -static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>> +static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags, enum cpu_idle_type idle)
>>  {
>>       /* Earliest time when we have to do rebalance again */
>>       unsigned long now = jiffies;
>>       unsigned long next_balance = now + 60*HZ;
>> -     unsigned long next_stats = now + msecs_to_jiffies(LOAD_AVG_PERIOD);
>> +     bool has_blocked_load = false;
>>       int update_next_balance = 0;
>>       int this_cpu = this_rq->cpu;
>> -     unsigned int flags;
>>       int balance_cpu;
>> +     int ret = false;
>>       struct rq *rq;
>> -
>> -     if (!(atomic_read(nohz_flags(this_cpu)) & NOHZ_KICK_MASK))
>> -             return false;
>> -
>> -     if (idle != CPU_IDLE) {
>> -             atomic_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
>> -             return false;
>> -     }
>> -
>> -     flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
>> +     u64 curr_cost = 0;
>>
>>       SCHED_WARN_ON((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
>>
>> @@ -9431,6 +9442,10 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>>       WRITE_ONCE(nohz.has_blocked, 0);
>>
>>       for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
>> +             u64 t0, domain_cost;
>> +
>> +             t0 = sched_clock_cpu(this_cpu);
>> +
>>               if (balance_cpu == this_cpu || !idle_cpu(balance_cpu))
>>                       continue;
>>
>> @@ -9444,6 +9459,16 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>>                       goto abort;
>>               }
>>
>> +             /*
>> +              * If the update is done while CPU becomes idle, we abort
>> +              * the update when its cost is higher than the average idle
>> +              * time in orde to not delay a possible wake up.
>> +              */
>> +             if (idle == CPU_NEWLY_IDLE && this_rq->avg_idle < curr_cost) {
>> +                     has_blocked_load = true;
>> +                     goto abort;
>> +             }
>> +
>>               rq = cpu_rq(balance_cpu);
>>
>>               update_blocked_averages(rq->cpu);
>> @@ -9456,10 +9481,10 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>>               if (time_after_eq(jiffies, rq->next_balance)) {
>>                       struct rq_flags rf;
>>
>> -                     rq_lock_irq(rq, &rf);
>> +                     rq_lock_irqsave(rq, &rf);
>>                       update_rq_clock(rq);
>>                       cpu_load_update_idle(rq);
>> -                     rq_unlock_irq(rq, &rf);
>> +                     rq_unlock_irqrestore(rq, &rf);
>>
>>                       if (flags & NOHZ_BALANCE_KICK)
>>                               rebalance_domains(rq, CPU_IDLE);
>> @@ -9469,15 +9494,27 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>>                       next_balance = rq->next_balance;
>>                       update_next_balance = 1;
>>               }
>> +
>> +             domain_cost = sched_clock_cpu(this_cpu) - t0;
>> +             curr_cost += domain_cost;
>> +
>> +     }
>> +
>> +     /* Newly idle CPU doesn't need an update */
>> +     if (idle != CPU_NEWLY_IDLE) {
>> +             update_blocked_averages(this_cpu);
>> +             has_blocked_load |= this_rq->has_blocked_load;
>>       }
>>
>> -     update_blocked_averages(this_cpu);
>>       if (flags & NOHZ_BALANCE_KICK)
>>               rebalance_domains(this_rq, CPU_IDLE);
>>
>>       WRITE_ONCE(nohz.next_blocked,
>>               now + msecs_to_jiffies(LOAD_AVG_PERIOD));
>>
>> +     /* The full idle balance loop has been done */
>> +     ret = true;
>> +
>>  abort:
>>       /* There is still blocked load, enable periodic update */
>>       if (has_blocked_load)
>> @@ -9491,6 +9528,35 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>>       if (likely(update_next_balance))
>>               nohz.next_balance = next_balance;
>>
>> +     return ret;
>> +}
>> +
>> +/*
>> + * In CONFIG_NO_HZ_COMMON case, the idle balance kickee will do the
>> + * rebalancing for all the cpus for whom scheduler ticks are stopped.
>> + */
>> +static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>> +{
>> +     int this_cpu = this_rq->cpu;
>> +     unsigned int flags;
>> +
>> +     if (!(atomic_read(nohz_flags(this_cpu)) & NOHZ_KICK_MASK))
>> +             return false;
>> +
>> +     if (idle != CPU_IDLE) {
>> +             atomic_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
>> +             return false;
>> +     }
>> +
>> +     /*
>> +      * barrier, pairs with nohz_balance_enter_idle(), ensures ...
>> +      */
>> +     flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(this_cpu));
>> +     if (!(flags & NOHZ_KICK_MASK))
>> +             return false;
>> +
>> +     _nohz_idle_balance(this_rq, flags, idle);
>> +
>>       return true;
>>  }
>>  #else
>>
