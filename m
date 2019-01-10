Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC1FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B3820879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbfAJRXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:23:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729891AbfAJRXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:23:49 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9085820879;
        Thu, 10 Jan 2019 17:23:48 +0000 (UTC)
Date:   Thu, 10 Jan 2019 12:23:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Possible use of RCU while in extended QS: idle vs RCU read-side
 in interrupt vs rcu_eqs_exit
Message-ID: <20190110122346.7063cf08@gandalf.local.home>
In-Reply-To: <600900741.1177.1547140315581.JavaMail.zimbra@efficios.com>
References: <2103471967.794.1547084331086.JavaMail.zimbra@efficios.com>
        <20190110110839.7daeef3d@gandalf.local.home>
        <1884815641.993.1547138653377.JavaMail.zimbra@efficios.com>
        <600900741.1177.1547140315581.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 12:11:55 -0500 (EST)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Jan 10, 2019, at 8:44 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
> 
> > ----- On Jan 10, 2019, at 8:08 AM, rostedt rostedt@goodmis.org wrote:
> >   
> >> On Wed, 9 Jan 2019 20:38:51 -0500 (EST)
> >> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >>   
> >>> Hi Paul,
> >>> 
> >>> I've had a user report that trace_sched_waking() appears to be
> >>> invoked while !rcu_is_watching() in some situation, so I started
> >>> digging into the scheduler idle code.  
> >> 
> >> I'm wondering if this isn't a bug. Do you have the backtrace for where
> >> trace_sched_waking() was called without rcu watching?  
> > 
> > I strongly suspect a bug as well. I'm awaiting a reproducer from the
> > user whom reported this issue so I can add a WARN_ON_ONCE(!rcu_is_watching())
> > in the scheduler code near trace_sched_waking() and gather a backtrace.
> > 
> > It still has to be confirmed, but I suspect this have been triggered
> > within a HyperV guest. It may therefore be related to a virtualized environment.
> > 
> > I'll try to ask more specifically on which environment this was encountered.  
> 
> So it ends up it happens directly on hardware on a Linux laptop. Here is
> the stacktrace:
> 
> vmlinux!try_to_wake_up
> vmlinux!default_wake_function
> vmlinux!pollwake
> vmlinux!__wake_up_common
> vmlinux!__wake_up_common_lock
> vmlinux!__wake_up
> vmlinux!perf_event_wakeup
> vmlinux!perf_pending_event
> vmlinux!irq_work_run_list
> vmlinux!irq_work_run

> vmlinux!smp_irq_work_iterrupt

The first thing this calls is ipi_entering_ack_irq(), which calls
irq_enter(), which calls rcu_irq_enter().

So why isn't rcu watching here?

-- Steve


> vmlinux!irq_work_interrupt
> vmlinux!finish_task_switch
> vmlinux!__schedule
> vmlinux!schedule_idle
> vmlinux!do_idle
> vmlinux!cpu_startup_entry
> vmlinux!start_secondary
> vmlinux!secondary_startup_64
> 
> Does it raise any red flag ?
> 
> Thanks,
> 
> Mathieu
> 
> > 
> > Thanks,
> > 
> > Mathieu
> >   
> >> 
> >> -- Steve
> >>   
> >>> 
> >>> It appears that interrupts are re-enabled before rcu_eqs_exit() is
> >>> invoked when exiting idle code from the scheduler.
> >>> 
> >>> I wonder what happens if an interrupt handler (including scheduler code)
> >>> happens to issue a RCU read-side critical section before rcu_eqs_exit()
> >>> is called ? Is there some code on interrupt entry that ensures rcu eqs
> >>> state is exited in such scenario ?
> >>> 
> >>> Thanks,
> >>> 
> >>> Mathieu  
> > 
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com  
> 

