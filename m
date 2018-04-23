Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755217AbeDWKvg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:51:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39196 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755184AbeDWKvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:51:16 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: dri-devel@lists.freedesktop.org, dianders@chromium.org,
        a.hajda@samsung.com, kernel@collabora.com, m.szyprowski@samsung.com,
        linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
        rydberg@bitmath.org, krzk@kernel.org,
        linux-rockchip@lists.infradead.org, kgene@kernel.org,
        orjan.eide@arm.com, wxt@rock-chips.com, jeffy.chen@rock-chips.com,
        linux-arm-kernel@lists.infradead.org, wzz@rock-chips.com,
        hl@rock-chips.com, jingoohan1@gmail.com, sw0312.kim@samsung.com,
        linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
        Laurent.pinchart@ideasonboard.com, kuankuan.y@gmail.com,
        hshi@chromium.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [RESEND PATCH v6 27/27] drm/rockchip: psr: Remove flush by CRTC
Date: Mon, 23 Apr 2018 12:50:03 +0200
Message-Id: <20180423105003.9004-28-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423105003.9004-1-enric.balletbo@collabora.com>
References: <20180423105003.9004-1-enric.balletbo@collabora.com>
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
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_psr.c | 35 ---------------------
 drivers/gpu/drm/rockchip/rockchip_drm_psr.h |  1 -
 2 files changed, 36 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
index 74f6a6a887dd..79d00d861a31 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -33,23 +33,6 @@ struct psr_drv {
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
@@ -166,24 +149,6 @@ static void rockchip_drm_do_flush(struct psr_drv *psr)
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
2.17.0
