Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932457AbeEWJ6H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:58:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35007 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932291AbeEWJ4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:56:32 -0400
X-Google-Smtp-Source: AB8JxZqXi1VWW9H4zbb1DXxmMgCv+9hlrqqoHJL4//jcT6xL1oOLhuNcfz+E6RIBWPtHFMvsKz2abQ==
From: Esben Haabendal <esben.haabendal@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Esben Haabendal <eha@deif.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Phil Reid <preid@electromag.com.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Wei Jinhua <wei.jinhua1@zte.com.cn>,
        Michail Georgios Etairidis <m.etairidis@beck-ipc.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] i2c: imx: Fix race condition in dma read
Date: Wed, 23 May 2018 11:56:21 +0200
Message-Id: <20180523095623.3347-3-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180523095623.3347-1-esben.haabendal@gmail.com>
References: <20180523095623.3347-1-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

This fixes a race condition, where the DMAEN bit ends up being set after
I2C slave has transmitted a byte following the dummy read.  When that
happens, an interrupt is generated instead, and no DMA request is generated
to kickstart the DMA read, and a timeout happens after DMA_TIMEOUT (1 sec).

Fixed by setting the DMAEN bit before the dummy read.

Signed-off-by: Esben Haabendal <eha@deif.com>
---
 drivers/i2c/busses/i2c-imx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 6fca5e64cffb..742b548437af 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -677,9 +677,6 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 	struct imx_i2c_dma *dma = i2c_imx->dma;
 	struct device *dev = &i2c_imx->adapter.dev;
 
-	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
-	temp |= I2CR_DMAEN;
-	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 
 	dma->chan_using = dma->chan_rx;
 	dma->dma_transfer_dir = DMA_DEV_TO_MEM;
@@ -819,6 +816,11 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 	if ((msgs->len - 1) || block_data)
 		temp &= ~I2CR_TXAK;
 	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+	if (i2c_imx->dma && msgs->len >= DMA_THRESHOLD && !block_data) {
+		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+		temp |= I2CR_DMAEN;
+		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+	}
 	imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR); /* dummy read */
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> read data\n", __func__);
-- 
2.17.0
