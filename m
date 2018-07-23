Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC25ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2276420779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2276420779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbeGWPcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:32:48 -0400
Received: from foss.arm.com ([217.140.101.70]:34898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388104AbeGWPcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:32:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79CE680D;
        Mon, 23 Jul 2018 07:31:16 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7D6A3F5D0;
        Mon, 23 Jul 2018 07:31:14 -0700 (PDT)
Date:   Mon, 23 Jul 2018 15:31:12 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20180723143112.GC2683@e110439-lin>
References: <20180629120947.14579-1-alessio.balsini@gmail.com>
 <20180723094904.GB2494@hirez.programming.kicks-ass.net>
 <20180723124946.GA2683@e110439-lin>
 <20180723141322.GZ2458@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723141322.GZ2458@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-Jul 16:13, Peter Zijlstra wrote:
> On Mon, Jul 23, 2018 at 01:49:46PM +0100, Patrick Bellasi wrote:
> > On 23-Jul 11:49, Peter Zijlstra wrote:
> > 
> > [...]
> > 
> > > > -void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
> > > > +void __getparam_dl(struct task_struct *p, struct sched_attr *attr,
> > > > +		   unsigned int flags)
> > > >  {
> > > >  	struct sched_dl_entity *dl_se = &p->dl;
> > > >  
> > > >  	attr->sched_priority = p->rt_priority;
> > > > -	attr->sched_runtime = dl_se->dl_runtime;
> > > > -	attr->sched_deadline = dl_se->dl_deadline;
> > > > +
> > > > +	if (flags & SCHED_GETATTR_FLAGS_DL_ABSOLUTE) {
> > > > +		/*
> > > > +		 * If the task is not running, its runtime is already
> > > > +		 * properly accounted. Otherwise, update clocks and the
> > > > +		 * statistics for the task.
> > > > +		 */
> > > > +		if (task_running(task_rq(p), p)) {
> > > > +			struct rq_flags rf;
> > > > +			struct rq *rq;
> > > > +
> > > > +			rq = task_rq_lock(p, &rf);
> > > > +			sched_clock_tick();
> > > > +			update_rq_clock(rq);
> > > > +			task_tick_dl(rq, p, 0);
> > > 
> > > Do we really want task_tick_dl() here, or update_curr_dl()?
> > 
> > I think this was to cover the case of a syscall being called while the
> > task is running and we are midway between two ticks...
> 
> Sure, I know what it's there for, just saying that update_curr_dl()
> would've updated the accounting as well. Calling tick stuff from !tick
> context is a wee bit dodgy.

Right, I think it depends on how much we want to be "precise" in closing
a control loop with user-space.

On Android we have ticks every 3-4ms, I'm wondering if this maximum
"latency" on measuring the remaining run-time can introduce a too big
error for certain applications...

Alessio: you have an interesting low-latency audio use-case on hand,
do you think we can tolerate a 4ms error in remaining run-time
readings?

[...]

> > Which means we should use something like:
> > 
> >    if (flags & SCHED_GETATTR_FLAGS_DL_ABSOLUTE) {
> >         /* Lock the task and the RQ before any other check and upate */
> >         rq = task_rq_lock(p, &rf);
> > 
> >         /* Check the task is still DL ?*/
> > 
> >         /* Update task stats */
> > 
> >         task_rq_unlock(rq, p, &rf);
> >    }
> > 
> > right?
> 
> Yeah, something along those lines.
> 
> > If that's better, then we should probably even better move the
> > task_rq_lock at the beginning of SYSCALL_DEFINE4(sched_getattr()) ?
> 
> Hurm.. yes, we should probably have the has_dl_policy test under the
> lock too. Which is really annoying, because this basically turns a
> lockless syscall into locked one.

Indeed...

> Another method would be to have __getparam_dl() 'fail' and retry if it
> finds !has_dl_policy() once we have the lock. That would retain the
> lockless nature for all current use-cases and only incur the locking
> overhead for this new case.

... right, this is actually the best solution to have a bit more
guarantees for the new DL control scenarios without affecting existing
ones!

-- 
#include <best/regards.h>

Patrick Bellasi
