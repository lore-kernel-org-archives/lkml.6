Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C69C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF000223DF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hgmbHSc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF000223DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933544AbeGFO7w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:59:52 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44360 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932984AbeGFO7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DIcTJBqD9rOtzo+LKCRX0UQjfQXx8o037ETZcLpgvWc=; b=hgmbHSc3gP++2ODYokwqOLQXMN
        8T0OmqNgjP223njtW7BrErJTpvzWzad2okClgguRRTm8AidPYMLcD6IpSoX7P3bnRUFKSLmRzqxWC
        YvnP1/lTMZC07wU4t7gmmsSADj1kCSYqu0VucHhUMF8+Ae34MGdzItIzOgptLN5gHECw=;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36536 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1fbSCf-0006OW-2L; Fri, 06 Jul 2018 15:59:21 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1fbSCZ-000773-0U; Fri, 06 Jul 2018 15:59:15 +0100
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
Subject: [PATCH 6/6] drm/i2c: tda998x: cleanup from previous changes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1fbSCZ-000773-0U@rmk-PC.armlinux.org.uk>
Date:   Fri, 06 Jul 2018 15:59:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the code a little from the effects of the previous changes:
- Move tda998x_destroy() to be above tda998x_create()
- Use 'dev' directly in tda998x_create() where appropriate.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 76 +++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 08ccaf8cf852..6f74b3451567 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1562,31 +1562,6 @@ static const struct drm_bridge_funcs tda998x_bridge_funcs = {
 	.enable = tda998x_bridge_enable,
 };
 
-static void tda998x_destroy(struct device *dev)
-{
-	struct tda998x_priv *priv = dev_get_drvdata(dev);
-
-	drm_bridge_remove(&priv->bridge);
-
-	/* disable all IRQs and free the IRQ handler */
-	cec_write(priv, REG_CEC_RXSHPDINTENA, 0);
-	reg_clear(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
-
-	if (priv->audio_pdev)
-		platform_device_unregister(priv->audio_pdev);
-
-	if (priv->hdmi->irq)
-		free_irq(priv->hdmi->irq, priv);
-
-	del_timer_sync(&priv->edid_delay_timer);
-	cancel_work_sync(&priv->detect_work);
-
-	i2c_unregister_device(priv->cec);
-
-	if (priv->cec_notify)
-		cec_notifier_put(priv->cec_notify);
-}
-
 /* I2C driver functions */
 
 static int tda998x_get_audio_ports(struct tda998x_priv *priv,
@@ -1650,6 +1625,31 @@ static void tda998x_set_config(struct tda998x_priv *priv,
 	priv->audio_params = p->audio_params;
 }
 
+static void tda998x_destroy(struct device *dev)
+{
+	struct tda998x_priv *priv = dev_get_drvdata(dev);
+
+	drm_bridge_remove(&priv->bridge);
+
+	/* disable all IRQs and free the IRQ handler */
+	cec_write(priv, REG_CEC_RXSHPDINTENA, 0);
+	reg_clear(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
+
+	if (priv->audio_pdev)
+		platform_device_unregister(priv->audio_pdev);
+
+	if (priv->hdmi->irq)
+		free_irq(priv->hdmi->irq, priv);
+
+	del_timer_sync(&priv->edid_delay_timer);
+	cancel_work_sync(&priv->detect_work);
+
+	i2c_unregister_device(priv->cec);
+
+	if (priv->cec_notify)
+		cec_notifier_put(priv->cec_notify);
+}
+
 static int tda998x_create(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1691,13 +1691,13 @@ static int tda998x_create(struct device *dev)
 	/* read version: */
 	rev_lo = reg_read(priv, REG_VERSION_LSB);
 	if (rev_lo < 0) {
-		dev_err(&client->dev, "failed to read version: %d\n", rev_lo);
+		dev_err(dev, "failed to read version: %d\n", rev_lo);
 		return rev_lo;
 	}
 
 	rev_hi = reg_read(priv, REG_VERSION_MSB);
 	if (rev_hi < 0) {
-		dev_err(&client->dev, "failed to read version: %d\n", rev_hi);
+		dev_err(dev, "failed to read version: %d\n", rev_hi);
 		return rev_hi;
 	}
 
@@ -1708,20 +1708,19 @@ static int tda998x_create(struct device *dev)
 
 	switch (priv->rev) {
 	case TDA9989N2:
-		dev_info(&client->dev, "found TDA9989 n2");
+		dev_info(dev, "found TDA9989 n2");
 		break;
 	case TDA19989:
-		dev_info(&client->dev, "found TDA19989");
+		dev_info(dev, "found TDA19989");
 		break;
 	case TDA19989N2:
-		dev_info(&client->dev, "found TDA19989 n2");
+		dev_info(dev, "found TDA19989 n2");
 		break;
 	case TDA19988:
-		dev_info(&client->dev, "found TDA19988");
+		dev_info(dev, "found TDA19988");
 		break;
 	default:
-		dev_err(&client->dev, "found unsupported device: %04x\n",
-			priv->rev);
+		dev_err(dev, "found unsupported device: %04x\n", priv->rev);
 		return -ENXIO;
 	}
 
@@ -1764,8 +1763,7 @@ static int tda998x_create(struct device *dev)
 					   tda998x_irq_thread, irq_flags,
 					   "tda998x", priv);
 		if (ret) {
-			dev_err(&client->dev,
-				"failed to request IRQ#%u: %d\n",
+			dev_err(dev, "failed to request IRQ#%u: %d\n",
 				client->irq, ret);
 			goto err_irq;
 		}
@@ -1774,13 +1772,13 @@ static int tda998x_create(struct device *dev)
 		cec_write(priv, REG_CEC_RXSHPDINTENA, CEC_RXSHPDLEV_HPD);
 	}
 
-	priv->cec_notify = cec_notifier_get(&client->dev);
+	priv->cec_notify = cec_notifier_get(dev);
 	if (!priv->cec_notify) {
 		ret = -ENOMEM;
 		goto fail;
 	}
 
-	priv->cec_glue.parent = &client->dev;
+	priv->cec_glue.parent = dev;
 	priv->cec_glue.data = priv;
 	priv->cec_glue.init = tda998x_cec_hook_init;
 	priv->cec_glue.exit = tda998x_cec_hook_exit;
@@ -1826,9 +1824,7 @@ static int tda998x_create(struct device *dev)
 		if (priv->audio_port[0].format != AFMT_UNUSED)
 			tda998x_audio_codec_init(priv, &client->dev);
 	} else {
-		struct tda998x_encoder_params *params;
-
-		params = client->dev.platform_data;
+		struct tda998x_encoder_params *params = dev->platform_data;
 		if (params)
 			tda998x_set_config(priv, params);
 	}
-- 
2.7.4

