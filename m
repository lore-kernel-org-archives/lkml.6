Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756546AbeBPPlJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:41:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41118 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756467AbeBPPlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:41:05 -0500
Date: Fri, 16 Feb 2018 15:41:01 +0000
From: Morten Rasmussen <morten.rasmussen@foss.arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>, mingo@redhat.com,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] sched: Add static_key for asymmetric cpu capacity
 optimizations
Message-ID: <20180216154101.GE28799@e105550-lin.cambridge.arm.com>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
 <1518711654-23503-2-git-send-email-morten.rasmussen@arm.com>
 <20180216134704.GE25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216134704.GE25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 02:47:04PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 15, 2018 at 04:20:48PM +0000, Morten Rasmussen wrote:
> > +static void update_asym_cpucapacity(int cpu)
> > +{
> > +	if (!static_branch_unlikely(&sched_asym_cpucapacity) &&
> > +	    lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY))
> > +		static_branch_enable(&sched_asym_cpucapacity);
> > +}
> 
> That looks odd, why not just:
> 
> 	if (lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY))
> 		static_branch_enable(&sched_asym_cpucapacity);

I actually had that initially and then I misread the implementation of
static_key_enable() as if it trigger the WARN_ON_ONCE() condition if I
enable an already enabled static key. But I see now that it should be
safe to do. 

> ? possibly with:
> 
> 	else
> 		static_branch_disable(&sched_asym_cpucapacity);
> 
> if you want to play funny games :-)

I thought about that too. It could make certain hotplug scenarios even
more expensive. I think we want the sched_asym_cpucapacity code to behave
even if SD_ASYM_CPUCAPACITY isn't set anywhere, so the static key would
be permanently from the point we detect asymmetry and leave it set. This
would be in line with how the smt static key works.
