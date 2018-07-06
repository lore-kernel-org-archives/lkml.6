Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B424C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B2B223DF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="T8HYurWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B2B223DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbeGFO7S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:59:18 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44254 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932769AbeGFO7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kGt6vzS/H42JUC4NgT6W9qMNXW28pa0z6LBzPRpAuEQ=; b=T8HYurWD7j8ZSmuZwl2S6xSdPQ
        8mmzMMUvfv7Z0m1th75/aXygqhx/SCLQmzYR6l+7tsGoWkgg0IzuEV+Qp71SiG2EVCXfnQgcx9pqt
        wGkLr+ojYIdsBtp4fvBz+bV8lwxlAy+IFM7yWatlToBmJgIIvb31WbvJy/AFRREfSIIw=;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:45958 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1fbSCF-0006Nq-7o; Fri, 06 Jul 2018 15:58:55 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1fbSCE-00076b-EO; Fri, 06 Jul 2018 15:58:54 +0100
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
Subject: [PATCH 2/6] drm/i2c: tda998x: split tda998x_encoder_dpms into
 enable/disable
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1fbSCE-00076b-EO@rmk-PC.armlinux.org.uk>
Date:   Fri, 06 Jul 2018 15:58:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

This fits better with the drm_bridge callbacks for when this
driver becomes a drm_bridge.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
[edited by rmk to just split the tda998x_encoder_dpms() function
 and restore the double-disable protection we originally had,
 preserving original behaviour.]
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 4061e293e671..e9a038a7bb30 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1299,18 +1299,9 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
 
 /* DRM encoder functions */
 
-static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
+static void tda998x_enable(struct tda998x_priv *priv)
 {
-	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
-	bool on;
-
-	/* we only care about on or off: */
-	on = mode == DRM_MODE_DPMS_ON;
-
-	if (on == priv->is_on)
-		return;
-
-	if (on) {
+	if (!priv->is_on) {
 		/* enable video ports, audio will be enabled later */
 		reg_write(priv, REG_ENA_VP_0, 0xff);
 		reg_write(priv, REG_ENA_VP_1, 0xff);
@@ -1321,7 +1312,12 @@ static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
 		reg_write(priv, REG_VIP_CNTRL_2, priv->vip_cntrl_2);
 
 		priv->is_on = true;
-	} else {
+	}
+}
+
+static void tda998x_disable(struct tda998x_priv *priv)
+{
+	if (!priv->is_on) {
 		/* disable video ports */
 		reg_write(priv, REG_ENA_VP_0, 0x00);
 		reg_write(priv, REG_ENA_VP_1, 0x00);
@@ -1331,6 +1327,23 @@ static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
 	}
 }
 
+static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
+{
+	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
+	bool on;
+
+	/* we only care about on or off: */
+	on = mode == DRM_MODE_DPMS_ON;
+
+	if (on == priv->is_on)
+		return;
+
+	if (on)
+		tda998x_enable(priv);
+	else
+		tda998x_disable(priv);
+}
+
 static void
 tda998x_encoder_mode_set(struct drm_encoder *encoder,
 			 struct drm_display_mode *mode,
-- 
2.7.4

