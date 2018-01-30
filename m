Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753230AbeA3UbC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:31:02 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56632 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753029AbeA3UaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:30:04 -0500
From: Thierry Escande <thierry.escande@collabora.com>
To: Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, Tomasz Figa <tfiga@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Haixia Shi <hshi@chromium.org>,
        =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>,
        Zain Wang <wzz@rock-chips.com>, Yakir Yang <ykk@rock-chips.com>,
        Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Mark Yao <mark.yao@rock-chips.com>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 39/43] drm/rockchip: psr: Avoid redundant calls to .set() callback
Date: Tue, 30 Jan 2018 21:29:09 +0100
Message-Id: <20180130202913.28724-40-thierry.escande@collabora.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180130202913.28724-1-thierry.escande@collabora.com>
References: <20180130202913.28724-1-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Content-Transfert-Encoding: 8bit
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
simply consider PSR_DISABLE and PSR_FLUSH the same state. This lets us
represent the hardware state by a simple boolean called "enabled" and,
while at it, rename the misleading "active" boolean to "inhibit", which
represents the purpose much better.

Also, userspace can (and does) trigger the rockchip_drm_do_flush() path
from drmModeDirtyFB() at any time, whether or the encoder is active. If
no mode is set, we call into analogix_dp_psr_set() which returns -EINVAL
because encoder->crtc is NULL. Avoid this by starting out with
psr->allowed set to false.

Signed-off-by: Kristian H. Kristensen <hoegsberg@chromium.org>
Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c | 79 +++++++++--------------------
 1 file changed, 23 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
index c8655e625ba2..448c5fde241c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -22,19 +22,13 @@
 
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
 	struct work_struct	disable_work;
@@ -78,52 +72,22 @@ static struct psr_drv *find_psr_by_encoder(struct drm_encoder *encoder)
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
@@ -131,10 +95,8 @@ static void psr_flush_handler(struct work_struct *work)
 	struct psr_drv *psr = container_of(to_delayed_work(work),
 					   struct psr_drv, flush_work);
 
-	/* If the state has changed since we initiated the flush, do nothing */
 	mutex_lock(&psr->lock);
-	if (psr->state == PSR_FLUSH)
-		psr_set_state_locked(psr, PSR_ENABLE);
+	psr_set_state_locked(psr, true);
 	mutex_unlock(&psr->lock);
 }
 
@@ -176,6 +138,7 @@ int rockchip_drm_psr_deactivate(struct drm_encoder *encoder)
 
 	mutex_lock(&psr->lock);
 	psr->active = false;
+	psr->enabled = false;
 	mutex_unlock(&psr->lock);
 	cancel_delayed_work_sync(&psr->flush_work);
 	cancel_work_sync(&psr->disable_work);
@@ -187,8 +150,12 @@ EXPORT_SYMBOL(rockchip_drm_psr_deactivate);
 static void rockchip_drm_do_flush(struct psr_drv *psr)
 {
 	cancel_delayed_work_sync(&psr->flush_work);
-	psr_set_state(psr, PSR_FLUSH);
-	mod_delayed_work(system_wq, &psr->flush_work, PSR_FLUSH_TIMEOUT_MS);
+
+	mutex_lock(&psr->lock);
+	if (!psr_set_state_locked(psr, false))
+		mod_delayed_work(system_wq, &psr->flush_work,
+				 PSR_FLUSH_TIMEOUT_MS);
+	mutex_unlock(&psr->lock);
 }
 
 /**
@@ -355,8 +322,8 @@ int rockchip_drm_psr_register(struct drm_encoder *encoder,
 	INIT_WORK(&psr->disable_work, psr_disable_handler);
 	mutex_init(&psr->lock);
 
-	psr->active = true;
-	psr->state = PSR_DISABLE;
+	psr->active = false;
+	psr->enabled = false;
 	psr->encoder = encoder;
 	psr->set = psr_set;
 
-- 
2.14.1
