Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374A020842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfBYIaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:30:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfBYIaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:30:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47F33C057F4B;
        Mon, 25 Feb 2019 08:30:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-228.ams2.redhat.com [10.36.116.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02A995C21E;
        Mon, 25 Feb 2019 08:30:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id EDB8711AB7; Mon, 25 Feb 2019 09:30:09 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     intel-gfx@lists.freedesktop.org, daniel@ffwll.ch,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 2/3] drm/fb-helper: call vga_remove_vgacon automatically.
Date:   Mon, 25 Feb 2019 09:30:08 +0100
Message-Id: <20190225083009.16082-3-kraxel@redhat.com>
In-Reply-To: <20190225083009.16082-1-kraxel@redhat.com>
References: <20190225083009.16082-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 25 Feb 2019 08:30:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vga_remove_vgacon() call to
drm_fb_helper_remove_conflicting_pci_framebuffers().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 include/drm/drm_fb_helper.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index bb9acea61369..286d58efed5d 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -36,6 +36,7 @@ struct drm_fb_helper;
 #include <drm/drm_crtc.h>
 #include <drm/drm_device.h>
 #include <linux/kgdb.h>
+#include <linux/vgaarb.h>
 
 enum mode_set_atomic {
 	LEAVE_ATOMIC_MODE_SET,
@@ -642,11 +643,18 @@ drm_fb_helper_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
 						  int resource_id,
 						  const char *name)
 {
+	int ret = 0;
+
+	/*
+	 * WARNING: Apparently we must kick fbdev drivers before vgacon,
+	 * otherwise the vga fbdev driver falls over.
+	 */
 #if IS_REACHABLE(CONFIG_FB)
-	return remove_conflicting_pci_framebuffers(pdev, resource_id, name);
-#else
-	return 0;
+	ret = remove_conflicting_pci_framebuffers(pdev, resource_id, name);
 #endif
+	if (ret == 0)
+		ret = vga_remove_vgacon(pdev);
+	return ret;
 }
 
 #endif
-- 
2.9.3

