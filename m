Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755877AbeEAPKz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:10:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755742AbeEAPKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:10:53 -0400
Date: Tue, 1 May 2018 17:10:50 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, mpe@ellerman.id.au, bigeasy@linutronix.de,
        gkohli@codeaurora.org, neeraju@codeaurora.org
Subject: Re: [PATCH 2/2] sched: Introduce set_special_state()
Message-ID: <20180501151050.GA13094@redhat.com>
References: <20180430141751.377491406@infradead.org>
 <20180430142235.900370484@infradead.org>
 <20180430164545.GA10951@redhat.com>
 <20180430194024.GA12217@hirez.programming.kicks-ass.net>
 <20180501095054.GD12235@hirez.programming.kicks-ass.net>
 <20180501135924.GA12696@redhat.com>
 <20180501142251.GH12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501142251.GH12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01, Peter Zijlstra wrote:
>
> On Tue, May 01, 2018 at 03:59:24PM +0200, Oleg Nesterov wrote:
> > On 05/01, Peter Zijlstra wrote:
> > >
> > > The only code I found that seems to care is ptrace_attach(), where we
> > > wait for JOBCTL_TRAPPING to get cleared. That same function has a
> > > comment about hiding the STOPPED -> RUNNING -> TRACED transition. So I'm
> > > assuming it needs to observe TRACED if it observes !TRAPPING.
> >
> > Yes, exactly.
> >
> > > But I don't think there's enough barriers on that end to guarantee this.
> > > Any ->state load after wait_on_bit() is, afact, free to have happened
> > > before the ->jobctl load.
> >
> > do_wait() does set_current_state() before it checks ->state or anything else.
>
> But how are ptrace_attach() and do_wait() related?

Yes.

> I guess I'm missing
> something fairly fundamental here.

You are missing the fact that ptrace API is very old and ugly ;)

Just one example. If the debugger knows that the task is STOPPED then it has
all rights to do, say,

	ptrace(PTRACE_ATTACH, pid);
	BUG_ON(pid != waitpid(pid, WNOHANG));

Or even do another ptrace() request right after ptrace(PTRACE_ATTACH) returns,
without do_wait().

And unless my memory fools me, gdb even has some test-cases for this... Not sure,
but it certainly looks at tracee->state in /proc before it does PTRACE_ATTACH,
because if it was already STOPPED then gdb won't have any notification from the
tracee.

> Anyway, does the below look ok?

Yes, thanks.

Oleg.
