Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968919AbeE3JoG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:44:06 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35892 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965077AbeE3JoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:44:02 -0400
X-Google-Smtp-Source: ADUXVKLoEZGOmGvNy3Jmo1zoiQOVEtIExYi8eJgyLLo3FYkPy10+FqXOhKDeqMDqaF1YGqzRI5BgPA==
From: Neil Armstrong <narmstrong@baylibre.com>
To: architt@codeaurora.org, a.hajda@samsung.com, jernej.skrabec@siol.net
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge/synopsys: dw-hdmi: fix dw_hdmi_setup_rx_sense
Date: Wed, 30 May 2018 11:43:58 +0200
Message-Id: <1527673438-20643-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dw_hdmi_setup_rx_sense exported function should not use struct device
to recover the dw-hdmi context using drvdata, but take struct dw_hdmi
directly like other exported functions.

This caused a regression using Meson DRM on S905X since v4.17-rc1 :

Internal error: Oops: 96000007 [#1] PREEMPT SMP
[...]
CPU: 0 PID: 124 Comm: irq/32-dw_hdmi_ Not tainted 4.17.0-rc7 #2
Hardware name: Libre Technology CC (DT)
[...]
pc : osq_lock+0x54/0x188
lr : __mutex_lock.isra.0+0x74/0x530
[...]
Process irq/32-dw_hdmi_ (pid: 124, stack limit = 0x00000000adf418cb)
Call trace:
  osq_lock+0x54/0x188
  __mutex_lock_slowpath+0x10/0x18
  mutex_lock+0x30/0x38
  __dw_hdmi_setup_rx_sense+0x28/0x98
  dw_hdmi_setup_rx_sense+0x10/0x18
  dw_hdmi_top_thread_irq+0x2c/0x50
  irq_thread_fn+0x28/0x68
  irq_thread+0x10c/0x1a0
  kthread+0x128/0x130
  ret_from_fork+0x10/0x18
 Code: 34000964 d00050a2 51000484 9135c042 (f864d844)
 ---[ end trace 945641e1fbbc07da ]---
 note: irq/32-dw_hdmi_[124] exited with preempt_count 1
 genirq: exiting task "irq/32-dw_hdmi_" (124) is an active IRQ thread (irq 32)

Fixes: eea034af90c6 ("drm/bridge/synopsys: dw-hdmi: don't clobber drvdata")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Koen Kooi <koen@dominion.thruhere.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 15 ++++-----------
 drivers/gpu/drm/meson/meson_dw_hdmi.c     |  2 +-
 include/drm/bridge/dw_hdmi.h              |  2 +-
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index ec8d000..3c136f2b 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2077,7 +2077,7 @@ static irqreturn_t dw_hdmi_hardirq(int irq, void *dev_id)
 	return ret;
 }
 
-void __dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
+void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
 {
 	mutex_lock(&hdmi->mutex);
 
@@ -2103,13 +2103,6 @@ void __dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
 	}
 	mutex_unlock(&hdmi->mutex);
 }
-
-void dw_hdmi_setup_rx_sense(struct device *dev, bool hpd, bool rx_sense)
-{
-	struct dw_hdmi *hdmi = dev_get_drvdata(dev);
-
-	__dw_hdmi_setup_rx_sense(hdmi, hpd, rx_sense);
-}
 EXPORT_SYMBOL_GPL(dw_hdmi_setup_rx_sense);
 
 static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
@@ -2145,9 +2138,9 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 	 */
 	if (intr_stat &
 	    (HDMI_IH_PHY_STAT0_RX_SENSE | HDMI_IH_PHY_STAT0_HPD)) {
-		__dw_hdmi_setup_rx_sense(hdmi,
-					 phy_stat & HDMI_PHY_HPD,
-					 phy_stat & HDMI_PHY_RX_SENSE);
+		dw_hdmi_setup_rx_sense(hdmi,
+				       phy_stat & HDMI_PHY_HPD,
+				       phy_stat & HDMI_PHY_RX_SENSE);
 
 		if ((phy_stat & (HDMI_PHY_RX_SENSE | HDMI_PHY_HPD)) == 0)
 			cec_notifier_set_phys_addr(hdmi->cec_notifier,
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index a393095..c9ad456 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -529,7 +529,7 @@ static irqreturn_t dw_hdmi_top_thread_irq(int irq, void *dev_id)
 		if (stat & HDMITX_TOP_INTR_HPD_RISE)
 			hpd_connected = true;
 
-		dw_hdmi_setup_rx_sense(dw_hdmi->dev, hpd_connected,
+		dw_hdmi_setup_rx_sense(dw_hdmi->hdmi, hpd_connected,
 				       hpd_connected);
 
 		drm_helper_hpd_irq_event(dw_hdmi->encoder.dev);
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index dd2a8cf..ccb5aa8 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -151,7 +151,7 @@ struct dw_hdmi *dw_hdmi_bind(struct platform_device *pdev,
 			     struct drm_encoder *encoder,
 			     const struct dw_hdmi_plat_data *plat_data);
 
-void dw_hdmi_setup_rx_sense(struct device *dev, bool hpd, bool rx_sense);
+void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense);
 
 void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
 void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
-- 
2.7.4
