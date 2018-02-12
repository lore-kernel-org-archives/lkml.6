Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753763AbeBLRio (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:38:44 -0500
Received: from casper.infradead.org ([85.118.1.10]:37910 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbeBLRin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:38:43 -0500
Date: Mon, 12 Feb 2018 18:37:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/numa: Delay retrying placement for automatic
 NUMA balance after wake_affine
Message-ID: <20180212173743.GB25201@hirez.programming.kicks-ass.net>
References: <20180212171131.26139-1-mgorman@techsingularity.net>
 <20180212171131.26139-3-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212171131.26139-3-mgorman@techsingularity.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 05:11:31PM +0000, Mel Gorman wrote:
> +static void
> +update_wa_numa_placement(struct task_struct *p, int prev_cpu, int target)
> +{
> +	unsigned long interval;
> +
> +	if (!static_branch_likely(&sched_numa_balancing))
> +		return;
> +
> +	/* If balancing has no preference then accept the target */
> +	if (p->numa_preferred_nid == -1)
> +		return;
> +
> +	/* If the wakeup is not affecting locality then accept the target */
> +	if (cpus_share_cache(prev_cpu, target))
> +		return;

Both the above comments speak of 'accepting' the target, but its a void
function, there's nothing they can do about it. It cannot not accept the
placement.

> +
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

Otherwise that makes sense.
