Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966642AbeBNJL2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 04:11:28 -0500
Received: from foss.arm.com ([217.140.101.70]:39270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966446AbeBNJL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 04:11:26 -0500
Subject: Re: [RESEND PATCH] sched/fair: consider RT/IRQ pressure in
 select_idle_sibling
To: Rohit Jain <rohit.k.jain@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        steven.sistare@oracle.com, dhaval.giani@oracle.com, joelaf@google.com,
        vincent.guittot@linaro.org, morten.rasmussen@arm.com,
        eas-dev@lists.linaro.org
References: <1517268429-933-1-git-send-email-rohit.k.jain@oracle.com>
 <20180209125358.GO25201@hirez.programming.kicks-ass.net>
 <2b3a903f-fbb6-cc0e-8a5d-e3329e1276c7@arm.com>
 <14d6cf2f-b987-6987-0f9e-df03ba84d989@oracle.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <0d66086e-4423-ad9b-acfd-d05e27e5d786@arm.com>
Date: Wed, 14 Feb 2018 10:11:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <14d6cf2f-b987-6987-0f9e-df03ba84d989@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2018 11:05 PM, Rohit Jain wrote:
> 
> On 02/09/2018 07:46 AM, Dietmar Eggemann wrote:
>> On 02/09/2018 01:53 PM, Peter Zijlstra wrote:
>>> On Mon, Jan 29, 2018 at 03:27:09PM -0800, Rohit Jain wrote:
>>
>> [...]
>>
>>>> @@ -6173,8 +6183,15 @@ static int select_idle_cpu(struct task_struct 
>>>> *p, struct sched_domain *sd, int t
>>>>               return -1;
>>>>           if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
>>>>               continue;
>>>> +        if (idle_cpu(cpu)) {
>>>> +            if (full_capacity(cpu)) {
>>>> +                best_cpu = cpu;
>>>> +                break;
>>>> +            } else if (capacity_of(cpu) > best_cap) {
>>>> +                best_cap = capacity_of(cpu);
>>>> +                best_cpu = cpu;
>>>> +            }
>>>> +        }
>>>
>>> No need for the else. And you'll note you're once again inconsistent
>>> with your previous self.
>>>
>>> But here I worry about big.little a wee bit. I think we're allowed big
>>> and little cores on the same L3 these days, and you can't directly
>>> compare capacity between them.
>>>
>>> Morten / Dietmar, any comments?
>>
>> Yes, for DynamIQ (big.little successor) systems, those cpus can have 
>> different capacity_orig_of() values already.
>>
> 
> OK, given that there are asymmetric capacities in L3 cores, we would
> probably have something like the below(?) in select_idle_cpu:
> 
>            if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
>                continue;
> +        if (idle_cpu(cpu) && !reduced_capacity(cpu))
> +            break;
> 

Only returning the first idle cpu w/o reduced capacity will definitely 
work better here on future DynamIQ systems than trying to find the 
best_cap cpu by taking capacity_of() into consideration.
