Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E77C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D149920842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfBYIaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:30:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfBYIaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:30:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A606E3082206;
        Mon, 25 Feb 2019 08:30:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-228.ams2.redhat.com [10.36.116.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7A9710018F9;
        Mon, 25 Feb 2019 08:30:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C0B3A11AB5; Mon, 25 Feb 2019 09:30:09 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     intel-gfx@lists.freedesktop.org, daniel@ffwll.ch,
        Gerd Hoffmann <kraxel@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 1/3] drm: move i915_kick_out_vgacon to vgaarb
Date:   Mon, 25 Feb 2019 09:30:07 +0100
Message-Id: <20190225083009.16082-2-kraxel@redhat.com>
In-Reply-To: <20190225083009.16082-1-kraxel@redhat.com>
References: <20190225083009.16082-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 25 Feb 2019 08:30:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also rename it to vga_remove_vgacon and add kerneldoc text.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 include/linux/vgaarb.h          |  2 ++
 drivers/gpu/drm/i915/i915_drv.c | 35 +-----------------------------
 drivers/gpu/vga/vgaarb.c        | 48 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 34 deletions(-)

diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
index ee162e3e879b..553b34c8b5f7 100644
--- a/include/linux/vgaarb.h
+++ b/include/linux/vgaarb.h
@@ -125,9 +125,11 @@ extern void vga_put(struct pci_dev *pdev, unsigned int rsrc);
 #ifdef CONFIG_VGA_ARB
 extern struct pci_dev *vga_default_device(void);
 extern void vga_set_default_device(struct pci_dev *pdev);
+extern int vga_remove_vgacon(struct pci_dev *pdev);
 #else
 static inline struct pci_dev *vga_default_device(void) { return NULL; };
 static inline void vga_set_default_device(struct pci_dev *pdev) { };
+static inline int vga_remove_vgacon(struct pci_dev *pdev) { return 0; };
 #endif
 
 /*
diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 6630212f2faf..9df65d386d11 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -757,39 +757,6 @@ static int i915_kick_out_firmware_fb(struct drm_i915_private *dev_priv)
 	return ret;
 }
 
-#if !defined(CONFIG_VGA_CONSOLE)
-static int i915_kick_out_vgacon(struct drm_i915_private *dev_priv)
-{
-	return 0;
-}
-#elif !defined(CONFIG_DUMMY_CONSOLE)
-static int i915_kick_out_vgacon(struct drm_i915_private *dev_priv)
-{
-	return -ENODEV;
-}
-#else
-static int i915_kick_out_vgacon(struct drm_i915_private *dev_priv)
-{
-	int ret = 0;
-
-	DRM_INFO("Replacing VGA console driver\n");
-
-	console_lock();
-	if (con_is_bound(&vga_con))
-		ret = do_take_over_console(&dummy_con, 0, MAX_NR_CONSOLES - 1, 1);
-	if (ret == 0) {
-		ret = do_unregister_con_driver(&vga_con);
-
-		/* Ignore "already unregistered". */
-		if (ret == -ENODEV)
-			ret = 0;
-	}
-	console_unlock();
-
-	return ret;
-}
-#endif
-
 static void intel_init_dpio(struct drm_i915_private *dev_priv)
 {
 	/*
@@ -1420,7 +1387,7 @@ static int i915_driver_init_hw(struct drm_i915_private *dev_priv)
 		goto err_ggtt;
 	}
 
-	ret = i915_kick_out_vgacon(dev_priv);
+	ret = vga_remove_vgacon(pdev);
 	if (ret) {
 		DRM_ERROR("failed to remove conflicting VGA console\n");
 		goto err_ggtt;
diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index dc8e039bfab5..dc817104e424 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -48,6 +48,8 @@
 #include <linux/miscdevice.h>
 #include <linux/slab.h>
 #include <linux/screen_info.h>
+#include <linux/vt.h>
+#include <linux/console.h>
 
 #include <linux/uaccess.h>
 
@@ -168,6 +170,52 @@ void vga_set_default_device(struct pci_dev *pdev)
 	vga_default = pci_dev_get(pdev);
 }
 
+/**
+ * vga_remove_vgacon - deactivete vga console
+ *
+ * Unbind and unregister vgacon in case pdev is the default vga
+ * device.  Can be called by gpu drivers on initialization to make
+ * sure vga register access done by vgacon will not disturb the
+ * device.
+ *
+ * @pdev: pci device.
+ */
+#if !defined(CONFIG_VGA_CONSOLE)
+int vga_remove_vgacon(struct pci_dev *pdev)
+{
+        return 0;
+}
+#elif !defined(CONFIG_DUMMY_CONSOLE)
+int vga_remove_vgacon(struct pci_dev *pdev)
+{
+        return -ENODEV;
+}
+#else
+int vga_remove_vgacon(struct pci_dev *pdev)
+{
+        int ret = 0;
+
+	if (pdev != vga_default)
+		return 0;
+	vgaarb_info(&pdev->dev, "deactivate vga console\n");
+
+        console_lock();
+        if (con_is_bound(&vga_con))
+                ret = do_take_over_console(&dummy_con, 0, MAX_NR_CONSOLES - 1, 1);
+        if (ret == 0) {
+                ret = do_unregister_con_driver(&vga_con);
+
+                /* Ignore "already unregistered". */
+                if (ret == -ENODEV)
+                        ret = 0;
+        }
+        console_unlock();
+
+        return ret;
+}
+#endif
+EXPORT_SYMBOL(vga_remove_vgacon);
+
 static inline void vga_irq_set_state(struct vga_device *vgadev, bool state)
 {
 	if (vgadev->irq_set_state)
-- 
2.9.3

