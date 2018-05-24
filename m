Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032927AbeEXSxi convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:53:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50238 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032744AbeEXSxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:53:36 -0400
Subject: Re: [PATCH v8 2/6] cpuset: Add new v2 cpuset.sched.domain flag
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>
References: <1526590545-3350-1-git-send-email-longman@redhat.com>
 <1526590545-3350-3-git-send-email-longman@redhat.com>
 <20180524154156.GI12198@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <675f0f38-9154-4e73-1679-179eefdb7c9f@redhat.com>
Date: Thu, 24 May 2018 14:53:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180524154156.GI12198@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/2018 11:41 AM, Peter Zijlstra wrote:
> On Thu, May 17, 2018 at 04:55:41PM -0400, Waiman Long wrote:
>> A new cpuset.sched.domain boolean flag is added to cpuset v2. This new
>> flag indicates that the CPUs in the current cpuset should be treated
>> as a separate scheduling domain.
> The traditional name for this is a partition.

Do you want to call it cpuset.sched.partition? That name sounds strange
to me.

>>                                  This new flag is owned by the parent
>> and will cause the CPUs in the cpuset to be removed from the effective
>> CPUs of its parent.
> This is a significant departure from existing behaviour, but one I can
> appreciate. I don't immediately see something terribly wrong with it.
>
>> This is implemented internally by adding a new isolated_cpus mask that
>> holds the CPUs belonging to child scheduling domain cpusets so that:
>>
>> 	isolated_cpus | effective_cpus = cpus_allowed
>> 	isolated_cpus & effective_cpus = 0
>>
>> This new flag can only be turned on in a cpuset if its parent is either
>> root or a scheduling domain itself with non-empty cpu list. The state
>> of this flag cannot be changed if the cpuset has children.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  Documentation/cgroup-v2.txt |  22 ++++
>>  kernel/cgroup/cpuset.c      | 237 +++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 256 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
>> index cf7bac6..54d9e22 100644
>> --- a/Documentation/cgroup-v2.txt
>> +++ b/Documentation/cgroup-v2.txt
>> @@ -1514,6 +1514,28 @@ Cpuset Interface Files
>>  	it is a subset of "cpuset.mems".  Its value will be affected
>>  	by memory nodes hotplug events.
>>  
>> +  cpuset.sched.domain
>> +	A read-write single value file which exists on non-root
>> +	cpuset-enabled cgroups.  It is a binary value flag that accepts
>> +	either "0" (off) or a non-zero value (on).
> I would be conservative and only allow 0/1.

I stated that because echoing other integer value like 2 into the flag
file won't return any error. I will modify it to say just 0 and 1.

>>                                                  This flag is set
>> +	by the parent and is not delegatable.
>> +
>> +	If set, it indicates that the CPUs in the current cgroup will
>> +	be the root of a scheduling domain.  The root cgroup is always
>> +	a scheduling domain.  There are constraints on where this flag
>> +	can be set.  It can only be set in a cgroup if all the following
>> +	conditions are true.
>> +
>> +	1) The parent cgroup is also a scheduling domain with a non-empty
>> +	   cpu list.
> Ah, so initially I was confused by the requirement for root to have it
> always set, but you'll allow child domains to steal _all_ CPUs, such
> that root ends up with an empty effective set?
>
> What about the (kernel) threads that cannot be moved out of the root
> group?

Actually, the current code won't allow you to take all the CPUs from a
scheduling domain cpuset with load balancing on. So there must be at
least 1 cpu left. You can take all away if load balancing is off.

>> +	2) The list of CPUs are exclusive, i.e. they are not shared by
>> +	   any of its siblings.
> Right.
>
>> +	3) There is no child cgroups with cpuset enabled.
>> +
>> +	Setting this flag will take the CPUs away from the effective
>> +	CPUs of the parent cgroup. Once it is set, this flag cannot be
>> +	cleared if there are any child cgroups with cpuset enabled.
> This I'm not clear on. Why?
>
That is for pragmatic reason as it is easier to code this way. We could
remove this restriction but that will make the code more complex.

Cheers,
Longman
