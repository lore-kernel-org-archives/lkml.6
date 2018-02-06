Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbeBFRcz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:32:55 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50298 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753090AbeBFRcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 12:32:09 -0500
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
 <CAJWu+orKkgYMjTxRiaHbjGAxeWT1YZQvpDR7ofpWcJreCi9Zgw@mail.gmail.com>
From: Rohit Jain <rohit.k.jain@oracle.com>
Message-ID: <39c72c93-b00b-f59c-ad75-af43daac77e9@oracle.com>
Date: Tue, 6 Feb 2018 09:36:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAJWu+orKkgYMjTxRiaHbjGAxeWT1YZQvpDR7ofpWcJreCi9Zgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8796 signatures=668662
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802060221
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/05/2018 10:42 PM, Joel Fernandes wrote:
> On Tue, Jan 30, 2018 at 11:47 AM, Rohit Jain <rohit.k.jain@oracle.com> wrote:
> [...]
>>>> @@ -6102,7 +6107,8 @@ static int select_idle_core(struct task_struct *p,
>>>> struct sched_domain *sd, int
>>>>     */
>>>>    static int select_idle_smt(struct task_struct *p, struct sched_domain
>>>> *sd, int target)
>>>>    {
>>>> -       int cpu;
>>>> +       int cpu, rcpu = -1;
>>>> +       unsigned long max_cap = 0;
>>>>
>>>>           if (!static_branch_likely(&sched_smt_present))
>>>>                   return -1;
>>>> @@ -6110,11 +6116,13 @@ static int select_idle_smt(struct task_struct *p,
>>>> struct sched_domain *sd, int t
>>>>           for_each_cpu(cpu, cpu_smt_mask(target)) {
>>>>                   if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
>>>>                           continue;
>>>> -               if (idle_cpu(cpu))
>>>> -                       return cpu;
>>>> +               if (idle_cpu(cpu) && (capacity_of(cpu) > max_cap)) {
>>>> +                       max_cap = capacity_of(cpu);
>>>> +                       rcpu = cpu;
>>> At the SMT level, do you need to bother with choosing best capacity
>>> among threads? If RT is eating into one of the SMT thread's underlying
>>> capacity, it would eat into the other's. Wondering what's the benefit
>>> of doing this here.
>>
>> Yes, you are right because of SD_SHARE_CPUCAPACITY, however the benefit
>> is that if don't do this check, we might end up picking a SMT thread
>> which has "high" RT/IRQ activity and be on the run queue for a while,
>> till the pull side can bail us out.
> Do your tests show a difference in results though with such change
> (for select_idle_smt)?

I don't have the numbers readily available, but I did see a measurable
difference with the select_idle_smt changes.

Thanks,
Rohit

>
> thanks,
>
> - Joel
