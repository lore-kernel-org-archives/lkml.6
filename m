Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755863AbeEaQm2 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:42:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755806AbeEaQmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:42:25 -0400
Subject: Re: [PATCH v9 3/7] cpuset: Add cpuset.sched.load_balance flag to v2
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1527601294-3444-1-git-send-email-longman@redhat.com>
 <1527601294-3444-4-git-send-email-longman@redhat.com>
 <20180531122638.GJ12180@hirez.programming.kicks-ass.net>
 <42cc1f44-2355-1c0c-b575-49c863303c42@redhat.com>
 <20180531152050.GK12180@hirez.programming.kicks-ass.net>
 <ebe7f0c1-b2dc-57ad-e5cb-7edf0fee4626@redhat.com>
 <20180531160857.GM12180@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <54c607c3-e742-4da9-c89a-4ed54146e3bd@redhat.com>
Date: Thu, 31 May 2018 12:42:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180531160857.GM12180@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31/2018 12:08 PM, Peter Zijlstra wrote:
> On Thu, May 31, 2018 at 11:36:39AM -0400, Waiman Long wrote:
>>> I'm on the fence myself; the only thing I'm fairly sure of is that tying
>>> this particular behaviour to the load-balance knob seems off.
>> The main reason for doing it this way is that I don't want to have
>> load-balanced partition with no cpu in it. How about we just don't allow
>> consume-all at all. Each partition must have at least 1 cpu.
> I suspect that might be sufficient. It certainly is for the use-cases
> I'm aware of. You always want a system/control set which runs the
> regular busy work of running a system.
>
> Then you have one (or more) partitions to run your 'important' work.

Good. I will make the change in the next version.

>
>>> I also think we should not mix the 'consume all' thing with the
>>> 'fully-partitioned' thing, as they are otherwise unrelated.
>> The "consume all" and "fully-partitioned" look the same to me. Are you
>> talking about allocating all the CPUs in a partition to sub-partitions
>> so that there is no CPU left in the parent partition?
> Not sure what you're asking. "consume all" is allowing sub-partitions to
> allocate all CPUs of the parent, such that there are none left.
>
> "fully-partitioned" is N cpus but no load-balancing, also equivalent to
> N 1 CPU parititions.

Thanks for the clarification.

> They are distinct things. Disabling load-balancing should not affect how
> many CPUs can be allocated to sub-partitions, the moment you hit 1 CPU
> the load balancing is effectively off already. Going down to 0 CPUs
> isn't a problem for the load-balancer, it wasn't doing anything anyway.
>
> So the question is if someone really needs the one partition without
> balancing over N separate paritions.

Thinking about isolcpus emulation, I now realize that it is more than
just disabling load balancing. it also disables some kernel threads like
kworker from running so that an userspace application can monopolize as
much of a cpu as possible. Disabling kernel threads from running isn't
that hard if it is only done once at boot time. it is trickier if we
have to do it at run time.

Without good isolcpus emulation, disabling load balance kind of loses
its usefulness. So I am going to take out the load_balance flag for now
unless I hear objection otherwise.

Cheers,
Longman
