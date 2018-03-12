Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeCLNQA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:16:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42184 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932333AbeCLNPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:15:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EDC3F60817
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From: Abhishek Sahu <absahu@codeaurora.org>
To: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Austin Christ <austinwc@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH v2 09/13] i2c: qup: change completion timeout according to transfer length
Date: Mon, 12 Mar 2018 18:44:58 +0530
Message-Id: <1520860502-14886-10-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
References: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the completion timeout is being taken according to
maximum transfer length which is too high if SCL is operating in
high frequency. This patch calculates timeout on the basis of
one-byte transfer time and uses the same for completion timeout.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
Reviewed-by: Andy Gross <andy.gross@linaro.org>
---

* Changes from v1:

1. Added comments to explain TOUT_MIN

 drivers/i2c/busses/i2c-qup.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index bf1b7ee..13c751e 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -121,8 +121,12 @@
 #define MX_TX_RX_LEN			SZ_64K
 #define MX_BLOCKS			(MX_TX_RX_LEN / QUP_READ_LIMIT)
 
-/* Max timeout in ms for 32k bytes */
-#define TOUT_MAX			300
+/*
+ * Minimum transfer timeout for i2c transfers in seconds. It will be added on
+ * the top of maximum transfer time calculated from i2c bus speed to compensate
+ * the overheads.
+ */
+#define TOUT_MIN			2
 
 /* Default values. Use these if FW query fails */
 #define DEFAULT_CLK_FREQ 100000
@@ -163,6 +167,7 @@ struct qup_i2c_dev {
 	int			in_blk_sz;
 
 	unsigned long		one_byte_t;
+	unsigned long		xfer_timeout;
 	struct qup_i2c_block	blk;
 
 	struct i2c_msg		*msg;
@@ -849,7 +854,7 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
 		dma_async_issue_pending(qup->brx.dma);
 	}
 
-	if (!wait_for_completion_timeout(&qup->xfer, TOUT_MAX * HZ)) {
+	if (!wait_for_completion_timeout(&qup->xfer, qup->xfer_timeout)) {
 		dev_err(qup->dev, "normal trans timed out\n");
 		ret = -ETIMEDOUT;
 	}
@@ -1605,6 +1610,8 @@ static int qup_i2c_probe(struct platform_device *pdev)
 	 */
 	one_bit_t = (USEC_PER_SEC / clk_freq) + 1;
 	qup->one_byte_t = one_bit_t * 9;
+	qup->xfer_timeout = TOUT_MIN * HZ +
+			    usecs_to_jiffies(MX_TX_RX_LEN * qup->one_byte_t);
 
 	dev_dbg(qup->dev, "IN:block:%d, fifo:%d, OUT:block:%d, fifo:%d\n",
 		qup->in_blk_sz, qup->in_fifo_sz,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
