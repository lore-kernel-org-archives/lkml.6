Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965112AbeEYOpW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:45:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936185AbeEYOpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:45:20 -0400
Subject: Re: [PATCH v8 3/6] cpuset: Add cpuset.sched.load_balance flag to v2
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>
References: <1526590545-3350-1-git-send-email-longman@redhat.com>
 <1526590545-3350-4-git-send-email-longman@redhat.com>
 <20180524143614.GC3948@localhost.localdomain>
 <4bd31510-4f73-e263-8dc1-5edb0fe63b59@redhat.com>
 <20180524151656.GD3948@localhost.localdomain>
 <5f409ed7-3850-f1ea-58cf-4326605d1570@redhat.com>
 <20180525094050.GB30654@e110439-lin>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <dc9c8ae5-d3fa-2c0a-a77a-bf79afa34134@redhat.com>
Date: Fri, 25 May 2018 10:45:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180525094050.GB30654@e110439-lin>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/25/2018 05:40 AM, Patrick Bellasi wrote:
> On 24-May 11:22, Waiman Long wrote:
>> On 05/24/2018 11:16 AM, Juri Lelli wrote:
>>> On 24/05/18 11:09, Waiman Long wrote:
>>>> On 05/24/2018 10:36 AM, Juri Lelli wrote:
>>>>> On 17/05/18 16:55, Waiman Long wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>> +	A parent cgroup cannot distribute all its CPUs to child
>>>>>> +	scheduling domain cgroups unless its load balancing flag is
>>>>>> +	turned off.
>>>>>> +
>>>>>> +  cpuset.sched.load_balance
>>>>>> +	A read-write single value file which exists on non-root
>>>>>> +	cpuset-enabled cgroups.  It is a binary value flag that accepts
>>>>>> +	either "0" (off) or a non-zero value (on).  This flag is set
>>>>>> +	by the parent and is not delegatable.
>>>>>> +
>>>>>> +	When it is on, tasks within this cpuset will be load-balanced
>>>>>> +	by the kernel scheduler.  Tasks will be moved from CPUs with
>>>>>> +	high load to other CPUs within the same cpuset with less load
>>>>>> +	periodically.
>>>>>> +
>>>>>> +	When it is off, there will be no load balancing among CPUs on
>>>>>> +	this cgroup.  Tasks will stay in the CPUs they are running on
>>>>>> +	and will not be moved to other CPUs.
>>>>>> +
>>>>>> +	The initial value of this flag is "1".	This flag is then
>>>>>> +	inherited by child cgroups with cpuset enabled.  Its state
>>>>>> +	can only be changed on a scheduling domain cgroup with no
>>>>>> +	cpuset-enabled children.
>>>>> [...]
>>>>>
>>>>>> +	/*
>>>>>> +	 * On default hierachy, a load balance flag change is only allowed
>>>>>> +	 * in a scheduling domain with no child cpuset.
>>>>>> +	 */
>>>>>> +	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) && balance_flag_changed &&
>>>>>> +	   (!is_sched_domain(cs) || css_has_online_children(&cs->css))) {
>>>>>> +		err = -EINVAL;
>>>>>> +		goto out;
>>>>>> +	}
>>>>> The rule is actually
>>>>>
>>>>>  - no child cpuset
>>>>>  - and it must be a scheduling domain
> I always a bit confused by the usage of "scheduling domain", which
> overlaps with the SD concept from the scheduler standpoint.

It is supposed to mimic SD concept of scheduler.

>
> AFAIU a cpuset sched domain is not granted to be turned into an
> actual scheduler SD, am I wrong?
>
> If that's the case, why not better disambiguate these two concept by
> calling the cpuset one a "cpus partition" or eventually "cpuset domain"?

Good point. Peter has similar comment. I will probably change the name
and clarifying it better in the documentation.

Cheers,
Longman
