Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeEBKYe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 06:24:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeEBKYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 06:24:30 -0400
Date: Wed, 2 May 2018 12:24:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v7 2/5] cpuset: Add cpuset.sched_load_balance to v2
Message-ID: <20180502102416.GJ12180@hirez.programming.kicks-ass.net>
References: <1524145624-23655-1-git-send-email-longman@redhat.com>
 <1524145624-23655-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524145624-23655-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 09:47:01AM -0400, Waiman Long wrote:
> +  cpuset.sched_load_balance
> +	A read-write single value file which exists on non-root cgroups.

Uhhm.. it should very much exist in the root group too. Otherwise you
cannot disable it there, which is required to allow smaller groups to
load-balance between themselves.

> +	The default is "1" (on), and the other possible value is "0"
> +	(off).
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
> +	This flag is hierarchical and is inherited by child cpusets. It
> +	can be turned off only when the CPUs in this cpuset aren't
> +	listed in the cpuset.cpus of other sibling cgroups, and all
> +	the child cpusets, if present, have this flag turned off.
> +
> +	Once it is off, it cannot be turned back on as long as the
> +	parent cgroup still has this flag in the off state.

That too is wrong and broken. You explicitly want to turn it on for
children.

So the idea is that you can have:

		R
	      /   \
            A       B

With:

	R cpus=0-3, load_balance=0
	A cpus=0-1, load_balance=1
	B cpus=2-3, load_balance=1

Which will allow all tasks in A,B (and its children) to load-balance
across 0-1 or 2-3 resp.

If you don't allow the root group to disable load_balance, it will
always be the largest group and load-balancing will always happen system
wide.
