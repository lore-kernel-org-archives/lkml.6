Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751248AbeBIPq6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 10:46:58 -0500
Received: from foss.arm.com ([217.140.101.70]:48598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751034AbeBIPq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 10:46:57 -0500
Subject: Re: [RESEND PATCH] sched/fair: consider RT/IRQ pressure in
 select_idle_sibling
To: Peter Zijlstra <peterz@infradead.org>,
        Rohit Jain <rohit.k.jain@oracle.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        steven.sistare@oracle.com, dhaval.giani@oracle.com, joelaf@google.com,
        vincent.guittot@linaro.org, morten.rasmussen@arm.com,
        eas-dev@lists.linaro.org
References: <1517268429-933-1-git-send-email-rohit.k.jain@oracle.com>
 <20180209125358.GO25201@hirez.programming.kicks-ass.net>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <2b3a903f-fbb6-cc0e-8a5d-e3329e1276c7@arm.com>
Date: Fri, 9 Feb 2018 16:46:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180209125358.GO25201@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2018 01:53 PM, Peter Zijlstra wrote:
> On Mon, Jan 29, 2018 at 03:27:09PM -0800, Rohit Jain wrote:

[...]

>> @@ -6173,8 +6183,15 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>   			return -1;
>>   		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
>>   			continue;
>> +		if (idle_cpu(cpu)) {
>> +			if (full_capacity(cpu)) {
>> +				best_cpu = cpu;
>> +				break;
>> +			} else if (capacity_of(cpu) > best_cap) {
>> +				best_cap = capacity_of(cpu);
>> +				best_cpu = cpu;
>> +			}
>> +		}
> 
> No need for the else. And you'll note you're once again inconsistent
> with your previous self.
> 
> But here I worry about big.little a wee bit. I think we're allowed big
> and little cores on the same L3 these days, and you can't directly
> compare capacity between them.
> 
> Morten / Dietmar, any comments?

Yes, for DynamIQ (big.little successor) systems, those cpus can have 
different capacity_orig_of() values already.
