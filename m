Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932421AbeCLNQF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:16:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42400 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932333AbeCLNQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:16:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CFA0603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From: Abhishek Sahu <absahu@codeaurora.org>
To: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Austin Christ <austinwc@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH v2 11/13] i2c: qup: send NACK for last read sub transfers
Date: Mon, 12 Mar 2018 18:45:00 +0530
Message-Id: <1520860502-14886-12-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
References: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to I2c specification, “If a master-receiver sends a
repeated START condition, it sends a not-acknowledge (A) just
before the repeated START condition”. QUP v2 supports sending
of NACK without stop with QUP_TAG_V2_DATARD_NACK so added the
same.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
Reviewed-by: Austin Christ <austinwc@codeaurora.org>
Reviewed-by: Andy Gross <andy.gross@linaro.org>
---

* Changes from v1: None

 drivers/i2c/busses/i2c-qup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 5bb7ebe..4ebd922 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -104,6 +104,7 @@
 #define QUP_TAG_V2_DATAWR              0x82
 #define QUP_TAG_V2_DATAWR_STOP         0x83
 #define QUP_TAG_V2_DATARD              0x85
+#define QUP_TAG_V2_DATARD_NACK         0x86
 #define QUP_TAG_V2_DATARD_STOP         0x87
 
 /* Status, Error flags */
@@ -606,7 +607,9 @@ static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
 			tags[len++] = QUP_TAG_V2_DATAWR_STOP;
 	} else {
 		if (msg->flags & I2C_M_RD)
-			tags[len++] = QUP_TAG_V2_DATARD;
+			tags[len++] = qup->blk.pos == (qup->blk.count - 1) ?
+				      QUP_TAG_V2_DATARD_NACK :
+				      QUP_TAG_V2_DATARD;
 		else
 			tags[len++] = QUP_TAG_V2_DATAWR;
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
