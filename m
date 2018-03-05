Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753784AbeCEW2x (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:28:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37976 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753711AbeCEW2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:28:24 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com, m.szyprowski@samsung.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 38/38] drm/rockchip: psr: Remove flush by CRTC
Date: Mon,  5 Mar 2018 23:28:02 +0100
Message-Id: <20180305222802.6659-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222802.6659-1-enric.balletbo@collabora.com>
References: <20180305222802.6659-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tfiga@chromium.org>

It is not used anymore after last changes and it was not even correct to
begin with as it assumed a 1:1 relation between a CRTC and encoder,
while in fact a CRTC can be attached to multiple encoders.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_psr.c | 35 -----------------------------
 drivers/gpu/drm/rockchip/rockchip_drm_psr.h |  1 -
 2 files changed, 36 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
index 1bf5cba9a64d..b1988ac758d5 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -40,23 +40,6 @@ struct psr_drv {
 	int (*set)(struct drm_encoder *encoder, bool enable);
 };
 
-static struct psr_drv *find_psr_by_crtc(struct drm_crtc *crtc)
-{
-	struct rockchip_drm_private *drm_drv = crtc->dev->dev_private;
-	struct psr_drv *psr;
-
-	mutex_lock(&drm_drv->psr_list_lock);
-	list_for_each_entry(psr, &drm_drv->psr_list, list) {
-		if (psr->encoder->crtc == crtc)
-			goto out;
-	}
-	psr = ERR_PTR(-ENODEV);
-
-out:
-	mutex_unlock(&drm_drv->psr_list_lock);
-	return psr;
-}
-
 static struct psr_drv *find_psr_by_encoder(struct drm_encoder *encoder)
 {
 	struct rockchip_drm_private *drm_drv = encoder->dev->dev_private;
@@ -173,24 +156,6 @@ static void rockchip_drm_do_flush(struct psr_drv *psr)
 	mutex_unlock(&psr->lock);
 }
 
-/**
- * rockchip_drm_psr_flush - flush a single pipe
- * @crtc: CRTC of the pipe to flush
- *
- * Returns:
- * 0 on success, -errno on fail
- */
-int rockchip_drm_psr_flush(struct drm_crtc *crtc)
-{
-	struct psr_drv *psr = find_psr_by_crtc(crtc);
-	if (IS_ERR(psr))
-		return PTR_ERR(psr);
-
-	rockchip_drm_do_flush(psr);
-	return 0;
-}
-EXPORT_SYMBOL(rockchip_drm_psr_flush);
-
 /**
  * rockchip_drm_psr_flush_all - force to flush all registered PSR encoders
  * @dev: drm device
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
index 40e026c14168..860c62494496 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
@@ -16,7 +16,6 @@
 #define __ROCKCHIP_DRM_PSR___
 
 void rockchip_drm_psr_flush_all(struct drm_device *dev);
-int rockchip_drm_psr_flush(struct drm_crtc *crtc);
 
 int rockchip_drm_psr_inhibit_put(struct drm_encoder *encoder);
 int rockchip_drm_psr_inhibit_get(struct drm_encoder *encoder);
-- 
2.16.1
