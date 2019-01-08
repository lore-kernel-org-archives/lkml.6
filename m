Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B33C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7B720883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfAHSBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:01:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57710 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbfAHSBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:01:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02538A78;
        Tue,  8 Jan 2019 10:01:54 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBDEE3F5AF;
        Tue,  8 Jan 2019 10:01:51 -0800 (PST)
Date:   Tue, 8 Jan 2019 18:01:49 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     mark.rutland@arm.com, daniel.thompson@linaro.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        catalin.marinas@arm.com, Julien Thierry <julien.thierry@arm.com>,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Message-ID: <20190108180149.GC5840@e103592.cambridge.arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-13-git-send-email-julien.thierry@arm.com>
 <20190108153957.GA5840@e103592.cambridge.arm.com>
 <8cae8016-d2c7-3c86-9832-f4278d42ea21@arm.com>
 <20190108164510.GB5840@e103592.cambridge.arm.com>
 <64a0dc42-0398-95ac-2c28-88797f969cef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64a0dc42-0398-95ac-2c28-88797f969cef@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 05:16:43PM +0000, Marc Zyngier wrote:
> On 08/01/2019 16:45, Dave Martin wrote:
> > On Tue, Jan 08, 2019 at 03:51:18PM +0000, Marc Zyngier wrote:
> >> On 08/01/2019 15:40, Dave Martin wrote:
> >>> On Tue, Jan 08, 2019 at 02:07:30PM +0000, Julien Thierry wrote:
> >>>> Instead disabling interrupts by setting the PSR.I bit, use a priority
> >>>> higher than the one used for interrupts to mask them via PMR.
> >>>>
> >>>> When using PMR to disable interrupts, the value of PMR will be used
> >>>> instead of PSR.[DAIF] for the irqflags.
> >>>>
> >>>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> >>>> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> >>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>>> Cc: Will Deacon <will.deacon@arm.com>
> >>>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>>> Cc: Oleg Nesterov <oleg@redhat.com>
> >>>> ---
> >>>>  arch/arm64/include/asm/efi.h      |  11 ++++
> >>>>  arch/arm64/include/asm/irqflags.h | 123 +++++++++++++++++++++++++++++---------
> >>>>  2 files changed, 106 insertions(+), 28 deletions(-)
> >>>
> >>> [...]
> >>>
> >>>> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> >>>> index 24692ed..fa3b06f 100644
> >>>> --- a/arch/arm64/include/asm/irqflags.h
> >>>> +++ b/arch/arm64/include/asm/irqflags.h
> >>>> @@ -18,7 +18,9 @@
> >>>
> >>> [...]
> >>>
> >>>>  static inline void arch_local_irq_enable(void)
> >>>>  {
> >>>> -	asm volatile(
> >>>> -		"msr	daifclr, #2		// arch_local_irq_enable"
> >>>> -		:
> >>>> +	unsigned long unmasked = GIC_PRIO_IRQON;
> >>>> +
> >>>> +	asm volatile(ALTERNATIVE(
> >>>> +		"msr	daifclr, #2		// arch_local_irq_enable\n"
> >>>> +		"nop",
> >>>> +		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
> >>>> +		"dsb	sy",
> >>>
> >>> I'm still not convinced these dsbs are needed.
> >>>
> >>> Without the dsb, we are probably not guaranteed to take a pending
> >>> interrupt _immediately_ on unmasking, but I'm not sure that's a
> >>> problem.
> >>>
> >>> What goes wrong if we omit them?
> >>
> >> Then the GIC doesn't know it can now deliver interrupts of a lower
> >> priority. Only a dsb can guarantee that the GIC's view of PMR will get
> >> updated.
> >>
> >> See 9.1.6 (Observability of the effects of accesses to the GIC
> >> registers), which states:
> >>
> >> <quote>
> >> Architectural execution of a DSB instruction guarantees that
> >> — The last value written to ICC_PMR_EL1 or GICC_PMR is observed by the
> >> associated Redistributor.
> >> </quote>
> >>
> >> So yes, DSB is required.
> > 
> > But it says neither what is means for the PMR write to be "observed by
> > the redistributor", nor whether the DSB is required for the
> > redistributor to observe the write at all.
> 
> Well, it seems pretty clear to me that if the redistributor doesn't
> observe the PMR value, it is unlikely to change its interpretation of
> it· And conversely, the redistributor is allowed to sit pretty and not
> give you any interrupt until you are actually telling it that something
> has changed.
> 
> I really think that for once, the spec is pretty unambiguous about what
> is required.

I think that there is some scope for clarification, but it sounds like
that doesn't impact this series.

> > (So, is an implementation
> > allowed to cached in the CPU interface indefinitely until forcibly
> > flushed to the redistributor by a DSB, and in any case can the write's
> > reaching the distributor in finite time or not have any effect that we
> > care about in this case?).
> 
> Nothing in the spec says that the system register write will magically
> trickle down to the redistributor in the absence of a DSB.
> 
> > My reason for querying this is that temporary local masking of classes
> > of interrupts seems an obvious use case for the PMR, and the DSB
> > requirement flies rather in the face of this.
> 
> Are you implying that the GIC architecture should have any form of
> sanity and be useful for general purpose software? Think again! ;-)
> 
> The PMR behavior you are describing only works in a single direction
> (from low to high priority), because the CPU interface has to perform
> some filtering. In the opposite direction, you need the big hammer.
> 
> > Have we seen hardware where interrupts may stall forever upstream of the
> > CPU interface after a PMR write, until a dsb is executed by the CPU?
> 
> Yes. You even have to have a DSB right after a read of IAR to avoid
> loosing interrupts. The short story is that there is hardly any
> synchronization between redistributor and CPU interface. Implementations
> are allowed a more closely coupled design, but that's not what the
> architecture mandates.

Well I guess that pretty much wraps it up!

If implementations require it, then we obviously need to have it.

> > Also, is it ever important in Linux that a pending interrupt be taken
> > immediately upon unmasking (and how do we know that said interrupt is
> > pending)?  If not, we don't care precisely when such interrupts are
> > pended to the PE, just that such an interrupt cannot be taken before
> > the PMR write that unmasks it.  It would be insane for the self-
> > synchronization of PMR writes to lack this guarantee (and a DSB after
> > the PMR write would do no good anyway in that case).
> 
> RT folks are usually quite picky on when they see their interrupts
> firing. I can also imagine the following scenario:
> 
> 	set_pmr(allow all interrupts)
> 	WFI
> 
> where things stop rather abruptly if this is the only CPU in the system.

This is a rather special case (and this case is indeed handled specially
by this series).  Here we don't need to expedite interrupt delivery,
but we want to make sure that the logic that will wake us back up knows
what it's supposed to be doing before we start powering things off.

However, I can see that for RT purposes explicit synchronisation on
interrupt unmasking may provided a more bounded interrupt blackout that
simply waiting for synchronisation to happen in the background (though
that might have better throughput).  Anyway, this is academic since
we have to have the synchyronisation anyway.

I will consider myself corrected and stop trolling...

Cheers
---Dave
