Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2C9C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 12:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AD32157F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 12:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86AD32157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbeHOPAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 11:00:49 -0400
Received: from hermes.aosc.io ([199.195.250.187]:54714 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728810AbeHOPAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 11:00:49 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 87292BE73E;
        Wed, 15 Aug 2018 12:08:42 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>,
        stable@vger.kernel.org
Subject: [PATCH] drm: sun4i: exclusively set HDMI-related clocks for dw-hdmi
Date:   Wed, 15 Aug 2018 20:07:45 +0800
Message-Id: <20180815120745.36593-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The glue in sun4i-drm of dw-hdmi currently doesn't set the clocks of
dw-hdmi exclusively, which will lead the display fails to initialize in
some situations.

Add the exclusivity to sun8i-dw-hdmi and sun8i-hdmi-phy.

Cc: stable@vger.kernel.org # v4.17+
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c  | 11 ++++++++++-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c |  7 +++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 31875b636434..a10220518548 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -137,10 +137,16 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 		goto err_assert_ctrl_reset;
 	}
 
+	ret = clk_rate_exclusive_get(hdmi->clk_tmds);
+	if (ret) {
+		dev_err(dev, "Could not get exclusivity over the tmds clock\n");
+		goto err_disable_clk_tmds;
+	}
+
 	phy_node = of_parse_phandle(dev->of_node, "phys", 0);
 	if (!phy_node) {
 		dev_err(dev, "Can't found PHY phandle\n");
-		goto err_disable_clk_tmds;
+		goto err_put_clk_tmds_exclusivity;
 	}
 
 	ret = sun8i_hdmi_phy_probe(hdmi, phy_node);
@@ -179,6 +185,8 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 cleanup_encoder:
 	drm_encoder_cleanup(encoder);
 	sun8i_hdmi_phy_remove(hdmi);
+err_put_clk_tmds_exclusivity:
+	clk_rate_exclusive_put(hdmi->clk_tmds);
 err_disable_clk_tmds:
 	clk_disable_unprepare(hdmi->clk_tmds);
 err_assert_ctrl_reset:
@@ -194,6 +202,7 @@ static void sun8i_dw_hdmi_unbind(struct device *dev, struct device *master,
 
 	dw_hdmi_unbind(hdmi->hdmi);
 	sun8i_hdmi_phy_remove(hdmi);
+	clk_rate_exclusive_put(hdmi->clk_tmds);
 	clk_disable_unprepare(hdmi->clk_tmds);
 	reset_control_assert(hdmi->rst_ctrl);
 }
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 82502b351aec..1e0b1d9bc0fb 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -511,13 +511,14 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
 		}
 
 		clk_prepare_enable(phy->clk_phy);
+		clk_rate_exclusive_get(phy->clk_phy);
 	}
 
 	phy->rst_phy = of_reset_control_get_shared(node, "phy");
 	if (IS_ERR(phy->rst_phy)) {
 		dev_err(dev, "Could not get phy reset control\n");
 		ret = PTR_ERR(phy->rst_phy);
-		goto err_disable_clk_phy;
+		goto err_put_clk_phy_exclusivity;
 	}
 
 	ret = reset_control_deassert(phy->rst_phy);
@@ -548,7 +549,8 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
 	reset_control_assert(phy->rst_phy);
 err_put_rst_phy:
 	reset_control_put(phy->rst_phy);
-err_disable_clk_phy:
+err_put_clk_phy_exclusivity:
+	clk_rate_exclusive_put(phy->clk_phy);
 	clk_disable_unprepare(phy->clk_phy);
 err_put_clk_pll1:
 	clk_put(phy->clk_pll1);
@@ -568,6 +570,7 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi)
 
 	clk_disable_unprepare(phy->clk_mod);
 	clk_disable_unprepare(phy->clk_bus);
+	clk_rate_exclusive_put(phy->clk_phy);
 	clk_disable_unprepare(phy->clk_phy);
 
 	reset_control_assert(phy->rst_phy);
-- 
2.18.0

