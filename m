Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D59BC282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAD2218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pMF7XVr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfAXUwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:52:02 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9858 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfAXUwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:52:00 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4a254b0001>; Thu, 24 Jan 2019 12:51:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 24 Jan 2019 12:52:00 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 24 Jan 2019 12:52:00 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Jan
 2019 20:51:59 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 24 Jan 2019 20:51:59 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c4a256f0000>; Thu, 24 Jan 2019 12:51:59 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 2/4] i2c: tegra: Update I2C transfer using buffer
Date:   Thu, 24 Jan 2019 12:51:51 -0800
Message-ID: <1548363113-25969-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
References: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548363084; bh=i0V95E1TplBno4PanJH1Y2OCtyPekLCMY+C3qSqGRuA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=pMF7XVr5hgJ3FhBSKr1CWqKZG9Ek/IguFnJ+rA1UAyDSwcRvkrhYKq5dHHWhn5tP8
         mi775js1sDyS9RZS3DL0W7y7ouMPeiHNLAFodOFQjQwoWS/4EZzxZxEp7Iji9St3n6
         IYWKb/NU0/lZ6SUh6LNjgIjYQDaK9hTFXtDE3ispUrnFu2ShFjbpNIM6+I+CGi/HTZ
         gG/K4mwPGjM3z525RxdlhWt4ibRwm9BRlPZKzgQbCENlzgUEzSFBOymSiG3yP6n/zj
         NMG1p5FFuWo7QhP3wzyl33SUjJcnpZ0mbPWECc6lwfsAIqSGrnsuBg8gvpup6fEAyc
         lEV4XsG/kDxag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prepares the buffer with the message bytes to be
transmitted along with the packet header information and then
performs i2c transfer in PIO mode.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V2] : DMA support changes include preparing buffer with message bytes and
	and header before sending them through DMA. So splitted the whole
	change into 2 seperate patches in this series.

 drivers/i2c/busses/i2c-tegra.c | 97 +++++++++++++++++++++++++++++-------------
 1 file changed, 68 insertions(+), 29 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index ef854be4c837..13bce1411ddc 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -117,6 +117,9 @@
 #define I2C_MST_FIFO_STATUS_TX_MASK		0xff0000
 #define I2C_MST_FIFO_STATUS_TX_SHIFT		16
 
+/* Packet header size in bytes */
+#define I2C_PACKET_HEADER_SIZE			12
+
 /*
  * msg_end_type: The bus control which need to be send at end of transfer.
  * @MSG_END_STOP: Send stop pulse at end of transfer.
@@ -677,35 +680,69 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int tegra_i2c_start_pio_xfer(struct tegra_i2c_dev *i2c_dev)
+{
+	u32 *buffer = (u32 *)i2c_dev->msg_buf;
+	unsigned long flags;
+	u32 int_mask;
+
+	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
+
+	int_mask = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
+	tegra_i2c_unmask_irq(i2c_dev, int_mask);
+
+	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
+	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
+	i2c_writel(i2c_dev, *(buffer++), I2C_TX_FIFO);
+
+	i2c_dev->msg_buf = (u8 *) buffer;
+
+	if (!i2c_dev->msg_read)
+		tegra_i2c_fill_tx_fifo(i2c_dev);
+
+	if (i2c_dev->hw->has_per_pkt_xfer_complete_irq)
+		int_mask |= I2C_INT_PACKET_XFER_COMPLETE;
+	if (i2c_dev->msg_read)
+		int_mask |= I2C_INT_RX_FIFO_DATA_REQ;
+	else if (i2c_dev->msg_buf_remaining)
+		int_mask |= I2C_INT_TX_FIFO_DATA_REQ;
+
+	tegra_i2c_unmask_irq(i2c_dev, int_mask);
+	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
+	dev_dbg(i2c_dev->dev, "unmasked irq: %02x\n",
+		i2c_readl(i2c_dev, I2C_INT_MASK));
+
+	return 0;
+}
+
 static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	struct i2c_msg *msg, enum msg_end_type end_state)
 {
 	u32 packet_header;
 	u32 int_mask;
 	unsigned long time_left;
-	unsigned long flags;
+	u32 *buffer;
+	int ret = 0;
+
+	buffer = kmalloc(ALIGN(msg->len, BYTES_PER_FIFO_WORD) +
+					I2C_PACKET_HEADER_SIZE, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
 
 	tegra_i2c_flush_fifos(i2c_dev);
 
-	i2c_dev->msg_buf = msg->buf;
+	i2c_dev->msg_buf = (u8 *)buffer;
 	i2c_dev->msg_buf_remaining = msg->len;
 	i2c_dev->msg_err = I2C_ERR_NONE;
 	i2c_dev->msg_read = (msg->flags & I2C_M_RD);
 	reinit_completion(&i2c_dev->msg_complete);
 
-	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
-
-	int_mask = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
-	tegra_i2c_unmask_irq(i2c_dev, int_mask);
-
-	packet_header = (0 << PACKET_HEADER0_HEADER_SIZE_SHIFT) |
+	(*buffer++) = (0 << PACKET_HEADER0_HEADER_SIZE_SHIFT) |
 			PACKET_HEADER0_PROTOCOL_I2C |
 			(i2c_dev->cont_id << PACKET_HEADER0_CONT_ID_SHIFT) |
 			(1 << PACKET_HEADER0_PACKET_ID_SHIFT);
-	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
 
-	packet_header = msg->len - 1;
-	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
+	(*buffer++) = msg->len - 1;
 
 	packet_header = I2C_HEADER_IE_ENABLE;
 	if (end_state == MSG_END_CONTINUE)
@@ -722,34 +759,31 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 		packet_header |= I2C_HEADER_CONT_ON_NAK;
 	if (msg->flags & I2C_M_RD)
 		packet_header |= I2C_HEADER_READ;
-	i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
+	*(buffer++) = packet_header;
 
 	if (!(msg->flags & I2C_M_RD))
-		tegra_i2c_fill_tx_fifo(i2c_dev);
-
-	if (i2c_dev->hw->has_per_pkt_xfer_complete_irq)
-		int_mask |= I2C_INT_PACKET_XFER_COMPLETE;
-	if (msg->flags & I2C_M_RD)
-		int_mask |= I2C_INT_RX_FIFO_DATA_REQ;
-	else if (i2c_dev->msg_buf_remaining)
-		int_mask |= I2C_INT_TX_FIFO_DATA_REQ;
+		memcpy(buffer, msg->buf, msg->len);
 
-	tegra_i2c_unmask_irq(i2c_dev, int_mask);
-	spin_unlock_irqrestore(&i2c_dev->xfer_lock, flags);
-	dev_dbg(i2c_dev->dev, "unmasked irq: %02x\n",
-		i2c_readl(i2c_dev, I2C_INT_MASK));
+	tegra_i2c_start_pio_xfer(i2c_dev);
 
 	time_left = wait_for_completion_timeout(&i2c_dev->msg_complete,
 						TEGRA_I2C_TIMEOUT);
-	tegra_i2c_mask_irq(i2c_dev, int_mask);
-
 	if (time_left == 0) {
 		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
 
 		tegra_i2c_init(i2c_dev);
-		return -ETIMEDOUT;
+		ret = -ETIMEDOUT;
+		goto err_xfer;
+	}
+
+	if (i2c_dev->msg_read) {
+		i2c_dev->msg_buf = (u8 *)buffer;
+		memcpy(msg->buf, i2c_dev->msg_buf, msg->len);
 	}
 
+	int_mask = i2c_readl(i2c_dev, I2C_INT_MASK);
+	tegra_i2c_mask_irq(i2c_dev, int_mask);
+
 	dev_dbg(i2c_dev->dev, "transfer complete: %lu %d %d\n",
 		time_left, completion_done(&i2c_dev->msg_complete),
 		i2c_dev->msg_err);
@@ -761,10 +795,15 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	if (i2c_dev->msg_err == I2C_ERR_NO_ACK) {
 		if (msg->flags & I2C_M_IGNORE_NAK)
 			return 0;
-		return -EREMOTEIO;
+		ret = -EREMOTEIO;
+		goto err_xfer;
 	}
 
-	return -EIO;
+	ret = -EIO;
+
+err_xfer:
+	kfree(buffer);
+	return ret;
 }
 
 static int tegra_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
-- 
2.7.4

