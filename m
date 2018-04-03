Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755110AbeDCGVm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 02:21:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34669 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754980AbeDCGVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 02:21:07 -0400
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, thomas.petazzoni@bootlin.com,
        mylene.josserand@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/13] ARM: sun9i: smp: Add is_sun9i field
Date: Tue,  3 Apr 2018 08:18:34 +0200
Message-Id: <20180403061836.3926-12-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180403061836.3926-1-mylene.josserand@bootlin.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare the support of sun8i-a83t, add a field in the smp_data
structure to enable the case of sun9i.

Start to handle the differences between sun9i-a80 and sun8i-a83t
by using this variable.
Add an index to retrieve which structures we are using.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/mach-sunxi/mc_smp.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 0a7252df207f..468a6c46bfc9 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -71,6 +71,7 @@
 static void __iomem *cpucfg_base;
 static void __iomem *prcm_base;
 static void __iomem *sram_b_smp_base;
+static int index;
 
 /*
  * This holds any device nodes that we requested resources for,
@@ -86,6 +87,7 @@ struct sunxi_mc_smp_nodes {
 struct sunxi_mc_smp_data {
 	const char *enable_method;
 	int (*get_smp_nodes)(struct sunxi_mc_smp_nodes *nodes);
+	int is_sun9i;
 };
 
 extern void sunxi_mc_smp_secondary_startup(void);
@@ -97,6 +99,7 @@ static const struct sunxi_mc_smp_data sunxi_mc_smp_data[] __initconst = {
 	{
 		.enable_method	= "allwinner,sun9i-a80-smp",
 		.get_smp_nodes	= sun9i_a80_get_smp_nodes,
+		.is_sun9i	= true,
 	},
 };
 
@@ -280,7 +283,8 @@ static int sunxi_cluster_powerup(unsigned int cluster)
 
 	/* clear cluster power gate */
 	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
-	reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
+	if (sunxi_mc_smp_data[index].is_sun9i)
+		reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
 	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
 	udelay(20);
 
@@ -477,7 +481,8 @@ static int sunxi_cluster_powerdown(unsigned int cluster)
 	/* gate cluster power */
 	pr_debug("%s: gate cluster power\n", __func__);
 	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
-	reg |= PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
+	if (sunxi_mc_smp_data[index].is_sun9i)
+		reg |= PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
 	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
 	udelay(20);
 
@@ -675,6 +680,7 @@ static int __init sunxi_mc_smp_init(void)
 	struct device_node *node;
 	struct resource res;
 	int i, ret;
+	void __iomem *addr;
 
 	/*
 	 * Don't bother checking the "cpus" node, as an enable-method
@@ -699,6 +705,8 @@ static int __init sunxi_mc_smp_init(void)
 			break;
 	}
 
+	index = i;
+
 	of_node_put(node);
 	if (ret)
 		return -ENODEV;
@@ -736,12 +744,14 @@ static int __init sunxi_mc_smp_init(void)
 		goto err_unmap_prcm;
 	}
 
-	sram_b_smp_base = of_io_request_and_map(nodes.sram_node, 0,
-						"sunxi-mc-smp");
-	if (IS_ERR(sram_b_smp_base)) {
-		ret = PTR_ERR(sram_b_smp_base);
-		pr_err("%s: failed to map secure SRAM\n", __func__);
-		goto err_unmap_release_cpucfg;
+	if (sunxi_mc_smp_data[index].is_sun9i) {
+		sram_b_smp_base = of_io_request_and_map(nodes.sram_node, 0,
+							"sunxi-mc-smp");
+		if (IS_ERR(sram_b_smp_base)) {
+			ret = PTR_ERR(sram_b_smp_base);
+			pr_err("%s: failed to map secure SRAM\n", __func__);
+			goto err_unmap_release_cpucfg;
+		}
 	}
 
 	/* Configure CCI-400 for boot cluster */
@@ -756,8 +766,9 @@ static int __init sunxi_mc_smp_init(void)
 	sunxi_mc_smp_put_nodes(&nodes);
 
 	/* Set the hardware entry point address */
-	writel(__pa_symbol(sunxi_mc_smp_secondary_startup),
-	       prcm_base + PRCM_CPU_SOFT_ENTRY_REG);
+	if (sunxi_mc_smp_data[index].is_sun9i)
+		addr = prcm_base + PRCM_CPU_SOFT_ENTRY_REG;
+	writel(__pa_symbol(sunxi_mc_smp_secondary_startup), addr);
 
 	/* Actually enable multi cluster SMP */
 	smp_set_ops(&sunxi_mc_smp_smp_ops);
@@ -767,8 +778,10 @@ static int __init sunxi_mc_smp_init(void)
 	return 0;
 
 err_unmap_release_secure_sram:
-	iounmap(sram_b_smp_base);
-	of_address_to_resource(nodes.sram_node, 0, &res);
+	if (sunxi_mc_smp_data[index].is_sun9i) {
+		iounmap(sram_b_smp_base);
+		of_address_to_resource(nodes.sram_node, 0, &res);
+	}
 	release_mem_region(res.start, resource_size(&res));
 err_unmap_release_cpucfg:
 	iounmap(cpucfg_base);
-- 
2.11.0
