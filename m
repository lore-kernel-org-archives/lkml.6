Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1376DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E286F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfAVKx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:53:56 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50732 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbfAVKxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:53:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FC60A78;
        Tue, 22 Jan 2019 02:53:55 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C04B3F6A8;
        Tue, 22 Jan 2019 02:53:52 -0800 (PST)
Date:   Tue, 22 Jan 2019 10:53:49 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 04/16] sched/core: uclamp: Add CPU's clamp buckets
 refcounting
Message-ID: <20190122105349.d6fhx3y6nb24t7zd@e110439-lin>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-5-patrick.bellasi@arm.com>
 <20190121151717.GK27931@hirez.programming.kicks-ass.net>
 <20190121155407.gv4cxpg2njqmdlj5@e110439-lin>
 <20190122100342.GO27931@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122100342.GO27931@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-Jan 11:03, Peter Zijlstra wrote:
> On Mon, Jan 21, 2019 at 03:54:07PM +0000, Patrick Bellasi wrote:
> > On 21-Jan 16:17, Peter Zijlstra wrote:
> > > On Tue, Jan 15, 2019 at 10:15:01AM +0000, Patrick Bellasi wrote:
> > > > +#ifdef CONFIG_UCLAMP_TASK
> > > 
> > > > +struct uclamp_bucket {
> > > > +	unsigned long value : bits_per(SCHED_CAPACITY_SCALE);
> > > > +	unsigned long tasks : BITS_PER_LONG - bits_per(SCHED_CAPACITY_SCALE);
> > > > +};
> > > 
> > > > +struct uclamp_cpu {
> > > > +	unsigned int value;
> > > 
> > > 	/* 4 byte hole */
> > > 
> > > > +	struct uclamp_bucket bucket[UCLAMP_BUCKETS];
> > > > +};
> > > 
> > > With the default of 5, this UCLAMP_BUCKETS := 6, so struct uclamp_cpu
> > > ends up being 7 'unsigned long's, or 56 bytes on 64bit (with a 4 byte
> > > hole).
> > 
> > Yes, that's dimensioned and configured to fit into a single cache line
> > for all the possible 5 (by default) clamp values of a clamp index
> > (i.e. min or max util).
> 
> And I suppose you picked 5 because 20% is a 'nice' number? whereas
> 16./666/% is a bit odd?

Yes, UCLAMP_BUCKETS:=6 gives me 5 20% buckets:

 0-19%, 20-39%, 40-59%, 60-79%, 80-99%
 
plus a 100% bucket to track the max boosted tasks.

Does that makes sense ?

> > > > +#endif /* CONFIG_UCLAMP_TASK */
> > > > +
> > > >  /*
> > > >   * This is the main, per-CPU runqueue data structure.
> > > >   *
> > > > @@ -835,6 +879,11 @@ struct rq {
> > > >  	unsigned long		nr_load_updates;
> > > >  	u64			nr_switches;
> > > >  
> > > > +#ifdef CONFIG_UCLAMP_TASK
> > > > +	/* Utilization clamp values based on CPU's RUNNABLE tasks */
> > > > +	struct uclamp_cpu	uclamp[UCLAMP_CNT] ____cacheline_aligned;
> > > 
> > > Which makes this 112 bytes with 8 bytes in 2 holes, which is short of 2
> > > 64 byte cachelines.
> > 
> > Right, we have 2 cache lines where:
> > - the first $L tracks 5 different util_min values
> > - the second $L tracks 5 different util_max values
> 
> Well, not quite so, if you want that you should put
> ____cacheline_aligned on struct uclamp_cpu. Such that the individual
> array entries are each aligned, the above only alignes the whole array,
> so the second uclamp_cpu is spread over both lines.

That's true... I was considering more important to save space if we
have a buckets number which can fit in let say 3 cache lines.
... but if you prefer the other way around I'll move it.

> But I think this is actually better, since you have to scan both
> min/max anyway, and allowing one the straddle a line you have to touch
> anyway, allows for using less lines in total.

Right.

> Consider for example the case where UCLAMP_BUCKETS=8, then each
> uclamp_cpu would be 9 words or 72 bytes. If you force align the member,
> then you end up with 4 lines, whereas now it would be 3.

Exactly :)

> > > Is that the best layout?
> > 
> > It changed few times and that's what I found more reasonable for both
> > for fitting the default configuration and also for code readability.
> > Notice that we access RQ and SE clamp values with the same patter,
> > for example:
> > 
> >    {rq|p}->uclamp[clamp_idx].value
> > 
> > Are you worried about the holes or something else specific ?
> 
> Not sure; just mostly asking if this was by design or by accident.
> 
> One thing I did wonder though; since bucket[0] is counting the tasks
> that are unconstrained and it's bucket value is basically fixed (0 /
> 1024), can't we abuse that value field to store uclamp_cpu::value ?

Mmm... should be possible, just worried about adding special cases
which can make the code even more complex of what it's not already.

.... moreover, if we ditch the mapping, the 1024 will be indexed at
the top of the array... so...

> OTOH, doing that might make the code really ugly with all them:
> 
>   if (!bucket_id)
> 
> exceptions all over the place.

Exactly... I should read all your comments before replying :)

-- 
#include <best/regards.h>

Patrick Bellasi
