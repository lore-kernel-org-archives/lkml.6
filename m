Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932352AbeEWJ4n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:56:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38981 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932180AbeEWJ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:56:35 -0400
X-Google-Smtp-Source: AB8JxZo+X6SqLzZFZNTXs19ABCP1z2TLAgFp/6vpDUoBPg6Jq1K2Pbd0Nzur6dECuz9QZqx4jescvw==
From: Esben Haabendal <esben.haabendal@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Esben Haabendal <eha@deif.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michail Georgios Etairidis <m.etairidis@beck-ipc.com>,
        Wei Jinhua <wei.jinhua1@zte.com.cn>,
        Phil Reid <preid@electromag.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] i2c: imx: Simplify stopped state tracking
Date: Wed, 23 May 2018 11:56:22 +0200
Message-Id: <20180523095623.3347-4-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523095623.3347-1-esben.haabendal@gmail.com>
References: <20180523095623.3347-1-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

Always update the stopped state when busy status have been checked.
This is identical to what was done before, with the exception of error
handling.
Without this change, some errors cause the stopped state to be left in
incorrect state in i2c_imx_stop(), i2c_imx_dma_read(), i2c_imx_read() and
i2c_imx_xfer().

Signed-off-by: Esben Haabendal <eha@deif.com>
---
 drivers/i2c/busses/i2c-imx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 742b548437af..f9c99b123188 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -430,10 +430,14 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
 			return -EAGAIN;
 		}
 
-		if (for_busy && (temp & I2SR_IBB))
+		if (for_busy && (temp & I2SR_IBB)) {
+			i2c_imx->stopped = 0;
 			break;
-		if (!for_busy && !(temp & I2SR_IBB))
+		}
+		if (!for_busy && !(temp & I2SR_IBB)) {
+			i2c_imx->stopped = 1;
 			break;
+		}
 		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> I2C bus is busy\n", __func__);
@@ -547,7 +551,6 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
 	result = i2c_imx_bus_busy(i2c_imx, 1);
 	if (result)
 		return result;
-	i2c_imx->stopped = 0;
 
 	temp |= I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
 	temp &= ~I2CR_DMAEN;
@@ -578,7 +581,6 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
 
 	if (!i2c_imx->stopped) {
 		i2c_imx_bus_busy(i2c_imx, 0);
-		i2c_imx->stopped = 1;
 	}
 
 	/* Disable I2C controller */
@@ -733,7 +735,6 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 		temp &= ~(I2CR_MSTA | I2CR_MTX);
 		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 		i2c_imx_bus_busy(i2c_imx, 0);
-		i2c_imx->stopped = 1;
 	} else {
 		/*
 		 * For i2c master receiver repeat restart operation like:
@@ -861,7 +862,6 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 				temp &= ~(I2CR_MSTA | I2CR_MTX);
 				imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 				i2c_imx_bus_busy(i2c_imx, 0);
-				i2c_imx->stopped = 1;
 			} else {
 				/*
 				 * For i2c master receiver repeat restart operation like:
-- 
2.17.0
