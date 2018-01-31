Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbeAaB5z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 20:57:55 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:39371 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbeAaB5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 20:57:54 -0500
X-Google-Smtp-Source: AH8x226JOnkBFbRXhbUPxOpYGPn47W7/jhQfi6POYqrSkKGhqSi8Kpm8Tovk71ma3cJUKJmyaiiyI7adpCZZ04ccdgU=
MIME-Version: 1.0
In-Reply-To: <6967b972-129a-a7f0-06ab-c48dc9709726@oracle.com>
References: <1517268429-933-1-git-send-email-rohit.k.jain@oracle.com>
 <CAJWu+opnNgfVxhgHwLft_qcLMeikEAbNY0zci0WtgQiFkVVjhg@mail.gmail.com> <6967b972-129a-a7f0-06ab-c48dc9709726@oracle.com>
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 30 Jan 2018 17:57:52 -0800
Message-ID: <CAJWu+orYPDy3H2TCtB_FZWrMx18F_ePnD=Gdfj=pKg4HVaLjTQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] sched/fair: consider RT/IRQ pressure in select_idle_sibling
To: Rohit Jain <rohit.k.jain@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        "Cc: EAS Dev" <eas-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 11:47 AM, Rohit Jain <rohit.k.jain@oracle.com> wrote:
[...]
>>>
>>> Currently fast path in the scheduler looks for an idle CPU to schedule
>>> threads on. Capacity is taken into account in the function
>>> 'select_task_rq_fair' when it calls 'wake_cap', however it ignores the
>>> instantaneous capacity and looks at the original capacity. Furthermore
>>> select_idle_sibling path of the code, ignores the RT/IRQ threads which
>>> are also running on the CPUs it is looking to schedule fair threads on.
>>>
>>> We don't necessarily have to force the code to go to slow path (by
>>> modifying wake_cap), instead we could do a better selection of the CPU
>>> in the current domain itself (i.e. in the fast path).
>>>
>>> This patch makes the fast path aware of capacity, resulting in overall
>>> performance improvements as shown in the test results.
>>>
>> [...]
>>>
>>> I also ran uperf and sysbench MySQL workloads but I see no statistically
>>> significant change.
>>>
>>> Signed-off-by: Rohit Jain<rohit.k.jain@oracle.com>
>>> ---
>>>   kernel/sched/fair.c | 38 ++++++++++++++++++++++++++++----------
>>>   1 file changed, 28 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 26a71eb..ce5ccf8 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -5625,6 +5625,11 @@ static unsigned long capacity_orig_of(int cpu)
>>>          return cpu_rq(cpu)->cpu_capacity_orig;
>>>   }
>>>
>>> +static inline bool full_capacity(int cpu)
>>> +{
>>> +       return capacity_of(cpu) >= (capacity_orig_of(cpu)*3)/4;
>>> +}
>>> +
>>>   static unsigned long cpu_avg_load_per_task(int cpu)
>>>   {
>>>          struct rq *rq = cpu_rq(cpu);
>>> @@ -6081,7 +6086,7 @@ static int select_idle_core(struct task_struct *p,
>>> struct sched_domain *sd, int
>>>
>>>                  for_each_cpu(cpu, cpu_smt_mask(core)) {
>>>                          cpumask_clear_cpu(cpu, cpus);
>>> -                       if (!idle_cpu(cpu))
>>> +                       if (!idle_cpu(cpu) || !full_capacity(cpu))
>>>                                  idle = false;
>>>                  }
>>
>> There's some difference in logic between select_idle_core and
>> select_idle_cpu as far as the full_capacity stuff you're adding goes.
>> In select_idle_core, if all CPUs are !full_capacity, you're returning
>> -1. But in select_idle_cpu you're returning the best idle CPU that's
>> the most cap among the !full_capacity ones. Why there is this
>> different in logic? Did I miss something?
>
>
> This is the previous discussion on this same code. I measured the
> performance difference and saw no statistically significant impact,
> hence went with your suggestion of simpler code.

Dude :) That is hardly an answer to the question I asked. Hint:
*different in logic*.

- Joel
