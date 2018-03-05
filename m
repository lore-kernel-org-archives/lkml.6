Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753705AbeCEW2U (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:28:20 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37876 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753053AbeCEW2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:28:13 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com, m.szyprowski@samsung.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 33/38] drm/rockchip: Cancel PSR enable work before changing the state
Date: Mon,  5 Mar 2018 23:27:57 +0100
Message-Id: <20180305222802.6659-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tfiga@chromium.org>

If we change the state first and reschedule later, we might have the
work executed according to previous scheduled time and end up with PSR
re-enabled instantly. Let's cancel the work before changing the state.

While at it, consolidate psr_disable_handler() to just call
rockchip_drm_do_flush(), as they are both supposed to do the same.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_psr.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
index a107845ba97c..c8655e625ba2 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -138,18 +138,6 @@ static void psr_flush_handler(struct work_struct *work)
 	mutex_unlock(&psr->lock);
 }
 
-static void psr_disable_handler(struct work_struct *work)
-{
-	struct psr_drv *psr = container_of(work, struct psr_drv, disable_work);
-
-	/* If the state has changed since we initiated the flush, do nothing */
-	mutex_lock(&psr->lock);
-	if (psr->state == PSR_ENABLE)
-		psr_set_state_locked(psr, PSR_FLUSH);
-	mutex_unlock(&psr->lock);
-	mod_delayed_work(system_wq, &psr->flush_work, PSR_FLUSH_TIMEOUT_MS);
-}
-
 /**
  * rockchip_drm_psr_activate - activate PSR on the given pipe
  * @encoder: encoder to obtain the PSR encoder
@@ -198,6 +186,7 @@ EXPORT_SYMBOL(rockchip_drm_psr_deactivate);
 
 static void rockchip_drm_do_flush(struct psr_drv *psr)
 {
+	cancel_delayed_work_sync(&psr->flush_work);
 	psr_set_state(psr, PSR_FLUSH);
 	mod_delayed_work(system_wq, &psr->flush_work, PSR_FLUSH_TIMEOUT_MS);
 }
@@ -244,6 +233,13 @@ void rockchip_drm_psr_flush_all(struct drm_device *dev)
 }
 EXPORT_SYMBOL(rockchip_drm_psr_flush_all);
 
+static void psr_disable_handler(struct work_struct *work)
+{
+	struct psr_drv *psr = container_of(work, struct psr_drv, disable_work);
+
+	rockchip_drm_do_flush(psr);
+}
+
 static void psr_input_event(struct input_handle *handle,
 			    unsigned int type, unsigned int code,
 			    int value)
-- 
2.16.1
