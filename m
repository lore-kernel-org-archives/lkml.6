Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2336C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752A92086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752A92086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390164AbeIUTgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:36:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389991AbeIUTgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:36:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 444C830026A9;
        Fri, 21 Sep 2018 13:47:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0518450A5F;
        Fri, 21 Sep 2018 13:47:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3A28E9EE59; Fri, 21 Sep 2018 15:47:05 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, michel@daenzer.net, imirkin@alum.mit.edu,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 4/6] drm/bochs: support changing byteorder at mode set time
Date:   Fri, 21 Sep 2018 15:47:02 +0200
Message-Id: <20180921134704.12826-5-kraxel@redhat.com>
In-Reply-To: <20180921134704.12826-1-kraxel@redhat.com>
References: <20180921134704.12826-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 21 Sep 2018 13:47:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bochs_hw_set_*_endian() helper functions, to set the framebuffer
byteorder at mode set time.  Support both DRM_FORMAT_XRGB8888 and
DRM_FORMAT_BGRX8888 framebuffer formats, no matter what the native
machine byte order is.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs.h       |  4 ++-
 drivers/gpu/drm/bochs/bochs_fbdev.c |  3 +-
 drivers/gpu/drm/bochs/bochs_hw.c    | 64 +++++++++++++++++++++++++++++--------
 drivers/gpu/drm/bochs/bochs_kms.c   |  8 +++--
 4 files changed, 61 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index b4f6bb5219..e7a69077e4 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -58,6 +58,7 @@ struct bochs_device {
 	void __iomem   *fb_map;
 	unsigned long  fb_base;
 	unsigned long  fb_size;
+	unsigned long  qext_size;
 
 	/* mode */
 	u16 xres;
@@ -121,7 +122,8 @@ int bochs_hw_init(struct drm_device *dev);
 void bochs_hw_fini(struct drm_device *dev);
 
 void bochs_hw_setmode(struct bochs_device *bochs,
-		      struct drm_display_mode *mode);
+		      struct drm_display_mode *mode,
+		      const struct drm_format_info *format);
 void bochs_hw_setbase(struct bochs_device *bochs,
 		      int x, int y, u64 addr);
 
diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
index c46fdae44e..dd3c7df267 100644
--- a/drivers/gpu/drm/bochs/bochs_fbdev.c
+++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
@@ -140,7 +140,8 @@ static struct drm_framebuffer *
 bochs_gem_fb_create(struct drm_device *dev, struct drm_file *file,
 		    const struct drm_mode_fb_cmd2 *mode_cmd)
 {
-	if (mode_cmd->pixel_format != DRM_FORMAT_HOST_XRGB8888)
+	if (mode_cmd->pixel_format != DRM_FORMAT_XRGB8888 &&
+	    mode_cmd->pixel_format != DRM_FORMAT_BGRX8888)
 		return ERR_PTR(-EINVAL);
 
 	return drm_gem_fb_create(dev, file, mode_cmd);
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index 16e4f1cacc..cacff73a64 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -47,11 +47,33 @@ static void bochs_dispi_write(struct bochs_device *bochs, u16 reg, u16 val)
 	}
 }
 
+static void bochs_hw_set_big_endian(struct bochs_device *bochs)
+{
+	if (bochs->qext_size < 8)
+		return;
+
+	writel(0xbebebebe, bochs->mmio + 0x604);
+}
+
+static void bochs_hw_set_little_endian(struct bochs_device *bochs)
+{
+	if (bochs->qext_size < 8)
+		return;
+
+	writel(0x1e1e1e1e, bochs->mmio + 0x604);
+}
+
+#ifdef __BIG_ENDIAN
+#define bochs_hw_set_native_endian(_b) bochs_hw_set_big_endian(_b)
+#else
+#define bochs_hw_set_native_endian(_b) bochs_hw_set_little_endian(_b)
+#endif
+
 int bochs_hw_init(struct drm_device *dev)
 {
 	struct bochs_device *bochs = dev->dev_private;
 	struct pci_dev *pdev = dev->pdev;
-	unsigned long addr, size, mem, ioaddr, iosize, qext_size;
+	unsigned long addr, size, mem, ioaddr, iosize;
 	u16 id;
 
 	if (pdev->resource[2].flags & IORESOURCE_MEM) {
@@ -117,19 +139,14 @@ int bochs_hw_init(struct drm_device *dev)
 		 ioaddr);
 
 	if (bochs->mmio && pdev->revision >= 2) {
-		qext_size = readl(bochs->mmio + 0x600);
-		if (qext_size < 4 || qext_size > iosize)
+		bochs->qext_size = readl(bochs->mmio + 0x600);
+		if (bochs->qext_size < 4 || bochs->qext_size > iosize) {
+			bochs->qext_size = 0;
 			goto noext;
-		DRM_DEBUG("Found qemu ext regs, size %ld\n", qext_size);
-		if (qext_size >= 8) {
-#ifdef __BIG_ENDIAN
-			writel(0xbebebebe, bochs->mmio + 0x604);
-#else
-			writel(0x1e1e1e1e, bochs->mmio + 0x604);
-#endif
-			DRM_DEBUG("  qext endian: 0x%x\n",
-				  readl(bochs->mmio + 0x604));
 		}
+		DRM_DEBUG("Found qemu ext regs, size %ld\n",
+			  bochs->qext_size);
+		bochs_hw_set_native_endian(bochs);
 	}
 
 noext:
@@ -150,7 +167,8 @@ void bochs_hw_fini(struct drm_device *dev)
 }
 
 void bochs_hw_setmode(struct bochs_device *bochs,
-		      struct drm_display_mode *mode)
+		      struct drm_display_mode *mode,
+		      const struct drm_format_info *format)
 {
 	bochs->xres = mode->hdisplay;
 	bochs->yres = mode->vdisplay;
@@ -158,8 +176,12 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 	bochs->stride = mode->hdisplay * (bochs->bpp / 8);
 	bochs->yres_virtual = bochs->fb_size / bochs->stride;
 
-	DRM_DEBUG_DRIVER("%dx%d @ %d bpp, vy %d\n",
+	DRM_DEBUG_DRIVER("%dx%d @ %d bpp, format %c%c%c%c, vy %d\n",
 			 bochs->xres, bochs->yres, bochs->bpp,
+			 (format->format >>  0) & 0xff,
+			 (format->format >>  8) & 0xff,
+			 (format->format >> 16) & 0xff,
+			 (format->format >> 24) & 0xff,
 			 bochs->yres_virtual);
 
 	bochs_vga_writeb(bochs, 0x3c0, 0x20); /* unblank */
@@ -177,6 +199,20 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_ENABLE,
 			  VBE_DISPI_ENABLED | VBE_DISPI_LFB_ENABLED);
+
+	switch (format->format) {
+	case DRM_FORMAT_XRGB8888:
+		bochs_hw_set_little_endian(bochs);
+		break;
+	case DRM_FORMAT_BGRX8888:
+		bochs_hw_set_big_endian(bochs);
+		break;
+	default:
+		/* should not happen */
+		DRM_ERROR("%s: Huh? Got framebuffer format 0x%x",
+			  __func__, format->format);
+		break;
+	};
 }
 
 void bochs_hw_setbase(struct bochs_device *bochs,
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index f3fdaf9456..9bc5b438ae 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -77,7 +77,10 @@ static int bochs_crtc_mode_set(struct drm_crtc *crtc,
 	struct bochs_device *bochs =
 		container_of(crtc, struct bochs_device, crtc);
 
-	bochs_hw_setmode(bochs, mode);
+	if (WARN_ON(crtc->primary->fb == NULL))
+		return -EINVAL;
+
+	bochs_hw_setmode(bochs, mode, crtc->primary->fb->format);
 	bochs_crtc_mode_set_base(crtc, x, y, old_fb);
 	return 0;
 }
@@ -127,7 +130,8 @@ static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
 };
 
 static const uint32_t bochs_formats[] = {
-	DRM_FORMAT_HOST_XRGB8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_BGRX8888,
 };
 
 static struct drm_plane *bochs_primary_plane(struct drm_device *dev)
-- 
2.9.3

