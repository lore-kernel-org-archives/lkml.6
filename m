Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFA7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A25C205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404756AbfAPO5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:57:39 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45267 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbfAPO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:57:39 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gjmdJ-0001gf-I2; Wed, 16 Jan 2019 15:57:33 +0100
Date:   Wed, 16 Jan 2019 15:57:28 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
Subject: Re: preempt_schedule_irq() loop question
In-Reply-To: <20190116134521.GG10803@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1901161550460.1749@nanos.tec.linutronix.de>
References: <cc989920-a13b-d53b-db83-1584a7f53edc@arm.com> <20190116134521.GG10803@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019, Peter Zijlstra wrote:
> On Wed, Jan 16, 2019 at 12:50:42PM +0000, Valentin Schneider wrote:
> > Hi,
> > 
> > I've been wandering around preempt_schedule_irq() in sched/core.c, and
> > got curious regarding how the arch code calls it.
> > 
> > The main part of preempt_schedule_irq() is:
> > 
> >     do {
> > 	    preempt_disable();
> > 	    local_irq_enable();
> > 	    __schedule(true);
> > 	    local_irq_disable();
> > 	    sched_preempt_enable_no_resched();
> >     } while (need_resched());
> > 
> > Yet all the arch entry.S I looked at (I stopped after arm64, arm, x86_32,
> > MIPS, powerpc) wrap the call to preempt_schedule_irq() in another
> > 
> >     do { ... } while (need_resched())
> > 
> > For instance, this is what's done in arm64:
> > 
> >     1:	bl	preempt_schedule_irq		// irq en/disable is done inside
> > 	ldr	x0, [tsk, #TSK_TI_FLAGS]	// get new tasks TI_FLAGS
> > 	tbnz	x0, #TIF_NEED_RESCHED, 1b	// needs rescheduling?
> > 
> > 
> > I naively thought this could be attributed to something like
> > preempt_schedule_irq() historically not having an inner loop, but it seems
> > to have been there since the beginning of time (or at least up to the point
> > where the git history stops).
> > 
> > I don't see why we need to have these nested loops - AFAICT the one in
> > preempt_schedule_irq() would suffice. What am I missing?
> 
> I think you're quite right; but I wasn't doing kernel work back when rml
> added the preemptible bits. Ingo, do you have any recollections that far
> back?

I just went back in the history tree and had to figure out that it's my
fault :)

preempt_schedule_irq() was introduced to plug a stupid race, but I did not
notice (and obviously nobody else) that this made the extra loop in the
entry code pointless. So it's just histerical raisins without any value.

Thanks,

	tglx

