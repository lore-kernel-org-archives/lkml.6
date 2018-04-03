Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932272AbeDCNKa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:10:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbeDCNK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:10:28 -0400
Date: Tue, 3 Apr 2018 06:10:25 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Signal handling in a page fault handler
Message-ID: <20180403131025.GF5832@bombadil.infradead.org>
References: <20180402141058.GL13332@bombadil.infradead.org>
 <152275879566.32747.9293394837417347482@mail.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152275879566.32747.9293394837417347482@mail.alporthouse.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 01:33:15PM +0100, Chris Wilson wrote:
> Quoting Matthew Wilcox (2018-04-02 15:10:58)
> > Souptick and I have been auditing the various page fault handler routines
> > and we've noticed that graphics drivers assume that a signal should be
> > able to interrupt a page fault.  In contrast, the page cache takes great
> > care to allow only fatal signals to interrupt a page fault.
> > 
> > I believe (but have not verified) that a non-fatal signal being delivered
> > to a task which is in the middle of a page fault may well end up in an
> > infinite loop, attempting to handle the page fault and failing forever.
> > 
> > Here's one of the simpler ones:
> > 
> >         ret = mutex_lock_interruptible(&etnaviv_obj->lock);
> >         if (ret)
> >                 return VM_FAULT_NOPAGE;
> > 
> > (many other drivers do essentially the same thing including i915)
> > 
> > On seeing NOPAGE, the fault handler believes the PTE is in the page
> > table, so does nothing before it returns to arch code at which point
> > I get lost in the magic assembler macros.  I believe it will end up
> > returning to userspace if the signal is non-fatal, at which point it'll
> > go right back into the page fault handler, and mutex_lock_interruptible()
> > will immediately fail.  So we've converted a sleeping lock into the most
> > expensive spinlock.
> 
> I'll ask the obvious question: why isn't the signal handled on return to
> userspace?

As I said, I don't know exactly how it works due to getting lost in the
assembler parts of kernel entry/exit.  But if it did work, then wouldn't
the page cache use it, rather than taking such great pains to only handle
fatal signals?  See commit 37b23e0525d393d48a7d59f870b3bc061a30ccdb
which introduced it.

One thing I did come up with is: What if the signal handler is the
one touching the page that needs to be faulted in?  And for the page
cache case, what if the page that needs to be faulted in is the page
containing the text of the signal handler?  (I don't think we support
mapping graphics memory PROT_EXEC ;-)

> > I don't think the graphics drivers really want to be interrupted by
> > any signal.
> 
> Assume the worst case and we may block for 10s. Even a 10ms delay may be
> unacceptable to some signal handlers (one presumes). For the number one
> ^C usecase, yes that may be reduced to only bother if it's killable, but
> I wonder if there are not timing loops (e.g. sigitimer in Xorg < 1.19)
> that want to be able to interrupt random blockages.

Ah, setitimer / SIGALRM.  So what do we want to have happen if that
signal handler touches the mmaped device memory?
