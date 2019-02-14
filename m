Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F9AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C5B21928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bSeKNmtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437801AbfBNR6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:58:00 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53160 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437759AbfBNR56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:57:58 -0500
Received: by mail-it1-f196.google.com with SMTP id r11so17200126itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l2ed/3/mPo7eGVi+/XTD6G8oylS839DTYEu+KI40Uu8=;
        b=bSeKNmtT1ezmnbjRJYnjiazgJl/jHn+7ntmhS09t14/jiP113zwOjMr/GkRwQFnukX
         SLSVPXrjTOC44hwqC/T+yLe5RXW1aC5adBwzvplw6aRwysBTFxO2xbhUoaQxmaER/TDp
         PqDGrgrD9I2HKbmcj6fcmBJRCV7Jni3NiZ8k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l2ed/3/mPo7eGVi+/XTD6G8oylS839DTYEu+KI40Uu8=;
        b=FbzE169BJoBnxzfKIyJONS3qcRn0OfWSPHloyNHjhUZfMu4hj6KbEDwhk/K05Yish8
         SwpcVqhI9kvZGeb4I9CfVS9FE3Tqyax6mVBIvw+9p7rW4sWnWADg3+aoAXJahYnEt+bY
         UHixUaIaBRPWuUuV3gHkbi/xIEW2w+5QFthh/5gZPh2fmfsL5PJOEmRE1u3CGOtNGoHb
         ZptFmwNFARKRO4QkcAeHrI66cVVDH4ZceKbSKvd55fqAPlXnWc63JOwVANlrrEWkm4jN
         /kIJQ0cEQ2ojLXAeFudwe4XA4f/7LyL2yOwjxum5oaOROiNIh/EnvO1fP5kXk2NUMYyn
         skJw==
X-Gm-Message-State: AHQUAubEqnndZqnAzwYWxGrpzPTU4RJPZJZjPJwoJ5eYeY3RgABpM+0l
        PzYWHnajI0Kvhl/2hOQpGad2Yw==
X-Google-Smtp-Source: AHgI3IZi5uUesOtmmJ6RpIbqqkfbSoKIfBS/z/jOdZXcoF9Nmw222bEnDod/XKiyh11HyDu9YcyjOg==
X-Received: by 2002:a24:9f87:: with SMTP id c129mr2753291ite.114.1550167075717;
        Thu, 14 Feb 2019 09:57:55 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id t64sm1534178itb.5.2019.02.14.09.57.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 09:57:55 -0800 (PST)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v5 4/8] i2c: iproc: add polling support
Date:   Thu, 14 Feb 2019 09:57:21 -0800
Message-Id: <20190214175725.60462-5-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Add polling support to the iProc I2C driver. Polling mode is
activated when the driver fails to obtain an interrupt ID from device
tree

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 298 ++++++++++++++++++-----------
 1 file changed, 181 insertions(+), 117 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 775b3d89a9c4..073e5a8888ad 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -373,95 +373,115 @@ static void bcm_iproc_i2c_read_valid_bytes(struct bcm_iproc_i2c_dev *iproc_i2c)
 	}
 }
 
-static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
+static void bcm_iproc_i2c_send(struct bcm_iproc_i2c_dev *iproc_i2c)
 {
-	struct bcm_iproc_i2c_dev *iproc_i2c = data;
-	u32 status = readl(iproc_i2c->base + IS_OFFSET);
-	u32 tmp;
-
-
-	bool ret;
-	u32 sl_status = status & ISR_MASK_SLAVE;
-
-	if (sl_status) {
-		ret = bcm_iproc_i2c_slave_isr(iproc_i2c, sl_status);
-		if (ret)
-			return IRQ_HANDLED;
-		else
-			return IRQ_NONE;
-	}
+	struct i2c_msg *msg = iproc_i2c->msg;
+	unsigned int tx_bytes = msg->len - iproc_i2c->tx_bytes;
+	unsigned int i;
+	u32 val;
 
-	status &= ISR_MASK;
+	/* can only fill up to the FIFO size */
+	tx_bytes = min_t(unsigned int, tx_bytes, M_TX_RX_FIFO_SIZE);
+	for (i = 0; i < tx_bytes; i++) {
+		/* start from where we left over */
+		unsigned int idx = iproc_i2c->tx_bytes + i;
 
-	if (!status)
-		return IRQ_NONE;
+		val = msg->buf[idx];
 
-	/* TX FIFO is empty and we have more data to send */
-	if (status & BIT(IS_M_TX_UNDERRUN_SHIFT)) {
-		struct i2c_msg *msg = iproc_i2c->msg;
-		unsigned int tx_bytes = msg->len - iproc_i2c->tx_bytes;
-		unsigned int i;
-		u32 val;
-
-		/* can only fill up to the FIFO size */
-		tx_bytes = min_t(unsigned int, tx_bytes, M_TX_RX_FIFO_SIZE);
-		for (i = 0; i < tx_bytes; i++) {
-			/* start from where we left over */
-			unsigned int idx = iproc_i2c->tx_bytes + i;
+		/* mark the last byte */
+		if (idx == msg->len - 1) {
+			val |= BIT(M_TX_WR_STATUS_SHIFT);
 
-			val = msg->buf[idx];
-
-			/* mark the last byte */
-			if (idx == msg->len - 1) {
-				val |= BIT(M_TX_WR_STATUS_SHIFT);
+			if (iproc_i2c->irq) {
+				u32 tmp;
 
 				/*
-				 * Since this is the last byte, we should
-				 * now disable TX FIFO underrun interrupt
+				 * Since this is the last byte, we should now
+				 * disable TX FIFO underrun interrupt
 				 */
 				tmp = readl(iproc_i2c->base + IE_OFFSET);
 				tmp &= ~BIT(IE_M_TX_UNDERRUN_SHIFT);
 				writel(tmp, iproc_i2c->base + IE_OFFSET);
 			}
-
-			/* load data into TX FIFO */
-			writel(val, iproc_i2c->base + M_TX_OFFSET);
 		}
-		/* update number of transferred bytes */
-		iproc_i2c->tx_bytes += tx_bytes;
+
+		/* load data into TX FIFO */
+		writel(val, iproc_i2c->base + M_TX_OFFSET);
 	}
 
-	if (status & BIT(IS_M_RX_THLD_SHIFT)) {
-		struct i2c_msg *msg = iproc_i2c->msg;
-		u32 bytes_left;
+	/* update number of transferred bytes */
+	iproc_i2c->tx_bytes += tx_bytes;
+}
 
-		bcm_iproc_i2c_read_valid_bytes(iproc_i2c);
-		bytes_left = msg->len - iproc_i2c->rx_bytes;
-		if (bytes_left == 0) {
+static void bcm_iproc_i2c_read(struct bcm_iproc_i2c_dev *iproc_i2c)
+{
+	struct i2c_msg *msg = iproc_i2c->msg;
+	u32 bytes_left, val;
+
+	bcm_iproc_i2c_read_valid_bytes(iproc_i2c);
+	bytes_left = msg->len - iproc_i2c->rx_bytes;
+	if (bytes_left == 0) {
+		if (iproc_i2c->irq) {
 			/* finished reading all data, disable rx thld event */
-			tmp = readl(iproc_i2c->base + IE_OFFSET);
-			tmp &= ~BIT(IS_M_RX_THLD_SHIFT);
-			writel(tmp, iproc_i2c->base + IE_OFFSET);
-		} else if (bytes_left < iproc_i2c->thld_bytes) {
-			/* set bytes left as threshold */
-			tmp = readl(iproc_i2c->base + M_FIFO_CTRL_OFFSET);
-			tmp &= ~(M_FIFO_RX_THLD_MASK << M_FIFO_RX_THLD_SHIFT);
-			tmp |= (bytes_left << M_FIFO_RX_THLD_SHIFT);
-			writel(tmp, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
-			iproc_i2c->thld_bytes = bytes_left;
+			val = readl(iproc_i2c->base + IE_OFFSET);
+			val &= ~BIT(IS_M_RX_THLD_SHIFT);
+			writel(val, iproc_i2c->base + IE_OFFSET);
 		}
-		/*
-		 * bytes_left >= iproc_i2c->thld_bytes,
-		 * hence no need to change the THRESHOLD SET.
-		 * It will remain as iproc_i2c->thld_bytes itself
-		 */
+	} else if (bytes_left < iproc_i2c->thld_bytes) {
+		/* set bytes left as threshold */
+		val = readl(iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+		val &= ~(M_FIFO_RX_THLD_MASK << M_FIFO_RX_THLD_SHIFT);
+		val |= (bytes_left << M_FIFO_RX_THLD_SHIFT);
+		writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+		iproc_i2c->thld_bytes = bytes_left;
 	}
+	/*
+	 * bytes_left >= iproc_i2c->thld_bytes,
+	 * hence no need to change the THRESHOLD SET.
+	 * It will remain as iproc_i2c->thld_bytes itself
+	 */
+}
 
+static void bcm_iproc_i2c_process_m_event(struct bcm_iproc_i2c_dev *iproc_i2c,
+					  u32 status)
+{
+	/* TX FIFO is empty and we have more data to send */
+	if (status & BIT(IS_M_TX_UNDERRUN_SHIFT))
+		bcm_iproc_i2c_send(iproc_i2c);
+
+	/* RX FIFO threshold is reached and data needs to be read out */
+	if (status & BIT(IS_M_RX_THLD_SHIFT))
+		bcm_iproc_i2c_read(iproc_i2c);
+
+	/* transfer is done */
 	if (status & BIT(IS_M_START_BUSY_SHIFT)) {
 		iproc_i2c->xfer_is_done = 1;
-		complete(&iproc_i2c->done);
+		if (iproc_i2c->irq)
+			complete(&iproc_i2c->done);
+	}
+}
+
+static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
+{
+	struct bcm_iproc_i2c_dev *iproc_i2c = data;
+	u32 status = readl(iproc_i2c->base + IS_OFFSET);
+	bool ret;
+	u32 sl_status = status & ISR_MASK_SLAVE;
+
+	if (sl_status) {
+		ret = bcm_iproc_i2c_slave_isr(iproc_i2c, sl_status);
+		if (ret)
+			return IRQ_HANDLED;
+		else
+			return IRQ_NONE;
 	}
 
+	status &= ISR_MASK;
+	if (!status)
+		return IRQ_NONE;
+
+	/* process all master based events */
+	bcm_iproc_i2c_process_m_event(iproc_i2c, status);
 	writel(status, iproc_i2c->base + IS_OFFSET);
 
 	return IRQ_HANDLED;
@@ -560,14 +580,71 @@ static int bcm_iproc_i2c_check_status(struct bcm_iproc_i2c_dev *iproc_i2c,
 	}
 }
 
+static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2c_dev *iproc_i2c,
+				   struct i2c_msg *msg,
+				   u32 cmd)
+{
+	unsigned long time_left = msecs_to_jiffies(I2C_TIMEOUT_MSEC);
+	u32 val, status;
+	int ret;
+
+	writel(cmd, iproc_i2c->base + M_CMD_OFFSET);
+
+	if (iproc_i2c->irq) {
+		time_left = wait_for_completion_timeout(&iproc_i2c->done,
+							time_left);
+		/* disable all interrupts */
+		writel(0, iproc_i2c->base + IE_OFFSET);
+		/* read it back to flush the write */
+		readl(iproc_i2c->base + IE_OFFSET);
+		/* make sure the interrupt handler isn't running */
+		synchronize_irq(iproc_i2c->irq);
+
+	} else { /* polling mode */
+		unsigned long timeout = jiffies + time_left;
+
+		do {
+			status = readl(iproc_i2c->base + IS_OFFSET) & ISR_MASK;
+			bcm_iproc_i2c_process_m_event(iproc_i2c, status);
+			writel(status, iproc_i2c->base + IS_OFFSET);
+
+			if (time_after(jiffies, timeout)) {
+				time_left = 0;
+				break;
+			}
+
+			cpu_relax();
+			cond_resched();
+		} while (!iproc_i2c->xfer_is_done);
+	}
+
+	if (!time_left && !iproc_i2c->xfer_is_done) {
+		dev_err(iproc_i2c->device, "transaction timed out\n");
+
+		/* flush both TX/RX FIFOs */
+		val = BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT);
+		writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+		return -ETIMEDOUT;
+	}
+
+	ret = bcm_iproc_i2c_check_status(iproc_i2c, msg);
+	if (ret) {
+		/* flush both TX/RX FIFOs */
+		val = BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT);
+		writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 					 struct i2c_msg *msg)
 {
-	int ret, i;
+	int i;
 	u8 addr;
 	u32 val, tmp, val_intr_en;
 	unsigned int tx_bytes;
-	unsigned long time_left = msecs_to_jiffies(I2C_TIMEOUT_MSEC);
 
 	/* check if bus is busy */
 	if (!!(readl(iproc_i2c->base + M_CMD_OFFSET) &
@@ -602,7 +679,9 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 	}
 
 	/* mark as incomplete before starting the transaction */
-	reinit_completion(&iproc_i2c->done);
+	if (iproc_i2c->irq)
+		reinit_completion(&iproc_i2c->done);
+
 	iproc_i2c->xfer_is_done = 0;
 
 	/*
@@ -647,39 +726,11 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
 	} else {
 		val |= (M_CMD_PROTOCOL_BLK_WR << M_CMD_PROTOCOL_SHIFT);
 	}
-	writel(val_intr_en, iproc_i2c->base + IE_OFFSET);
-	writel(val, iproc_i2c->base + M_CMD_OFFSET);
 
-	time_left = wait_for_completion_timeout(&iproc_i2c->done, time_left);
+	if (iproc_i2c->irq)
+		writel(val_intr_en, iproc_i2c->base + IE_OFFSET);
 
-	/* disable all interrupts */
-	writel(0, iproc_i2c->base + IE_OFFSET);
-	/* read it back to flush the write */
-	readl(iproc_i2c->base + IE_OFFSET);
-
-	/* make sure the interrupt handler isn't running */
-	synchronize_irq(iproc_i2c->irq);
-
-	if (!time_left && !iproc_i2c->xfer_is_done) {
-		dev_err(iproc_i2c->device, "transaction timed out\n");
-
-		/* flush FIFOs */
-		val = (1 << M_FIFO_RX_FLUSH_SHIFT) |
-		      (1 << M_FIFO_TX_FLUSH_SHIFT);
-		writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
-		return -ETIMEDOUT;
-	}
-
-	ret = bcm_iproc_i2c_check_status(iproc_i2c, msg);
-	if (ret) {
-		/* flush both TX/RX FIFOs */
-		val = (1 << M_FIFO_RX_FLUSH_SHIFT) |
-		      (1 << M_FIFO_TX_FLUSH_SHIFT);
-		writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
-		return ret;
-	}
-
-	return 0;
+	return bcm_iproc_i2c_xfer_wait(iproc_i2c, msg, val);
 }
 
 static int bcm_iproc_i2c_xfer(struct i2c_adapter *adapter,
@@ -781,17 +832,20 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
 		return ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(iproc_i2c->device, "no irq resource\n");
-		return irq;
-	}
-	iproc_i2c->irq = irq;
+	if (irq > 0) {
+		ret = devm_request_irq(iproc_i2c->device, irq,
+				       bcm_iproc_i2c_isr, 0, pdev->name,
+				       iproc_i2c);
+		if (ret < 0) {
+			dev_err(iproc_i2c->device,
+				"unable to request irq %i\n", irq);
+			return ret;
+		}
 
-	ret = devm_request_irq(iproc_i2c->device, irq, bcm_iproc_i2c_isr, 0,
-			       pdev->name, iproc_i2c);
-	if (ret < 0) {
-		dev_err(iproc_i2c->device, "unable to request irq %i\n", irq);
-		return ret;
+		iproc_i2c->irq = irq;
+	} else {
+		dev_warn(iproc_i2c->device,
+			 "no irq resource, falling back to poll mode\n");
 	}
 
 	bcm_iproc_i2c_enable_disable(iproc_i2c, true);
@@ -811,10 +865,15 @@ static int bcm_iproc_i2c_remove(struct platform_device *pdev)
 {
 	struct bcm_iproc_i2c_dev *iproc_i2c = platform_get_drvdata(pdev);
 
-	/* make sure there's no pending interrupt when we remove the adapter */
-	writel(0, iproc_i2c->base + IE_OFFSET);
-	readl(iproc_i2c->base + IE_OFFSET);
-	synchronize_irq(iproc_i2c->irq);
+	if (iproc_i2c->irq) {
+		/*
+		 * Make sure there's no pending interrupt when we remove the
+		 * adapter
+		 */
+		writel(0, iproc_i2c->base + IE_OFFSET);
+		readl(iproc_i2c->base + IE_OFFSET);
+		synchronize_irq(iproc_i2c->irq);
+	}
 
 	i2c_del_adapter(&iproc_i2c->adapter);
 	bcm_iproc_i2c_enable_disable(iproc_i2c, false);
@@ -828,10 +887,15 @@ static int bcm_iproc_i2c_suspend(struct device *dev)
 {
 	struct bcm_iproc_i2c_dev *iproc_i2c = dev_get_drvdata(dev);
 
-	/* make sure there's no pending interrupt when we go into suspend */
-	writel(0, iproc_i2c->base + IE_OFFSET);
-	readl(iproc_i2c->base + IE_OFFSET);
-	synchronize_irq(iproc_i2c->irq);
+	if (iproc_i2c->irq) {
+		/*
+		 * Make sure there's no pending interrupt when we go into
+		 * suspend
+		 */
+		writel(0, iproc_i2c->base + IE_OFFSET);
+		readl(iproc_i2c->base + IE_OFFSET);
+		synchronize_irq(iproc_i2c->irq);
+	}
 
 	/* now disable the controller */
 	bcm_iproc_i2c_enable_disable(iproc_i2c, false);
-- 
2.17.1

