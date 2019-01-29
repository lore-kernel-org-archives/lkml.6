Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AC1C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B296A2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VbP0dzqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfA2WGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:06:24 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10829 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfA2WGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:06:22 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c50ce400000>; Tue, 29 Jan 2019 14:05:52 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 29 Jan 2019 14:06:20 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 29 Jan 2019 14:06:20 -0800
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 22:06:19 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 22:06:19 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c50ce5b0004>; Tue, 29 Jan 2019 14:06:19 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V4 2/4] i2c: tegra: Add Bus Clear Master Support
Date:   Tue, 29 Jan 2019 14:06:16 -0800
Message-ID: <1548799578-11638-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548799578-11638-1-git-send-email-skomatineni@nvidia.com>
References: <1548799578-11638-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548799552; bh=bhXd4j2sJebwN48X9L05ZIdTkbQch1PdwkFJs8DrmzI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=VbP0dzqB2x/RIp1Ra2+Ks/5Yh71uSANt9FBW3msKBQ7HGMEohA1qQycJipQPttWNM
         1OtW/9Nprmsf0CB0hAIawAh3eO9RrsBn2RK0zJaU3WKYyF6oAo9+J1ctfUh5ErsGF2
         CGvMKq3W83LMt/HbNdES/Nt4gezctLWAGnF2prlE/McyRgWUl4JjFoVxyhHi3Am4KY
         lJIeTsLs2d159znztaC2SG1P//T1FIzXAG252xXPzwwO6FzgqaysG1qMBpobc11TW/
         4Amd/Ev2C0egy5lE1DfRV1ISrSOaex4W8oUWhQqq7RZB53uLQtMyKuHWUl89ELFN2f
         GY27xeqEDVFVQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bus clear feature of tegra i2c controller helps to recover from
bus hang when i2c master loses the bus arbitration due to the
slave device holding SDA LOW continuously for some unknown reasons.

Per I2C specification, the device that held the bus LOW should
release it within 9 clock pulses.

During bus clear operation, Tegra I2C controller sends 9 clock
pulses and terminates the transaction with STOP condition.
Upon successful bus clear operation, bus goes to idle state and
driver retries the transaction.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V4]: Added I2C Bus Clear support patch to this version of series.

 drivers/i2c/busses/i2c-tegra.c | 71 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 15806c984859..c4892a47a483 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -51,6 +51,7 @@
 #define I2C_FIFO_STATUS_RX_SHIFT		0
 #define I2C_INT_MASK				0x064
 #define I2C_INT_STATUS				0x068
+#define I2C_INT_BUS_CLR_DONE			BIT(11)
 #define I2C_INT_PACKET_XFER_COMPLETE		BIT(7)
 #define I2C_INT_ALL_PACKETS_XFER_COMPLETE	BIT(6)
 #define I2C_INT_TX_FIFO_OVERFLOW		BIT(5)
@@ -93,6 +94,15 @@
 #define I2C_HEADER_MASTER_ADDR_SHIFT		12
 #define I2C_HEADER_SLAVE_ADDR_SHIFT		1
 
+#define I2C_BUS_CLEAR_CNFG			0x084
+#define I2C_BC_SCLK_THRESHOLD			9
+#define I2C_BC_SCLK_THRESHOLD_SHIFT		16
+#define I2C_BC_STOP_COND			BIT(2)
+#define I2C_BC_TERMINATE			BIT(1)
+#define I2C_BC_ENABLE				BIT(0)
+#define I2C_BUS_CLEAR_STATUS			0x088
+#define I2C_BC_STATUS				BIT(0)
+
 #define I2C_CONFIG_LOAD				0x08C
 #define I2C_MSTR_CONFIG_LOAD			BIT(0)
 #define I2C_SLV_CONFIG_LOAD			BIT(1)
@@ -152,6 +162,8 @@ enum msg_end_type {
  * @has_mst_fifo: The I2C controller contains the new MST FIFO interface that
  *		provides additional features and allows for longer messages to
  *		be transferred in one go.
+ * @supports_bus_clear: Bus Clear support to recover from bus hang during
+ *		SDA stuck low from device for some unknown reasons.
  */
 struct tegra_i2c_hw_feature {
 	bool has_continue_xfer_support;
@@ -164,6 +176,7 @@ struct tegra_i2c_hw_feature {
 	bool has_multi_master_mode;
 	bool has_slcg_override_reg;
 	bool has_mst_fifo;
+	bool supports_bus_clear;
 };
 
 /**
@@ -636,6 +649,12 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 			i2c_dev->msg_err |= I2C_ERR_ARBITRATION_LOST;
 		goto err;
 	}
+	/*
+	 * I2C transfer is terminated during the bus clear so skip
+	 * processing the other interrupts.
+	 */
+	if (i2c_dev->hw->supports_bus_clear && (status & I2C_INT_BUS_CLR_DONE))
+		goto err;
 
 	if (i2c_dev->msg_read && (status & I2C_INT_RX_FIFO_DATA_REQ)) {
 		if (i2c_dev->msg_buf_remaining)
@@ -665,6 +684,8 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 	tegra_i2c_mask_irq(i2c_dev, I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST |
 		I2C_INT_PACKET_XFER_COMPLETE | I2C_INT_TX_FIFO_DATA_REQ |
 		I2C_INT_RX_FIFO_DATA_REQ);
+	if (i2c_dev->hw->supports_bus_clear)
+		tegra_i2c_mask_irq(i2c_dev, I2C_INT_BUS_CLR_DONE);
 	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
 	if (i2c_dev->is_dvc)
 		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
@@ -675,6 +696,43 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int tegra_i2c_issue_bus_clear(struct tegra_i2c_dev *i2c_dev)
+{
+	int err;
+	unsigned long time_left;
+	u32 reg;
+
+	if (i2c_dev->hw->supports_bus_clear) {
+		reinit_completion(&i2c_dev->msg_complete);
+		reg = (I2C_BC_SCLK_THRESHOLD << I2C_BC_SCLK_THRESHOLD_SHIFT) |
+		      I2C_BC_STOP_COND | I2C_BC_TERMINATE;
+		i2c_writel(i2c_dev, reg, I2C_BUS_CLEAR_CNFG);
+		if (i2c_dev->hw->has_config_load_reg) {
+			err = tegra_i2c_wait_for_config_load(i2c_dev);
+			if (err)
+				return err;
+		}
+		reg |= I2C_BC_ENABLE;
+		i2c_writel(i2c_dev, reg, I2C_BUS_CLEAR_CNFG);
+		tegra_i2c_unmask_irq(i2c_dev, I2C_INT_BUS_CLR_DONE);
+
+		time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
+							TEGRA_I2C_TIMEOUT);
+		if (time_left == 0) {
+			dev_err(i2c_dev->dev, "timed out for bus clear\n");
+			return -ETIMEDOUT;
+		}
+		reg = i2c_readl(i2c_dev, I2C_BUS_CLEAR_STATUS);
+		if (!(reg & I2C_BC_STATUS)) {
+			dev_err(i2c_dev->dev,
+				"Un-recovered arbitration lost\n");
+			return -EIO;
+		}
+	}
+
+	return -EAGAIN;
+}
+
 static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	struct i2c_msg *msg, enum msg_end_type end_state)
 {
@@ -756,6 +814,12 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 		return 0;
 
 	tegra_i2c_init(i2c_dev);
+	/* start recovery upon arbitration loss in single master mode */
+	if (i2c_dev->msg_err == I2C_ERR_ARBITRATION_LOST) {
+		if (!i2c_dev->is_multimaster_mode)
+			return tegra_i2c_issue_bus_clear(i2c_dev);
+		return -EAGAIN;
+	}
 	if (i2c_dev->msg_err == I2C_ERR_NO_ACK) {
 		if (msg->flags & I2C_M_IGNORE_NAK)
 			return 0;
@@ -845,6 +909,7 @@ static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
 	.has_multi_master_mode = false,
 	.has_slcg_override_reg = false,
 	.has_mst_fifo = false,
+	.supports_bus_clear = false,
 };
 
 static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
@@ -858,6 +923,7 @@ static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
 	.has_multi_master_mode = false,
 	.has_slcg_override_reg = false,
 	.has_mst_fifo = false,
+	.supports_bus_clear = false,
 };
 
 static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
@@ -871,6 +937,7 @@ static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
 	.has_multi_master_mode = false,
 	.has_slcg_override_reg = false,
 	.has_mst_fifo = false,
+	.supports_bus_clear = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
@@ -884,6 +951,7 @@ static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
 	.has_multi_master_mode = false,
 	.has_slcg_override_reg = true,
 	.has_mst_fifo = false,
+	.supports_bus_clear = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
@@ -897,6 +965,7 @@ static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
 	.has_multi_master_mode = true,
 	.has_slcg_override_reg = true,
 	.has_mst_fifo = false,
+	.supports_bus_clear = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
@@ -910,6 +979,7 @@ static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
 	.has_multi_master_mode = true,
 	.has_slcg_override_reg = true,
 	.has_mst_fifo = true,
+	.supports_bus_clear = true,
 };
 
 /* Match table for of_platform binding */
@@ -962,6 +1032,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	i2c_dev->div_clk = div_clk;
 	i2c_dev->adapter.algo = &tegra_i2c_algo;
 	i2c_dev->adapter.quirks = &tegra_i2c_quirks;
+	i2c_dev->adapter.retries = 1;
 	i2c_dev->irq = irq;
 	i2c_dev->cont_id = pdev->id;
 	i2c_dev->dev = &pdev->dev;
-- 
2.7.4

