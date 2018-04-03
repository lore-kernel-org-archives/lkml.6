Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754964AbeDCGVE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 02:21:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34610 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754835AbeDCGU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 02:20:56 -0400
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, thomas.petazzoni@bootlin.com,
        mylene.josserand@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/13] ARM: sunxi: smp: Move assembly code into a file
Date: Tue,  3 Apr 2018 08:18:25 +0200
Message-Id: <20180403061836.3926-3-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180403061836.3926-1-mylene.josserand@bootlin.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the assembly code for cluster cache enabling
into an assembly file instead of having it directly in C code.

Remove the CFLAGS because we are using the ARM directive "arch"
instead.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/mach-sunxi/Makefile  |  4 +--
 arch/arm/mach-sunxi/headsmp.S | 75 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-sunxi/mc_smp.c  | 71 ++--------------------------------------
 3 files changed, 79 insertions(+), 71 deletions(-)
 create mode 100644 arch/arm/mach-sunxi/headsmp.S

diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index 7de9cc286d53..7f45071ae74a 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -1,5 +1,3 @@
-CFLAGS_mc_smp.o	+= -march=armv7-a
-
 obj-$(CONFIG_ARCH_SUNXI) += sunxi.o
-obj-$(CONFIG_ARCH_SUNXI_MC_SMP) += mc_smp.o
+obj-$(CONFIG_ARCH_SUNXI_MC_SMP) += mc_smp.o headsmp.o
 obj-$(CONFIG_SMP) += platsmp.o
diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
new file mode 100644
index 000000000000..119005b5dff9
--- /dev/null
+++ b/arch/arm/mach-sunxi/headsmp.S
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Chen-Yu Tsai
+ * Copyright (c) 2018 Bootlin
+ *
+ * Chen-Yu Tsai <wens@csie.org>
+ * Mylène Josserand <mylene.josserand@bootlin.com>
+ *
+ * SMP support for sunxi based systems with Cortex A7/A15
+ *
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/cputype_def.h>
+
+ENTRY(sunxi_mc_smp_cluster_cache_enable)
+	.arch	armv7-a
+	/*
+	 * Enable cluster-level coherency, in preparation for turning on the MMU.
+	 *
+	 * Also enable regional clock gating and L2 data latency settings for
+	 * Cortex-A15. These settings are from the vendor kernel.
+	 */
+	mrc	p15, 0, r1, c0, c0, 0
+	movw	r2, #(ARM_CPU_PART_MASK & 0xffff)
+	movt	r2, #(ARM_CPU_PART_MASK >> 16)
+	and	r1, r1, r2
+	movw	r2, #(ARM_CPU_PART_CORTEX_A15 & 0xffff)
+	movt	r2, #(ARM_CPU_PART_CORTEX_A15 >> 16)
+	cmp	r1, r2
+	bne	not_a15
+
+	/* The following is Cortex-A15 specific */
+
+	/* ACTLR2: Enable CPU regional clock gates */
+	mrc p15, 1, r1, c15, c0, 4
+	orr r1, r1, #(0x1 << 31)
+	mcr p15, 1, r1, c15, c0, 4
+
+	/* L2ACTLR */
+	mrc p15, 1, r1, c15, c0, 0
+	/* Enable L2, GIC, and Timer regional clock gates */
+	orr r1, r1, #(0x1 << 26)
+	/* Disable clean/evict from being pushed to external */
+	orr r1, r1, #(0x1<<3)
+	mcr p15, 1, r1, c15, c0, 0
+
+	/* L2CTRL: L2 data RAM latency */
+	mrc p15, 1, r1, c9, c0, 2
+	bic r1, r1, #(0x7 << 0)
+	orr r1, r1, #(0x3 << 0)
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
+ENTRY(sunxi_mc_smp_secondary_startup)
+	bl	sunxi_mc_smp_cluster_cache_enable
+	b	secondary_startup
+ENDPROC(sunxi_mc_smp_secondary_startup)
diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index c0246ec54a0a..9cc6c8fc6db7 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -72,6 +72,8 @@ static void __iomem *cpucfg_base;
 static void __iomem *prcm_base;
 static void __iomem *sram_b_smp_base;
 
+extern void sunxi_mc_smp_secondary_startup(void);
+
 static bool sunxi_core_is_cortex_a15(unsigned int core, unsigned int cluster)
 {
 	struct device_node *node;
@@ -300,74 +302,7 @@ static void sunxi_cluster_cache_disable_without_axi(void)
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
 
-- 
2.11.0
