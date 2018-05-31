Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755240AbeEaNWc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:22:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755006AbeEaNW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:22:29 -0400
Subject: Re: [PATCH] cpuset: Enforce that a child's cpus must be a subset of
 the parent
To: Zefan Li <lizefan@huawei.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>, Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <1527687991-1431-1-git-send-email-longman@redhat.com>
 <5B0F4F09.9050100@huawei.com> <5B0FAE72.1090204@huawei.com>
 <20180531082613.GF12180@hirez.programming.kicks-ass.net>
 <5B0FB58C.9030705@huawei.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <4dc718bc-4bd5-4998-853b-9c6ba67b89a0@redhat.com>
Date: Thu, 31 May 2018 09:22:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <5B0FB58C.9030705@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31/2018 04:42 AM, Zefan Li wrote:
> On 2018/5/31 16:26, Peter Zijlstra wrote:
>> On Thu, May 31, 2018 at 04:12:34PM +0800, Zefan Li wrote:
>>> On 2018/5/31 9:25, Zefan Li wrote:
>>>> Hi Waiman,
>>>>
>>>> On 2018/5/30 21:46, Waiman Long wrote:
>>>>> It was found that the cpuset.cpus could contain CPUs that are not listed
>>>>> in their parent's cpu list as shown by the command sequence below:
>>>>>
>>>>>   # echo "+cpuset" >cgroup.subtree_control
>>>>>   # mkdir g1
>>>>>   # echo 0-5 >g1/cpuset.cpus
>>>>>   # mkdir g1/g11
>>>>>   # echo "+cpuset" > g1/cgroup.subtree_control
>>>>>   # echo 6-11 >g1/g11/cpuset.cpus
>>>>>   # grep -R . g1 | grep "\.cpus"
>>>>>   g1/cpuset.cpus:0-5
>>>>>   g1/cpuset.cpus.effective:0-5
>>>>>   g1/g11/cpuset.cpus:6-11
>>>>>   g1/g11/cpuset.cpus.effective:0-5
>>>>>
>>>>> As the intersection of g11's cpus and that of g1 is empty, the effective
>>>>> cpus of g11 is just that of g1. The check in update_cpumask() is now
>>>>> corrected to make sure that cpus in a child cpus must be a subset of
>>>>> its parent's cpus. The error "write error: Invalid argument" will now
>>>>> be reported in the above case.
>>>>>
>>>> We made the distinction between user-configured CPUs and effective CPUs
>>>> in commit 7e88291beefbb758, so actually it's not a bug.
>>>>
>>> I remember the original reason is to support restoration of the original
>>> cpu after cpu offline->online. We use user-configured CPUs to remember
>>> if the cpu should be restored in the cpuset after it's onlined.
>> AFAICT you can do that and still have the child a subset of the parent,
>> no?
>> .
> Sure. IIRC this was suggested by Tejun as he had done something similar to devcgroup.
>
OK, let wait until Tejun has time to chime in. For me, it just look
weird to be able to do that.

Another corner case that is not handled is when cpus_allowed is empty.
In this case, it falls back to the parent's effective cpus. On the other
hand, it can also be argued that an empty cpus_allowed is a transient
state and a cpuset shouldn't have cpus undefined while creating children.

Cheers,
Longman
