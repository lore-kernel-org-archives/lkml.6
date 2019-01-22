Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E29C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE49A21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MC0lZrWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfAVUCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:02:24 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4623 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfAVUCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:02:23 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4776b50000>; Tue, 22 Jan 2019 12:01:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 22 Jan 2019 12:02:21 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 22 Jan 2019 12:02:21 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 22 Jan
 2019 20:02:21 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 22 Jan
 2019 20:02:21 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 20:02:21 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c4776cd0000>; Tue, 22 Jan 2019 12:02:21 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V3] i2c: tegra: Add Bus Clear Master Support
Date:   Tue, 22 Jan 2019 12:02:18 -0800
Message-ID: <1548187338-6807-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548187318; bh=8Q9O90DFWUm3/6fBPSzOVoSXtJdH0AIUyx9DIiLaOhs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=MC0lZrWEBscwFDOrzQ+D7/hz35VE/Vf1ySNurmjiA+G6Dj1ibfZr5w0FjYgRYqqR4
         XG8Mn67ksb70/JNci1lhY2LiNHxwjDLEJYPaU4p6B9+wvh+bMIkp/UnSs6tSlJBT4h
         rWw0snJU2eb14dQjAMzfF0YFNhDxM4m/sKVDheCnyet9Ie+pDh/qEoiZqdyK5cdzcF
         vDtp5A1Lxcl/W1SghN2L+ct0opJV31dvcfIByazFmfT6FgyKmmjtO7IJRWuwFlwLKf
         1tUylICxkKF8aR6UAgNVEvT0VDRtFu8EGf5IJRiOvEOxhH0NSXLUQnBFPUgPmChRgr
         GZwahm9oCCfdg==
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
 [V3]: Updated comments and commit message to be clear on the change
 [V2]: Same as V1 rebased to 5.0-rc1

 drivers/i2c/busses/i2c-tegra.c | 70 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index e417ebf7628c..b1b920b4a203 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -54,6 +54,7 @@
 #define I2C_FIFO_STATUS_RX_SHIFT		0
 #define I2C_INT_MASK				0x064
 #define I2C_INT_STATUS				0x068
+#define I2C_INT_BUS_CLR_DONE			BIT(11)
 #define I2C_INT_PACKET_XFER_COMPLETE		BIT(7)
 #define I2C_INT_ALL_PACKETS_XFER_COMPLETE	BIT(6)
 #define I2C_INT_TX_FIFO_OVERFLOW		BIT(5)
@@ -96,6 +97,15 @@
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
@@ -155,6 +165,8 @@ enum msg_end_type {
  * @has_mst_fifo: The I2C controller contains the new MST FIFO interface that
  *		provides additional features and allows for longer messages to
  *		be transferred in one go.
+ * @supports_bus_clear: Bus Clear support to recover from bus hang during
+ *		SDA stuck low from device for some unknown reasons.
  */
 struct tegra_i2c_hw_feature {
 	bool has_continue_xfer_support;
@@ -167,6 +179,7 @@ struct tegra_i2c_hw_feature {
 	bool has_multi_master_mode;
 	bool has_slcg_override_reg;
 	bool has_mst_fifo;
+	bool supports_bus_clear;
 };
 
 /**
@@ -639,6 +652,12 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
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
@@ -668,6 +687,8 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 	tegra_i2c_mask_irq(i2c_dev, I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST |
 		I2C_INT_PACKET_XFER_COMPLETE | I2C_INT_TX_FIFO_DATA_REQ |
 		I2C_INT_RX_FIFO_DATA_REQ);
+	if (i2c_dev->hw->supports_bus_clear)
+		tegra_i2c_mask_irq(i2c_dev, I2C_INT_BUS_CLR_DONE);
 	i2c_writel(i2c_dev, status, I2C_INT_STATUS);
 	if (i2c_dev->is_dvc)
 		dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE_INTR, DVC_STATUS);
@@ -678,6 +699,43 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
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
@@ -759,6 +817,12 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
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
@@ -848,6 +912,7 @@ static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
 	.has_multi_master_mode = false,
 	.has_slcg_override_reg = false,
 	.has_mst_fifo = false,
+	.supports_bus_clear = false,
 };
 
 static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
@@ -861,6 +926,7 @@ static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
 	.has_multi_master_mode = false,
 	.has_slcg_override_reg = false,
 	.has_mst_fifo = false,
+	.supports_bus_clear = false,
 };
 
 static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
@@ -874,6 +940,7 @@ static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
 	.has_multi_master_mode = false,
 	.has_slcg_override_reg = false,
 	.has_mst_fifo = false,
+	.supports_bus_clear = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
@@ -887,6 +954,7 @@ static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
 	.has_multi_master_mode = false,
 	.has_slcg_override_reg = true,
 	.has_mst_fifo = false,
+	.supports_bus_clear = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
@@ -900,6 +968,7 @@ static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
 	.has_multi_master_mode = true,
 	.has_slcg_override_reg = true,
 	.has_mst_fifo = false,
+	.supports_bus_clear = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
@@ -913,6 +982,7 @@ static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
 	.has_multi_master_mode = true,
 	.has_slcg_override_reg = true,
 	.has_mst_fifo = true,
+	.supports_bus_clear = true,
 };
 
 /* Match table for of_platform binding */
-- 
2.7.4

