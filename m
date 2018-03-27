Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbeC0QVd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:21:33 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43259 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeC0QTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:19:32 -0400
X-Google-Smtp-Source: AG47ELv6vCZeS9u8fT7hEdNbsa249SyHa1jlSgGyTKn65WP1V/idgzH2lZ+inXR56Imy0SOK4PQatg==
Subject: [PATCH v4 5/8] arm: Convert to GENERIC_IRQ_MULTI_HANDLER
Date: Tue, 27 Mar 2018 09:19:08 -0700
Message-Id: <20180327161911.14086-6-palmer@sifive.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180327161911.14086-1-palmer@sifive.com>
References: <20180327161911.14086-1-palmer@sifive.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: linux@armlinux.org.uk, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the ARM port to use the recently added
GENERIC_IRQ_MULTI_HANDLER, which is essentially just a copy of ARM's
existhing MULTI_IRQ_HANDLER.  The only changes are:

* handle_arch_irq is now defined in a generic C file instead of an
  arm-specific assembly file.
* handle_arch_irq is now marked as __ro_after_init.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/arm/Kconfig                 | 19 +++++++------------
 arch/arm/include/asm/irq.h       |  5 -----
 arch/arm/include/asm/mach/arch.h |  2 +-
 arch/arm/kernel/entry-armv.S     | 10 ++--------
 arch/arm/kernel/irq.c            | 10 ----------
 arch/arm/kernel/setup.c          |  2 +-
 6 files changed, 11 insertions(+), 37 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7e3d53575486..3f972e83909b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -339,8 +339,8 @@ config ARCH_MULTIPLATFORM
 	select TIMER_OF
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_MULTI_HANDLER
 	select MIGHT_HAVE_PCI
-	select MULTI_IRQ_HANDLER
 	select PCI_DOMAINS if PCI
 	select SPARSE_IRQ
 	select USE_OF
@@ -467,9 +467,9 @@ config ARCH_DOVE
 	bool "Marvell Dove"
 	select CPU_PJ4
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIOLIB
 	select MIGHT_HAVE_PCI
-	select MULTI_IRQ_HANDLER
 	select MVEBU_MBUS
 	select PINCTRL
 	select PINCTRL_DOVE
@@ -514,8 +514,8 @@ config ARCH_LPC32XX
 	select COMMON_CLK
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIOLIB
-	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	select USE_OF
 	help
@@ -534,11 +534,11 @@ config ARCH_PXA
 	select TIMER_OF
 	select CPU_XSCALE if !CPU_XSC3
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIO_PXA
 	select GPIOLIB
 	select HAVE_IDE
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
 	select PLAT_PXA
 	select SPARSE_IRQ
 	help
@@ -574,11 +574,11 @@ config ARCH_SA1100
 	select CPU_FREQ
 	select CPU_SA1100
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIOLIB
 	select HAVE_IDE
 	select IRQ_DOMAIN
 	select ISA
-	select MULTI_IRQ_HANDLER
 	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
 	help
@@ -592,10 +592,10 @@ config ARCH_S3C24XX
 	select GENERIC_CLOCKEVENTS
 	select GPIO_SAMSUNG
 	select GPIOLIB
+	select GENERIC_IRQ_MULTI_HANDLER
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
-	select MULTI_IRQ_HANDLER
 	select NEED_MACH_IO_H
 	select SAMSUNG_ATAGS
 	select USE_OF
@@ -629,10 +629,10 @@ config ARCH_OMAP1
 	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIOLIB
 	select HAVE_IDE
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
 	select NEED_MACH_IO_H if PCCARD
 	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
@@ -921,11 +921,6 @@ config IWMMXT
 	  Enable support for iWMMXt context switching at run time if
 	  running on a CPU that supports it.
 
-config MULTI_IRQ_HANDLER
-	bool
-	help
-	  Allow each machine to specify it's own IRQ handler at run time.
-
 if !MMU
 source "arch/arm/Kconfig-nommu"
 endif
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index b6f319606e30..c883fcbe93b6 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -31,11 +31,6 @@ extern void asm_do_IRQ(unsigned int, struct pt_regs *);
 void handle_IRQ(unsigned int, struct pt_regs *);
 void init_IRQ(void);
 
-#ifdef CONFIG_MULTI_IRQ_HANDLER
-extern void (*handle_arch_irq)(struct pt_regs *);
-extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
-#endif
-
 #ifdef CONFIG_SMP
 extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
 					   bool exclude_self);
diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 5c1ad11aa392..bb8851208e17 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -59,7 +59,7 @@ struct machine_desc {
 	void			(*init_time)(void);
 	void			(*init_machine)(void);
 	void			(*init_late)(void);
-#ifdef CONFIG_MULTI_IRQ_HANDLER
+#ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
 	void			(*handle_irq)(struct pt_regs *);
 #endif
 	void			(*restart)(enum reboot_mode, const char *);
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 1752033b0070..7eeb1f57fa20 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -22,7 +22,7 @@
 #include <asm/glue-df.h>
 #include <asm/glue-pf.h>
 #include <asm/vfpmacros.h>
-#ifndef CONFIG_MULTI_IRQ_HANDLER
+#ifndef CONFIG_GENERIC_IRQ_MULTI_HANDLER
 #include <mach/entry-macro.S>
 #endif
 #include <asm/thread_notify.h>
@@ -39,7 +39,7 @@
  * Interrupt handling.
  */
 	.macro	irq_handler
-#ifdef CONFIG_MULTI_IRQ_HANDLER
+#ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
 	ldr	r1, =handle_arch_irq
 	mov	r0, sp
 	badr	lr, 9997f
@@ -1226,9 +1226,3 @@ vector_addrexcptn:
 	.globl	cr_alignment
 cr_alignment:
 	.space	4
-
-#ifdef CONFIG_MULTI_IRQ_HANDLER
-	.globl	handle_arch_irq
-handle_arch_irq:
-	.space	4
-#endif
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index ece04a457486..9908dacf9229 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -102,16 +102,6 @@ void __init init_IRQ(void)
 	uniphier_cache_init();
 }
 
-#ifdef CONFIG_MULTI_IRQ_HANDLER
-void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
-{
-	if (handle_arch_irq)
-		return;
-
-	handle_arch_irq = handle_irq;
-}
-#endif
-
 #ifdef CONFIG_SPARSE_IRQ
 int __init arch_probe_nr_irqs(void)
 {
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index fc40a2b40595..f6c26c370427 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1145,7 +1145,7 @@ void __init setup_arch(char **cmdline_p)
 
 	reserve_crashkernel();
 
-#ifdef CONFIG_MULTI_IRQ_HANDLER
+#ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
 	handle_arch_irq = mdesc->handle_irq;
 #endif
 
-- 
2.16.1
