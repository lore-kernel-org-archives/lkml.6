Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB38C282C7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E472175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GQ/OfcuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbfA3DNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 22:13:44 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8809 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbfA3DNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 22:13:43 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5116680000>; Tue, 29 Jan 2019 19:13:44 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 29 Jan 2019 19:13:42 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 29 Jan 2019 19:13:42 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 30 Jan
 2019 03:13:42 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 30 Jan 2019 03:13:42 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.165.12]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c5116650002>; Tue, 29 Jan 2019 19:13:41 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V6 5/5] i2c: tegra: Add I2C interface timing support
Date:   Tue, 29 Jan 2019 19:13:33 -0800
Message-ID: <1548818013-21226-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548818013-21226-1-git-send-email-skomatineni@nvidia.com>
References: <1548818013-21226-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548818024; bh=TCC1dFPsCWQ+A5zXtM8zjCs5YN4RiyAsHOfOL9fVyUI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=GQ/OfcuSnBzeeuucCGsXV1mzxSrIQmhTCW1aY6fJePx+sxMX03PJotVUTdWePlc4B
         BbTmj43noWtEmLtkX/8s5TNerkP8IhdI/6+6/5lJEd+XHvP+UyIOOYY4EJzNrLONPw
         VWcpo2moVKoUV6q+kHCVoOMlAh81ixjgkCjXBPjT7kGPmqG8rtSIoMvd1iVpQ07GuQ
         x26ncbaVj27gLNYA75rMjf+bR+Dlo+jBl8dxkRa6rzM57iHg96+ng9aD+rq21+CAAl
         xv2WLXJ5veIoWPAmYujSzsq5WGWaQWNQnWh1tDDNZ7TSGOPK4hZGSrzX9qCQeWaCnA
         8ZWVX4/Uytwjw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds I2C interface timing registers support for
proper bus rate configuration along with meeting the i2c spec
setup and hold times based on the tuning performed on Tegra210,
Tegra186 and Tegra194 platforms.

I2C_INTERFACE_TIMING_0 register contains TLOW and THIGH field
and Tegra I2C controller design uses them as a part of internal
clock divisor.

I2C_INTERFACE_TIMING_1 register contains the setup and hold times
for start and stop conditions.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V5/V6] : Added this Interface timing patch in V5 of the patch series.

 drivers/i2c/busses/i2c-tegra.c | 223 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 200 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 623bf4f275cd..0fd5e1943313 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -130,6 +130,19 @@
 #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
 #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
 
+#define I2C_INTERFACE_TIMING_0			0x94
+#define I2C_TLOW_MASK				0x3F
+#define I2C_THIGH_SHIFT				8
+#define I2C_THIGH_MASK				(0x3F << I2C_THIGH_SHIFT)
+#define I2C_TLOW_NEW_MASK			0xFF
+#define I2C_THIGH_NEW_MASK			(0xFF << I2C_THIGH_SHIFT)
+#define I2C_INTERFACE_TIMING_1			0x98
+
+#define I2C_STANDARD_MODE			100000
+#define I2C_FAST_MODE				400000
+#define I2C_FAST_PLUS_MODE			1000000
+#define I2C_HS_MODE				3500000
+
 /* Packet header size in bytes */
 #define I2C_PACKET_HEADER_SIZE			12
 
@@ -167,7 +180,10 @@ enum msg_end_type {
  * @has_config_load_reg: Has the config load register to load the new
  *		configuration.
  * @clk_divisor_hs_mode: Clock divisor in HS mode.
- * @clk_divisor_std_fast_mode: Clock divisor in standard/fast mode. It is
+ * @clk_divisor_std_mode: Clock divisor in standard mode. It is
+ *		applicable if there is no fast clock source i.e. single clock
+ *		source.
+ * @clk_divisor_fast_mode: Clock divisor in fast mode. It is
  *		applicable if there is no fast clock source i.e. single clock
  *		source.
  * @clk_divisor_fast_plus_mode: Clock divisor in fast mode plus. It is
@@ -182,6 +198,19 @@ enum msg_end_type {
  *		be transferred in one go.
  * @supports_bus_clear: Bus Clear support to recover from bus hang during
  *		SDA stuck low from device for some unknown reasons.
+ * @interface_timing_enhancement: Interface Timing bit fields increased in
+ *		Tegra194 compared to Prior Tegra chips for more tuning to meet
+ *		I2C Timing requirements for various data rates.
+ * @tlow_std_mode: Low period of the clock in standard mode.
+ * @thigh_std_mode: High period of the clock in standard mode.
+ * @tlow_fast_fastplus_mode: Low period of the clock in fast/fast-plus modes.
+ * @thigh_fast_fastplus_mode: High period of the clock in fast/fast-plus modes.
+ * @setup_hold_time_std_mode: Setup and hold time for start and stop conditions
+ *		in standard mode.
+ * @setup_hold_time_fast_fast_plus_mode: Setup and hold time for start and stop
+ *		conditions in fast/fast-plus modes.
+ * @setup_hold_time_hs_mode: Setup and hold time for start and stop conditions
+ *		in HS mode.
  */
 struct tegra_i2c_hw_feature {
 	bool has_continue_xfer_support;
@@ -189,12 +218,21 @@ struct tegra_i2c_hw_feature {
 	bool has_single_clk_source;
 	bool has_config_load_reg;
 	int clk_divisor_hs_mode;
-	int clk_divisor_std_fast_mode;
+	int clk_divisor_std_mode;
+	int clk_divisor_fast_mode;
 	u16 clk_divisor_fast_plus_mode;
 	bool has_multi_master_mode;
 	bool has_slcg_override_reg;
 	bool has_mst_fifo;
 	bool supports_bus_clear;
+	bool interface_timing_enhancement;
+	u8 tlow_std_mode;
+	u8 thigh_std_mode;
+	u8 tlow_fast_fastplus_mode;
+	u8 thigh_fast_fastplus_mode;
+	u32 setup_hold_time_std_mode;
+	u32 setup_hold_time_fast_fast_plus_mode;
+	u32 setup_hold_time_hs_mode;
 };
 
 /**
@@ -262,6 +300,7 @@ struct tegra_i2c_dev {
 };
 
 static struct dma_chan *chan;
+static bool first_init = true;
 
 static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val,
 		       unsigned long reg)
@@ -639,6 +678,61 @@ static int tegra_i2c_wait_for_config_load(struct tegra_i2c_dev *i2c_dev)
 	return 0;
 }
 
+static void tegra_i2c_set_timing(struct tegra_i2c_dev *i2c_dev)
+{
+	u32 val;
+	u32 tsu_thd = 0;
+	u8 tlow = 0;
+	u8 thigh = 0;
+
+	if ((i2c_dev->bus_clk_rate > I2C_STANDARD_MODE) &&
+	    (i2c_dev->bus_clk_rate <= I2C_FAST_PLUS_MODE)) {
+		tlow = i2c_dev->hw->tlow_fast_fastplus_mode;
+		thigh = i2c_dev->hw->thigh_fast_fastplus_mode;
+		tsu_thd = i2c_dev->hw->setup_hold_time_fast_fast_plus_mode;
+	} else {
+		tlow = i2c_dev->hw->tlow_std_mode;
+		thigh = i2c_dev->hw->thigh_std_mode;
+		tsu_thd = i2c_dev->hw->setup_hold_time_std_mode;
+	}
+
+	val = (thigh << I2C_THIGH_SHIFT) | tlow;
+	if (val)
+		i2c_writel(i2c_dev, val, I2C_INTERFACE_TIMING_0);
+
+	if (tsu_thd)
+		i2c_writel(i2c_dev, tsu_thd, I2C_INTERFACE_TIMING_1);
+}
+
+static int tegra_i2c_set_clk_rate(struct tegra_i2c_dev *i2c_dev)
+{
+	u32 clk_multiplier;
+	u32 val;
+	u8 low_clk_period, high_clk_period;
+	int ret = 0;
+
+	val = i2c_readl(i2c_dev, I2C_INTERFACE_TIMING_0);
+
+	if (i2c_dev->hw->interface_timing_enhancement) {
+		low_clk_period = val & I2C_TLOW_NEW_MASK;
+		high_clk_period = (val & I2C_THIGH_NEW_MASK) >>
+							I2C_THIGH_SHIFT;
+	} else {
+		low_clk_period = val & I2C_TLOW_MASK;
+		high_clk_period = (val & I2C_THIGH_MASK) >> I2C_THIGH_SHIFT;
+	}
+
+	clk_multiplier = (low_clk_period + high_clk_period + 2);
+	clk_multiplier *= (i2c_dev->clk_divisor_non_hs_mode + 1);
+
+	ret = clk_set_rate(i2c_dev->div_clk,
+			   i2c_dev->bus_clk_rate * clk_multiplier);
+	if (ret)
+		dev_err(i2c_dev->dev, "failed changing clock rate: %d\n", ret);
+
+	return ret;
+}
+
 static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 {
 	u32 val;
@@ -667,12 +761,21 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 	i2c_writel(i2c_dev, val, I2C_CNFG);
 	i2c_writel(i2c_dev, 0, I2C_INT_MASK);
 
+	tegra_i2c_set_timing(i2c_dev);
 	/* Make sure clock divisor programmed correctly */
 	clk_divisor = i2c_dev->hw->clk_divisor_hs_mode;
 	clk_divisor |= i2c_dev->clk_divisor_non_hs_mode <<
 					I2C_CLK_DIVISOR_STD_FAST_MODE_SHIFT;
 	i2c_writel(i2c_dev, clk_divisor, I2C_CLK_DIVISOR);
 
+	if (first_init) {
+		err = tegra_i2c_set_clk_rate(i2c_dev);
+		if (err < 0)
+			goto err;
+		else
+			first_init = false;
+	}
+
 	if (!i2c_dev->is_dvc) {
 		u32 sl_cfg = i2c_readl(i2c_dev, I2C_SL_CNFG);
 
@@ -1213,13 +1316,22 @@ static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = false,
 	.has_single_clk_source = false,
 	.clk_divisor_hs_mode = 3,
-	.clk_divisor_std_fast_mode = 0,
+	.clk_divisor_std_mode = 0,
+	.clk_divisor_fast_mode = 0,
 	.clk_divisor_fast_plus_mode = 0,
 	.has_config_load_reg = false,
 	.has_multi_master_mode = false,
 	.has_slcg_override_reg = false,
 	.has_mst_fifo = false,
 	.supports_bus_clear = false,
+	.interface_timing_enhancement = false,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x2,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0x0,
+	.setup_hold_time_fast_fast_plus_mode = 0x0,
+	.setup_hold_time_hs_mode = 0x0,
 };
 
 static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
@@ -1227,13 +1339,22 @@ static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = false,
 	.has_single_clk_source = false,
 	.clk_divisor_hs_mode = 3,
-	.clk_divisor_std_fast_mode = 0,
+	.clk_divisor_std_mode = 0,
+	.clk_divisor_fast_mode = 0,
 	.clk_divisor_fast_plus_mode = 0,
 	.has_config_load_reg = false,
 	.has_multi_master_mode = false,
 	.has_slcg_override_reg = false,
 	.has_mst_fifo = false,
 	.supports_bus_clear = false,
+	.interface_timing_enhancement = false,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x2,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0x0,
+	.setup_hold_time_fast_fast_plus_mode = 0x0,
+	.setup_hold_time_hs_mode = 0x0,
 };
 
 static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
@@ -1241,13 +1362,22 @@ static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = true,
 	.has_single_clk_source = true,
 	.clk_divisor_hs_mode = 1,
-	.clk_divisor_std_fast_mode = 0x19,
+	.clk_divisor_std_mode = 0x19,
+	.clk_divisor_fast_mode = 0x19,
 	.clk_divisor_fast_plus_mode = 0x10,
 	.has_config_load_reg = false,
 	.has_multi_master_mode = false,
 	.has_slcg_override_reg = false,
 	.has_mst_fifo = false,
 	.supports_bus_clear = true,
+	.interface_timing_enhancement = false,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x2,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0x0,
+	.setup_hold_time_fast_fast_plus_mode = 0x0,
+	.setup_hold_time_hs_mode = 0x0,
 };
 
 static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
@@ -1255,13 +1385,22 @@ static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = true,
 	.has_single_clk_source = true,
 	.clk_divisor_hs_mode = 1,
-	.clk_divisor_std_fast_mode = 0x19,
+	.clk_divisor_std_mode = 0x19,
+	.clk_divisor_fast_mode = 0x19,
 	.clk_divisor_fast_plus_mode = 0x10,
 	.has_config_load_reg = true,
 	.has_multi_master_mode = false,
 	.has_slcg_override_reg = true,
 	.has_mst_fifo = false,
 	.supports_bus_clear = true,
+	.interface_timing_enhancement = false,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x2,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0x0,
+	.setup_hold_time_fast_fast_plus_mode = 0x0,
+	.setup_hold_time_hs_mode = 0x0,
 };
 
 static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
@@ -1269,32 +1408,74 @@ static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = true,
 	.has_single_clk_source = true,
 	.clk_divisor_hs_mode = 1,
-	.clk_divisor_std_fast_mode = 0x19,
+	.clk_divisor_std_mode = 0x19,
+	.clk_divisor_fast_mode = 0x19,
 	.clk_divisor_fast_plus_mode = 0x10,
 	.has_config_load_reg = true,
 	.has_multi_master_mode = true,
 	.has_slcg_override_reg = true,
 	.has_mst_fifo = false,
 	.supports_bus_clear = true,
+	.interface_timing_enhancement = false,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x2,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0,
+	.setup_hold_time_fast_fast_plus_mode = 0,
+	.setup_hold_time_hs_mode = 0,
 };
 
-static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
+static const struct tegra_i2c_hw_feature tegra186_i2c_hw = {
 	.has_continue_xfer_support = true,
 	.has_per_pkt_xfer_complete_irq = true,
 	.has_single_clk_source = true,
 	.clk_divisor_hs_mode = 1,
-	.clk_divisor_std_fast_mode = 0x19,
+	.clk_divisor_std_mode = 0x16,
+	.clk_divisor_fast_mode = 0x19,
 	.clk_divisor_fast_plus_mode = 0x10,
 	.has_config_load_reg = true,
 	.has_multi_master_mode = true,
 	.has_slcg_override_reg = true,
 	.has_mst_fifo = true,
 	.supports_bus_clear = true,
+	.interface_timing_enhancement = true,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x3,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0,
+	.setup_hold_time_fast_fast_plus_mode = 0,
+	.setup_hold_time_hs_mode = 0,
+};
+
+static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
+	.has_continue_xfer_support = true,
+	.has_per_pkt_xfer_complete_irq = true,
+	.has_single_clk_source = true,
+	.clk_divisor_hs_mode = 1,
+	.clk_divisor_std_mode = 0x4f,
+	.clk_divisor_fast_mode = 0x3c,
+	.clk_divisor_fast_plus_mode = 0x16,
+	.has_config_load_reg = true,
+	.has_multi_master_mode = true,
+	.has_slcg_override_reg = true,
+	.has_mst_fifo = true,
+	.supports_bus_clear = true,
+	.interface_timing_enhancement = true,
+	.tlow_std_mode = 0x8,
+	.thigh_std_mode = 0x7,
+	.tlow_fast_fastplus_mode = 0x2,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0x08080808,
+	.setup_hold_time_fast_fast_plus_mode = 0x02020202,
+	.setup_hold_time_hs_mode = 0x090909,
 };
 
 /* Match table for of_platform binding */
 static const struct of_device_id tegra_i2c_of_match[] = {
 	{ .compatible = "nvidia,tegra194-i2c", .data = &tegra194_i2c_hw, },
+	{ .compatible = "nvidia,tegra186-i2c", .data = &tegra186_i2c_hw, },
 	{ .compatible = "nvidia,tegra210-i2c", .data = &tegra210_i2c_hw, },
 	{ .compatible = "nvidia,tegra124-i2c", .data = &tegra124_i2c_hw, },
 	{ .compatible = "nvidia,tegra114-i2c", .data = &tegra114_i2c_hw, },
@@ -1315,7 +1496,6 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	phys_addr_t phys_addr;
 	int irq;
 	int ret = 0;
-	int clk_multiplier = I2C_CLK_MULTIPLIER_STD_FAST_MODE;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	phys_addr = res->start;
@@ -1385,20 +1565,17 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 		}
 	}
 
-	i2c_dev->clk_divisor_non_hs_mode =
-			i2c_dev->hw->clk_divisor_std_fast_mode;
-	if (i2c_dev->hw->clk_divisor_fast_plus_mode &&
-		(i2c_dev->bus_clk_rate == 1000000))
+	if ((i2c_dev->bus_clk_rate > I2C_FAST_MODE) &&
+	    (i2c_dev->bus_clk_rate <= I2C_FAST_PLUS_MODE))
 		i2c_dev->clk_divisor_non_hs_mode =
-			i2c_dev->hw->clk_divisor_fast_plus_mode;
-
-	clk_multiplier *= (i2c_dev->clk_divisor_non_hs_mode + 1);
-	ret = clk_set_rate(i2c_dev->div_clk,
-			   i2c_dev->bus_clk_rate * clk_multiplier);
-	if (ret) {
-		dev_err(i2c_dev->dev, "Clock rate change failed %d\n", ret);
-		goto unprepare_fast_clk;
-	}
+				i2c_dev->hw->clk_divisor_fast_plus_mode;
+	else if ((i2c_dev->bus_clk_rate > I2C_STANDARD_MODE) &&
+		 (i2c_dev->bus_clk_rate <= I2C_FAST_MODE))
+		i2c_dev->clk_divisor_non_hs_mode =
+				i2c_dev->hw->clk_divisor_fast_mode;
+	else
+		i2c_dev->clk_divisor_non_hs_mode =
+				i2c_dev->hw->clk_divisor_std_mode;
 
 	ret = clk_prepare(i2c_dev->div_clk);
 	if (ret < 0) {
-- 
2.7.4

