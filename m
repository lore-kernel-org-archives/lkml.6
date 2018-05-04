Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751721AbeEDRW3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:22:29 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39982 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbeEDRW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:22:27 -0400
Subject: Re: [RFC] sched/core: Don't schedule threads on pre-empted vcpus
To: Peter Zijlstra <peterz@infradead.org>
Cc: matt@codeblueprint.co.uk, mingo@kernel.org, dhaval.giani@oracle.com,
        subhra.mazumdar@oracle.com, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org
References: <1525294330-7759-1-git-send-email-rohit.k.jain@oracle.com>
 <20180504094716.GL12217@hirez.programming.kicks-ass.net>
From: Rohit Jain <rohit.k.jain@oracle.com>
Message-ID: <19c761ee-0865-cc32-1728-0c3ccaf5814a@oracle.com>
Date: Fri, 4 May 2018 10:22:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504094716.GL12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8883 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805040159
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,


On 05/04/2018 02:47 AM, Peter Zijlstra wrote:
> On Wed, May 02, 2018 at 01:52:10PM -0700, Rohit Jain wrote:
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 5e10aae..75d1ecf 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4033,6 +4033,9 @@ int idle_cpu(int cpu)
>>   		return 0;
>>   #endif
>>   
>> +	if (vcpu_is_preempted(cpu))
>> +		return 0;
>> +
>>   	return 1;
>>   }
> Basically OK with this, but did you consider idle_cpu() usage outside of
> select_idle_sibling()?
>
> For instance, I think got_nohz_idle_kick() isn't quite right with this
> on. Similarly for scheduler_tick(), that wants the actual idle state.

As far as intent is concerned, yes I agree you might be right. I left
the VM running for a couple of days, didn't see anything weird however.

We could add a check at each of those places or something to that effect
if this is an issue. Please let me know how you want to proceed.
