Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A50BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9152080F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9152080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeKSLWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:22:25 -0500
Received: from mx.socionext.com ([202.248.49.38]:40664 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbeKSLWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:22:25 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 19 Nov 2018 10:00:29 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 8570F60062;
        Mon, 19 Nov 2018 10:00:29 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 19 Nov 2018 10:00:29 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 1743D40387;
        Mon, 19 Nov 2018 10:00:29 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id EAC35120455;
        Mon, 19 Nov 2018 10:00:28 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH 01/14] ARM: milbeaut: Add basic support for Milbeaut m10v SoC
Date:   Mon, 19 Nov 2018 10:01:06 +0900
Message-Id: <1542589274-13878-2-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the basic M10V SoC support under arch/arm.
Since all cores are activated in the custom bootloader before booting
linux, it is necessary to wait for sub-cores using the trampoline area.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 arch/arm/Kconfig                  |   2 +
 arch/arm/Makefile                 |   1 +
 arch/arm/mach-milbeaut/Kconfig    |  28 +++++++
 arch/arm/mach-milbeaut/Makefile   |   3 +
 arch/arm/mach-milbeaut/m10v_evb.c |  31 ++++++++
 arch/arm/mach-milbeaut/platsmp.c  | 157 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 222 insertions(+)
 create mode 100644 arch/arm/mach-milbeaut/Kconfig
 create mode 100644 arch/arm/mach-milbeaut/Makefile
 create mode 100644 arch/arm/mach-milbeaut/m10v_evb.c
 create mode 100644 arch/arm/mach-milbeaut/platsmp.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 91be74d..0b8a1af 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -767,6 +767,8 @@ source "arch/arm/mach-mediatek/Kconfig"
 
 source "arch/arm/mach-meson/Kconfig"
 
+source "arch/arm/mach-milbeaut/Kconfig"
+
 source "arch/arm/mach-mmp/Kconfig"
 
 source "arch/arm/mach-moxart/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 05a91d8..627853c 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -190,6 +190,7 @@ machine-$(CONFIG_ARCH_MV78XX0)		+= mv78xx0
 machine-$(CONFIG_ARCH_MVEBU)		+= mvebu
 machine-$(CONFIG_ARCH_MXC)		+= imx
 machine-$(CONFIG_ARCH_MEDIATEK)		+= mediatek
+machine-$(CONFIG_ARCH_MILBEAUT)		+= milbeaut
 machine-$(CONFIG_ARCH_MXS)		+= mxs
 machine-$(CONFIG_ARCH_NETX)		+= netx
 machine-$(CONFIG_ARCH_NOMADIK)		+= nomadik
diff --git a/arch/arm/mach-milbeaut/Kconfig b/arch/arm/mach-milbeaut/Kconfig
new file mode 100644
index 0000000..63b6f69
--- /dev/null
+++ b/arch/arm/mach-milbeaut/Kconfig
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+menuconfig ARCH_MILBEAUT
+	bool "Socionext Milbeaut SoCs"
+	depends on ARCH_MULTI_V7
+	select ARM_GIC
+	select CLKDEV_LOOKUP
+	select GENERIC_CLOCKEVENTS
+	select CLKSRC_MMIO
+	select ZONE_DMA
+	help
+		This enables support for Socionext Milbeaut SoCs
+
+if ARCH_MILBEAUT
+
+config ARCH_MILBEAUT_M10V
+	bool "Milbeaut SC2000/M10V platform"
+	select ARM_ARCH_TIMER
+	select M10V_TIMER
+	select PINCTRL
+	select PINCTRL_M10V
+	help
+	  Support for Socionext's MILBEAUT M10V based systems
+
+config MACH_M10V_EVB
+	bool "Support for Milbeaut Evaluation boards"
+	default y
+
+endif
diff --git a/arch/arm/mach-milbeaut/Makefile b/arch/arm/mach-milbeaut/Makefile
new file mode 100644
index 0000000..64f6f52
--- /dev/null
+++ b/arch/arm/mach-milbeaut/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_SMP) += platsmp.o
+obj-$(CONFIG_MACH_M10V_EVB) += m10v_evb.o
+
diff --git a/arch/arm/mach-milbeaut/m10v_evb.c b/arch/arm/mach-milbeaut/m10v_evb.c
new file mode 100644
index 0000000..a1fa7c3
--- /dev/null
+++ b/arch/arm/mach-milbeaut/m10v_evb.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Socionext Inc.
+ * Copyright:   (C) 2015 Linaro Ltd.
+ */
+
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+static struct map_desc m10v_io_desc[] __initdata = {
+};
+
+void __init m10v_map_io(void)
+{
+	debug_ll_io_init();
+	iotable_init(m10v_io_desc, ARRAY_SIZE(m10v_io_desc));
+}
+
+static const char * const m10v_compat[] = {
+	"socionext,milbeaut-m10v-evb",
+	NULL,
+};
+
+DT_MACHINE_START(M10V_REB, "Socionext Milbeaut")
+	.dt_compat	= m10v_compat,
+	.l2c_aux_mask	= 0xffffffff,
+	.map_io		= m10v_map_io,
+MACHINE_END
diff --git a/arch/arm/mach-milbeaut/platsmp.c b/arch/arm/mach-milbeaut/platsmp.c
new file mode 100644
index 0000000..b706851
--- /dev/null
+++ b/arch/arm/mach-milbeaut/platsmp.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Socionext Inc.
+ * Copyright:	(C) 2015 Linaro Ltd.
+ */
+
+#include <linux/cpu_pm.h>
+#include <linux/irqchip/arm-gic.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/suspend.h>
+
+#include <asm/cacheflush.h>
+#include <asm/cp15.h>
+#include <asm/idmap.h>
+#include <asm/smp_plat.h>
+#include <asm/suspend.h>
+
+#define M10V_MAX_CPU	4
+
+#define KERNEL_UNBOOT_FLAG	0x12345678
+#define CPU_FINISH_SUSPEND_FLAG 0x56784321
+
+static void __iomem *trampoline;
+
+static int m10v_boot_secondary(unsigned int l_cpu, struct task_struct *idle)
+{
+	unsigned int mpidr, cpu, cluster;
+
+	mpidr = cpu_logical_map(l_cpu);
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	if (cpu >= M10V_MAX_CPU)
+		return -EINVAL;
+
+	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
+
+	writel(virt_to_phys(secondary_startup), trampoline + cpu * 4);
+	arch_send_wakeup_ipi_mask(cpumask_of(l_cpu));
+
+	return 0;
+}
+
+static void m10v_cpu_die(unsigned int l_cpu)
+{
+	gic_cpu_if_down(0);
+
+	v7_exit_coherency_flush(louis);
+
+	/* Now we are prepared for power-down, do it: */
+	wfi();
+}
+
+static int m10v_cpu_kill(unsigned int l_cpu)
+{
+	unsigned int mpidr, cpu;
+
+	mpidr = cpu_logical_map(l_cpu);
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+
+	writel(KERNEL_UNBOOT_FLAG, trampoline + cpu * 4);
+
+	return 1;
+}
+
+static struct smp_operations m10v_smp_ops __initdata = {
+	.smp_boot_secondary	= m10v_boot_secondary,
+	.cpu_die		= m10v_cpu_die,
+	.cpu_kill		= m10v_cpu_kill,
+};
+
+static int __init m10v_smp_init(void)
+{
+	unsigned int mpidr, cpu, cluster;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "socionext,milbeaut-m10v-evb");
+	if (!np || !of_device_is_available(np))
+		return -ENODEV;
+	of_node_put(np);
+
+	np = of_find_compatible_node(NULL, NULL, "socionext,smp-trampoline");
+	if (!np)
+		return -ENODEV;
+
+	trampoline = of_iomap(np, 0);
+	if (!trampoline)
+		return -ENODEV;
+	of_node_put(np);
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	pr_info("MCPM boot on cpu_%u cluster_%u\n", cpu, cluster);
+
+	for (cpu = 0; cpu < M10V_MAX_CPU; cpu++)
+		writel(KERNEL_UNBOOT_FLAG, trampoline + cpu * 4);
+
+	smp_set_ops(&m10v_smp_ops);
+
+	return 0;
+}
+early_initcall(m10v_smp_init);
+
+static int m10v_pm_valid(suspend_state_t state)
+{
+	return (state == PM_SUSPEND_STANDBY) || (state == PM_SUSPEND_MEM);
+}
+
+typedef void (*phys_reset_t)(unsigned long);
+static phys_reset_t phys_reset;
+
+static int m10v_die(unsigned long arg)
+{
+	setup_mm_for_reboot();
+	asm("wfi");
+	/* Boot just like a secondary */
+	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
+	phys_reset(virt_to_phys(cpu_resume));
+
+	return 0;
+}
+
+static int m10v_pm_enter(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		pr_err("STANDBY\n");
+		asm("wfi");
+		break;
+	case PM_SUSPEND_MEM:
+		pr_err("SUSPEND\n");
+		cpu_pm_enter();
+		cpu_suspend(0, m10v_die);
+		cpu_pm_exit();
+		break;
+	}
+	return 0;
+}
+
+static const struct platform_suspend_ops m10v_pm_ops = {
+	.valid		= m10v_pm_valid,
+	.enter		= m10v_pm_enter,
+};
+
+struct clk *m10v_clclk_register(struct device *cpu_dev);
+
+static int __init m10v_pm_init(void)
+{
+	suspend_set_ops(&m10v_pm_ops);
+
+	return 0;
+}
+late_initcall(m10v_pm_init);
-- 
1.9.1

