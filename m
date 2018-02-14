Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031500AbeBNUJ7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 15:09:59 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:36769 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031347AbeBNUJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 15:09:44 -0500
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, narmstrong@baylibre.com,
        Jose.Abreu@synopsys.com
Cc: jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v5 04/12] drm/bridge/synopsys: dw-hdmi: Export some PHY related functions
Date: Wed, 14 Feb 2018 21:08:58 +0100
Message-Id: <20180214200906.31509-5-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180214200906.31509-1-jernej.skrabec@siol.net>
References: <20180214200906.31509-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parts of PHY code could be useful also for custom PHYs. For example,
Allwinner A83T has custom PHY which is probably Synopsys gen2 PHY
with few additional memory mapped registers, so most of the Synopsys PHY
related code could be reused.

Functions exported here are actually not specific to Synopsys PHYs but
to DWC HDMI controller PHY interface. This means that even if the PHY is
completely custom, i.e. not designed by Synopsys, exported functions can
be useful.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 44 +++++++++++++++++++++----------
 drivers/gpu/drm/meson/meson_dw_hdmi.c     |  8 +++---
 include/drm/bridge/dw_hdmi.h              | 11 ++++++++
 3 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 7ca14d7325b5..7d80f4b56683 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1037,19 +1037,21 @@ static void dw_hdmi_phy_enable_svsret(struct dw_hdmi *hdmi, u8 enable)
 			 HDMI_PHY_CONF0_SVSRET_MASK);
 }
 
-static void dw_hdmi_phy_gen2_pddq(struct dw_hdmi *hdmi, u8 enable)
+void dw_hdmi_phy_gen2_pddq(struct dw_hdmi *hdmi, u8 enable)
 {
 	hdmi_mask_writeb(hdmi, enable, HDMI_PHY_CONF0,
 			 HDMI_PHY_CONF0_GEN2_PDDQ_OFFSET,
 			 HDMI_PHY_CONF0_GEN2_PDDQ_MASK);
 }
+EXPORT_SYMBOL_GPL(dw_hdmi_phy_gen2_pddq);
 
-static void dw_hdmi_phy_gen2_txpwron(struct dw_hdmi *hdmi, u8 enable)
+void dw_hdmi_phy_gen2_txpwron(struct dw_hdmi *hdmi, u8 enable)
 {
 	hdmi_mask_writeb(hdmi, enable, HDMI_PHY_CONF0,
 			 HDMI_PHY_CONF0_GEN2_TXPWRON_OFFSET,
 			 HDMI_PHY_CONF0_GEN2_TXPWRON_MASK);
 }
+EXPORT_SYMBOL_GPL(dw_hdmi_phy_gen2_txpwron);
 
 static void dw_hdmi_phy_sel_data_en_pol(struct dw_hdmi *hdmi, u8 enable)
 {
@@ -1065,6 +1067,22 @@ static void dw_hdmi_phy_sel_interface_control(struct dw_hdmi *hdmi, u8 enable)
 			 HDMI_PHY_CONF0_SELDIPIF_MASK);
 }
 
+void dw_hdmi_phy_reset(struct dw_hdmi *hdmi)
+{
+	/* PHY reset. The reset signal is active high on Gen2 PHYs. */
+	hdmi_writeb(hdmi, HDMI_MC_PHYRSTZ_PHYRSTZ, HDMI_MC_PHYRSTZ);
+	hdmi_writeb(hdmi, 0, HDMI_MC_PHYRSTZ);
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_phy_reset);
+
+void dw_hdmi_phy_i2c_set_addr(struct dw_hdmi *hdmi, u8 address)
+{
+	hdmi_phy_test_clear(hdmi, 1);
+	hdmi_writeb(hdmi, address, HDMI_PHY_I2CM_SLAVE_ADDR);
+	hdmi_phy_test_clear(hdmi, 0);
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_phy_i2c_set_addr);
+
 static void dw_hdmi_phy_power_off(struct dw_hdmi *hdmi)
 {
 	const struct dw_hdmi_phy_data *phy = hdmi->phy.data;
@@ -1203,16 +1221,11 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi)
 	if (phy->has_svsret)
 		dw_hdmi_phy_enable_svsret(hdmi, 1);
 
-	/* PHY reset. The reset signal is active high on Gen2 PHYs. */
-	hdmi_writeb(hdmi, HDMI_MC_PHYRSTZ_PHYRSTZ, HDMI_MC_PHYRSTZ);
-	hdmi_writeb(hdmi, 0, HDMI_MC_PHYRSTZ);
+	dw_hdmi_phy_reset(hdmi);
 
 	hdmi_writeb(hdmi, HDMI_MC_HEACPHY_RST_ASSERT, HDMI_MC_HEACPHY_RST);
 
-	hdmi_phy_test_clear(hdmi, 1);
-	hdmi_writeb(hdmi, HDMI_PHY_I2CM_SLAVE_ADDR_PHY_GEN2,
-		    HDMI_PHY_I2CM_SLAVE_ADDR);
-	hdmi_phy_test_clear(hdmi, 0);
+	dw_hdmi_phy_i2c_set_addr(hdmi, HDMI_PHY_I2CM_SLAVE_ADDR_PHY_GEN2);
 
 	/* Write to the PHY as configured by the platform */
 	if (pdata->configure_phy)
@@ -1251,15 +1264,16 @@ static void dw_hdmi_phy_disable(struct dw_hdmi *hdmi, void *data)
 	dw_hdmi_phy_power_off(hdmi);
 }
 
-static enum drm_connector_status dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
-						      void *data)
+enum drm_connector_status dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
+					       void *data)
 {
 	return hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_HPD ?
 		connector_status_connected : connector_status_disconnected;
 }
+EXPORT_SYMBOL_GPL(dw_hdmi_phy_read_hpd);
 
-static void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
-				   bool force, bool disabled, bool rxsense)
+void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
+			    bool force, bool disabled, bool rxsense)
 {
 	u8 old_mask = hdmi->phy_mask;
 
@@ -1271,8 +1285,9 @@ static void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
 	if (old_mask != hdmi->phy_mask)
 		hdmi_writeb(hdmi, hdmi->phy_mask, HDMI_PHY_MASK0);
 }
+EXPORT_SYMBOL_GPL(dw_hdmi_phy_update_hpd);
 
-static void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data)
+void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data)
 {
 	/*
 	 * Configure the PHY RX SENSE and HPD interrupts polarities and clear
@@ -1291,6 +1306,7 @@ static void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data)
 	hdmi_writeb(hdmi, ~(HDMI_IH_PHY_STAT0_HPD | HDMI_IH_PHY_STAT0_RX_SENSE),
 		    HDMI_IH_MUTE_PHY_STAT0);
 }
+EXPORT_SYMBOL_GPL(dw_hdmi_phy_setup_hpd);
 
 static const struct dw_hdmi_phy_ops dw_hdmi_synopsys_phy_ops = {
 	.init = dw_hdmi_phy_init,
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 17de3afd98f6..e8c3ef8a94ce 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -302,7 +302,7 @@ static void meson_hdmi_phy_setup_mode(struct meson_dw_hdmi *dw_hdmi,
 	}
 }
 
-static inline void dw_hdmi_phy_reset(struct meson_dw_hdmi *dw_hdmi)
+static inline void meson_dw_hdmi_phy_reset(struct meson_dw_hdmi *dw_hdmi)
 {
 	struct meson_drm *priv = dw_hdmi->priv;
 
@@ -409,9 +409,9 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	msleep(100);
 
 	/* Reset PHY 3 times in a row */
-	dw_hdmi_phy_reset(dw_hdmi);
-	dw_hdmi_phy_reset(dw_hdmi);
-	dw_hdmi_phy_reset(dw_hdmi);
+	meson_dw_hdmi_phy_reset(dw_hdmi);
+	meson_dw_hdmi_phy_reset(dw_hdmi);
+	meson_dw_hdmi_phy_reset(dw_hdmi);
 
 	/* Temporary Disable VENC video stream */
 	if (priv->venc.hdmi_use_enci)
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 182f83283e24..f3f3f0e1b2d3 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -157,7 +157,18 @@ void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
 void dw_hdmi_audio_disable(struct dw_hdmi *hdmi);
 
 /* PHY configuration */
+void dw_hdmi_phy_i2c_set_addr(struct dw_hdmi *hdmi, u8 address);
 void dw_hdmi_phy_i2c_write(struct dw_hdmi *hdmi, unsigned short data,
 			   unsigned char addr);
 
+void dw_hdmi_phy_gen2_pddq(struct dw_hdmi *hdmi, u8 enable);
+void dw_hdmi_phy_gen2_txpwron(struct dw_hdmi *hdmi, u8 enable);
+void dw_hdmi_phy_reset(struct dw_hdmi *hdmi);
+
+enum drm_connector_status dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
+					       void *data);
+void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
+			    bool force, bool disabled, bool rxsense);
+void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data);
+
 #endif /* __IMX_HDMI_H__ */
-- 
2.16.1
