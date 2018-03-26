Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeCZIH5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:07:57 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37138 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeCZIH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:07:56 -0400
X-Google-Smtp-Source: AG47ELspBfUfnc7it73oiYenLRcL2O+UxOr0pnmu+EXxDRmd/o25bQrT0sPYTOXsN75RwHESALbuyMnQwYSrbvezBEY=
MIME-Version: 1.0
In-Reply-To: <mhng-673d4545-7e62-4815-bdac-33b0e990ec7e@palmer-si-x1c4>
References: <alpine.DEB.2.21.1803200852590.6506@nanos.tec.linutronix.de> <mhng-673d4545-7e62-4815-bdac-33b0e990ec7e@palmer-si-x1c4>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Mar 2018 10:07:54 +0200
X-Google-Sender-Auth: 3xzIRPhbapYzIqJtGkyOj_KCELg
Message-ID: <CAK8P3a0bD0669qXQ6NVJQ+b8j4Nsm8WeXNGfYinndGmRMVnPCg@mail.gmail.com>
Subject: Re: [tip:irq/core 12/13] drivers/irqchip/irq-vic.c:295:2: error:
 implicit declaration of function 'set_handle_irq'; did you mean 'vic_handle_irq'?
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Fengguang Wu <fengguang.wu@intel.com>, kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tipbuild@zytor.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 6:52 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
> On Tue, 20 Mar 2018 00:53:21 PDT (-0700), tglx@linutronix.de wrote:
>>
>> On Tue, 20 Mar 2018, kbuild test robot wrote:
>>
>>> Hi Palmer,
>>>
>>> FYI, the error/warning still remains.
>>
>>
>> Zapped the commit as well...
>
>
> Sorry, I got the flu at ELC and have been offline for a bit.  It looks like
> you've kept the IRQ and RISC-V patches, I'll fix up the others are re-submit
> them as a separate patch set.

Not sure which patches are in flight at the moment. To get a clean build
on arm32 and arm64 randconfig kernels, I needed the fixup below
on top of linux-next (not meant to be applied like this, just for reference).

       Arnd

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index a0fee6985e6a..b2b0c6405eb0 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -8,8 +8,6 @@

 struct pt_regs;

-extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
-
 static inline int nr_legacy_irqs(void)
 {
        return 0;
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 60e5fc661f74..780a12f59a8f 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -42,16 +42,6 @@ int arch_show_interrupts(struct seq_file *p, int prec)
        return 0;
 }

-void (*handle_arch_irq)(struct pt_regs *) = NULL;
-
-void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
-{
-       if (handle_arch_irq)
-               return;
-
-       handle_arch_irq = handle_irq;
-}
-
 #ifdef CONFIG_VMAP_STACK
 static void init_irq_stacks(void)
 {
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e9233db16e03..164516c1d49d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -8,8 +8,8 @@ config ARM_GIC
        bool
        select IRQ_DOMAIN
        select IRQ_DOMAIN_HIERARCHY
-       select MULTI_IRQ_HANDLER
        select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+       select GENERIC_IRQ_MULTI_HANDLER

 config ARM_GIC_PM
        bool
@@ -34,10 +34,9 @@ config GIC_NON_BANKED
 config ARM_GIC_V3
        bool
        select IRQ_DOMAIN
-       select MULTI_IRQ_HANDLER
-       select IRQ_DOMAIN_HIERARCHY
        select PARTITION_PERCPU
        select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+       select GENERIC_IRQ_MULTI_HANDLER

 config ARM_GIC_V3_ITS
        bool
@@ -66,7 +65,7 @@ config ARM_NVIC
 config ARM_VIC
        bool
        select IRQ_DOMAIN
-       select MULTI_IRQ_HANDLER
+       select GENERIC_IRQ_MULTI_HANDLER

 config ARM_VIC_NR
        int
@@ -92,15 +91,15 @@ config ALPINE_MSI
 config ATMEL_AIC_IRQ
        bool
        select GENERIC_IRQ_CHIP
+       select GENERIC_IRQ_MULTI_HANDLER
        select IRQ_DOMAIN
-       select MULTI_IRQ_HANDLER
        select SPARSE_IRQ

 config ATMEL_AIC5_IRQ
        bool
        select GENERIC_IRQ_CHIP
+       select GENERIC_IRQ_MULTI_HANDLER
        select IRQ_DOMAIN
-       select MULTI_IRQ_HANDLER
        select SPARSE_IRQ

 config I8259
@@ -136,8 +135,8 @@ config DW_APB_ICTL

 config FARADAY_FTINTC010
        bool
+       select GENERIC_IRQ_MULTI_HANDLER
        select IRQ_DOMAIN
-       select MULTI_IRQ_HANDLER
        select SPARSE_IRQ

 config HISILICON_IRQ_MBIGEN
@@ -162,7 +161,7 @@ config CLPS711X_IRQCHIP
        bool
        depends on ARCH_CLPS711X
        select IRQ_DOMAIN
-       select MULTI_IRQ_HANDLER
+       select GENERIC_IRQ_MULTI_HANDLER
        select SPARSE_IRQ
        default y

@@ -180,8 +179,8 @@ config OMAP_IRQCHIP

 config ORION_IRQCHIP
        bool
+       select GENERIC_IRQ_MULTI_HANDLER
        select IRQ_DOMAIN
-       select MULTI_IRQ_HANDLER

 config PIC32_EVIC
        bool
