Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeCZSIi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 14:08:38 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39036 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbeCZSIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 14:08:37 -0400
X-Google-Smtp-Source: AG47ELv8VfeVlwA2XafcaJdxMlUReVz7wre4OaLM0oYtQEed6CXbYxOo0o+KH45EoLxtFS8Nf+dVSw==
Date: Mon, 26 Mar 2018 11:08:35 -0700 (PDT)
X-Google-Original-Date: Mon, 26 Mar 2018 11:08:34 PDT (-0700)
Subject: Re: [tip:irq/core 12/13] drivers/irqchip/irq-vic.c:295:2: error: implicit declaration of function 'set_handle_irq'; did you mean 'vic_handle_irq'?
In-Reply-To: <CAK8P3a0bD0669qXQ6NVJQ+b8j4Nsm8WeXNGfYinndGmRMVnPCg@mail.gmail.com>
CC: fengguang.wu@intel.com, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, tipbuild@zytor.com
From: Palmer Dabbelt <palmer@sifive.com>
To: Arnd Bergmann <arnd@arndb.de>, tglx@linutronix.de
Message-ID: <mhng-ca8cf5ce-3363-405e-ab78-bbbe4f79dbcd@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2018 01:07:54 PDT (-0700), Arnd Bergmann wrote:
> On Tue, Mar 20, 2018 at 6:52 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
>> On Tue, 20 Mar 2018 00:53:21 PDT (-0700), tglx@linutronix.de wrote:
>>>
>>> On Tue, 20 Mar 2018, kbuild test robot wrote:
>>>
>>>> Hi Palmer,
>>>>
>>>> FYI, the error/warning still remains.
>>>
>>>
>>> Zapped the commit as well...
>>
>>
>> Sorry, I got the flu at ELC and have been offline for a bit.  It looks like
>> you've kept the IRQ and RISC-V patches, I'll fix up the others are re-submit
>> them as a separate patch set.
>
> Not sure which patches are in flight at the moment. To get a clean build
> on arm32 and arm64 randconfig kernels, I needed the fixup below
> on top of linux-next (not meant to be applied like this, just for reference).

Thanks, I missed these during my original patch submission.  I think the 
cleanest way to submit this is to spin a whole new patch set, including those 
that are already in tip.  Would it be possible to just remove my IRQ cleanups 
from tip so I can try again?

>
>        Arnd
>
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index a0fee6985e6a..b2b0c6405eb0 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -8,8 +8,6 @@
>
>  struct pt_regs;
>
> -extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
> -
>  static inline int nr_legacy_irqs(void)
>  {
>         return 0;
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index 60e5fc661f74..780a12f59a8f 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -42,16 +42,6 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>         return 0;
>  }
>
> -void (*handle_arch_irq)(struct pt_regs *) = NULL;
> -
> -void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
> -{
> -       if (handle_arch_irq)
> -               return;
> -
> -       handle_arch_irq = handle_irq;
> -}
> -
>  #ifdef CONFIG_VMAP_STACK
>  static void init_irq_stacks(void)
>  {
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index e9233db16e03..164516c1d49d 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -8,8 +8,8 @@ config ARM_GIC
>         bool
>         select IRQ_DOMAIN
>         select IRQ_DOMAIN_HIERARCHY
> -       select MULTI_IRQ_HANDLER
>         select GENERIC_IRQ_EFFECTIVE_AFF_MASK
> +       select GENERIC_IRQ_MULTI_HANDLER
>
>  config ARM_GIC_PM
>         bool
> @@ -34,10 +34,9 @@ config GIC_NON_BANKED
>  config ARM_GIC_V3
>         bool
>         select IRQ_DOMAIN
> -       select MULTI_IRQ_HANDLER
> -       select IRQ_DOMAIN_HIERARCHY
>         select PARTITION_PERCPU
>         select GENERIC_IRQ_EFFECTIVE_AFF_MASK
> +       select GENERIC_IRQ_MULTI_HANDLER
>
>  config ARM_GIC_V3_ITS
>         bool
> @@ -66,7 +65,7 @@ config ARM_NVIC
>  config ARM_VIC
>         bool
>         select IRQ_DOMAIN
> -       select MULTI_IRQ_HANDLER
> +       select GENERIC_IRQ_MULTI_HANDLER
>
>  config ARM_VIC_NR
>         int
> @@ -92,15 +91,15 @@ config ALPINE_MSI
>  config ATMEL_AIC_IRQ
>         bool
>         select GENERIC_IRQ_CHIP
> +       select GENERIC_IRQ_MULTI_HANDLER
>         select IRQ_DOMAIN
> -       select MULTI_IRQ_HANDLER
>         select SPARSE_IRQ
>
>  config ATMEL_AIC5_IRQ
>         bool
>         select GENERIC_IRQ_CHIP
> +       select GENERIC_IRQ_MULTI_HANDLER
>         select IRQ_DOMAIN
> -       select MULTI_IRQ_HANDLER
>         select SPARSE_IRQ
>
>  config I8259
> @@ -136,8 +135,8 @@ config DW_APB_ICTL
>
>  config FARADAY_FTINTC010
>         bool
> +       select GENERIC_IRQ_MULTI_HANDLER
>         select IRQ_DOMAIN
> -       select MULTI_IRQ_HANDLER
>         select SPARSE_IRQ
>
>  config HISILICON_IRQ_MBIGEN
> @@ -162,7 +161,7 @@ config CLPS711X_IRQCHIP
>         bool
>         depends on ARCH_CLPS711X
>         select IRQ_DOMAIN
> -       select MULTI_IRQ_HANDLER
> +       select GENERIC_IRQ_MULTI_HANDLER
>         select SPARSE_IRQ
>         default y
>
> @@ -180,8 +179,8 @@ config OMAP_IRQCHIP
>
>  config ORION_IRQCHIP
>         bool
> +       select GENERIC_IRQ_MULTI_HANDLER
>         select IRQ_DOMAIN
> -       select MULTI_IRQ_HANDLER
>
>  config PIC32_EVIC
>         bool
