Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C04C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940AC2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940AC2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965719AbeFSIaa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:30:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:37071 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965372AbeFSIaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:30:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9477AAED2;
        Tue, 19 Jun 2018 08:30:22 +0000 (UTC)
Date:   Tue, 19 Jun 2018 10:30:21 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port
 locks
Message-ID: <20180619083021.4avsgvcqjrpkat6s@pathway.suse.cz>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
 <20180618143818.50b2f2f9@alans-desktop>
 <20180619005308.GA405@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619005308.GA405@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-06-19 09:53:08, Sergey Senozhatsky wrote:
> Thanks for taking a look!
> 
> On (06/18/18 14:38), Alan Cox wrote:
> > > It doesn't come as a surprise that recursive printk() calls are not the
> > > only way for us to deadlock in printk() and we still have a whole bunch
> > > of other printk() deadlock scenarios. For instance, those that involve
> > > TTY port->lock spin_lock and UART port->lock spin_lock.
> > 
> > The tty layer code there is not re-entrant. Nor is it supposed to be

It is re-entrant via printk(). I mean that any printk() called inside
the locked sections might cause recursion if the same lock is needed
also by con->write() callbacks.


> Could be.
> 
> But at least we have circular locking dependency in tty,
> see [1] for more details:
> 
>   tty_port->lock  => uart_port->lock
> 
>    CPU0
>    tty
>     spin_lock(&tty_port->lock)
>      printk()
>       call_console_drivers()
>        foo_console_write()
>         spin_lock(&uart_port->lock)
> 
> Whereas we normally have
> 
>   uart_port->lock => tty_port->lock
> 
>    CPU1
>    IRQ
>     foo_console_handle_IRQ()
>      spin_lock(&uart_port->lock)
>       tty
>        spin_lock(&tty_port->lock)

This is even more complicated situation because printk() allowed
an ABBA lock scenario.

> If we switch to printk_safe when we take tty_port->lock then we
> remove the printk->uart_port chain from the picture.
> 
> > > So the idea of this patch set is to take tty_port->lock and
> > > uart_port->lock from printk_safe context and to eliminate some
> > > of non-recursive printk() deadlocks - the ones that don't start
> > > in printk(), but involve console related locks and thus eventually
> > > deadlock us in printk(). For this purpose the patch set introduces
> > > several helper macros:
> > 
> > I don't see how this helps - if you recurse into the uart code you are
> > still hitting the paths that are unsafe when re-entered. All you've done
> > is messed up a pile of locking code on critical performance paths.
> > 
> > As it stands I think it's a bad idea.
> 
> The only new thing is that we inc/dec per-CPU printk context
> variable when we lock/unlock tty/uart port lock:
> 
> 	printk_safe_enter() -> this_cpu_inc(printk_context);
> 	printk_safe_exit() -> this_cpu_dec(printk_context);

To make it clear. This patch set adds yet another spin_lock API.
It behaves exactly as spin_lock_irqsafe()/spin_unlock_irqrestore()
but in addition it sets printk_context.

Where printk_context defines what printk implementation is safe. We
basically have four possibilities:

  1. normal   (store in logbuf, try to handle consoles)
  2. deferred (store in logbuf, deffer consoles)
  3. safe     (store in per-CPU buffer, deffer everything)
  4. safe_nmi (store in another per-CPU buffer, deffer everything)


This patchset forces safe context around TTY and UART locks.
In fact, the deferred context would be enough to prevent
all the mentioned deadlocks.

IMHO, the only question is if people might get familiar with
yet another spin_lock API.

Best Regards,
Petr
