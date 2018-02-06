Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeBFGuu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 01:50:50 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:33038 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeBFGun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 01:50:43 -0500
X-Google-Smtp-Source: AH8x224RISYFLqbAheKTotovY54O+XJ5CrTu/BbzckorHLmw/XmZ9L5YsS5/JUkWQ+ib2rAEhq3DPYm22KTa8fQ5RYA=
MIME-Version: 1.0
In-Reply-To: <c78b1dab-95fb-ed88-30de-b4d489a5fc17@oracle.com>
References: <1517268429-933-1-git-send-email-rohit.k.jain@oracle.com>
 <CAJWu+opnNgfVxhgHwLft_qcLMeikEAbNY0zci0WtgQiFkVVjhg@mail.gmail.com>
 <6967b972-129a-a7f0-06ab-c48dc9709726@oracle.com> <CAJWu+orYPDy3H2TCtB_FZWrMx18F_ePnD=Gdfj=pKg4HVaLjTQ@mail.gmail.com>
 <c78b1dab-95fb-ed88-30de-b4d489a5fc17@oracle.com>
From: Joel Fernandes <joelaf@google.com>
Date: Mon, 5 Feb 2018 22:50:41 -0800
Message-ID: <CAJWu+opnwHQm8p6LnFRpfmQ+rkPgeGUWkV_imemvMqzg2WGB_Q@mail.gmail.com>
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

On Wed, Jan 31, 2018 at 9:50 AM, Rohit Jain <rohit.k.jain@oracle.com> wrote:
>>>>>    kernel/sched/fair.c | 38 ++++++++++++++++++++++++++++----------
>>>>>    1 file changed, 28 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>> index 26a71eb..ce5ccf8 100644
>>>>> --- a/kernel/sched/fair.c
>>>>> +++ b/kernel/sched/fair.c
>>>>> @@ -5625,6 +5625,11 @@ static unsigned long capacity_orig_of(int cpu)
>>>>>           return cpu_rq(cpu)->cpu_capacity_orig;
>>>>>    }
>>>>>
>>>>> +static inline bool full_capacity(int cpu)
>>>>> +{
>>>>> +       return capacity_of(cpu) >= (capacity_orig_of(cpu)*3)/4;
>>>>> +}
>>>>> +
>>>>>    static unsigned long cpu_avg_load_per_task(int cpu)
>>>>>    {
>>>>>           struct rq *rq = cpu_rq(cpu);
>>>>> @@ -6081,7 +6086,7 @@ static int select_idle_core(struct task_struct
>>>>> *p,
>>>>> struct sched_domain *sd, int
>>>>>
>>>>>                   for_each_cpu(cpu, cpu_smt_mask(core)) {
>>>>>                           cpumask_clear_cpu(cpu, cpus);
>>>>> -                       if (!idle_cpu(cpu))
>>>>> +                       if (!idle_cpu(cpu) || !full_capacity(cpu))
>>>>>                                   idle = false;
>>>>>                   }
>>>>
>>>> There's some difference in logic between select_idle_core and
>>>> select_idle_cpu as far as the full_capacity stuff you're adding goes.
>>>> In select_idle_core, if all CPUs are !full_capacity, you're returning
>>>> -1. But in select_idle_cpu you're returning the best idle CPU that's
>>>> the most cap among the !full_capacity ones. Why there is this
>>>> different in logic? Did I miss something?
>>>>
>
> <snip>
>
>> Dude :) That is hardly an answer to the question I asked. Hint:
>> *different in logic*.
>
>
> Let me re-try :)
>
> For select_idle_core, we are doing a search for a fully idle and full
> capacity core, the fail-safe is select_idle_cpu because we will re-scan
> the CPUs. The notion is to select an idle CPU no matter what, because
> being on an idle CPU is better than waiting on a non-idle one. In
> select_idle_core you can be slightly picky about the core because
> select_idle_cpu is a fail safe. I measured the performance impact of
> choosing the "best among low cap" vs the code changes I have (for
> select_idle_core) and could not find a statistically significant impact,
> hence went with the simpler code changes.

That's Ok with me. Just that I remember Peter messing with this path
and that it was expensive to scan too much for some systems. The other
thing is you're really doing to do a "fail safe" as you call it search
here with SIS_PROP set. Do you see a difference in perf when doing the
same approach as you took in select_idle_core?

Peter, are you with the approach Rohit has adopted to pick best
capacity idle CPU in select_idle_cpu? I guess nr--; will bail out
early if we have SIS_PROP set, incase the scan cost gets too much but
then again we might end scanning too few CPUs.

thanks,

- Joel
