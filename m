Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933419AbeBLJwd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:52:33 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:42075 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932505AbeBLJwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:52:32 -0500
X-Google-Smtp-Source: AH8x225NsPE7ch7J7pI/xT8ACvmdiwb+/wyOAnbreg8DEsikif0cKZm9sa15NF4kyQicsyUKgp1m0aMUXuWdKIf8fgs=
MIME-Version: 1.0
In-Reply-To: <20180212094115.GS25201@hirez.programming.kicks-ass.net>
References: <1518422874-13216-1-git-send-email-vincent.guittot@linaro.org>
 <1518422874-13216-2-git-send-email-vincent.guittot@linaro.org> <20180212094115.GS25201@hirez.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 12 Feb 2018 10:52:11 +0100
Message-ID: <CAKfTPtDGSOhK6Ly6So6EXjComTb==Rd1Bbt79syOtjsBnN5avQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] sched: Stop nohz stats when decayed
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 February 2018 at 10:41, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Feb 12, 2018 at 09:07:52AM +0100, Vincent Guittot wrote:
>> @@ -9222,6 +9259,20 @@ void nohz_balance_enter_idle(int cpu)
>>       atomic_inc(&nohz.nr_cpus);
>>
>>       set_cpu_sd_state_idle(cpu);
>> +
>> +     /*
>> +         * Ensures that if nohz_idle_balance() fails to observe our
>> +         * @idle_cpus_mask store, it must observe the @has_blocked
>> +         * store.
>> +         */
>> +        smp_mb__after_atomic();
>> +
>> +out:
>> +     /*
>> +      * Each time a cpu enter idle, we assume that it has blocked load and
>> +      * enable the periodic update of the load of idle cpus
>> +      */
>> +     WRITE_ONCE(nohz.has_blocked, 1);
>>  }
>>  #else
>>  static inline void nohz_balancer_kick(struct rq *rq) { }
>
> I moved the barrier up one statement, such that its right after the
> atomic_inc(). Otherwise people will get all itchy about __after_atomic()
> semantics and we really only care about the cpumask_set_cpu() vs
> WRITE_ONCE() ordering, so it doesn't really matter _where_ that barrier
> lands in between.

ok. make sense

>
>> @@ -9374,6 +9425,22 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
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
>> +
>> +     /*
>> +         * Ensures that if we miss the CPU, we must see the has_blocked
>> +         * store from nohz_balance_enter_idle().
>> +         */
>> +        smp_mb();
>> +
>>       for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
>>               if (balance_cpu == this_cpu || !idle_cpu(balance_cpu))
>>                       continue;
>
> Fixed that white space damage for you ;-)

Thanks
