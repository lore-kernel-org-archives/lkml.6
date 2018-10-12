Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0B7C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522052098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J2pB9MSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522052098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeJMDvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:51:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56838 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbeJMDva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:51:30 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9CKHGLH122224;
        Fri, 12 Oct 2018 15:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539375436;
        bh=b6E8oXItaNH66wt3E4Y8dtew64zag+r7x73OQ+Bu6e8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=J2pB9MSO5mt/FiR9UJ5R4a7KoAYNgGpeJYxW/FamKyQKGqfOd7NH6X35WzIIOTFPU
         sPeyFgAdVX+ZF3k8vyRbMP5SyKWGMZ4bjqtVF2VXEqiEas+t0r/PhAAU4GThH0UA5m
         vRj69WIdgaz/rukOLbfcZYlCTQXUSNAn3q23bZoc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9CKHGcx011820;
        Fri, 12 Oct 2018 15:17:16 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 12
 Oct 2018 15:17:16 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 12 Oct 2018 15:17:16 -0500
Received: from uda0869644a.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9CKH7EZ000402;
        Fri, 12 Oct 2018 15:17:16 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>, Benoit Parrot <bparrot@ti.com>
Subject: [Patch v4 5/8] drm/omap: Add global state as a private atomic object
Date:   Fri, 12 Oct 2018 15:17:00 -0500
Message-ID: <20181012201703.29065-6-bparrot@ti.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20181012201703.29065-1-bparrot@ti.com>
References: <20181012201703.29065-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Global shared resources (like hw overlays) for omapdrm are implemented
as a part of atomic state using the drm_private_obj infrastructure
available in the atomic core.

omap_global_state is introduced as a drm atomic private object. The two
funcs omap_get_global_state() and omap_get_existing_global_state() are
the two variants that will be used to access omap_global_state.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c | 97 +++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/omapdrm/omap_drv.h | 23 +++++++++
 2 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 2921cc90f2d8..94658ec79c76 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -129,6 +129,94 @@ static const struct drm_mode_config_funcs omap_mode_config_funcs = {
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
+/* Global/shared object state funcs */
+
+/*
+ * This is a helper that returns the private state currently in operation.
+ * Note that this would return the "old_state" if called in the atomic check
+ * path, and the "new_state" after the atomic swap has been done.
+ */
+struct omap_global_state *
+omap_get_existing_global_state(struct omap_drm_private *priv)
+{
+	return to_omap_global_state(priv->glob_obj.state);
+}
+
+/*
+ * This acquires the modeset lock set aside for global state, creates
+ * a new duplicated private object state.
+ */
+struct omap_global_state *__must_check
+omap_get_global_state(struct drm_atomic_state *s)
+{
+	struct omap_drm_private *priv = s->dev->dev_private;
+	struct drm_private_state *priv_state;
+	int ret;
+
+	if (!drm_modeset_is_locked(&priv->glob_obj_lock)) {
+		ret = drm_modeset_lock(&priv->glob_obj_lock, s->acquire_ctx);
+		if (ret) {
+			DBG("getting priv->glob_obj_lock (%p) failed %d",
+			    &priv->glob_obj_lock, ret);
+			return ERR_PTR(ret);
+		}
+	}
+
+	priv_state = drm_atomic_get_private_obj_state(s, &priv->glob_obj);
+	if (IS_ERR(priv_state))
+		return ERR_CAST(priv_state);
+
+	return to_omap_global_state(priv_state);
+}
+
+static struct drm_private_state *
+omap_global_duplicate_state(struct drm_private_obj *obj)
+{
+	struct omap_global_state *state;
+
+	state = kmemdup(obj->state, sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return NULL;
+
+	__drm_atomic_helper_private_obj_duplicate_state(obj, &state->base);
+
+	return &state->base;
+}
+
+static void omap_global_destroy_state(struct drm_private_obj *obj,
+				      struct drm_private_state *state)
+{
+	struct omap_global_state *omap_state = to_omap_global_state(state);
+
+	kfree(omap_state);
+}
+
+static const struct drm_private_state_funcs omap_global_state_funcs = {
+	.atomic_duplicate_state = omap_global_duplicate_state,
+	.atomic_destroy_state = omap_global_destroy_state,
+};
+
+static int omap_global_obj_init(struct omap_drm_private *priv)
+{
+	struct omap_global_state *state;
+
+	drm_modeset_lock_init(&priv->glob_obj_lock);
+
+	state = kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	drm_atomic_private_obj_init(&priv->glob_obj, &state->base,
+				    &omap_global_state_funcs);
+	return 0;
+}
+
+static void omap_global_obj_fini(struct omap_drm_private *priv)
+{
+	drm_atomic_private_obj_fini(&priv->glob_obj);
+	drm_modeset_lock_fini(&priv->glob_obj_lock);
+}
+
 static void omap_disconnect_pipelines(struct drm_device *ddev)
 {
 	struct omap_drm_private *priv = ddev->dev_private;
@@ -569,10 +657,14 @@ static int omapdrm_init(struct omap_drm_private *priv, struct device *dev)
 
 	omap_gem_init(ddev);
 
-	ret = omap_hwoverlays_init(priv);
+	ret = omap_global_obj_init(priv);
 	if (ret)
 		goto err_gem_deinit;
 
+	ret = omap_hwoverlays_init(priv);
+	if (ret)
+		goto err_free_priv_obj;
+
 	ret = omap_modeset_init(ddev);
 	if (ret) {
 		dev_err(priv->dev, "omap_modeset_init failed: ret=%d\n", ret);
@@ -612,6 +704,8 @@ static int omapdrm_init(struct omap_drm_private *priv, struct device *dev)
 err_cleanup_modeset:
 	drm_mode_config_cleanup(ddev);
 	omap_drm_irq_uninstall(ddev);
+err_free_priv_obj:
+	omap_global_obj_fini(priv);
 err_free_overlays:
 	omap_hwoverlays_destroy(priv);
 err_gem_deinit:
@@ -644,6 +738,7 @@ static void omapdrm_cleanup(struct omap_drm_private *priv)
 	omap_drm_irq_uninstall(ddev);
 	omap_gem_deinit(ddev);
 
+	omap_global_obj_fini(priv);
 	omap_hwoverlays_destroy(priv);
 
 	destroy_workqueue(priv->wq);
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index 929f04e7cc3b..f374dc100447 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -23,6 +23,7 @@
 #include <linux/workqueue.h>
 
 #include <drm/drmP.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_gem.h>
 #include <drm/omap_drm.h>
@@ -54,6 +55,17 @@ struct omap_drm_pipeline {
 	struct omap_dss_device *display;
 };
 
+/*
+ * Global private object state for tracking resources that are shared across
+ * multiple kms objects (planes/crtcs/etc).
+ */
+#define to_omap_global_state(x) container_of(x, struct omap_global_state, base)
+struct omap_global_state {
+	struct drm_private_state base;
+
+	struct drm_atomic_state *state;
+};
+
 struct omap_drm_private {
 	struct drm_device *ddev;
 	struct device *dev;
@@ -73,6 +85,13 @@ struct omap_drm_private {
 	unsigned int num_ovls;
 	struct omap_hw_overlay *overlays[8];
 
+	/*
+	 * Global private object state, Do not access directly, use
+	 * omap_global_get_state()
+	 */
+	struct drm_modeset_lock glob_obj_lock;
+	struct drm_private_obj glob_obj;
+
 	struct drm_fb_helper *fbdev;
 
 	struct workqueue_struct *wq;
@@ -100,5 +119,9 @@ struct omap_drm_private {
 
 
 int omap_debugfs_init(struct drm_minor *minor);
+struct omap_global_state *__must_check
+omap_get_global_state(struct drm_atomic_state *s);
+struct omap_global_state *
+omap_get_existing_global_state(struct omap_drm_private *priv);
 
 #endif /* __OMAPDRM_DRV_H__ */
-- 
2.9.0

