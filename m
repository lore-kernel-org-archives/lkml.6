Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F17DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DCE222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732842AbfBMOP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:15:57 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46615 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfBMOP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:15:56 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gtvKC-000314-OO; Wed, 13 Feb 2019 15:15:44 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190213014141.GB8097@jagdpanzerIV>
Date:   Wed, 13 Feb 2019 15:15:42 +0100
In-Reply-To: <20190213014141.GB8097@jagdpanzerIV> (Sergey Senozhatsky's
        message of "Wed, 13 Feb 2019 10:41:41 +0900")
Message-ID: <878syj22r5.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-13, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>> - console_flush_on_panic() currently is a NOP. It is pretty clear how
>>   this could be implemented if atomic_write was available. But if no
>>   such console is registered, it is not clear what should be done. Is
>>   this function really even needed?
>
> If you now rely on a fully preemptible printk kthread to flush
> pending logbuf messages, then console_flush_on_panic() is your
> only chance to see those pending logbuf messages on the serial
> console when the system dies.

Anything critical would have already been immediately print to the
emergency consoles. And if an emergency console was available,
console_flush_on_panic() could be a special case where _all_ unseen
messages (regardless of importance) are printed to the emergency
console.

> Non-atomic consoles should become atomic once you call bust_spinlocks(1),
> this is what we currently have:
>
> 	panic()
> 	bust_spinlocks(1)                       // sets oops_in_progress
> 	console_flush_on_panic()
> 	 call_console_drivers()
> 	  -> serial_driver_write()
> 	      if (oops_in_progress)
> 	        locked = spin_trylock_irqsave(&port->lock);
> 	      uart_console_write();
> 	      if (locked)
> 	        spin_unlock_irqrestore(&port->lock);

I don't like bust_spinlocks() because drivers end up implementing
oops_in_progress with exactly that... ignoring their own locks. I prefer
consoles are provided with a locking mechanism that they can use to
support a separate NMI-safe write function. My series introduces
console_atomic_lock() for exactly this purpose.

But this doesn't help here. Here we are talking about a crashing system
that does _not_ have an emergency console. And in this case I would say
messages would be lost (just like they are now if all you have is a vt
console and it was busy).

I suppose we could keep the current bust_spinlocks() stuff for the
special case that there are no emergency consoles available. It's better
than nothing, but also not really reliable. Preferrably we figure out
how to implement write_atomic for all console drivers.

John Ogness
