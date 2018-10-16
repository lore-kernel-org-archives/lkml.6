Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89509C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F562089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BYbgcSeo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F562089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeJPUor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:44:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55554 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeJPUor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3kq1AaMWv0oBC6tWjZTnnIzjgOgV2CGHc7jyTyWjRxU=; b=BYbgcSeo2DBaZBsu00ZQyBfLO
        P1u58NDTz63BoMC63gzX+E9NNzLrxjjVCmEBx0WdX8u7b9q0g79c2mWrs5XUwv21RZjbiFyTUI8ct
        3dn8H3aQlehANhGI1zZN6S/yKyH0uK/m/dpcHWwJ6HCv0t56g81bvOsP3Z1mbrx1gguLuUNkCW671
        m6gqrKHoYH0iGXEme0tHtM/yTnrs/1ieogKEQVhK4ydRXnsbBfXxkYk6GlUZUlkhW/dlhz7IAQSNF
        kx9KUTZIb0In/Qry46zn/AgNRygq8mUIfHHIU5KpCWS6eLznsgwVCsTrp6jKyZ4qZHjiGP9NtZ0H6
        NMnT6e9qg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCOra-0001nQ-8E; Tue, 16 Oct 2018 12:54:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C27A120297B77; Tue, 16 Oct 2018 14:54:15 +0200 (CEST)
Date:   Tue, 16 Oct 2018 14:54:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
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
Subject: Re: [RFC][PATCHv2 2/4] printk: move printk_safe macros to printk
 header
Message-ID: <20181016125415.GA3121@hirez.programming.kicks-ass.net>
References: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
 <20181016050428.17966-3-sergey.senozhatsky@gmail.com>
 <20181016072719.GB4030@hirez.programming.kicks-ass.net>
 <20181016122734.GA1259@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016122734.GA1259@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 09:27:34PM +0900, Sergey Senozhatsky wrote:
> per-CPU printk_safe _semi-magic_ makes some things simple to handle.
> We can't just remove per-CPU buffers and add a wake_up_process() at
> the bottom of vprintk_emit(). Because this will deadlock:
> 
>   printk()
>    wake_up_process()
>     try_to_wake_up()
>      raw_spin_lock_irqsave()
>  <NMI>
>       printk()
>        wake_up_process()
>         try_to_wake_up()
>          raw_spin_lock_irqsave()
> 
> So we still need some amount of per-CPU printk() semi-magic anyway.

All we need is 4 max-line-length buffers per-CPU. Nothing more.

The above trainwreck is the direct result of forcing synchronous
printk'ing (which I'm otherwise a big fan of, but regular console
drivers stink and are unfixable).

> And printk-kthread offloding will not eliminate the need of
> printk_deferred().

Why not? printk() will reduce to a lockless buffer insert. IOW _all_
printk is deferred.

All you need are 4 max-line-length buffers per CPU and a global/shared
lockless buffer.

printk will determine the current context:

  task, softirq, hardirq or NMI

and pick the corresponding per-cpu line buffer and do the vsnprintf()
thing. Then we have the actual line length and content. With the length
we reserve the bytes from the global buffer, we memcpy into the buffer
and commit.

Done.

The printk thread will observe it lags behind the buffer head and will
start printk-ing crud from task context.

> Speaking of lockless logbuf,
> logbuf buffer and logbuf_lock are the smallest of the problems printk
> currently has. Mainly because of lockless semi-magical printk_safe
> buffers.

Which are rubbish. You now have two buffers with duplicated
functionality and wildly different semantics.

Why not have a single buffer that does it all?

> Replacing one lockless buffer with another lockless buffer will
> not simplify things in this department. We probably additionally will
> have some nasty screw ups, e.g. when NMI printk on CPUA interrupts normal
> printk on the same CPUA and now we have mixed in characters; and so on.

Line buffers fix that. You don't need anything fancy for that.

> per-CPU printk_safe at least keeps us on the safe side in these cases and
> looks fairly simple.

printk_safe is an abomination, it fixes something that shouldn't need
fixing. See above.

> We do, however, have loads of problems with all those dependencies which
> come from serial drivers and friends: timekeeping, scheduler (scheduler
> is brilliant and cool, but we do have some deadlocks in printk because of
> it ;), tty, net, MM, wq, etc. So I generally like the idea of "detached
> serial consoles" (that's what I call it). IOW, elimination of the direct
> printk -> serial console path. 

Right; we need to get rid of that in the generic case. Only allow
lockless consoles (earlycon) to be used synchonously. With maybe a
special case for the BUG/PANIC case to push things out ASAP.

But given 'fine' console drivers like USB-serial, or DRM-framebuffer, I
don't know if it makes much difference to wake a thread and rely on that
or call it directly and deadlock :/

> The current approach - use the existing printk_safe mechanism and
> case-by-case, manually, break dependencies which can deadlock us is
> a lazy approach, yes; and not very convenient. I'm aware of it.

It's ugly and pushes ugly all over :/

> So, unless I'm missing something, things are not entirely that simple:
> - throw away printk_safe semi-magic
> - add a lockless logbuf
> - add wake_up_process() to vprintk_emit().

No, no wakups. irq_work to wake the printk-thread, at most.


