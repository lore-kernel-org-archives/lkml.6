Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbeCIQfa convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:35:30 -0500
Received: from mout.gmx.net ([212.227.17.20]:43375 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751182AbeCIQf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:35:28 -0500
Message-ID: <1520613285.12489.36.camel@gmx.de>
Subject: Re: [PATCH v4] cpuset: Enable cpuset controller in default hierarchy
From: Mike Galbraith <efault@gmx.de>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
Date: Fri, 09 Mar 2018 17:34:45 +0100
In-Reply-To: <1520609707-16582-1-git-send-email-longman@redhat.com>
References: <1520609707-16582-1-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:+S/aaXwuBJ56qklBd3mhvKMqYFiglnclLgp9VfQCGdf9VQU9cCS
 Ae/8CmFOIsC5tm0pKqvqu4BSLv1qVWY71DLjwuKbR06byjujaV8WWbjCbOPfTHbtCz/MatH
 XyV5THAHAJIGQewgJPsXyfWNGoNGVbwjSUP0+mNi4L6xsoLv1SAR884CpE341ar9mr6CkmE
 XR6gd8jZX6SQlTPBWVLkA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FCbiaOOKdjg=:HKw19xnQ3q+USoi+RuPJuR
 SbQB7PizuwwfAG1vSNnZ4Tu7NUodeTggIo6201nWRxpvWUhlvK/5ck5Oz4N5xdwZl4zc3qUTV
 WfOXE3mV/dd9vHz+J08vf0BE0Z641eofhGiSXk0JD7e0FzeFNha8F3h/S7pfAwvolTPNbyXtC
 r4PLIAY6/iu06UykE4GAU7T9N7hGxGXW6/qqV46rQZWQO5Uz8wpZo6iZRQUseP+UYl1gBupDY
 mCLOKXN1851X5BcQAl1bYDl60noGmO7mUDnFj6Y1ExdDI4Gjk4xBnTY1LTJsA4RXhA9+3w0F5
 RsNe6kxoG3r4Yd9yFoMYq9fmeCuDiT2wrF+OHwx81EMcZGpRZN/+NUsg1PznIG20cAz0siPE7
 MRMrCcxh+lN6zEpZT2ZP/ulN3kbKmZwNcLARDPBU3sFqGTGO/xl9warpCgb7xEqrU810rIj8r
 0ugc1wMfEsEKSm0gTlR/oegXwdf2mAoGIvEXdRxDeW/TPMVUUv4SJMTt9Gdby9txaM3DCabVz
 8F8JEulbCbTI06l7wN7z28/6frWeHCdi14vpDmxjB2Qsu3qCKv1mNatFZIBawQPK2RcVD7BZ7
 aVWOEEv1rLQlIdlh+24PbibX/pwd2RsLCOIjIQB9w/mEQI79BFJwjEPr8fU3aG4i52wEnl6Hd
 RdfyZdgP5RDq71u2nrPDgv3nNyukEYn4FtzML5vCcehAiRrgXTS6tatpKh1X1y24GfB16COHx
 hm8BIbjAWO0jm1nfjAwk31GufF8SBhMYaz/2CnMW9GdnCahcLBW6E6vYm5IMZToQXy8PnMPDP
 +ThK5wrRrDP0u7o0L3FoPeBEyLck1nsHVKqc+A5L17iwaHrHJ0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-09 at 10:35 -0500, Waiman Long wrote:
> Given the fact that thread mode had been merged into 4.14, it is now
> time to enable cpuset to be used in the default hierarchy (cgroup v2)
> as it is clearly threaded.
> 
> The cpuset controller had experienced feature creep since its
> introduction more than a decade ago. Besides the core cpus and mems
> control files to limit cpus and memory nodes, there are a bunch of
> additional features that can be controlled from the userspace. Some of
> the features are of doubtful usefulness and may not be actively used.

One rather important features is the ability to dynamically partition a
box and isolate critical loads.  How does one do that with v2?

In v1, you create two or more exclusive sets, one for generic
housekeeping, and one or more for critical load(s), RT in my case,
turning off load balancing in the critical set(s) for obvious reasons.

> This patch enables cpuset controller in the default hierarchy with
> a minimal set of features, namely just the cpus and mems and their
> effective_* counterparts.  We can certainly add more features to the
> default hierarchy in the future if there is a real user need for them
> later on.
> 
> Alternatively, with the unified hiearachy, it may make more sense
> to move some of those additional cpuset features, if desired, to
> memory controller or may be to the cpu controller instead of staying
> with cpuset.
> 
> v4:
>  - Further minimize the feature set by removing the flags control knob.
> 
> v3:
>  - Further trim the additional features down to just memory_migrate.
>  - Update Documentation/cgroup-v2.txt.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  Documentation/cgroup-v2.txt | 96 ++++++++++++++++++++++++++++++++++++++++-----
>  kernel/cgroup/cpuset.c      | 44 +++++++++++++++++++--
>  2 files changed, 127 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
> index 74cdeae..8d7300f 100644
> --- a/Documentation/cgroup-v2.txt
> +++ b/Documentation/cgroup-v2.txt
> @@ -48,16 +48,18 @@ v1 is available under Documentation/cgroup-v1/.
>         5-2-1. Memory Interface Files
>         5-2-2. Usage Guidelines
>         5-2-3. Memory Ownership
> -     5-3. IO
> -       5-3-1. IO Interface Files
> -       5-3-2. Writeback
> -     5-4. PID
> -       5-4-1. PID Interface Files
> -     5-5. Device
> -     5-6. RDMA
> -       5-6-1. RDMA Interface Files
> -     5-7. Misc
> -       5-7-1. perf_event
> +     5-3. Cpuset
> +       5.3-1. Cpuset Interface Files
> +     5-4. IO
> +       5-4-1. IO Interface Files
> +       5-4-2. Writeback
> +     5-5. PID
> +       5-5-1. PID Interface Files
> +     5-6. Device
> +     5-7. RDMA
> +       5-7-1. RDMA Interface Files
> +     5-8. Misc
> +       5-8-1. perf_event
>       5-N. Non-normative information
>         5-N-1. CPU controller root cgroup process behaviour
>         5-N-2. IO controller root cgroup process behaviour
> @@ -1243,6 +1245,80 @@ POSIX_FADV_DONTNEED to relinquish the ownership of memory areas
>  belonging to the affected files to ensure correct memory ownership.
>  
>  
> +Cpuset
> +------
> +
> +The "cpuset" controller provides a mechanism for constraining
> +the CPU and memory node placement of tasks to only the resources
> +specified in the cpuset interface files in a task's current cgroup.
> +This is especially valuable on large NUMA systems where placing jobs
> +on properly sized subsets of the systems with careful processor and
> +memory placement to reduce cross-node memory access and contention
> +can improve overall system performance.
> +
> +The "cpuset" controller is hierarchical.  That means the controller
> +cannot use CPUs or memory nodes not allowed in its parent.
> +
> +
> +Cpuset Interface Files
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +  cpuset.cpus
> +	A read-write multiple values file which exists on non-root
> +	cgroups.
> +
> +	It lists the CPUs allowed to be used by tasks within this
> +	cgroup.  The CPU numbers are comma-separated numbers or
> +	ranges.  For example:
> +
> +	  # cat cpuset.cpus
> +	  0-4,6,8-10
> +
> +	An empty value indicates that the cgroup is using the same
> +	setting as the nearest cgroup ancestor with a non-empty
> +	"cpuset.cpus" or all the available CPUs if none is found.
> +
> +	The value of "cpuset.cpus" stays constant until the next update
> +	and won't be affected by any CPU hotplug events.
> +
> +  cpuset.effective_cpus
> +	A read-only multiple values file which exists on non-root
> +	cgroups.
> +
> +	It lists the onlined CPUs that are actually allowed to be
> +	used by tasks within the current cgroup. It is a subset of
> +	"cpuset.cpus". Its value will be affected by CPU hotplug
> +	events.
> +
> +  cpuset.mems
> +	A read-write multiple values file which exists on non-root
> +	cgroups.
> +
> +	It lists the memory nodes allowed to be used by tasks within
> +	this cgroup.  The memory node numbers are comma-separated
> +	numbers or ranges.  For example:
> +
> +	  # cat cpuset.mems
> +	  0-1,3
> +
> +	An empty value indicates that the cgroup is using the same
> +	setting as the nearest cgroup ancestor with a non-empty
> +	"cpuset.mems" or all the available memory nodes if none
> +	is found.
> +
> +	The value of "cpuset.mems" stays constant until the next update
> +	and won't be affected by any memory nodes hotplug events.
> +
> +  cpuset.effective_mems
> +	A read-only multiple values file which exists on non-root
> +	cgroups.
> +
> +	It lists the onlined memory nodes that are actually allowed
> +	to be used by tasks within the current cgroup. It is a subset
> +	of "cpuset.mems". Its value will be affected by memory nodes
> +	hotplug events.
> +
> +
>  IO
>  --
>  
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index b42037e..7837d1f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1823,12 +1823,11 @@ static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
>  	return 0;
>  }
>  
> -
>  /*
>   * for the common functions, 'private' gives the type of file
>   */
>  
> -static struct cftype files[] = {
> +static struct cftype legacy_files[] = {
>  	{
>  		.name = "cpus",
>  		.seq_show = cpuset_common_seq_show,
> @@ -1931,6 +1930,43 @@ static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
>  };
>  
>  /*
> + * This is currently a minimal set for the default hierarchy. It can be
> + * expanded later on by migrating more features and control files from v1.
> + */
> +static struct cftype dfl_files[] = {
> +	{
> +		.name = "cpus",
> +		.seq_show = cpuset_common_seq_show,
> +		.write = cpuset_write_resmask,
> +		.max_write_len = (100U + 6 * NR_CPUS),
> +		.private = FILE_CPULIST,
> +	},
> +
> +	{
> +		.name = "mems",
> +		.seq_show = cpuset_common_seq_show,
> +		.write = cpuset_write_resmask,
> +		.max_write_len = (100U + 6 * MAX_NUMNODES),
> +		.private = FILE_MEMLIST,
> +	},
> +
> +	{
> +		.name = "effective_cpus",
> +		.seq_show = cpuset_common_seq_show,
> +		.private = FILE_EFFECTIVE_CPULIST,
> +	},
> +
> +	{
> +		.name = "effective_mems",
> +		.seq_show = cpuset_common_seq_show,
> +		.private = FILE_EFFECTIVE_MEMLIST,
> +	},
> +
> +	{ }	/* terminate */
> +};
> +
> +
> +/*
>   *	cpuset_css_alloc - allocate a cpuset css
>   *	cgrp:	control group that the new cpuset will be part of
>   */
> @@ -2104,8 +2140,10 @@ struct cgroup_subsys cpuset_cgrp_subsys = {
>  	.post_attach	= cpuset_post_attach,
>  	.bind		= cpuset_bind,
>  	.fork		= cpuset_fork,
> -	.legacy_cftypes	= files,
> +	.legacy_cftypes	= legacy_files,
> +	.dfl_cftypes	= dfl_files,
>  	.early_init	= true,
> +	.threaded	= true,
>  };
>  
>  /**
