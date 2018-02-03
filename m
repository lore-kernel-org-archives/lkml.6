Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbeBCH7t (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 02:59:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35538 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbeBCH6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 02:58:46 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 73968608BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From: Abhishek Sahu <absahu@codeaurora.org>
To: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH 05/12] i2c: qup: fix the transfer length for BAM rx EOT FLUSH tags
Date: Sat,  3 Feb 2018 13:28:10 +0530
Message-Id: <1517644697-30806-6-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of FLUSH operation, BAM copies INPUT EOT FLUSH (0x94)
instead of normal EOT (0x93) tag in input data stream when an
input EOT tag is received during flush operation. So only one tag
will be written instead of 2 separate tags.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 6357aff..094be6a 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -768,10 +768,10 @@ static int qup_i2c_bam_do_xfer(struct qup_i2c_dev *qup, struct i2c_msg *msg,
 		qup->btx.tag.start[0] = QUP_BAM_INPUT_EOT;
 		len++;
 
-		/* scratch buf to read the BAM EOT and FLUSH tags */
+		/* scratch buf to read the BAM EOT FLUSH tags */
 		ret = qup_sg_set_buf(&qup->brx.sg[rx_buf++],
 				     &qup->brx.tag.start[0],
-				     2, qup, DMA_FROM_DEVICE);
+				     1, qup, DMA_FROM_DEVICE);
 		if (ret)
 			return ret;
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
