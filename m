Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B601DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AAC20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfB0SVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:21:48 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:41654 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfB0SVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:21:48 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 913A515632; Wed, 27 Feb 2019 18:21:46 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: imx: add support for I2C_M_STOP flag
Date:   Wed, 27 Feb 2019 18:21:37 +0000
Message-Id: <20190227182137.12100-1-mans@mansr.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the I2C_M_STOP flag to the i2c-imx driver.  This allows
devices requiring a stop between messages to work with this controller.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/i2c/busses/i2c-imx.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index c406700789e1..43b4d5bc2196 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -908,10 +908,17 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 
 	/* read/write data */
 	for (i = 0; i < num; i++) {
-		if (i == num - 1)
-			is_lastmsg = true;
+		if (is_lastmsg) {
+			/* previous message had I2C_M_STOP flag set */
+			temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+			temp |= I2CR_MSTA;
+			imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+			result = i2c_imx_bus_busy(i2c_imx, 1);
+			if (result)
+				goto fail0;
+		}
 
-		if (i) {
+		if (i && !is_lastmsg) {
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> repeated start\n", __func__);
 			temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
@@ -921,6 +928,10 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 			if (result)
 				goto fail0;
 		}
+
+		if (i == num - 1 || (msgs[i].flags & I2C_M_STOP))
+			is_lastmsg = true;
+
 		dev_dbg(&i2c_imx->adapter.dev,
 			"<%s> transfer message: %d\n", __func__, i);
 		/* write/read data */
@@ -948,6 +959,13 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 				result = i2c_imx_dma_write(i2c_imx, &msgs[i]);
 			else
 				result = i2c_imx_write(i2c_imx, &msgs[i]);
+
+			if (msgs[i].flags & I2C_M_STOP) {
+				temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+				temp &= ~I2CR_MSTA;
+				imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+				i2c_imx_bus_busy(i2c_imx, 0);
+			}
 		}
 		if (result)
 			goto fail0;
@@ -1034,7 +1052,7 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
 
 static u32 i2c_imx_func(struct i2c_adapter *adapter)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
+	return I2C_FUNC_I2C | I2C_FUNC_PROTOCOL_MANGLING | I2C_FUNC_SMBUS_EMUL
 		| I2C_FUNC_SMBUS_READ_BLOCK_DATA;
 }
 
-- 
2.20.1

