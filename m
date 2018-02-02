Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbeBBMRU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:17:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:56982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750773AbeBBMRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:17:11 -0500
Date: Fri, 2 Feb 2018 13:17:08 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: do not flush printk_safe from irq_work
Message-ID: <20180202121708.alnc65u2v43gtita@pathway.suse.cz>
References: <20180124093723.1300-1-sergey.senozhatsky@gmail.com>
 <20180126152613.7mko26ulk24hzjlp@pathway.suse.cz>
 <20180129022918.GA24497@jagdpanzerIV>
 <20180130122317.a2lv4evl6v5hx62a@pathway.suse.cz>
 <20180201024647.GA984@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180201024647.GA984@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-02-01 11:46:47, Sergey Senozhatsky wrote:
> On (01/30/18 13:23), Petr Mladek wrote:
> [..]
> > > If the system is in "big troubles" then what makes irq_work more
> > > possible? Local IRQs can stay disabled, just like preemption. I
> > > guess when the troubles are really big our strategy is the same
> > > for both wq and irq_work solutions - we keep the printk_safe buffer
> > > and wait for panic()->flush.
> > 
> > But the patch still uses irq work because queue_work_on() could not
> > be safely called from printk_safe(). By other words, it requires
> > both irq_work and workqueues to be functional.
> 
> Right, that's all true. The reason it's done this way is because buffers can
> be big and we still flush under console_sem in console_unlock() loop, which
> can in theory be problematic. In other words, I wanted to remove the root
> cause - irq flush of printk_safe while we are still in printing
> loop.

Good point! We know that we would eventually push non-trivial amount
of messages and it would make sense to do it from non-atomic context.

On the other hand, this does not solve the same problem with printk
NMI buffer. And I guess that we do not want to risk offloading to
workqueues for NMI messages.


> > > I guess I'm OK with the wq dependency after all, but I may be mistaken.
> > > printk_safe was never about "immediately flush the buffer", it was about
> > > "avoid deadlocks", which was extended to "flush from any context which
> > > will let us to avoid deadlock". It just happened that it inherited
> > > irq_work dependency from printk_nmi.
> > 
> > I see the point. But if I remember correctly, it was also designed
> > before we started to be concerned about a sudden death and "get
> > printks out ASAP" mantra.
> 
> Can you elaborate a bit?

The pull request with printk_safe was sent on February 22, 2017, see
https://lkml.kernel.org/r/20170222114705.GA30336@linux.suse

The printk softlockup was still being solved by an immediate offload
from vprintk_emit() on March 29, 2017, see
https://lkml.kernel.org/r/20170329092511.3958-3-sergey.senozhatsky@gmail.com

I believe that it was the mail from Pavel Machek that made us
thinking about the sudden death. It was sent on April 7, 2017,
see https://lkml.kernel.org/r/20170407120642.GB4756@amd

The first version with the offload from console_unlock was
sent on May 9, 2017, see
https://lkml.kernel.org/r/20170509082859.854-3-sergey.senozhatsky@gmail.com

I am not exactly sure when the "get printks out ASAP" mantra started
but I cannot forget the mail from June 30, 2017, see
https://lkml.kernel.org/r/20170630070131.GA474@jagdpanzerIV.localdomain

Best Regards,
Petr
