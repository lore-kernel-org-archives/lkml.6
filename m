Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE3FC4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68189206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lekensteyn.nl header.i=@lekensteyn.nl header.b="yPKsMqIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68189206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lekensteyn.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeIGCzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:55:54 -0400
Received: from lekensteyn.nl ([178.21.112.251]:47253 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728170AbeIGCzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=1aZbXxiFoDDSHnKHZSWLhkTST3t+hkEUs5imDri/IRQ=;
        b=yPKsMqIB8CFC0VC+7VPUVvNu8ofFefpDWx3DXBvBrVtVdr3H0O4GK3UFmLc7GzyfIio5HbmkhqI2eJoRmR8eF4FjdP36QnrXmrn5D/apb//ZqAtzjmnY3UERpYzEYVGesII/MY7Rhz59KFwGJ7ya1kvkFCcurFS/xVdjj8iKCPGJiaVG2vuxbX94mkOdGG+7zv9d/f/F+v8XnCNc7u7m0XFhUqUsXc5coSWWOpnwtGOpK9R8a72T1/AswUgli0ICdApiNAWWHEK9El46wxQ+yizqH+iaUq4UnFgzBR5Rv9SF4bp2ZY/1Hav4EFQCwDkBdPTt6sNzUOlruxbDN2L4FA==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <peter@lekensteyn.nl>)
        id 1fy2bO-0005Us-IX; Fri, 07 Sep 2018 00:18:15 +0200
From:   Peter Wu <peter@lekensteyn.nl>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] drm/fb-helper: improve documentation and print warnings
Date:   Fri,  7 Sep 2018 00:18:10 +0200
Message-Id: <20180906221810.20170-5-peter@lekensteyn.nl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180906221810.20170-1-peter@lekensteyn.nl>
References: <20180906221810.20170-1-peter@lekensteyn.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify the relation between drm_fb_helper_fbdev_setup/teardown. Clarify
requirements for the new generic fbdev emulation API and log some more
details in case the driver does something wrong. Fix related typos.

Cc: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 drivers/gpu/drm/drm_fb_helper.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 4b0dd20bccb8..7f92ff173986 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2821,7 +2821,9 @@ EXPORT_SYMBOL(drm_fb_helper_hotplug_event);
  * The caller must to provide a &drm_fb_helper_funcs->fb_probe callback
  * function.
  *
- * See also: drm_fb_helper_initial_config()
+ * Use drm_fb_helper_fbdev_teardown() to destroy the fbdev.
+ *
+ * See also: drm_fb_helper_initial_config(), drm_fbdev_generic_setup().
  *
  * Returns:
  * Zero on success or negative error code on failure.
@@ -3037,7 +3039,7 @@ static struct fb_deferred_io drm_fbdev_defio = {
  * @fb_helper: fbdev helper structure
  * @sizes: describes fbdev size and scanout surface size
  *
- * This function uses the client API to crate a framebuffer backed by a dumb buffer.
+ * This function uses the client API to create a framebuffer backed by a dumb buffer.
  *
  * The _sys_ versions are used for &fb_ops.fb_read, fb_write, fb_fillrect,
  * fb_copyarea, fb_imageblit.
@@ -3165,8 +3167,10 @@ static int drm_fbdev_client_hotplug(struct drm_client_dev *client)
 	if (dev->fb_helper)
 		return drm_fb_helper_hotplug_event(dev->fb_helper);
 
-	if (!dev->mode_config.num_connector)
+	if (!dev->mode_config.num_connector) {
+		DRM_DEV_DEBUG(dev->dev, "No connectors found, will not create framebuffer!\n");
 		return 0;
+	}
 
 	ret = drm_fb_helper_fbdev_setup(dev, fb_helper, &drm_fb_helper_generic_funcs,
 					fb_helper->preferred_bpp, 0);
@@ -3187,13 +3191,15 @@ static const struct drm_client_funcs drm_fbdev_client_funcs = {
 };
 
 /**
- * drm_fb_helper_generic_fbdev_setup() - Setup generic fbdev emulation
+ * drm_fbdev_generic_setup() - Setup generic fbdev emulation
  * @dev: DRM device
  * @preferred_bpp: Preferred bits per pixel for the device.
  *                 @dev->mode_config.preferred_depth is used if this is zero.
  *
  * This function sets up generic fbdev emulation for drivers that supports
- * dumb buffers with a virtual address and that can be mmap'ed.
+ * dumb buffers with a virtual address and that can be mmap'ed. If the driver
+ * does not support these functions, it could use drm_fb_helper_fbdev_setup().
+ * This function can only be used with devices created using drm_dev_register().
  *
  * Restore, hotplug events and teardown are all taken care of. Drivers that do
  * suspend/resume need to call drm_fb_helper_set_suspend_unlocked() themselves.
@@ -3206,6 +3212,8 @@ static const struct drm_client_funcs drm_fbdev_client_funcs = {
  * This function is safe to call even when there are no connectors present.
  * Setup will be retried on the next hotplug event.
  *
+ * The fbdev is destroyed by drm_dev_unregister().
+ *
  * Returns:
  * Zero on success or negative error code on failure.
  */
@@ -3214,6 +3222,8 @@ int drm_fbdev_generic_setup(struct drm_device *dev, unsigned int preferred_bpp)
 	struct drm_fb_helper *fb_helper;
 	int ret;
 
+	WARN(dev->fb_helper, "fb_helper is already set!\n");
+
 	if (!drm_fbdev_emulation)
 		return 0;
 
@@ -3224,12 +3234,15 @@ int drm_fbdev_generic_setup(struct drm_device *dev, unsigned int preferred_bpp)
 	ret = drm_client_new(dev, &fb_helper->client, "fbdev", &drm_fbdev_client_funcs);
 	if (ret) {
 		kfree(fb_helper);
+		DRM_DEV_ERROR(dev->dev, "Failed to register client: %d\n", ret);
 		return ret;
 	}
 
 	fb_helper->preferred_bpp = preferred_bpp;
 
-	drm_fbdev_client_hotplug(&fb_helper->client);
+	ret = drm_fbdev_client_hotplug(&fb_helper->client);
+	if (ret)
+		DRM_DEV_DEBUG(dev->dev, "client hotplug ret=%d\n", ret);
 
 	return 0;
 }
-- 
2.18.0

