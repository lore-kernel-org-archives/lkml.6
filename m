Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CACC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C5F2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C5F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbeIGMMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:12:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbeIGMMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:12:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8848240241EE;
        Fri,  7 Sep 2018 07:32:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CEE37D4D8;
        Fri,  7 Sep 2018 07:32:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8138E16E08; Fri,  7 Sep 2018 09:32:23 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm: refuse ADDFB2 ioctl for broken bigendian drivers
Date:   Fri,  7 Sep 2018 09:32:13 +0200
Message-Id: <20180907073213.20410-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 07 Sep 2018 07:32:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 07 Sep 2018 07:32:26 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers must set the quirk_addfb_prefer_host_byte_order quirk to make
the drm_mode_addfb() compat code work correctly on bigendian machines.

If they don't they interpret pixel_format values incorrectly for bug
compatibility, which in turn implies the ADDFB2 ioctl does not work
correctly then.  So block it to make userspace fallback to ADDFB.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/drm_crtc_internal.h |  6 ++++--
 drivers/gpu/drm/drm_framebuffer.c   | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/drm_ioctl.c         |  2 +-
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
index b613227633..6719e1c8df 100644
--- a/drivers/gpu/drm/drm_crtc_internal.h
+++ b/drivers/gpu/drm/drm_crtc_internal.h
@@ -174,6 +174,8 @@ void drm_fb_release(struct drm_file *file_priv);
 
 int drm_mode_addfb(struct drm_device *dev, struct drm_mode_fb_cmd *or,
 		   struct drm_file *file_priv);
+int drm_mode_addfb2(struct drm_device *dev,
+		    void *data, struct drm_file *file_priv);
 int drm_mode_rmfb(struct drm_device *dev, u32 fb_id,
 		  struct drm_file *file_priv);
 
@@ -181,8 +183,8 @@ int drm_mode_rmfb(struct drm_device *dev, u32 fb_id,
 /* IOCTL */
 int drm_mode_addfb_ioctl(struct drm_device *dev,
 			 void *data, struct drm_file *file_priv);
-int drm_mode_addfb2(struct drm_device *dev,
-		    void *data, struct drm_file *file_priv);
+int drm_mode_addfb2_ioctl(struct drm_device *dev,
+			  void *data, struct drm_file *file_priv);
 int drm_mode_rmfb_ioctl(struct drm_device *dev,
 			void *data, struct drm_file *file_priv);
 int drm_mode_getfb(struct drm_device *dev,
diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index f863f8a20f..fb7528444c 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -363,6 +363,30 @@ int drm_mode_addfb2(struct drm_device *dev,
 	return 0;
 }
 
+int drm_mode_addfb2_ioctl(struct drm_device *dev,
+			  void *data, struct drm_file *file_priv)
+{
+#ifdef __BIG_ENDIAN
+	if (!dev->mode_config.quirk_addfb_prefer_host_byte_order) {
+		/*
+		 * Drivers must set the
+		 * quirk_addfb_prefer_host_byte_order quirk to make
+		 * the drm_mode_addfb() compat code work correctly on
+		 * bigendian machines.
+		 *
+		 * If they don't they interpret pixel_format values
+		 * incorrectly for bug compatibility, which in turn
+		 * implies the ADDFB2 ioctl does not work correctly
+		 * then.  So block it to make userspace fallback to
+		 * ADDFB.
+		 */
+		DRM_DEBUG_KMS("addfb2 broken on bigendian");
+		return -EINVAL;
+	}
+#endif
+	return drm_mode_addfb2(dev, data, file_priv);
+}
+
 struct drm_mode_rmfb_work {
 	struct work_struct work;
 	struct list_head fbs;
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index ea10e9a26a..6b4a633b42 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -645,7 +645,7 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETPROPBLOB, drm_mode_getblob_ioctl, DRM_UNLOCKED),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETFB, drm_mode_getfb, DRM_UNLOCKED),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_ADDFB, drm_mode_addfb_ioctl, DRM_UNLOCKED),
-	DRM_IOCTL_DEF(DRM_IOCTL_MODE_ADDFB2, drm_mode_addfb2, DRM_UNLOCKED),
+	DRM_IOCTL_DEF(DRM_IOCTL_MODE_ADDFB2, drm_mode_addfb2_ioctl, DRM_UNLOCKED),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_RMFB, drm_mode_rmfb_ioctl, DRM_UNLOCKED),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_PAGE_FLIP, drm_mode_page_flip_ioctl, DRM_MASTER|DRM_UNLOCKED),
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_DIRTYFB, drm_mode_dirtyfb_ioctl, DRM_MASTER|DRM_UNLOCKED),
-- 
2.9.3

