Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932896AbeCEWc0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:32:26 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37164 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753221AbeCEWXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:23:38 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com, m.szyprowski@samsung.com,
        Caesar Wang <wxt@rock-chips.com>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 02/38] drm/rockchip: Don't use atomic constructs for psr
Date: Mon,  5 Mar 2018 23:22:54 +0100
Message-Id: <20180305222324.5872-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222324.5872-1-enric.balletbo@collabora.com>
References: <20180305222324.5872-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

Instead of using timer and spinlocks, use delayed_work and
mutexes for rockchip psr. This allows us to make blocking
calls when enabling/disabling psr (which is sort of important
given we're talking over dpcd to the display).

Cc: Caesar Wang <wxt@rock-chips.com>
Cc: 征增 王 <wzz@rock-chips.com>
Cc: Stéphane Marchesin <marcheu@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c | 68 ++++++++++++-----------------
 3 files changed, 31 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 1920334dbdaa..f814d37b1db2 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -134,7 +134,7 @@ static int rockchip_drm_bind(struct device *dev)
 	drm_dev->dev_private = private;
 
 	INIT_LIST_HEAD(&private->psr_list);
-	spin_lock_init(&private->psr_list_lock);
+	mutex_init(&private->psr_list_lock);
 
 	ret = rockchip_drm_init_iommu(drm_dev);
 	if (ret)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 498dfbc52cec..9c064a40458b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -55,7 +55,7 @@ struct rockchip_drm_private {
 	struct mutex mm_lock;
 	struct drm_mm mm;
 	struct list_head psr_list;
-	spinlock_t psr_list_lock;
+	struct mutex psr_list_lock;
 };
 
 int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
index b3fb99c5b1fd..b339ca943139 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -18,7 +18,7 @@
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_psr.h"
 
-#define PSR_FLUSH_TIMEOUT	msecs_to_jiffies(100)
+#define PSR_FLUSH_TIMEOUT_MS	100
 
 enum psr_state {
 	PSR_FLUSH,
@@ -30,11 +30,11 @@ struct psr_drv {
 	struct list_head	list;
 	struct drm_encoder	*encoder;
 
-	spinlock_t		lock;
+	struct mutex		lock;
 	bool			active;
 	enum psr_state		state;
 
-	struct timer_list	flush_timer;
+	struct delayed_work	flush_work;
 
 	void (*set)(struct drm_encoder *encoder, bool enable);
 };
@@ -43,9 +43,8 @@ static struct psr_drv *find_psr_by_crtc(struct drm_crtc *crtc)
 {
 	struct rockchip_drm_private *drm_drv = crtc->dev->dev_private;
 	struct psr_drv *psr;
-	unsigned long flags;
 
-	spin_lock_irqsave(&drm_drv->psr_list_lock, flags);
+	mutex_lock(&drm_drv->psr_list_lock);
 	list_for_each_entry(psr, &drm_drv->psr_list, list) {
 		if (psr->encoder->crtc == crtc)
 			goto out;
@@ -53,7 +52,7 @@ static struct psr_drv *find_psr_by_crtc(struct drm_crtc *crtc)
 	psr = ERR_PTR(-ENODEV);
 
 out:
-	spin_unlock_irqrestore(&drm_drv->psr_list_lock, flags);
+	mutex_unlock(&drm_drv->psr_list_lock);
 	return psr;
 }
 
@@ -61,9 +60,8 @@ static struct psr_drv *find_psr_by_encoder(struct drm_encoder *encoder)
 {
 	struct rockchip_drm_private *drm_drv = encoder->dev->dev_private;
 	struct psr_drv *psr;
-	unsigned long flags;
 
-	spin_lock_irqsave(&drm_drv->psr_list_lock, flags);
+	mutex_lock(&drm_drv->psr_list_lock);
 	list_for_each_entry(psr, &drm_drv->psr_list, list) {
 		if (psr->encoder == encoder)
 			goto out;
@@ -71,7 +69,7 @@ static struct psr_drv *find_psr_by_encoder(struct drm_encoder *encoder)
 	psr = ERR_PTR(-ENODEV);
 
 out:
-	spin_unlock_irqrestore(&drm_drv->psr_list_lock, flags);
+	mutex_unlock(&drm_drv->psr_list_lock);
 	return psr;
 }
 
@@ -112,23 +110,21 @@ static void psr_set_state_locked(struct psr_drv *psr, enum psr_state state)
 
 static void psr_set_state(struct psr_drv *psr, enum psr_state state)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&psr->lock, flags);
+	mutex_lock(&psr->lock);
 	psr_set_state_locked(psr, state);
-	spin_unlock_irqrestore(&psr->lock, flags);
+	mutex_unlock(&psr->lock);
 }
 
-static void psr_flush_handler(struct timer_list *t)
+static void psr_flush_handler(struct work_struct *work)
 {
-	struct psr_drv *psr = from_timer(psr, t, flush_timer);
-	unsigned long flags;
+	struct psr_drv *psr = container_of(to_delayed_work(work),
+					   struct psr_drv, flush_work);
 
 	/* If the state has changed since we initiated the flush, do nothing */
-	spin_lock_irqsave(&psr->lock, flags);
+	mutex_lock(&psr->lock);
 	if (psr->state == PSR_FLUSH)
 		psr_set_state_locked(psr, PSR_ENABLE);
-	spin_unlock_irqrestore(&psr->lock, flags);
+	mutex_unlock(&psr->lock);
 }
 
 /**
@@ -141,14 +137,13 @@ static void psr_flush_handler(struct timer_list *t)
 int rockchip_drm_psr_activate(struct drm_encoder *encoder)
 {
 	struct psr_drv *psr = find_psr_by_encoder(encoder);
-	unsigned long flags;
 
 	if (IS_ERR(psr))
 		return PTR_ERR(psr);
 
-	spin_lock_irqsave(&psr->lock, flags);
+	mutex_lock(&psr->lock);
 	psr->active = true;
-	spin_unlock_irqrestore(&psr->lock, flags);
+	mutex_unlock(&psr->lock);
 
 	return 0;
 }
@@ -164,15 +159,14 @@ EXPORT_SYMBOL(rockchip_drm_psr_activate);
 int rockchip_drm_psr_deactivate(struct drm_encoder *encoder)
 {
 	struct psr_drv *psr = find_psr_by_encoder(encoder);
-	unsigned long flags;
 
 	if (IS_ERR(psr))
 		return PTR_ERR(psr);
 
-	spin_lock_irqsave(&psr->lock, flags);
+	mutex_lock(&psr->lock);
 	psr->active = false;
-	spin_unlock_irqrestore(&psr->lock, flags);
-	del_timer_sync(&psr->flush_timer);
+	mutex_unlock(&psr->lock);
+	cancel_delayed_work_sync(&psr->flush_work);
 
 	return 0;
 }
@@ -180,9 +174,8 @@ EXPORT_SYMBOL(rockchip_drm_psr_deactivate);
 
 static void rockchip_drm_do_flush(struct psr_drv *psr)
 {
-	mod_timer(&psr->flush_timer,
-		  round_jiffies_up(jiffies + PSR_FLUSH_TIMEOUT));
 	psr_set_state(psr, PSR_FLUSH);
+	mod_delayed_work(system_wq, &psr->flush_work, PSR_FLUSH_TIMEOUT_MS);
 }
 
 /**
@@ -219,12 +212,11 @@ void rockchip_drm_psr_flush_all(struct drm_device *dev)
 {
 	struct rockchip_drm_private *drm_drv = dev->dev_private;
 	struct psr_drv *psr;
-	unsigned long flags;
 
-	spin_lock_irqsave(&drm_drv->psr_list_lock, flags);
+	mutex_lock(&drm_drv->psr_list_lock);
 	list_for_each_entry(psr, &drm_drv->psr_list, list)
 		rockchip_drm_do_flush(psr);
-	spin_unlock_irqrestore(&drm_drv->psr_list_lock, flags);
+	mutex_unlock(&drm_drv->psr_list_lock);
 }
 EXPORT_SYMBOL(rockchip_drm_psr_flush_all);
 
@@ -241,7 +233,6 @@ int rockchip_drm_psr_register(struct drm_encoder *encoder,
 {
 	struct rockchip_drm_private *drm_drv = encoder->dev->dev_private;
 	struct psr_drv *psr;
-	unsigned long flags;
 
 	if (!encoder || !psr_set)
 		return -EINVAL;
@@ -250,17 +241,17 @@ int rockchip_drm_psr_register(struct drm_encoder *encoder,
 	if (!psr)
 		return -ENOMEM;
 
-	timer_setup(&psr->flush_timer, psr_flush_handler, 0);
-	spin_lock_init(&psr->lock);
+	INIT_DELAYED_WORK(&psr->flush_work, psr_flush_handler);
+	mutex_init(&psr->lock);
 
 	psr->active = true;
 	psr->state = PSR_DISABLE;
 	psr->encoder = encoder;
 	psr->set = psr_set;
 
-	spin_lock_irqsave(&drm_drv->psr_list_lock, flags);
+	mutex_lock(&drm_drv->psr_list_lock);
 	list_add_tail(&psr->list, &drm_drv->psr_list);
-	spin_unlock_irqrestore(&drm_drv->psr_list_lock, flags);
+	mutex_unlock(&drm_drv->psr_list_lock);
 
 	return 0;
 }
@@ -278,16 +269,15 @@ void rockchip_drm_psr_unregister(struct drm_encoder *encoder)
 {
 	struct rockchip_drm_private *drm_drv = encoder->dev->dev_private;
 	struct psr_drv *psr, *n;
-	unsigned long flags;
 
-	spin_lock_irqsave(&drm_drv->psr_list_lock, flags);
+	mutex_lock(&drm_drv->psr_list_lock);
 	list_for_each_entry_safe(psr, n, &drm_drv->psr_list, list) {
 		if (psr->encoder == encoder) {
-			del_timer(&psr->flush_timer);
+			cancel_delayed_work_sync(&psr->flush_work);
 			list_del(&psr->list);
 			kfree(psr);
 		}
 	}
-	spin_unlock_irqrestore(&drm_drv->psr_list_lock, flags);
+	mutex_unlock(&drm_drv->psr_list_lock);
 }
 EXPORT_SYMBOL(rockchip_drm_psr_unregister);
-- 
2.16.1
