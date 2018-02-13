Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965038AbeBMOBp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:01:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52186 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964991AbeBMOBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:01:44 -0500
Date: Tue, 13 Feb 2018 15:01:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] sched/numa: Delay retrying placement for automatic
 NUMA balance after wake_affine
Message-ID: <20180213140137.GN25201@hirez.programming.kicks-ass.net>
References: <20180213133730.24064-1-mgorman@techsingularity.net>
 <20180213133730.24064-7-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213133730.24064-7-mgorman@techsingularity.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 01:37:30PM +0000, Mel Gorman wrote:
> +static void
> +update_wa_numa_placement(struct task_struct *p, int prev_cpu, int target)
> +{
> +	unsigned long interval;
> +
> +	if (!static_branch_likely(&sched_numa_balancing))
> +		return;
> +
> +	/* If balancing has no preference then continue gathering data */
> +	if (p->numa_preferred_nid == -1)
> +		return;
> +
> +	/*
> +	 * If the wakeup is not affecting locality then it is neutral from
> +	 * the perspective of NUMA balacing so continue gathering data.
> +	 */
> +	if (cpus_share_cache(prev_cpu, target))
> +		return;

Dang, I wanted to mention this before, but it slipped my mind. The
comment and code don't match.

Did you want to write:

	if (cpu_to_node(prev_cpu) == cpu_to_node(target))
		return;

> +	/*
> +	 * Temporarily prevent NUMA balancing trying to place waker/wakee after
> +	 * wakee has been moved by wake_affine. This will potentially allow
> +	 * related tasks to converge and update their data placement. The
> +	 * 4 * numa_scan_period is to allow the two-pass filter to migrate
> +	 * hot data to the wakers node.
> +	 */
> +	interval = max(sysctl_numa_balancing_scan_delay,
> +			 p->numa_scan_period << 2);
> +	p->numa_migrate_retry = jiffies + msecs_to_jiffies(interval);
> +
> +	interval = max(sysctl_numa_balancing_scan_delay,
> +			 current->numa_scan_period << 2);
> +	current->numa_migrate_retry = jiffies + msecs_to_jiffies(interval);
> +}
