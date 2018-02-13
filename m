Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935443AbeBMOnr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:43:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33554 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935243AbeBMOnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:43:46 -0500
Date: Tue, 13 Feb 2018 15:43:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] sched/numa: Delay retrying placement for automatic
 NUMA balance after wake_affine
Message-ID: <20180213144326.GO25201@hirez.programming.kicks-ass.net>
References: <20180213133730.24064-1-mgorman@techsingularity.net>
 <20180213133730.24064-7-mgorman@techsingularity.net>
 <20180213140137.GN25201@hirez.programming.kicks-ass.net>
 <20180213141812.ikin7n2owi5uor3b@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213141812.ikin7n2owi5uor3b@techsingularity.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 02:18:12PM +0000, Mel Gorman wrote:
> On Tue, Feb 13, 2018 at 03:01:37PM +0100, Peter Zijlstra wrote:
> > On Tue, Feb 13, 2018 at 01:37:30PM +0000, Mel Gorman wrote:
> > > +static void
> > > +update_wa_numa_placement(struct task_struct *p, int prev_cpu, int target)
> > > +{
> > > +	unsigned long interval;
> > > +
> > > +	if (!static_branch_likely(&sched_numa_balancing))
> > > +		return;
> > > +
> > > +	/* If balancing has no preference then continue gathering data */
> > > +	if (p->numa_preferred_nid == -1)
> > > +		return;
> > > +
> > > +	/*
> > > +	 * If the wakeup is not affecting locality then it is neutral from
> > > +	 * the perspective of NUMA balacing so continue gathering data.
> > > +	 */
> > > +	if (cpus_share_cache(prev_cpu, target))
> > > +		return;
> > 
> > Dang, I wanted to mention this before, but it slipped my mind. The
> > comment and code don't match.
> > 
> > Did you want to write:
> > 
> > 	if (cpu_to_node(prev_cpu) == cpu_to_node(target))
> > 		return;
> > 
> 
> Well, it was deliberate. While it's possible to be on the same memory
> node and not sharing cache, the scheduler typically is more concerned with
> the LLC than NUMA per-se. If they share LLC, then I also assume that they
> share memory locality.

True, but the remaining code only has effect for numa balance, which is
concerned with nodes. So I don't see the point of using something
potentially smaller.

Suppose someone did hardware where a node has 2 cache clusters, then
we'd still set a wake_affine back-off for numa-balance, even though it
remains on the same node.

How would that be useful?
