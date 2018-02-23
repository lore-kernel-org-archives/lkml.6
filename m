Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeBWNqT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:46:19 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:48885 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbeBWNid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:38:33 -0500
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: maxime.ripard@bootlin.com, linux@armlinux.org.uk, wens@csie.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clabbe.montjoie@gmail.com,
        thomas.petazzoni@bootlin.com, mylene.josserand@bootlin.com,
        quentin.schulz@bootlin.com
Subject: [PATCH v4 01/10] ARM: sun9i: smp: Add sun9i dt parsing function
Date: Fri, 23 Feb 2018 14:37:33 +0100
Message-Id: <20180223133742.26044-2-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180223133742.26044-1-mylene.josserand@bootlin.com>
References: <20180223133742.26044-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare the support for sun8i-a83t, create a new function
that handles all the resources needed on sun9i-a80 (because
it will be different from sun8i-a83t).

All the parsing of device tree is moved into this new function:
sun9i_dt_parsing. Create also a function to release the resources
retrieved during the dt parsing in case there is an error in init
function.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/mach-sunxi/mc_smp.c | 99 ++++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 11e46c6efb90..650a2ad4398f 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -684,35 +684,22 @@ static int __init sunxi_mc_smp_lookback(void)
 	return ret;
 }
 
-static int __init sunxi_mc_smp_init(void)
+static int sun9i_dt_parsing(struct resource res)
 {
-	struct device_node *cpucfg_node, *sram_node, *node;
-	struct resource res;
+	struct device_node *prcm_node, *cpucfg_node, *sram_node;
 	int ret;
 
-	if (!of_machine_is_compatible("allwinner,sun9i-a80"))
-		return -ENODEV;
-
-	if (!sunxi_mc_smp_cpu_table_init())
-		return -EINVAL;
-
-	if (!cci_probed()) {
-		pr_err("%s: CCI-400 not available\n", __func__);
-		return -ENODEV;
-	}
-
-	node = of_find_compatible_node(NULL, NULL, "allwinner,sun9i-a80-prcm");
-	if (!node) {
-		pr_err("%s: PRCM not available\n", __func__);
+	prcm_node = of_find_compatible_node(NULL, NULL,
+				       "allwinner,sun9i-a80-prcm");
+	if (!prcm_node)
 		return -ENODEV;
-	}
 
 	/*
 	 * Unfortunately we can not request the I/O region for the PRCM.
 	 * It is shared with the PRCM clock.
 	 */
-	prcm_base = of_iomap(node, 0);
-	of_node_put(node);
+	prcm_base = of_iomap(prcm_node, 0);
+	of_node_put(prcm_node);
 	if (!prcm_base) {
 		pr_err("%s: failed to map PRCM registers\n", __func__);
 		return -ENOMEM;
@@ -748,33 +735,12 @@ static int __init sunxi_mc_smp_init(void)
 		goto err_put_sram_node;
 	}
 
-	/* Configure CCI-400 for boot cluster */
-	ret = sunxi_mc_smp_lookback();
-	if (ret) {
-		pr_err("%s: failed to configure boot cluster: %d\n",
-		       __func__, ret);
-		goto err_unmap_release_secure_sram;
-	}
-
 	/* We don't need the CPUCFG and SRAM device nodes anymore */
 	of_node_put(cpucfg_node);
 	of_node_put(sram_node);
 
-	/* Set the hardware entry point address */
-	writel(__pa_symbol(sunxi_mc_smp_secondary_startup),
-	       prcm_base + PRCM_CPU_SOFT_ENTRY_REG);
-
-	/* Actually enable multi cluster SMP */
-	smp_set_ops(&sunxi_mc_smp_smp_ops);
-
-	pr_info("sunxi multi cluster SMP support installed\n");
-
 	return 0;
 
-err_unmap_release_secure_sram:
-	iounmap(sram_b_smp_base);
-	of_address_to_resource(sram_node, 0, &res);
-	release_mem_region(res.start, resource_size(&res));
 err_put_sram_node:
 	of_node_put(sram_node);
 err_unmap_release_cpucfg:
@@ -785,6 +751,57 @@ static int __init sunxi_mc_smp_init(void)
 	of_node_put(cpucfg_node);
 err_unmap_prcm:
 	iounmap(prcm_base);
+
+	return ret;
+}
+
+static void sun9i_iounmap(void)
+{
+	iounmap(sram_b_smp_base);
+	iounmap(cpucfg_base);
+	iounmap(prcm_base);
+}
+
+static int __init sunxi_mc_smp_init(void)
+{
+	struct resource res;
+	int ret;
+
+	if (!of_machine_is_compatible("allwinner,sun9i-a80"))
+		return -ENODEV;
+
+	if (!sunxi_mc_smp_cpu_table_init())
+		return -EINVAL;
+
+	if (!cci_probed()) {
+		pr_err("%s: CCI-400 not available\n", __func__);
+		return -ENODEV;
+	}
+
+	ret = sun9i_dt_parsing(res);
+	if (ret) {
+		pr_err("%s: failed to parse DT: %d\n", __func__, ret);
+		return ret;
+	}
+
+	/* Configure CCI-400 for boot cluster */
+	ret = sunxi_mc_smp_lookback();
+	if (ret) {
+		pr_err("%s: failed to configure boot cluster: %d\n",
+		       __func__, ret);
+		sun9i_iounmap();
+		return ret;
+	}
+
+	/* Set the hardware entry point address */
+	writel(__pa_symbol(sunxi_mc_smp_secondary_startup),
+	       prcm_base + PRCM_CPU_SOFT_ENTRY_REG);
+
+	/* Actually enable multi cluster SMP */
+	smp_set_ops(&sunxi_mc_smp_smp_ops);
+
+	pr_info("sunxi multi cluster SMP support installed\n");
+
 	return ret;
 }
 
-- 
2.11.0
