Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeDKKov (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 06:44:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47926 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751409AbeDKKot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 06:44:49 -0400
Date: Wed, 11 Apr 2018 11:44:45 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2] cpufreq/schedutil: Cleanup, document and fix iowait
 boost
Message-ID: <20180411104445.GM14248@e110439-lin>
References: <20180410155931.31973-1-patrick.bellasi@arm.com>
 <20180410193708.GE4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410193708.GE4043@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-Apr 21:37, Peter Zijlstra wrote:
> On Tue, Apr 10, 2018 at 04:59:31PM +0100, Patrick Bellasi wrote:
> > The iowait boosting code has been recently updated to add a progressive
> > boosting behavior which allows to be less aggressive in boosting tasks
> > doing only sporadic IO operations, thus being more energy efficient for
> > example on mobile platforms.
> > 
> > The current code is now however a bit convoluted. Some functionalities
> > (e.g. iowait boost reset) are replicated in different paths and their
> > documentation is slightly misaligned.
> 
> While your patch does seem to improve things, it still has duplicated
> bits in. Eg. the TICK_NSEC clearing exists in both functions.

Yes, that duplication has been added in v2 since, as Viresh pointed
out, iowait boost reset was still broken for IO wait tasks waking up
on a CPU idle for more then TICK_NSEC... we should probably have it on
a separate patch.

> > - sugov_set_iowait_boost: is now in charge only to set/increase the IO
> >      wait boost, every time a task wakes up from an IO wait.
> > 
> > - sugov_iowait_boost: is now in charge to reset/reduce the IO wait
> >      boost, every time a sugov update is triggered, as well as
> >      to (eventually) enforce the currently required IO boost value.
> 
> I'm not sold on those function names; feels like we can do better,
> although I'm struggling to come up with anything sensible just now.

What about something like:

 sugov_iowait_init()
 since here we are mainly initializing the iowait boost

 sugov_iowait_boost()
 since here we are mainly applying the proper boost to each cpu

Although they are not really so different...

> >  
> >  		if (delta_ns > TICK_NSEC) {
> > +			sg_cpu->iowait_boost = iowait
> > +				? sg_cpu->sg_policy->policy->min : 0;
> > +			sg_cpu->iowait_boost_pending = iowait;
> > +			return;
> >  		}
> 
> > +	if (delta_ns > TICK_NSEC) {
> > +		sg_cpu->iowait_boost = 0;
> > +		sg_cpu->iowait_boost_pending = false;
> > +		return;
> > +	}
> 
> Looks like something we can maybe put in a helper or something.

... but we can also probably fold the two chunks above into something
like:

---8<---
static bool sugov_iowait_reset(struct sugov_cpu *sg_cpu, u64 time,
			       bool iowait_boost)
{
	s64 delta_ns = time - sg_cpu->last_update;

	if (delta_ns <= TICK_NSEC)
		return false;

	sg_cpu->iowait_boost = iowait_boost
		? sg_cpu->sg_policy->policy->min : 0;
	sg_cpu->iowait_boost_pending = iowait_boost;

	return true;
}
---8<---

-- 
#include <best/regards.h>

Patrick Bellasi
