Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4368CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A87721773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbfBLQZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:25:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:56746 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfBLQZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:25:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 08:25:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="318387067"
Received: from joyceboo-mobl4.gar.corp.intel.com (HELO ubuntu.localdomain) ([10.255.147.184])
  by fmsmga006.fm.intel.com with ESMTP; 12 Feb 2019 08:25:05 -0800
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        See Chin Liang <chin.liang.see@intel.com>,
        Joyce Ooi <joyce.ooi@intel.com>
Subject: [PATCH] net: stmmac: Add SMC support for EMAC System Manager register
Date:   Tue, 12 Feb 2019 08:24:52 -0800
Message-Id: <1549988692-4124-1-git-send-email-joyce.ooi@intel.com>
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
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |  101 ++++++++++++++++++++
 1 files changed, 101 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 5b3b06a..55cce97 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -15,6 +15,10 @@
  * Adopted from dwmac-sti.c
  */
 
+#if defined CONFIG_HAVE_ARM_SMCCC && defined CONFIG_ARCH_STRATIX10
+#include <linux/arm-smccc.h>
+#include <linux/firmware/intel/stratix10-smc.h>
+#endif
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -52,6 +56,9 @@ struct socfpga_dwmac {
 	int	interface;
 	u32	reg_offset;
 	u32	reg_shift;
+#if defined CONFIG_HAVE_ARM_SMCCC && defined CONFIG_ARCH_STRATIX10
+	u32	sysmgr_reg;
+#endif
 	struct	device *dev;
 	struct regmap *sys_mgr_base_addr;
 	struct reset_control *stmmac_rst;
@@ -61,6 +68,63 @@ struct socfpga_dwmac {
 	struct tse_pcs pcs;
 };
 
+#if defined CONFIG_HAVE_ARM_SMCCC && defined CONFIG_ARCH_STRATIX10
+/**************** Stratix 10 EMAC Memory Controller Functions ************/
+
+/* s10_protected_reg_write
+ * Write to a protected SMC register.
+ * @context: Not used
+ * @reg: Address of register
+ * @value: Value to write
+ * Return: INTEL_SIP_SMC_STATUS_OK (0) on success
+ *         INTEL_SIP_SMC_REG_ERROR on error
+ *         INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION if not supported
+ */
+static int s10_protected_reg_write(void *context, unsigned int reg,
+				   unsigned int val)
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
+ * @context: Not used
+ * @reg: Address of register
+ * @value: Value read.
+ * Return: INTEL_SIP_SMC_STATUS_OK (0) on success
+ *         INTEL_SIP_SMC_REG_ERROR on error
+ *         INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION if not supported
+ */
+static int s10_protected_reg_read(void *context, unsigned int reg,
+				  unsigned int *val)
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
+
+static const struct regmap_config s10_emac_regmap_cfg = {
+	.name = "s10_emac",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.max_register = 0xffffffff,
+	.reg_read = s10_protected_reg_read,
+	.reg_write = s10_protected_reg_write,
+	.use_single_read = true,
+	.use_single_write = true,
+};
+#endif
+
 static void socfpga_dwmac_fix_mac_speed(void *priv, unsigned int speed)
 {
 	struct socfpga_dwmac *dwmac = (struct socfpga_dwmac *)priv;
@@ -105,20 +169,43 @@ static int socfpga_dwmac_parse_data(struct socfpga_dwmac *dwmac, struct device *
 	struct device_node *np = dev->of_node;
 	struct regmap *sys_mgr_base_addr;
 	u32 reg_offset, reg_shift;
+#if defined CONFIG_HAVE_ARM_SMCCC && defined CONFIG_ARCH_STRATIX10
+	u32 sysmgr_reg = 0;
+#endif
 	int ret, index;
 	struct device_node *np_splitter = NULL;
 	struct device_node *np_sgmii_adapter = NULL;
+#if defined CONFIG_HAVE_ARM_SMCCC && defined CONFIG_ARCH_STRATIX10
+	struct device_node *np_sysmgr = NULL;
+#endif
 	struct resource res_splitter;
 	struct resource res_tse_pcs;
 	struct resource res_sgmii_adapter;
 
 	dwmac->interface = of_get_phy_mode(np);
 
+#if defined CONFIG_HAVE_ARM_SMCCC && defined CONFIG_ARCH_STRATIX10
+	sys_mgr_base_addr = devm_regmap_init(dev, NULL, (void *)dwmac,
+					     &s10_emac_regmap_cfg);
+	if (IS_ERR(sys_mgr_base_addr))
+		return PTR_ERR(sys_mgr_base_addr);
+
+	np_sysmgr = of_parse_phandle(np, "altr,sysmgr-syscon", 0);
+	if (np_sysmgr) {
+		ret = of_property_read_u32_index(np_sysmgr, "reg", 0,
+						 &sysmgr_reg);
+		if (ret) {
+			dev_info(dev, "Could not read sysmgr register address\n");
+			return -EINVAL;
+		}
+	}
+#else
 	sys_mgr_base_addr = syscon_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
 	if (IS_ERR(sys_mgr_base_addr)) {
 		dev_info(dev, "No sysmgr-syscon node found\n");
 		return PTR_ERR(sys_mgr_base_addr);
 	}
+#endif
 
 	ret = of_property_read_u32_index(np, "altr,sysmgr-syscon", 1, &reg_offset);
 	if (ret) {
@@ -222,6 +309,9 @@ static int socfpga_dwmac_parse_data(struct socfpga_dwmac *dwmac, struct device *
 	dwmac->reg_offset = reg_offset;
 	dwmac->reg_shift = reg_shift;
 	dwmac->sys_mgr_base_addr = sys_mgr_base_addr;
+#if defined CONFIG_HAVE_ARM_SMCCC && defined CONFIG_ARCH_STRATIX10
+	dwmac->sysmgr_reg = sysmgr_reg;
+#endif
 	dwmac->dev = dev;
 	of_node_put(np_sgmii_adapter);
 
@@ -238,6 +328,9 @@ static int socfpga_dwmac_set_phy_mode(struct socfpga_dwmac *dwmac)
 	int phymode = dwmac->interface;
 	u32 reg_offset = dwmac->reg_offset;
 	u32 reg_shift = dwmac->reg_shift;
+#if defined CONFIG_HAVE_ARM_SMCCC && defined CONFIG_ARCH_STRATIX10
+	u32 sysmgr_reg = dwmac->sysmgr_reg;
+#endif
 	u32 ctrl, val, module;
 
 	switch (phymode) {
@@ -266,7 +359,11 @@ static int socfpga_dwmac_set_phy_mode(struct socfpga_dwmac *dwmac)
 	reset_control_assert(dwmac->stmmac_ocp_rst);
 	reset_control_assert(dwmac->stmmac_rst);
 
+#if defined CONFIG_HAVE_ARM_SMCCC && defined CONFIG_ARCH_STRATIX10
+	regmap_read(sys_mgr_base_addr, sysmgr_reg + reg_offset, &ctrl);
+#else
 	regmap_read(sys_mgr_base_addr, reg_offset, &ctrl);
+#endif
 	ctrl &= ~(SYSMGR_EMACGRP_CTRL_PHYSEL_MASK << reg_shift);
 	ctrl |= val << reg_shift;
 
@@ -284,7 +381,11 @@ static int socfpga_dwmac_set_phy_mode(struct socfpga_dwmac *dwmac)
 		ctrl &= ~(SYSMGR_EMACGRP_CTRL_PTP_REF_CLK_MASK << (reg_shift / 2));
 	}
 
+#if defined CONFIG_HAVE_ARM_SMCCC && defined CONFIG_ARCH_STRATIX10
+	regmap_write(sys_mgr_base_addr, sysmgr_reg + reg_offset, ctrl);
+#else
 	regmap_write(sys_mgr_base_addr, reg_offset, ctrl);
+#endif
 
 	/* Deassert reset for the phy configuration to be sampled by
 	 * the enet controller, and operation to start in requested mode
-- 
1.7.1

