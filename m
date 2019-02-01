Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E77C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7F32086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eCECZdYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfBARIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:08:15 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4309 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfBARIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:08:15 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c547cc20000>; Fri, 01 Feb 2019 09:07:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 01 Feb 2019 09:07:56 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 01 Feb 2019 09:07:56 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 17:07:56 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 1 Feb
 2019 17:07:56 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 17:07:56 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.172.14]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c547ceb0000>; Fri, 01 Feb 2019 09:07:55 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V9 5/5] i2c: tegra: add i2c interface timing support
Date:   Fri, 1 Feb 2019 09:07:47 -0800
Message-ID: <1549040867-18149-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549040835; bh=8IcS8VFsRp+2SobYOQan5SvRWXSioTWPYHLKrJA+ElU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=eCECZdYCwgGdHCBpLdcDpeQoMlP5h3HCYtB1kFl8PiLtrdLEitw+lwoSdrWGcQfRF
         QNls5tQdSgDsyCJQYs6Vyd+fadKGraoHxVA+fA2AYp4FCO3cF84D8dohTez0BPU0ZJ
         hgl09G2S2068a3fCgHUM58n0SGiRQNdcDVIYrw2hnHzxFLP2UAo+hD9XhD+4Lz3Dg1
         GCZpS4xwr5/Z3eqHeRfY0/0KKZBnfSCNiU0JsopR8d7NwX99QyXJmDhj+H3sfsSyjh
         hnTEBjr1KQ6303umFK3kG/VLCtEFFHZ7sePe0thBHyKqA7sgycT6LP321n6WLWhG8W
         tCR9Sz6OuSUgg==
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
Acked-by: Thierry Reding <treding@nvidia.com>
---
 [V9] : Rebased to 5.0-rc4
	Minor update to commit message
 [V8] : Updated to handle timing implementation within tegra_i2c_init directly
 [V7] : Minor updates to timing implementation
 [V5/V6] : Added this Interface timing patch in V5 of the patch series.

 drivers/i2c/busses/i2c-tegra.c | 188 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 159 insertions(+), 29 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 43449495bfaa..32d5744bce45 100644
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
@@ -183,6 +195,16 @@ enum msg_end_type {
  *		allowing 0 length transfers.
  * @supports_bus_clear: Bus Clear support to recover from bus hang during
  *		SDA stuck low from device for some unknown reasons.
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
@@ -190,13 +212,21 @@ struct tegra_i2c_hw_feature {
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
 	const struct i2c_adapter_quirks *quirks;
 	bool supports_bus_clear;
+	u8 tlow_std_mode;
+	u8 thigh_std_mode;
+	u8 tlow_fast_fastplus_mode;
+	u8 thigh_fast_fastplus_mode;
+	u32 setup_hold_time_std_mode;
+	u32 setup_hold_time_fast_fast_plus_mode;
+	u32 setup_hold_time_hs_mode;
 };
 
 /**
@@ -641,11 +671,13 @@ static int tegra_i2c_wait_for_config_load(struct tegra_i2c_dev *i2c_dev)
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
@@ -675,6 +707,36 @@ static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
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
 
@@ -1074,7 +1136,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 			dmaengine_terminate_all(i2c_dev->msg_read ?
 						i2c_dev->rx_dma_chan :
 						i2c_dev->tx_dma_chan);
-			tegra_i2c_init(i2c_dev);
+			tegra_i2c_init(i2c_dev, true);
 			return -ETIMEDOUT;
 		}
 
@@ -1099,7 +1161,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	if (time_left == 0) {
 		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
 
-		tegra_i2c_init(i2c_dev);
+		tegra_i2c_init(i2c_dev, true);
 		return -ETIMEDOUT;
 	}
 
@@ -1110,7 +1172,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	if (likely(i2c_dev->msg_err == I2C_ERR_NONE))
 		return 0;
 
-	tegra_i2c_init(i2c_dev);
+	tegra_i2c_init(i2c_dev, true);
 	/* start recovery upon arbitration loss in single master mode */
 	if (i2c_dev->msg_err == I2C_ERR_ARBITRATION_LOST) {
 		if (!i2c_dev->is_multimaster_mode)
@@ -1205,7 +1267,8 @@ static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = false,
 	.has_single_clk_source = false,
 	.clk_divisor_hs_mode = 3,
-	.clk_divisor_std_fast_mode = 0,
+	.clk_divisor_std_mode = 0,
+	.clk_divisor_fast_mode = 0,
 	.clk_divisor_fast_plus_mode = 0,
 	.has_config_load_reg = false,
 	.has_multi_master_mode = false,
@@ -1213,6 +1276,13 @@ static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
 	.has_mst_fifo = false,
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = false,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x2,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0x0,
+	.setup_hold_time_fast_fast_plus_mode = 0x0,
+	.setup_hold_time_hs_mode = 0x0,
 };
 
 static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
@@ -1220,7 +1290,8 @@ static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = false,
 	.has_single_clk_source = false,
 	.clk_divisor_hs_mode = 3,
-	.clk_divisor_std_fast_mode = 0,
+	.clk_divisor_std_mode = 0,
+	.clk_divisor_fast_mode = 0,
 	.clk_divisor_fast_plus_mode = 0,
 	.has_config_load_reg = false,
 	.has_multi_master_mode = false,
@@ -1228,6 +1299,13 @@ static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
 	.has_mst_fifo = false,
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = false,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x2,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0x0,
+	.setup_hold_time_fast_fast_plus_mode = 0x0,
+	.setup_hold_time_hs_mode = 0x0,
 };
 
 static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
@@ -1235,7 +1313,8 @@ static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = true,
 	.has_single_clk_source = true,
 	.clk_divisor_hs_mode = 1,
-	.clk_divisor_std_fast_mode = 0x19,
+	.clk_divisor_std_mode = 0x19,
+	.clk_divisor_fast_mode = 0x19,
 	.clk_divisor_fast_plus_mode = 0x10,
 	.has_config_load_reg = false,
 	.has_multi_master_mode = false,
@@ -1243,6 +1322,13 @@ static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
 	.has_mst_fifo = false,
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = true,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x2,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0x0,
+	.setup_hold_time_fast_fast_plus_mode = 0x0,
+	.setup_hold_time_hs_mode = 0x0,
 };
 
 static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
@@ -1250,7 +1336,8 @@ static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = true,
 	.has_single_clk_source = true,
 	.clk_divisor_hs_mode = 1,
-	.clk_divisor_std_fast_mode = 0x19,
+	.clk_divisor_std_mode = 0x19,
+	.clk_divisor_fast_mode = 0x19,
 	.clk_divisor_fast_plus_mode = 0x10,
 	.has_config_load_reg = true,
 	.has_multi_master_mode = false,
@@ -1258,6 +1345,13 @@ static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
 	.has_mst_fifo = false,
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = true,
+	.tlow_std_mode = 0x4,
+	.thigh_std_mode = 0x2,
+	.tlow_fast_fastplus_mode = 0x4,
+	.thigh_fast_fastplus_mode = 0x2,
+	.setup_hold_time_std_mode = 0x0,
+	.setup_hold_time_fast_fast_plus_mode = 0x0,
+	.setup_hold_time_hs_mode = 0x0,
 };
 
 static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
@@ -1265,7 +1359,8 @@ static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
 	.has_per_pkt_xfer_complete_irq = true,
 	.has_single_clk_source = true,
 	.clk_divisor_hs_mode = 1,
-	.clk_divisor_std_fast_mode = 0x19,
+	.clk_divisor_std_mode = 0x19,
+	.clk_divisor_fast_mode = 0x19,
 	.clk_divisor_fast_plus_mode = 0x10,
 	.has_config_load_reg = true,
 	.has_multi_master_mode = true,
@@ -1273,26 +1368,65 @@ static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
 	.has_mst_fifo = false,
 	.quirks = &tegra_i2c_quirks,
 	.supports_bus_clear = true,
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
@@ -1313,7 +1447,6 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	phys_addr_t base_phys;
 	int irq;
 	int ret = 0;
-	int clk_multiplier = I2C_CLK_MULTIPLIER_STD_FAST_MODE;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base_phys = res->start;
@@ -1383,20 +1516,17 @@ static int tegra_i2c_probe(struct platform_device *pdev)
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
@@ -1426,7 +1556,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	if (ret == -EPROBE_DEFER)
 		goto disable_div_clk;
 
-	ret = tegra_i2c_init(i2c_dev);
+	ret = tegra_i2c_init(i2c_dev, false);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize i2c controller\n");
 		goto disable_div_clk;
-- 
2.7.4

