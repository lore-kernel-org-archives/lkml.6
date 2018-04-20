Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753944AbeDTHTL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:19:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753798AbeDTHTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:19:07 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/4] qxl: remove qxl_io_log()
Date: Fri, 20 Apr 2018 09:19:01 +0200
Message-Id: <20180420071904.24276-2-kraxel@redhat.com>
In-Reply-To: <20180420071904.24276-1-kraxel@redhat.com>
References: <20180420071904.24276-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qxl_io_log() sends messages over to the host (qemu) for logging.
Remove the function and all callers, we can just use standard
DRM_DEBUG calls (and if needed a serial console).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h     |  3 ---
 drivers/gpu/drm/qxl/qxl_cmd.c     | 34 ++--------------------------------
 drivers/gpu/drm/qxl/qxl_display.c | 27 ++++-----------------------
 drivers/gpu/drm/qxl/qxl_fb.c      |  2 --
 drivers/gpu/drm/qxl/qxl_irq.c     |  3 +--
 5 files changed, 7 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 00a1a66b05..4b89840173 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -298,9 +298,6 @@ struct qxl_device {
 	int monitors_config_height;
 };
 
-/* forward declaration for QXL_INFO_IO */
-__printf(2,3) void qxl_io_log(struct qxl_device *qdev, const char *fmt, ...);
-
 extern const struct drm_ioctl_desc qxl_ioctls[];
 extern int qxl_max_ioctl;
 
diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index c0fb52c6d4..850f8d7d37 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -341,12 +341,9 @@ int qxl_io_update_area(struct qxl_device *qdev, struct qxl_bo *surf,
 	surface_height = surf->surf.height;
 
 	if (area->left < 0 || area->top < 0 ||
-	    area->right > surface_width || area->bottom > surface_height) {
-		qxl_io_log(qdev, "%s: not doing area update for "
-			   "%d, (%d,%d,%d,%d) (%d,%d)\n", __func__, surface_id, area->left,
-			   area->top, area->right, area->bottom, surface_width, surface_height);
+	    area->right > surface_width || area->bottom > surface_height)
 		return -EINVAL;
-	}
+
 	mutex_lock(&qdev->update_area_mutex);
 	qdev->ram_header->update_area = *area;
 	qdev->ram_header->update_surface = surface_id;
@@ -407,20 +404,6 @@ void qxl_io_memslot_add(struct qxl_device *qdev, uint8_t id)
 	wait_for_io_cmd(qdev, id, QXL_IO_MEMSLOT_ADD_ASYNC);
 }
 
-void qxl_io_log(struct qxl_device *qdev, const char *fmt, ...)
-{
-	va_list args;
-
-	va_start(args, fmt);
-	vsnprintf(qdev->ram_header->log_buf, QXL_LOG_BUF_SIZE, fmt, args);
-	va_end(args);
-	/*
-	 * DO not do a DRM output here - this will call printk, which will
-	 * call back into qxl for rendering (qxl_fb)
-	 */
-	outb(0, qdev->io_base + QXL_IO_LOG);
-}
-
 void qxl_io_reset(struct qxl_device *qdev)
 {
 	outb(0, qdev->io_base + QXL_IO_RESET);
@@ -428,19 +411,6 @@ void qxl_io_reset(struct qxl_device *qdev)
 
 void qxl_io_monitors_config(struct qxl_device *qdev)
 {
-	qxl_io_log(qdev, "%s: %d [%dx%d+%d+%d]\n", __func__,
-		   qdev->monitors_config ?
-		   qdev->monitors_config->count : -1,
-		   qdev->monitors_config && qdev->monitors_config->count ?
-		   qdev->monitors_config->heads[0].width : -1,
-		   qdev->monitors_config && qdev->monitors_config->count ?
-		   qdev->monitors_config->heads[0].height : -1,
-		   qdev->monitors_config && qdev->monitors_config->count ?
-		   qdev->monitors_config->heads[0].x : -1,
-		   qdev->monitors_config && qdev->monitors_config->count ?
-		   qdev->monitors_config->heads[0].y : -1
-		   );
-
 	wait_for_io_cmd(qdev, 0, QXL_IO_MONITORS_CONFIG_ASYNC);
 }
 
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index ecb35ed0ea..dea757ef62 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -48,12 +48,8 @@ static void qxl_alloc_client_monitors_config(struct qxl_device *qdev, unsigned c
 		qdev->client_monitors_config = kzalloc(
 				sizeof(struct qxl_monitors_config) +
 				sizeof(struct qxl_head) * count, GFP_KERNEL);
-		if (!qdev->client_monitors_config) {
-			qxl_io_log(qdev,
-				   "%s: allocation failure for %u heads\n",
-				   __func__, count);
+		if (!qdev->client_monitors_config)
 			return;
-		}
 	}
 	qdev->client_monitors_config->count = count;
 }
@@ -74,12 +70,8 @@ static int qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
 	num_monitors = qdev->rom->client_monitors_config.count;
 	crc = crc32(0, (const uint8_t *)&qdev->rom->client_monitors_config,
 		  sizeof(qdev->rom->client_monitors_config));
-	if (crc != qdev->rom->client_monitors_config_crc) {
-		qxl_io_log(qdev, "crc mismatch: have %X (%zd) != %X\n", crc,
-			   sizeof(qdev->rom->client_monitors_config),
-			   qdev->rom->client_monitors_config_crc);
+	if (crc != qdev->rom->client_monitors_config_crc)
 		return MONITORS_CONFIG_BAD_CRC;
-	}
 	if (!num_monitors) {
 		DRM_DEBUG_KMS("no client monitors configured\n");
 		return status;
@@ -170,12 +162,10 @@ void qxl_display_read_client_monitors_config(struct qxl_device *qdev)
 		udelay(5);
 	}
 	if (status == MONITORS_CONFIG_BAD_CRC) {
-		qxl_io_log(qdev, "config: bad crc\n");
 		DRM_DEBUG_KMS("ignoring client monitors config: bad crc");
 		return;
 	}
 	if (status == MONITORS_CONFIG_UNCHANGED) {
-		qxl_io_log(qdev, "config: unchanged\n");
 		DRM_DEBUG_KMS("ignoring client monitors config: unchanged");
 		return;
 	}
@@ -385,14 +375,6 @@ static bool qxl_crtc_mode_fixup(struct drm_crtc *crtc,
 				  const struct drm_display_mode *mode,
 				  struct drm_display_mode *adjusted_mode)
 {
-	struct drm_device *dev = crtc->dev;
-	struct qxl_device *qdev = dev->dev_private;
-
-	qxl_io_log(qdev, "%s: (%d,%d) => (%d,%d)\n",
-		   __func__,
-		   mode->hdisplay, mode->vdisplay,
-		   adjusted_mode->hdisplay,
-		   adjusted_mode->vdisplay);
 	return true;
 }
 
@@ -403,10 +385,9 @@ qxl_send_monitors_config(struct qxl_device *qdev)
 
 	BUG_ON(!qdev->ram_header->monitors_config);
 
-	if (qdev->monitors_config->count == 0) {
-		qxl_io_log(qdev, "%s: 0 monitors??\n", __func__);
+	if (qdev->monitors_config->count == 0)
 		return;
-	}
+
 	for (i = 0 ; i < qdev->monitors_config->count ; ++i) {
 		struct qxl_head *head = &qdev->monitors_config->heads[i];
 
diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
index 338891401f..9a67526060 100644
--- a/drivers/gpu/drm/qxl/qxl_fb.c
+++ b/drivers/gpu/drm/qxl/qxl_fb.c
@@ -185,8 +185,6 @@ static int qxlfb_framebuffer_dirty(struct drm_framebuffer *fb,
 	/*
 	 * we are using a shadow draw buffer, at qdev->surface0_shadow
 	 */
-	qxl_io_log(qdev, "dirty x[%d, %d], y[%d, %d]\n", clips->x1, clips->x2,
-		   clips->y1, clips->y2);
 	image->dx = clips->x1;
 	image->dy = clips->y1;
 	image->width = clips->x2 - clips->x1;
diff --git a/drivers/gpu/drm/qxl/qxl_irq.c b/drivers/gpu/drm/qxl/qxl_irq.c
index 23a40106ab..3bb31add63 100644
--- a/drivers/gpu/drm/qxl/qxl_irq.c
+++ b/drivers/gpu/drm/qxl/qxl_irq.c
@@ -57,10 +57,9 @@ irqreturn_t qxl_irq_handler(int irq, void *arg)
 		 * to avoid endless loops).
 		 */
 		qdev->irq_received_error++;
-		qxl_io_log(qdev, "%s: driver is in bug mode.\n", __func__);
+		DRM_WARN("driver is in bug mode\n");
 	}
 	if (pending & QXL_INTERRUPT_CLIENT_MONITORS_CONFIG) {
-		qxl_io_log(qdev, "QXL_INTERRUPT_CLIENT_MONITORS_CONFIG\n");
 		schedule_work(&qdev->client_monitors_config_work);
 	}
 	qdev->ram_header->int_mask = QXL_INTERRUPT_MASK;
-- 
2.9.3
