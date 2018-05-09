Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934437AbeEIImb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:42:31 -0400
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:38122 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934264AbeEIIlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:41:51 -0400
Date: Wed, 9 May 2018 09:41:48 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: torvalds@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, efault@gmx.de, linux-kernel@vger.kernel.org,
        matt@codeblueprint.co.uk, peterz@infradead.org, ggherdovich@suse.cz,
        linux-tip-commits@vger.kernel.org, mpe@ellerman.id.au
Subject: Re: [tip:sched/core] sched/numa: Delay retrying placement for
 automatic NUMA balance after wake_affine()
Message-ID: <20180509084148.qzpsetz74pkg7g33@techsingularity.net>
References: <20180213133730.24064-7-mgorman@techsingularity.net>
 <tip-7347fc87dfe6b7315e74310ee1243dc222c68086@git.kernel.org>
 <20180507110607.GA3828@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180507110607.GA3828@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 04:06:07AM -0700, Srikar Dronamraju wrote:
> > @@ -1876,7 +1877,18 @@ static void numa_migrate_preferred(struct task_struct *p)
> >
> >  	/* Periodically retry migrating the task to the preferred node */
> >  	interval = min(interval, msecs_to_jiffies(p->numa_scan_period) / 16);
> > -	p->numa_migrate_retry = jiffies + interval;
> > +	numa_migrate_retry = jiffies + interval;
> > +
> > +	/*
> > +	 * Check that the new retry threshold is after the current one. If
> > +	 * the retry is in the future, it implies that wake_affine has
> > +	 * temporarily asked NUMA balancing to backoff from placement.
> > +	 */
> > +	if (numa_migrate_retry > p->numa_migrate_retry)
> > +		return;
> 
> The above check looks wrong. This check will most likely to be true,
> numa_migrate_preferred() itself is called either when jiffies >
> p->numa_migrate_retry or if the task's numa_preferred_nid has changed.
> 

Sorry for the delay getting back -- viral infections combined with a public
day off is slowing me.

You're right, without affine wakeups with a wakeup-intensive workload
the path may never be hit and with the current code, it effectively acts
as a broken throttling mechanism. However, I've confirmed that "fixing"
it has mixed results with many regressions on x86 for both 2 and 4 socket
boxes. I need time to think about it and see if this can be fixed without
introducing another regression. I'll also check if a plain revert is the
way to go for a short-term fix and then revisit it.

Thanks Srikar.

-- 
Mel Gorman
SUSE Labs
