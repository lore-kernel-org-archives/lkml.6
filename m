Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C377C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B92420645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B92420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeLES0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:26:21 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32940 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbeLES0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:26:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FD1680D;
        Wed,  5 Dec 2018 10:26:21 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F9643F575;
        Wed,  5 Dec 2018 10:26:19 -0800 (PST)
Date:   Wed, 5 Dec 2018 18:26:16 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     daniel.thompson@linaro.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        marc.zyngier@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, christoffer.dall@arm.com,
        james.morse@arm.com, Oleg Nesterov <oleg@redhat.com>,
        joel@joelfernandes.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 10/24] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Message-ID: <20181205182616.GE27881@arrakis.emea.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-11-git-send-email-julien.thierry@arm.com>
 <20181204173610.GC19210@arrakis.emea.arm.com>
 <bc8d0621-8b6c-c678-49ec-ad1c96bac88a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc8d0621-8b6c-c678-49ec-ad1c96bac88a@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 04:55:54PM +0000, Julien Thierry wrote:
> On 04/12/18 17:36, Catalin Marinas wrote:
> > On Mon, Nov 12, 2018 at 11:57:01AM +0000, Julien Thierry wrote:
> >> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> >> index 24692ed..e0a32e4 100644
> >> --- a/arch/arm64/include/asm/irqflags.h
> >> +++ b/arch/arm64/include/asm/irqflags.h
> >> @@ -18,7 +18,27 @@
> >>  
> >>  #ifdef __KERNEL__
> >>  
> >> +#include <asm/alternative.h>
> >> +#include <asm/cpufeature.h>
> >>  #include <asm/ptrace.h>
> >> +#include <asm/sysreg.h>
> >> +
> >> +
> >> +/*
> >> + * When ICC_PMR_EL1 is used for interrupt masking, only the bit indicating
> >> + * whether the normal interrupts are masked is kept along with the daif
> >> + * flags.
> >> + */
> >> +#define ARCH_FLAG_PMR_EN 0x1
> >> +
> >> +#define MAKE_ARCH_FLAGS(daif, pmr)					\
> >> +	((daif) | (((pmr) >> GIC_PRIO_STATUS_SHIFT) & ARCH_FLAG_PMR_EN))
> >> +
> >> +#define ARCH_FLAGS_GET_PMR(flags)				 \
> >> +	((((flags) & ARCH_FLAG_PMR_EN) << GIC_PRIO_STATUS_SHIFT) \
> >> +		| GIC_PRIO_IRQOFF)
> >> +
> >> +#define ARCH_FLAGS_GET_DAIF(flags) ((flags) & ~ARCH_FLAG_PMR_EN)
> > 
> > I wonder whether we could just use the PSR_I_BIT here to decide whether
> > to set the GIC_PRIO_IRQ{ON,OFF}. We could clear the PSR_I_BIT in
> > _restore_daif() with an alternative.
> 
> So, the issue with it is that some contexts might be using PSR.I to
> disable interrupts (any contexts with async errors or debug exceptions
> disabled, kvm guest entry paths, pseudo-NMIs, ...).
> 
> If any of these contexts calls local_irq_save()/local_irq_restore() or
> local_daif_save()/local_daif_restore(), by only relying on PSR_I_BIT to
> represent the PMR status, we might end up clearing PSR.I when we shouldn't.
> 
> I'm not sure whether there are no callers of these functions in those
> context. But if that is the case, we could simplify things, yes.

There are callers of local_daif_save() (3) and local_daif_mask() (7) but
do they all need to disable the pseudo-NMIs?

At a brief look at x86, it seems that they have something like
stop_nmi() and restart_nmi(). These don't have save/restore semantics,
so we could do something similar on arm64 that only deals with the
PSTATE.I bit directly and keep the software (flags) PSR.I as the PMR
bit. But we'd have to go through the 10 local_daif_* cases above to see
which actually need the stop_nmi() semantics.

-- 
Catalin
