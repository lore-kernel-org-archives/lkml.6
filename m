Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932084AbeDWOMF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:12:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46344 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755579AbeDWOLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:11:24 -0400
Date: Mon, 23 Apr 2018 16:10:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com
Subject: Re: [PATCH tip/core/rcu 01/22] sched: Make non-production PREEMPT
 cond_resched() help Tasks RCU
Message-ID: <20180423141038.GA4064@hirez.programming.kicks-ass.net>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
 <1524450747-22778-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180423085127.GR4064@hirez.programming.kicks-ass.net>
 <20180423124000.GL26088@linux.vnet.ibm.com>
 <20180423094742.6582e19d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423094742.6582e19d@gandalf.local.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 09:47:42AM -0400, Steven Rostedt wrote:
> On Mon, 23 Apr 2018 05:40:00 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > > I'm confused.. why is having this conditional on TRACEPOINT_BENCHMARK a
> > > sane idea?  
> > 
> > Because the TRACEPOINT_BENCHMARK tests are insane, so a similar
> > level of insanity is required to make things work.  Plus having this
> > be unconditional would not be good for performance, as 0day has been
> > telling me frequently over the past couple of years.
> 
> Just for some context. The tracepoint benchmark (which should never be
> enabled in any production machine), will start a thread when the
> benchmark trace event is enabled. This thread will never exit (until
> the trace event is disabled), and does a benchmark loop and constantly
> calls "cond_resched()" to allow other tasks to run. The point is, this
> thread will never have a quiescent state for task_rcu, unless we tell
> rcu that cond_resched() is a quiescent state. But this is only required
> because the tracepoint benchmark has this nasty thread, that is only
> used for debugging and benchmarking the tracepoint (during development).
> 
> I also suggested having a direct call into RCU from the thread to tell
> RCU that it entered a quiescent state, but Paul didn't like that idea
> as it caused the tracepoint benchmark to call too deep into RCU
> internals.
> 
>  http://lkml.kernel.org/r/20180227153646.GD3777@linux.vnet.ibm.com

That thread using cond_resched_task_rcu_qs() seems like a _lot_ better
than having cond_resched() semantics change depending on random
!scheduler config parameters.
