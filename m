Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753279AbeA3Ubn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:31:43 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56612 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752995AbeA3UaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:30:03 -0500
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
Subject: [PATCH v3 38/43] drm/rockchip: Cancel PSR enable work before changing the state
Date: Tue, 30 Jan 2018 21:29:08 +0100
Message-Id: <20180130202913.28724-39-thierry.escande@collabora.com>
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

If we change the state first and reschedule later, we might have the
work executed according to previous scheduled time and end up with PSR
re-enabled instantly. Let's cancel the work before changing the state.

While at it, consolidate psr_disable_handler() to just call
rockchip_drm_do_flush(), as they are both supposed to do the same.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
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
2.14.1
