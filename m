Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754938AbeEaM1P (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:27:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40716 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754733AbeEaM1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:27:11 -0400
Date: Thu, 31 May 2018 14:26:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v9 3/7] cpuset: Add cpuset.sched.load_balance flag to v2
Message-ID: <20180531122638.GJ12180@hirez.programming.kicks-ass.net>
References: <1527601294-3444-1-git-send-email-longman@redhat.com>
 <1527601294-3444-4-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527601294-3444-4-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 09:41:30AM -0400, Waiman Long wrote:
> The sched.load_balance flag is needed to enable CPU isolation similar to
> what can be done with the "isolcpus" kernel boot parameter. Its value
> can only be changed in a scheduling domain with no child cpusets. On
> a non-scheduling domain cpuset, the value of sched.load_balance is
> inherited from its parent. This is to make sure that all the cpusets
> within the same scheduling domain or partition has the same load
> balancing state.
> 
> This flag is set by the parent and is not delegatable.

> +  cpuset.sched.domain_root
> +	A read-write single value file which exists on non-root
> +	cpuset-enabled cgroups.  It is a binary value flag that accepts
> +	either "0" (off) or "1" (on).  This flag is set by the parent
> +	and is not delegatable.
> +
> +	If set, it indicates that the current cgroup is the root of a
> +	new scheduling domain or partition that comprises itself and
> +	all its descendants except those that are scheduling domain
> +	roots themselves and their descendants.  The root cgroup is
> +	always a scheduling domain root.
> +
> +	There are constraints on where this flag can be set.  It can
> +	only be set in a cgroup if all the following conditions are true.
> +
> +	1) The "cpuset.cpus" is not empty and the list of CPUs are
> +	   exclusive, i.e. they are not shared by any of its siblings.
> +	2) The parent cgroup is also a scheduling domain root.
> +	3) There is no child cgroups with cpuset enabled.  This is
> +	   for eliminating corner cases that have to be handled if such
> +	   a condition is allowed.
> +
> +	Setting this flag will take the CPUs away from the effective
> +	CPUs of the parent cgroup.  Once it is set, this flag cannot
> +	be cleared if there are any child cgroups with cpuset enabled.
> +	Further changes made to "cpuset.cpus" is allowed as long as
> +	the first condition above is still true.
> +
> +	A parent scheduling domain root cgroup cannot distribute all
> +	its CPUs to its child scheduling domain root cgroups unless
> +	its load balancing flag is turned off.
> +
> +  cpuset.sched.load_balance
> +	A read-write single value file which exists on non-root
> +	cpuset-enabled cgroups.  It is a binary value flag that accepts
> +	either "0" (off) or "1" (on).  This flag is set by the parent
> +	and is not delegatable.  It is on by default in the root cgroup.
> +
> +	When it is on, tasks within this cpuset will be load-balanced
> +	by the kernel scheduler.  Tasks will be moved from CPUs with
> +	high load to other CPUs within the same cpuset with less load
> +	periodically.
> +
> +	When it is off, there will be no load balancing among CPUs on
> +	this cgroup.  Tasks will stay in the CPUs they are running on
> +	and will not be moved to other CPUs.
> +
> +	The load balancing state of a cgroup can only be changed on a
> +	scheduling domain root cgroup with no cpuset-enabled children.
> +	All cgroups within a scheduling domain or partition must have
> +	the same load balancing state.	As descendant cgroups of a
> +	scheduling domain root are created, they inherit the same load
> +	balancing state of their root.

I still find all that a bit weird.

So load_balance=0 basically changes a partition into a
'fully-partitioned partition' with the seemingly random side-effect that
now sub-partitions are allowed to consume all CPUs.

The rationale, only given in the Changelog above, seems to be to allow
'easy' emulation of isolcpus.

I'm still not convinced this is a useful knob to have. You can do
fully-partitioned by simply creating a lot of 1 cpu parititions.

So this one knob does two separate things, both of which seem, to me,
redundant.

Can we please get better rationale for this?
