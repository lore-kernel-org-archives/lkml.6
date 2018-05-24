Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032268AbeEXKkA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 06:40:00 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43752 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032130AbeEXKjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 06:39:43 -0400
X-Google-Smtp-Source: AB8JxZpPd9Rz5CkullRl/5uMbSF5z+dyc2HH6Y72KkJH/bmgwpCVXQxqrqzl+0cxsz3qP9jltiSfCA==
Date: Thu, 24 May 2018 12:39:38 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v8 4/6] cpuset: Make generate_sched_domains() recognize
 isolated_cpus
Message-ID: <20180524103938.GB3948@localhost.localdomain>
References: <1526590545-3350-1-git-send-email-longman@redhat.com>
 <1526590545-3350-5-git-send-email-longman@redhat.com>
 <20180523173453.GY30654@e110439-lin>
 <bf4cb72b-9ff3-eb8b-ca2c-f6c4fee5c123@redhat.com>
 <20180524090430.GZ30654@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524090430.GZ30654@e110439-lin>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/18 10:04, Patrick Bellasi wrote:

[...]

> From 84bb8137ce79f74849d97e30871cf67d06d8d682 Mon Sep 17 00:00:00 2001
> From: Patrick Bellasi <patrick.bellasi@arm.com>
> Date: Wed, 23 May 2018 16:33:06 +0100
> Subject: [PATCH 1/1] cgroup/cpuset: disable sched domain rebuild when not
>  required
> 
> The generate_sched_domains() already addresses the "special case for 99%
> of systems" which require a single full sched domain at the root,
> spanning all the CPUs. However, the current support is based on an
> expensive sequence of operations which destroy and recreate the exact
> same scheduling domain configuration.
> 
> If we notice that:
> 
>  1) CPUs in "cpuset.isolcpus" are excluded from load balancing by the
>     isolcpus= kernel boot option, and will never be load balanced
>     regardless of the value of "cpuset.sched_load_balance" in any
>     cpuset.
> 
>  2) the root cpuset has load_balance enabled by default at boot and
>     it's the only parameter which userspace can change at run-time.
> 
> we know that, by default, every system comes up with a complete and
> properly configured set of scheduling domains covering all the CPUs.
> 
> Thus, on every system, unless the user explicitly disables load balance
> for the top_cpuset, the scheduling domains already configured at boot
> time by the scheduler/topology code and updated in consequence of
> hotplug events, are already properly configured for cpuset too.
> 
> This configuration is the default one for 99% of the systems,
> and it's also the one used by most of the Android devices which never
> disable load balance from the top_cpuset.
> 
> Thus, while load balance is enabled for the top_cpuset,
> destroying/rebuilding the scheduling domains at every cpuset.cpus
> reconfiguration is a useless operation which will always produce the
> same result.
> 
> Let's anticipate the "special" optimization within:
> 
>    rebuild_sched_domains_locked()
> 
> thus completely skipping the expensive:
> 
>    generate_sched_domains()
>    partition_sched_domains()
> 
> for all the cases we know that the scheduling domains already defined
> will not be affected by whatsoever value of cpuset.cpus.

[...]

> +	/* Special case for the 99% of systems with one, full, sched domain */
> +	if (!top_cpuset.isolation_count &&
> +	    is_sched_load_balance(&top_cpuset))
> +		goto out;
> +

Mmm, looks like we still need to destroy e recreate if there is a
new_topology (see arch_update_cpu_topology() in partition_sched_
domains).

Maybe we could move the check you are proposing in update_cpumasks_
hier() ?
