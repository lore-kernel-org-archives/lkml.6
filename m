Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbeCJUnR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 15:43:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58018 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751043AbeCJUnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 15:43:16 -0500
Subject: Re: [RESEND PATCH] sched/fair: consider RT/IRQ pressure in
 select_idle_sibling
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        steven.sistare@oracle.com, dhaval.giani@oracle.com, joelaf@google.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, eas-dev@lists.linaro.org
References: <1517268429-933-1-git-send-email-rohit.k.jain@oracle.com>
 <20180209125358.GO25201@hirez.programming.kicks-ass.net>
From: Rohit Jain <rohit.k.jain@oracle.com>
Message-ID: <11d1a1df-7a4e-fdb5-6de2-680f447a63ad@oracle.com>
Date: Sat, 10 Mar 2018 12:41:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209125358.GO25201@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8828 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803100253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 02/09/2018 04:53 AM, Peter Zijlstra wrote:

<snip>

>>   	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>>   	if (!this_sd)
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
> No need for the else. And you'll note you're once again inconsistent
> with your previous self.
>
> But here I worry about big.little a wee bit. I think we're allowed big
> and little cores on the same L3 these days, and you can't directly
> compare capacity between them.
>
>
<snip>

After pulling to the latest code I see that the changes by Mel Gorman
(commit 32e839dda3ba576943365f0f5817ce5c843137dc) have created a short
path for returning an idle CPU.

The fact that now there exists a short path, to bypass rest of
select_idle_sibling (SIS) is causing a regression in the
"hackbench + ping" testcase *when* I add capacity awareness in the baseline
code as was discussed here.

In details: baseline today has a short cut in the recent_used_cpu to
bypass SIS. When I add capacity awareness in the SIS code path, causing
that extra search to find a better CPU itself is taking more time than
the benefit it provides.

However, there are certain patches which reduce SIS cost while
maintaining a similar spread for threads on CPUs. When I use those
patches I see that the benefit for adding capacity awareness is
restored. Please suggest how to proceed on this.

Thanks,
Rohit
