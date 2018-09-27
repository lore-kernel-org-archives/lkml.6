Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF32C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AEC2152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AEC2152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeI0Pjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:39:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56352 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeI0Pjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:39:32 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E75D21120;
        Thu, 27 Sep 2018 09:22:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Emil Lundmark <lndmrk@chromium.org>
Subject: [PATCH 4.14 47/64] drm: udl: Destroy framebuffer only if it was initialized
Date:   Thu, 27 Sep 2018 11:04:04 +0200
Message-Id: <20180927090256.569191069@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
References: <20180927090249.801943776@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emil Lundmark <lndmrk@chromium.org>

commit fcb74da1eb8edd3a4ef9b9724f88ed709d684227 upstream.

This fixes a NULL pointer dereference that can happen if the UDL
driver is unloaded before the framebuffer is initialized. This can
happen e.g. if the USB device is unplugged right after it was plugged
in.

As explained by Stéphane Marchesin:

It happens when fbdev is disabled (which is the case for Chrome OS).
Even though intialization of the fbdev part is optional (it's done in
udlfb_create which is the callback for fb_probe()), the teardown isn't
optional (udl_driver_unload -> udl_fbdev_cleanup ->
udl_fbdev_destroy).

Note that udl_fbdev_cleanup *tries* to be conditional (you can see it
does if (!udl->fbdev)) but that doesn't work, because udl->fbdev is
always set during udl_fbdev_init.

Cc: stable@vger.kernel.org
Suggested-by: Sean Paul <seanpaul@chromium.org>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Emil Lundmark <lndmrk@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20180528142711.142466-1-lndmrk@chromium.org
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/udl/udl_fb.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/udl/udl_fb.c
+++ b/drivers/gpu/drm/udl/udl_fb.c
@@ -432,9 +432,11 @@ static void udl_fbdev_destroy(struct drm
 {
 	drm_fb_helper_unregister_fbi(&ufbdev->helper);
 	drm_fb_helper_fini(&ufbdev->helper);
-	drm_framebuffer_unregister_private(&ufbdev->ufb.base);
-	drm_framebuffer_cleanup(&ufbdev->ufb.base);
-	drm_gem_object_put_unlocked(&ufbdev->ufb.obj->base);
+	if (ufbdev->ufb.obj) {
+		drm_framebuffer_unregister_private(&ufbdev->ufb.base);
+		drm_framebuffer_cleanup(&ufbdev->ufb.base);
+		drm_gem_object_put_unlocked(&ufbdev->ufb.obj->base);
+	}
 }
 
 int udl_fbdev_init(struct drm_device *dev)


