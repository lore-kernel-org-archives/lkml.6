Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162172AbeCAVfW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:35:22 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:33171 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1162157AbeCAVfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:35:17 -0500
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org
Cc: jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 09/16] drm/sun4i: Fix polarity configuration for DW HDMI PHY
Date: Thu,  1 Mar 2018 22:34:35 +0100
Message-Id: <20180301213442.16677-10-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180301213442.16677-1-jernej.skrabec@siol.net>
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current polarity configuration code is cleary wrong since it compares
same flag two times. However, even if flag name is fixed, it won't work
well for resolutions which have one polarity positive and another
negative.

Fix that by properly set each bit according to each polarity. Since
those two bits are not described in any documentation, relationships
were obtained by experimentation.

Fixes: b7c7436a5ff0 ("drm/sun4i: Implement A83T HDMI driver")

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index e5bfcdd43ec9..9d2f11ca3538 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -10,7 +10,8 @@
 #define SUN8I_HDMI_PHY_DBG_CTRL_REG	0x0000
 #define SUN8I_HDMI_PHY_DBG_CTRL_PX_LOCK		BIT(0)
 #define SUN8I_HDMI_PHY_DBG_CTRL_POL_MASK	GENMASK(15, 8)
-#define SUN8I_HDMI_PHY_DBG_CTRL_POL(val)	(val << 8)
+#define SUN8I_HDMI_PHY_DBG_CTRL_POL_NHSYNC	BIT(8)
+#define SUN8I_HDMI_PHY_DBG_CTRL_POL_NVSYNC	BIT(9)
 #define SUN8I_HDMI_PHY_DBG_CTRL_ADDR_MASK	GENMASK(23, 16)
 #define SUN8I_HDMI_PHY_DBG_CTRL_ADDR(addr)	(addr << 16)
 
@@ -35,14 +36,14 @@ static int sun8i_hdmi_phy_config(struct dw_hdmi *hdmi, void *data,
 	struct sun8i_hdmi_phy *phy = (struct sun8i_hdmi_phy *)data;
 	u32 val = 0;
 
-	if ((mode->flags & DRM_MODE_FLAG_NHSYNC) &&
-	    (mode->flags & DRM_MODE_FLAG_NHSYNC)) {
-		val = 0x03;
-	}
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		val |= SUN8I_HDMI_PHY_DBG_CTRL_POL_NHSYNC;
+
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		val |= SUN8I_HDMI_PHY_DBG_CTRL_POL_NVSYNC;
 
 	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_DBG_CTRL_REG,
-			   SUN8I_HDMI_PHY_DBG_CTRL_POL_MASK,
-			   SUN8I_HDMI_PHY_DBG_CTRL_POL(val));
+			   SUN8I_HDMI_PHY_DBG_CTRL_POL_MASK, val);
 
 	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_REXT_CTRL_REG,
 			   SUN8I_HDMI_PHY_REXT_CTRL_REXT_EN,
-- 
2.16.2
