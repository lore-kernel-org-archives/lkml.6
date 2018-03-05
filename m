Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753808AbeCEW3n (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:29:43 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37920 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753633AbeCEW2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:28:18 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com, m.szyprowski@samsung.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 35/38] drm/rockchip: psr: Sanitize semantics of allow/disallow API
Date: Mon,  5 Mar 2018 23:27:59 +0100
Message-Id: <20180305222802.6659-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222802.6659-1-enric.balletbo@collabora.com>
References: <20180305222802.6659-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tfiga@chromium.org>

Currently both rockchip_drm_psr_activate() and _deactivate() only set the
boolean "active" flag without actually making sure that hardware state
complies with it.

Since we are going to extend the usage of this API to properly lock PSR
for the duration of atomic commits, we change the semantics in following
way:
 - a counter is used to track the number of disallow requests,
 - PSR is actually disabled in hardware on first disallow request,
 - PSR enable work is scheduled on last disallow request.

The above allows using the API as a way to deterministically synchronize
PSR state changes with other DRM events, i.e. atomic commits and cursor
updates. As a nice side effect, the naming is sorted out and we have
"inhibit" for stopping the software logic and "enable" for hardware
state.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c |  4 +-
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c     | 57 ++++++++++++++++++-------
 drivers/gpu/drm/rockchip/rockchip_drm_psr.h     |  4 +-
 3 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 6d45d62466b3..080f05352195 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -134,7 +134,7 @@ static int rockchip_dp_poweron_end(struct analogix_dp_plat_data *plat_data)
 {
 	struct rockchip_dp_device *dp = to_dp(plat_data);
 
-	return rockchip_drm_psr_activate(&dp->encoder);
+	return rockchip_drm_psr_inhibit_put(&dp->encoder);
 }
 
 static int rockchip_dp_powerdown(struct analogix_dp_plat_data *plat_data)
@@ -142,7 +142,7 @@ static int rockchip_dp_powerdown(struct analogix_dp_plat_data *plat_data)
 	struct rockchip_dp_device *dp = to_dp(plat_data);
 	int ret;
 
-	ret = rockchip_drm_psr_deactivate(&dp->encoder);
+	ret = rockchip_drm_psr_inhibit_get(&dp->encoder);
 	if (ret != 0)
 		return ret;
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
index 448c5fde241c..e7e16d92d5a1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.c
@@ -27,7 +27,7 @@ struct psr_drv {
 	struct drm_encoder	*encoder;
 
 	struct mutex		lock;
-	bool			active;
+	int			inhibit_count;
 	bool			enabled;
 
 	struct delayed_work	flush_work;
@@ -76,7 +76,7 @@ static int psr_set_state_locked(struct psr_drv *psr, bool enable)
 {
 	int ret;
 
-	if (!psr->active)
+	if (psr->inhibit_count > 0)
 		return -EINVAL;
 
 	if (enable == psr->enabled)
@@ -101,13 +101,18 @@ static void psr_flush_handler(struct work_struct *work)
 }
 
 /**
- * rockchip_drm_psr_activate - activate PSR on the given pipe
+ * rockchip_drm_psr_inhibit_put - release PSR inhibit on given encoder
  * @encoder: encoder to obtain the PSR encoder
  *
+ * Decrements PSR inhibit count on given encoder. Should be called only
+ * for a PSR inhibit count increment done before. If PSR inhibit counter
+ * reaches zero, PSR flush work is scheduled to make the hardware enter
+ * PSR mode in PSR_FLUSH_TIMEOUT_MS.
+ *
  * Returns:
  * Zero on success, negative errno on failure.
  */
-int rockchip_drm_psr_activate(struct drm_encoder *encoder)
+int rockchip_drm_psr_inhibit_put(struct drm_encoder *encoder)
 {
 	struct psr_drv *psr = find_psr_by_encoder(encoder);
 
@@ -115,21 +120,29 @@ int rockchip_drm_psr_activate(struct drm_encoder *encoder)
 		return PTR_ERR(psr);
 
 	mutex_lock(&psr->lock);
-	psr->active = true;
+	--psr->inhibit_count;
+	if (!psr->inhibit_count)
+		mod_delayed_work(system_wq, &psr->flush_work,
+				 PSR_FLUSH_TIMEOUT_MS);
 	mutex_unlock(&psr->lock);
 
 	return 0;
 }
-EXPORT_SYMBOL(rockchip_drm_psr_activate);
+EXPORT_SYMBOL(rockchip_drm_psr_inhibit_put);
 
 /**
- * rockchip_drm_psr_deactivate - deactivate PSR on the given pipe
+ * rockchip_drm_psr_inhibit_get - acquire PSR inhibit on given encoder
  * @encoder: encoder to obtain the PSR encoder
  *
+ * Increments PSR inhibit count on given encoder. This function guarantees
+ * that after it returns PSR is turned off on given encoder and no PSR-related
+ * hardware state change occurs at least until a matching call to
+ * rockchip_drm_psr_inhibit_put() is done.
+ *
  * Returns:
  * Zero on success, negative errno on failure.
  */
-int rockchip_drm_psr_deactivate(struct drm_encoder *encoder)
+int rockchip_drm_psr_inhibit_get(struct drm_encoder *encoder)
 {
 	struct psr_drv *psr = find_psr_by_encoder(encoder);
 
@@ -137,15 +150,15 @@ int rockchip_drm_psr_deactivate(struct drm_encoder *encoder)
 		return PTR_ERR(psr);
 
 	mutex_lock(&psr->lock);
-	psr->active = false;
-	psr->enabled = false;
+	psr_set_state_locked(psr, false);
+	++psr->inhibit_count;
 	mutex_unlock(&psr->lock);
 	cancel_delayed_work_sync(&psr->flush_work);
 	cancel_work_sync(&psr->disable_work);
 
 	return 0;
 }
-EXPORT_SYMBOL(rockchip_drm_psr_deactivate);
+EXPORT_SYMBOL(rockchip_drm_psr_inhibit_get);
 
 static void rockchip_drm_do_flush(struct psr_drv *psr)
 {
@@ -301,6 +314,11 @@ static const struct input_device_id psr_ids[] = {
  * @encoder: encoder that obtain the PSR function
  * @psr_set: call back to set PSR state
  *
+ * The function returns with PSR inhibit counter initialized with one
+ * and the caller (typically encoder driver) needs to call
+ * rockchip_drm_psr_inhibit_put() when it becomes ready to accept PSR
+ * enable request.
+ *
  * Returns:
  * Zero on success, negative errno on failure.
  */
@@ -322,7 +340,7 @@ int rockchip_drm_psr_register(struct drm_encoder *encoder,
 	INIT_WORK(&psr->disable_work, psr_disable_handler);
 	mutex_init(&psr->lock);
 
-	psr->active = false;
+	psr->inhibit_count = 1;
 	psr->enabled = false;
 	psr->encoder = encoder;
 	psr->set = psr_set;
@@ -362,6 +380,11 @@ EXPORT_SYMBOL(rockchip_drm_psr_register);
  * @encoder: encoder that obtain the PSR function
  * @psr_set: call back to set PSR state
  *
+ * It is expected that the PSR inhibit counter is 1 when this function is
+ * called, which corresponds to a state when related encoder has been
+ * disconnected from any CRTCs and its driver called
+ * rockchip_drm_psr_inhibit_get() to stop the PSR logic.
+ *
  * Returns:
  * Zero on success, negative errno on failure.
  */
@@ -373,10 +396,14 @@ void rockchip_drm_psr_unregister(struct drm_encoder *encoder)
 	mutex_lock(&drm_drv->psr_list_lock);
 	list_for_each_entry_safe(psr, n, &drm_drv->psr_list, list) {
 		if (psr->encoder == encoder) {
-			input_unregister_handler(&psr->input_handler);
-			cancel_delayed_work_sync(&psr->flush_work);
-			cancel_work_sync(&psr->disable_work);
+			/*
+			 * Any other value would mean that the encoder
+			 * is still in use.
+			 */
+			WARN_ON(psr->inhibit_count != 1);
+
 			list_del(&psr->list);
+			input_unregister_handler(&psr->input_handler);
 			kfree(psr->input_handler.name);
 			kfree(psr);
 		}
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
index 06537ee27565..40e026c14168 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_psr.h
@@ -18,8 +18,8 @@
 void rockchip_drm_psr_flush_all(struct drm_device *dev);
 int rockchip_drm_psr_flush(struct drm_crtc *crtc);
 
-int rockchip_drm_psr_activate(struct drm_encoder *encoder);
-int rockchip_drm_psr_deactivate(struct drm_encoder *encoder);
+int rockchip_drm_psr_inhibit_put(struct drm_encoder *encoder);
+int rockchip_drm_psr_inhibit_get(struct drm_encoder *encoder);
 
 int rockchip_drm_psr_register(struct drm_encoder *encoder,
 			int (*psr_set)(struct drm_encoder *, bool enable));
-- 
2.16.1
