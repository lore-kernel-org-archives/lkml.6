Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0642AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B00204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DS+UdFrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfAVKDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:03:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbfAVKDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MxW7EkzKu38OCx7JyMEyNb3O/cZi1s0UnYiz/UueQD0=; b=DS+UdFrTJoXG6NVzsO5q+oqle
        iDE2hzB33OZkNOT2xnCRNy65Bm6DOfaSGM2AXPfCQgcJ5qGZawGEvi1ob6Gf8rqosSefFhXIwl/XL
        KxZ7kr82LW6p0lL/df3oolHoXaxQT8zYfnziT62gc7MWu1ENiMC+sSv8aKG/s6Ld1HPfPQWX+eloQ
        Aw3S2XxQDGgXVeIOypNgXWVk2AXeA7byjlGT6XSQE4wbVaruREU3tmeYOC99Xr2JTEmEkPd3HD+/Q
        0qeLf5kyA4vqLXwJsnMCF1W7m60B3rd1f9CN87lcyVyiQV9eLlzgLUKptkWl5+yc36iFon6DwSGjw
        kfHtKo4cQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glsuH-0004iw-6u; Tue, 22 Jan 2019 10:03:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C375B20267E52; Tue, 22 Jan 2019 11:03:42 +0100 (CET)
Date:   Tue, 22 Jan 2019 11:03:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
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
Message-ID: <20190122100342.GO27931@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-5-patrick.bellasi@arm.com>
 <20190121151717.GK27931@hirez.programming.kicks-ass.net>
 <20190121155407.gv4cxpg2njqmdlj5@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121155407.gv4cxpg2njqmdlj5@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 03:54:07PM +0000, Patrick Bellasi wrote:
> On 21-Jan 16:17, Peter Zijlstra wrote:
> > On Tue, Jan 15, 2019 at 10:15:01AM +0000, Patrick Bellasi wrote:
> > > +#ifdef CONFIG_UCLAMP_TASK
> > 
> > > +struct uclamp_bucket {
> > > +	unsigned long value : bits_per(SCHED_CAPACITY_SCALE);
> > > +	unsigned long tasks : BITS_PER_LONG - bits_per(SCHED_CAPACITY_SCALE);
> > > +};
> > 
> > > +struct uclamp_cpu {
> > > +	unsigned int value;
> > 
> > 	/* 4 byte hole */
> > 
> > > +	struct uclamp_bucket bucket[UCLAMP_BUCKETS];
> > > +};
> > 
> > With the default of 5, this UCLAMP_BUCKETS := 6, so struct uclamp_cpu
> > ends up being 7 'unsigned long's, or 56 bytes on 64bit (with a 4 byte
> > hole).
> 
> Yes, that's dimensioned and configured to fit into a single cache line
> for all the possible 5 (by default) clamp values of a clamp index
> (i.e. min or max util).

And I suppose you picked 5 because 20% is a 'nice' number? whereas
16./666/% is a bit odd?

> > > +#endif /* CONFIG_UCLAMP_TASK */
> > > +
> > >  /*
> > >   * This is the main, per-CPU runqueue data structure.
> > >   *
> > > @@ -835,6 +879,11 @@ struct rq {
> > >  	unsigned long		nr_load_updates;
> > >  	u64			nr_switches;
> > >  
> > > +#ifdef CONFIG_UCLAMP_TASK
> > > +	/* Utilization clamp values based on CPU's RUNNABLE tasks */
> > > +	struct uclamp_cpu	uclamp[UCLAMP_CNT] ____cacheline_aligned;
> > 
> > Which makes this 112 bytes with 8 bytes in 2 holes, which is short of 2
> > 64 byte cachelines.
> 
> Right, we have 2 cache lines where:
> - the first $L tracks 5 different util_min values
> - the second $L tracks 5 different util_max values

Well, not quite so, if you want that you should put
____cacheline_aligned on struct uclamp_cpu. Such that the individual
array entries are each aligned, the above only alignes the whole array,
so the second uclamp_cpu is spread over both lines.

But I think this is actually better, since you have to scan both
min/max anyway, and allowing one the straddle a line you have to touch
anyway, allows for using less lines in total.

Consider for example the case where UCLAMP_BUCKETS=8, then each
uclamp_cpu would be 9 words or 72 bytes. If you force align the member,
then you end up with 4 lines, whereas now it would be 3.

> > Is that the best layout?
> 
> It changed few times and that's what I found more reasonable for both
> for fitting the default configuration and also for code readability.
> Notice that we access RQ and SE clamp values with the same patter,
> for example:
> 
>    {rq|p}->uclamp[clamp_idx].value
> 
> Are you worried about the holes or something else specific ?

Not sure; just mostly asking if this was by design or by accident.

One thing I did wonder though; since bucket[0] is counting the tasks
that are unconstrained and it's bucket value is basically fixed (0 /
1024), can't we abuse that value field to store uclamp_cpu::value ?

OTOH, doing that might make the code really ugly with all them:

  if (!bucket_id)

exceptions all over the place.
