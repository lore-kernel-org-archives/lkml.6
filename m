Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752554AbeA3Tn2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:43:28 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51368 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbeA3Tn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:43:27 -0500
From: Rohit Jain <rohit.k.jain@oracle.com>
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
Message-ID: <6967b972-129a-a7f0-06ab-c48dc9709726@oracle.com>
Date: Tue, 30 Jan 2018 11:47:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAJWu+opnNgfVxhgHwLft_qcLMeikEAbNY0zci0WtgQiFkVVjhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8790 signatures=668657
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801300239
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On 1/29/2018 7:39 PM, Joel Fernandes wrote:
> Hi Rohit,
>
> On Mon, Jan 29, 2018 at 3:27 PM, Rohit Jain<rohit.k.jain@oracle.com>  wrote:
>> Currently fast path in the scheduler looks for an idle CPU to schedule
>> threads on. Capacity is taken into account in the function
>> 'select_task_rq_fair' when it calls 'wake_cap', however it ignores the
>> instantaneous capacity and looks at the original capacity. Furthermore
>> select_idle_sibling path of the code, ignores the RT/IRQ threads which
>> are also running on the CPUs it is looking to schedule fair threads on.
>>
>> We don't necessarily have to force the code to go to slow path (by
>> modifying wake_cap), instead we could do a better selection of the CPU
>> in the current domain itself (i.e. in the fast path).
>>
>> This patch makes the fast path aware of capacity, resulting in overall
>> performance improvements as shown in the test results.
>>
> [...]
>> I also ran uperf and sysbench MySQL workloads but I see no statistically
>> significant change.
>>
>> Signed-off-by: Rohit Jain<rohit.k.jain@oracle.com>
>> ---
>>   kernel/sched/fair.c | 38 ++++++++++++++++++++++++++++----------
>>   1 file changed, 28 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 26a71eb..ce5ccf8 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5625,6 +5625,11 @@ static unsigned long capacity_orig_of(int cpu)
>>          return cpu_rq(cpu)->cpu_capacity_orig;
>>   }
>>
>> +static inline bool full_capacity(int cpu)
>> +{
>> +       return capacity_of(cpu) >= (capacity_orig_of(cpu)*3)/4;
>> +}
>> +
>>   static unsigned long cpu_avg_load_per_task(int cpu)
>>   {
>>          struct rq *rq = cpu_rq(cpu);
>> @@ -6081,7 +6086,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>>
>>                  for_each_cpu(cpu, cpu_smt_mask(core)) {
>>                          cpumask_clear_cpu(cpu, cpus);
>> -                       if (!idle_cpu(cpu))
>> +                       if (!idle_cpu(cpu) || !full_capacity(cpu))
>>                                  idle = false;
>>                  }
> There's some difference in logic between select_idle_core and
> select_idle_cpu as far as the full_capacity stuff you're adding goes.
> In select_idle_core, if all CPUs are !full_capacity, you're returning
> -1. But in select_idle_cpu you're returning the best idle CPU that's
> the most cap among the !full_capacity ones. Why there is this
> different in logic? Did I miss something?

This is the previous discussion on this same code. I measured the
performance difference and saw no statistically significant impact,
hence went with your suggestion of simpler code.

https://lkml.org/lkml/2017/10/3/1001

>
>> @@ -6102,7 +6107,8 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
>>    */
>>   static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
>>   {
>> -       int cpu;
>> +       int cpu, rcpu = -1;
>> +       unsigned long max_cap = 0;
>>
>>          if (!static_branch_likely(&sched_smt_present))
>>                  return -1;
>> @@ -6110,11 +6116,13 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
>>          for_each_cpu(cpu, cpu_smt_mask(target)) {
>>                  if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
>>                          continue;
>> -               if (idle_cpu(cpu))
>> -                       return cpu;
>> +               if (idle_cpu(cpu) && (capacity_of(cpu) > max_cap)) {
>> +                       max_cap = capacity_of(cpu);
>> +                       rcpu = cpu;
> At the SMT level, do you need to bother with choosing best capacity
> among threads? If RT is eating into one of the SMT thread's underlying
> capacity, it would eat into the other's. Wondering what's the benefit
> of doing this here.

Yes, you are right because of SD_SHARE_CPUCAPACITY, however the benefit
is that if don't do this check, we might end up picking a SMT thread
which has "high" RT/IRQ activity and be on the run queue for a while,
till the pull side can bail us out.

Thanks,
Rohit

> thanks,
>
> - Joel
