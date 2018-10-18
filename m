Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EB6C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBDE21486
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOAs5OX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBDE21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbeJSCER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729102AbeJSCER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:04:17 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12A7821479;
        Thu, 18 Oct 2018 18:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885731;
        bh=fYyZMYmxOAeN0yKtKVRV7WXt4hiGiAPfTNF2jyK+g/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LOAs5OX4XH+WDrAwz91mOLXAwix3cjka0lXLzIC94cN3aWHWxFamQAo5BTSvYGmm9
         PB12YAf0XYMMzt/h/bRiNJYosQZhmiqfjbFAyXDGhssJgkTq8NJxKMvmWbZVNF9Mxh
         xjbiID/gNT50g1s5lJdJ7YAC+b2H/+K8sDpNc0VU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>, stable@kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 40/41] i2c: rcar: handle RXDMA HW behaviour on Gen3
Date:   Thu, 18 Oct 2018 19:54:55 +0200
Message-Id: <20181018175423.512745849@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.718399607@linuxfoundation.org>
References: <20181018175416.718399607@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
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
@@ -140,6 +142,8 @@ struct rcar_i2c_priv {
 	struct dma_chan *dma_rx;
 	struct scatterlist sg;
 	enum dma_data_direction dma_direction;
+
+	struct reset_control *rstc;
 };
 
 #define rcar_i2c_priv_to_dev(p)		((p)->adap.dev.parent)
@@ -321,6 +325,11 @@ static void rcar_i2c_dma_unmap(struct rc
 	dma_unmap_single(chan->device->dev, sg_dma_address(&priv->sg),
 			 sg_dma_len(&priv->sg), priv->dma_direction);
 
+	/* Gen3 can only do one RXDMA per transfer and we just completed it */
+	if (priv->devtype == I2C_RCAR_GEN3 &&
+	    priv->dma_direction == DMA_FROM_DEVICE)
+		priv->flags |= ID_P_NO_RXDMA;
+
 	priv->dma_direction = DMA_NONE;
 }
 
@@ -358,8 +367,9 @@ static void rcar_i2c_dma(struct rcar_i2c
 	unsigned char *buf;
 	int len;
 
-	/* Do not use DMA if it's not available or for messages < 8 bytes */
-	if (IS_ERR(chan) || msg->len < 8)
+	/* Do various checks to see if DMA is feasible at all */
+	if (IS_ERR(chan) || msg->len < 8 ||
+	    (read && priv->flags & ID_P_NO_RXDMA))
 		return;
 
 	if (read) {
@@ -688,6 +698,25 @@ static void rcar_i2c_release_dma(struct
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
@@ -699,6 +728,16 @@ static int rcar_i2c_master_xfer(struct i
 
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
@@ -868,6 +907,15 @@ static int rcar_i2c_probe(struct platfor
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


