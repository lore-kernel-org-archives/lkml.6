Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_MIXED_ES,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0FCC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4429E2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4429E2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeLLQIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:08:06 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:58842 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLLQIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:08:06 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1gX70x-0002QR-00; Wed, 12 Dec 2018 16:05:35 +0000
Date:   Wed, 12 Dec 2018 11:05:35 -0500
From:   Rich Felker <dalias@libc.org>
To:     Steven Newbury <steve@snewbury.org.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        macro@linux-mips.org, tg@mirbsd.de, luto@kernel.org, arnd@arndb.de,
        s@ecloud.org, catalin.marinas@arm.com, fweimer@redhat.com,
        glaubitz@physik.fu-berlin.de, christian.brauner@canonical.com,
        hjl.tools@gmail.com, hpa@zytor.com
Subject: Re: Can we drop upstream Linux x32 support?
Message-ID: <20181212160535.GS23599@brightrain.aerifal.cx>
References: <1544605954.117529.27.camel@snewbury.org.uk>
 <20181212140147.GR23599@brightrain.aerifal.cx>
 <1544625960.117529.58.camel@snewbury.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544625960.117529.58.camel@snewbury.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 02:46:00PM +0000, Steven Newbury wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> On Wed, 2018-12-12 at 09:01 -0500, Rich Felker wrote:
> > On Wed, Dec 12, 2018 at 09:12:34AM +0000, Steven Newbury wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA256
> > > 
> > > First off I'd like to request: Please don't break my userspace!
> > > 
> > > I have a number of systems running with x32-abi as native.  They
> > > work
> > > well, I've no want or desire to upgrade their memory or CPUs to
> > > make
> > > keep them working as well as they do now.  Let alone the hassle of
> > > having to redeploy with a completely different ABI.
> > > 
> > > 
> > > I've been working on getting as much userspace as I can working
> > > with
> > > x32 since it first became somewhat usable, I've sent patches
> > > upstream
> > > and pushed to encourage projects to write portable code.  Sometimes
> > > that has meant just little tweaks to build systems, or sometimes
> > > disabling asm where I consider it isn't worth the effort of making
> > > it
> > > work.  For other projects I've converted the asm or even in some
> > > cases
> > > got the JIT working, mozjs17 for example.
> > > 
> > > So I'm both a user and a developer.
> > > 
> > > Breaking support for x32 would be really bad for me, but if I'm the
> > > only one using it I suppose I can't really justify it being kept on
> > > that basis.  I know CERN has sucessfully experimented with it over
> > > the
> > > years though, so I wouldn't be surprised if there are other users
> > > hiding out there.
> > > 
> > > I can't help but wonder if it wouldn't make more sense to drop x86
> > > support from long mode than x32.  AMD64 x86 support was always
> > > intended
> > >  as a compatibility feature, I very much doubt there are more
> > > people
> > > out there using an x86 native userspace on a 64 bit kernel than
> > > there
> > 
> > I am. The only reason I'm using a 64-bit kernel with it is to get the
> > full 4GB address space for userspace rather than just 3GB. I suspect
> > there are more users like me than like you.
> > 
> You may well be right, I lack any data either way.  I just find it hard
> to believe I'm, what, one of two users of x32?
> 
> > Unlike x32, i386 is actually widely supported and works, and achieves
> > most of the benefits of x32, but with marginally worse performance
> > due
> x32 works, and is widely supported by the fact that the vast majority
> of free software is just a compile away.  Now, there are holes, I've
> been trying to get Chromium/qtwebengine ported for the last couple of
> weeks.
> 
> The performance isn't marginally worse, it's much worse, unless the
> code in question is hand optimized SIMD or is otherwise not really
> standard "IA32 ISA" anyway.

When the baseline improvement is roughly 2x (because you can double N
in make -jN), I consider 10-20% "marginal". Obviously there's a
perspective where 10-20% is huge. Have you actually observed x32 gcc
(since gcc is the example I'm using here, where it makes a big
difference) running that much faster than i386 gcc, though?

What I meant by "widely supported" is that pretty much any kernel
that's shipped can run i386 binaries. On the other hand, at least as I
understand it,lots of distros have x32 disabled because it's "not
used" or because there were a couple historic vulns exposed by having
it enabled and they just decided it wasn't worth it.

> > performance sensitive it's the right choice for shipping static
> > binaries, especially if they may be memory-hungry, since it works on
> > pretty much any box.
> > 
> When it comes to power usage and latency any code that runs often is
> peformance senstitive.  I can't argue about shipping i386 static
> binaries, they'll work on pretty much any *x86* box, I agree.

OK, so we're on the same page there.

> > > are native x32 users.  x86 support could be implemented via KVM
> > > and/or
> > > qemu-user.  There is no reason to keep the extra complexity in the
> > > kernel for what is effectively an emulation layer anyway.
> > 
> > qemu-user is a non-solution. Not only does it result in being much
> > slower and using more resources than just running a 64-bit userspace
> > (defeating the purpose); it's also incapable of correctly emulating
> > lots of corner cases. I've never been able to get it to work with
> > thread cancellation, and doing so is fundamentally hard because it
> > would require heavy emulation of signals rather than passing them
> > through.
> > 
> What's the purpose?  Running IA32 binaries is for legacy.  You don't
> run i386/IA32 binaries for the performance.  You use i386 as x32 was
> intended, that's succifient for you.  Great.  I get the benefits I want
> from an x32 userspace with amd64 binaries and libraries where it makes
> sense as I understand does Thorsten.  Are you saying this wrong,
> broken(?), and should be removed?

No, I'm not really taking a position here except that i386 (IA32)
should not be removed. I agree that x32 is useful (which a lot of
people are wrongly dismissing), but I also agree that the kernel code
for it is a mess and a maintenance burden, and I'm not sure if the
usefulness justifies that burden. I think it's really helpful to hear
from people like you who are using it why you care that it's there.

Rich
