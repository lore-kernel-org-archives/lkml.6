Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753716AbeEHAaI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 20:30:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753503AbeEHAaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 20:30:05 -0400
Subject: Re: [PATCH v7 3/5] cpuset: Add a root-only cpus.isolated v2 control
 file
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>
References: <1524145624-23655-1-git-send-email-longman@redhat.com>
 <1524145624-23655-4-git-send-email-longman@redhat.com>
 <20180502140835.GK12180@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <04f33505-1256-461e-917c-175869d6dd24@redhat.com>
Date: Mon, 7 May 2018 20:30:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180502140835.GK12180@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2018 10:08 AM, Peter Zijlstra wrote:
> On Thu, Apr 19, 2018 at 09:47:02AM -0400, Waiman Long wrote:
>> diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
>> index c970bd7..8d89dc2 100644
>> --- a/Documentation/cgroup-v2.txt
>> +++ b/Documentation/cgroup-v2.txt
>> @@ -1484,6 +1484,31 @@ Cpuset Interface Files
>>  	a subset of "cpuset.cpus".  Its value will be affected by CPU
>>  	hotplug events.
>>  
>> +  cpuset.cpus.isolated
>> +	A read-write multiple values file which exists on root cgroup
>> +	only.
>> +
>> +	It lists the CPUs that have been withdrawn from the root cgroup
>> +	for load balancing.  These CPUs can still be allocated to child
>> +	cpusets with load balancing enabled, if necessary.
>> +
>> +	If a child cpuset contains only an exclusive set of CPUs that are
>> +	a subset of the isolated CPUs and with load balancing enabled,
>> +	these CPUs will be load balanced on a separate root domain from
>> +	the one in the root cgroup.
>> +
>> +	Just putting the CPUs into "cpuset.cpus.isolated" will be
>> +	enough to disable load balancing on those CPUs as long as they
>> +	do not appear in a child cpuset with load balancing enabled.
>> +	Fine-grained control of cpu isolation can also be done by
>> +	putting these isolated CPUs into child cpusets with load
>> +	balancing disabled.
>> +
>> +	The "cpuset.cpus.isolated" should be set up before child
>> +	cpusets are created.  Once child cpusets are present, changes
>> +	to "cpuset.cpus.isolated" will not be allowed if the CPUs that
>> +	change their states are in any of the child cpusets.
>> +
> So I see why you did this, but it is _really_ ugly and breaks the
> container invariant.
>
> Ideally we'd make the root group less special, not more special.

Yes, I am planning to make the root cgroup less special by putting a new
isolation flag into all the non-root cgroup.

The container invariant thing, however, is a bit hard to do. Do we
really need a container root to behave exactly like the real root? I
guess we can make that happen if we really want to, but it will
certainly make the code more complex. So it is a trade-off about what is
worth to do and what is not.

Cheers,
Longman
