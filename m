Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeBBBHb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 20:07:31 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33592 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBBBH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 20:07:26 -0500
X-Google-Smtp-Source: AH8x225/cM25mJJJiEipMuGsM0ZJjje287oSLdP+1u2KdRpJy429tHBGTcK/9xO6DqjERTaV2SI0gg==
Date: Fri, 2 Feb 2018 10:07:20 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: do not flush printk_safe from irq_work
Message-ID: <20180202010720.GB6533@jagdpanzerIV>
References: <20180124093723.1300-1-sergey.senozhatsky@gmail.com>
 <20180126152613.7mko26ulk24hzjlp@pathway.suse.cz>
 <20180129022918.GA24497@jagdpanzerIV>
 <20180201130025.38fa70e0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201130025.38fa70e0@gandalf.local.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/01/18 13:00), Steven Rostedt wrote:
> On Mon, 29 Jan 2018 11:29:18 +0900
> Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
[..]
> > If the system is in "big troubles" then what makes irq_work more
> > possible? Local IRQs can stay disabled, just like preemption. I
> > guess when the troubles are really big our strategy is the same
> > for both wq and irq_work solutions - we keep the printk_safe buffer
> > and wait for panic()->flush.
> 
> Working on the RT kernel, I would tell you there's a huge difference
> getting an irq_work to trigger than to expect something to schedule.
> 
> It takes much less to disable the systems scheduling than it does to
> disable interrupts. If interrupts are disabled, then so is scheduling.
> But if scheduling is disabled, interrupts may still trigger.

Sure, I understand those points and don't object any of those. Just
weighing the risks and benefits.

> But if printk_safe() is just for recursion protection, how important is
> it to get out?

Well, it depends. printk_safe can protect us against... what should I
call it... let's call it first order, or direct, printk recursion. The
one which involve locks internal to print. For instance,

	vprintk_emit()
	 spin_lock_irqsave(&logbuf_lock)
	  spin_lock_debug(...)
	   spin_dump()
	    printk()
	     vprintk_emit()
	      spin_lock_irqsave(&logbuf_lock)  << deadlock

printk_safe will save us by redirecting spin_dump()->printk().

printk_safe cannot protect us against second order, or indirect,
printk recursion. The one that involves locks which are external
to printk. In case of indirect recursion we can store lockdep report
in printk_safe, so we will not immediately recurse back to printk,
but in general it does not mean that we will be actually safe from
any deadlocks. For instance,

   timekeeping
    spin_lock_irqsave timer base
     printk
      call_console_drivers
       foo_console_driver
        mod_timer
	 spin_lock_irqsave timer base   << deadlock

printk_safe will not save us here, and most likely irq_work will
not happen on this CPU, because we deadlock with IRQs disabled.

So printk_safe output is in general of some interest, but we don't
have guarantees that it will be printed: if it was the direct printk
recursion - then it's all good, if indirect - then it may not be good.

	-ss
