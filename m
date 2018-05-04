Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbeEDRcn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:32:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50524 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbeEDRcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:32:42 -0400
Subject: Re: [RFC] sched/core: Don't schedule threads on pre-empted vcpus
To: Rohit Jain <rohit.k.jain@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, matt@codeblueprint.co.uk,
        mingo@kernel.org, dhaval.giani@oracle.com, subhra.mazumdar@oracle.com,
        linux-kernel@vger.kernel.org
References: <1525294330-7759-1-git-send-email-rohit.k.jain@oracle.com>
 <20180504094716.GL12217@hirez.programming.kicks-ass.net>
 <19c761ee-0865-cc32-1728-0c3ccaf5814a@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <0a1b4e9d-691c-29bb-37f9-43b62aa8234c@oracle.com>
Date: Fri, 4 May 2018 13:32:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <19c761ee-0865-cc32-1728-0c3ccaf5814a@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8883 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805040160
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/2018 1:22 PM, Rohit Jain wrote:
> Hi Peter,
> 
> On 05/04/2018 02:47 AM, Peter Zijlstra wrote:
>> On Wed, May 02, 2018 at 01:52:10PM -0700, Rohit Jain wrote:
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 5e10aae..75d1ecf 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -4033,6 +4033,9 @@ int idle_cpu(int cpu)
>>>           return 0;
>>>   #endif
>>>   +    if (vcpu_is_preempted(cpu))
>>> +        return 0;
>>> +
>>>       return 1;
>>>   }
>> Basically OK with this, but did you consider idle_cpu() usage outside of
>> select_idle_sibling()?
>>
>> For instance, I think got_nohz_idle_kick() isn't quite right with this
>> on. Similarly for scheduler_tick(), that wants the actual idle state.
> 
> As far as intent is concerned, yes I agree you might be right. I left
> the VM running for a couple of days, didn't see anything weird however.
> 
> We could add a check at each of those places or something to that effect
> if this is an issue. Please let me know how you want to proceed.

The point is that some idle_cpu() call sites should consider preemption state
and some should not, and they must be considered on a case by case basis.  You 
could define a new accessor to abstract the difference, and call it from
select_idle_sibling and anywhere else it makes sense.

available_idle_cpu()
{
  return idle_cpu() && !vcpu_is_preempted()
}

- Steve
