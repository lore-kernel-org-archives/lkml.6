Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E41C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4DE208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4DE208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeK1XFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:05:32 -0500
Received: from foss.arm.com ([217.140.101.70]:37170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbeK1XFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:05:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47CC23650;
        Wed, 28 Nov 2018 04:04:06 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0E4813F59C;
        Wed, 28 Nov 2018 04:04:06 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 2AC3D1AE0808; Wed, 28 Nov 2018 12:04:24 +0000 (GMT)
Date:   Wed, 28 Nov 2018 12:04:24 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com, rml@tech9.net,
        tglx@linutronix.de, schwidefsky@de.ibm.com
Subject: Re: [PATCH 0/2] arm64: Only call into preempt_schedule() if
 need_resched()
Message-ID: <20181128120423.GA24868@arm.com>
References: <1543347902-21170-1-git-send-email-will.deacon@arm.com>
 <20181128085640.GX2131@hirez.programming.kicks-ass.net>
 <20181128090146.GF2149@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128090146.GF2149@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 10:01:46AM +0100, Peter Zijlstra wrote:
> On Wed, Nov 28, 2018 at 09:56:40AM +0100, Peter Zijlstra wrote:
> > On Tue, Nov 27, 2018 at 07:45:00PM +0000, Will Deacon wrote:
> > > This pair of patches improves our preempt_enable() implementation slightly
> > > on arm64 by making the resulting call to preempt_schedule() conditional
> > > on need_resched(), which is tracked in bit 32 of the preempt count. The
> > > logic is inverted so that we can detect the preempt count going to zero
> > > and need_resched being set with a single CBZ instruction.
> > 
> > >   40:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
> > >   44:   910003fd        mov     x29, sp
> > >   48:   d5384101        mrs     x1, sp_el0
> > >   4c:   f9400820        ldr     x0, [x1, #16]
> > 
> > We load x0 which is a u64, right?
> > 
> > >   50:   d1000400        sub     x0, x0, #0x1
> > >   54:   b9001020        str     w0, [x1, #16]
> > 
> > But we store w0, which is the low u32, such as to not touch the high
> > word which contains the preempt bit.
> > 
> > >   58:   b4000060        cbz     x0, 64 <will+0x24>
> > >   5c:   a8c17bfd        ldp     x29, x30, [sp], #16
> > >   60:   d65f03c0        ret
> > >   64:   94000000        bl      0 <preempt_schedule>
> > >   68:   a8c17bfd        ldp     x29, x30, [sp], #16
> > >   6c:   d65f03c0        ret
> > 
> > Why not?
> > 
> >    58:   b4000060        cbnz    x0, 60 <will+0x24>
> >    5c:   94000000        bl      0 <preempt_schedule>
> >    60:   a8c17bfd        ldp     x29, x30, [sp], #16
> >    64:   d65f03c0        ret
> > 
> > which seems shorter.
> > 
> > 
> > So it's still early, and I haven't finished (or really even started) my
> > pot 'o tea, but what about:
> > 
> > 
> > 	ldr x0, [x1, #16]	// seees the high bit set -- no preempt needed
> > 	sub x0, x0, #1
> > 
> > 	<interrupt>
> > 	  ...
> > 	  resched_curr()
> > 	    set_tsk_need_resched();
> > 	    set_preempt_need_resched();
> > 	</interrupt> // sees preempt_count != 0, does not preempt
> > 
> > 	str w0, [x1, #16] // stores preempt_count == 0
> > 	cbnz x0, 1f // taken, we still observe the high word from before
> > 
> > 1:	ret
> > 
> > 
> > Which then ends with preempt_count==0, need_resched==0 and no actual
> > preemption afaict.
> > 
> > Can you use mis-matched ll x0 / sc w0 to do this same thing and detector
> > the intermediate write on the high word?
> 
> That is, something along these here lines:
> 
> 1:	ldxr x0, [x1, #16]
> 	sub  x0, x0, #1
> 	stxr w1, w0, [x1, #16]

^^ This guy needs a different encoding but, to be honest, I reckon we're
better off just reloading the need_resched flag in the case where the count
has hit zero. I'll have a play. The assembly I posted is all generated by
GCC, so I can't comment on why it didn't chose your shorter sequence :)

Will
