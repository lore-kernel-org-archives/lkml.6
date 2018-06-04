Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753584AbeFDPQv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:16:51 -0400
Received: from foss.arm.com ([217.140.101.70]:44840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750868AbeFDPQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:16:50 -0400
Date: Mon, 4 Jun 2018 16:16:42 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Quentin Perret <quentin.perret@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com
Subject: Re: [PATCH v5 03/10] cpufreq/schedutil: add rt utilization tracking
Message-ID: <20180604151642.GB32302@e110439-lin>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-4-git-send-email-vincent.guittot@linaro.org>
 <20180530164601.GC2174@e108498-lin.cambridge.arm.com>
 <20180531084607.GB17937@localhost.localdomain>
 <20180601162357.GT12180@hirez.programming.kicks-ass.net>
 <20180601172359.GN30654@e110439-lin>
 <20180604101751.GB3082@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604101751.GB3082@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-Jun 11:17, Quentin Perret wrote:
> On Friday 01 Jun 2018 at 18:23:59 (+0100), Patrick Bellasi wrote:
> > On 01-Jun 18:23, Peter Zijlstra wrote:
> > > On Thu, May 31, 2018 at 10:46:07AM +0200, Juri Lelli wrote:
> > > > On 30/05/18 17:46, Quentin Perret wrote:

[...]

> > > There might be something there, IIRC that tracks the max potential
> > > utilization for the running tasks. So at that point we can set a
> > > frequency to minimize idle time.
> > 
> > Or we can do the opposite: we go to max by default (as it is now) and
> > if you think that some RT tasks don't need the full speed, you can
> > apply a util_max to them.
> > 
> > That way, when a RT task is running alone on a CPU, we can run it
> > only at a custom max freq which is known to be ok according to your
> > latency requirements.
> > 
> > If instead it's running with other CFS tasks, we add already the CFS
> > utilization, which will result into a speedup of the RT task to give
> > back the CPU to CFS.
> 
> Hmmm why not setting a util_min constraint instead ? The default for a
> RT task should be a util_min of 1024, which means go to max. And then
> if userspace has knowledge about the tasks it could decide to lower the
> util_min value. That way, you would still let the util_avg grow if a
> RT task runs flat out for a long time, and you would still be able to go
> to higher frequencies. But if the util of the RT tasks is very low, you
> wouldn't necessarily run at max freq, you would run at the freq matching
> the util_min constraint.
> 
> So you probably want to: 1) forbid setting max_util constraints for RT;
> 2) have schedutil look at the min-capped RT util if rt_nr_running > 0;
> and 3) have schedutil look at the non-capped RT util if rt_nr_running == 0.
> 
> Does that make any sense ?

I would say that it "could" make sense... it really depends on
use-space IMO. You could have long running RT tasks which still you
don't want to run at max OPP for power/energy concerns, maybe?

Anyway, the good point is that this is a user-space policy.

Right now we do not do anything special for RT task from the
util_clamp side.  The user-space is in charge to configure it
correctly, and it could also very well decide to use different clamps
for different RT tasks, maybe.
Thus, I would probably avoid the special cases you describe in the
above last two points.

-- 
#include <best/regards.h>

Patrick Bellasi
