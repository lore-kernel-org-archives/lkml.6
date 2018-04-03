Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751725AbeDCOse (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:48:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57386 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeDCOsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:48:33 -0400
Date: Tue, 3 Apr 2018 07:48:29 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Thomas Hellstrom <thomas@shipmail.org>
Cc: Chris Wilson <chris@chris-wilson.co.uk>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Signal handling in a page fault handler
Message-ID: <20180403144829.GB28565@bombadil.infradead.org>
References: <20180402141058.GL13332@bombadil.infradead.org>
 <152275879566.32747.9293394837417347482@mail.alporthouse.com>
 <e10f5e18-299b-57fd-4ba7-800caa1a105d@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e10f5e18-299b-57fd-4ba7-800caa1a105d@shipmail.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 03:12:35PM +0200, Thomas Hellstrom wrote:
> I think the TTM page fault handler originally set the standard for this.
> First, IMO any critical section that waits for the GPU (like typically the
> page fault handler does), should be locked at least killable. The need for
> interruptible locks came from the X server's silken mouse relying on signals
> for smooth mouse operations: You didn't want the X server to be stuck in the
> kernel waiting for GPU completion when it should handle the cursor move
> request.. Now that doesn't seem to be the case anymore but to reiterate
> Chris' question, why would the signal persist once returned to user-space?

Yeah, you graphics people have had to deal with much more recalcitrant
hardware than most of the rest of us ... and less reasonable user
expectations ("My graphics card was doing something and I expected
everything else to keep going" vs "My hard drive died and my kernel
paniced, oh well.")

I don't know exactly how the signal code works at the delivery end;
I'm not sure when TIF_SIGPENDING gets cleared.  I just get concerned
when I see one bit of kernel code doing things in a very complicated
and careful manner and another bit of kernel code blithely assuming
that everything's going to be OK.
