Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbeA3MXU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 07:23:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:54968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751638AbeA3MXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 07:23:19 -0500
Date: Tue, 30 Jan 2018 13:23:17 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: do not flush printk_safe from irq_work
Message-ID: <20180130122317.a2lv4evl6v5hx62a@pathway.suse.cz>
References: <20180124093723.1300-1-sergey.senozhatsky@gmail.com>
 <20180126152613.7mko26ulk24hzjlp@pathway.suse.cz>
 <20180129022918.GA24497@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129022918.GA24497@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-01-29 11:29:18, Sergey Senozhatsky wrote:
> On (01/26/18 16:26), Petr Mladek wrote:
> [..]
> > First, this delays showing eventually valuable information until
> > the preemption is enabled. It might never happen if the system
> > is in big troubles. In each case, it might be much longer delay
> > than it was before.
> 
> If the system is in "big troubles" then what makes irq_work more
> possible? Local IRQs can stay disabled, just like preemption. I
> guess when the troubles are really big our strategy is the same
> for both wq and irq_work solutions - we keep the printk_safe buffer
> and wait for panic()->flush.

But the patch still uses irq work because queue_work_on() could not
be safely called from printk_safe(). By other words, it requires
both irq_work and workqueues to be functional. Note that there
might be deadlock or livelock in the workqueues subsystem. It is
just another non-trivial thingy that might get wrong.

Also interrupts are handled immediately when they are enabled.
On the other hand, a workqueue work is proceed only when the worker
is scheduled and the work is first in the queue. It might
take ages if there is a high load on the CPU or on the given
workqueue.


> > Second, it makes printk() dependent on another non-trivial subsystem.
> > I mean workqueues.
> [..]
> > The following, a bit ugly, solution has came to my mind. We could
> > think about it like extending the printk_context. It counts
> > printks called in this context and does nothing when we reach
> > the limit. The difference is that the context is task-specific
> > instead of CPU-specific.
> [..]
> > +int console_recursion_count;
> > +int console_recursion_limit = 100;
> 
> Hm... I'm not entirely happy with magic constants, to be honest.
> Why 100? One of the printk_safe lockdep reports I saw was ~270
> lines long: https://marc.info/?l=linux-kernel&m=150659041411473&w=2

I am not happy with this constant either. It was used just for
a simplicity of the RFC.


> `console_recursion_limit' also makes PRINTK_SAFE_LOG_BUF_SHIFT
> a bit useless and hard to understand - despite its value we will
> store only 100 lines.
>
> We probably can replace `console_recursion_limit' with the following:
> - in the current `console_recursion' section we let only SAFE_LOG_BUF_LEN
>   chars to be stored in printk-safe buffer and, once we reached the limit,
>   don't append any new messages until we are out of `console_recursion'
>   context. Which is somewhat close to wq solution, the difference is that
>   printk_safe can happen earlier if local IRQs are enabled.

I like this idea. It would actually make perfect sense to use the same
limit for PRINTK_SAFE buffer size and for the printk recursion.

They both should be big enough to allow a meaningful report. On
the other hand, they both should be relatively small. One because
of memory constrains, the other because of reducing redundancy.

In each case, there is a direct dependency. The recursive messages
are stored into the printk_safe buffer.


>   same time someone might set PRINTK_SAFE_LOG_BUF_SHIFT big enough to
>   still cause troubles, just because printk-deadlock errors sound scary
>   and important enough.

We could always make it more complicated if people come up with
a reasonable use case. IMHO, most people will not care about
these limits.


> I guess I'm OK with the wq dependency after all, but I may be mistaken.
> printk_safe was never about "immediately flush the buffer", it was about
> "avoid deadlocks", which was extended to "flush from any context which
> will let us to avoid deadlock". It just happened that it inherited
> irq_work dependency from printk_nmi.

I see the point. But if I remember correctly, it was also designed
before we started to be concerned about a sudden death and "get
printks out ASAP" mantra.

Best Regards,
Petr
