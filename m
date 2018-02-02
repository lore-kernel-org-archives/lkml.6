Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeBBKXw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 05:23:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:47912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbeBBKXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 05:23:45 -0500
Date: Fri, 2 Feb 2018 11:23:43 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: do not flush printk_safe from irq_work
Message-ID: <20180202102343.ibtrlvmp7cezmn2t@pathway.suse.cz>
References: <20180124093723.1300-1-sergey.senozhatsky@gmail.com>
 <20180126152613.7mko26ulk24hzjlp@pathway.suse.cz>
 <20180129022918.GA24497@jagdpanzerIV>
 <20180201130025.38fa70e0@gandalf.local.home>
 <20180202010720.GB6533@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202010720.GB6533@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-02-02 10:07:20, Sergey Senozhatsky wrote:
> On (02/01/18 13:00), Steven Rostedt wrote:
> > On Mon, 29 Jan 2018 11:29:18 +0900
> > Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> [..]
> > > If the system is in "big troubles" then what makes irq_work more
> > > possible? Local IRQs can stay disabled, just like preemption. I
> > > guess when the troubles are really big our strategy is the same
> > > for both wq and irq_work solutions - we keep the printk_safe buffer
> > > and wait for panic()->flush.
> > 
> > Working on the RT kernel, I would tell you there's a huge difference
> > getting an irq_work to trigger than to expect something to schedule.

And this is not only about scheduling. It is also about having
a worker ready to handle the work. So, there is yet another
level that can eventually fail.


> > But if printk_safe() is just for recursion protection, how important is
> > it to get out?

Good question!

> Well, it depends. printk_safe can protect us against... what should I
> call it... let's call it first order, or direct, printk recursion. The
> one which involve locks internal to print. For instance,
> 
> 	vprintk_emit()
> 	 spin_lock_irqsave(&logbuf_lock)
> 	  spin_lock_debug(...)
> 	   spin_dump()
> 	    printk()
> 	     vprintk_emit()
> 	      spin_lock_irqsave(&logbuf_lock)  << deadlock
> 
> printk_safe will save us by redirecting spin_dump()->printk().
> 
> So printk_safe output is in general of some interest, but we don't
> have guarantees that it will be printed: if it was the direct printk
> recursion - then it's all good, if indirect - then it may not be good.

IMHO, the question is if the information about printk recursion would
help to understand the situation on the system or if it would just
add a noise to the original problem.

I would personally prefer to know about it. But I do not feel
experienced enough to make a generic decision.

Best Regards,
Petr
