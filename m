Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB91C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF30D2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfAHLZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:25:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728644AbfAHLZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:25:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C021363144;
        Tue,  8 Jan 2019 11:25:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com [10.36.116.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9E53189E3;
        Tue,  8 Jan 2019 11:25:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 472C75EE4; Tue,  8 Jan 2019 12:25:21 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 12/15] drm/bochs: switch to generic drm fbdev emulation
Date:   Tue,  8 Jan 2019 12:25:16 +0100
Message-Id: <20190108112519.27473-13-kraxel@redhat.com>
In-Reply-To: <20190108112519.27473-1-kraxel@redhat.com>
References: <20190108112519.27473-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 08 Jan 2019 11:25:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_drv.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index a9c7140e3b..350e34cf2c 100644
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
@@ -178,6 +170,7 @@ static int bochs_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_unload;
 
+	drm_fbdev_generic_setup(dev, 32);
 	return ret;
 
 err_unload:
-- 
2.9.3

