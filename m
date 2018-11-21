Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65474C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0C52147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0C52147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbeKVCok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:44:40 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49236 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731421AbeKVCoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:44:39 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9B18A27E1B0
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv5 5/6] drm/omap: add framedone interrupt support
Date:   Wed, 21 Nov 2018 17:09:15 +0100
Message-Id: <20181121160916.22017-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121160916.22017-1-sebastian.reichel@collabora.com>
References: <20181121160916.22017-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares framedone interrupt handling for
manual display update support.

Acked-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 50 +++++++++++++++++++++++++++++
 drivers/gpu/drm/omapdrm/omap_crtc.h |  1 +
 drivers/gpu/drm/omapdrm/omap_irq.c  | 25 +++++++++++++++
 drivers/gpu/drm/omapdrm/omap_irq.h  |  1 +
 4 files changed, 77 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index caffc547ef97..59ee2399f2e9 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -52,6 +52,9 @@ struct omap_crtc {
 	bool pending;
 	wait_queue_head_t pending_wait;
 	struct drm_pending_vblank_event *event;
+
+	void (*framedone_handler)(void *);
+	void *framedone_handler_data;
 };
 
 /* -----------------------------------------------------------------------------
@@ -231,6 +234,18 @@ static int omap_crtc_dss_register_framedone(
 		struct omap_drm_private *priv, enum omap_channel channel,
 		void (*handler)(void *), void *data)
 {
+	struct drm_crtc *crtc = priv->channels[channel]->crtc;
+	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
+	struct drm_device *dev = omap_crtc->base.dev;
+
+	if (omap_crtc->framedone_handler)
+		return -EBUSY;
+
+	dev_dbg(dev->dev, "register framedone %s", omap_crtc->name);
+
+	omap_crtc->framedone_handler = handler;
+	omap_crtc->framedone_handler_data = data;
+
 	return 0;
 }
 
@@ -238,6 +253,17 @@ static void omap_crtc_dss_unregister_framedone(
 		struct omap_drm_private *priv, enum omap_channel channel,
 		void (*handler)(void *), void *data)
 {
+	struct drm_crtc *crtc = priv->channels[channel]->crtc;
+	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
+	struct drm_device *dev = omap_crtc->base.dev;
+
+	dev_dbg(dev->dev, "unregister framedone %s", omap_crtc->name);
+
+	WARN_ON(omap_crtc->framedone_handler != handler);
+	WARN_ON(omap_crtc->framedone_handler_data != data);
+
+	omap_crtc->framedone_handler = NULL;
+	omap_crtc->framedone_handler_data = NULL;
 }
 
 static const struct dss_mgr_ops mgr_ops = {
@@ -303,6 +329,30 @@ void omap_crtc_vblank_irq(struct drm_crtc *crtc)
 	DBG("%s: apply done", omap_crtc->name);
 }
 
+void omap_crtc_framedone_irq(struct drm_crtc *crtc, uint32_t irqstatus)
+{
+	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
+
+	if (!omap_crtc->framedone_handler) {
+		dev_warn(omap_crtc->base.dev->dev, "no framedone handler?");
+		return;
+	}
+
+	omap_crtc->framedone_handler(omap_crtc->framedone_handler_data);
+
+	spin_lock(&crtc->dev->event_lock);
+	/* Send the vblank event if one has been requested. */
+	if (omap_crtc->event) {
+		drm_crtc_send_vblank_event(crtc, omap_crtc->event);
+		omap_crtc->event = NULL;
+	}
+	omap_crtc->pending = false;
+	spin_unlock(&crtc->dev->event_lock);
+
+	/* Wake up omap_atomic_complete. */
+	wake_up(&omap_crtc->pending_wait);
+}
+
 static void omap_crtc_write_crtc_properties(struct drm_crtc *crtc)
 {
 	struct omap_drm_private *priv = crtc->dev->dev_private;
diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.h b/drivers/gpu/drm/omapdrm/omap_crtc.h
index d9de437ba9dd..d33bbb7a4f90 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.h
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.h
@@ -41,5 +41,6 @@ struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 int omap_crtc_wait_pending(struct drm_crtc *crtc);
 void omap_crtc_error_irq(struct drm_crtc *crtc, u32 irqstatus);
 void omap_crtc_vblank_irq(struct drm_crtc *crtc);
+void omap_crtc_framedone_irq(struct drm_crtc *crtc, uint32_t irqstatus);
 
 #endif /* __OMAPDRM_CRTC_H__ */
diff --git a/drivers/gpu/drm/omapdrm/omap_irq.c b/drivers/gpu/drm/omapdrm/omap_irq.c
index 329ad26d6d50..01dda84ca2ee 100644
--- a/drivers/gpu/drm/omapdrm/omap_irq.c
+++ b/drivers/gpu/drm/omapdrm/omap_irq.c
@@ -85,6 +85,28 @@ int omap_irq_wait(struct drm_device *dev, struct omap_irq_wait *wait,
 	return ret == 0 ? -1 : 0;
 }
 
+int omap_irq_enable_framedone(struct drm_crtc *crtc, bool enable)
+{
+	struct drm_device *dev = crtc->dev;
+	struct omap_drm_private *priv = dev->dev_private;
+	unsigned long flags;
+	enum omap_channel channel = omap_crtc_channel(crtc);
+	int framedone_irq =
+		priv->dispc_ops->mgr_get_framedone_irq(priv->dispc, channel);
+
+	DBG("dev=%p, crtc=%u, enable=%d", dev, channel, enable);
+
+	spin_lock_irqsave(&priv->wait_lock, flags);
+	if (enable)
+		priv->irq_mask |= framedone_irq;
+	else
+		priv->irq_mask &= ~framedone_irq;
+	omap_irq_update(dev);
+	spin_unlock_irqrestore(&priv->wait_lock, flags);
+
+	return 0;
+}
+
 /**
  * enable_vblank - enable vblank interrupt events
  * @dev: DRM device
@@ -217,6 +239,9 @@ static irqreturn_t omap_irq_handler(int irq, void *arg)
 
 		if (irqstatus & priv->dispc_ops->mgr_get_sync_lost_irq(priv->dispc, channel))
 			omap_crtc_error_irq(crtc, irqstatus);
+
+		if (irqstatus & priv->dispc_ops->mgr_get_framedone_irq(priv->dispc, channel))
+			omap_crtc_framedone_irq(crtc, irqstatus);
 	}
 
 	omap_irq_ocp_error_handler(dev, irqstatus);
diff --git a/drivers/gpu/drm/omapdrm/omap_irq.h b/drivers/gpu/drm/omapdrm/omap_irq.h
index 9d5441468eca..02abb4ed9813 100644
--- a/drivers/gpu/drm/omapdrm/omap_irq.h
+++ b/drivers/gpu/drm/omapdrm/omap_irq.h
@@ -27,6 +27,7 @@ struct drm_device;
 struct omap_irq_wait;
 
 int omap_irq_enable_vblank(struct drm_crtc *crtc);
+int omap_irq_enable_framedone(struct drm_crtc *crtc, bool enable);
 void omap_irq_disable_vblank(struct drm_crtc *crtc);
 void omap_drm_irq_uninstall(struct drm_device *dev);
 int omap_drm_irq_install(struct drm_device *dev);
-- 
2.19.1

