Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752554AbeBFRhu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:37:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58376 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbeBFRhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 12:37:43 -0500
Subject: Re: [RESEND PATCH] sched/fair: consider RT/IRQ pressure in
 select_idle_sibling
To: Joel Fernandes <joelaf@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        "Cc: EAS Dev" <eas-dev@lists.linaro.org>
References: <1517268429-933-1-git-send-email-rohit.k.jain@oracle.com>
 <CAJWu+opnNgfVxhgHwLft_qcLMeikEAbNY0zci0WtgQiFkVVjhg@mail.gmail.com>
 <6967b972-129a-a7f0-06ab-c48dc9709726@oracle.com>
 <CAJWu+orYPDy3H2TCtB_FZWrMx18F_ePnD=Gdfj=pKg4HVaLjTQ@mail.gmail.com>
 <c78b1dab-95fb-ed88-30de-b4d489a5fc17@oracle.com>
 <CAJWu+opnwHQm8p6LnFRpfmQ+rkPgeGUWkV_imemvMqzg2WGB_Q@mail.gmail.com>
From: Rohit Jain <rohit.k.jain@oracle.com>
Message-ID: <9dabc7cd-61d8-76dd-7c21-69f1f2835b1a@oracle.com>
Date: Tue, 6 Feb 2018 09:41:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAJWu+opnwHQm8p6LnFRpfmQ+rkPgeGUWkV_imemvMqzg2WGB_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8796 signatures=668662
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802060222
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/05/2018 10:50 PM, Joel Fernandes wrote:
> On Wed, Jan 31, 2018 at 9:50 AM, Rohit Jain <rohit.k.jain@oracle.com> wrote:
>>>>>>     kernel/sched/fair.c | 38 ++++++++++++++++++++++++++++----------
>>>>>>     1 file changed, 28 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>>> index 26a71eb..ce5ccf8 100644
>>>>>> --- a/kernel/sched/fair.c
>>>>>> +++ b/kernel/sched/fair.c
>>>>>> @@ -5625,6 +5625,11 @@ static unsigned long capacity_orig_of(int cpu)
>>>>>>            return cpu_rq(cpu)->cpu_capacity_orig;
>>>>>>     }
>>>>>>
>>>>>> +static inline bool full_capacity(int cpu)
>>>>>> +{
>>>>>> +       return capacity_of(cpu) >= (capacity_orig_of(cpu)*3)/4;
>>>>>> +}
>>>>>> +
>>>>>>     static unsigned long cpu_avg_load_per_task(int cpu)
>>>>>>     {
>>>>>>            struct rq *rq = cpu_rq(cpu);
>>>>>> @@ -6081,7 +6086,7 @@ static int select_idle_core(struct task_struct
>>>>>> *p,
>>>>>> struct sched_domain *sd, int
>>>>>>
>>>>>>                    for_each_cpu(cpu, cpu_smt_mask(core)) {
>>>>>>                            cpumask_clear_cpu(cpu, cpus);
>>>>>> -                       if (!idle_cpu(cpu))
>>>>>> +                       if (!idle_cpu(cpu) || !full_capacity(cpu))
>>>>>>                                    idle = false;
>>>>>>                    }
>>>>> There's some difference in logic between select_idle_core and
>>>>> select_idle_cpu as far as the full_capacity stuff you're adding goes.
>>>>> In select_idle_core, if all CPUs are !full_capacity, you're returning
>>>>> -1. But in select_idle_cpu you're returning the best idle CPU that's
>>>>> the most cap among the !full_capacity ones. Why there is this
>>>>> different in logic? Did I miss something?
>>>>>
>> <snip>
>>
>>
>>
>> Let me re-try :)
>>
>> For select_idle_core, we are doing a search for a fully idle and full
>> capacity core, the fail-safe is select_idle_cpu because we will re-scan
>> the CPUs. The notion is to select an idle CPU no matter what, because
>> being on an idle CPU is better than waiting on a non-idle one. In
>> select_idle_core you can be slightly picky about the core because
>> select_idle_cpu is a fail safe. I measured the performance impact of
>> choosing the "best among low cap" vs the code changes I have (for
>> select_idle_core) and could not find a statistically significant impact,
>> hence went with the simpler code changes.
> That's Ok with me. Just that I remember Peter messing with this path
> and that it was expensive to scan too much for some systems. The other
> thing is you're really doing to do a "fail safe" as you call it search
> here with SIS_PROP set. Do you see a difference in perf when doing the
> same approach as you took in select_idle_core?

I didn't see any measurable impact by changing select_idle_core from the
above logic to be the same logic as select_idle_cpu. I am OK with either
if there are concerns.

Thanks,
Rohit

>
> Peter, are you with the approach Rohit has adopted to pick best
> capacity idle CPU in select_idle_cpu? I guess nr--; will bail out
> early if we have SIS_PROP set, incase the scan cost gets too much but
> then again we might end scanning too few CPUs.
>
> thanks,
>
> - Joel
