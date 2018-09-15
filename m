Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D9BECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 18:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235A021477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 18:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235A021477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeIOX7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 19:59:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52047 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbeIOX7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 19:59:11 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1FTM-0003uR-WD; Sat, 15 Sep 2018 20:39:13 +0200
Date:   Sat, 15 Sep 2018 20:39:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rich Felker <dalias@libc.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: futex_cmpxchg_enabled breakage
In-Reply-To: <20180915161554.GS1878@brightrain.aerifal.cx>
Message-ID: <alpine.DEB.2.21.1809152021510.1650@nanos.tec.linutronix.de>
References: <20180829222221.GA22017@brightrain.aerifal.cx> <alpine.DEB.2.21.1808301109220.1210@nanos.tec.linutronix.de> <20180830135527.GT1878@brightrain.aerifal.cx> <alpine.DEB.2.21.1809151726290.1650@nanos.tec.linutronix.de>
 <20180915161554.GS1878@brightrain.aerifal.cx>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Sep 2018, Rich Felker wrote:
> On Sat, Sep 15, 2018 at 05:34:24PM +0200, Thomas Gleixner wrote:
> > By doing that you paper over a non functional fixup which could cause other
> > really hard to decode runtime failures. If that fails there is a bug
> > somewhere else and that runtime check is not to blame at all for it.
> 
> The bug, if it's a bug (lack of memory protection on a system that
> explicitly does not have memory protection is not a bug), is unrelated
> to futexes, so having futex functionality break is not a very
> intuitive way of leading people to find the bug. If kernel developers
> really want to consider 0-address-is-mapped a bug (conditional on
> CONFIG_MMU) there should be some test separate from futex that does
> BUG_ON(attempt to access *0 != EFAULT).

Fair enough.

> > Cool, so you can have a NULL pointer dereference without noticing it.
> 
> Yes, you can also clobber arbitrary kernel memory from userspace. Fun, eh?

I was assuming that the mmu-less CPUs Linux runs on at least have a MPU
nowadays.

> > That's hardly a kernel issue, right?
> 
> It's an issue of mismatched assumptions about the contract of these
> interfaces.

ENOSYS is a general contract.

> > I kinda agree for the nommu case, but for power64 you are barking up the
> > wrong tree. If that check fails something very fundamentaly is broken and
> > that breakage is _NOT_ in the futex code. This has to work independent of
> > the futex code, really.
> 
> I agree, but it would have been nice for that to be caught by BUG_ON,
> not subtle failures in robust mutex functionality that would go
> completely unnoticed in production until something broke horribly if
> not for the affected user having been running conformance tests.
> 
> For musl I will probably add code to pthread_mutexattr_setrobust that
> probes whether SYS_get_robust_list fails, and errors out on attempts
> to produce an attribute object with the robust flag set if the kernel
> cannot support it, since there is no way to safely make forward
> progress if the SYS_set_robust_list call fails later. But I was not
> aware of the possibility of failure here, and apparently the glibc
> folks were not either.

They surely were when robust list and PI futex were introduced. That check
got removed somewhere on the way for whatever reason.

> In any case, morally it "should not" be able to fail -- some sort of
> working cmpxchg is needed all over the place, at least in userspace
> and likely also in kernelspace, and if the cpu lacks a direct way of
> implementing it, whatever form of emulation is used elsewhere should
> be used here.

There is some history behind this test. In the early days when robust
futexes and PI futexes were introduced we still had 386 around which did
not have cmpxchg and there was no real requirement to emulate it. Other
archictures like MIPS followed that and aside of the NOMMU/NOMPU case it
simply should just work.

We surely can revisit this on technical grounds, but I really fail to see
any moral issues with a syscall returning -ENOSYS. Futexes can be compiled
out completely and futex_pi is conditional as well.

Thanks,

	tglx



