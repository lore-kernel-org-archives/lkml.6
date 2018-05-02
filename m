Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeEBOIw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:08:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbeEBOIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:08:50 -0400
Date: Wed, 2 May 2018 16:08:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v7 3/5] cpuset: Add a root-only cpus.isolated v2 control
 file
Message-ID: <20180502140835.GK12180@hirez.programming.kicks-ass.net>
References: <1524145624-23655-1-git-send-email-longman@redhat.com>
 <1524145624-23655-4-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524145624-23655-4-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 09:47:02AM -0400, Waiman Long wrote:
> diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
> index c970bd7..8d89dc2 100644
> --- a/Documentation/cgroup-v2.txt
> +++ b/Documentation/cgroup-v2.txt
> @@ -1484,6 +1484,31 @@ Cpuset Interface Files
>  	a subset of "cpuset.cpus".  Its value will be affected by CPU
>  	hotplug events.
>  
> +  cpuset.cpus.isolated
> +	A read-write multiple values file which exists on root cgroup
> +	only.
> +
> +	It lists the CPUs that have been withdrawn from the root cgroup
> +	for load balancing.  These CPUs can still be allocated to child
> +	cpusets with load balancing enabled, if necessary.
> +
> +	If a child cpuset contains only an exclusive set of CPUs that are
> +	a subset of the isolated CPUs and with load balancing enabled,
> +	these CPUs will be load balanced on a separate root domain from
> +	the one in the root cgroup.
> +
> +	Just putting the CPUs into "cpuset.cpus.isolated" will be
> +	enough to disable load balancing on those CPUs as long as they
> +	do not appear in a child cpuset with load balancing enabled.
> +	Fine-grained control of cpu isolation can also be done by
> +	putting these isolated CPUs into child cpusets with load
> +	balancing disabled.
> +
> +	The "cpuset.cpus.isolated" should be set up before child
> +	cpusets are created.  Once child cpusets are present, changes
> +	to "cpuset.cpus.isolated" will not be allowed if the CPUs that
> +	change their states are in any of the child cpusets.
> +

So I see why you did this, but it is _really_ ugly and breaks the
container invariant.

Ideally we'd make the root group less special, not more special.
