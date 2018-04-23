Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755199AbeDWKvR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:51:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39114 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755155AbeDWKvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:51:09 -0400
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
Subject: [RESEND PATCH v6 24/27] drm/rockchip: psr: Avoid redundant calls to .set() callback
Date: Mon, 23 Apr 2018 12:50:00 +0200
Message-Id: <20180423105003.9004-25-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423105003.9004-1-enric.balletbo@collabora.com>
References: <20180423105003.9004-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tfiga@chromium.org>

The first time after we call rockchip_drm_do_flush() after
rockchip_drm_psr_register(), we go from PSR_DISABLE to PSR_FLUSH. The
difference between PSR_DISABLE and PSR_FLUSH is whether or not we have a
delayed work pending - PSR is off in either state.  However
psr_set_state() only catches the transition from PSR_FLUSH to
PSR_DISABLE (which never happens), while going from PSR_DISABLE to
PSR_FLUSH triggers a call to psr->set() to disable PSR while it's
already disabled. This triggers the eDP PHY power-on sequence without
being shut down first and this seems to occasionally leave the encoder
unable to later enable PSR. Let's just simplify the state machine and
simply consider PSR_DISABLE and PSR_FLUSH the same state.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Kristian H. Kristensen <hoegsberg@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_psr.c | 80 +++++++--------------
 1 file changed, 24 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
index 9376f4396b6b..1a6157ffecec 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -20,19 +20,13 @@
 
 #define PSR_FLUSH_TIMEOUT_MS	100
 
-enum psr_state {
-	PSR_FLUSH,
-	PSR_ENABLE,
-	PSR_DISABLE,
-};
-
 struct psr_drv {
 	struct list_head	list;
 	struct drm_encoder	*encoder;
 
 	struct mutex		lock;
 	bool			active;
-	enum psr_state		state;
+	bool			enabled;
 
 	struct delayed_work	flush_work;
 
@@ -73,52 +67,22 @@ static struct psr_drv *find_psr_by_encoder(struct drm_encoder *encoder)
 	return psr;
 }
 
-static void psr_set_state_locked(struct psr_drv *psr, enum psr_state state)
+static int psr_set_state_locked(struct psr_drv *psr, bool enable)
 {
-	/*
-	 * Allowed finite state machine:
-	 *
-	 *   PSR_ENABLE  < = = = = = >  PSR_FLUSH
-	 *       | ^                        |
-	 *       | |                        |
-	 *       v |                        |
-	 *   PSR_DISABLE < - - - - - - - - -
-	 */
-	if (state == psr->state || !psr->active)
-		return;
-
-	/* Already disabled in flush, change the state, but not the hardware */
-	if (state == PSR_DISABLE && psr->state == PSR_FLUSH) {
-		psr->state = state;
-		return;
-	}
+	int ret;
 
-	/* Actually commit the state change to hardware */
-	switch (state) {
-	case PSR_ENABLE:
-		if (psr->set(psr->encoder, true))
-			return;
-		break;
-
-	case PSR_DISABLE:
-	case PSR_FLUSH:
-		if (psr->set(psr->encoder, false))
-			return;
-		break;
-
-	default:
-		pr_err("%s: Unknown state %d\n", __func__, state);
-		return;
-	}
+	if (!psr->active)
+		return -EINVAL;
 
-	psr->state = state;
-}
+	if (enable == psr->enabled)
+		return 0;
 
-static void psr_set_state(struct psr_drv *psr, enum psr_state state)
-{
-	mutex_lock(&psr->lock);
-	psr_set_state_locked(psr, state);
-	mutex_unlock(&psr->lock);
+	ret = psr->set(psr->encoder, enable);
+	if (ret)
+		return ret;
+
+	psr->enabled = enable;
+	return 0;
 }
 
 static void psr_flush_handler(struct work_struct *work)
@@ -126,10 +90,8 @@ static void psr_flush_handler(struct work_struct *work)
 	struct psr_drv *psr = container_of(to_delayed_work(work),
 					   struct psr_drv, flush_work);
 
-	/* If the state has changed since we initiated the flush, do nothing */
 	mutex_lock(&psr->lock);
-	if (psr->state == PSR_FLUSH)
-		psr_set_state_locked(psr, PSR_ENABLE);
+	psr_set_state_locked(psr, true);
 	mutex_unlock(&psr->lock);
 }
 
@@ -171,6 +133,7 @@ int rockchip_drm_psr_deactivate(struct drm_encoder *encoder)
 
 	mutex_lock(&psr->lock);
 	psr->active = false;
+	psr->enabled = false;
 	mutex_unlock(&psr->lock);
 	cancel_delayed_work_sync(&psr->flush_work);
 
@@ -180,8 +143,13 @@ EXPORT_SYMBOL(rockchip_drm_psr_deactivate);
 
 static void rockchip_drm_do_flush(struct psr_drv *psr)
 {
-	psr_set_state(psr, PSR_FLUSH);
-	mod_delayed_work(system_wq, &psr->flush_work, PSR_FLUSH_TIMEOUT_MS);
+	cancel_delayed_work_sync(&psr->flush_work);
+
+	mutex_lock(&psr->lock);
+	if (!psr_set_state_locked(psr, false))
+		mod_delayed_work(system_wq, &psr->flush_work,
+				 PSR_FLUSH_TIMEOUT_MS);
+	mutex_unlock(&psr->lock);
 }
 
 /**
@@ -250,8 +218,8 @@ int rockchip_drm_psr_register(struct drm_encoder *encoder,
 	INIT_DELAYED_WORK(&psr->flush_work, psr_flush_handler);
 	mutex_init(&psr->lock);
 
-	psr->active = true;
-	psr->state = PSR_DISABLE;
+	psr->active = false;
+	psr->enabled = false;
 	psr->encoder = encoder;
 	psr->set = psr_set;
 
-- 
2.17.0
