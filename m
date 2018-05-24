Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967962AbeEXPmb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:42:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48984 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967710AbeEXPmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:42:21 -0400
Date: Thu, 24 May 2018 17:41:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v8 2/6] cpuset: Add new v2 cpuset.sched.domain flag
Message-ID: <20180524154156.GI12198@hirez.programming.kicks-ass.net>
References: <1526590545-3350-1-git-send-email-longman@redhat.com>
 <1526590545-3350-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526590545-3350-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 04:55:41PM -0400, Waiman Long wrote:
> A new cpuset.sched.domain boolean flag is added to cpuset v2. This new
> flag indicates that the CPUs in the current cpuset should be treated
> as a separate scheduling domain.

The traditional name for this is a partition.

>                                  This new flag is owned by the parent
> and will cause the CPUs in the cpuset to be removed from the effective
> CPUs of its parent.

This is a significant departure from existing behaviour, but one I can
appreciate. I don't immediately see something terribly wrong with it.

> This is implemented internally by adding a new isolated_cpus mask that
> holds the CPUs belonging to child scheduling domain cpusets so that:
> 
> 	isolated_cpus | effective_cpus = cpus_allowed
> 	isolated_cpus & effective_cpus = 0
> 
> This new flag can only be turned on in a cpuset if its parent is either
> root or a scheduling domain itself with non-empty cpu list. The state
> of this flag cannot be changed if the cpuset has children.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  Documentation/cgroup-v2.txt |  22 ++++
>  kernel/cgroup/cpuset.c      | 237 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 256 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
> index cf7bac6..54d9e22 100644
> --- a/Documentation/cgroup-v2.txt
> +++ b/Documentation/cgroup-v2.txt
> @@ -1514,6 +1514,28 @@ Cpuset Interface Files
>  	it is a subset of "cpuset.mems".  Its value will be affected
>  	by memory nodes hotplug events.
>  
> +  cpuset.sched.domain
> +	A read-write single value file which exists on non-root
> +	cpuset-enabled cgroups.  It is a binary value flag that accepts
> +	either "0" (off) or a non-zero value (on).

I would be conservative and only allow 0/1.

>                                                  This flag is set
> +	by the parent and is not delegatable.
> +
> +	If set, it indicates that the CPUs in the current cgroup will
> +	be the root of a scheduling domain.  The root cgroup is always
> +	a scheduling domain.  There are constraints on where this flag
> +	can be set.  It can only be set in a cgroup if all the following
> +	conditions are true.
> +
> +	1) The parent cgroup is also a scheduling domain with a non-empty
> +	   cpu list.

Ah, so initially I was confused by the requirement for root to have it
always set, but you'll allow child domains to steal _all_ CPUs, such
that root ends up with an empty effective set?

What about the (kernel) threads that cannot be moved out of the root
group?

> +	2) The list of CPUs are exclusive, i.e. they are not shared by
> +	   any of its siblings.

Right.

> +	3) There is no child cgroups with cpuset enabled.
> +
> +	Setting this flag will take the CPUs away from the effective
> +	CPUs of the parent cgroup. Once it is set, this flag cannot be
> +	cleared if there are any child cgroups with cpuset enabled.

This I'm not clear on. Why?
