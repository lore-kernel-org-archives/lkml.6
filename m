Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA570C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1A120877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1A120877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbeJEEQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:16:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37006 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbeJEEQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:16:28 -0400
Received: from tmo-108-109.customers.d1-online.com ([80.187.108.109] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g8B3W-0008FU-D5; Thu, 04 Oct 2018 23:21:10 +0200
Date:   Thu, 4 Oct 2018 23:21:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     Daniel Wagner <daniel.wagner@siemens.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RT 1/2] x86/kconfig: Use ticket spinlocks for -rt
In-Reply-To: <20181004140846.uerpx7txvx7pj6yc@linutronix.de>
Message-ID: <alpine.DEB.2.21.1810042303040.29948@nanos.tec.linutronix.de>
References: <20181004134622.23181-1-daniel.wagner@siemens.com> <20181004134622.23181-2-daniel.wagner@siemens.com> <20181004140846.uerpx7txvx7pj6yc@linutronix.de>
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

On Thu, 4 Oct 2018, Sebastian Andrzej Siewior wrote:

> On 2018-10-04 15:46:21 [+0200], Daniel Wagner wrote:
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 6df130a37d41..21f9418d850f 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -42,7 +42,7 @@ config X86
> >  	select ARCH_USE_BUILTIN_BSWAP
> >  	select ARCH_USE_CMPXCHG_LOCKREF		if X86_64
> >  	select ARCH_USE_QUEUED_RWLOCKS
> > -	select ARCH_USE_QUEUED_SPINLOCKS
> > +	select ARCH_USE_QUEUED_SPINLOCKS	if !PREEMPT_RT_FULL
> >  	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> >  	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
> >  	select ARCH_WANT_FRAME_POINTERS
> 
> I would argue, that RT exposes a problem and we should not limit it to
> RT only. Anyone?

It has absolutely nothing to do with RT, really. RT is merily exposing the
problem in an observable way. The same issue happens with upstream, it's
harder to trigger and it's harder to observe for obvious reasons.

If you read through the discussions then you really see that there is an
upstream issue with the x86 qrlock implementation and Peter has posted fixes
which resolve it, both at the practical and the theoretical level.

So making this depend on RT is just shooting the messenger and sending the
totally wrong signal.

The original x86 ticket lock implementation does not have this issue by
design, so switching back to ticket locks on 4.4 is the right thing to do
because backporting a gazillion of updates and fixes for qrlocks to 4.4 is
worse.

While I agree that we want to fix that for 4.4-RT ASAP because it can be
triggered, the real solution is to fix that in 4.4 stable as well. In fact
all stable trees need too be fixed because the issue can be triggered on
all versions.

   4.4:  Trivial by switching back to ticket locks.

   4.9:  Decide whether bringing back ticket locks or backporting all qrlock
   	 fixes. Sebastian has done the latter already and it's probably the
   	 right solution

   4.14:
   4.18: Backporting the qrlock fixes

   4.19: Either the fix ends up in 4.19 final or it needs to be backported

Aside of that there is no solution for ARM64 yet. aside of the horrible
hack of adding the delay loop into cpu_relax(). Still working on that, but
won't be able to do more investigation before monday.

Thanks,

	tglx




