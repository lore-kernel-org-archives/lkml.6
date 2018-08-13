Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC672C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999AD2177D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999AD2177D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbeHMJWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:22:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:31382 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbeHMJWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:22:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2018 23:42:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,232,1531810800"; 
   d="scan'208";a="82877911"
Received: from ubuntu.png.intel.com ([10.226.248.83])
  by orsmga002.jf.intel.com with ESMTP; 12 Aug 2018 23:41:51 -0700
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ong Hean Loong <hean.loong.ong@intel.com>,
        Yves Vandervennet <yves.vandervennet@intel.com>,
        Joyce Ooi <joyce.ooi@intel.com>
Subject: [PATCH] net: stmmac: Add SMC support for EMAC System Manager register
Date:   Sun, 12 Aug 2018 23:41:34 -0700
Message-Id: <1534142494-11541-1-git-send-email-joyce.ooi@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there is restriction to access to EMAC System Manager registers in
the kernel for Intel Stratix10, the use of SMC calls are required and
added in dwmac-socfpga driver.

Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
---
This patch is dependent on https://lkml.org/lkml/2018/7/26/624
---
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   74 +++++++++++++++++++-
 1 files changed, 73 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index c3a78c1..2cea97d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -23,6 +23,9 @@
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/stmmac.h>
+#ifdef CONFIG_HAVE_ARM_SMCCC
+#include <linux/stratix10-smc.h>
+#endif
 
 #include "stmmac.h"
 #include "stmmac_platform.h"
@@ -52,6 +55,7 @@ struct socfpga_dwmac {
 	int	interface;
 	u32	reg_offset;
 	u32	reg_shift;
+	u32	sysmgr_reg;
 	struct	device *dev;
 	struct regmap *sys_mgr_base_addr;
 	struct reset_control *stmmac_rst;
@@ -61,6 +65,48 @@ struct socfpga_dwmac {
 	struct tse_pcs pcs;
 };
 
+#ifdef CONFIG_HAVE_ARM_SMCCC
+/**************** Stratix 10 EMAC Memory Controller Functions ************/
+
+/* s10_protected_reg_write
+ * Write to a protected SMC register.
+ * @reg: Address of register
+ * @value: Value to write
+ * Return: INTEL_SIP_SMC_STATUS_OK (0) on success
+ *         INTEL_SIP_SMC_REG_ERROR on error
+ *         INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION if not supported
+ */
+static int s10_protected_reg_write(unsigned int reg, unsigned int val)
+{
+	struct arm_smccc_res result;
+
+	arm_smccc_smc(INTEL_SIP_SMC_REG_WRITE, reg, val, 0, 0,
+		      0, 0, 0, &result);
+
+	return (int)result.a0;
+}
+
+/* s10_protected_reg_read
+ * Read the status of a protected SMC register
+ * @reg: Address of register
+ * @value: Value read.
+ * Return: INTEL_SIP_SMC_STATUS_OK (0) on success
+ *         INTEL_SIP_SMC_REG_ERROR on error
+ *         INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION if not supported
+ */
+static int s10_protected_reg_read(unsigned int reg, unsigned int *val)
+{
+	struct arm_smccc_res result;
+
+	arm_smccc_smc(INTEL_SIP_SMC_REG_READ, reg, 0, 0, 0,
+		      0, 0, 0, &result);
+
+	*val = (unsigned int)result.a1;
+
+	return (int)result.a0;
+}
+#endif
+
 static void socfpga_dwmac_fix_mac_speed(void *priv, unsigned int speed)
 {
 	struct socfpga_dwmac *dwmac = (struct socfpga_dwmac *)priv;
@@ -104,10 +150,11 @@ static int socfpga_dwmac_parse_data(struct socfpga_dwmac *dwmac, struct device *
 {
 	struct device_node *np = dev->of_node;
 	struct regmap *sys_mgr_base_addr;
-	u32 reg_offset, reg_shift;
+	u32 reg_offset, reg_shift, sysmgr_reg;
 	int ret, index;
 	struct device_node *np_splitter = NULL;
 	struct device_node *np_sgmii_adapter = NULL;
+	struct device_node *np_sysmgr = NULL;
 	struct resource res_splitter;
 	struct resource res_tse_pcs;
 	struct resource res_sgmii_adapter;
@@ -132,6 +179,16 @@ static int socfpga_dwmac_parse_data(struct socfpga_dwmac *dwmac, struct device *
 		return -EINVAL;
 	}
 
+	np_sysmgr = of_parse_phandle(np, "altr,sysmgr-syscon", 0);
+	if (np_sysmgr) {
+		ret = of_property_read_u32_index(np_sysmgr, "reg", 0,
+						 &sysmgr_reg);
+		if (ret) {
+			dev_info(dev, "Could not read sysmgr register address\n");
+			return -EINVAL;
+		}
+	}
+
 	dwmac->f2h_ptp_ref_clk = of_property_read_bool(np, "altr,f2h_ptp_ref_clk");
 
 	np_splitter = of_parse_phandle(np, "altr,emac-splitter", 0);
@@ -221,6 +278,7 @@ static int socfpga_dwmac_parse_data(struct socfpga_dwmac *dwmac, struct device *
 	}
 	dwmac->reg_offset = reg_offset;
 	dwmac->reg_shift = reg_shift;
+	dwmac->sysmgr_reg = sysmgr_reg;
 	dwmac->sys_mgr_base_addr = sys_mgr_base_addr;
 	dwmac->dev = dev;
 	of_node_put(np_sgmii_adapter);
@@ -238,7 +296,9 @@ static int socfpga_dwmac_set_phy_mode(struct socfpga_dwmac *dwmac)
 	int phymode = dwmac->interface;
 	u32 reg_offset = dwmac->reg_offset;
 	u32 reg_shift = dwmac->reg_shift;
+	u32 sysmgr_reg = dwmac->sysmgr_reg;
 	u32 ctrl, val, module;
+	int ret = 0;
 
 	switch (phymode) {
 	case PHY_INTERFACE_MODE_RGMII:
@@ -266,7 +326,13 @@ static int socfpga_dwmac_set_phy_mode(struct socfpga_dwmac *dwmac)
 	reset_control_assert(dwmac->stmmac_ocp_rst);
 	reset_control_assert(dwmac->stmmac_rst);
 
+#ifdef CONFIG_HAVE_ARM_SMCCC
+	ret = s10_protected_reg_read(sysmgr_reg + reg_offset, &ctrl);
+	if (ret)
+		dev_err(dwmac->dev, "error reading Sys Mgr %d\n", ret);
+#else
 	regmap_read(sys_mgr_base_addr, reg_offset, &ctrl);
+#endif
 	ctrl &= ~(SYSMGR_EMACGRP_CTRL_PHYSEL_MASK << reg_shift);
 	ctrl |= val << reg_shift;
 
@@ -281,7 +347,13 @@ static int socfpga_dwmac_set_phy_mode(struct socfpga_dwmac *dwmac)
 		ctrl &= ~(SYSMGR_EMACGRP_CTRL_PTP_REF_CLK_MASK << (reg_shift / 2));
 	}
 
+#ifdef CONFIG_HAVE_ARM_SMCCC
+	ret = s10_protected_reg_write(sysmgr_reg + reg_offset, ctrl);
+	if (ret)
+		dev_err(dwmac->dev, "error writing Sys Mgr %d\n", ret);
+#else
 	regmap_write(sys_mgr_base_addr, reg_offset, ctrl);
+#endif
 
 	/* Deassert reset for the phy configuration to be sampled by
 	 * the enet controller, and operation to start in requested mode
-- 
1.7.1

