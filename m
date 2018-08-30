Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B35BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDA5205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDA5205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbeH3R5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:57:47 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:56698 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbeH3R5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:57:47 -0400
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1fvNPz-0004Cz-00; Thu, 30 Aug 2018 13:55:27 +0000
Date:   Thu, 30 Aug 2018 09:55:27 -0400
From:   Rich Felker <dalias@libc.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: futex_cmpxchg_enabled breakage
Message-ID: <20180830135527.GT1878@brightrain.aerifal.cx>
References: <20180829222221.GA22017@brightrain.aerifal.cx>
 <alpine.DEB.2.21.1808301109220.1210@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808301109220.1210@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 11:19:58AM +0200, Thomas Gleixner wrote:
> On Wed, 29 Aug 2018, Rich Felker wrote:
> 
> > I just spent a number of hours helping someone track down a bug that
> > looks like it's some kind of futex_cmpxchg_enabled detection error on
> > powerpc64 (still not sure of the root cause; set_robust_list producing
> > -ENOSYS), and a while back I hit the same problem on sh2 due to lack
> > of EFAULT on nommu, leading to commit 72cc564f16ca. I think the test
> > (introduced way back in commit a0c1e9073ef7) is fundamentally buggy;
> > if anything, it should be checking for !=-ENOSYS, not ==-EFAULT.
> 
> Errm? This does a futex_cmpxchg() on NULL which has to return EFAULT if
> it's available. There is nothing fundamentally buggy about it at all.

I'll let you know when if/when we finish figuring out how this
happened on powerpc64, but it's an arch that most certainly has a
working cmpxchg where these syscalls ended up returning -ENOSYS. This
is an error condition that should not be able to happen. At the very
very least all the archs that actually have a working cmpxchg
unconditionally should be updated with:

	select HAVE_FUTEX_CMPXCHG if FUTEX

so that whatever caused this for powerpc64 doesn't happen again.

> > Presumably it could also fail to produce -EFAULT if mmap_min_addr is 0
> > and page 0 is mapped (a bad idea, but maybe someone does it...). And
> > of course other nommu archs are possibly still broken.
> 
> If NULL is mapped in the kernel then a lot of other things are broken. The
> futex thing is then the least of your worries.

For nommu NULL is always "mapped".

> > Ultimately from an API perspective, the functionality that depends on
> > futex_cmpxchg_enabled is non-optional, and the current approach of
> > treating it as something that can be disabled via detection at runtime
> > is fragile and wrong.
> 
> The availibility of the interfaces which depend on futex_cmpxchg_enabled
> has been runtime detectable forever and it's documented that way. I have no
> idea why you think it's non-optional. If you made it unconditional in your
> lib, then it's hardly the kernels problem.

Modern glibc also defines:

#define __ASSUME_SET_ROBUST_LIST        1

It's then #undef'd for some archs (mips, m68k, sparc, arm), but not
all archs that lack HAVE_FUTEX_CMPXCHG, so glibc seems to be assuming
set_robust_list actually works on some where the kernel is treating
failure as a possibility.

> > If there are no archs that support SMP but don't provide their own
> > asm/futex.h (as opposed to the asm-generic one that does -ENOSYS on
> > SMP), the detection code should just be removed, and the SMP case in
> > asm-generic/futex.h should be made into #error.
> 
> And why so? Just because?

To prevent inadvertent introduction of this issue on new archs (if the
porters don't realize asm-generic/futex.h doesn't actually work for
SMP).

> > If there are archs that support SMP but don't provide their own
> > working asm/futex.h, then asm-generic/futex.h's SMP case should be
> > enhanced to perform a stop-the-world IPI and then do the same thing as
> > the non-SMP case (disable preemption[/interrupts?], perform the
> > cmpxchg non-atomically).
> > 
> > Thoughts? Would a patch to do this be acceptable?
> 
> No. There is nothing at all in the world which requires that PI futexes and
> robust list are provided and even if you implement that hack in the kernel
> then the user space side still does not work because the user space part of
> those interfaces has a hard dependency on working cmpxchg as well.

Of course there's a working cmpxchg; this is a hard requirement for
userspace. You cannot implement pthread primitives without one. On
archs/ISA-levels that lack an insn it's already provided as a syscall,
a vdso/khelper, or trap-and-emulate. The problem I'm complaining about
here is that, despite already needing and having working ways to
achieve this, the kernel is not using them, and breaking functionality
that should work.

Rich
