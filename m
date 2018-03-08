Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933774AbeCHPBr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:01:47 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:47266 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751991AbeCHPA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:00:28 -0500
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Mylene Josserand <mylene.josserand@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 4/4] ARM: sunxi: mc-smp: Split out SoC-specific device node lookup sequence
Date: Thu,  8 Mar 2018 23:00:12 +0800
Message-Id: <20180308150012.19045-5-wens@csie.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180308150012.19045-1-wens@csie.org>
References: <20180308150012.19045-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The multi-cluster SMP code maps the address spaces of several hardware
control blocks. The device nodes for them are SoC-specific. To help with
supporting other SoCs to re-use this code, these bits should be split
out to a separate function tied to the enable-method string.

This patch splits out and groups the device node lookup sequence, and
adds new data structures to have the newly created function tied to
the enable method string. This structure can also be used to encode
other differences between the SoCs.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Hi Mylene,

I suggest you use this patch as a start, and add the A83T specific bits
accordingly, such as handling the r_cpucfg node in the new *_nodes code,
and adding an "is_sun9i" field to sunxi_mc_smp_data. It should be better
than what you already have.

---
 arch/arm/mach-sunxi/mc_smp.c | 126 +++++++++++++++++++++++++++++--------------
 1 file changed, 86 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 86e90b038555..c0246ec54a0a 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -684,11 +684,69 @@ static int __init sunxi_mc_smp_loopback(void)
 	return ret;
 }
 
+/*
+ * This holds any device nodes that we requested resources for,
+ * so that we may easily release resources in the error path.
+ */
+struct sunxi_mc_smp_nodes {
+	struct device_node *prcm_node;
+	struct device_node *cpucfg_node;
+	struct device_node *sram_node;
+};
+
+/* This structure holds SoC-specific bits tied to an enable-method string. */
+struct sunxi_mc_smp_data {
+	const char *enable_method;
+	int (*get_smp_nodes)(struct sunxi_mc_smp_nodes *nodes);
+};
+
+static void __init sunxi_mc_smp_put_nodes(struct sunxi_mc_smp_nodes *nodes)
+{
+	of_node_put(nodes->prcm_node);
+	of_node_put(nodes->cpucfg_node);
+	of_node_put(nodes->sram_node);
+	memset(nodes, 0, sizeof(*nodes));
+}
+
+static int __init sun9i_a80_get_smp_nodes(struct sunxi_mc_smp_nodes *nodes)
+{
+	nodes->prcm_node = of_find_compatible_node(NULL, NULL,
+						   "allwinner,sun9i-a80-prcm");
+	if (!nodes->prcm_node) {
+		pr_err("%s: PRCM not available\n", __func__);
+		return -ENODEV;
+	}
+
+	nodes->cpucfg_node = of_find_compatible_node(NULL, NULL,
+						     "allwinner,sun9i-a80-cpucfg");
+	if (!nodes->cpucfg_node) {
+		pr_err("%s: CPUCFG not available\n", __func__);
+		return -ENODEV;
+	}
+
+	nodes->sram_node = of_find_compatible_node(NULL, NULL,
+						   "allwinner,sun9i-a80-smp-sram");
+	if (!nodes->sram_node) {
+		pr_err("%s: Secure SRAM not available\n", __func__);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static const struct sunxi_mc_smp_data sunxi_mc_smp_data[] __initconst = {
+	{
+		.enable_method	= "allwinner,sun9i-a80-smp",
+		.get_smp_nodes	= sun9i_a80_get_smp_nodes,
+	},
+};
+
 static int __init sunxi_mc_smp_init(void)
 {
-	struct device_node *cpucfg_node, *sram_node, *node;
+	struct sunxi_mc_smp_nodes nodes = { 0 };
+	struct device_node *node;
 	struct resource res;
-	int ret;
+	int i, ret;
 
 	/*
 	 * Don't bother checking the "cpus" node, as an enable-method
@@ -706,8 +764,13 @@ static int __init sunxi_mc_smp_init(void)
 	 * callbacks in smp_operations, which we would use if we were to
 	 * use CPU_METHOD_OF_DECLARE
 	 */
-	ret = of_property_match_string(node, "enable-method",
-				       "allwinner,sun9i-a80-smp");
+	for (i = 0; i < ARRAY_SIZE(sunxi_mc_smp_data); i++) {
+		ret = of_property_match_string(node, "enable-method",
+					       sunxi_mc_smp_data[i].enable_method);
+		if (!ret)
+			break;
+	}
+
 	of_node_put(node);
 	if (ret)
 		return -ENODEV;
@@ -720,51 +783,37 @@ static int __init sunxi_mc_smp_init(void)
 		return -ENODEV;
 	}
 
-	node = of_find_compatible_node(NULL, NULL, "allwinner,sun9i-a80-prcm");
-	if (!node) {
-		pr_err("%s: PRCM not available\n", __func__);
-		return -ENODEV;
-	}
+	/* Get needed device tree nodes */
+	ret = sunxi_mc_smp_data[i].get_smp_nodes(&nodes);
+	if (ret)
+		goto err_put_nodes;
 
 	/*
 	 * Unfortunately we can not request the I/O region for the PRCM.
 	 * It is shared with the PRCM clock.
 	 */
-	prcm_base = of_iomap(node, 0);
-	of_node_put(node);
+	prcm_base = of_iomap(nodes.prcm_node, 0);
 	if (!prcm_base) {
 		pr_err("%s: failed to map PRCM registers\n", __func__);
-		return -ENOMEM;
-	}
-
-	cpucfg_node = of_find_compatible_node(NULL, NULL,
-					      "allwinner,sun9i-a80-cpucfg");
-	if (!cpucfg_node) {
-		ret = -ENODEV;
-		pr_err("%s: CPUCFG not available\n", __func__);
-		goto err_unmap_prcm;
+		ret = -ENOMEM;
+		goto err_put_nodes;
 	}
 
-	cpucfg_base = of_io_request_and_map(cpucfg_node, 0, "sunxi-mc-smp");
+	cpucfg_base = of_io_request_and_map(nodes.cpucfg_node, 0,
+					    "sunxi-mc-smp");
 	if (IS_ERR(cpucfg_base)) {
 		ret = PTR_ERR(cpucfg_base);
 		pr_err("%s: failed to map CPUCFG registers: %d\n",
 		       __func__, ret);
-		goto err_put_cpucfg_node;
-	}
-
-	sram_node = of_find_compatible_node(NULL, NULL,
-					    "allwinner,sun9i-a80-smp-sram");
-	if (!sram_node) {
-		ret = -ENODEV;
-		goto err_unmap_release_cpucfg;
+		goto err_unmap_prcm;
 	}
 
-	sram_b_smp_base = of_io_request_and_map(sram_node, 0, "sunxi-mc-smp");
+	sram_b_smp_base = of_io_request_and_map(nodes.sram_node, 0,
+						"sunxi-mc-smp");
 	if (IS_ERR(sram_b_smp_base)) {
 		ret = PTR_ERR(sram_b_smp_base);
 		pr_err("%s: failed to map secure SRAM\n", __func__);
-		goto err_put_sram_node;
+		goto err_unmap_release_cpucfg;
 	}
 
 	/* Configure CCI-400 for boot cluster */
@@ -775,9 +824,8 @@ static int __init sunxi_mc_smp_init(void)
 		goto err_unmap_release_secure_sram;
 	}
 
-	/* We don't need the CPUCFG and SRAM device nodes anymore */
-	of_node_put(cpucfg_node);
-	of_node_put(sram_node);
+	/* We don't need the device nodes anymore */
+	sunxi_mc_smp_put_nodes(&nodes);
 
 	/* Set the hardware entry point address */
 	writel(__pa_symbol(sunxi_mc_smp_secondary_startup),
@@ -792,18 +840,16 @@ static int __init sunxi_mc_smp_init(void)
 
 err_unmap_release_secure_sram:
 	iounmap(sram_b_smp_base);
-	of_address_to_resource(sram_node, 0, &res);
+	of_address_to_resource(nodes.sram_node, 0, &res);
 	release_mem_region(res.start, resource_size(&res));
-err_put_sram_node:
-	of_node_put(sram_node);
 err_unmap_release_cpucfg:
 	iounmap(cpucfg_base);
-	of_address_to_resource(cpucfg_node, 0, &res);
+	of_address_to_resource(nodes.cpucfg_node, 0, &res);
 	release_mem_region(res.start, resource_size(&res));
-err_put_cpucfg_node:
-	of_node_put(cpucfg_node);
 err_unmap_prcm:
 	iounmap(prcm_base);
+err_put_nodes:
+	sunxi_mc_smp_put_nodes(&nodes);
 	return ret;
 }
 
-- 
2.16.2
