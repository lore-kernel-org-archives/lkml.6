Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeBTQd5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:33:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45200 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751329AbeBTQd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:33:56 -0500
Date: Tue, 20 Feb 2018 16:33:52 +0000
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] sched/fair: Avoid unnecessary balancing of
 asymmetric capacity groups
Message-ID: <20180220163352.GD4589@e105550-lin.cambridge.arm.com>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
 <1518711654-23503-5-git-send-email-morten.rasmussen@arm.com>
 <20180219151011.GI25181@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219151011.GI25181@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 04:10:11PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 15, 2018 at 04:20:51PM +0000, Morten Rasmussen wrote:
> > +/*
> > + * group_similar_cpu_capacity: Returns true if the minimum capacity of the
> > + * compared groups differ by less than 12.5%.
> > + */
> > +static inline bool
> > +group_similar_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
> > +{
> > +	long diff = sg->sgc->min_capacity - ref->sgc->min_capacity;
> > +	long max = max(sg->sgc->min_capacity, ref->sgc->min_capacity);
> > +
> > +	return abs(diff) < max >> 3;
> > +}
> 
> This seems a fairly random and dodgy heuristic.

I can't deny that :-)

We need to somehow figure out if we are doing asymmetric cpu capacity
balancing or normal SMP balancing. We probably don't care about
migrating tasks if the capacities are nearly identical. But how much is
'nearly'?

We could make it strictly equal as long as sgc->min_capacity is based on
capacity_orig. If we let things like rt-pressure influence
sgc->min_capacity, it might become a mess.

We could tie it to sd->imbalance_pct to make it slightly less arbitrary,
or we can try to drop the margin.

Alternative solutions and preferences are welcome...
