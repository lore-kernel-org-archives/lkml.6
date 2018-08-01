Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6624DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1987C2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1987C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbeHAUM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:12:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46160 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404192AbeHATDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0785D1237;
        Wed,  1 Aug 2018 17:09:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>, stable@kernel.org
Subject: [PATCH 4.17 300/336] i2c: rcar: handle RXDMA HW behaviour on Gen3
Date:   Wed,  1 Aug 2018 18:50:35 +0200
Message-Id: <20180801165040.530258375@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 2b16fd63059ab9a46d473620749672dc342e1d21 upstream.

On Gen3, we can only do RXDMA once per transfer reliably. For that, we
must reset the device, then we can have RXDMA once. This patch
implements this. When there is no reset controller or the reset fails,
RXDMA will be blocked completely. Otherwise, it will be disabled after
the first RXDMA transfer. Based on a commit from the BSP by Hiromitsu
Yamasaki, yet completely refactored to handle multiple read messages
within one transfer.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-rcar.c |   54 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -32,6 +32,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 
 /* register offsets */
@@ -111,8 +112,9 @@
 #define ID_ARBLOST	(1 << 3)
 #define ID_NACK		(1 << 4)
 /* persistent flags */
+#define ID_P_NO_RXDMA	(1 << 30) /* HW forbids RXDMA sometimes */
 #define ID_P_PM_BLOCKED	(1 << 31)
-#define ID_P_MASK	ID_P_PM_BLOCKED
+#define ID_P_MASK	(ID_P_PM_BLOCKED | ID_P_NO_RXDMA)
 
 enum rcar_i2c_type {
 	I2C_RCAR_GEN1,
@@ -141,6 +143,8 @@ struct rcar_i2c_priv {
 	struct dma_chan *dma_rx;
 	struct scatterlist sg;
 	enum dma_data_direction dma_direction;
+
+	struct reset_control *rstc;
 };
 
 #define rcar_i2c_priv_to_dev(p)		((p)->adap.dev.parent)
@@ -370,6 +374,11 @@ static void rcar_i2c_dma_unmap(struct rc
 	dma_unmap_single(chan->device->dev, sg_dma_address(&priv->sg),
 			 sg_dma_len(&priv->sg), priv->dma_direction);
 
+	/* Gen3 can only do one RXDMA per transfer and we just completed it */
+	if (priv->devtype == I2C_RCAR_GEN3 &&
+	    priv->dma_direction == DMA_FROM_DEVICE)
+		priv->flags |= ID_P_NO_RXDMA;
+
 	priv->dma_direction = DMA_NONE;
 }
 
@@ -407,8 +416,9 @@ static void rcar_i2c_dma(struct rcar_i2c
 	unsigned char *buf;
 	int len;
 
-	/* Do not use DMA if it's not available or for messages < 8 bytes */
-	if (IS_ERR(chan) || msg->len < 8 || !(msg->flags & I2C_M_DMA_SAFE))
+	/* Do various checks to see if DMA is feasible at all */
+	if (IS_ERR(chan) || msg->len < 8 || !(msg->flags & I2C_M_DMA_SAFE) ||
+	    (read && priv->flags & ID_P_NO_RXDMA))
 		return;
 
 	if (read) {
@@ -737,6 +747,25 @@ static void rcar_i2c_release_dma(struct
 	}
 }
 
+/* I2C is a special case, we need to poll the status of a reset */
+static int rcar_i2c_do_reset(struct rcar_i2c_priv *priv)
+{
+	int i, ret;
+
+	ret = reset_control_reset(priv->rstc);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < LOOP_TIMEOUT; i++) {
+		ret = reset_control_status(priv->rstc);
+		if (ret == 0)
+			return 0;
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
 static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 				struct i2c_msg *msgs,
 				int num)
@@ -748,6 +777,16 @@ static int rcar_i2c_master_xfer(struct i
 
 	pm_runtime_get_sync(dev);
 
+	/* Gen3 needs a reset before allowing RXDMA once */
+	if (priv->devtype == I2C_RCAR_GEN3) {
+		priv->flags |= ID_P_NO_RXDMA;
+		if (!IS_ERR(priv->rstc)) {
+			ret = rcar_i2c_do_reset(priv);
+			if (ret == 0)
+				priv->flags &= ~ID_P_NO_RXDMA;
+		}
+	}
+
 	rcar_i2c_init(priv);
 
 	ret = rcar_i2c_bus_barrier(priv);
@@ -918,6 +957,15 @@ static int rcar_i2c_probe(struct platfor
 	if (ret < 0)
 		goto out_pm_put;
 
+	if (priv->devtype == I2C_RCAR_GEN3) {
+		priv->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+		if (!IS_ERR(priv->rstc)) {
+			ret = reset_control_status(priv->rstc);
+			if (ret < 0)
+				priv->rstc = ERR_PTR(-ENOTSUPP);
+		}
+	}
+
 	/* Stay always active when multi-master to keep arbitration working */
 	if (of_property_read_bool(dev->of_node, "multi-master"))
 		priv->flags |= ID_P_PM_BLOCKED;


