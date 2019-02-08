Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B4DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342CB20663
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfBHMZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:25:37 -0500
Received: from mx.socionext.com ([202.248.49.38]:27751 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbfBHMZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:25:37 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 Feb 2019 21:25:35 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 6FBE160062;
        Fri,  8 Feb 2019 21:25:35 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 8 Feb 2019 21:25:35 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 498921A04E1;
        Fri,  8 Feb 2019 21:25:35 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 2E5511202F1;
        Fri,  8 Feb 2019 21:25:35 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH v2 04/15] ARM: milbeaut: Add basic support for Milbeaut m10v SoC
Date:   Fri,  8 Feb 2019 21:26:18 +0900
Message-Id: <1549628778-30785-1-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the basic M10V SoC support under arch/arm.
Since all cores are activated in the custom bootloader before booting
linux, it is necessary to wait for the secondary-cores using cpu-enable-
method and special sram.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 arch/arm/Kconfig                 |   2 +
 arch/arm/Makefile                |   1 +
 arch/arm/mach-milbeaut/Kconfig   |  20 ++++++
 arch/arm/mach-milbeaut/Makefile  |   1 +
 arch/arm/mach-milbeaut/platsmp.c | 144 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 168 insertions(+)
 create mode 100644 arch/arm/mach-milbeaut/Kconfig
 create mode 100644 arch/arm/mach-milbeaut/Makefile
 create mode 100644 arch/arm/mach-milbeaut/platsmp.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918..c8cb752 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -750,6 +750,8 @@ source "arch/arm/mach-mediatek/Kconfig"
 
 source "arch/arm/mach-meson/Kconfig"
 
+source "arch/arm/mach-milbeaut/Kconfig"
+
 source "arch/arm/mach-mmp/Kconfig"
 
 source "arch/arm/mach-moxart/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 9db3c58..00000e9 100644
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
index 0000000..6a576fd
--- /dev/null
+++ b/arch/arm/mach-milbeaut/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+menuconfig ARCH_MILBEAUT
+	bool "Socionext Milbeaut SoCs"
+	depends on ARCH_MULTI_V7
+	select ARM_GIC
+	help
+	  This enables support for Socionext Milbeaut SoCs
+
+if ARCH_MILBEAUT
+
+config ARCH_MILBEAUT_M10V
+	bool "Milbeaut SC2000/M10V platform"
+	select ARM_ARCH_TIMER
+	select MILBEAUT_TIMER
+	select PINCTRL
+	select PINCTRL_MILBEAUT
+	help
+	  Support for Socionext's MILBEAUT M10V based systems
+
+endif
diff --git a/arch/arm/mach-milbeaut/Makefile b/arch/arm/mach-milbeaut/Makefile
new file mode 100644
index 0000000..ce5ea06
--- /dev/null
+++ b/arch/arm/mach-milbeaut/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SMP) += platsmp.o
diff --git a/arch/arm/mach-milbeaut/platsmp.c b/arch/arm/mach-milbeaut/platsmp.c
new file mode 100644
index 0000000..bdcd98e
--- /dev/null
+++ b/arch/arm/mach-milbeaut/platsmp.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright:	(C) 2018 Socionext Inc.
+ * Copyright:	(C) 2015 Linaro Ltd.
+ */
+
+#include <linux/cpu_pm.h>
+#include <linux/irqchip/arm-gic.h>
+#include <linux/of_address.h>
+#include <linux/suspend.h>
+
+#include <asm/cacheflush.h>
+#include <asm/cp15.h>
+#include <asm/idmap.h>
+#include <asm/smp_plat.h>
+#include <asm/suspend.h>
+
+#define M10V_MAX_CPU	4
+#define KERNEL_UNBOOT_FLAG	0x12345678
+
+static void __iomem *m10v_smp_base;
+
+static int m10v_boot_secondary(unsigned int l_cpu, struct task_struct *idle)
+{
+	unsigned int mpidr, cpu, cluster;
+
+	if (!m10v_smp_base)
+		return -ENXIO;
+
+	mpidr = cpu_logical_map(l_cpu);
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+
+	if (cpu >= M10V_MAX_CPU)
+		return -EINVAL;
+
+	pr_info("%s: cpu %u l_cpu %u cluster %u\n",
+			__func__, cpu, l_cpu, cluster);
+
+	writel(__pa_symbol(secondary_startup), m10v_smp_base + cpu * 4);
+	arch_send_wakeup_ipi_mask(cpumask_of(l_cpu));
+
+	return 0;
+}
+
+static void m10v_smp_init(unsigned int max_cpus)
+{
+	unsigned int mpidr, cpu, cluster;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "socionext,milbeaut-smp-sram");
+	if (!np)
+		return;
+
+	m10v_smp_base = of_iomap(np, 0);
+	if (!m10v_smp_base)
+		return;
+
+	mpidr = read_cpuid_mpidr();
+	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
+	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
+	pr_info("MCPM boot on cpu_%u cluster_%u\n", cpu, cluster);
+
+	for (cpu = 0; cpu < M10V_MAX_CPU; cpu++)
+		writel(KERNEL_UNBOOT_FLAG, m10v_smp_base + cpu * 4);
+}
+
+static void m10v_cpu_die(unsigned int l_cpu)
+{
+	gic_cpu_if_down(0);
+	v7_exit_coherency_flush(louis);
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
+	writel(KERNEL_UNBOOT_FLAG, m10v_smp_base + cpu * 4);
+
+	return 1;
+}
+
+static struct smp_operations m10v_smp_ops __initdata = {
+	.smp_prepare_cpus	= m10v_smp_init,
+	.smp_boot_secondary	= m10v_boot_secondary,
+	.cpu_die		= m10v_cpu_die,
+	.cpu_kill		= m10v_cpu_kill,
+};
+CPU_METHOD_OF_DECLARE(m10v_smp, "socionext,milbeaut-m10v-smp", &m10v_smp_ops);
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

