Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037CAC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BAA20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BAA20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeLLR7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:59:52 -0500
Received: from foss.arm.com ([217.140.101.70]:46616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbeLLR7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:59:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50B7C80D;
        Wed, 12 Dec 2018 09:59:51 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D7563F575;
        Wed, 12 Dec 2018 09:59:49 -0800 (PST)
Subject: Re: [PATCH v7 11/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        joel@joelfernandes.org, Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, oleg@redhat.com
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
 <1544633245-6036-12-git-send-email-julien.thierry@arm.com>
 <CAKv+Gu8E9g=J78a-2HAdcijaHyVFL1KA3civwfoVHQ=mp7yJJA@mail.gmail.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <19500d6b-62a3-21cb-9ac0-a4e5d4714a63@arm.com>
Date:   Wed, 12 Dec 2018 17:59:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8E9g=J78a-2HAdcijaHyVFL1KA3civwfoVHQ=mp7yJJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2018 17:27, Ard Biesheuvel wrote:
> On Wed, 12 Dec 2018 at 17:48, Julien Thierry <julien.thierry@arm.com> wrote:
>>
>> Instead disabling interrupts by setting the PSR.I bit, use a priority
>> higher than the one used for interrupts to mask them via PMR.
>>
>> When using PMR to disable interrupts, the value of PMR will be used
>> instead of PSR.[DAIF] for the irqflags.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: Oleg Nesterov <oleg@redhat.com>
>> ---
>>  arch/arm64/include/asm/efi.h      |   5 +-
>>  arch/arm64/include/asm/irqflags.h | 123 +++++++++++++++++++++++++++++---------
>>  2 files changed, 99 insertions(+), 29 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
>> index 7ed3208..a9d3ebc 100644
>> --- a/arch/arm64/include/asm/efi.h
>> +++ b/arch/arm64/include/asm/efi.h
>> @@ -42,7 +42,10 @@
>>
>>  efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
>>
>> -#define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
>> +#define ARCH_EFI_IRQ_FLAGS_MASK                                                \
>> +       (system_uses_irq_prio_masking() ?                               \
>> +               GIC_PRIO_IRQON :                                        \
>> +               (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT))
>>
> 
> This mask is used to determine whether we return from a firmware call
> with a different value for the I flag than we entered it with. So
> instead of changing the mask, we should change the way we record DAIF,
> given that the firmware is still going to poke the I bit if it
> misbehaves, regardless of whether the OS happens to use priorities for
> interrupt masking.
> 

Thanks for pointing that out, so this change makes little sense...

The annoying part is that the flag checking takes place in the arch
agnostic code.

Would introducing some overriddable efi_get_flags() or efi_save_flags()
that default to local_save_flags() seem like an acceptable solution?

This way I could override it for arm64 and still return the DAIF bits.

> It also means that the NMI concept is a best effort thing only, given
> that uncooperative firmware could prevent them from being delivered.
> 

Yes, but we would get an error on the EFI side if it starts setting the
I bit. The NMI would be mostly a debug tool at that point anyway, so I
guess if external forces are against us, it is not really worth fighting
for it.

Thanks,

> 
> 
>>  /* arch specific definitions used by the stub code */
>>
>> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
>> index 24692ed..fa3b06f 100644
>> --- a/arch/arm64/include/asm/irqflags.h
>> +++ b/arch/arm64/include/asm/irqflags.h
>> @@ -18,7 +18,9 @@
>>
>>  #ifdef __KERNEL__
>>
>> +#include <asm/alternative.h>
>>  #include <asm/ptrace.h>
>> +#include <asm/sysreg.h>
>>
>>  /*
>>   * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
>> @@ -36,47 +38,96 @@
>>  /*
>>   * CPU interrupt mask handling.
>>   */
>> -static inline unsigned long arch_local_irq_save(void)
>> -{
>> -       unsigned long flags;
>> -       asm volatile(
>> -               "mrs    %0, daif                // arch_local_irq_save\n"
>> -               "msr    daifset, #2"
>> -               : "=r" (flags)
>> -               :
>> -               : "memory");
>> -       return flags;
>> -}
>> -
>>  static inline void arch_local_irq_enable(void)
>>  {
>> -       asm volatile(
>> -               "msr    daifclr, #2             // arch_local_irq_enable"
>> -               :
>> +       unsigned long unmasked = GIC_PRIO_IRQON;
>> +
>> +       asm volatile(ALTERNATIVE(
>> +               "msr    daifclr, #2             // arch_local_irq_enable\n"
>> +               "nop",
>> +               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
>> +               "dsb    sy",
>> +               ARM64_HAS_IRQ_PRIO_MASKING)
>>                 :
>> +               : "r" (unmasked)
>>                 : "memory");
>>  }
>>
>>  static inline void arch_local_irq_disable(void)
>>  {
>> -       asm volatile(
>> -               "msr    daifset, #2             // arch_local_irq_disable"
>> -               :
>> +       unsigned long masked = GIC_PRIO_IRQOFF;
>> +
>> +       asm volatile(ALTERNATIVE(
>> +               "msr    daifset, #2             // arch_local_irq_disable",
>> +               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
>> +               ARM64_HAS_IRQ_PRIO_MASKING)
>>                 :
>> +               : "r" (masked)
>>                 : "memory");
>>  }
>>
>>  /*
>> + * Having two ways to control interrupt status is a bit complicated. Some
>> + * locations like exception entries will have PSR.I bit set by the architecture
>> + * while PMR is unmasked.
>> + * We need the irqflags to represent that interrupts are disabled in such cases.
>> + *
>> + * For this, we lower the value read from PMR when the I bit is set so it is
>> + * considered as an irq masking priority. (With PMR, lower value means masking
>> + * more interrupts).
>> + */
>> +#define _get_irqflags(daif_bits, pmr)                                  \
>> +({                                                                     \
>> +       unsigned long flags;                                            \
>> +                                                                       \
>> +       BUILD_BUG_ON(GIC_PRIO_IRQOFF < (GIC_PRIO_IRQON & ~PSR_I_BIT));  \
>> +       asm volatile(ALTERNATIVE(                                       \
>> +               "mov    %0, %1\n"                                       \
>> +               "nop\n"                                                 \
>> +               "nop",                                                  \
>> +               "and    %0, %1, #" __stringify(PSR_I_BIT) "\n"          \
>> +               "mvn    %0, %0\n"                                       \
>> +               "and    %0, %0, %2",                                    \
>> +               ARM64_HAS_IRQ_PRIO_MASKING)                             \
>> +               : "=&r" (flags)                                         \
>> +               : "r" (daif_bits), "r" (pmr)                            \
>> +               : "memory");                                            \
>> +                                                                       \
>> +       flags;                                                          \
>> +})
>> +
>> +/*
>>   * Save the current interrupt enable state.
>>   */
>>  static inline unsigned long arch_local_save_flags(void)
>>  {
>> -       unsigned long flags;
>> -       asm volatile(
>> -               "mrs    %0, daif                // arch_local_save_flags"
>> -               : "=r" (flags)
>> +       unsigned long daif_bits;
>> +       unsigned long pmr; // Only used if alternative is on
>> +
>> +       daif_bits = read_sysreg(daif);
>> +
>> +       // Get PMR
>> +       asm volatile(ALTERNATIVE(
>> +                       "nop",
>> +                       "mrs_s  %0, " __stringify(SYS_ICC_PMR_EL1),
>> +                       ARM64_HAS_IRQ_PRIO_MASKING)
>> +               : "=&r" (pmr)
>>                 :
>>                 : "memory");
>> +
>> +       return _get_irqflags(daif_bits, pmr);
>> +}
>> +
>> +#undef _get_irqflags
>> +
>> +static inline unsigned long arch_local_irq_save(void)
>> +{
>> +       unsigned long flags;
>> +
>> +       flags = arch_local_save_flags();
>> +
>> +       arch_local_irq_disable();
>> +
>>         return flags;
>>  }
>>
>> @@ -85,16 +136,32 @@ static inline unsigned long arch_local_save_flags(void)
>>   */
>>  static inline void arch_local_irq_restore(unsigned long flags)
>>  {
>> -       asm volatile(
>> -               "msr    daif, %0                // arch_local_irq_restore"
>> -       :
>> -       : "r" (flags)
>> -       : "memory");
>> +       asm volatile(ALTERNATIVE(
>> +                       "msr    daif, %0\n"
>> +                       "nop",
>> +                       "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0\n"
>> +                       "dsb    sy",
>> +                       ARM64_HAS_IRQ_PRIO_MASKING)
>> +               : "+r" (flags)
>> +               :
>> +               : "memory");
>>  }
>>
>>  static inline int arch_irqs_disabled_flags(unsigned long flags)
>>  {
>> -       return flags & PSR_I_BIT;
>> +       int res;
>> +
>> +       asm volatile(ALTERNATIVE(
>> +                       "and    %w0, %w1, #" __stringify(PSR_I_BIT) "\n"
>> +                       "nop",
>> +                       "cmp    %w1, #" __stringify(GIC_PRIO_IRQOFF) "\n"
>> +                       "cset   %w0, ls",
>> +                       ARM64_HAS_IRQ_PRIO_MASKING)
>> +               : "=&r" (res)
>> +               : "r" ((int) flags)
>> +               : "memory");
>> +
>> +       return res;
>>  }
>>  #endif
>>  #endif
>> --
>> 1.9.1
>>

-- 
Julien Thierry
