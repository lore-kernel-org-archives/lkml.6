Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752977AbeBIWAo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 17:00:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34870 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeBIWAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 17:00:43 -0500
Subject: Re: [RESEND PATCH] sched/fair: consider RT/IRQ pressure in
 select_idle_sibling
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        steven.sistare@oracle.com, dhaval.giani@oracle.com, joelaf@google.com,
        vincent.guittot@linaro.org, morten.rasmussen@arm.com,
        eas-dev@lists.linaro.org
References: <1517268429-933-1-git-send-email-rohit.k.jain@oracle.com>
 <20180209125358.GO25201@hirez.programming.kicks-ass.net>
 <2b3a903f-fbb6-cc0e-8a5d-e3329e1276c7@arm.com>
From: Rohit Jain <rohit.k.jain@oracle.com>
Message-ID: <14d6cf2f-b987-6987-0f9e-df03ba84d989@oracle.com>
Date: Fri, 9 Feb 2018 14:05:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2b3a903f-fbb6-cc0e-8a5d-e3329e1276c7@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8800 signatures=668666
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=739
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090277
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/09/2018 07:46 AM, Dietmar Eggemann wrote:
> On 02/09/2018 01:53 PM, Peter Zijlstra wrote:
>> On Mon, Jan 29, 2018 at 03:27:09PM -0800, Rohit Jain wrote:
>
> [...]
>
>>> @@ -6173,8 +6183,15 @@ static int select_idle_cpu(struct task_struct 
>>> *p, struct sched_domain *sd, int t
>>>               return -1;
>>>           if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
>>>               continue;
>>> +        if (idle_cpu(cpu)) {
>>> +            if (full_capacity(cpu)) {
>>> +                best_cpu = cpu;
>>> +                break;
>>> +            } else if (capacity_of(cpu) > best_cap) {
>>> +                best_cap = capacity_of(cpu);
>>> +                best_cpu = cpu;
>>> +            }
>>> +        }
>>
>> No need for the else. And you'll note you're once again inconsistent
>> with your previous self.
>>
>> But here I worry about big.little a wee bit. I think we're allowed big
>> and little cores on the same L3 these days, and you can't directly
>> compare capacity between them.
>>
>> Morten / Dietmar, any comments?
>
> Yes, for DynamIQ (big.little successor) systems, those cpus can have 
> different capacity_orig_of() values already.
>

OK, given that there are asymmetric capacities in L3 cores, we would
probably have something like the below(?) in select_idle_cpu:

           if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
               continue;
+        if (idle_cpu(cpu) && !reduced_capacity(cpu))
+            break;
