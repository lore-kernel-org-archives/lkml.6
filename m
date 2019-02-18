Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69875C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B792177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390258AbfBRQuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:50:23 -0500
Received: from foss.arm.com ([217.140.101.70]:34132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbfBRQuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:50:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82F1380D;
        Mon, 18 Feb 2019 08:50:22 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68E143F675;
        Mon, 18 Feb 2019 08:50:10 -0800 (PST)
Date:   Mon, 18 Feb 2019 16:50:07 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190218165007.GC16713@fuggles.cambridge.arm.com>
References: <20190211172948.3322-1-will.deacon@arm.com>
 <CAHk-=wiP42aqBApAUJbLAB43u5ips9ArgLxXn5L1r74bowxdow@mail.gmail.com>
 <20190213172047.GH6346@brain-police>
 <CAHk-=wigYDMPnoFRC9eBystt0gi6n1yQtAyuEqVg6x+5znOk6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wigYDMPnoFRC9eBystt0gi6n1yQtAyuEqVg6x+5znOk6A@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:27:09AM -0800, Linus Torvalds wrote:
> On Wed, Feb 13, 2019 at 9:20 AM Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Feb 11, 2019 at 02:34:31PM -0800, Linus Torvalds wrote:
> > > IOW, we should seriously just consider making the rule be that locking
> > > will order mmio too. Because that's practically the rule anyway.
> >
> > I would /love/ to get rid of mmiowb() because I think it's both extremely
> > difficult to use and also pretty much never needed. It reminds me a lot of
> > smp_read_barrier_depends(), which we finally pushed into READ_ONCE for
> > Alpha.
> 
> Right. Make as much of this implicit as we can.
> 
> At least as long as it's _reasonably_ cheap on all architectures that matter.
> 
> How expensive would it be on ARM? Does the normal acquire/release
> already mean the IO in between is serialized?

Yeah, that should work, but actually I'm wondered whether that means we can
relax our mandatory barriers as well now that we have a multi-copy atomic
memory model (i.e. if acquire/release works for locks between CPUs, then it
should work for DMA buffers between a CPU and a device). I'll chase this up
with the architects...

Either way, mmiowb() is an empty macro for us.

> > > Powerpc already does it. IO within a locked region will serialize with the
> > > lock.
> >
> > I thought ia64 was the hold out here? Did they actually have machines that
> > needed this in practice?
> 
> Note that even if mmiowb() is expensive (and I don't think that's
> actually even the case on ia64), you can - and probably should - do
> what PowerPC does.
> 
> Doing an IO barrier on PowerPC is insanely expensive, but they solve
> that simply track the whole "have I done any IO" manually. It's not
> even that expensive, it just uses a percpu flag.
> 
> (Admittedly, PowerPC makes it less obvious that it's a percpu variable
> because it's actually in the special "paca" region that is like a
> hyper-local percpu area).
> 
> > If so, I think we can either:
> >
> >   (a) Add an mmiowb() to their spin_unlock() code, or
> >   (b) Remove ia64 altogether if nobody complains
> >
> > I know that Peter has been in favour of (b) for a while...
> 
> I don't think we're quite ready for (b), but see above: I don't think
> adding mmiowb() to the ia64 spin unlock code is even all that
> expensive.

Well, I figured it was worth asking the question.

> Yeah, yeah, there's the SGI "SN" platform that apparently has a bug,
> so because of that platform problem maybe it needs the more complex
> "use a flag" model.  But even the complex model isn't _hugely_
> complex.
> 
> But we *could* first just do the mmiowb() unconditionally in the ia64
> unlocking code, and then see if anybody notices?

I'll hack this up as a starting point. We can always try to be clever later
on if it's deemed necessary.

Will
