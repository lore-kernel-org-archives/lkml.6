Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B06C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45C9218D0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PW0gNWBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfAVJhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:37:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfAVJhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NU4V5uCQmV84QkTw0S+I2r8MuzPTPNrPYuSs+2uS5y4=; b=PW0gNWBLoYOCSz6mnwSOOsGrA
        Dxn2PRND+3H1sRQoZWifWHelGjQUeRKM/R8+nBIpI3flVLfRp9ZPQvC9emuHNTXk3hXHON6X4PKI2
        qxk8UpjShmuoenwoZqSR4KmsetHZlfc+GS1BefEqhA2vxUCKMFbC6t5zBlS4t1zd0iMxQv3Ckk/ub
        lRfYeTKuZoqUErQEpzC0UAiMPlv52D8Po64jx7lw2tBqEVupQBrrwnwksfqG8mh+9mFLSNmBtlSvD
        /xz4BaeLTVf5pdqwBf0Sxx+uwypVB+o0tZDqd8XFvh8knuUAgnK0cpDpRHrkF8zbkVhuo+mTaYjoD
        mGYGy8N0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glsUU-0001FV-MW; Tue, 22 Jan 2019 09:37:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9B6BD211A59B4; Tue, 22 Jan 2019 10:37:04 +0100 (CET)
Date:   Tue, 22 Jan 2019 10:37:04 +0100
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
Subject: Re: [PATCH v6 05/16] sched/core: uclamp: Update CPU's refcount on
 clamp changes
Message-ID: <20190122093704.GM27931@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-6-patrick.bellasi@arm.com>
 <20190121153308.GL27931@hirez.programming.kicks-ass.net>
 <20190121154412.fak2t2iquj3aixtu@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121154412.fak2t2iquj3aixtu@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 03:44:12PM +0000, Patrick Bellasi wrote:
> On 21-Jan 16:33, Peter Zijlstra wrote:
> > On Tue, Jan 15, 2019 at 10:15:02AM +0000, Patrick Bellasi wrote:
> > 
> > > +static inline void
> > > +uclamp_task_update_active(struct task_struct *p, unsigned int clamp_id)
> > > +{
> > > +	struct rq_flags rf;
> > > +	struct rq *rq;
> > > +
> > > +	/*
> > > +	 * Lock the task and the CPU where the task is (or was) queued.
> > > +	 *
> > > +	 * We might lock the (previous) rq of a !RUNNABLE task, but that's the
> > > +	 * price to pay to safely serialize util_{min,max} updates with
> > > +	 * enqueues, dequeues and migration operations.
> > > +	 * This is the same locking schema used by __set_cpus_allowed_ptr().
> > > +	 */
> > > +	rq = task_rq_lock(p, &rf);
> > > +
> > > +	/*
> > > +	 * Setting the clamp bucket is serialized by task_rq_lock().
> > > +	 * If the task is not yet RUNNABLE and its task_struct is not
> > > +	 * affecting a valid clamp bucket, the next time it's enqueued,
> > > +	 * it will already see the updated clamp bucket value.
> > > +	 */
> > > +	if (!p->uclamp[clamp_id].active)
> > > +		goto done;
> > > +
> > > +	uclamp_cpu_dec_id(p, rq, clamp_id);
> > > +	uclamp_cpu_inc_id(p, rq, clamp_id);
> > > +
> > > +done:
> > > +	task_rq_unlock(rq, p, &rf);
> > > +}
> > 
> > > @@ -1008,11 +1043,11 @@ static int __setscheduler_uclamp(struct task_struct *p,
> > >  
> > >  	mutex_lock(&uclamp_mutex);
> > >  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> > > -		uclamp_bucket_inc(&p->uclamp[UCLAMP_MIN],
> > > +		uclamp_bucket_inc(p, &p->uclamp[UCLAMP_MIN],
> > >  				  UCLAMP_MIN, lower_bound);
> > >  	}
> > >  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> > > -		uclamp_bucket_inc(&p->uclamp[UCLAMP_MAX],
> > > +		uclamp_bucket_inc(p, &p->uclamp[UCLAMP_MAX],
> > >  				  UCLAMP_MAX, upper_bound);
> > >  	}
> > >  	mutex_unlock(&uclamp_mutex);
> > 
> > 
> > But.... __sched_setscheduler() actually does the whole dequeue + enqueue
> > thing already ?!? See where it does __setscheduler().
> 
> This is slow-path accounting, not fast path.

Sure; but that's still no reason for duplicate or unneeded code.

> There are two refcounting going on here:
> 
>   1) mapped buckets:
> 
>      clamp_value <--(M1)--> bucket_id
> 
>   2) RUNNABLE tasks:
> 
>      bucket_id <--(M2)--> RUNNABLE tasks in a bucket
> 
> What we fix here is the refcounting for the buckets mapping. If a task
> does not have a task specific clamp value it does not refcount any
> bucket. The moment we assign a task specific clamp value, we need to
> refcount the task in the bucket corresponding to that clamp value.
> 
> This will keep the bucket in use at least as long as the task will
> need that clamp value.

Sure, I get that. What I don't get is why you're adding that (2) here.
Like said, __sched_setscheduler() already does a dequeue/enqueue under
rq->lock, which should already take care of that.
