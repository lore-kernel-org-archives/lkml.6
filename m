Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331C1C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EE820661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EE820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeLIWWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:22:05 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35190 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726517AbeLIVzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:21 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72k-0002pr-6i; Sun, 09 Dec 2018 21:55:18 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0003Yn-IB; Sun, 09 Dec 2018 21:55:15 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Sean Paul" <seanpaul@chromium.org>,
        "Emil Lundmark" <lndmrk@chromium.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.730715302@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 230/328] drm: udl: Destroy framebuffer only if it was
 initialized
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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

Suggested-by: Sean Paul <seanpaul@chromium.org>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Emil Lundmark <lndmrk@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20180528142711.142466-1-lndmrk@chromium.org
Signed-off-by: Sean Paul <seanpaul@chromium.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/udl/udl_fb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/udl/udl_fb.c
+++ b/drivers/gpu/drm/udl/udl_fb.c
@@ -574,9 +574,11 @@ static void udl_fbdev_destroy(struct drm
 		framebuffer_release(info);
 	}
 	drm_fb_helper_fini(&ufbdev->helper);
-	drm_framebuffer_unregister_private(&ufbdev->ufb.base);
-	drm_framebuffer_cleanup(&ufbdev->ufb.base);
-	drm_gem_object_unreference_unlocked(&ufbdev->ufb.obj->base);
+	if (ufbdev->ufb.obj) {
+		drm_framebuffer_unregister_private(&ufbdev->ufb.base);
+		drm_framebuffer_cleanup(&ufbdev->ufb.base);
+		drm_gem_object_unreference_unlocked(&ufbdev->ufb.obj->base);
+	}
 }
 
 int udl_fbdev_init(struct drm_device *dev)

