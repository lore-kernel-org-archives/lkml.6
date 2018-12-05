Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB92C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3402084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3402084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeLEQ4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:56:00 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59052 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbeLEQz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:55:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 198B9A78;
        Wed,  5 Dec 2018 08:55:59 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B39F3F5AF;
        Wed,  5 Dec 2018 08:55:56 -0800 (PST)
Subject: Re: [PATCH v6 10/24] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, daniel.thompson@linaro.org,
        marc.zyngier@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        christoffer.dall@arm.com, james.morse@arm.com,
        Oleg Nesterov <oleg@redhat.com>, joel@joelfernandes.org
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-11-git-send-email-julien.thierry@arm.com>
 <20181204173610.GC19210@arrakis.emea.arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <bc8d0621-8b6c-c678-49ec-ad1c96bac88a@arm.com>
Date:   Wed, 5 Dec 2018 16:55:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181204173610.GC19210@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/18 17:36, Catalin Marinas wrote:
> On Mon, Nov 12, 2018 at 11:57:01AM +0000, Julien Thierry wrote:
>> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
>> index 24692ed..e0a32e4 100644
>> --- a/arch/arm64/include/asm/irqflags.h
>> +++ b/arch/arm64/include/asm/irqflags.h
>> @@ -18,7 +18,27 @@
>>  
>>  #ifdef __KERNEL__
>>  
>> +#include <asm/alternative.h>
>> +#include <asm/cpufeature.h>
>>  #include <asm/ptrace.h>
>> +#include <asm/sysreg.h>
>> +
>> +
>> +/*
>> + * When ICC_PMR_EL1 is used for interrupt masking, only the bit indicating
>> + * whether the normal interrupts are masked is kept along with the daif
>> + * flags.
>> + */
>> +#define ARCH_FLAG_PMR_EN 0x1
>> +
>> +#define MAKE_ARCH_FLAGS(daif, pmr)					\
>> +	((daif) | (((pmr) >> GIC_PRIO_STATUS_SHIFT) & ARCH_FLAG_PMR_EN))
>> +
>> +#define ARCH_FLAGS_GET_PMR(flags)				 \
>> +	((((flags) & ARCH_FLAG_PMR_EN) << GIC_PRIO_STATUS_SHIFT) \
>> +		| GIC_PRIO_IRQOFF)
>> +
>> +#define ARCH_FLAGS_GET_DAIF(flags) ((flags) & ~ARCH_FLAG_PMR_EN)
> 
> I wonder whether we could just use the PSR_I_BIT here to decide whether
> to set the GIC_PRIO_IRQ{ON,OFF}. We could clear the PSR_I_BIT in
> _restore_daif() with an alternative.
> 

So, the issue with it is that some contexts might be using PSR.I to
disable interrupts (any contexts with async errors or debug exceptions
disabled, kvm guest entry paths, pseudo-NMIs, ...).

If any of these contexts calls local_irq_save()/local_irq_restore() or
local_daif_save()/local_daif_restore(), by only relying on PSR_I_BIT to
represent the PMR status, we might end up clearing PSR.I when we shouldn't.

I'm not sure whether there are no callers of these functions in those
context. But if that is the case, we could simplify things, yes.

Thanks,


>> +/*
>> + * CPU interrupt mask handling.
>> + */
>>  static inline void arch_local_irq_enable(void)
>>  {
>> -	asm volatile(
>> -		"msr	daifclr, #2		// arch_local_irq_enable"
>> -		:
>> +	unsigned long unmasked = GIC_PRIO_IRQON;
>> +
>> +	asm volatile(ALTERNATIVE(
>> +		"msr	daifclr, #2		// arch_local_irq_enable\n"
>> +		"nop",
>> +		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
>> +		"dsb	sy",
>> +		ARM64_HAS_IRQ_PRIO_MASKING)
> 
> DSB needed here as well? I guess I'd have to read the GIC spec before
> asking again ;).
> 

-- 
Julien Thierry
