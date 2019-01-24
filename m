Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F24C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853E720854
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tMBWENLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfAXJII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:08:08 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52150 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbfAXJII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NGUIZKzm8nhFzhx4M2SE2hiHdtuCjlwzvin7gesdf/g=; b=tMBWENLG0/ZqwAqGnogCZajU8
        WDYM4nTBHbnjLYCsSZWl/V+d9cJni+q2HKMR3Duf5jPYt8if1mXPZPUZBCbBJZgFjUUSRnTsoSi8r
        Qrf9KAOJ3TvhxGRyRN2tygm6BF6hTnAckvwl5DVt+y9axY6TaZuipO071xfrW/Eu3gHpHZ+/r7IIk
        LUM1uhS4W0O0UGZV4+9wo2FLWsVq56b25MS4Gh+SxCZSKn284KSzPOj4kNLZE1qztXJ4NYF5hpJQg
        UBCvc676bvOlNn/pepivh86nFbZ1U7Hda0Bk2zkzln+Xkwd8qf8rIujpS8To71Ty08sFzPomBoVUY
        PXWoN3dcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmazN-0007cd-4k; Thu, 24 Jan 2019 09:07:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39C5C20726151; Thu, 24 Jan 2019 10:07:55 +0100 (CET)
Date:   Thu, 24 Jan 2019 10:07:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
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
Message-ID: <20190124090755.GC13536@hirez.programming.kicks-ass.net>
References: <1542711308-25256-1-git-send-email-vincent.guittot@linaro.org>
 <1542711308-25256-3-git-send-email-vincent.guittot@linaro.org>
 <CAKfTPtD=sV3zJiZMfCFi92_f6j-jTO9D5RsEBAXHVa6VN3Urwg@mail.gmail.com>
 <20181128100241.GA2131@hirez.programming.kicks-ass.net>
 <20181128115336.GB23094@e110439-lin>
 <20181129125348.GL2131@hirez.programming.kicks-ass.net>
 <20181129151316.GG23094@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129151316.GG23094@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry; trying to get back to this and re-reading the old conversations.

On Thu, Nov 29, 2018 at 03:13:16PM +0000, Patrick Bellasi wrote:
> On 29-Nov 13:53, Peter Zijlstra wrote:
> > On Wed, Nov 28, 2018 at 11:53:36AM +0000, Patrick Bellasi wrote:
> > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index ac855b2f4774..93e0cf5d8a76 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -3661,6 +3661,10 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
> > >  	if (!task_sleep)
> > >  		return;
> > > 
> > > +	/* Skip samples which do not represent an actual utilization */
> > > +	if (unlikely(task_util(p) > capacity_of(task_cpu(p))))
> > > +		return;
> > > +
> > >  	/*
> > >  	 * If the PELT values haven't changed since enqueue time,
> > >  	 * skip the util_est update.
> > 
> > Would you not want something like:
> > 
> > 	min(task_util(p), capacity_of(task_cpu(p)))
> > 
> > And is this the only place where we need this?
> 
> Mmm... even this could be an over-estimation:
> 
> I've just posted an example in my last reply to Vincent, end of:
> 
>    Message-ID: <20181129150020.GF23094@e110439-lin>
>    https://lore.kernel.org/lkml/20181129150020.GF23094@e110439-lin/

In particular this bit:

 | Seems we agree that, when there is no idle time:
 | - the two 15% tasks will be overestimated
 | - their utilization will reach 50% after a while

Right?

> > OTOH, if the task is always running, it will be always running
> > irrespective of where it runs.
> 
> That's not what I'm concerned about. I'm concerned about small tasks
> which are running on limited capacity (e.g. due to thermal capping)
> without idle time. In this case, the new "utilization" signal could
> overestimate the real task needs.
> 
> > Not storing these samples seems weird though; this is the exact
> > condition you want to record -- the task is very active, if we skip
> > these, we'll come back at a low frequency on the next wakeup.
> 
> When there is not idle time, we don't know if the reported
> utilization, above the cpu capacity, is due to the task being bigger...
> or just the new utilization signal converging towards:
> 
>     100% / RUNNABLE_TASKS_COUNT

So if I'm not mistaken we then have 3 cases:

 1) runnable == util <= capacity

    no contention, idle

 2) runnable == util > capacity

    no contention, no idle

 3) runnable > util

    contention, no idle

For 1) we can use: 'util'
For 2) we can use: 'capacity'
For 3) we can use: 'util * capacity >> 10'

(note that 2 is a special case of 3 when u=1)

This should work right?

Now, instead of doing complicated things like that, you instead figure
that when there's no idle there's also no dequeue happening and we can
simply short-cut by skipping the entire thing, forgetting everything
about 2,3.

Did I get that right?


