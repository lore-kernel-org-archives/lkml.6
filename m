Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968628AbeE3Ici (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:32:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:36433 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935975AbeE3IcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:32:07 -0400
Date: Wed, 30 May 2018 10:32:04 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Hoeun Ryu <hoeun.ryu@lge.com.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, Hoeun Ryu <hoeun.ryu@lge.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  printk: make printk_safe_flush safe in NMI context by
 skipping flushing
Message-ID: <20180530083204.m2yvmm7mc6owvpdk@pathway.suse.cz>
References: <1527562331-25880-1-git-send-email-hoeun.ryu@lge.com.com>
 <20180529121315.GE438@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529121315.GE438@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-05-29 21:13:15, Sergey Senozhatsky wrote:
> On (05/29/18 11:51), Hoeun Ryu wrote:
> >  Make printk_safe_flush() safe in NMI context.
> > nmi_trigger_cpumask_backtrace() can be called in NMI context. For example the
> > function is called in watchdog_overflow_callback() if the flag of hardlockup
> > backtrace (sysctl_hardlockup_all_cpu_backtrace) is true and
> > watchdog_overflow_callback() function is called in NMI context on some
> > architectures.
> >  Calling printk_safe_flush() in nmi_trigger_cpumask_backtrace() eventually tries
> > to lock logbuf_lock in vprintk_emit() but the logbuf_lock can be already locked in
> > preempted contexts (task or irq in this case) or by other CPUs and it may cause

The sentence "logbuf_lock can be already locked in preempted contexts" does not
make much sense. It is a spin lock. It means that both interrupts and
preemption are disabled.

I would change it to something like:

"Calling printk_safe_flush() in nmi_trigger_cpumask_backtrace() eventually tries
to lock logbuf_lock in vprintk_emit() that might be already be part
of a soft- or hard-lockup on another CPU."


> > deadlocks.
> >  By making printk_safe_flush() safe in NMI context, the backtrace triggering CPU
> > just skips flushing if the lock is not avaiable in NMI context. The messages in
> > per-cpu nmi buffer of the backtrace triggering CPU can be lost if the CPU is in
> > hard lockup (because irq is disabled here) but if panic() is not called. The
> > flushing can be delayed by the next irq work in normal cases.

I somehow miss there a motivation why the current state is better than
the previous. It looks like we exchange the risk of a deadlock with
a risk of loosing the messages.

I see it the following way:

"This patch prevents a deadlock in printk_safe_flush() in NMI
context. It makes sure that we continue and eventually call
printk_safe_flush_on_panic() from panic() that has better
chances to succeed.

There is a risk that logbuf_lock was not part of a soft- or
dead-lockup and we might just loose the messages. But then there is a high
chance that irq_work will get called and the messages will get flushed
the normal way."


> Any chance we can add more info to the commit message? E.g. backtraces
> which would describe "how" is this possible (like the one I posted in
> another email). Just to make it more clear.

I agree that a backtrace would be helpful. But it is not a must to
have from my point of view.

The patch itself looks good to me.

Best Regards,
Petr
