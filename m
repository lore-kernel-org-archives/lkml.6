Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614D3C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBE721855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfAXOEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 09:04:38 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57412 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727596AbfAXOEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 09:04:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC351A78;
        Thu, 24 Jan 2019 06:04:37 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 743D23F5C1;
        Thu, 24 Jan 2019 06:04:35 -0800 (PST)
Date:   Thu, 24 Jan 2019 14:04:32 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org, Quentin Perret <quentin.perret@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v7 2/2] sched/fair: update scale invariance of PELT
Message-ID: <20190124140432.2kiprlxzw2cpf35f@e110439-lin>
References: <1542711308-25256-1-git-send-email-vincent.guittot@linaro.org>
 <1542711308-25256-3-git-send-email-vincent.guittot@linaro.org>
 <CAKfTPtD=sV3zJiZMfCFi92_f6j-jTO9D5RsEBAXHVa6VN3Urwg@mail.gmail.com>
 <20181128100241.GA2131@hirez.programming.kicks-ass.net>
 <20181128115336.GB23094@e110439-lin>
 <20181129125348.GL2131@hirez.programming.kicks-ass.net>
 <20181129151316.GG23094@e110439-lin>
 <20190124090755.GC13536@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124090755.GC13536@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-Jan 10:07, Peter Zijlstra wrote:
> 
> Sorry; trying to get back to this and re-reading the old conversations.
> 
> On Thu, Nov 29, 2018 at 03:13:16PM +0000, Patrick Bellasi wrote:
> > On 29-Nov 13:53, Peter Zijlstra wrote:
> > > On Wed, Nov 28, 2018 at 11:53:36AM +0000, Patrick Bellasi wrote:
> > > 
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index ac855b2f4774..93e0cf5d8a76 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -3661,6 +3661,10 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
> > > >  	if (!task_sleep)
> > > >  		return;
> > > > 
> > > > +	/* Skip samples which do not represent an actual utilization */
> > > > +	if (unlikely(task_util(p) > capacity_of(task_cpu(p))))
> > > > +		return;
> > > > +
> > > >  	/*
> > > >  	 * If the PELT values haven't changed since enqueue time,
> > > >  	 * skip the util_est update.
> > > 
> > > Would you not want something like:
> > > 
> > > 	min(task_util(p), capacity_of(task_cpu(p)))
> > > 
> > > And is this the only place where we need this?
> > 
> > Mmm... even this could be an over-estimation:
> > 
> > I've just posted an example in my last reply to Vincent, end of:
> > 
> >    Message-ID: <20181129150020.GF23094@e110439-lin>
> >    https://lore.kernel.org/lkml/20181129150020.GF23094@e110439-lin/
> 
> In particular this bit:
> 
>  | Seems we agree that, when there is no idle time:
>  | - the two 15% tasks will be overestimated
>  | - their utilization will reach 50% after a while
> 
> Right?
> 
> > > OTOH, if the task is always running, it will be always running
> > > irrespective of where it runs.
> > 
> > That's not what I'm concerned about. I'm concerned about small tasks
> > which are running on limited capacity (e.g. due to thermal capping)
> > without idle time. In this case, the new "utilization" signal could
> > overestimate the real task needs.
> > 
> > > Not storing these samples seems weird though; this is the exact
> > > condition you want to record -- the task is very active, if we skip
> > > these, we'll come back at a low frequency on the next wakeup.
> > 
> > When there is not idle time, we don't know if the reported
> > utilization, above the cpu capacity, is due to the task being bigger...
> > or just the new utilization signal converging towards:
> > 
> >     100% / RUNNABLE_TASKS_COUNT
> 
> So if I'm not mistaken we then have 3 cases:
> 
>  1) runnable == util <= capacity
> 
>     no contention, idle
> 
>  2) runnable == util > capacity
> 
>     no contention, no idle
> 
>  3) runnable > util
> 
>     contention, no idle
> 
> For 1) we can use: 'util'
> For 2) we can use: 'capacity'
> For 3) we can use: 'util * capacity >> 10'
> 
> (note that 2 is a special case of 3 when u=1)
> 
> This should work right?

I think there is a case, similar to 2, in which the new 'util' could
potentially be used. That's the case for example of a 20% (estimated)
utilization task running alone on a 15% capacity CPU, for a single
activation. In that case such a task will complete and be dequeued
with:

   runnable == util > capacity

The problem is that we need to be sure there was not contention... and
that seems to be difficult to detect.

> Now, instead of doing complicated things like that, you instead figure
> that when there's no idle there's also no dequeue happening and we can
> simply short-cut by skipping the entire thing, forgetting everything
> about 2,3.
> 
> Did I get that right?

More or less... just saying that 1 is the only easy to detect scenario
in which we are granted the utilization represents an actual bandwidth
request and thus the only safe values to sample for estimated
utilization. For the other cases, since anyway:

   util_est := max(max(ewma, last_util), util_avg)

util_est will just keep representing a safe and actually measured
lower-bound for the expected utilization of a task, without
side-affecting the EWMA which has a "slow" update dynamic.

-- 
#include <best/regards.h>

Patrick Bellasi
