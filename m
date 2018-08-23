Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99597C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7F921473
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7F921473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbeHWL1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:27:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41982 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeHWL1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:27:40 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BA2129D2;
        Thu, 23 Aug 2018 07:59:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 50/79] drm/armada: fix colorkey mode property
Date:   Thu, 23 Aug 2018 09:53:26 +0200
Message-Id: <20180823074922.391052029@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit d378859a667edc99e3473704847698cae97ca2b1 ]

The colorkey mode property was not correctly disabling the colorkeying
when "disabled" mode was selected.  Arrange for this to work as one
would expect.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/armada/armada_hw.h      |    1 +
 drivers/gpu/drm/armada/armada_overlay.c |   30 ++++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/armada/armada_hw.h
+++ b/drivers/gpu/drm/armada/armada_hw.h
@@ -160,6 +160,7 @@ enum {
 	CFG_ALPHAM_GRA		= 0x1 << 16,
 	CFG_ALPHAM_CFG		= 0x2 << 16,
 	CFG_ALPHA_MASK		= 0xff << 8,
+#define CFG_ALPHA(x)		((x) << 8)
 	CFG_PIXCMD_MASK		= 0xff,
 };
 
--- a/drivers/gpu/drm/armada/armada_overlay.c
+++ b/drivers/gpu/drm/armada/armada_overlay.c
@@ -27,6 +27,7 @@ struct armada_ovl_plane_properties {
 	uint16_t contrast;
 	uint16_t saturation;
 	uint32_t colorkey_mode;
+	uint32_t colorkey_enable;
 };
 
 struct armada_ovl_plane {
@@ -62,11 +63,13 @@ armada_ovl_update_attr(struct armada_ovl
 	writel_relaxed(0x00002000, dcrtc->base + LCD_SPU_CBSH_HUE);
 
 	spin_lock_irq(&dcrtc->irq_lock);
-	armada_updatel(prop->colorkey_mode | CFG_ALPHAM_GRA,
-		     CFG_CKMODE_MASK | CFG_ALPHAM_MASK | CFG_ALPHA_MASK,
-		     dcrtc->base + LCD_SPU_DMA_CTRL1);
-
-	armada_updatel(ADV_GRACOLORKEY, 0, dcrtc->base + LCD_SPU_ADV_REG);
+	armada_updatel(prop->colorkey_mode,
+		       CFG_CKMODE_MASK | CFG_ALPHAM_MASK | CFG_ALPHA_MASK,
+		       dcrtc->base + LCD_SPU_DMA_CTRL1);
+	if (dcrtc->variant->has_spu_adv_reg)
+		armada_updatel(prop->colorkey_enable,
+			       ADV_GRACOLORKEY | ADV_VIDCOLORKEY,
+			       dcrtc->base + LCD_SPU_ADV_REG);
 	spin_unlock_irq(&dcrtc->irq_lock);
 }
 
@@ -339,8 +342,17 @@ static int armada_ovl_plane_set_property
 		dplane->prop.colorkey_vb |= K2B(val);
 		update_attr = true;
 	} else if (property == priv->colorkey_mode_prop) {
-		dplane->prop.colorkey_mode &= ~CFG_CKMODE_MASK;
-		dplane->prop.colorkey_mode |= CFG_CKMODE(val);
+		if (val == CKMODE_DISABLE) {
+			dplane->prop.colorkey_mode =
+				CFG_CKMODE(CKMODE_DISABLE) |
+				CFG_ALPHAM_CFG | CFG_ALPHA(255);
+			dplane->prop.colorkey_enable = 0;
+		} else {
+			dplane->prop.colorkey_mode =
+				CFG_CKMODE(val) |
+				CFG_ALPHAM_GRA | CFG_ALPHA(0);
+			dplane->prop.colorkey_enable = ADV_GRACOLORKEY;
+		}
 		update_attr = true;
 	} else if (property == priv->brightness_prop) {
 		dplane->prop.brightness = val - 256;
@@ -469,7 +481,9 @@ int armada_overlay_plane_create(struct d
 	dplane->prop.colorkey_yr = 0xfefefe00;
 	dplane->prop.colorkey_ug = 0x01010100;
 	dplane->prop.colorkey_vb = 0x01010100;
-	dplane->prop.colorkey_mode = CFG_CKMODE(CKMODE_RGB);
+	dplane->prop.colorkey_mode = CFG_CKMODE(CKMODE_RGB) |
+				     CFG_ALPHAM_GRA | CFG_ALPHA(0);
+	dplane->prop.colorkey_enable = ADV_GRACOLORKEY;
 	dplane->prop.brightness = 0;
 	dplane->prop.contrast = 0x4000;
 	dplane->prop.saturation = 0x4000;


