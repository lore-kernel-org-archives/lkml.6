Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854DDECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A6B20685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A6B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbeJaVZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:25:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:44748 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728844AbeJaVZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:25:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77576B0E3;
        Wed, 31 Oct 2018 12:27:39 +0000 (UTC)
Date:   Wed, 31 Oct 2018 13:27:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv3] panic: avoid deadlocks in re-entrant console drivers
Message-ID: <20181031122736.epbxu424l3xagge5@pathway.suse.cz>
References: <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181025101036.6823-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025101036.6823-1-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-10-25 19:10:36, Sergey Senozhatsky wrote:
> >From printk()/serial console point of view panic() is special, because
> it may force CPU to re-enter printk() or/and serial console driver.
> Therefore, some of serial consoles drivers are re-entrant. E.g. 8250:
> 
> serial8250_console_write()
> {
>         if (port->sysrq)
>                 locked = 0;
>         else if (oops_in_progress)
>                 locked = spin_trylock_irqsave(&port->lock, flags);
>         else
>                 spin_lock_irqsave(&port->lock, flags);
> 	...
> }
> 
> panic() does set oops_in_progress via bust_spinlocks(1), so in theory
> we should be able to re-enter serial console driver from panic():
> 
> 	CPU0
> 	<NMI>
> 	uart_console_write()
> 	serial8250_console_write()		// if (oops_in_progress)
> 						//    spin_trylock_irqsave()
> 	call_console_drivers()
> 	console_unlock()
> 	console_flush_on_panic()
> 	bust_spinlocks(1)			// oops_in_progress++
> 	panic()
> 	<NMI/>
> 	spin_lock_irqsave(&port->lock, flags)   // spin_lock_irqsave()
> 	serial8250_console_write()
> 	call_console_drivers()
> 	console_unlock()
> 	printk()
> 	...
> 
> However, this does not happen and we deadlock in serial console on
> port->lock spinlock. And the problem is that console_flush_on_panic()
> called after bust_spinlocks(0):
> 
> void panic(const char *fmt, ...)
> {
>         bust_spinlocks(1);
> ...
>         bust_spinlocks(0);
>         console_flush_on_panic();
> ...
> }
> 
> bust_spinlocks(0) decrements oops_in_progress, so oops_in_progress
> can go back to zero. Thus even re-entrant console drivers will simply
> spin on port->lock spinlock. Given that port->lock may already be
> locked either by a stopped CPU, or by the very same CPU we execute
> panic() on (for instance, NMI panic() on printing CPU) the system
> deadlocks and does not reboot.
> 
> Fix this by removing bust_spinlocks(0), so oops_in_progress is always
> set in panic() now and, thus, re-entrant console drivers will trylock
> the port->lock instead of spinning on it forever, when we call them
> from console_flush_on_panic().
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

The patch makes sense to me. The locks should stay busted also for
console_flush_on_panic().

With the added #include <linux/vt_kern.h>:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
