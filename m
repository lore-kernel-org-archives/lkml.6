Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7620B606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeFFLQB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:16:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:59409 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbeFFLP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:15:59 -0400
Date: Wed, 6 Jun 2018 13:15:57 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180606111557.xzs6l3lkvg7lq3ts@pathway.suse.cz>
References: <20180517143903.19339-1-pmladek@suse.com>
 <20180605124729.3vix5nlkjpjzdljx@pathway.suse.cz>
 <20180606051029.GA19211@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606051029.GA19211@tigerII.localdomain>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-06-06 14:10:29, Sergey Senozhatsky wrote:
> On (06/05/18 14:47), Petr Mladek wrote:
> [..]
> > Grr, the ABBA deadlock is still there. NMIs are not sent to the other
> > CPUs atomically. Even if we detect that logbuf_lock is available
> > in printk_nmi_enter() on some CPUs, it might still get locked on
> > another CPU before the other CPU gets NMI.
> 
> Can we do something about "B"? :) I mean - any chance we can rework
> locking in nmi_cpu_backtrace()?

I can't think of any possibility at the moment. Well, it does not mean
that it does not exist.

The irony is that we need the extra lock in nmi_cpu_backtrace() only
because we try to store the messages into the common log buffer.
If we always use the per-CPU buffers in NMI then the lock would
not cause any problems but it also won't be necessary.


> > By other words, any check in printk_safe_enter() is racy and not
> > sufficient
> 
> I suppose you meant printk_nmi_enter().

Yup, I am sorry for confusion.

> >   => I suggest to revert the commit 719f6a7040f1bdaf96fcc70
> >      "printk: Use the main logbuf in NMI when logbuf_lock is available"
> >      for-4.18 and stable until we get a better solution.
> 
> Just random thoughts.
> 
> May be we need to revert it, but let's not "panic". I think [but don't
> insist on it] that the patch in question is *probably* "good enough". It
> addresses a bug report after all.

It was a problem reported by me. I found it when testing other changes.
The patch improved the situation definitely. The question is if it is
enough in practice.


> How often do we have arch_trigger_cpumask_backtrace() on all CPUs these
> days? I tend to think that it used to be much more popular in the past,
> because we had a loops_per_jiffy based spin_lock lockup detection which
> would trigger NMI backtracase, but this functionality has gone, see
> bc88c10d7e6900916f5e1ba3829d66a9de92b633 for details.

AFAIK, we (SUSE) started to work on the printk/NMI deadlocks because
it was too risky to use sysrq-l on systems with many CPUs. It means that
the use case is still there.

Hmm, the original problem was that any interrupted logbuf_lock owner
caused the deadlock. It is _different now_ because the interrupted
logbuf_lock owner must block another CPU via the lock in
nmi_cpu_backtrace().

I actually wonder why this patch actually helped so much in my test
(while true; do echo l >/proc/sysrq-trigger; done). My guess is
that it increased a lot the number of CPUs using PRINTK_NMI_CONTEXT
(per-CPU buffers). Therefore the deadlock was less likely.
On the other hand, the original problem was basically back
without this patch.


> I'm not saying that the race condition that you found is
> unrealistic, I'm just saying that _it seems_ that
> nmi_panic()->printk() on a single CPU is more common
> now, so having that nmi_printk()->printk_deferred() might be quite
> valuable at the end of the day.

I see the point. I need to think about it.

> May be I'm wrong!
> 
> > The only safe solution seems to be a trylock() in NMI in
> > vprintk_emit() and fallback to vprintk_safe() when the lock
> > is not taken. I mean something like:
> > 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 247808333ba4..4a5a0bf221b3 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -1845,7 +1845,13 @@ asmlinkage int vprintk_emit(int facility, int level,
> >  	printk_delay();
> >  
> >  	/* This stops the holder of console_sem just where we want him */
> > -	logbuf_lock_irqsave(flags);
> > +	printk_safe_enter_irqsave(flags);
> > +	if (in_nmi() && !raw_spin_trylock(&logbuf_lock)) {
> > +		vprintk_nmi(fmt, args);
> > +		printk_safe_exit_irqrestore(flags);
> > +		return;
> > +	} else
> > +		raw_spin_lock(&logbuf_lock);
> >  	/*
> >  	 * The printf needs to come first; we need the syslog
> >  	 * prefix which might be passed-in as a parameter.
> 
> I need some time to think about it.

The bad thing about this solution is that different messages might
be handled different way during a single nmi_cpu_backtrace().
The result might be mixed backtraces in the log.


> > Sigh, this looks like a material for-4.19.
> 
> Agreed.
> 
> > We might need to revisit if printk_context still makes sense, ...

> What do you mean by this?

My dream was to select the right vprintk implementation according
to printk_context on a single place (vprintk_func()). If this is not
usable for NMI, we might need to think about another solution.
But this is premature. I believe the printk_context will most
likely make still sense.

I need to think more about it.

Best Regards,
Petr
