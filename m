Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932207AbeDCMdV convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:33:21 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:49631 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932100AbeDCMdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:33:20 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Matthew Wilcox <willy@infradead.org>, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, "Souptick Joarder" <jrdr.linux@gmail.com>
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20180402141058.GL13332@bombadil.infradead.org>
Cc: linux-kernel@vger.kernel.org
References: <20180402141058.GL13332@bombadil.infradead.org>
Message-ID: <152275879566.32747.9293394837417347482@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: Signal handling in a page fault handler
Date: Tue, 03 Apr 2018 13:33:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthew Wilcox (2018-04-02 15:10:58)
> 
> Souptick and I have been auditing the various page fault handler routines
> and we've noticed that graphics drivers assume that a signal should be
> able to interrupt a page fault.  In contrast, the page cache takes great
> care to allow only fatal signals to interrupt a page fault.
> 
> I believe (but have not verified) that a non-fatal signal being delivered
> to a task which is in the middle of a page fault may well end up in an
> infinite loop, attempting to handle the page fault and failing forever.
> 
> Here's one of the simpler ones:
> 
>         ret = mutex_lock_interruptible(&etnaviv_obj->lock);
>         if (ret)
>                 return VM_FAULT_NOPAGE;
> 
> (many other drivers do essentially the same thing including i915)
> 
> On seeing NOPAGE, the fault handler believes the PTE is in the page
> table, so does nothing before it returns to arch code at which point
> I get lost in the magic assembler macros.  I believe it will end up
> returning to userspace if the signal is non-fatal, at which point it'll
> go right back into the page fault handler, and mutex_lock_interruptible()
> will immediately fail.  So we've converted a sleeping lock into the most
> expensive spinlock.

I'll ask the obvious question: why isn't the signal handled on return to
userspace?

> I don't think the graphics drivers really want to be interrupted by
> any signal.

Assume the worst case and we may block for 10s. Even a 10ms delay may be
unacceptable to some signal handlers (one presumes). For the number one
^C usecase, yes that may be reduced to only bother if it's killable, but
I wonder if there are not timing loops (e.g. sigitimer in Xorg < 1.19)
that want to be able to interrupt random blockages.
-Chris
