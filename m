Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeBACqy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 21:46:54 -0500
Received: from mail-pl0-f46.google.com ([209.85.160.46]:45457 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeBACqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 21:46:53 -0500
X-Google-Smtp-Source: AH8x227/qHwCR7sdXmhlawB9H64fnhzkKD6flGswbK0PIEYa74FxJcsb8XMLKkCxZGRlGRUYiBT1dw==
Date: Thu, 1 Feb 2018 11:46:47 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: do not flush printk_safe from irq_work
Message-ID: <20180201024647.GA984@jagdpanzerIV>
References: <20180124093723.1300-1-sergey.senozhatsky@gmail.com>
 <20180126152613.7mko26ulk24hzjlp@pathway.suse.cz>
 <20180129022918.GA24497@jagdpanzerIV>
 <20180130122317.a2lv4evl6v5hx62a@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130122317.a2lv4evl6v5hx62a@pathway.suse.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (01/30/18 13:23), Petr Mladek wrote:
[..]
> > If the system is in "big troubles" then what makes irq_work more
> > possible? Local IRQs can stay disabled, just like preemption. I
> > guess when the troubles are really big our strategy is the same
> > for both wq and irq_work solutions - we keep the printk_safe buffer
> > and wait for panic()->flush.
> 
> But the patch still uses irq work because queue_work_on() could not
> be safely called from printk_safe(). By other words, it requires
> both irq_work and workqueues to be functional.

Right, that's all true. The reason it's done this way is because buffers can
be big and we still flush under console_sem in console_unlock() loop, which
can in theory be problematic. In other words, I wanted to remove the root
cause - irq flush of printk_safe while we are still in printing loop.
Technically, we minimize the probability by throttling down printk_safe flush,
but we don't eliminate the possibility entirely. Maybe it is good enough,
maybe not. Opinions?

[..]
> > `console_recursion_limit' also makes PRINTK_SAFE_LOG_BUF_SHIFT
> > a bit useless and hard to understand - despite its value we will
> > store only 100 lines.
> >
> > We probably can replace `console_recursion_limit' with the following:
> > - in the current `console_recursion' section we let only SAFE_LOG_BUF_LEN
> >   chars to be stored in printk-safe buffer and, once we reached the limit,
> >   don't append any new messages until we are out of `console_recursion'
> >   context. Which is somewhat close to wq solution, the difference is that
> >   printk_safe can happen earlier if local IRQs are enabled.

      ^^^^^ printk_safe flush

> I like this idea. It would actually make perfect sense to use the same
> limit for PRINTK_SAFE buffer size and for the printk recursion.

Yes, we probably can do it that way, but this thing

    " They both should be big enough to "

is a bit of a concern. The "big enough to" can lead to different things.

> > I guess I'm OK with the wq dependency after all, but I may be mistaken.
> > printk_safe was never about "immediately flush the buffer", it was about
> > "avoid deadlocks", which was extended to "flush from any context which
> > will let us to avoid deadlock". It just happened that it inherited
> > irq_work dependency from printk_nmi.
> 
> I see the point. But if I remember correctly, it was also designed
> before we started to be concerned about a sudden death and "get
> printks out ASAP" mantra.

Can you elaborate a bit?

	-ss
