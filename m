Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeBWNir (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:38:47 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:48937 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbeBWNij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:38:39 -0500
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: maxime.ripard@bootlin.com, linux@armlinux.org.uk, wens@csie.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clabbe.montjoie@gmail.com,
        thomas.petazzoni@bootlin.com, mylene.josserand@bootlin.com,
        quentin.schulz@bootlin.com
Subject: [PATCH v4 08/10] ARM: sunxi: smp: Move assembly code into a file
Date: Fri, 23 Feb 2018 14:37:40 +0100
Message-Id: <20180223133742.26044-9-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180223133742.26044-1-mylene.josserand@bootlin.com>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the assembly code for cluster cache enabling
into an assembly file instead of having it directly in C code.

Create a sunxi_boot entry that will perform a cluster cached
enabling and called secondary_startup.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/mach-sunxi/Makefile  |  1 +
 arch/arm/mach-sunxi/headsmp.S | 73 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-sunxi/mc_smp.c  | 76 ++++---------------------------------------
 3 files changed, 80 insertions(+), 70 deletions(-)
 create mode 100644 arch/arm/mach-sunxi/headsmp.S

diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index 7de9cc286d53..d1a072b879ed 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -1,5 +1,6 @@
 CFLAGS_mc_smp.o	+= -march=armv7-a
 
 obj-$(CONFIG_ARCH_SUNXI) += sunxi.o
+obj-$(CONFIG_ARCH_SUNXI) += headsmp.o
 obj-$(CONFIG_ARCH_SUNXI_MC_SMP) += mc_smp.o
 obj-$(CONFIG_SMP) += platsmp.o
diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
new file mode 100644
index 000000000000..4f5957a6e188
--- /dev/null
+++ b/arch/arm/mach-sunxi/headsmp.S
@@ -0,0 +1,73 @@
+/*
+ * SMP support for sunxi based systems with Cortex A7/A15
+ *
+ * Copyright (C) 2018 Bootlin
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+ENTRY(sunxi_mc_smp_cluster_cache_enable)
+	/*
+	* Enable cluster-level coherency, in preparation for turning on the MMU.
+	*
+	* Also enable regional clock gating and L2 data latency settings for
+	* Cortex-A15. These settings are from the vendor kernel.
+	*/
+	mrc	p15, 0, r1, c0, c0, 0
+	movw	r2, #(0xff00fff0&0xffff)
+	movt	r2, #(0xff00fff0>>16)
+	and	r1, r1, r2
+	movw	r2, #(0x4100c0f0&0xffff)
+	movt	r2, #(0x4100c0f0>>16)
+	cmp	r1, r2
+	bne	not_a15
+
+	/* The following is Cortex-A15 specific */
+
+	/* ACTLR2: Enable CPU regional clock gates */
+	mrc p15, 1, r1, c15, c0, 4
+	orr r1, r1, #(0x1<<31)
+	mcr p15, 1, r1, c15, c0, 4
+
+	/* L2ACTLR */
+	mrc p15, 1, r1, c15, c0, 0
+	/* Enable L2, GIC, and Timer regional clock gates */
+	orr r1, r1, #(0x1<<26)
+	/* Disable clean/evict from being pushed to external */
+	orr r1, r1, #(0x1<<3)
+	mcr p15, 1, r1, c15, c0, 0
+
+	/* L2CTRL: L2 data RAM latency */
+	mrc p15, 1, r1, c9, c0, 2
+	bic r1, r1, #(0x7<<0)
+	orr r1, r1, #(0x3<<0)
+	mcr p15, 1, r1, c9, c0, 2
+
+	/* End of Cortex-A15 specific setup */
+	not_a15:
+
+	/* Get value of sunxi_mc_smp_first_comer */
+	adr	r1, first
+	ldr	r0, [r1]
+	ldr	r0, [r1, r0]
+
+	/* Skip cci_enable_port_for_self if not first comer */
+	cmp	r0, #0
+	bxeq	lr
+	b	cci_enable_port_for_self
+
+	.align 2
+	first: .word sunxi_mc_smp_first_comer - .
+ENDPROC(sunxi_mc_smp_cluster_cache_enable)
+
+#ifdef CONFIG_SMP
+ENTRY(sunxi_boot)
+	bl	sunxi_mc_smp_cluster_cache_enable
+	b	secondary_startup
+ENDPROC(sunxi_boot)
+#endif
diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index f2c2cfca28cd..4e807cc11a0f 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -82,6 +82,9 @@ static void __iomem *prcm_base;
 static void __iomem *sram_b_smp_base;
 static bool is_sun9i;
 
+extern void sunxi_boot(void);
+extern void sunxi_cluster_cache_enable(void);
+
 static bool sunxi_core_is_cortex_a15(unsigned int core, unsigned int cluster)
 {
 	struct device_node *node;
@@ -361,74 +364,7 @@ static void sunxi_cluster_cache_disable_without_axi(void)
 }
 
 static int sunxi_mc_smp_cpu_table[SUNXI_NR_CLUSTERS][SUNXI_CPUS_PER_CLUSTER];
-static int sunxi_mc_smp_first_comer;
-
-/*
- * Enable cluster-level coherency, in preparation for turning on the MMU.
- *
- * Also enable regional clock gating and L2 data latency settings for
- * Cortex-A15. These settings are from the vendor kernel.
- */
-static void __naked sunxi_mc_smp_cluster_cache_enable(void)
-{
-	asm volatile (
-		"mrc	p15, 0, r1, c0, c0, 0\n"
-		"movw	r2, #" __stringify(ARM_CPU_PART_MASK & 0xffff) "\n"
-		"movt	r2, #" __stringify(ARM_CPU_PART_MASK >> 16) "\n"
-		"and	r1, r1, r2\n"
-		"movw	r2, #" __stringify(ARM_CPU_PART_CORTEX_A15 & 0xffff) "\n"
-		"movt	r2, #" __stringify(ARM_CPU_PART_CORTEX_A15 >> 16) "\n"
-		"cmp	r1, r2\n"
-		"bne	not_a15\n"
-
-		/* The following is Cortex-A15 specific */
-
-		/* ACTLR2: Enable CPU regional clock gates */
-		"mrc p15, 1, r1, c15, c0, 4\n"
-		"orr r1, r1, #(0x1<<31)\n"
-		"mcr p15, 1, r1, c15, c0, 4\n"
-
-		/* L2ACTLR */
-		"mrc p15, 1, r1, c15, c0, 0\n"
-		/* Enable L2, GIC, and Timer regional clock gates */
-		"orr r1, r1, #(0x1<<26)\n"
-		/* Disable clean/evict from being pushed to external */
-		"orr r1, r1, #(0x1<<3)\n"
-		"mcr p15, 1, r1, c15, c0, 0\n"
-
-		/* L2CTRL: L2 data RAM latency */
-		"mrc p15, 1, r1, c9, c0, 2\n"
-		"bic r1, r1, #(0x7<<0)\n"
-		"orr r1, r1, #(0x3<<0)\n"
-		"mcr p15, 1, r1, c9, c0, 2\n"
-
-		/* End of Cortex-A15 specific setup */
-		"not_a15:\n"
-
-		/* Get value of sunxi_mc_smp_first_comer */
-		"adr	r1, first\n"
-		"ldr	r0, [r1]\n"
-		"ldr	r0, [r1, r0]\n"
-
-		/* Skip cci_enable_port_for_self if not first comer */
-		"cmp	r0, #0\n"
-		"bxeq	lr\n"
-		"b	cci_enable_port_for_self\n"
-
-		".align 2\n"
-		"first: .word sunxi_mc_smp_first_comer - .\n"
-	);
-}
-
-static void __naked sunxi_mc_smp_secondary_startup(void)
-{
-	asm volatile(
-		"bl	sunxi_mc_smp_cluster_cache_enable\n"
-		"b	secondary_startup"
-		/* Let compiler know about sunxi_mc_smp_cluster_cache_enable */
-		:: "i" (sunxi_mc_smp_cluster_cache_enable)
-	);
-}
+int sunxi_mc_smp_first_comer;
 
 static DEFINE_SPINLOCK(boot_lock);
 
@@ -951,10 +887,10 @@ static int __init sunxi_mc_smp_init(void)
 
 	/* Set the hardware entry point address */
 	if (is_sun9i)
-		writel(__pa_symbol(sunxi_mc_smp_secondary_startup),
+		writel(__pa_symbol(sunxi_boot),
 		       prcm_base + PRCM_CPU_SOFT_ENTRY_REG);
 	else
-		writel(__pa_symbol(sunxi_mc_smp_secondary_startup),
+		writel(__pa_symbol(sunxi_boot),
 		       r_cpucfg_base + R_CPUCFG_CPU_SOFT_ENTRY_REG);
 
 	/* Actually enable multi cluster SMP */
-- 
2.11.0
