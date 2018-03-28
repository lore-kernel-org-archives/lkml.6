Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeC1CHI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 22:07:08 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34611 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752503AbeC1CHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 22:07:04 -0400
X-Google-Smtp-Source: AIpwx4+RvkwReCjwJREMgg5dh/Kvl9kHbCJfmHNf5mEcW8kXgn5Adq2/bf1alfx2U/SlbxiIJEM5kw==
From: Rob Herring <robh@kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] microblaze: remove redundant early_printk support
Date: Tue, 27 Mar 2018 21:06:59 -0500
Message-Id: <20180328020700.17050-3-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180328020700.17050-1-robh@kernel.org>
References: <20180328020700.17050-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With earlycon support now enabled, the arch specific early_printk support
can be removed.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Michal Simek <monstr@monstr.eu>
---
v2: 
- Fix booting. The setup_memory call needed to be before the 
  parse_early_param call. And we want to do both before unflattening so 
  the earlycon is up.
- Remove some unused function declarations.

 arch/microblaze/Kconfig.debug         |   8 --
 arch/microblaze/include/asm/prom.h    |  27 -----
 arch/microblaze/include/asm/setup.h   |   5 -
 arch/microblaze/kernel/Makefile       |   1 -
 arch/microblaze/kernel/early_printk.c | 184 ----------------------------------
 arch/microblaze/kernel/misc.S         |  35 -------
 arch/microblaze/kernel/prom.c         |  82 ---------------
 arch/microblaze/kernel/setup.c        |  17 +---
 8 files changed, 4 insertions(+), 355 deletions(-)
 delete mode 100644 arch/microblaze/include/asm/prom.h
 delete mode 100644 arch/microblaze/kernel/early_printk.c

diff --git a/arch/microblaze/Kconfig.debug b/arch/microblaze/Kconfig.debug
index 012e377330cd..331a3bb66297 100644
--- a/arch/microblaze/Kconfig.debug
+++ b/arch/microblaze/Kconfig.debug
@@ -8,14 +8,6 @@ config TRACE_IRQFLAGS_SUPPORT
 
 source "lib/Kconfig.debug"
 
-config EARLY_PRINTK
-	bool "Early printk function for kernel"
-	depends on SERIAL_UARTLITE_CONSOLE || SERIAL_8250_CONSOLE
-	default n
-	help
-	  This option turns on/off early printk messages to console.
-	  First Uartlite node is taken.
-
 config HEART_BEAT
 	bool "Heart beat function for kernel"
 	default n
diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
deleted file mode 100644
index 2f03ac815851..000000000000
--- a/arch/microblaze/include/asm/prom.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * Definitions for talking to the Open Firmware PROM on
- * Power Macintosh computers.
- *
- * Copyright (C) 1996-2005 Paul Mackerras.
- *
- * Updates for PPC64 by Peter Bergner & David Engebretsen, IBM Corp.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#ifndef _ASM_MICROBLAZE_PROM_H
-#define _ASM_MICROBLAZE_PROM_H
-
-#include <linux/of.h>
-
-/* Other Prototypes */
-enum early_consoles {
-	UARTLITE = 1,
-	UART16550 = 2,
-};
-
-extern int of_early_console(void *version);
-
-#endif /* _ASM_MICROBLAZE_PROM_H */
diff --git a/arch/microblaze/include/asm/setup.h b/arch/microblaze/include/asm/setup.h
index 7c968c1d1729..d5384f6f36f7 100644
--- a/arch/microblaze/include/asm/setup.h
+++ b/arch/microblaze/include/asm/setup.h
@@ -19,16 +19,11 @@ extern char cmd_line[COMMAND_LINE_SIZE];
 
 extern char *klimit;
 
-int setup_early_printk(char *opt);
-void remap_early_printk(void);
-void disable_early_printk(void);
-
 void microblaze_heartbeat(void);
 void microblaze_setup_heartbeat(void);
 
 #   ifdef CONFIG_MMU
 extern void mmu_reset(void);
-extern void early_console_reg_tlb_alloc(unsigned int addr);
 #   endif /* CONFIG_MMU */
 
 extern void of_platform_reset_gpio_probe(void);
diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
index 0da76fa1ab17..7e99cf6984a1 100644
--- a/arch/microblaze/kernel/Makefile
+++ b/arch/microblaze/kernel/Makefile
@@ -22,7 +22,6 @@ obj-y += dma.o exceptions.o \
 
 obj-y += cpu/
 
-obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_HEART_BEAT)	+= heartbeat.o
 obj-$(CONFIG_MODULES)		+= microblaze_ksyms.o module.o
 obj-$(CONFIG_MMU)		+= misc.o
diff --git a/arch/microblaze/kernel/early_printk.c b/arch/microblaze/kernel/early_printk.c
deleted file mode 100644
index 365f2d53f1b2..000000000000
--- a/arch/microblaze/kernel/early_printk.c
+++ /dev/null
@@ -1,184 +0,0 @@
-/*
- * Early printk support for Microblaze.
- *
- * Copyright (C) 2007-2009 Michal Simek <monstr@monstr.eu>
- * Copyright (C) 2007-2009 PetaLogix
- * Copyright (C) 2003-2006 Yasushi SHOJI <yashi@atmark-techno.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/console.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/string.h>
-#include <linux/tty.h>
-#include <linux/io.h>
-#include <asm/processor.h>
-#include <linux/fcntl.h>
-#include <asm/setup.h>
-#include <asm/prom.h>
-
-static u32 base_addr;
-
-#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
-static void early_printk_uartlite_putc(char c)
-{
-	/*
-	 * Limit how many times we'll spin waiting for TX FIFO status.
-	 * This will prevent lockups if the base address is incorrectly
-	 * set, or any other issue on the UARTLITE.
-	 * This limit is pretty arbitrary, unless we are at about 10 baud
-	 * we'll never timeout on a working UART.
-	 */
-
-	unsigned retries = 1000000;
-	/* read status bit - 0x8 offset */
-	while (--retries && (in_be32(base_addr + 8) & (1 << 3)))
-		;
-
-	/* Only attempt the iowrite if we didn't timeout */
-	/* write to TX_FIFO - 0x4 offset */
-	if (retries)
-		out_be32(base_addr + 4, c & 0xff);
-}
-
-static void early_printk_uartlite_write(struct console *unused,
-					const char *s, unsigned n)
-{
-	while (*s && n-- > 0) {
-		if (*s == '\n')
-			early_printk_uartlite_putc('\r');
-		early_printk_uartlite_putc(*s);
-		s++;
-	}
-}
-
-static struct console early_serial_uartlite_console = {
-	.name = "earlyser",
-	.write = early_printk_uartlite_write,
-	.flags = CON_PRINTBUFFER | CON_BOOT,
-	.index = -1,
-};
-#endif /* CONFIG_SERIAL_UARTLITE_CONSOLE */
-
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-static void early_printk_uart16550_putc(char c)
-{
-	/*
-	 * Limit how many times we'll spin waiting for TX FIFO status.
-	 * This will prevent lockups if the base address is incorrectly
-	 * set, or any other issue on the UARTLITE.
-	 * This limit is pretty arbitrary, unless we are at about 10 baud
-	 * we'll never timeout on a working UART.
-	 */
-
-	#define UART_LSR_TEMT	0x40 /* Transmitter empty */
-	#define UART_LSR_THRE	0x20 /* Transmit-hold-register empty */
-	#define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
-
-	unsigned retries = 10000;
-
-	while (--retries &&
-		!((in_be32(base_addr + 0x14) & BOTH_EMPTY) == BOTH_EMPTY))
-		;
-
-	if (retries)
-		out_be32(base_addr, c & 0xff);
-}
-
-static void early_printk_uart16550_write(struct console *unused,
-					const char *s, unsigned n)
-{
-	while (*s && n-- > 0) {
-		if (*s == '\n')
-			early_printk_uart16550_putc('\r');
-		early_printk_uart16550_putc(*s);
-		s++;
-	}
-}
-
-static struct console early_serial_uart16550_console = {
-	.name = "earlyser",
-	.write = early_printk_uart16550_write,
-	.flags = CON_PRINTBUFFER | CON_BOOT,
-	.index = -1,
-};
-#endif /* CONFIG_SERIAL_8250_CONSOLE */
-
-int __init setup_early_printk(char *opt)
-{
-	int version = 0;
-
-	if (early_console)
-		return 1;
-
-	base_addr = of_early_console(&version);
-	if (base_addr) {
-#ifdef CONFIG_MMU
-		early_console_reg_tlb_alloc(base_addr);
-#endif
-		switch (version) {
-#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
-		case UARTLITE:
-			pr_info("Early console on uartlite at 0x%08x\n",
-								base_addr);
-			early_console = &early_serial_uartlite_console;
-			break;
-#endif
-#ifdef CONFIG_SERIAL_8250_CONSOLE
-		case UART16550:
-			pr_info("Early console on uart16650 at 0x%08x\n",
-								base_addr);
-			early_console = &early_serial_uart16550_console;
-			break;
-#endif
-		default:
-			pr_info("Unsupported early console %d\n",
-								version);
-			return 1;
-		}
-
-		register_console(early_console);
-		return 0;
-	}
-	return 1;
-}
-
-/* Remap early console to virtual address and do not allocate one TLB
- * only for early console because of performance degression */
-void __init remap_early_printk(void)
-{
-	if (!early_console)
-		return;
-	pr_info("early_printk_console remapping from 0x%x to ", base_addr);
-	base_addr = (u32) ioremap(base_addr, PAGE_SIZE);
-	pr_cont("0x%x\n", base_addr);
-
-#ifdef CONFIG_MMU
-	/*
-	 * Early console is on the top of skipped TLB entries
-	 * decrease tlb_skip size ensure that hardcoded TLB entry will be
-	 * used by generic algorithm
-	 * FIXME check if early console mapping is on the top by rereading
-	 * TLB entry and compare baseaddr
-	 *  mts  rtlbx, (tlb_skip - 1)
-	 *  nop
-	 *  mfs  rX, rtlblo
-	 *  nop
-	 *  cmp rX, orig_base_addr
-	 */
-	tlb_skip -= 1;
-#endif
-}
-
-void __init disable_early_printk(void)
-{
-	if (!early_console)
-		return;
-	pr_warn("disabling early console\n");
-	unregister_console(early_console);
-	early_console = NULL;
-}
diff --git a/arch/microblaze/kernel/misc.S b/arch/microblaze/kernel/misc.S
index 1dafddeb8a0b..6759af688451 100644
--- a/arch/microblaze/kernel/misc.S
+++ b/arch/microblaze/kernel/misc.S
@@ -63,38 +63,3 @@ _tlbie_1:
 	nop
 
 	.size  _tlbie, . - _tlbie
-
-/*
- * Allocate TLB entry for early console
- */
-.globl early_console_reg_tlb_alloc;
-.type  early_console_reg_tlb_alloc, @function
-.align 4;
-early_console_reg_tlb_alloc:
-	/*
-	 * Load a TLB entry for the UART, so that microblaze_progress() can use
-	 * the UARTs nice and early.  We use a 4k real==virtual mapping.
-	 */
-	lwi	r4, r0, tlb_skip
-	mts	rtlbx, r4 /* TLB slot 63 */
-
-	or	r4,r5,r0
-	andi	r4,r4,0xfffff000
-	ori	r4,r4,(TLB_WR|TLB_I|TLB_M|TLB_G)
-
-	andi	r5,r5,0xfffff000
-	ori	r5,r5,(TLB_VALID | TLB_PAGESZ(PAGESZ_4K))
-
-	mts	rtlblo,r4 /* Load the data portion of the entry */
-	nop
-	mts	rtlbhi,r5 /* Load the tag portion of the entry */
-	nop
-
-	lwi	r5, r0, tlb_skip
-	addik	r5, r5, 1
-	swi	r5, r0, tlb_skip
-
-	rtsd	r15, 8
-	nop
-
-	.size  early_console_reg_tlb_alloc, . - early_console_reg_tlb_alloc
diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index 68f099960ebc..c76c93b90b79 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -13,91 +13,11 @@
  *      2 of the License, or (at your option) any later version.
  */
 
-#include <stdarg.h>
-#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
-#include <linux/init.h>
-#include <linux/threads.h>
-#include <linux/spinlock.h>
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/stringify.h>
-#include <linux/delay.h>
-#include <linux/initrd.h>
-#include <linux/bitops.h>
-#include <linux/kexec.h>
-#include <linux/debugfs.h>
-#include <linux/irq.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
 
-#include <asm/prom.h>
-#include <asm/page.h>
-#include <asm/processor.h>
-#include <asm/irq.h>
-#include <linux/io.h>
-#include <asm/mmu.h>
-#include <asm/pgtable.h>
-#include <asm/sections.h>
-#include <asm/pci-bridge.h>
-
-#ifdef CONFIG_EARLY_PRINTK
-static const char *stdout;
-
-static int __init early_init_dt_scan_chosen_serial(unsigned long node,
-				const char *uname, int depth, void *data)
-{
-	int l;
-	const char *p;
-
-	pr_debug("%s: depth: %d, uname: %s\n", __func__, depth, uname);
-
-	if (depth == 1 && (strcmp(uname, "chosen") == 0 ||
-				strcmp(uname, "chosen@0") == 0)) {
-		p = of_get_flat_dt_prop(node, "linux,stdout-path", &l);
-		if (p != NULL && l > 0)
-			stdout = p; /* store pointer to stdout-path */
-	}
-
-	if (stdout && strstr(stdout, uname)) {
-		p = of_get_flat_dt_prop(node, "compatible", &l);
-		pr_debug("Compatible string: %s\n", p);
-
-		if ((strncmp(p, "xlnx,xps-uart16550", 18) == 0) ||
-			(strncmp(p, "xlnx,axi-uart16550", 18) == 0)) {
-			unsigned int addr;
-
-			*(u32 *)data = UART16550;
-
-			addr = *(u32 *)of_get_flat_dt_prop(node, "reg", &l);
-			addr += *(u32 *)of_get_flat_dt_prop(node,
-							"reg-offset", &l);
-			/* clear register offset */
-			return be32_to_cpu(addr) & ~3;
-		}
-		if ((strncmp(p, "xlnx,xps-uartlite", 17) == 0) ||
-				(strncmp(p, "xlnx,opb-uartlite", 17) == 0) ||
-				(strncmp(p, "xlnx,axi-uartlite", 17) == 0) ||
-				(strncmp(p, "xlnx,mdm", 8) == 0)) {
-			const unsigned int *addrp;
-
-			*(u32 *)data = UARTLITE;
-
-			addrp = of_get_flat_dt_prop(node, "reg", &l);
-			return be32_to_cpup(addrp); /* return address */
-		}
-	}
-	return 0;
-}
-
-/* this function is looking for early console - Microblaze specific */
-int __init of_early_console(void *version)
-{
-	return of_scan_flat_dt(early_init_dt_scan_chosen_serial, version);
-}
-#endif
-
 void __init early_init_devtree(void *params)
 {
 	pr_debug(" -> early_init_devtree(%p)\n", params);
@@ -106,8 +26,6 @@ void __init early_init_devtree(void *params)
 	if (!strlen(boot_command_line))
 		strlcpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
 
-	parse_early_param();
-
 	memblock_allow_resize();
 
 	pr_debug("Phys. mem: %lx\n", (unsigned long) memblock_phys_mem_size());
diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index be98ffe28ca8..bbd6968ce55b 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -27,13 +27,12 @@
 #include <linux/param.h>
 #include <linux/pci.h>
 #include <linux/cache.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/dma-mapping.h>
 #include <asm/cacheflush.h>
 #include <asm/entry.h>
 #include <asm/cpuinfo.h>
 
-#include <asm/prom.h>
 #include <asm/pgtable.h>
 
 DEFINE_PER_CPU(unsigned int, KSP);	/* Saved kernel stack pointer */
@@ -54,6 +53,9 @@ void __init setup_arch(char **cmdline_p)
 {
 	*cmdline_p = boot_command_line;
 
+	setup_memory();
+	parse_early_param();
+
 	console_verbose();
 
 	unflatten_device_tree();
@@ -62,13 +64,6 @@ void __init setup_arch(char **cmdline_p)
 
 	microblaze_cache_init();
 
-	setup_memory();
-
-#ifdef CONFIG_EARLY_PRINTK
-	/* remap early console to virtual address */
-	remap_early_printk();
-#endif
-
 	xilinx_pci_init();
 
 #if defined(CONFIG_DUMMY_CONSOLE)
@@ -133,10 +128,6 @@ void __init machine_early_init(const char *cmdline, unsigned int ram,
 /* initialize device tree for usage in early_printk */
 	early_init_devtree(_fdt_start);
 
-#ifdef CONFIG_EARLY_PRINTK
-	setup_early_printk(NULL);
-#endif
-
 	/* setup kernel_tlb after BSS cleaning
 	 * Maybe worth to move to asm code */
 	kernel_tlb = tlb0 + tlb1;
-- 
2.14.1
