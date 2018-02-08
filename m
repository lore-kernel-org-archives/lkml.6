Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeBHPGU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:06:20 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:32914 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeBHPGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:06:19 -0500
X-Google-Smtp-Source: AH8x224B6OCrIA7EbjpnpBw3msR6Zr+LTGFYqQB3wvgDcBLhHCWljjthQ609SZ2DngH8PC3mJnHN/NuWT7mbj6NMCgk=
MIME-Version: 1.0
In-Reply-To: <20180208140005.GH25201@hirez.programming.kicks-ass.net>
References: <1517944987-343-1-git-send-email-vincent.guittot@linaro.org>
 <1517944987-343-2-git-send-email-vincent.guittot@linaro.org> <20180208140005.GH25201@hirez.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 8 Feb 2018 16:05:58 +0100
Message-ID: <CAKfTPtB0dDmovt=iM=efXUG1EY7GnOAuTTCf0VqTvx08fatWeQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sched: Stop nohz stats when decayed
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 February 2018 at 15:00, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Feb 06, 2018 at 08:23:05PM +0100, Vincent Guittot wrote:
>
>> @@ -9207,13 +9231,15 @@ void nohz_balance_enter_idle(int cpu)
>>       if (!housekeeping_cpu(cpu, HK_FLAG_SCHED))
>>               return;
>>
>> +     rq->has_blocked_load = 1;
>> +
>>       if (rq->nohz_tick_stopped)
>> -             return;
>
> this case is difficult... needs thinking

The use case happens when a CPU wakes up and goes back to idle before
the tick fires and clears nohz_tick_stopped.

>
>> +             goto out;
>>
>>       /*
>>        * If we're a completely isolated CPU, we don't play.
>>        */
>> -     if (on_null_domain(cpu_rq(cpu)))
>> +     if (on_null_domain(rq))
>>               return;
>>
>>       rq->nohz_tick_stopped = 1;
>> @@ -9222,6 +9248,13 @@ void nohz_balance_enter_idle(int cpu)
>>       atomic_inc(&nohz.nr_cpus);
>>
>>       set_cpu_sd_state_idle(cpu);
>
>         /*
>          * Ensures that if nohz_idle_balance() fails to observe our
>          * @idle_cpus_mask store, it must observe the @has_blocked
>          * store.
>          */
>         smp_mb__after_atomic();
>
>> +
>> +out:
>> +     /*
>> +      * Each time a cpu enter idle, we assume that it has blocked load and
>> +      * enable the periodic update of the load of idle cpus
>> +      */
>> +     WRITE_ONCE(nohz.has_blocked, 1);
>>  }
>
>
>
>> @@ -9374,6 +9407,16 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>>
>>       SCHED_WARN_ON((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
>>
>> +     /*
>> +      * We assume there will be no idle load after this update and clear
>> +      * the has_blocked flag. If a cpu enters idle in the mean time, it will
>> +      * set the has_blocked flag and trig another update of idle load.
>> +      * Because a cpu that becomes idle, is added to idle_cpus_mask before
>> +      * setting the flag, we are sure to not clear the state and not
>> +      * check the load of an idle cpu.
>> +      */
>> +     WRITE_ONCE(nohz.has_blocked, 0);
>
>         /*
>          * Ensures that if we miss the CPU, we must see the has_blocked
>          * store from nohz_balance_enter_idle().
>          */
>         smp_mb();
>
>>       for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
>>               if (balance_cpu == this_cpu || !idle_cpu(balance_cpu))
>>                       continue;
>
>
> I _think_, but my brain isn't quite willing to turn on today.
>
> Without this ordering I think it would be possible to loose has_blocked
> and not observe the CPU either.

I think that you are right.
I also wondered if some barriers were necessary but wrongly concluded
that set operation on nohz.idle_cpus_mask and WRITE_ONCE with volatile
would be enough to ensure the right ordering

>
>
