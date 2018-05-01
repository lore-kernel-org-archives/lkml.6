Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755799AbeEAOXJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:23:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45564 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755132AbeEAOXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:23:07 -0400
Date: Tue, 1 May 2018 16:22:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, mpe@ellerman.id.au, bigeasy@linutronix.de,
        gkohli@codeaurora.org, neeraju@codeaurora.org
Subject: Re: [PATCH 2/2] sched: Introduce set_special_state()
Message-ID: <20180501142251.GH12217@hirez.programming.kicks-ass.net>
References: <20180430141751.377491406@infradead.org>
 <20180430142235.900370484@infradead.org>
 <20180430164545.GA10951@redhat.com>
 <20180430194024.GA12217@hirez.programming.kicks-ass.net>
 <20180501095054.GD12235@hirez.programming.kicks-ass.net>
 <20180501135924.GA12696@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501135924.GA12696@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 03:59:24PM +0200, Oleg Nesterov wrote:
> On 05/01, Peter Zijlstra wrote:
> >
> > The only code I found that seems to care is ptrace_attach(), where we
> > wait for JOBCTL_TRAPPING to get cleared. That same function has a
> > comment about hiding the STOPPED -> RUNNING -> TRACED transition. So I'm
> > assuming it needs to observe TRACED if it observes !TRAPPING.
> 
> Yes, exactly.
> 
> > But I don't think there's enough barriers on that end to guarantee this.
> > Any ->state load after wait_on_bit() is, afact, free to have happened
> > before the ->jobctl load.
> 
> do_wait() does set_current_state() before it checks ->state or anything else.

But how are ptrace_attach() and do_wait() related? I guess I'm missing
something fairly fundamental here. Is it userspace doing these two
system calls back-to-back or something?

Is that not a little bit fragile, to rely on a barrier in do_wait()
for this?

Anyway, does the below look ok?

---
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1961,14 +1961,26 @@ static void ptrace_stop(int exit_code, i
 			return;
 	}
 
+	set_special_state(TASK_TRACED);
+
 	/*
 	 * We're committing to trapping.  TRACED should be visible before
 	 * TRAPPING is cleared; otherwise, the tracer might fail do_wait().
 	 * Also, transition to TRACED and updates to ->jobctl should be
 	 * atomic with respect to siglock and should be done after the arch
 	 * hook as siglock is released and regrabbed across it.
+	 *
+	 *     TRACER				    TRACEE
+	 *     ptrace_attach()
+	 * [L]   wait_on_bit(JOBCTL_TRAPPING)	[S] set_special_state(TRACED)
+	 *     do_wait()
+	 *       set_current_state()                smp_wmb();
+	 *       ptrace_do_wait()
+	 *         wait_task_stopped()
+	 *           task_stopped_code()
+	 * [L]         task_is_traced()		[S] task_clear_jobctl_trapping();
 	 */
-	set_special_state(TASK_TRACED);
+	smp_wmb();
 
 	current->last_siginfo = info;
 	current->exit_code = exit_code;
