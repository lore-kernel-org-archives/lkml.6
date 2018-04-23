Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755327AbeDWNrr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754943AbeDWNrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:47:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006852178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 23 Apr 2018 09:47:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel.opensrc@gmail.com
Subject: Re: [PATCH tip/core/rcu 01/22] sched: Make non-production PREEMPT
 cond_resched() help Tasks RCU
Message-ID: <20180423094742.6582e19d@gandalf.local.home>
In-Reply-To: <20180423124000.GL26088@linux.vnet.ibm.com>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
        <1524450747-22778-1-git-send-email-paulmck@linux.vnet.ibm.com>
        <20180423085127.GR4064@hirez.programming.kicks-ass.net>
        <20180423124000.GL26088@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018 05:40:00 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> > I'm confused.. why is having this conditional on TRACEPOINT_BENCHMARK a
> > sane idea?  
> 
> Because the TRACEPOINT_BENCHMARK tests are insane, so a similar
> level of insanity is required to make things work.  Plus having this
> be unconditional would not be good for performance, as 0day has been
> telling me frequently over the past couple of years.

Just for some context. The tracepoint benchmark (which should never be
enabled in any production machine), will start a thread when the
benchmark trace event is enabled. This thread will never exit (until
the trace event is disabled), and does a benchmark loop and constantly
calls "cond_resched()" to allow other tasks to run. The point is, this
thread will never have a quiescent state for task_rcu, unless we tell
rcu that cond_resched() is a quiescent state. But this is only required
because the tracepoint benchmark has this nasty thread, that is only
used for debugging and benchmarking the tracepoint (during development).

I also suggested having a direct call into RCU from the thread to tell
RCU that it entered a quiescent state, but Paul didn't like that idea
as it caused the tracepoint benchmark to call too deep into RCU
internals.

 http://lkml.kernel.org/r/20180227153646.GD3777@linux.vnet.ibm.com


-- Steve
