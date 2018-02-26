Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754212AbeBZPJL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:09:11 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51324 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754033AbeBZPGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:06:21 -0500
Date: Mon, 26 Feb 2018 15:06:17 +0000
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] sched/fair: Avoid unnecessary balancing of
 asymmetric capacity groups
Message-ID: <20180226150617.GF4589@e105550-lin.cambridge.arm.com>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
 <1518711654-23503-5-git-send-email-morten.rasmussen@arm.com>
 <20180219151011.GI25181@hirez.programming.kicks-ass.net>
 <20180220163352.GD4589@e105550-lin.cambridge.arm.com>
 <20180220182605.GI25201@hirez.programming.kicks-ass.net>
 <20180223163806.GE4589@e105550-lin.cambridge.arm.com>
 <20180223164752.GW25181@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223164752.GW25181@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 05:47:52PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 23, 2018 at 04:38:06PM +0000, Morten Rasmussen wrote:
> > > Or am I now terminally confused again?
> > 
> > No, I think you are right, or I'm equally confused.
> 
> :-)
> 
> Would it make sense to also track max_capacity, but then based on the
> value before RT scaling ?
> 
> That should readily be able to distinguish between big and little
> clusters, although then DynamiQ would still completely ruin things.

IIRC, I did actually track max_capacity to begin with for the wake_cap()
stuff, but someone suggested to use min_capacity instead to factor in
the RT scaling as it could potentially help some use-cases.

I can add unscaled max_capacity tracking and use that as this is
primarily a solution for asymmetric cpu capacity system.

Whether we track max or min shouldn't really matter if it is based on
original capacity, unless you have a DynamiQ system. For DynamiQ system
it depends on how it is configured. If it is a single DynamiQ cluster we
will have just on sched_domain with per-cpu sched_groups, so we don't
have balancing between mixed groups. If we have multiple DynamiQ
clusters, we can have mixed groups, homogeneous groups, or both
depending on the system configuration. Homogeneous groups should be
okay, mixed groups could work okay, I think, as long as all group have
the same mix, a mix of mixed groups is going to be a challenge. Most
likely we would have to treat all these groups as one and ignore cache
boundaries for scheduling decisions.

We are slowly getting into the mess of which capacity should be used for
various conditions. Is it the original capacity (unscaled and at the
highest frequency), do we subtract the RT utilization, and what if the
thermal framework has disabled some of the higher frequencies?

Particularly, the fact that constraints impose by RT and thermal are not
permanent and might change depending on the use-case and how we place
the tasks. But that is a longer discussion to be had.
