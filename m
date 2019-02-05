Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DA6C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D392083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="R0suUYfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfBEI4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:56:36 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11391 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbfBEI4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:56:34 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c594fb80000>; Tue, 05 Feb 2019 00:56:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 05 Feb 2019 00:56:33 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 05 Feb 2019 00:56:33 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 5 Feb
 2019 08:56:33 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 5 Feb 2019 08:56:33 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.175.36]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c594fc00000>; Tue, 05 Feb 2019 00:56:33 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <digetx@gmail.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V11 5/5] i2c: tegra: add i2c interface timing support
Date:   Tue, 5 Feb 2019 00:56:25 -0800
Message-ID: <1549356985-25726-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549356985-25726-1-git-send-email-skomatineni@nvidia.com>
References: <1549356985-25726-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549356984; bh=+rS707ZFqF9Lkm5+M/rPF/IVcVIrAl1aOoT3Z67guOE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=R0suUYfxug3o7hKwf9l/sQ8A8h5qjO1s701OBGmaCXRrCneZIAxK29wBdu4MOD8wJ
         hdtNCEyH9R7ISYOkasfvL3UreMP0Eypkn+S79voriB0li2wjRA1F0tY/1xvnouGBOp
         rh3gMgdGu98vCeQpSFNzQZOiaYk1ygGeOsdO82UB/yd3+fc/bWTpUXPB4x66hT65Aa
         ITcDuOW4LXjhhF5RamvlPuR3aUQ0T80ylfRofx1HDjSl0TsmEsfHTAf2zU224CBQTX
         8tGet9ED7QRsRBuoS6xjY3Ucwly6xudUA/SYdJu/CZJbiKKGLKE79gjP1DWS7XHeKg
         5MZvlTPyrzbzw==
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

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V9/V10/V11] : Same as V8
 [V8] : Updated to handle timing implementation within tegra_i2c_init directly
 [V7] : Minor updates to timing implementation
 [V5/V6] : Added this Interface timing patch in V5 of the patch series.

 drivers/i2c/busses/i2c-tegra.c | 189 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 160 insertions(+), 29 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index f7584f0ea7da..841cad6ccb57 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -129,6 +129,15 @@
 #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
 #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
 
+#define I2C_INTERFACE_TIMING_0			0x94
+#define I2C_THIGH_SHIFT				8
+#define I2C_INTERFACE_TIMING_1			0x98
+
+#define I2C_STANDARD_MODE			100000
+#define I2C_FAST_MODE				400000
+#define I2C_FAST_PLUS_MODE			1000000
+#define I2C_HS_MODE				3500000
+
 /* Packet header size in bytes */
 #define I2C_PACKET_HEADER_SIZE			12
 
@@ -166,7 +175,10 @@ enum msg_end_type {
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
@@ -184,6 +196,16 @@ enum msg_end_type {
  * @supports_bus_clear: Bus Clear support to recover from bus hang during
  *		SDA stuck low from device for some unknown reasons.
  * @has_apb_dma: Support of APBDMA on corresponding Tegra chip.
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
@@ -191,7 +213,8 @@ struct tegra_i2c_hw_feature {
 	bool has_single_clk_source;
 	bool has_config_load_reg;
 	int clk_divisor_hs_mode;
-	int clk_divisor_std_fast_mode;
+	int clk_divisor_std_mode;
+	int clk_divisor_fast_mode;
 	u16 clk_divisor_fast_plus_mode;
 	bool has_multi_master_mode;
 	bool has_slcg_override_reg;
@@ -199,6 +222,13 @@ struct tegra_i2c_hw_feature {
 	const struct i2c_adapter_quirks *quirks;
 	bool supports_bus_clear;
 	bool has_apb_dma;
+	u8 tlow_std_mode;
+	u8 thigh_std_mode;
+	u8 tlow_fast_fastplus_mode;
+	u8 thigh_fast_fastplus_mode;
+	u32 setup_hold_time_std_mode;
+	u32 setup_hold_time_fast_fast_plus_mode;
+	u32 setup_hold_time_hs_mode;
 };
 
 /**
@@ -666,11 +696,13 @@ static int tegra_i2c_wait_for_config_load(struct tegra_i2c_dev *i2c_dev)
 	return 0;
 }
 
-static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
+static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev, bool clk_reinit)
 {
 	u32 val;
 	int err;
-	u32 clk_divisor;
+	u32 clk_divisor, clk_multiplier;
+	u32 tsu_thd = 0;
+	u8 tlow, thigh;
 
 	err = pm_runtime_get_sync(i2c_dev->dev);
 	if (err < 0) {
@@ -700,6 +732,36 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
 					I2C_CLK_DIVISOR_STD_FAST_MODE_SHIFT;
 	i2c_writel(i2c_dev, clk_divisor, I2C_CLK_DIVISOR);
 
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
+
+	if (!clk_reinit) {
+		clk_multiplier = (tlow + thigh + 2);
+		clk_multiplier *= (i2c_dev->clk_divisor_non_hs_mode + 1);
+		err = clk_set_rate(i2c_dev->div_clk,
+				   i2c_dev->bus_clk_rate * clk_multiplier);
+		if (err) {
+			dev_err(i2c_dev->dev,
+				"failed changing clock rate: %d\n", err);
+			goto err;
+		}
+	}
+
 	if (!i2c_dev->is_dvc) {
 		u32 sl_cfg = i2c_readl(i2c_dev, I2C_SL_CNFG);
 
@@ -1106,7 +1168,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 			dmaengine_terminate_sync(i2c_dev->msg_read ?
 						  i2c_dev->rx_dma_chan :
 						  i2c_dev->tx_dma_chan);
-			tegra_i2c_init(i2c_dev);
+			tegra_i2c_init(i2c_dev, true);
 			return -ETIMEDOUT;
 		}
 
@@ -1133,7 +1195,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	if (time_left == 0) {
 		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
 
-		tegra_i2c_init(i2c_dev);
+		tegra_i2c_init(i2c_dev, true);
 		return -ETIMEDOUT;
 	}
 
@@ -1145,7 +1207,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	if (likely(i2c_dev->msg_err == I2C_ERR_NONE))
 		return 0;
 
-	tegra_i2c_init(i2c_dev);
+	tegra_i2c_init(i2c_dev, true);
 	/* start recovery upon arbitration loss in single master mode */
 	if (i2c_dev->msg_err == I2C_ERR_ARBITRATION_LOST) {
 		if (!i2c_dev->is_multimaster_mode)
@@ -1240,7 +1302,8 @@ static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = false,
 	.has_single_clk_source = false,
 	.clk_divisor_hs_mode = 3,
-	.clk_divisor_std_fast_mode = 0,
+	.clk_divisor_std_mode = 0,
+	.clk_divisor_fast_mode = 0,
 	.clk_divisor_fast_plus_mode = 0,
 	.has_config_load_reg = false,
 	.has_multi_master_mode = false,
@@ -1249,6 +1312,13 @@ static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = false,
 	.has_apb_dma = true,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x2,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0x0,
+	.setup_hold_time_fast_fast_plus_mode = 0x0,
+	.setup_hold_time_hs_mode = 0x0,
 };
 
 static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
@@ -1256,7 +1326,8 @@ static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = false,
 	.has_single_clk_source = false,
 	.clk_divisor_hs_mode = 3,
-	.clk_divisor_std_fast_mode = 0,
+	.clk_divisor_std_mode = 0,
+	.clk_divisor_fast_mode = 0,
 	.clk_divisor_fast_plus_mode = 0,
 	.has_config_load_reg = false,
 	.has_multi_master_mode = false,
@@ -1265,6 +1336,13 @@ static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = false,
 	.has_apb_dma = true,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x2,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0x0,
+	.setup_hold_time_fast_fast_plus_mode = 0x0,
+	.setup_hold_time_hs_mode = 0x0,
 };
 
 static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
@@ -1272,7 +1350,8 @@ static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = true,
 	.has_single_clk_source = true,
 	.clk_divisor_hs_mode = 1,
-	.clk_divisor_std_fast_mode = 0x19,
+	.clk_divisor_std_mode = 0x19,
+	.clk_divisor_fast_mode = 0x19,
 	.clk_divisor_fast_plus_mode = 0x10,
 	.has_config_load_reg = false,
 	.has_multi_master_mode = false,
@@ -1281,6 +1360,13 @@ static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = true,
 	.has_apb_dma = true,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x2,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0x0,
+	.setup_hold_time_fast_fast_plus_mode = 0x0,
+	.setup_hold_time_hs_mode = 0x0,
 };
 
 static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
@@ -1288,7 +1374,8 @@ static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = true,
 	.has_single_clk_source = true,
 	.clk_divisor_hs_mode = 1,
-	.clk_divisor_std_fast_mode = 0x19,
+	.clk_divisor_std_mode = 0x19,
+	.clk_divisor_fast_mode = 0x19,
 	.clk_divisor_fast_plus_mode = 0x10,
 	.has_config_load_reg = true,
 	.has_multi_master_mode = false,
@@ -1297,6 +1384,13 @@ static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = true,
 	.has_apb_dma = true,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x2,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0x0,
+	.setup_hold_time_fast_fast_plus_mode = 0x0,
+	.setup_hold_time_hs_mode = 0x0,
 };
 
 static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
@@ -1304,7 +1398,8 @@ static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = true,
 	.has_single_clk_source = true,
 	.clk_divisor_hs_mode = 1,
-	.clk_divisor_std_fast_mode = 0x19,
+	.clk_divisor_std_mode = 0x19,
+	.clk_divisor_fast_mode = 0x19,
 	.clk_divisor_fast_plus_mode = 0x10,
 	.has_config_load_reg = true,
 	.has_multi_master_mode = true,
@@ -1313,27 +1408,67 @@ static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = true,
 	.has_apb_dma = true,
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
+	.quirks = &tegra_i2c_quirks,
+	.supports_bus_clear = true,
+	.has_apb_dma = false,
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
 	.quirks = &tegra194_i2c_quirks,
 	.supports_bus_clear = true,
 	.has_apb_dma = false,
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
@@ -1354,7 +1489,6 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	phys_addr_t base_phys;
 	int irq;
 	int ret = 0;
-	int clk_multiplier = I2C_CLK_MULTIPLIER_STD_FAST_MODE;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base_phys = res->start;
@@ -1425,20 +1559,17 @@ static int tegra_i2c_probe(struct platform_device *pdev)
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
@@ -1468,7 +1599,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto disable_div_clk;
 
-	ret = tegra_i2c_init(i2c_dev);
+	ret = tegra_i2c_init(i2c_dev, false);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize i2c controller\n");
 		goto disable_div_clk;
-- 
2.7.4

