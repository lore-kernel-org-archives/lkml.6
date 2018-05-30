Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbeE3M4P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:56:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753129AbeE3M4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:56:13 -0400
Subject: Re: [PATCH v9 0/7] Enable cpuset controller in default hierarchy
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <1527601294-3444-1-git-send-email-longman@redhat.com>
 <20180530101317.GB3320@localhost.localdomain>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d74c67ea-43c9-cabb-4303-ecff008412df@redhat.com>
Date: Wed, 30 May 2018 08:56:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180530101317.GB3320@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30/2018 06:13 AM, Juri Lelli wrote:
> Hi,
>
> On 29/05/18 09:41, Waiman Long wrote:
>> v9:
>>  - Rename cpuset.sched.domain to cpuset.sched.domain_root to better
>>    identify its purpose as the root of a new scheduling domain or
>>    partition.
>>  - Clarify in the document about the purpose of domain_root and
>>    load_balance. Using domain_root is th only way to create new
>>    partition.
>>  - Fix a lockdep warning in update_isolated_cpumask() function.
>>  - Add a new patch to eliminate call to generate_sched_domains() for
>>    v2 when a change in cpu list does not touch a domain_root.
> I was playing with this and ended up with the situation below:
>
>  g1/cgroup.controllers:cpuset
>  g1/cgroup.events:populated 0
>  g1/cgroup.max.depth:max
>  g1/cgroup.max.descendants:max
>  g1/cgroup.stat:nr_descendants 1
>  g1/cgroup.stat:nr_dying_descendants 0
>  g1/cgroup.subtree_control:cpuset
>  g1/cgroup.type:domain
>  g1/cpuset.cpus:0-5                   <---
>  g1/cpuset.cpus.effective:0-5
>  g1/cpuset.mems.effective:0-1
>  g1/cpuset.sched.domain_root:1        <---
>  g1/cpuset.sched.load_balance:1
>  g1/cpu.stat:usage_usec 0
>  g1/cpu.stat:user_usec 0
>  g1/cpu.stat:system_usec 0
>  g1/g11/cgroup.events:populated 0
>  g1/g11/cgroup.max.descendants:max
>  g1/g11/cpu.stat:usage_usec 0
>  g1/g11/cpu.stat:user_usec 0
>  g1/g11/cpu.stat:system_usec 0
>  g1/g11/cgroup.type:domain
>  g1/g11/cgroup.stat:nr_descendants 0
>  g1/g11/cgroup.stat:nr_dying_descendants 0
>  g1/g11/cpuset.cpus.effective:0-5
>  g1/g11/cgroup.controllers:cpuset
>  g1/g11/cpuset.sched.load_balance:1
>  g1/g11/cpuset.mems.effective:0-1
>  g1/g11/cpuset.cpus:6-11              <---
>  g1/g11/cgroup.max.depth:max
>  g1/g11/cpuset.sched.domain_root:0
>
> Should this be allowed? I was expecting subgroup g11 should be
> restricted to a subset of g1's cpus.
>
> Best,
>
> - Juri

That shouldn't be allowed.The code is probably missing some checks that
should have been done. What was the sequence of commands leading to the
above configuration?

Cheers,
Longman
