Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBDCC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA4F20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544612922;
	bh=PDrtaN6cQnbKfzkNqPknBmaLeK+OqifZ2wMk4R/tvLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=No8mHYm1Jh9pMIUlMo/ZJ2IEtjzTrmWoE7cU/1DoAJM6DxR0qaaxkmd7uMNaNmgZs
	 9lAt+fd4RVrJRUe5Bbgl9Mm4YKc1HuIfppDUbbPPNpM0i4yyLPHpXDrr+Wn3R9H8qz
	 TNZS4wzbsbMzgOzBYdFL+9EOxvJEfuRVC0zsVT5Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA4F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbeLLLIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:08:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbeLLLIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:08:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D17DD2084E;
        Wed, 12 Dec 2018 11:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544612920;
        bh=PDrtaN6cQnbKfzkNqPknBmaLeK+OqifZ2wMk4R/tvLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e8mQFG9fjB6cys6l/uDi9eBWRIqiV8v3/aY6EUvy4ska6JL8gDKbDlbk/xT0ch7Eq
         4Pri3BN31+4UEsgoSGNmPuSpfKC27M/oG389YXRSKIhFAD/JXDny3e9Ir5o2/AJlzf
         8mEbn+YIsNQ7JFN+chukEP8+EMvhMdWhsmVmYTg4=
Date:   Wed, 12 Dec 2018 12:08:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Daniel Wang <wonderfly@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCHv2 3/4] serial: introduce uart_port locking helpers
Message-ID: <20181212110838.GA11361@kroah.com>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-4-sergey.senozhatsky@gmail.com>
 <20181208031249.GA443@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208031249.GA443@jagdpanzerIV>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 12:12:49PM +0900, Sergey Senozhatsky wrote:
> On (10/16/18 14:04), Sergey Senozhatsky wrote:
> [..]
> > - The first entry point is console ->write() callback, which we call
> >   from printk(). A possible deadlock scenario there is:
> > 
> >   CPU0
> > 	<NMI>
> > 	spin_lock_irqsave(&port->lock, flags)      << deadlock
> > 	serial_foo_write()
> > 	call_console_drivers()
> > 	console_unlock()
> > 	console_flush_on_panic()
> > 	panic()
> > 	<NMI/>
> > 	spin_lock_irqsave(&port->lock, flags)
> > 	serial_foo_write()
> > 	call_console_drivers()
> > 	console_unlock()
> > 	printk()
> > 	...
> 
> [..]
> > - The rest (of entry points) requires a bit different handling.
> >   Let's take a look at the following backtrace:
> > 
> >   	CPU0
> > 	<IRQ>
> > 	spin_lock_irqsave(&port->lock, flags)      << deadlock
> > 	serial_foo_write()
> > 	call_console_drivers()
> > 	console_unlock()
> > 	printk()
> > 	__queue_work()
> > 	tty_flip_buffer_push()
> > 	spin_lock_irqsave(&port->lock, flags)
> > 	serial_foo_handle_IRQ()
> > 	<IRQ/>
> >
> >   Serial drivers invoke tons of core kernel functions - WQ, MM, etc. All
> >   of which may printk() in various cases. So we can't really just
> >   "remove those printk-s". The simples way to address this seems to be
> >   PRINTK_SAFE_CONTEXT_MASK.
> 
> serial/UART and printk guys, sorry to bother you, do you hate this
> idea of removing console_driver->CORE KERNEL->printk->console_driver
> deadlock path? Or is there any chance we can move forward?

If done in a sane manner, no objection from me.
