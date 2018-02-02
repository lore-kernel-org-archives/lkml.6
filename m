Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeBBOS2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:18:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:39676 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751469AbeBBOSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:18:22 -0500
Date: Fri, 2 Feb 2018 15:18:20 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: do not flush printk_safe from irq_work
Message-ID: <20180202141820.ri7pdgawyqjrcgem@pathway.suse.cz>
References: <20180124093723.1300-1-sergey.senozhatsky@gmail.com>
 <20180126152613.7mko26ulk24hzjlp@pathway.suse.cz>
 <20180129022918.GA24497@jagdpanzerIV>
 <20180130122317.a2lv4evl6v5hx62a@pathway.suse.cz>
 <20180201024647.GA984@jagdpanzerIV>
 <20180202121708.alnc65u2v43gtita@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202121708.alnc65u2v43gtita@pathway.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-02-02 13:17:08, Petr Mladek wrote:
> On Thu 2018-02-01 11:46:47, Sergey Senozhatsky wrote:
> > On (01/30/18 13:23), Petr Mladek wrote:
> > [..]
> > > > If the system is in "big troubles" then what makes irq_work more
> > > > possible? Local IRQs can stay disabled, just like preemption. I
> > > > guess when the troubles are really big our strategy is the same
> > > > for both wq and irq_work solutions - we keep the printk_safe buffer
> > > > and wait for panic()->flush.
> > > 
> > > But the patch still uses irq work because queue_work_on() could not
> > > be safely called from printk_safe(). By other words, it requires
> > > both irq_work and workqueues to be functional.
> > 
> > Right, that's all true. The reason it's done this way is because buffers can
> > be big and we still flush under console_sem in console_unlock() loop, which
> > can in theory be problematic. In other words, I wanted to remove the root
> > cause - irq flush of printk_safe while we are still in printing
> > loop.
> 
> Good point! We know that we would eventually push non-trivial amount
> of messages and it would make sense to do it from non-atomic context.
> 
> On the other hand, this does not solve the same problem with printk
> NMI buffer. And I guess that we do not want to risk offloading to
> workqueues for NMI messages.

By the above I want to say that I am not sure if it is worth having
different solution for flushing printk_safe and nmi buffer. We might
be forced to debug why a solution does not work. Shared solution and
shared issues might safe us some work.

I know that my alternative solution needed some extra code for
printk_safe as well. But it is pretty straightforward. It basically
just a check of a counter.

Note that the WQ-based solution is kind of tricky. There is
the journey printk() -> irq_work -> wq. Also it relies on
the fact that console_unlock() is called with disabled preemption.


> > > > I guess I'm OK with the wq dependency after all, but I may be mistaken.
> > > > printk_safe was never about "immediately flush the buffer", it was about
> > > > "avoid deadlocks", which was extended to "flush from any context which
> > > > will let us to avoid deadlock". It just happened that it inherited
> > > > irq_work dependency from printk_nmi.
> > > 
> > > I see the point. But if I remember correctly, it was also designed
> > > before we started to be concerned about a sudden death and "get
> > > printks out ASAP" mantra.
> > 
> > Can you elaborate a bit?

You probably knew the dates. Anyway, I want to say. Even when
the messages stored in the printk_safe buffer might be less
important, they still might be interesting and we might want
to get them out rather sooner than later.

All in all, it seems that we are basically down to the dilemma
between "get messages out ASAP" vs. "avoid softlockups".
We need to take into account:

   + printk_safe messages are more or less printk-subsystem
     specific. They might be "less" important for others.
     But who knows for sure?

   + the code complexity


With the above in mind, I still prefer the "easier" solution based
on the counter. If people had problems with softlockups,
we would need to solve them. But then they probably will have
this problem also with normal printk or in NMI and we would
probably need a solution that is not using workqueues.

Does this makes any sense?

Best Regards,
Petr


PS: I am sorry for so many mails today. Sometimes (often?), it is so
hard to understand and say things clearly. And it is Friday.
