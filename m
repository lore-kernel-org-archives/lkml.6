Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C124DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9829820675
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbfAKFir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:38:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730105AbfAKFiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:38:00 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE102A4056;
        Fri, 11 Jan 2019 05:38:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B9081E7;
        Fri, 11 Jan 2019 05:37:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 81BDE93E9; Fri, 11 Jan 2019 06:37:54 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, noralf@tronnes.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 14/16] drm/bochs: switch to generic drm fbdev emulation
Date:   Fri, 11 Jan 2019 06:37:50 +0100
Message-Id: <20190111053752.4004-15-kraxel@redhat.com>
In-Reply-To: <20190111053752.4004-1-kraxel@redhat.com>
References: <20190111053752.4004-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 11 Jan 2019 05:38:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs_drv.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index a3f4e21078..cea42ac64d 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -16,10 +16,6 @@ static int bochs_modeset = -1;
 module_param_named(modeset, bochs_modeset, int, 0444);
 MODULE_PARM_DESC(modeset, "enable/disable kernel modesetting");
 
-static bool enable_fbdev = true;
-module_param_named(fbdev, enable_fbdev, bool, 0444);
-MODULE_PARM_DESC(fbdev, "register fbdev device");
-
 /* ---------------------------------------------------------------------- */
 /* drm interface                                                          */
 
@@ -27,7 +23,6 @@ static void bochs_unload(struct drm_device *dev)
 {
 	struct bochs_device *bochs = dev->dev_private;
 
-	bochs_fbdev_fini(bochs);
 	bochs_kms_fini(bochs);
 	bochs_mm_fini(bochs);
 	bochs_hw_fini(dev);
@@ -58,9 +53,6 @@ static int bochs_load(struct drm_device *dev)
 	if (ret)
 		goto err;
 
-	if (enable_fbdev)
-		bochs_fbdev_init(bochs);
-
 	return 0;
 
 err:
@@ -110,9 +102,7 @@ static int bochs_pm_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
-	struct bochs_device *bochs = drm_dev->dev_private;
 
-	drm_fb_helper_set_suspend_unlocked(&bochs->fb.helper, 1);
 	return drm_mode_config_helper_suspend(drm_dev);
 }
 
@@ -120,9 +110,7 @@ static int bochs_pm_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
-	struct bochs_device *bochs = drm_dev->dev_private;
 
-	drm_fb_helper_set_suspend_unlocked(&bochs->fb.helper, 0);
 	return drm_mode_config_helper_resume(drm_dev);
 }
 #endif
@@ -167,6 +155,7 @@ static int bochs_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_unload;
 
+	drm_fbdev_generic_setup(dev, 32);
 	return ret;
 
 err_unload:
-- 
2.9.3

