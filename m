Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeCWRmR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:42:17 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:57318 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751595AbeCWRmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:42:13 -0400
Date: Fri, 23 Mar 2018 12:42:02 -0500
From: Julia Cartwright <julia@ni.com>
To: Joe Korty <joe.korty@concurrent-rt.com>
CC: <bigeasy@linutronix.de>, <mingo@redhat.com>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>, <linux-rt-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RT] Defer migrate_enable migration while task state !=
 TASK_RUNNING
Message-ID: <20180323174202.GH10942@jcartwri.amer.corp.natinst.com>
References: <20180323150959.GA16131@zipoli.concurrent-rt.com>
 <20180323165921.GG10942@jcartwri.amer.corp.natinst.com>
 <20180323172131.GA2670@zipoli.concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180323172131.GA2670@zipoli.concurrent-rt.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-23_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 01:21:31PM -0400, joe.korty@concurrent-rt.com wrote:
> On Fri, Mar 23, 2018 at 11:59:21AM -0500, Julia Cartwright wrote:
> > On Fri, Mar 23, 2018 at 11:09:59AM -0400, joe.korty@concurrent-rt.com wrote:
> > > I see the below kernel splat in 4.9-rt when I run a test program that
> > > continually changes the affinity of some set of running pids:
> > >
> > >    do not call blocking ops when !TASK_RUNNING; state=2 set at ...
> > >       ...
> > >       stop_one_cpu+0x60/0x80
> > >       migrate_enable+0x21f/0x3e0
> > >       rt_spin_unlock+0x2f/0x40
> > >       prepare_to_wait+0x5c/0x80
> > >       ...
> >
> > This is clearly a problem.
> >
> > > The reason is that spin_unlock, write_unlock, and read_unlock call
> > > migrate_enable, and since 4.4-rt, migrate_enable will sleep if it discovers
> > > that a migration is in order.  But sleeping in the unlock services is not
> > > expected by most kernel developers,
> >
> > I don't buy this, see below:
> >
> > > and where that counts most is in code sequences like the following:
> > >
> > >   set_current_state(TASK_UNINTERRUPIBLE);
> > >   spin_unlock(&s);
> > >   schedule();
> >
> > The analog in mainline is CONFIG_PREEMPT and the implicit
> > preempt_enable() in spin_unlock().  In this configuration, a kernel
> > developer should _absolutely_ expect their task to be suspended (and
> > potentially migrated), _regardless of the task state_ if there is a
> > preemption event on the CPU on which this task is executing.
> >
> > Similarly, on RT, there is nothing _conceptually_ wrong on RT with
> > migrating on migrate_enable(), regardless of task state, if there is a
> > pending migration event.
>
> My understanding is, in standard Linux and in rt, setting
> task state to anything other than TASK_RUNNING in of itself
> blocks preemption.

I'm assuming you're referring to the window of time between a task
setting its state to !TASK_RUNNING and schedule()?  The task remains
preemptible in this window.

> A preemption is not really needed here as it is expected that there is
> a schedule() written in that will shortly be executed.
>
> And if a 'involuntary schedule' (ie, preemption) were allowed to occur
> between the task state set and the schedule(), that would change the
> task state back to TASK_RUNNING;

This isn't the case.  A preempted task preserves its state.

   Julia
