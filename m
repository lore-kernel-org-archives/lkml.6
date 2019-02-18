Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5A8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A722173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403859AbfBRR4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:56:50 -0500
Received: from foss.arm.com ([217.140.101.70]:35128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389053AbfBRR4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:56:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCB4C80D;
        Mon, 18 Feb 2019 09:56:49 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D83DC3F675;
        Mon, 18 Feb 2019 09:56:27 -0800 (PST)
Date:   Mon, 18 Feb 2019 17:56:25 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190218175625.GD16713@fuggles.cambridge.arm.com>
References: <20190211172948.3322-1-will.deacon@arm.com>
 <CAK8P3a2Pr2oWYB7QHQMaHRq6H8h9xMwhhyJz5Pu67bVe4GaK9g@mail.gmail.com>
 <20190218162954.GB16713@fuggles.cambridge.arm.com>
 <CAK8P3a1TY9S=zYsdZ5O021p2yYcZhehVuwB3_65dR6x6zbkTYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1TY9S=zYsdZ5O021p2yYcZhehVuwB3_65dR6x6zbkTYQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 05:59:13PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 18, 2019 at 5:30 PM Will Deacon <will.deacon@arm.com> wrote:
> >
> > On Tue, Feb 12, 2019 at 02:03:04PM +0100, Arnd Bergmann wrote:
> > > On Mon, Feb 11, 2019 at 6:29 PM Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > > +     __iomem pointers obtained with non-default attributes (e.g. those returned
> > > > +     by ioremap_wc()) are unlikely to provide many of these guarantees. If
> > > > +     ordering is required for such mappings, then the mandatory barriers should
> > > > +     be used in conjunction with the _relaxed() accessors defined below.
> > >
> > > I wonder if we are even able to guarantee consistent behavior across
> > > architectures
> > > in the last case here (wc mapping with relaxed accessors and barriers).
> > >
> > > Fortunately, there are only five implementations that actually differ from
> > > ioremap_nocache(): arm32, arm64, ppc32, ppc64 and x86 (both 32/64), so
> > > that is something we can probably figure out between the people on Cc.
> >
> ...
> > > The problem with recommending *_relaxed() + barrier() is that it ends
> > > up being more expensive than the non-relaxed accessors whenever
> > > _relaxed() implies the barrier already (true on most architectures other
> > > than arm).
> > >
> > > ioremap_wc() in turn is used almost exclusively to map RAM behind
> > > a bus, (typically for frame buffers) and we may be better off not
> > > assuming any particular MMIO barrier semantics for it at all, but possibly
> > > audit the few uses that are not frame buffers.
> >
> > Right, my expectation is actually that you very rarely need ordering
> > guarantees for wc mappings, and so saying "relaxed + mandatory barriers"
> > is the best thing to say for portable driver code. I'm deliberately /not/
> > trying to enumerate arch or device-specific behaviours.
> 
> That's fine, my worry is more that you are already saying too much
> by describing a behavior for ioremap_wc+relaxed+barrier that is
> neither a good idea or guaranteed to do what you describe.

I could drop the mention of relaxed accessors here for now, if you like?
For example:

  "__iomem pointers obtained with non-default attributes (e.g. those returned
   by ioremap_wc()) are unlikely to provide many of these guarantees. If
   ordering is required for such mappings, then the mandatory barriers should
   be used."

which we could flesh out if/when we have a notion of the portable semantics.

> > > >   (*) ioreadX(), iowriteX()
> > > >
> > > >       These will perform appropriately for the type of access they're actually
> > > >       doing, be it inX()/outX() or readX()/writeX().
> > >
> > > This probably needs clarification as well then: On architectures that
> > > have a stronger barrier after outX() than writeX() but that use memory
> > > mapped access for both, the statement is currently not true. We could
> > > either strengthen the requirement by requiring CONFIG_GENERIC_IOMAP
> > > on such architectures, or we could document the current behavior
> > > as intentional and explicitly not allow iowriteX() on I/O ports to be posted.
> >
> > At least on arm and arm64, the heavy barrier in outX() is *before* the I/O
> > access, and so it does nothing to prevent the access from being posted. It
> > looks like the asm-generic/io.h behaviour is the same in the case that none
> > of the __io_* barriers are provided by the architecture.
> >
> > Do you think this is something we actually need to strengthen, or are
> > drivers that rely on this going to be x86-specific anyway?
> 
> I would say we should strengthen the behavior of outX() where possible.
> I don't know if arm64 actually has a way of doing that, my understanding
> earlier was that the AXI bus was already posted, so there is not much
> you can do here to define __io_paw() in a way that will prevent posted
> writes.

If we could map I/O space using different page table attributes (probably by
hacking pci_remap_iospace() ?) then we could disable the
early-write-acknowledge hint and implement __io_paw() as a completion
barrier, although it would be at the mercy of the system as to whether or
not that requires a response from the RC.

I would still prefer to document the weaker semantics as the portable
interface, unless there are portable drivers relying on this today (which
would imply that it's widely supported by other architectures).

Will
