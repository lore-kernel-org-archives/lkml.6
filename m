Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753542AbeBLRrc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:47:32 -0500
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:52595 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751287AbeBLRrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:47:31 -0500
Date: Mon, 12 Feb 2018 17:47:29 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/fair: Do not migrate due to a sync wakeup on
 exit
Message-ID: <20180212174729.4ftdldlepvcjsqji@techsingularity.net>
References: <20180212145857.8056-1-mgorman@techsingularity.net>
 <20180212145857.8056-5-mgorman@techsingularity.net>
 <20180212173147.GZ25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180212173147.GZ25201@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 06:31:47PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 12, 2018 at 02:58:57PM +0000, Mel Gorman wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 28c8d9c91955..50442697b455 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5710,8 +5710,14 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
> >  	if (idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
> >  		return idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
> >  
> > -	if (sync && cpu_rq(this_cpu)->nr_running == 1)
> > +	if (sync && cpu_rq(this_cpu)->nr_running == 1) {
> > +		/* Avoid tasks exiting pulling parents to new nodes */
> > +		if ((current->flags & PF_EXITING) &&
> > +		    !cpus_share_cache(this_cpu, prev_cpu))
> > +			return prev_cpu;
> > +
> 
> Cute, but should we not kill @sync right at the source in this case?
> 
> Something a little like this?
> 

That works too but note that it has a slightly disadvantage in that we
add weight to the select_task_rq_fair fast path for all wakeups, not just
those that are affine. It's also not 100% functionally equivalent as I was
still allowing parents to migrate to the CPU if it shared cache although I
expect any advantage there is marginal. I can replace my patch with yours
if you really prefer it as the overhead in the fast path should be marginal.

-- 
Mel Gorman
SUSE Labs
