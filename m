Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757436AbeD0GvD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 02:51:03 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34586 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbeD0GvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 02:51:01 -0400
X-Google-Smtp-Source: AB8JxZrl8SL7gXNO3jStHaGeoBeeANbrJDNHXkKJeFLFqQSces+t/JDXvKf02r6AmaOt6rDL68SObQ==
Date: Fri, 27 Apr 2018 08:50:57 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/numa: Stagger NUMA balancing scan periods for new
 threads
Message-ID: <20180427065057.5l24znpbsb3bdkur@gmail.com>
References: <20180426104830.b3v7kixdnqlrtujb@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426104830.b3v7kixdnqlrtujb@techsingularity.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mel Gorman <mgorman@techsingularity.net> wrote:

> The different in headline performance across a range of machines and
> workloads is marginal but the system CPU usage is reduced due to less scan
> activity.  The following is the time reported by NAS Parallel Benchmark
> using unbound openmp threads and a D size class.
> 
>                       4.17.0-rc1             4.17.0-rc1
>                          vanilla           stagger-v1r1
> Time bt.D      442.77 (   0.00%)      419.70 (   5.21%)
> Time cg.D      171.90 (   0.00%)      180.85 (  -5.21%)
> Time ep.D       33.10 (   0.00%)       32.90 (   0.60%)
> Time is.D        9.59 (   0.00%)        9.42 (   1.77%)
> Time lu.D      306.75 (   0.00%)      304.65 (   0.68%)
> Time mg.D       54.56 (   0.00%)       52.38 (   4.00%)
> Time sp.D     1020.03 (   0.00%)      903.77 (  11.40%)
> Time ua.D      400.58 (   0.00%)      386.49 (   3.52%)
> 
> Note it's not a universal win but we have no prior knowledge of which
> thread matters but the number of threads created often exceeds the size of
> the node when the threads are not bound. On balance, the set of workloads
> complete faster and there is a a reducation of overall system CPU usage
> 
>                             4.17.0-rc1             4.17.0-rc1
>                                vanilla           stagger-v1r1
> sys-time-bt.D         48.78 (   0.00%)       48.22 (   1.15%)
> sys-time-cg.D         25.31 (   0.00%)       26.63 (  -5.22%)
> sys-time-ep.D          1.65 (   0.00%)        0.62 (  62.42%)
> sys-time-is.D         40.05 (   0.00%)       24.45 (  38.95%)
> sys-time-lu.D         37.55 (   0.00%)       29.02 (  22.72%)
> sys-time-mg.D         47.52 (   0.00%)       34.92 (  26.52%)
> sys-time-sp.D        119.01 (   0.00%)      109.05 (   8.37%)
> sys-time-ua.D         51.52 (   0.00%)       45.13 (  12.40%)
> 
> NUMA scan activity is reduced as well as other balancing activity.
> 
> NUMA alloc local               1042828     1342670
> NUMA base PTE updates        140481138    93577468
> NUMA huge PMD updates           272171      180766
> NUMA page range updates      279832690   186129660
> NUMA hint faults               1395972     1193897
> NUMA hint local faults          877925      855053
> NUMA hint local percent             62          71
> NUMA pages migrated           12057909     9158023

Looks like a nice reduction in scanning overhead - which was always the main worry 
with the fault based active NUMA balancing technique.

I have a couple of minor code cleanliness nit:

> +void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
> +{
> +	int mm_users = 0;
> +
> +	if (p->mm) {
> +		mm_users = atomic_read(&p->mm->mm_users);
> +		if (mm_users == 1) {
> +			p->mm->numa_next_scan = jiffies + msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
> +			p->mm->numa_scan_seq = 0;
> +		}
> +	}
> +	p->node_stamp = 0ULL;
> +	p->numa_scan_seq = p->mm ? p->mm->numa_scan_seq : 0;
> +	p->numa_scan_period = sysctl_numa_balancing_scan_delay;
> +	p->numa_work.next = &p->numa_work;
> +	p->numa_faults = NULL;
> +	p->last_task_numa_placement = 0;
> +	p->last_sum_exec_runtime = 0;
> +	p->numa_group = NULL;

While this is pre-existing code that you moved, could we please use a bit more 
organization to make this more readable:

	p->node_stamp			= 0ULL;
	p->numa_scan_seq		= p->mm ? p->mm->numa_scan_seq : 0;
	p->numa_scan_period		= sysctl_numa_balancing_scan_delay;
	p->numa_work.next		= &p->numa_work;
	p->numa_faults			= NULL;
	p->last_task_numa_placement	= 0;
	p->last_sum_exec_runtime	= 0;
	p->numa_group			= NULL;

?

This form made me notice a detail: the 0ULL asymmetry looks weird, this integer 
literal type specification is entirely superfluous here, we can just write '0'.

> +	/* New address space */
> +	if (!(clone_flags & CLONE_VM)) {
> +		p->numa_preferred_nid = -1;
> +		return;
> +	}
> +
> +	/* New thread, use existing preferred nid but stagger scans */
> +	if (p->mm) {
> +		unsigned int delay;
> +
> +		delay = min_t(unsigned int, task_scan_max(current),
> +			current->numa_scan_period * mm_users * NSEC_PER_MSEC);
> +		delay += 2 * TICK_NSEC;
> +		p->numa_preferred_nid = current->numa_preferred_nid;
> +		p->node_stamp = delay;
> +	}

So this is a fork time function, shouldn't p->numa_preferred_nid be equal to 
current->numa_preferred_nid already?

This is what happens in the !p->mm && CLONE_VM case anyway, right?

So we could leave out the superfluous assignment and make it clear in a comment 
that we inherit the parent's ->numa_preferred_nid intentionally.

Also, there's a lot of p->mm use, could we add this helper local variable to 
simplify the code some more:

	struct mm_struct *mm = p->mm;

?

Thanks,

	Ingo
