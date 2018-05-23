Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932313AbeEWJ4e (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:56:34 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35735 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932180AbeEWJ43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:56:29 -0400
X-Google-Smtp-Source: AB8JxZpUGvK3SvZ0A4m9iq3IihYe5oCwPXE7PYCvaSk5n5dad0EOJIHskM9i/oAxvNgZVVmjCkHcXA==
From: Esben Haabendal <esben.haabendal@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Esben Haabendal <eha@deif.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>,
        Phil Reid <preid@electromag.com.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Michail Georgios Etairidis <m.etairidis@beck-ipc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] i2c: imx: Fix reinit_completion() use
Date: Wed, 23 May 2018 11:56:20 +0200
Message-Id: <20180523095623.3347-2-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523095623.3347-1-esben.haabendal@gmail.com>
References: <20180523095623.3347-1-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

Make sure to call reinit_completion() before dma is started to avoid race
condition where reinit_compleition() is called after complete() and before
wait_for_completion_timeout().

Signed-off-by: Esben Haabendal <eha@deif.com>
---
 drivers/i2c/busses/i2c-imx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index d7267dd9c7bf..6fca5e64cffb 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -377,6 +377,7 @@ static int i2c_imx_dma_xfer(struct imx_i2c_struct *i2c_imx,
 		goto err_desc;
 	}
 
+	reinit_completion(&dma->cmd_complete);
 	txdesc->callback = i2c_imx_dma_callback;
 	txdesc->callback_param = i2c_imx;
 	if (dma_submit_error(dmaengine_submit(txdesc))) {
@@ -631,7 +632,6 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 	 * The first byte must be transmitted by the CPU.
 	 */
 	imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
-	reinit_completion(&i2c_imx->dma->cmd_complete);
 	time_left = wait_for_completion_timeout(
 				&i2c_imx->dma->cmd_complete,
 				msecs_to_jiffies(DMA_TIMEOUT));
@@ -690,7 +690,6 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 	if (result)
 		return result;
 
-	reinit_completion(&i2c_imx->dma->cmd_complete);
 	time_left = wait_for_completion_timeout(
 				&i2c_imx->dma->cmd_complete,
 				msecs_to_jiffies(DMA_TIMEOUT));
-- 
2.17.0
