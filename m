Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDDBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E73213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfBZJpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:45:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:34298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbfBZJpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:45:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2AE6EAFF9;
        Tue, 26 Feb 2019 09:45:38 +0000 (UTC)
Date:   Tue, 26 Feb 2019 10:45:37 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Subject: Re: [RFC PATCH v1 10/25] printk: redirect emit/store to new
 ringbuffer
Message-ID: <20190226094537.46xfhv5rr5m4c33s@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-11-john.ogness@linutronix.de>
 <20190220090112.xbnauwt2w7gwtebo@pathway.suse.cz>
 <8736oijgpf.fsf@linutronix.de>
 <20190225121106.oig7s6odqikcn4xw@pathway.suse.cz>
 <875zt7bz1t.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zt7bz1t.fsf@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-02-25 17:41:50, John Ogness wrote:
> On 2019-02-25, Petr Mladek <pmladek@suse.com> wrote:
> >> >> vprintk_emit and vprintk_store are the main functions that all printk
> >> >> variants eventually go through. Change these to store the message in
> >> >> the new printk ring buffer that the printk kthread is reading.
> >> >
> >> > Please, are there any candidates or plans to reuse the new ring
> >> > buffer implementation?
> >> 
> >> As you pointed out below, this patch already uses the ring buffer
> >> implementation for a totally different purpose: NMI safe dynamic memory
> >> allocation.
> >
> > I have found an alternative solution. We could calculate the length
> > of the formatted string without any buffer:
> >
> > 	va_list args_copy;
> >
> > 	va_copy(args_copy, args);
> > 	len = vscprintf(NULL, fmt, args_copy);
> > 	va_end(args_copy);
> >
> > This vsprintf() mode was implemented for exactly this purpose.
> 
> For vprintk_emit() that would work. As you will see in later (patch 23),
> the sprint_rb ringbuffer is used for dynamic memory allocation for
> kmsg_dump functions as well.

It looks dangerous to share a limited buffer between core kernel
functionality and user-space triggered one. I mean that an unlimited
number of devkmsg operations must not cause loosing printk() messages.

> The current printk implementation allows readers to read directly from
> the ringbuffer. The proposed ringbuffer requires the reader (printk) to
> have its own buffers.
> 
> We may be able to find an alternate solution here as well if that is
> desired.

I hope that we will be able to find one. The previous implementation
needed some buffers as well. We should be able to use the same
approach.

I guess that one problem is that the new ringbuffer API is not
able to copy just the text directly into the user-provided buffer.
It might get solved by extending the API.

Anyway, I still have to look at the remaining patches.

Best Regards,
Petr
