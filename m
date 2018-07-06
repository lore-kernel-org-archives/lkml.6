Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B08C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E68A223DF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gkASNnzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E68A223DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933471AbeGFO7g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:59:36 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44298 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932984AbeGFO7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WO5xgQ41AkjI0W4qPuMo00Xflz8g696ogpKJmfkc97A=; b=gkASNnzuDbIJxRLZPR/WMgFQLl
        cJcmpVNBExqaqNF3fKVl2klfBG8y5i7fZSUnm/MNwHHU0SJSGx9GJN/MO/rKeH3Tamz/tPEJyKk5c
        fFjwe70QH5gat4GS2bX8vLrIz2oJF/okrKLcS8Y1mA9+M/0RwWlg8mvLFnJ49CtVDstU=;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:46474 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1fbSCM-0006O1-5g; Fri, 06 Jul 2018 15:59:02 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1fbSCJ-00076i-Hr; Fri, 06 Jul 2018 15:58:59 +0100
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
Subject: [PATCH 3/6] drm/i2c: tda998x: move tda998x_set_config() into
 tda998x_create()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1fbSCJ-00076i-Hr@rmk-PC.armlinux.org.uk>
Date:   Fri, 06 Jul 2018 15:58:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the non-DT configuration of the TDA998x into tda998x_create()
so that we do all setup in one place.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 75 ++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index e9a038a7bb30..931135db979c 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1621,6 +1621,25 @@ static int tda998x_get_audio_ports(struct tda998x_priv *priv,
 	return 0;
 }
 
+static void tda998x_set_config(struct tda998x_priv *priv,
+			       const struct tda998x_encoder_params *p)
+{
+	priv->vip_cntrl_0 = VIP_CNTRL_0_SWAP_A(p->swap_a) |
+			    (p->mirr_a ? VIP_CNTRL_0_MIRR_A : 0) |
+			    VIP_CNTRL_0_SWAP_B(p->swap_b) |
+			    (p->mirr_b ? VIP_CNTRL_0_MIRR_B : 0);
+	priv->vip_cntrl_1 = VIP_CNTRL_1_SWAP_C(p->swap_c) |
+			    (p->mirr_c ? VIP_CNTRL_1_MIRR_C : 0) |
+			    VIP_CNTRL_1_SWAP_D(p->swap_d) |
+			    (p->mirr_d ? VIP_CNTRL_1_MIRR_D : 0);
+	priv->vip_cntrl_2 = VIP_CNTRL_2_SWAP_E(p->swap_e) |
+			    (p->mirr_e ? VIP_CNTRL_2_MIRR_E : 0) |
+			    VIP_CNTRL_2_SWAP_F(p->swap_f) |
+			    (p->mirr_f ? VIP_CNTRL_2_MIRR_F : 0);
+
+	priv->audio_params = p->audio_params;
+}
+
 static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 {
 	struct device_node *np = client->dev.of_node;
@@ -1772,23 +1791,28 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 	/* enable EDID read irq: */
 	reg_set(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
 
-	if (!np)
-		return 0;		/* non-DT */
+	if (np) {
+		/* get the device tree parameters */
+		ret = of_property_read_u32(np, "video-ports", &video);
+		if (ret == 0) {
+			priv->vip_cntrl_0 = video >> 16;
+			priv->vip_cntrl_1 = video >> 8;
+			priv->vip_cntrl_2 = video;
+		}
 
-	/* get the device tree parameters */
-	ret = of_property_read_u32(np, "video-ports", &video);
-	if (ret == 0) {
-		priv->vip_cntrl_0 = video >> 16;
-		priv->vip_cntrl_1 = video >> 8;
-		priv->vip_cntrl_2 = video;
-	}
+		ret = tda998x_get_audio_ports(priv, np);
+		if (ret)
+			goto fail;
 
-	ret = tda998x_get_audio_ports(priv, np);
-	if (ret)
-		goto fail;
+		if (priv->audio_port[0].format != AFMT_UNUSED)
+			tda998x_audio_codec_init(priv, &client->dev);
+	} else {
+		struct tda998x_encoder_params *params;
 
-	if (priv->audio_port[0].format != AFMT_UNUSED)
-		tda998x_audio_codec_init(priv, &client->dev);
+		params = client->dev.platform_data;
+		if (params)
+			tda998x_set_config(priv, params);
+	}
 
 	return 0;
 
@@ -1835,28 +1859,8 @@ static const struct drm_encoder_funcs tda998x_encoder_funcs = {
 	.destroy = tda998x_encoder_destroy,
 };
 
-static void tda998x_set_config(struct tda998x_priv *priv,
-			       const struct tda998x_encoder_params *p)
-{
-	priv->vip_cntrl_0 = VIP_CNTRL_0_SWAP_A(p->swap_a) |
-			    (p->mirr_a ? VIP_CNTRL_0_MIRR_A : 0) |
-			    VIP_CNTRL_0_SWAP_B(p->swap_b) |
-			    (p->mirr_b ? VIP_CNTRL_0_MIRR_B : 0);
-	priv->vip_cntrl_1 = VIP_CNTRL_1_SWAP_C(p->swap_c) |
-			    (p->mirr_c ? VIP_CNTRL_1_MIRR_C : 0) |
-			    VIP_CNTRL_1_SWAP_D(p->swap_d) |
-			    (p->mirr_d ? VIP_CNTRL_1_MIRR_D : 0);
-	priv->vip_cntrl_2 = VIP_CNTRL_2_SWAP_E(p->swap_e) |
-			    (p->mirr_e ? VIP_CNTRL_2_MIRR_E : 0) |
-			    VIP_CNTRL_2_SWAP_F(p->swap_f) |
-			    (p->mirr_f ? VIP_CNTRL_2_MIRR_F : 0);
-
-	priv->audio_params = p->audio_params;
-}
-
 static int tda998x_bind(struct device *dev, struct device *master, void *data)
 {
-	struct tda998x_encoder_params *params = dev->platform_data;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct drm_device *drm = data;
 	struct tda998x_priv *priv;
@@ -1884,9 +1888,6 @@ static int tda998x_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
-	if (!dev->of_node && params)
-		tda998x_set_config(priv, params);
-
 	drm_encoder_helper_add(&priv->encoder, &tda998x_encoder_helper_funcs);
 	ret = drm_encoder_init(drm, &priv->encoder, &tda998x_encoder_funcs,
 			       DRM_MODE_ENCODER_TMDS, NULL);
-- 
2.7.4

