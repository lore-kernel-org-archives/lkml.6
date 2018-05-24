Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033015AbeEXSza (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 14:55:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032744AbeEXSz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 14:55:28 -0400
Subject: Re: [PATCH v8 3/6] cpuset: Add cpuset.sched.load_balance flag to v2
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>
References: <1526590545-3350-1-git-send-email-longman@redhat.com>
 <1526590545-3350-4-git-send-email-longman@redhat.com>
 <20180524154341.GJ12198@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9f547771-54e8-118e-80f7-48f99c7b0a12@redhat.com>
Date: Thu, 24 May 2018 14:55:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180524154341.GJ12198@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/2018 11:43 AM, Peter Zijlstra wrote:
> On Thu, May 17, 2018 at 04:55:42PM -0400, Waiman Long wrote:
>> The sched.load_balance flag is needed to enable CPU isolation similar to
>> what can be done with the "isolcpus" kernel boot parameter. Its value
>> can only be changed in a scheduling domain with no child cpusets. On
>> a non-scheduling domain cpuset, the value of sched.load_balance is
>> inherited from its parent.
>>
>> This flag is set by the parent and is not delegatable.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  Documentation/cgroup-v2.txt | 24 ++++++++++++++++++++
>>  kernel/cgroup/cpuset.c      | 53 +++++++++++++++++++++++++++++++++++++++++----
>>  2 files changed, 73 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
>> index 54d9e22..071b634d 100644
>> --- a/Documentation/cgroup-v2.txt
>> +++ b/Documentation/cgroup-v2.txt
>> @@ -1536,6 +1536,30 @@ Cpuset Interface Files
>>  	CPUs of the parent cgroup. Once it is set, this flag cannot be
>>  	cleared if there are any child cgroups with cpuset enabled.
>>  
>> +	A parent cgroup cannot distribute all its CPUs to child
>> +	scheduling domain cgroups unless its load balancing flag is
>> +	turned off.
>> +
>> +  cpuset.sched.load_balance
>> +	A read-write single value file which exists on non-root
>> +	cpuset-enabled cgroups.  It is a binary value flag that accepts
>> +	either "0" (off) or a non-zero value (on).  This flag is set
>> +	by the parent and is not delegatable.
>> +
>> +	When it is on, tasks within this cpuset will be load-balanced
>> +	by the kernel scheduler.  Tasks will be moved from CPUs with
>> +	high load to other CPUs within the same cpuset with less load
>> +	periodically.
>> +
>> +	When it is off, there will be no load balancing among CPUs on
>> +	this cgroup.  Tasks will stay in the CPUs they are running on
>> +	and will not be moved to other CPUs.
>> +
>> +	The initial value of this flag is "1".	This flag is then
>> +	inherited by child cgroups with cpuset enabled.  Its state
>> +	can only be changed on a scheduling domain cgroup with no
>> +	cpuset-enabled children.
> I'm confused... why exactly do we have both domain and load_balance ?

The domain is for partitioning the CPUs only. It doesn't change the load
balancing state. So the load_balance flag is still need to turn on and
off load balancing.

Cheers,
Longman
