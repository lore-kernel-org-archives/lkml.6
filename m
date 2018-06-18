Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F00C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AA620864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AA620864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935030AbeFRNiy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:38:54 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:33268 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934267AbeFRNiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:38:52 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w5IDcJE5007311;
        Mon, 18 Jun 2018 14:38:19 +0100
Date:   Mon, 18 Jun 2018 14:38:18 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
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
Message-ID: <20180618143818.50b2f2f9@alans-desktop>
In-Reply-To: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
References: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It doesn't come as a surprise that recursive printk() calls are not the
> only way for us to deadlock in printk() and we still have a whole bunch
> of other printk() deadlock scenarios. For instance, those that involve
> TTY port->lock spin_lock and UART port->lock spin_lock.

The tty layer code there is not re-entrant. Nor is it supposed to be

> So the idea of this patch set is to take tty_port->lock and
> uart_port->lock from printk_safe context and to eliminate some
> of non-recursive printk() deadlocks - the ones that don't start
> in printk(), but involve console related locks and thus eventually
> deadlock us in printk(). For this purpose the patch set introduces
> several helper macros:

I don't see how this helps - if you recurse into the uart code you are
still hitting the paths that are unsafe when re-entered. All you've done
is messed up a pile of locking code on critical performance paths.

As it stands I think it's a bad idea.

> Of course, TTY and UART port spin_locks are not the only locks that
> we can deadlock on. So this patch set does not address all deadlock
> scenarios, it just makes a small step forward.
> 
> Any opinions?

The cure is worse than the disease.

The only case that's worth looking at is the direct polled console code
paths. The moment you touch the other layers you add essentially never
needed code to hot paths.

Given printk nowdays is already somewhat unreliable with all the perf
related changes, and we have other good debug tools I think it would be
far cleaner to have some kind of


	if (spin_trylock(...)) {
		console_defer(buffer);
		return;
	}

helper layer in the printk/console logic, at least for the non panic/oops
cases.

Alan
