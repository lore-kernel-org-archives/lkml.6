Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965444AbeEXIiH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:38:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36512 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965042AbeEXIiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:38:03 -0400
Date: Thu, 24 May 2018 10:37:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched,tracing: Correct trace_sched_pi_setprio() for
 deboosting
Message-ID: <20180524083754.GD12198@hirez.programming.kicks-ass.net>
References: <20180523141107.6417-1-bigeasy@linutronix.de>
 <20180523172819.GW12198@hirez.programming.kicks-ass.net>
 <20180524074413.dukslrbgqfvaab5b@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524074413.dukslrbgqfvaab5b@linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 09:44:14AM +0200, Sebastian Andrzej Siewior wrote:
> On 2018-05-23 19:28:19 [+0200], Peter Zijlstra wrote:
> > On Wed, May 23, 2018 at 04:11:07PM +0200, Sebastian Andrzej Siewior wrote:

> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 092f7c4de903..888df643b99b 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -3823,7 +3823,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
> > >  		goto out_unlock;
> > >  	}
> > >  
> > > -	trace_sched_pi_setprio(p, pi_task);
> > > +	trace_sched_pi_setprio(p, prio);

> I don't see the point in open coding __rt_effective_prio() and
> recomputing the value we already have. I'm a little worried that if
> something happens to `prio' we might miss it and notice later while
> debugging.
> However, if they are reasons like breaking the trace-API for $tools, I
> can update it.

Thing is, with the pi_task as an argument, someone using the tracehook
can actually get the deadline data out, even if the normal 'event' does
not.
