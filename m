Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746E9C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A4B20866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TMGS+hSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfAVUS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:18:58 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53115 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfAVUS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:18:58 -0500
Received: by mail-it1-f194.google.com with SMTP id g76so23716614itg.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 12:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJT1F0qIq8Tsw54r6HJtqhgv9rAheiXApZ/xRhlov+g=;
        b=TMGS+hSszdm5dq5n7TUbrF3ZUFew9a3yYBPtEZ+R29vkEOqdAEpSoDXdXJZyysl4vA
         xwgtzm7TmWHimBbbNPZboUppWT3r+Wt4EZLAh0hTyS1kRfInpsC2S0QCgWdoChKQV6sS
         jtVeafZ5wfqo/gsZxX0qpOpTyf4dShH8BvN/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJT1F0qIq8Tsw54r6HJtqhgv9rAheiXApZ/xRhlov+g=;
        b=iTQPn2ey+FeJysWk3vsBLPcB/kD4M/DxqW4R2lonuSSNrwBNZeHNJQlX2tXrrxmmQQ
         bxIoMh/mUp53mzecK1xxUA6+y97t8aqj13S+F1sRHGmJ7XkdR7V+abvb6ZQRTmbFcc3H
         jinacVNjFMQ6Gpf4qU48D5FdXrYXBuAYr2r+vbWeJOX8UhiB7xEwb6p39xKqPbH53xDn
         yAiro73KAtgVbxYUmx1RK44JOjzdhOj4KXC+bENq/n1S07tBnkCaFSqQ091IpJuAJDU7
         Gw7zlrMRPjnjwFWrVkNrwVfXkMtqOc8tdTWh1Dnill85T/xjFWmBzVbpxmHhO0UMZyYo
         8PJw==
X-Gm-Message-State: AJcUukfU4Ix8EzPPIXag4jV6Fou3drXOnqmV9whzHSkdGrNrKWqDUOcQ
        h+HxGmY+EfskImZFiqipLUvXZcxUZvUoCDnUHaVmtQ==
X-Google-Smtp-Source: ALg8bN7ZSPCBtZpSW/6tE7vNhIk01WeXlaP6ZgI9xknccXjOxCZCY57zq6FnmgE8eukdUenQhcNgztF7HshFVOF2sb8=
X-Received: by 2002:a24:710:: with SMTP id f16mr2660624itf.121.1548188337202;
 Tue, 22 Jan 2019 12:18:57 -0800 (PST)
MIME-Version: 1.0
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com> <1548084825-8803-10-git-send-email-julien.thierry@arm.com>
In-Reply-To: <1548084825-8803-10-git-send-email-julien.thierry@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 22 Jan 2019 21:18:45 +0100
Message-ID: <CAKv+Gu8qL1BWE-xXA+X0wrORBpv+tVKKOnN0Dv+FGQFZGWUB-w@mail.gmail.com>
Subject: Re: [PATCH v9 09/26] arm64: Unmask PMR before going idle
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        James Morse <james.morse@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 at 16:36, Julien Thierry <julien.thierry@arm.com> wrote:
>
> CPU does not received signals for interrupts with a priority masked by
> ICC_PMR_EL1. This means the CPU might not come back from a WFI
> instruction.
>
> Make sure ICC_PMR_EL1 does not mask interrupts when doing a WFI.
>
> Since the logic of cpu_do_idle is becoming a bit more complex than just
> two instructions, lets turn it from ASM to C.
>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/process.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/mm/proc.S        | 11 -----------
>  2 files changed, 45 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 6d410fc..f05b63f 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -51,6 +51,7 @@
>  #include <linux/thread_info.h>
>
>  #include <asm/alternative.h>
> +#include <asm/arch_gicv3.h>
>  #include <asm/compat.h>
>  #include <asm/cacheflush.h>
>  #include <asm/exec.h>
> @@ -74,6 +75,50 @@
>
>  void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
>
> +static inline void __cpu_do_idle(void)
> +{
> +       dsb(sy);
> +       wfi();
> +}
> +
> +static inline void __cpu_do_idle_irqprio(void)

Can we drop the 'inline's from all the function definitions in .c
files? (not just in this patch)
We tend to leave that to the compiler.

> +{
> +       unsigned long pmr;
> +       unsigned long daif_bits;
> +
> +       daif_bits = read_sysreg(daif);
> +       write_sysreg(daif_bits | PSR_I_BIT, daif);
> +
> +       /*
> +        * Unmask PMR before going idle to make sure interrupts can
> +        * be raised.
> +        */
> +       pmr = gic_read_pmr();
> +       gic_write_pmr(GIC_PRIO_IRQON);
> +
> +       __cpu_do_idle();
> +
> +       gic_write_pmr(pmr);
> +       write_sysreg(daif_bits, daif);
> +}
> +
> +/*
> + *     cpu_do_idle()
> + *
> + *     Idle the processor (wait for interrupt).
> + *
> + *     If the CPU supports priority masking we must do additional work to
> + *     ensure that interrupts are not masked at the PMR (because the core will
> + *     not wake up if we block the wake up signal in the interrupt controller).
> + */
> +void cpu_do_idle(void)
> +{
> +       if (system_uses_irq_prio_masking())
> +               __cpu_do_idle_irqprio();
> +       else
> +               __cpu_do_idle();
> +}
> +
>  /*
>   * This is our default idle handler.
>   */
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 73886a5..3ea4f3b 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -55,17 +55,6 @@
>
>  #define MAIR(attr, mt) ((attr) << ((mt) * 8))
>
> -/*
> - *     cpu_do_idle()
> - *
> - *     Idle the processor (wait for interrupt).
> - */
> -ENTRY(cpu_do_idle)
> -       dsb     sy                              // WFI may enter a low-power mode
> -       wfi
> -       ret
> -ENDPROC(cpu_do_idle)
> -
>  #ifdef CONFIG_CPU_PM
>  /**
>   * cpu_do_suspend - save CPU registers context
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
