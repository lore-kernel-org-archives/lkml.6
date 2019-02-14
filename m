Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99C6C10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C866222DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g1bPfV2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437826AbfBNR6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:58:04 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:33378 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437790AbfBNR6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:58:00 -0500
Received: by mail-it1-f193.google.com with SMTP id g137so5409280ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Me9XXS4EbKCUGepbHlS7WPPRS+DQurUbgVfda7V56wg=;
        b=g1bPfV2YOhpSLIPwgfgMuMbMIb8r4+1qgZSc/lO0XQVeIi+xzc74Z09ry+gSOSAgf5
         HWrNUksurPez8I+SF7JWib15etE8xdS/0a1Mddd2Sfr+mhUD6bXUNQPMmiUB17/H7TGt
         tFP9Ej4H8MlMEtHS3uJ92KnwpxW2okoJTfdZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Me9XXS4EbKCUGepbHlS7WPPRS+DQurUbgVfda7V56wg=;
        b=Gy/mhcCI9kMRHGUHdzv/yCojsL+XkOLwXHgJT4bqMmJ/tGvCELFn3uRtJ9KHwArfwy
         UYCsQitb5lf9td4HY5q8oSEvYB3PiuW8MHgFki7bI9tRbXRSgYgBoScYXGxwiDscxs9N
         Gmz5PzFxhrOQrbaX3F62M++c2Ahyz2ydqO+e96snARt8N5EJj5W/4Mj9Xixq0+JwDAmm
         7J/HjX52tdUWZuXbb7NDPsO8T62//sQeoJnMriIRW4P6KoD1Q7buM2AtBzYVNW5frVvu
         2uNZSaFAdlx4kyjPRGBSOYZqR4mhU8U2XIG/KIqcrN3u5iKG2Pz2F8zPujIE9uKesBo5
         edKQ==
X-Gm-Message-State: AHQUAuYVRDD7dUwvG08dTacThy1nNON7e9xaHY5xkX0AjDnnNtukW552
        YNfyFC2chJZ9LY8GeV8shW42VR9hKoeDDeK/
X-Google-Smtp-Source: AHgI3IbDrPVHD6FXhmIq5gl002owvr2GlBIzeygqKNzQOFy/Fdq8U+ACxPhmqgkJuq+aXS8lxE8zew==
X-Received: by 2002:a24:94cb:: with SMTP id j194mr2646394ite.117.1550167079167;
        Thu, 14 Feb 2019 09:57:59 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id t64sm1534178itb.5.2019.02.14.09.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 09:57:58 -0800 (PST)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v5 5/8] i2c: iproc: use wrapper for read/write access
Date:   Thu, 14 Feb 2019 09:57:22 -0800
Message-Id: <20190214175725.60462-6-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Use the following wrapper for read/write access of iProc i2c registers:
u32 iproc_i2c_rd_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
                     u32 offset)
void iproc_i2c_wr_reg(struct bcm_iproc_i2c_dev *iproc_i2c, u32 offset,
                      u32 val)

This preps the driver for support of indirect register access required
by certain SoCs with this iProc I2C block integrated

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 145 ++++++++++++++++-------------
 1 file changed, 79 insertions(+), 66 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 073e5a8888ad..5b9cbd7a3776 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -212,6 +212,18 @@ static int bcm_iproc_i2c_unreg_slave(struct i2c_client *slave);
 static void bcm_iproc_i2c_enable_disable(struct bcm_iproc_i2c_dev *iproc_i2c,
 					 bool enable);
 
+static inline u32 iproc_i2c_rd_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
+				   u32 offset)
+{
+	return readl(iproc_i2c->base + offset);
+}
+
+static inline void iproc_i2c_wr_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
+				    u32 offset, u32 val)
+{
+	writel(val, iproc_i2c->base + offset);
+}
+
 static void bcm_iproc_i2c_slave_init(
 	struct bcm_iproc_i2c_dev *iproc_i2c, bool need_reset)
 {
@@ -219,37 +231,37 @@ static void bcm_iproc_i2c_slave_init(
 
 	if (need_reset) {
 		/* put controller in reset */
-		val = readl(iproc_i2c->base + CFG_OFFSET);
+		val = iproc_i2c_rd_reg(iproc_i2c, CFG_OFFSET);
 		val |= BIT(CFG_RESET_SHIFT);
-		writel(val, iproc_i2c->base + CFG_OFFSET);
+		iproc_i2c_wr_reg(iproc_i2c, CFG_OFFSET, val);
 
 		/* wait 100 usec per spec */
 		udelay(100);
 
 		/* bring controller out of reset */
 		val &= ~(BIT(CFG_RESET_SHIFT));
-		writel(val, iproc_i2c->base + CFG_OFFSET);
+		iproc_i2c_wr_reg(iproc_i2c, CFG_OFFSET, val);
 	}
 
 	/* flush TX/RX FIFOs */
 	val = (BIT(S_FIFO_RX_FLUSH_SHIFT) | BIT(S_FIFO_TX_FLUSH_SHIFT));
-	writel(val, iproc_i2c->base + S_FIFO_CTRL_OFFSET);
+	iproc_i2c_wr_reg(iproc_i2c, S_FIFO_CTRL_OFFSET, val);
 
 	/* RANDOM SLAVE STRETCH time - 20ms*/
-	val = readl(iproc_i2c->base + TIM_CFG_OFFSET);
+	val = iproc_i2c_rd_reg(iproc_i2c, TIM_CFG_OFFSET);
 	val &= ~(TIM_RAND_SLAVE_STRETCH_MASK << TIM_RAND_SLAVE_STRETCH_SHIFT);
 	val |= (SLAVE_CLOCK_STRETCH_TIME << TIM_RAND_SLAVE_STRETCH_SHIFT);
-	writel(val, iproc_i2c->base + TIM_CFG_OFFSET);
+	iproc_i2c_wr_reg(iproc_i2c, TIM_CFG_OFFSET, val);
 
 	/* Configure the slave address */
-	val = readl(iproc_i2c->base + S_CFG_SMBUS_ADDR_OFFSET);
+	val = iproc_i2c_rd_reg(iproc_i2c, S_CFG_SMBUS_ADDR_OFFSET);
 	val |= BIT(S_CFG_EN_NIC_SMB_ADDR3_SHIFT);
 	val &= ~(S_CFG_NIC_SMB_ADDR3_MASK << S_CFG_NIC_SMB_ADDR3_SHIFT);
 	val |= (iproc_i2c->slave->addr << S_CFG_NIC_SMB_ADDR3_SHIFT);
-	writel(val, iproc_i2c->base + S_CFG_SMBUS_ADDR_OFFSET);
+	iproc_i2c_wr_reg(iproc_i2c, S_CFG_SMBUS_ADDR_OFFSET, val);
 
 	/* clear all pending slave interrupts */
-	writel(ISR_MASK_SLAVE, iproc_i2c->base + IS_OFFSET);
+	iproc_i2c_wr_reg(iproc_i2c, IS_OFFSET, ISR_MASK_SLAVE);
 
 	/* Enable interrupt register for any READ event */
 	val = BIT(IE_S_RD_EVENT_SHIFT);
@@ -257,7 +269,7 @@ static void bcm_iproc_i2c_slave_init(
 	val |= BIT(IE_S_RX_EVENT_SHIFT);
 	/* Enable interrupt register for the Slave BUSY command */
 	val |= BIT(IE_S_START_BUSY_SHIFT);
-	writel(val, iproc_i2c->base + IE_OFFSET);
+	iproc_i2c_wr_reg(iproc_i2c, IE_OFFSET, val);
 
 	iproc_i2c->xfer_dir = I2C_SLAVE_DIR_NONE;
 }
@@ -267,7 +279,7 @@ static void bcm_iproc_i2c_check_slave_status(
 {
 	u32 val;
 
-	val = readl(iproc_i2c->base + S_CMD_OFFSET);
+	val = iproc_i2c_rd_reg(iproc_i2c, S_CMD_OFFSET);
 	val = (val >> S_CMD_STATUS_SHIFT) & S_CMD_STATUS_MASK;
 
 	if (val == S_CMD_STATUS_TIMEOUT) {
@@ -290,7 +302,7 @@ static bool bcm_iproc_i2c_slave_isr(struct bcm_iproc_i2c_dev *iproc_i2c,
 
 	/* Start of transaction. check address and populate the direction */
 	if (iproc_i2c->xfer_dir == I2C_SLAVE_DIR_NONE) {
-		tmp = readl(iproc_i2c->base + S_RX_OFFSET);
+		tmp = iproc_i2c_rd_reg(iproc_i2c, S_RX_OFFSET);
 		rd_status = (tmp >> S_RX_STATUS_SHIFT) & S_RX_STATUS_MASK;
 		/* This condition checks whether the request is a new request */
 		if (((rd_status == I2C_SLAVE_RX_START) &&
@@ -316,16 +328,16 @@ static bool bcm_iproc_i2c_slave_isr(struct bcm_iproc_i2c_dev *iproc_i2c,
 		(iproc_i2c->xfer_dir == I2C_SLAVE_DIR_WRITE)) {
 		i2c_slave_event(iproc_i2c->slave,
 			I2C_SLAVE_READ_PROCESSED, &value);
-		writel(value, iproc_i2c->base + S_TX_OFFSET);
+		iproc_i2c_wr_reg(iproc_i2c, S_TX_OFFSET, value);
 
 		val = BIT(S_CMD_START_BUSY_SHIFT);
-		writel(val, iproc_i2c->base + S_CMD_OFFSET);
+		iproc_i2c_wr_reg(iproc_i2c, S_CMD_OFFSET, val);
 	}
 
 	/* write request from master */
 	if ((status & BIT(IS_S_RX_EVENT_SHIFT)) &&
 		(iproc_i2c->xfer_dir == I2C_SLAVE_DIR_READ)) {
-		val = readl(iproc_i2c->base + S_RX_OFFSET);
+		val = iproc_i2c_rd_reg(iproc_i2c, S_RX_OFFSET);
 		/* Its a write request by Master to Slave.
 		 * We read data present in receive FIFO
 		 */
@@ -348,7 +360,7 @@ static bool bcm_iproc_i2c_slave_isr(struct bcm_iproc_i2c_dev *iproc_i2c,
 	}
 
 	/* clear interrupt status */
-	writel(status, iproc_i2c->base + IS_OFFSET);
+	iproc_i2c_wr_reg(iproc_i2c, IS_OFFSET, status);
 
 	bcm_iproc_i2c_check_slave_status(iproc_i2c);
 	return true;
@@ -360,14 +372,13 @@ static void bcm_iproc_i2c_read_valid_bytes(struct bcm_iproc_i2c_dev *iproc_i2c)
 
 	/* Read valid data from RX FIFO */
 	while (iproc_i2c->rx_bytes < msg->len) {
-		if (!((readl(iproc_i2c->base +
-		M_FIFO_CTRL_OFFSET) >>
-		M_FIFO_RX_CNT_SHIFT) &
-		M_FIFO_RX_CNT_MASK))
+		if (!((iproc_i2c_rd_reg(iproc_i2c,
+					M_FIFO_CTRL_OFFSET) >>
+		       M_FIFO_RX_CNT_SHIFT) & M_FIFO_RX_CNT_MASK))
 			break;
 
 		msg->buf[iproc_i2c->rx_bytes] =
-			(readl(iproc_i2c->base + M_RX_OFFSET) >>
+			(iproc_i2c_rd_reg(iproc_i2c, M_RX_OFFSET) >>
 			M_RX_DATA_SHIFT) & M_RX_DATA_MASK;
 		iproc_i2c->rx_bytes++;
 	}
@@ -399,14 +410,15 @@ static void bcm_iproc_i2c_send(struct bcm_iproc_i2c_dev *iproc_i2c)
 				 * Since this is the last byte, we should now
 				 * disable TX FIFO underrun interrupt
 				 */
-				tmp = readl(iproc_i2c->base + IE_OFFSET);
+				tmp = iproc_i2c_rd_reg(iproc_i2c, IE_OFFSET);
 				tmp &= ~BIT(IE_M_TX_UNDERRUN_SHIFT);
-				writel(tmp, iproc_i2c->base + IE_OFFSET);
+				iproc_i2c_wr_reg(iproc_i2c, IE_OFFSET,
+						 tmp);
 			}
 		}
 
 		/* load data into TX FIFO */
-		writel(val, iproc_i2c->base + M_TX_OFFSET);
+		iproc_i2c_wr_reg(iproc_i2c, M_TX_OFFSET, val);
 	}
 
 	/* update number of transferred bytes */
@@ -423,16 +435,16 @@ static void bcm_iproc_i2c_read(struct bcm_iproc_i2c_dev *iproc_i2c)
 	if (bytes_left == 0) {
 		if (iproc_i2c->irq) {
 			/* finished reading all data, disable rx thld event */
-			val = readl(iproc_i2c->base + IE_OFFSET);
+			val = iproc_i2c_rd_reg(iproc_i2c, IE_OFFSET);
 			val &= ~BIT(IS_M_RX_THLD_SHIFT);
-			writel(val, iproc_i2c->base + IE_OFFSET);
+			iproc_i2c_wr_reg(iproc_i2c, IE_OFFSET, val);
 		}
 	} else if (bytes_left < iproc_i2c->thld_bytes) {
 		/* set bytes left as threshold */
-		val = readl(iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+		val = iproc_i2c_rd_reg(iproc_i2c, M_FIFO_CTRL_OFFSET);
 		val &= ~(M_FIFO_RX_THLD_MASK << M_FIFO_RX_THLD_SHIFT);
 		val |= (bytes_left << M_FIFO_RX_THLD_SHIFT);
-		writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+		iproc_i2c_wr_reg(iproc_i2c, M_FIFO_CTRL_OFFSET, val);
 		iproc_i2c->thld_bytes = bytes_left;
 	}
 	/*
@@ -464,7 +476,7 @@ static void bcm_iproc_i2c_process_m_event(struct bcm_iproc_i2c_dev *iproc_i2c,
 static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
 {
 	struct bcm_iproc_i2c_dev *iproc_i2c = data;
-	u32 status = readl(iproc_i2c->base + IS_OFFSET);
+	u32 status = iproc_i2c_rd_reg(iproc_i2c, IS_OFFSET);
 	bool ret;
 	u32 sl_status = status & ISR_MASK_SLAVE;
 
@@ -482,7 +494,7 @@ static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
 
 	/* process all master based events */
 	bcm_iproc_i2c_process_m_event(iproc_i2c, status);
-	writel(status, iproc_i2c->base + IS_OFFSET);
+	iproc_i2c_wr_reg(iproc_i2c, IS_OFFSET, status);
 
 	return IRQ_HANDLED;
 }
@@ -492,29 +504,29 @@ static int bcm_iproc_i2c_init(struct bcm_iproc_i2c_dev *iproc_i2c)
 	u32 val;
 
 	/* put controller in reset */
-	val = readl(iproc_i2c->base + CFG_OFFSET);
+	val = iproc_i2c_rd_reg(iproc_i2c, CFG_OFFSET);
 	val |= BIT(CFG_RESET_SHIFT);
 	val &= ~(BIT(CFG_EN_SHIFT));
-	writel(val, iproc_i2c->base + CFG_OFFSET);
+	iproc_i2c_wr_reg(iproc_i2c, CFG_OFFSET, val);
 
 	/* wait 100 usec per spec */
 	udelay(100);
 
 	/* bring controller out of reset */
 	val &= ~(BIT(CFG_RESET_SHIFT));
-	writel(val, iproc_i2c->base + CFG_OFFSET);
+	iproc_i2c_wr_reg(iproc_i2c, CFG_OFFSET, val);
 
 	/* flush TX/RX FIFOs and set RX FIFO threshold to zero */
 	val = (BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT));
-	writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+	iproc_i2c_wr_reg(iproc_i2c, M_FIFO_CTRL_OFFSET, val);
 	/* disable all interrupts */
-	val = readl(iproc_i2c->base + IE_OFFSET);
+	val = iproc_i2c_rd_reg(iproc_i2c, IE_OFFSET);
 	val &= ~(IE_M_ALL_INTERRUPT_MASK <<
 			IE_M_ALL_INTERRUPT_SHIFT);
-	writel(val, iproc_i2c->base + IE_OFFSET);
+	iproc_i2c_wr_reg(iproc_i2c, IE_OFFSET, val);
 
 	/* clear all pending interrupts */
-	writel(0xffffffff, iproc_i2c->base + IS_OFFSET);
+	iproc_i2c_wr_reg(iproc_i2c, IS_OFFSET, 0xffffffff);
 
 	return 0;
 }
@@ -524,12 +536,12 @@ static void bcm_iproc_i2c_enable_disable(struct bcm_iproc_i2c_dev *iproc_i2c,
 {
 	u32 val;
 
-	val = readl(iproc_i2c->base + CFG_OFFSET);
+	val = iproc_i2c_rd_reg(iproc_i2c, CFG_OFFSET);
 	if (enable)
 		val |= BIT(CFG_EN_SHIFT);
 	else
 		val &= ~BIT(CFG_EN_SHIFT);
-	writel(val, iproc_i2c->base + CFG_OFFSET);
+	iproc_i2c_wr_reg(iproc_i2c, CFG_OFFSET, val);
 }
 
 static int bcm_iproc_i2c_check_status(struct bcm_iproc_i2c_dev *iproc_i2c,
@@ -537,7 +549,7 @@ static int bcm_iproc_i2c_check_status(struct bcm_iproc_i2c_dev *iproc_i2c,
 {
 	u32 val;
 
-	val = readl(iproc_i2c->base + M_CMD_OFFSET);
+	val = iproc_i2c_rd_reg(iproc_i2c, M_CMD_OFFSET);
 	val = (val >> M_CMD_STATUS_SHIFT) & M_CMD_STATUS_MASK;
 
 	switch (val) {
@@ -588,15 +600,15 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2c_dev *iproc_i2c,
 	u32 val, status;
 	int ret;
 
-	writel(cmd, iproc_i2c->base + M_CMD_OFFSET);
+	iproc_i2c_wr_reg(iproc_i2c, M_CMD_OFFSET, cmd);
 
 	if (iproc_i2c->irq) {
 		time_left = wait_for_completion_timeout(&iproc_i2c->done,
 							time_left);
 		/* disable all interrupts */
-		writel(0, iproc_i2c->base + IE_OFFSET);
+		iproc_i2c_wr_reg(iproc_i2c, IE_OFFSET, 0);
 		/* read it back to flush the write */
-		readl(iproc_i2c->base + IE_OFFSET);
+		iproc_i2c_rd_reg(iproc_i2c, IE_OFFSET);
 		/* make sure the interrupt handler isn't running */
 		synchronize_irq(iproc_i2c->irq);
 
@@ -604,9 +616,10 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2c_dev *iproc_i2c,
 		unsigned long timeout = jiffies + time_left;
 
 		do {
-			status = readl(iproc_i2c->base + IS_OFFSET) & ISR_MASK;
+			status = iproc_i2c_rd_reg(iproc_i2c,
+						  IS_OFFSET) & ISR_MASK;
 			bcm_iproc_i2c_process_m_event(iproc_i2c, status);
-			writel(status, iproc_i2c->base + IS_OFFSET);
+			iproc_i2c_wr_reg(iproc_i2c, IS_OFFSET, status);
 
 			if (time_after(jiffies, timeout)) {
 				time_left = 0;
@@ -623,7 +636,7 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2c_dev *iproc_i2c,
 
 		/* flush both TX/RX FIFOs */
 		val = BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT);
-		writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+		iproc_i2c_wr_reg(iproc_i2c, M_FIFO_CTRL_OFFSET, val);
 		return -ETIMEDOUT;
 	}
 
@@ -631,7 +644,7 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2c_dev *iproc_i2c,
 	if (ret) {
 		/* flush both TX/RX FIFOs */
 		val = BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT);
-		writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+		iproc_i2c_wr_reg(iproc_i2c, M_FIFO_CTRL_OFFSET, val);
 		return ret;
 	}
 
@@ -647,8 +660,8 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 	unsigned int tx_bytes;
 
 	/* check if bus is busy */
-	if (!!(readl(iproc_i2c->base + M_CMD_OFFSET) &
-	       BIT(M_CMD_START_BUSY_SHIFT))) {
+	if (!!(iproc_i2c_rd_reg(iproc_i2c,
+				M_CMD_OFFSET) & BIT(M_CMD_START_BUSY_SHIFT))) {
 		dev_warn(iproc_i2c->device, "bus is busy\n");
 		return -EBUSY;
 	}
@@ -657,7 +670,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 
 	/* format and load slave address into the TX FIFO */
 	addr = i2c_8bit_addr_from_msg(msg);
-	writel(addr, iproc_i2c->base + M_TX_OFFSET);
+	iproc_i2c_wr_reg(iproc_i2c, M_TX_OFFSET, addr);
 
 	/*
 	 * For a write transaction, load data into the TX FIFO. Only allow
@@ -673,7 +686,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 			if (i == msg->len - 1)
 				val |= 1 << M_TX_WR_STATUS_SHIFT;
 
-			writel(val, iproc_i2c->base + M_TX_OFFSET);
+			iproc_i2c_wr_reg(iproc_i2c, M_TX_OFFSET, val);
 		}
 		iproc_i2c->tx_bytes = tx_bytes;
 	}
@@ -713,10 +726,10 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 			iproc_i2c->thld_bytes = msg->len;
 
 		/* set threshold value */
-		tmp = readl(iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+		tmp = iproc_i2c_rd_reg(iproc_i2c, M_FIFO_CTRL_OFFSET);
 		tmp &= ~(M_FIFO_RX_THLD_MASK << M_FIFO_RX_THLD_SHIFT);
 		tmp |= iproc_i2c->thld_bytes << M_FIFO_RX_THLD_SHIFT;
-		writel(tmp, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+		iproc_i2c_wr_reg(iproc_i2c, M_FIFO_CTRL_OFFSET, tmp);
 
 		/* enable the RX threshold interrupt */
 		val_intr_en |= BIT(IE_M_RX_THLD_SHIFT);
@@ -728,7 +741,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 	}
 
 	if (iproc_i2c->irq)
-		writel(val_intr_en, iproc_i2c->base + IE_OFFSET);
+		iproc_i2c_wr_reg(iproc_i2c, IE_OFFSET, val_intr_en);
 
 	return bcm_iproc_i2c_xfer_wait(iproc_i2c, msg, val);
 }
@@ -792,10 +805,10 @@ static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
 	}
 
 	iproc_i2c->bus_speed = bus_speed;
-	val = readl(iproc_i2c->base + TIM_CFG_OFFSET);
+	val = iproc_i2c_rd_reg(iproc_i2c, TIM_CFG_OFFSET);
 	val &= ~(1 << TIM_CFG_MODE_400_SHIFT);
 	val |= (bus_speed == 400000) << TIM_CFG_MODE_400_SHIFT;
-	writel(val, iproc_i2c->base + TIM_CFG_OFFSET);
+	iproc_i2c_wr_reg(iproc_i2c, TIM_CFG_OFFSET, val);
 
 	dev_info(iproc_i2c->device, "bus set to %u Hz\n", bus_speed);
 
@@ -870,8 +883,8 @@ static int bcm_iproc_i2c_remove(struct platform_device *pdev)
 		 * Make sure there's no pending interrupt when we remove the
 		 * adapter
 		 */
-		writel(0, iproc_i2c->base + IE_OFFSET);
-		readl(iproc_i2c->base + IE_OFFSET);
+		iproc_i2c_wr_reg(iproc_i2c, IE_OFFSET, 0);
+		iproc_i2c_rd_reg(iproc_i2c, IE_OFFSET);
 		synchronize_irq(iproc_i2c->irq);
 	}
 
@@ -892,8 +905,8 @@ static int bcm_iproc_i2c_suspend(struct device *dev)
 		 * Make sure there's no pending interrupt when we go into
 		 * suspend
 		 */
-		writel(0, iproc_i2c->base + IE_OFFSET);
-		readl(iproc_i2c->base + IE_OFFSET);
+		iproc_i2c_wr_reg(iproc_i2c, IE_OFFSET, 0);
+		iproc_i2c_rd_reg(iproc_i2c, IE_OFFSET);
 		synchronize_irq(iproc_i2c->irq);
 	}
 
@@ -918,10 +931,10 @@ static int bcm_iproc_i2c_resume(struct device *dev)
 		return ret;
 
 	/* configure to the desired bus speed */
-	val = readl(iproc_i2c->base + TIM_CFG_OFFSET);
+	val = iproc_i2c_rd_reg(iproc_i2c, TIM_CFG_OFFSET);
 	val &= ~(1 << TIM_CFG_MODE_400_SHIFT);
 	val |= (iproc_i2c->bus_speed == 400000) << TIM_CFG_MODE_400_SHIFT;
-	writel(val, iproc_i2c->base + TIM_CFG_OFFSET);
+	iproc_i2c_wr_reg(iproc_i2c, TIM_CFG_OFFSET, val);
 
 	bcm_iproc_i2c_enable_disable(iproc_i2c, true);
 
@@ -965,15 +978,15 @@ static int bcm_iproc_i2c_unreg_slave(struct i2c_client *slave)
 	iproc_i2c->slave = NULL;
 
 	/* disable all slave interrupts */
-	tmp = readl(iproc_i2c->base + IE_OFFSET);
+	tmp = iproc_i2c_rd_reg(iproc_i2c, IE_OFFSET);
 	tmp &= ~(IE_S_ALL_INTERRUPT_MASK <<
 			IE_S_ALL_INTERRUPT_SHIFT);
-	writel(tmp, iproc_i2c->base + IE_OFFSET);
+	iproc_i2c_wr_reg(iproc_i2c, IE_OFFSET, tmp);
 
 	/* Erase the slave address programmed */
-	tmp = readl(iproc_i2c->base + S_CFG_SMBUS_ADDR_OFFSET);
+	tmp = iproc_i2c_rd_reg(iproc_i2c, S_CFG_SMBUS_ADDR_OFFSET);
 	tmp &= ~BIT(S_CFG_EN_NIC_SMB_ADDR3_SHIFT);
-	writel(tmp, iproc_i2c->base + S_CFG_SMBUS_ADDR_OFFSET);
+	iproc_i2c_wr_reg(iproc_i2c, S_CFG_SMBUS_ADDR_OFFSET, tmp);
 
 	return 0;
 }
-- 
2.17.1

