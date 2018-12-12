Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CE1C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5897020870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X62LZb15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5897020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeLLR2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:28:03 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41442 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbeLLR2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:28:03 -0500
Received: by mail-io1-f66.google.com with SMTP id s22so15441319ioc.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 09:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llfekz+lWRZKDYONtsa//P3ai+T9gFhFog7TJksSkqc=;
        b=X62LZb153OykjMOZzo+uWSShEw/ipuZMvzOZ45AAHcfL442XbIW70SAx/hgAa4rEjL
         a1G5BYUqNXnkG+3D+3V88nn17QZ1rLDBfTDuiJphWpaMGwcM5LvqseqxVhq+SJxHJ+v3
         twtBT/Rd+tALVHGAu4NjuDfW1vite2n5y26+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llfekz+lWRZKDYONtsa//P3ai+T9gFhFog7TJksSkqc=;
        b=j+6in68Ok14BwyQxTeKK6wC4Fq2PT/ucmifKGQRLYtLV5pZw7ITmnkVqRSJoDXYKdL
         x8pyL4y7XUT0Rro8iSY6dYHwg5d/UEbdI+NtoESAvEm6998eU8Vw3BUWjnaVBJCm9gz/
         pHoW/GvIkQ7nzlc0LnJCxs/sHab8/Ly5g7FnTf6Nkos0q+GUQlZCWRsRRg9YTVIHmgBV
         gdu4l8yhDblETDakjfs9pHFC/Z4un/guqpvKEaacVkBfGMPe2dVejMV/EZ88SaSz3tSH
         vOhwwSYIQFmNDcPOysU1FT2Tdu7N/zQ/sMwnHGCxkt8t8AoD+8lAaJgt7YEgaQOcy5br
         ukkQ==
X-Gm-Message-State: AA+aEWbobIfbtZgIXMeKwXJKWTovpP+ZdVLboPISToKIttkk73VK7DgC
        6X6bXEr95pcEHLGjrdxb9GIj0LVtJENcjusFCNKwXA==
X-Google-Smtp-Source: AFSGD/V1dkF2/N2MqAG6I6aS/FZQpAglacOTs5RVL/SSs985ZyQnK/IzKI70IZIb8WTabeXKC/00C5r0pfZTOwS22eU=
X-Received: by 2002:a5e:c202:: with SMTP id v2mr1939788iop.60.1544635681614;
 Wed, 12 Dec 2018 09:28:01 -0800 (PST)
MIME-Version: 1.0
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com> <1544633245-6036-12-git-send-email-julien.thierry@arm.com>
In-Reply-To: <1544633245-6036-12-git-send-email-julien.thierry@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 12 Dec 2018 18:27:50 +0100
Message-ID: <CAKv+Gu8E9g=J78a-2HAdcijaHyVFL1KA3civwfoVHQ=mp7yJJA@mail.gmail.com>
Subject: Re: [PATCH v7 11/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        joel@joelfernandes.org, Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 at 17:48, Julien Thierry <julien.thierry@arm.com> wrote:
>
> Instead disabling interrupts by setting the PSR.I bit, use a priority
> higher than the one used for interrupts to mask them via PMR.
>
> When using PMR to disable interrupts, the value of PMR will be used
> instead of PSR.[DAIF] for the irqflags.
>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> ---
>  arch/arm64/include/asm/efi.h      |   5 +-
>  arch/arm64/include/asm/irqflags.h | 123 +++++++++++++++++++++++++++++---------
>  2 files changed, 99 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index 7ed3208..a9d3ebc 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -42,7 +42,10 @@
>
>  efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
>
> -#define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
> +#define ARCH_EFI_IRQ_FLAGS_MASK                                                \
> +       (system_uses_irq_prio_masking() ?                               \
> +               GIC_PRIO_IRQON :                                        \
> +               (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT))
>

This mask is used to determine whether we return from a firmware call
with a different value for the I flag than we entered it with. So
instead of changing the mask, we should change the way we record DAIF,
given that the firmware is still going to poke the I bit if it
misbehaves, regardless of whether the OS happens to use priorities for
interrupt masking.

It also means that the NMI concept is a best effort thing only, given
that uncooperative firmware could prevent them from being delivered.



>  /* arch specific definitions used by the stub code */
>
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 24692ed..fa3b06f 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -18,7 +18,9 @@
>
>  #ifdef __KERNEL__
>
> +#include <asm/alternative.h>
>  #include <asm/ptrace.h>
> +#include <asm/sysreg.h>
>
>  /*
>   * Aarch64 has flags for masking: Debug, Asynchronous (serror), Interrupts and
> @@ -36,47 +38,96 @@
>  /*
>   * CPU interrupt mask handling.
>   */
> -static inline unsigned long arch_local_irq_save(void)
> -{
> -       unsigned long flags;
> -       asm volatile(
> -               "mrs    %0, daif                // arch_local_irq_save\n"
> -               "msr    daifset, #2"
> -               : "=r" (flags)
> -               :
> -               : "memory");
> -       return flags;
> -}
> -
>  static inline void arch_local_irq_enable(void)
>  {
> -       asm volatile(
> -               "msr    daifclr, #2             // arch_local_irq_enable"
> -               :
> +       unsigned long unmasked = GIC_PRIO_IRQON;
> +
> +       asm volatile(ALTERNATIVE(
> +               "msr    daifclr, #2             // arch_local_irq_enable\n"
> +               "nop",
> +               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
> +               "dsb    sy",
> +               ARM64_HAS_IRQ_PRIO_MASKING)
>                 :
> +               : "r" (unmasked)
>                 : "memory");
>  }
>
>  static inline void arch_local_irq_disable(void)
>  {
> -       asm volatile(
> -               "msr    daifset, #2             // arch_local_irq_disable"
> -               :
> +       unsigned long masked = GIC_PRIO_IRQOFF;
> +
> +       asm volatile(ALTERNATIVE(
> +               "msr    daifset, #2             // arch_local_irq_disable",
> +               "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
> +               ARM64_HAS_IRQ_PRIO_MASKING)
>                 :
> +               : "r" (masked)
>                 : "memory");
>  }
>
>  /*
> + * Having two ways to control interrupt status is a bit complicated. Some
> + * locations like exception entries will have PSR.I bit set by the architecture
> + * while PMR is unmasked.
> + * We need the irqflags to represent that interrupts are disabled in such cases.
> + *
> + * For this, we lower the value read from PMR when the I bit is set so it is
> + * considered as an irq masking priority. (With PMR, lower value means masking
> + * more interrupts).
> + */
> +#define _get_irqflags(daif_bits, pmr)                                  \
> +({                                                                     \
> +       unsigned long flags;                                            \
> +                                                                       \
> +       BUILD_BUG_ON(GIC_PRIO_IRQOFF < (GIC_PRIO_IRQON & ~PSR_I_BIT));  \
> +       asm volatile(ALTERNATIVE(                                       \
> +               "mov    %0, %1\n"                                       \
> +               "nop\n"                                                 \
> +               "nop",                                                  \
> +               "and    %0, %1, #" __stringify(PSR_I_BIT) "\n"          \
> +               "mvn    %0, %0\n"                                       \
> +               "and    %0, %0, %2",                                    \
> +               ARM64_HAS_IRQ_PRIO_MASKING)                             \
> +               : "=&r" (flags)                                         \
> +               : "r" (daif_bits), "r" (pmr)                            \
> +               : "memory");                                            \
> +                                                                       \
> +       flags;                                                          \
> +})
> +
> +/*
>   * Save the current interrupt enable state.
>   */
>  static inline unsigned long arch_local_save_flags(void)
>  {
> -       unsigned long flags;
> -       asm volatile(
> -               "mrs    %0, daif                // arch_local_save_flags"
> -               : "=r" (flags)
> +       unsigned long daif_bits;
> +       unsigned long pmr; // Only used if alternative is on
> +
> +       daif_bits = read_sysreg(daif);
> +
> +       // Get PMR
> +       asm volatile(ALTERNATIVE(
> +                       "nop",
> +                       "mrs_s  %0, " __stringify(SYS_ICC_PMR_EL1),
> +                       ARM64_HAS_IRQ_PRIO_MASKING)
> +               : "=&r" (pmr)
>                 :
>                 : "memory");
> +
> +       return _get_irqflags(daif_bits, pmr);
> +}
> +
> +#undef _get_irqflags
> +
> +static inline unsigned long arch_local_irq_save(void)
> +{
> +       unsigned long flags;
> +
> +       flags = arch_local_save_flags();
> +
> +       arch_local_irq_disable();
> +
>         return flags;
>  }
>
> @@ -85,16 +136,32 @@ static inline unsigned long arch_local_save_flags(void)
>   */
>  static inline void arch_local_irq_restore(unsigned long flags)
>  {
> -       asm volatile(
> -               "msr    daif, %0                // arch_local_irq_restore"
> -       :
> -       : "r" (flags)
> -       : "memory");
> +       asm volatile(ALTERNATIVE(
> +                       "msr    daif, %0\n"
> +                       "nop",
> +                       "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0\n"
> +                       "dsb    sy",
> +                       ARM64_HAS_IRQ_PRIO_MASKING)
> +               : "+r" (flags)
> +               :
> +               : "memory");
>  }
>
>  static inline int arch_irqs_disabled_flags(unsigned long flags)
>  {
> -       return flags & PSR_I_BIT;
> +       int res;
> +
> +       asm volatile(ALTERNATIVE(
> +                       "and    %w0, %w1, #" __stringify(PSR_I_BIT) "\n"
> +                       "nop",
> +                       "cmp    %w1, #" __stringify(GIC_PRIO_IRQOFF) "\n"
> +                       "cset   %w0, ls",
> +                       ARM64_HAS_IRQ_PRIO_MASKING)
> +               : "=&r" (res)
> +               : "r" ((int) flags)
> +               : "memory");
> +
> +       return res;
>  }
>  #endif
>  #endif
> --
> 1.9.1
>
