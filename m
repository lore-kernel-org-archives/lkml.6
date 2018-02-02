Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753354AbeBBRnz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 12:43:55 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51010 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753497AbeBBRmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 12:42:23 -0500
Subject: Re: [RESEND RFC PATCH V3] sched: Improve scalability of
 select_idle_sibling using SMT balance
To: Peter Zijlstra <peterz@infradead.org>,
        Steven Sistare <steven.sistare@oracle.com>
References: <20180129233102.19018-1-subhra.mazumdar@oracle.com>
 <20180201123335.GV2249@hirez.programming.kicks-ass.net>
 <911d42cf-54c7-4776-c13e-7c11f8ebfd31@oracle.com>
 <20180202171708.GN2269@hirez.programming.kicks-ass.net>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        dhaval.giani@oracle.com
From: Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <93db4b69-5ec6-732f-558e-5e64d9ba0cf9@oracle.com>
Date: Fri, 2 Feb 2018 09:37:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180202171708.GN2269@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8793 signatures=668661
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=923
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020216
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/18 9:17 AM, Peter Zijlstra wrote:
> On Fri, Feb 02, 2018 at 11:53:40AM -0500, Steven Sistare wrote:
>>>> +static int select_idle_smt(struct task_struct *p, struct sched_group *sg)
>>>>   {
>>>> +	int i, rand_index, rand_cpu;
>>>> +	int this_cpu = smp_processor_id();
>>>>   
>>>> +	rand_index = CPU_PSEUDO_RANDOM(this_cpu) % sg->group_weight;
>>>> +	rand_cpu = sg->cp_array[rand_index];
>>> Right, so yuck.. I know why you need that, but that extra array and
>>> dereference is the reason I never went there.
>>>
>>> How much difference does it really make vs the 'normal' wrapping search
>>> from last CPU ?
>>>
>>> This really should be a separate patch with separate performance numbers
>>> on.
>> For the benefit of other readers, if we always search and choose starting from
>> the first CPU in a core, then later searches will often need to traverse the first
>> N busy CPU's to find the first idle CPU.  Choosing a random starting point avoids
>> such bias.  It is probably a win for processors with 4 to 8 CPUs per core, and
>> a slight but hopefully negligible loss for 2 CPUs per core, and I agree we need
>> to see performance data for this as a separate patch to decide.  We have SPARC
>> systems with 8 CPUs per core.
> Which is why the current code already doesn't start from the first cpu
> in the mask. We start at whatever CPU the task ran last on, which is
> effectively 'random' if the system is busy.
>
> So how is a per-cpu rotor better than that?
In the scheme of SMT balance, if the idle cpu search is done _not_ in 
the last run core, then we need a random cpu to start from. If the idle 
cpu search is done in the last run core we can start the search from 
last run cpu. Since we need the random index for the first case I just 
did it for both.

Thanks,
Subhra
