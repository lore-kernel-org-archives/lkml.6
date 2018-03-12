Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932316AbeCLNPt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:15:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42018 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932222AbeCLNPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:15:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43F4E60849
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From: Abhishek Sahu <absahu@codeaurora.org>
To: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Austin Christ <austinwc@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH v2 07/13] i2c: qup: proper error handling for i2c error in BAM mode
Date: Mon, 12 Mar 2018 18:44:56 +0530
Message-Id: <1520860502-14886-8-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
References: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the i2c error handling in BAM mode is not working
properly in stress condition.

1. After an error, the FIFO are being written with FLUSH and
   EOT tags which should not be required since already these tags
   have been written in BAM descriptor itself.

2. QUP state is being moved to RESET in IRQ handler in case
   of error. When QUP HW encounters an error in BAM mode then it
   moves the QUP STATE to PAUSE state. In this case, I2C_FLUSH
   command needs to be executed while moving to RUN_STATE by writing
   to the QUP_STATE register with the I2C_FLUSH bit set to 1.

3. In Error case, sometimes, QUP generates more than one
   interrupt which will trigger the complete again. After an error,
   the flush operation will be scheduled after doing
   reinit_completion which should be triggered by BAM IRQ callback.
   If the second QUP IRQ comes during this time then it will call
   the complete and the transfer function will assume the all the
   BAM HW descriptors have been completed.

4. The release DMA is being called after each error which
   will free the DMA tx and rx channels. The error like NACK is very
   common in I2C transfer and every time this will be overhead. Now,
   since the error handling is proper so this release channel can be
   completely avoided.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
Reviewed-by: Sricharan R <sricharan@codeaurora.org>
Reviewed-by: Austin Christ <austinwc@codeaurora.org>
---

* Changes from v1: None

 drivers/i2c/busses/i2c-qup.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 73a2880..d16361d 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -219,9 +219,24 @@ static irqreturn_t qup_i2c_interrupt(int irq, void *dev)
 	if (bus_err)
 		writel(bus_err, qup->base + QUP_I2C_STATUS);
 
+	/*
+	 * Check for BAM mode and returns if already error has come for current
+	 * transfer. In Error case, sometimes, QUP generates more than one
+	 * interrupt.
+	 */
+	if (qup->use_dma && (qup->qup_err || qup->bus_err))
+		return IRQ_HANDLED;
+
 	/* Reset the QUP State in case of error */
 	if (qup_err || bus_err) {
-		writel(QUP_RESET_STATE, qup->base + QUP_STATE);
+		/*
+		 * Don’t reset the QUP state in case of BAM mode. The BAM
+		 * flush operation needs to be scheduled in transfer function
+		 * which will clear the remaining schedule descriptors in BAM
+		 * HW FIFO and generates the BAM interrupt.
+		 */
+		if (!qup->use_dma)
+			writel(QUP_RESET_STATE, qup->base + QUP_STATE);
 		goto done;
 	}
 
@@ -847,20 +862,12 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
 			goto desc_err;
 		}
 
-		if (rx_cnt)
-			writel(QUP_BAM_INPUT_EOT,
-			       qup->base + QUP_OUT_FIFO_BASE);
-
-		writel(QUP_BAM_FLUSH_STOP, qup->base + QUP_OUT_FIFO_BASE);
-
 		qup_i2c_flush(qup);
 
 		/* wait for remaining interrupts to occur */
 		if (!wait_for_completion_timeout(&qup->xfer, HZ))
 			dev_err(qup->dev, "flush timed out\n");
 
-		qup_i2c_rel_dma(qup);
-
 		ret =  (qup->bus_err & QUP_I2C_NACK_FLAG) ? -ENXIO : -EIO;
 	}
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
