Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BCCECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D32B20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D32B20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388762AbeGWNvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:51:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33326 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388662AbeGWNu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:50:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A570580D;
        Mon, 23 Jul 2018 05:49:54 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAD973F778;
        Mon, 23 Jul 2018 05:49:52 -0700 (PDT)
Date:   Mon, 23 Jul 2018 13:49:46 +0100
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
Message-ID: <20180723124946.GA2683@e110439-lin>
References: <20180629120947.14579-1-alessio.balsini@gmail.com>
 <20180723094904.GB2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723094904.GB2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-Jul 11:49, Peter Zijlstra wrote:

[...]

> > -void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
> > +void __getparam_dl(struct task_struct *p, struct sched_attr *attr,
> > +		   unsigned int flags)
> >  {
> >  	struct sched_dl_entity *dl_se = &p->dl;
> >  
> >  	attr->sched_priority = p->rt_priority;
> > -	attr->sched_runtime = dl_se->dl_runtime;
> > -	attr->sched_deadline = dl_se->dl_deadline;
> > +
> > +	if (flags & SCHED_GETATTR_FLAGS_DL_ABSOLUTE) {
> > +		/*
> > +		 * If the task is not running, its runtime is already
> > +		 * properly accounted. Otherwise, update clocks and the
> > +		 * statistics for the task.
> > +		 */
> > +		if (task_running(task_rq(p), p)) {
> > +			struct rq_flags rf;
> > +			struct rq *rq;
> > +
> > +			rq = task_rq_lock(p, &rf);
> > +			sched_clock_tick();
> 
> This isn't required here. The reason it is used elsewhere is because
> those are interrupts, but this is a system call, the clock state should
> be good.
> 
> > +			update_rq_clock(rq);
> > +			task_tick_dl(rq, p, 0);
> 
> Do we really want task_tick_dl() here, or update_curr_dl()?

I think this was to cover the case of a syscall being called while the
task is running and we are midway between two ticks...

> Also, who says the task still is dl ? :-)

Good point, but what should be the rule in general for these cases?

We already have:

   SYSCALL_DEFINE4(sched_getattr())
       ....
       if (task_has_dl_policy(p))
            __getparam_dl(p, &attr);

which is also potentially racy, isn't it?

In this syscall we don't even use get_task_struct()... as we do for
example in sched_setaffinity()...

What should we do if, in the middle of such a  syscall, someone else
demoted the task to a different class?

Should we fail the syscall with a specific error?

Or just make the syscall return the most updated metrics for all the
scheduling classes since we cannot grant the user anything about what
the task will be once we return to userspace?


> > +			task_rq_unlock(rq, p, &rf);
> > +		}
> > +
> > +		/*
> > +		 * If the task is throttled, this value could be negative,
> > +		 * but sched_runtime is unsigned.
> > +		 */
> > +		attr->sched_runtime = dl_se->runtime <= 0 ? 0 : dl_se->runtime;
> > +		attr->sched_deadline = dl_se->deadline;
> 
> This is all very racy..
> 
> Even if the task wasn't running when you did the task_running() test, it
> could be running now. And if it was running, it might not be running
> anymore by the time you've acquired the rq->lock.

Which means we should use something like:

   if (flags & SCHED_GETATTR_FLAGS_DL_ABSOLUTE) {
        /* Lock the task and the RQ before any other check and upate */
        rq = task_rq_lock(p, &rf);

        /* Check the task is still DL ?*/

        /* Update task stats */

        task_rq_unlock(rq, p, &rf);
   }

right?

If that's better, then we should probably even better move the
task_rq_lock at the beginning of SYSCALL_DEFINE4(sched_getattr()) ?

> On 32bit reading these numbers without locks is broken to boot. And even
> on 64bit, I suppose you can a consistent snapshot of runtime and
> deadline together, which isn't possible without the locks.

Indeed... I think we really need the lock and, likely, to place it at
the beginning of the syscall...

> And of course, by the time we get back to userspace, the returned values
> will be out-of-date anyway. But that isn't to be helped I suppose.

Yes, but that's always kind-of implied by syscall returning kernel
metrics, isn't it?

> > +	} else {
> > +		attr->sched_runtime = dl_se->dl_runtime;
> > +		attr->sched_deadline = dl_se->dl_deadline;
> > +	}
> > +
> >  	attr->sched_period = dl_se->dl_period;
> >  	attr->sched_flags = dl_se->flags;
> >  }

-- 
#include <best/regards.h>

Patrick Bellasi
