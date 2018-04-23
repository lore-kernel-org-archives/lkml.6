Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755414AbeDWOEQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:04:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51742 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755126AbeDWOEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:04:15 -0400
Date: Mon, 23 Apr 2018 16:03:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel.opensrc@gmail.com
Subject: Re: [PATCH tip/core/rcu 01/22] sched: Make non-production PREEMPT
 cond_resched() help Tasks RCU
Message-ID: <20180423140342.GM4082@hirez.programming.kicks-ass.net>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
 <1524450747-22778-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180423085127.GR4064@hirez.programming.kicks-ass.net>
 <20180423124000.GL26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423124000.GL26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 05:40:00AM -0700, Paul E. McKenney wrote:
> On Mon, Apr 23, 2018 at 10:51:27AM +0200, Peter Zijlstra wrote:
> > On Sun, Apr 22, 2018 at 07:32:06PM -0700, Paul E. McKenney wrote:
> > > In CONFIG_PREEMPT=y kernels, cond_resched() is a complete no-op, and
> > > thus cannot help advance Tasks-RCU grace periods.  However, such grace
> > > periods are only an issue in non-production benchmarking runs of the
> > > Linux kernel.  This commit therefore makes cond_resched() invoke
> > > rcu_note_voluntary_context_switch() for kernels implementing Tasks RCU
> > > even in CONFIG_PREEMPT=y kernels.
> > 
> > I'm confused.. why is having this conditional on TRACEPOINT_BENCHMARK a
> > sane idea?
> 
> Because the TRACEPOINT_BENCHMARK tests are insane, so a similar
> level of insanity is required to make things work.  Plus having this
> be unconditional would not be good for performance, as 0day has been
> telling me frequently over the past couple of years.
> 
> All that aside, I am very open to ideas.  What would you suggest?

Dunno; Steve how insane is that benchmark? Is it at all possible for an
actual user to cause something like tha?

Thing is, I find it very dodgy to have cond_resched() behaviour depend
on a benchmark config.

Either we should always have that (and somehow fix the performance
issues) or we should not and then have the tracepoint crud not be
insane, possibly adding a few of those cond_resched_trace_rcu_qs()
things from the later patch.
