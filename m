Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B676C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3719B20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3719B20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=santannapisa.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeJLOxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 10:53:48 -0400
Received: from ms01.santannapisa.it ([193.205.80.99]:37685 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeJLOxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 10:53:48 -0400
Received: from [151.40.40.188] (account l.abeni@santannapisa.it HELO sweethome)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 133616499; Fri, 12 Oct 2018 09:22:38 +0200
Date:   Fri, 12 Oct 2018 09:22:31 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 5/8] sched: Add proxy execution
Message-ID: <20181012092231.0bdb5cf7@sweethome>
In-Reply-To: <20181011125325.GA9867@hirez.programming.kicks-ass.net>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
        <20181009092434.26221-6-juri.lelli@redhat.com>
        <20181010131048.54afd1b6@luca64>
        <20181011123448.GS9130@localhost.localdomain>
        <20181011125325.GA9867@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018 14:53:25 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

[...]
> > > > +	if (rq->curr != rq->idle) {
> > > > +		rq->proxy = rq->idle;
> > > > +		set_tsk_need_resched(rq->idle);
> > > > +		/*
> > > > +		 * XXX [juril] don't we still need to migrate
> > > > @next to
> > > > +		 * @owner's CPU?
> > > > +		 */
> > > > +		return rq->idle;
> > > > +	}  
> > > 
> > > If I understand well, this code ends up migrating the task only
> > > if the CPU was previously idle? (scheduling the idle task if the
> > > CPU was not previously idle)
> > > 
> > > Out of curiosity (I admit this is my ignorance), why is this
> > > needed? If I understand well, after scheduling the idle task the
> > > scheduler will be invoked again (because of the
> > > set_tsk_need_resched(rq->idle)) but I do not understand why it is
> > > not possible to migrate task "p" immediately (I would just check
> > > "rq->curr != p", to avoid migrating the currently scheduled
> > > task).  
[...]
> I think it was the safe and simple choice; note that we're not
> migrating just a single @p, but a whole chain of @p.

Ah, that's the point I was missing... Thanks for explaining, now
everything looks more clear!


But... Here is my next dumb question: once the tasks are migrated to
the other runqueue, what prevents the scheduler from migrating them
back? In particular, task p: if it is (for example) a fixed priority
task an is on this runqueue, it is probably because the FP invariant
wants this... So, the push mechanism might end up migrating p back to
this runqueue soon... No?

Another doubt: if I understand well, when a task p "blocks" on a mutex
the proxy mechanism migrates it (and the whole chain of blocked tasks)
to the owner's core... Right?
Now, I understand why this is simpler to implement, but from the
schedulability point of view shouldn't we migrate the owner to p's core
instead?


			Thanks,
				Luca

> rq->curr must
> not be any of the possible @p's. rq->idle, is per definition not one
> of the @p's.
> 
> Does that make sense?

