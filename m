Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeBWNih (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:38:37 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:48910 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbeBWNif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:38:35 -0500
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: maxime.ripard@bootlin.com, linux@armlinux.org.uk, wens@csie.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clabbe.montjoie@gmail.com,
        thomas.petazzoni@bootlin.com, mylene.josserand@bootlin.com,
        quentin.schulz@bootlin.com
Subject: [PATCH v4 03/10] ARM: sun8i: smp: Add support for A83T
Date: Fri, 23 Feb 2018 14:37:35 +0100
Message-Id: <20180223133742.26044-4-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180223133742.26044-1-mylene.josserand@bootlin.com>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support for A83T.

A83T SoC has an additional register than A80 to handle CPU configurations:
R_CPUS_CFG. Information about the register comes from Allwinner's BSP
driver.
An important difference is the Power Off Gating register for clusters
which is BIT(4) in case of SUN9I-A80 and BIT(0) in case of SUN8I-A83T.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/mach-sunxi/Kconfig  |   2 +-
 arch/arm/mach-sunxi/mc_smp.c | 168 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 162 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index ce53ceaf4cc5..a0ad35c41c02 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -51,7 +51,7 @@ config MACH_SUN9I
 config ARCH_SUNXI_MC_SMP
 	bool
 	depends on SMP
-	default MACH_SUN9I
+	default y if MACH_SUN9I || MACH_SUN8I
 	select ARM_CCI400_PORT_CTRL
 	select ARM_CPU_SUSPEND
 
diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index de02e5662557..3bd9066a1422 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -55,22 +55,32 @@
 #define CPUCFG_CX_RST_CTRL_L2_RST	BIT(8)
 #define CPUCFG_CX_RST_CTRL_CX_RST(n)	BIT(4 + (n))
 #define CPUCFG_CX_RST_CTRL_CORE_RST(n)	BIT(n)
+#define CPUCFG_CX_RST_CTRL_CORE_RST_ALL	(0xf << 0)
 
 #define PRCM_CPU_PO_RST_CTRL(c)		(0x4 + 0x4 * (c))
 #define PRCM_CPU_PO_RST_CTRL_CORE(n)	BIT(n)
 #define PRCM_CPU_PO_RST_CTRL_CORE_ALL	0xf
 #define PRCM_PWROFF_GATING_REG(c)	(0x100 + 0x4 * (c))
+/* The power off register for clusters are different from SUN9I and SUN8I */
+#define PRCM_PWROFF_GATING_REG_CLUSTER_SUN8I	BIT(0)
 #define PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I	BIT(4)
 #define PRCM_PWROFF_GATING_REG_CORE(n)	BIT(n)
 #define PRCM_PWR_SWITCH_REG(c, cpu)	(0x140 + 0x10 * (c) + 0x4 * (cpu))
 #define PRCM_CPU_SOFT_ENTRY_REG		0x164
 
+/* R_CPUCFG registers, specific to SUN8I */
+#define R_CPUCFG_CLUSTER_PO_RST_CTRL(c)	(0x30 + (c) * 0x4)
+#define R_CPUCFG_CLUSTER_PO_RST_CTRL_CORE(n)	BIT(n)
+#define R_CPUCFG_CPU_SOFT_ENTRY_REG	0x01a4
+
 #define CPU0_SUPPORT_HOTPLUG_MAGIC0	0xFA50392F
 #define CPU0_SUPPORT_HOTPLUG_MAGIC1	0x790DCA3A
 
 static void __iomem *cpucfg_base;
+static void __iomem *r_cpucfg_base;
 static void __iomem *prcm_base;
 static void __iomem *sram_b_smp_base;
+static bool is_sun9i;
 
 static bool sunxi_core_is_cortex_a15(unsigned int core, unsigned int cluster)
 {
@@ -157,6 +167,16 @@ static int sunxi_cpu_powerup(unsigned int cpu, unsigned int cluster)
 	reg &= ~PRCM_CPU_PO_RST_CTRL_CORE(cpu);
 	writel(reg, prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
 
+	if (r_cpucfg_base) {
+		/* assert cpu power-on reset */
+		reg  = readl(r_cpucfg_base +
+			     R_CPUCFG_CLUSTER_PO_RST_CTRL(cluster));
+		reg &= ~(R_CPUCFG_CLUSTER_PO_RST_CTRL_CORE(cpu));
+		writel(reg, r_cpucfg_base +
+		       R_CPUCFG_CLUSTER_PO_RST_CTRL(cluster));
+		udelay(10);
+	}
+
 	/* Cortex-A7: hold L1 reset disable signal low */
 	if (!sunxi_core_is_cortex_a15(cpu, cluster)) {
 		reg = readl(cpucfg_base + CPUCFG_CX_CTRL_REG0(cluster));
@@ -180,17 +200,37 @@ static int sunxi_cpu_powerup(unsigned int cpu, unsigned int cluster)
 	/* open power switch */
 	sunxi_cpu_power_switch_set(cpu, cluster, true);
 
+	/* Handle A83T bit swap */
+	if (!is_sun9i) {
+		if (cpu == 0)
+			cpu = 4;
+	}
+
 	/* clear processor power gate */
 	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
 	reg &= ~PRCM_PWROFF_GATING_REG_CORE(cpu);
 	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
 	udelay(20);
 
+	if (!is_sun9i) {
+		if (cpu == 4)
+			cpu = 0;
+	}
+
 	/* de-assert processor power-on reset */
 	reg = readl(prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
 	reg |= PRCM_CPU_PO_RST_CTRL_CORE(cpu);
 	writel(reg, prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
 
+	if (r_cpucfg_base) {
+		reg  = readl(r_cpucfg_base +
+			     R_CPUCFG_CLUSTER_PO_RST_CTRL(cluster));
+		reg |= R_CPUCFG_CLUSTER_PO_RST_CTRL_CORE(cpu);
+		writel(reg, r_cpucfg_base +
+		       R_CPUCFG_CLUSTER_PO_RST_CTRL(cluster));
+		udelay(10);
+	}
+
 	/* de-assert all processor resets */
 	reg = readl(cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
 	reg |= CPUCFG_CX_RST_CTRL_DBG_RST(cpu);
@@ -212,6 +252,14 @@ static int sunxi_cluster_powerup(unsigned int cluster)
 	if (cluster >= SUNXI_NR_CLUSTERS)
 		return -EINVAL;
 
+	/* For A83T, assert cluster cores resets */
+	if (!is_sun9i) {
+		reg = readl(cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
+		reg &= ~CPUCFG_CX_RST_CTRL_CORE_RST_ALL;   /* Core Reset    */
+		writel(reg, cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
+		udelay(10);
+	}
+
 	/* assert ACINACTM */
 	reg = readl(cpucfg_base + CPUCFG_CX_CTRL_REG1(cluster));
 	reg |= CPUCFG_CX_CTRL_REG1_ACINACTM;
@@ -222,6 +270,16 @@ static int sunxi_cluster_powerup(unsigned int cluster)
 	reg &= ~PRCM_CPU_PO_RST_CTRL_CORE_ALL;
 	writel(reg, prcm_base + PRCM_CPU_PO_RST_CTRL(cluster));
 
+	/* assert cluster cores resets */
+	if (r_cpucfg_base) {
+		reg  = readl(r_cpucfg_base +
+			     R_CPUCFG_CLUSTER_PO_RST_CTRL(cluster));
+		reg &= ~CPUCFG_CX_RST_CTRL_CORE_RST_ALL;
+		writel(reg, r_cpucfg_base +
+		       R_CPUCFG_CLUSTER_PO_RST_CTRL(cluster));
+		udelay(10);
+	}
+
 	/* assert cluster resets */
 	reg = readl(cpucfg_base + CPUCFG_CX_RST_CTRL(cluster));
 	reg &= ~CPUCFG_CX_RST_CTRL_DBG_SOC_RST;
@@ -252,7 +310,10 @@ static int sunxi_cluster_powerup(unsigned int cluster)
 
 	/* clear cluster power gate */
 	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
-	reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
+	if (is_sun9i)
+		reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
+	else
+		reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER_SUN8I;
 	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
 	udelay(20);
 
@@ -516,7 +577,8 @@ static int sunxi_cluster_powerdown(unsigned int cluster)
 	/* gate cluster power */
 	pr_debug("%s: gate cluster power\n", __func__);
 	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
-	reg |= PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
+	if (is_sun9i)
+		reg |= PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
 	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
 	udelay(20);
 
@@ -762,12 +824,92 @@ static void sun9i_iounmap(void)
 	iounmap(prcm_base);
 }
 
+static int sun8i_dt_parsing(struct resource res)
+{
+	struct device_node *node, *cpucfg_node;
+	int ret;
+
+	node = of_find_compatible_node(NULL, NULL,
+				       "allwinner,sun8i-a83t-r-ccu");
+	if (!node)
+		return -ENODEV;
+
+	/*
+	 * Unfortunately we can not request the I/O region for the PRCM.
+	 * It is shared with the PRCM clock.
+	 */
+	prcm_base = of_iomap(node, 0);
+	of_node_put(node);
+	if (!prcm_base) {
+		pr_err("%s: failed to map PRCM registers\n", __func__);
+		iounmap(prcm_base);
+		return -ENOMEM;
+	}
+
+	cpucfg_node = of_find_compatible_node(NULL, NULL,
+					      "allwinner,sun8i-a83t-cpucfg");
+	if (!cpucfg_node) {
+		ret = -ENODEV;
+		pr_err("%s: CPUCFG not available\n", __func__);
+		goto err_unmap_prcm;
+	}
+
+	cpucfg_base = of_io_request_and_map(cpucfg_node, 0, "sunxi-mc-smp");
+	if (IS_ERR(cpucfg_base)) {
+		ret = PTR_ERR(cpucfg_base);
+		pr_err("%s: failed to map CPUCFG registers: %d\n",
+		       __func__, ret);
+		goto err_put_cpucfg_node;
+	}
+
+	node = of_find_compatible_node(NULL, NULL,
+				       "allwinner,sun8i-a83t-r-cpucfg");
+	if (!node) {
+		ret = -ENODEV;
+		goto err_unmap_release_cpucfg;
+	}
+
+	r_cpucfg_base = of_iomap(node, 0);
+	if (!r_cpucfg_base) {
+		pr_err("%s: failed to map R-CPUCFG registers\n",
+		       __func__);
+		ret = -ENOMEM;
+		goto err_put_node;
+	}
+
+	/* We don't need the CPUCFG device node anymore */
+	of_node_put(cpucfg_node);
+	of_node_put(node);
+
+	return 0;
+err_put_node:
+	of_node_put(node);
+err_unmap_release_cpucfg:
+	iounmap(cpucfg_base);
+	of_address_to_resource(cpucfg_node, 0, &res);
+	release_mem_region(res.start, resource_size(&res));
+err_put_cpucfg_node:
+	of_node_put(cpucfg_node);
+err_unmap_prcm:
+	iounmap(prcm_base);
+
+	return ret;
+}
+
+static void sun8i_iounmap(void)
+{
+	iounmap(r_cpucfg_base);
+	iounmap(cpucfg_base);
+	iounmap(prcm_base);
+}
+
 static int __init sunxi_mc_smp_init(void)
 {
 	struct resource res;
 	int ret;
 
-	if (!of_machine_is_compatible("allwinner,sun9i-a80"))
+	if (!of_machine_is_compatible("allwinner,sun9i-a80") &&
+	    !of_machine_is_compatible("allwinner,sun8i-a83t"))
 		return -ENODEV;
 
 	if (!sunxi_mc_smp_cpu_table_init())
@@ -778,7 +920,12 @@ static int __init sunxi_mc_smp_init(void)
 		return -ENODEV;
 	}
 
-	ret = sun9i_dt_parsing(res);
+	is_sun9i = of_machine_is_compatible("allwinner,sun9i-a80");
+
+	if (is_sun9i)
+		ret = sun9i_dt_parsing(res);
+	else
+		ret = sun8i_dt_parsing(res);
 	if (ret) {
 		pr_err("%s: failed to parse DT: %d\n", __func__, ret);
 		return ret;
@@ -789,13 +936,20 @@ static int __init sunxi_mc_smp_init(void)
 	if (ret) {
 		pr_err("%s: failed to configure boot cluster: %d\n",
 		       __func__, ret);
-		sun9i_iounmap();
+		if (is_sun9i)
+			sun9i_iounmap();
+		else
+			sun8i_iounmap();
 		return ret;
 	}
 
 	/* Set the hardware entry point address */
-	writel(__pa_symbol(sunxi_mc_smp_secondary_startup),
-	       prcm_base + PRCM_CPU_SOFT_ENTRY_REG);
+	if (is_sun9i)
+		writel(__pa_symbol(sunxi_mc_smp_secondary_startup),
+		       prcm_base + PRCM_CPU_SOFT_ENTRY_REG);
+	else
+		writel(__pa_symbol(sunxi_mc_smp_secondary_startup),
+		       r_cpucfg_base + R_CPUCFG_CPU_SOFT_ENTRY_REG);
 
 	/* Actually enable multi cluster SMP */
 	smp_set_ops(&sunxi_mc_smp_smp_ops);
-- 
2.11.0
