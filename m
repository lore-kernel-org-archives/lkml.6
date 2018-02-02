Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753511AbeBBRoR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 12:44:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39740 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752945AbeBBRmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 12:42:12 -0500
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
To: Peter Zijlstra <peterz@infradead.org>
Cc: subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        dhaval.giani@oracle.com
References: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
 <20180201123335.GV2249@hirez.programming.kicks-ass.net>
 <911d42cf-54c7-4776-c13e-7c11f8ebfd31@oracle.com>
 <20180202171708.GN2269@hirez.programming.kicks-ass.net>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <0b3ee72d-0316-e11d-dee4-0d35375eed1d@oracle.com>
Date: Fri, 2 Feb 2018 12:36:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180202171708.GN2269@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8793 signatures=668661
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=683
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020216
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/2018 12:17 PM, Peter Zijlstra wrote:
> On Fri, Feb 02, 2018 at 11:53:40AM -0500, Steven Sistare wrote:
>>>> +static int select_idle_smt(struct task_struct *p, struct sched_group *sg)
>>>>  {
>>>> +	int i, rand_index, rand_cpu;
>>>> +	int this_cpu = smp_processor_id();
>>>>  
>>>> +	rand_index = CPU_PSEUDO_RANDOM(this_cpu) % sg->group_weight;
>>>> +	rand_cpu = sg->cp_array[rand_index];
>>>
>>> Right, so yuck.. I know why you need that, but that extra array and
>>> dereference is the reason I never went there.
>>>
>>> How much difference does it really make vs the 'normal' wrapping search
>>> from last CPU ?
>>>
>>> This really should be a separate patch with separate performance numbers
>>> on.
>>
>> For the benefit of other readers, if we always search and choose starting from
>> the first CPU in a core, then later searches will often need to traverse the first
>> N busy CPU's to find the first idle CPU.  Choosing a random starting point avoids
>> such bias.  It is probably a win for processors with 4 to 8 CPUs per core, and
>> a slight but hopefully negligible loss for 2 CPUs per core, and I agree we need
>> to see performance data for this as a separate patch to decide.  We have SPARC
>> systems with 8 CPUs per core.
> 
> Which is why the current code already doesn't start from the first cpu
> in the mask. We start at whatever CPU the task ran last on, which is
> effectively 'random' if the system is busy.
> 
> So how is a per-cpu rotor better than that?

The current code is:
        for_each_cpu(cpu, cpu_smt_mask(target)) {

For an 8-cpu/core processor, 8 values of target map to the same cpu_smt_mask.
8 different tasks will traverse the mask in the same order.

- Steve
