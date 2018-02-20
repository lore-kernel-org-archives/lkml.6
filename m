Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeBTS0R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:26:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbeBTS0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:26:16 -0500
Date: Tue, 20 Feb 2018 19:26:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] sched/fair: Avoid unnecessary balancing of
 asymmetric capacity groups
Message-ID: <20180220182605.GI25201@hirez.programming.kicks-ass.net>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
 <1518711654-23503-5-git-send-email-morten.rasmussen@arm.com>
 <20180219151011.GI25181@hirez.programming.kicks-ass.net>
 <20180220163352.GD4589@e105550-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220163352.GD4589@e105550-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 04:33:52PM +0000, Morten Rasmussen wrote:
> On Mon, Feb 19, 2018 at 04:10:11PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 15, 2018 at 04:20:51PM +0000, Morten Rasmussen wrote:
> > > +/*
> > > + * group_similar_cpu_capacity: Returns true if the minimum capacity of the
> > > + * compared groups differ by less than 12.5%.
> > > + */
> > > +static inline bool
> > > +group_similar_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
> > > +{
> > > +	long diff = sg->sgc->min_capacity - ref->sgc->min_capacity;
> > > +	long max = max(sg->sgc->min_capacity, ref->sgc->min_capacity);
> > > +
> > > +	return abs(diff) < max >> 3;
> > > +}
> > 
> > This seems a fairly random and dodgy heuristic.
> 
> I can't deny that :-)
> 
> We need to somehow figure out if we are doing asymmetric cpu capacity
> balancing or normal SMP balancing. We probably don't care about
> migrating tasks if the capacities are nearly identical. But how much is
> 'nearly'?
> 
> We could make it strictly equal as long as sgc->min_capacity is based on
> capacity_orig. If we let things like rt-pressure influence
> sgc->min_capacity, it might become a mess.

See, that is the problem, I think it this min_capacity thing is
influenced by rt-pressure and the like.

See update_cpu_capacity(), min_capacity is set after we add the RT scale
factor thingy, and then update_group_capacity() filters the min of the
whole group. The thing only ever goes down.

But this means that if a big CPU has a very high IRQ/RT load, its
capacity will dip below that of a little core and min_capacity for the
big group as a whole will appear smaller than that of the little group.

Or am I now terminally confused again?
