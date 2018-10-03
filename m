Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B411C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD992089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD992089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeJCOya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:54:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33274 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbeJCOy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:54:29 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7cBW-0000Go-3W; Wed, 03 Oct 2018 10:07:06 +0200
Date:   Wed, 3 Oct 2018 10:07:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
cc:     Peter Zijlstra <peterz@infradead.org>, bigeasy@linutronix.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        daniel.wagner@siemens.com, Will Deacon <will.deacon@arm.com>,
        x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, boqun.feng@gmail.com,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: [Problem] Cache line starvation
In-Reply-To: <CAHkRjk4Vvv5rc+habecu2xPiFGZ37onRzy1kCnFcBH2115U8jQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1810031005210.1435@nanos.tec.linutronix.de>
References: <20180921120226.6xjgr4oiho22ex75@linutronix.de> <20180921122058.GB24124@hirez.programming.kicks-ass.net> <CAHkRjk4Vvv5rc+habecu2xPiFGZ37onRzy1kCnFcBH2115U8jQ@mail.gmail.com>
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

On Wed, 3 Oct 2018, Catalin Marinas wrote:

> On Fri, 21 Sep 2018 at 13:22, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Fri, Sep 21, 2018 at 02:02:26PM +0200, Sebastian Andrzej Siewior wrote:
> > > We reproducibly observe cache line starvation on a Core2Duo E6850 (2
> > > cores), a i5-6400 SKL (4 cores) and on a NXP LS2044A ARM Cortex-A72 (4
> > > cores).
> > >
> > > The problem can be triggered with a v4.9-RT kernel by starting
> >
> > > Daniel reported that disabling ticket locks on 4.4 makes the problem go
> > > away, but he hasn't run a long time test yet and as we saw with 4.14 it can
> > > take quite a while.
> >
> > On 4.4 and 4.9 ARM64 still uses ticket locks. So I'm very interested to
> > know if the ticket locks on x86 really fix or just make it harder.
> >
> > I've been looking at qspinlock in the light of this and there is indeed
> > room for improvement. The ticket lock certainly is much simpler.
> 
> FWIW, in the qspinlock TLA+ model [1], if I replace the
> atomic_fetch_or() model with a try_cmpxchg loop, it violates the
> liveness properties with only 2 CPUs as one keeps locking/unlocking,
> hence changing the lock value, while the other repeatedly fails the
> cmpxchg. Your latest qspinlock patches seem to address this (couldn't
> get it to fail but the model is only sequentially consistent). Not
> sure that's what Sebastian is seeing but without your proposed
> qspinlock changes, ticket spinlocks may be a better bet for RT.

Except that the ARM64 ticket locks are not preventing the starvation
issue. Neither do the qrlocks on ARM64 on later kernels.

Thanks,

	tglx
