Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9DBC2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A5C20870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcvAN8R9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbfAUPp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:45:29 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54351 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbfAUPp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:45:28 -0500
Received: by mail-it1-f195.google.com with SMTP id i145so16946176ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PNev0wZfyiJbw9twBFu1eNBJ+MQBNRFBHLHo5P3/wg0=;
        b=AcvAN8R9pXmhmF2NHjENm5C1IUSukp4VLxp7wXQr5rYwfg2g6yxuuBftzbEYmlcE34
         IPLd74rKiWQL9gC6b1OC3qv4/fBazIxnJqCagMJRKtKbUuqZ5MTMf+gV0EG1CYOkSD2c
         I7cycJqjAxJrcgGhEFCPq7tc37PhaxLwar2WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNev0wZfyiJbw9twBFu1eNBJ+MQBNRFBHLHo5P3/wg0=;
        b=FKYQa6euKWDbkneYWxBXx9r9j2nEw0qFXzUTnVZqKcm7nNLGG7ONRVY5kxzPLTOgr9
         sCKlXhbeAFn6/75s27X/GzNt+PsbxDx+vGr8Vc3hXelTjOtcehNg1+G/qjbnNdChKIs2
         XODS85Xq6hekX5F7ZHQqBz40Fryq7aOiXucOzxUW/0yMNqI6Y2HkGsvY73dDyEQFDCXG
         /Y4j6+EHi0HMwYxUGOo3xzaddep+TnuDOK6Fc2CPMHP2nOq4hDN03pLSF8JHfSg1SJzZ
         GEm3M+yrNvVn+rgwqfw+MxymAf6rAcqOc2HDn5POTejWoQAURmCXeevJoLEihk34IGYZ
         T7XQ==
X-Gm-Message-State: AJcUukc3foTlHLe4K6S3Rj+SaFyOFzbCJg2LmCgbMvD/aTsz1kcyiCIt
        RsW9uERbNoKE+JdeJDNB9OOUn5K0SjK0fHBOgCEhpQ==
X-Google-Smtp-Source: ALg8bN5V7q/JMjKZCK+nCc1rPamgJ+wMgtJeybNndDN35rV75DiidvVxBFSWloy3iTsbMnfWMVxTwsQz1xYmC78zrB8=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr17686402itk.71.1548085527208;
 Mon, 21 Jan 2019 07:45:27 -0800 (PST)
MIME-Version: 1.0
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com> <1548084825-8803-13-git-send-email-julien.thierry@arm.com>
In-Reply-To: <1548084825-8803-13-git-send-email-julien.thierry@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Jan 2019 16:45:15 +0100
Message-ID: <CAKv+Gu-m2KcbDNsM1AJZHOKrJkE5Ki=xX8qqUvFnDc=87-4OsA@mail.gmail.com>
Subject: Re: [PATCH v9 12/26] arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 at 16:34, Julien Thierry <julien.thierry@arm.com> wrote:
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
>  arch/arm64/include/asm/efi.h      |   6 +++
>  arch/arm64/include/asm/irqflags.h | 104 ++++++++++++++++++++++++++++----------
>  2 files changed, 82 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index 7ed3208..3db6772 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -44,6 +44,12 @@
>
>  #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
>
> +#define arch_efi_save_flags(state_flags)               \
> +       ((void)((state_flags) = read_sysreg(daif)))
> +
> +#define arch_efi_restore_flags(state_flags)    write_sysreg(state_flags, daif)
> +
> +
>  /* arch specific definitions used by the stub code */
>
>  /*

For the EFI changes

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

although it deserves a comment as to why it is unaffected by
ARM64_HAS_IRQ_PRIO_MASKING


> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index 24692ed..7e82a92 100644
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
> @@ -36,33 +38,31 @@
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
> @@ -71,12 +71,44 @@ static inline void arch_local_irq_disable(void)
>   */
>  static inline unsigned long arch_local_save_flags(void)
>  {
> +       unsigned long daif_bits;
>         unsigned long flags;
> -       asm volatile(
> -               "mrs    %0, daif                // arch_local_save_flags"
> -               : "=r" (flags)
> -               :
> +
> +       daif_bits = read_sysreg(daif);
> +
> +       /*
> +        * The asm is logically equivalent to:
> +        *
> +        * if (system_uses_irq_prio_masking())
> +        *      flags = (daif_bits & PSR_I_BIT) ?
> +        *                      GIC_PRIO_IRQOFF :
> +        *                      read_sysreg_s(SYS_ICC_PMR_EL1);
> +        * else
> +        *      flags = daif_bits;
> +        */
> +       asm volatile(ALTERNATIVE(
> +                       "mov    %0, %1\n"
> +                       "nop\n"
> +                       "nop",
> +                       "mrs_s  %0, " __stringify(SYS_ICC_PMR_EL1) "\n"
> +                       "ands   %1, %1, " __stringify(PSR_I_BIT) "\n"
> +                       "csel   %0, %0, %2, eq",
> +                       ARM64_HAS_IRQ_PRIO_MASKING)
> +               : "=&r" (flags), "+r" (daif_bits)
> +               : "r" (GIC_PRIO_IRQOFF)
>                 : "memory");
> +
> +       return flags;
> +}
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
> @@ -85,16 +117,32 @@ static inline unsigned long arch_local_save_flags(void)
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
