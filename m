Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1A5C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A24223E2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HiGKqG0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A24223E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933561AbeGFPAP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:00:15 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44346 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932962AbeGFO7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W2vcGN+gPiy72R95n6vHJ29F5AAOF8ZZacSy/5HixeQ=; b=HiGKqG0NSxvVF5WR6/r7bNtzMK
        ynk5879rX8A/S5OZFksHy7AdjoQWO8SrDaaOLfMXKSanCBYnNUXHe5xX1/KqWSws6qB4cf78hfJJb
        2Sc76/P/cFFLEcZPpeaIV6u02dJVf3uj3fanxurhGfJDjiZPBSIJ4SAB+DRmgbVsVDFc=;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:46478 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1fbSCZ-0006OP-Bd; Fri, 06 Jul 2018 15:59:15 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1fbSCT-00076w-SL; Fri, 06 Jul 2018 15:59:09 +0100
In-Reply-To: <20180706145748.GA17271@n2100.armlinux.org.uk>
References: <20180706145748.GA17271@n2100.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Peter Rosin <peda@axentia.se>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jsarha@ti.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/6] drm/i2c: tda998x: allocate tda998x_priv inside
 tda998x_create()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1fbSCT-00076w-SL@rmk-PC.armlinux.org.uk>
Date:   Fri, 06 Jul 2018 15:59:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the tda998x_priv allocation inside tda998x_create() and simplify
the tda998x_create()'s arguments.  Pass the same to tda998x_destroy().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 53f110e7d433..08ccaf8cf852 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1562,8 +1562,10 @@ static const struct drm_bridge_funcs tda998x_bridge_funcs = {
 	.enable = tda998x_bridge_enable,
 };
 
-static void tda998x_destroy(struct tda998x_priv *priv)
+static void tda998x_destroy(struct device *dev)
 {
+	struct tda998x_priv *priv = dev_get_drvdata(dev);
+
 	drm_bridge_remove(&priv->bridge);
 
 	/* disable all IRQs and free the IRQ handler */
@@ -1648,13 +1650,21 @@ static void tda998x_set_config(struct tda998x_priv *priv,
 	priv->audio_params = p->audio_params;
 }
 
-static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
+static int tda998x_create(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct device_node *np = client->dev.of_node;
 	struct i2c_board_info cec_info;
+	struct tda998x_priv *priv;
 	u32 video;
 	int rev_lo, rev_hi, ret;
 
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, priv);
+
 	mutex_init(&priv->mutex);	/* protect the page access */
 	mutex_init(&priv->audio_mutex); /* protect access from audio thread */
 	mutex_init(&priv->edid_mutex);
@@ -1831,7 +1841,7 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 	return 0;
 
 fail:
-	tda998x_destroy(priv);
+	tda998x_destroy(dev);
 err_irq:
 	return ret;
 }
@@ -1883,30 +1893,22 @@ static int tda998x_encoder_init(struct device *dev, struct drm_device *drm)
 
 static int tda998x_bind(struct device *dev, struct device *master, void *data)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct drm_device *drm = data;
-	struct tda998x_priv *priv;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	dev_set_drvdata(dev, priv);
-
-	ret = tda998x_create(client, priv);
+	ret = tda998x_create(dev);
 	if (ret)
 		return ret;
 
 	ret = tda998x_encoder_init(dev, drm);
 	if (ret) {
-		tda998x_destroy(priv);
+		tda998x_destroy(dev);
 		return ret;
 	}
 	return 0;
 
 err_encoder:
-	tda998x_destroy(priv);
+	tda998x_destroy(dev);
 	return ret;
 }
 
@@ -1917,7 +1919,7 @@ static void tda998x_unbind(struct device *dev, struct device *master,
 
 	drm_connector_cleanup(&priv->connector);
 	drm_encoder_cleanup(&priv->encoder);
-	tda998x_destroy(priv);
+	tda998x_destroy(dev);
 }
 
 static const struct component_ops tda998x_ops = {
-- 
2.7.4

