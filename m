Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932349AbeCLNPy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:15:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42088 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932302AbeCLNPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:15:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97362605FB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From: Abhishek Sahu <absahu@codeaurora.org>
To: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Austin Christ <austinwc@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH v2 08/13] i2c: qup: use the complete transfer length to choose DMA mode
Date: Mon, 12 Mar 2018 18:44:57 +0530
Message-Id: <1520860502-14886-9-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
References: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently each message length in complete transfer is being
checked for determining DMA mode and if any of the message length
is less than FIFO length then non DMA mode is being used which
will increase overhead. DMA can be used for any length and it
should be determined with complete transfer length. Now, this
patch selects DMA mode if the total length is greater than FIFO
length.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
Reviewed-by: Austin Christ <austinwc@codeaurora.org>
Reviewed-by: Andy Gross <andy.gross@linaro.org>
---

* Changes from v1:

1. Removed dma_threshold from global structure
2. Modified commit message for the same

 drivers/i2c/busses/i2c-qup.c | 25 ++++++++++++++++---------
 drivers/i2c/busses/i2c-qup.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index d16361d..bf1b7ee 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1300,7 +1300,8 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
 			   int num)
 {
 	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
-	int ret, len, idx = 0;
+	int ret, idx = 0;
+	unsigned int total_len = 0;
 
 	qup->bus_err = 0;
 	qup->qup_err = 0;
@@ -1326,14 +1327,14 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
 				goto out;
 			}
 
-			len = (msgs[idx].len > qup->out_fifo_sz) ||
-			      (msgs[idx].len > qup->in_fifo_sz);
-
-			if (is_vmalloc_addr(msgs[idx].buf) || !len)
+			if (is_vmalloc_addr(msgs[idx].buf))
 				break;
+
+			total_len += msgs[idx].len;
 		}
 
-		if (idx == num)
+		if (idx == num && (total_len > qup->out_fifo_sz ||
+				   total_len > qup->in_fifo_sz))
 			qup->use_dma = true;
 	}
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
