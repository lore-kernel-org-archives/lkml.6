Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD82C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899EB20862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899EB20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388827AbeGZSgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:36:33 -0400
Received: from hermes.aosc.io ([199.195.250.187]:58365 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730085AbeGZSgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:36:33 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 70C919FAEE;
        Thu, 26 Jul 2018 17:18:37 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v3.1 09/10] drm/sun4i: Add support for HDMI voltage regulator
Date:   Fri, 27 Jul 2018 01:12:56 +0800
Message-Id: <20180726171257.6688-10-icenowy@aosc.io>
In-Reply-To: <20180726171257.6688-1-icenowy@aosc.io>
References: <20180726171257.6688-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

Some boards have HDMI VCC pin connected to voltage regulator which may
not be turned on by default.

Add support for such boards by adding voltage regulator handling code to
HDMI driver.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v3.1:
- New patch. (Replaced "drm: sun4i: add support for HVCC regulator
  for DWC HDMI glue" by Icenowy.)

 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 17 ++++++++++++++++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h |  2 ++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 31875b636434..bf7bf4f2fb29 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -125,10 +125,22 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 		return PTR_ERR(hdmi->clk_tmds);
 	}
 
+	hdmi->regulator = devm_regulator_get(dev, "hdmi");
+	if (IS_ERR(hdmi->regulator)) {
+		dev_err(dev, "Couldn't get regulator\n");
+		return PTR_ERR(hdmi->regulator);
+	}
+
+	ret = regulator_enable(hdmi->regulator);
+	if (ret) {
+		dev_err(dev, "Failed to enable regulator\n");
+		return ret;
+	}
+
 	ret = reset_control_deassert(hdmi->rst_ctrl);
 	if (ret) {
 		dev_err(dev, "Could not deassert ctrl reset control\n");
-		return ret;
+		goto err_disable_regulator;
 	}
 
 	ret = clk_prepare_enable(hdmi->clk_tmds);
@@ -183,6 +195,8 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	clk_disable_unprepare(hdmi->clk_tmds);
 err_assert_ctrl_reset:
 	reset_control_assert(hdmi->rst_ctrl);
+err_disable_regulator:
+	regulator_disable(hdmi->regulator);
 
 	return ret;
 }
@@ -196,6 +210,7 @@ static void sun8i_dw_hdmi_unbind(struct device *dev, struct device *master,
 	sun8i_hdmi_phy_remove(hdmi);
 	clk_disable_unprepare(hdmi->clk_tmds);
 	reset_control_assert(hdmi->rst_ctrl);
+	regulator_disable(hdmi->regulator);
 }
 
 static const struct component_ops sun8i_dw_hdmi_ops = {
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index aadbe0a10b0c..7fdc1ecd2892 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -10,6 +10,7 @@
 #include <drm/drm_encoder.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
 #define SUN8I_HDMI_PHY_DBG_CTRL_REG	0x0000
@@ -176,6 +177,7 @@ struct sun8i_dw_hdmi {
 	struct drm_encoder		encoder;
 	struct sun8i_hdmi_phy		*phy;
 	struct dw_hdmi_plat_data	plat_data;
+	struct regulator		*regulator;
 	struct reset_control		*rst_ctrl;
 };
 
-- 
2.18.0

