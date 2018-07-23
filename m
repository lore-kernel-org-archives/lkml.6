Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01034ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7BB20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QxRF6YLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7BB20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388410AbeGWPPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:15:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41688 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388112AbeGWPPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+mNtInzZZTWCQUh0J0c9ts0fB5z8wjF04lz5VAF5crQ=; b=QxRF6YLa2oJ5WUj1GHqZvds/Q
        aTiHC9hk53YTzBP9eetBe1rjegohDDm2H4vl1EwfjVqnVTDyNZ+aBLyUk5TdVZguhDqFgKLQEj5nW
        1LJrF3oSYAU7YkJdtnnFFBCsT7TsVfHj+NLEwJrDeEkxFVv6b01ZiLHxJAt3Re4/KeLAD5GYMfI/Q
        lKGaN3yyxUye2QxBTA5wLJKY5fuY0F9rcl8d4s06+y9WZI/F984x3WcZE5EL3ZMf5dm7gcNdFYRnt
        y0WQZo/R1lyZLVCNFKx5OWqG+8phdHOqEfjBHaAejuliSYacrzs0TNNKLP6qg5ltBT8BJEP+JarNI
        8zhBapLRw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhbaW-0007Rs-3Z; Mon, 23 Jul 2018 14:13:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD6D920275F47; Mon, 23 Jul 2018 16:13:22 +0200 (CEST)
Date:   Mon, 23 Jul 2018 16:13:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Alessio Balsini <alessio.balsini@gmail.com>,
        linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH] sched/deadline: sched_getattr() returns absolute
 dl-task information
Message-ID: <20180723141322.GZ2458@hirez.programming.kicks-ass.net>
References: <20180629120947.14579-1-alessio.balsini@gmail.com>
 <20180723094904.GB2494@hirez.programming.kicks-ass.net>
 <20180723124946.GA2683@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723124946.GA2683@e110439-lin>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 01:49:46PM +0100, Patrick Bellasi wrote:
> On 23-Jul 11:49, Peter Zijlstra wrote:
> 
> [...]
> 
> > > -void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
> > > +void __getparam_dl(struct task_struct *p, struct sched_attr *attr,
> > > +		   unsigned int flags)
> > >  {
> > >  	struct sched_dl_entity *dl_se = &p->dl;
> > >  
> > >  	attr->sched_priority = p->rt_priority;
> > > -	attr->sched_runtime = dl_se->dl_runtime;
> > > -	attr->sched_deadline = dl_se->dl_deadline;
> > > +
> > > +	if (flags & SCHED_GETATTR_FLAGS_DL_ABSOLUTE) {
> > > +		/*
> > > +		 * If the task is not running, its runtime is already
> > > +		 * properly accounted. Otherwise, update clocks and the
> > > +		 * statistics for the task.
> > > +		 */
> > > +		if (task_running(task_rq(p), p)) {
> > > +			struct rq_flags rf;
> > > +			struct rq *rq;
> > > +
> > > +			rq = task_rq_lock(p, &rf);
> > > +			sched_clock_tick();
> > > +			update_rq_clock(rq);
> > > +			task_tick_dl(rq, p, 0);
> > 
> > Do we really want task_tick_dl() here, or update_curr_dl()?
> 
> I think this was to cover the case of a syscall being called while the
> task is running and we are midway between two ticks...

Sure, I know what it's there for, just saying that update_curr_dl()
would've updated the accounting as well. Calling tick stuff from !tick
context is a wee bit dodgy.

> > Also, who says the task still is dl ? :-)
> 
> Good point, but what should be the rule in general for these cases?
> 
> We already have:
> 
>    SYSCALL_DEFINE4(sched_getattr())
>        ....
>        if (task_has_dl_policy(p))
>             __getparam_dl(p, &attr);
> 
> which is also potentially racy, isn't it?

Yes, but only in so far as that the whole syscall is racy
per-definition. EVen if we'd lock the rq and get the absolute accurate
values, everything can change the moment we release the locks and return
to userspace again.

> Or just make the syscall return the most updated metrics for all the
> scheduling classes since we cannot grant the user anything about what
> the task will be once we return to userspace?

This.

> > > +			task_rq_unlock(rq, p, &rf);
> > > +		}
> > > +
> > > +		/*
> > > +		 * If the task is throttled, this value could be negative,
> > > +		 * but sched_runtime is unsigned.
> > > +		 */
> > > +		attr->sched_runtime = dl_se->runtime <= 0 ? 0 : dl_se->runtime;
> > > +		attr->sched_deadline = dl_se->deadline;
> > 
> > This is all very racy..
> > 
> > Even if the task wasn't running when you did the task_running() test, it
> > could be running now. And if it was running, it might not be running
> > anymore by the time you've acquired the rq->lock.
> 
> Which means we should use something like:
> 
>    if (flags & SCHED_GETATTR_FLAGS_DL_ABSOLUTE) {
>         /* Lock the task and the RQ before any other check and upate */
>         rq = task_rq_lock(p, &rf);
> 
>         /* Check the task is still DL ?*/
> 
>         /* Update task stats */
> 
>         task_rq_unlock(rq, p, &rf);
>    }
> 
> right?

Yeah, something along those lines.

> If that's better, then we should probably even better move the
> task_rq_lock at the beginning of SYSCALL_DEFINE4(sched_getattr()) ?

Hurm.. yes, we should probably have the has_dl_policy test under the
lock too. Which is really annoying, because this basically turns a
lockless syscall into locked one.

Another method would be to have __getparam_dl() 'fail' and retry if it
finds !has_dl_policy() once we have the lock. That would retain the
lockless nature for all current use-cases and only incur the locking
overhead for this new case.
