Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C212AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D33220652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfARMVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:21:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbfARMUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:20:31 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70084132690;
        Fri, 18 Jan 2019 12:20:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-38.ams2.redhat.com [10.36.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6691760851;
        Fri, 18 Jan 2019 12:20:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D9A3E1FCC2; Fri, 18 Jan 2019 13:20:22 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 17/23] drm/qxl: use generic fbdev emulation
Date:   Fri, 18 Jan 2019 13:20:14 +0100
Message-Id: <20190118122020.27596-18-kraxel@redhat.com>
In-Reply-To: <20190118122020.27596-1-kraxel@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 18 Jan 2019 12:20:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch qxl over to the new generic fbdev emulation.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 7 -------
 drivers/gpu/drm/qxl/qxl_drv.c     | 2 ++
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index ef832f98ab..9c751f01e3 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1221,18 +1221,11 @@ int qxl_modeset_init(struct qxl_device *qdev)
 	qxl_display_read_client_monitors_config(qdev);
 
 	drm_mode_config_reset(&qdev->ddev);
-
-	/* primary surface must be created by this point, to allow
-	 * issuing command queue commands and having them read by
-	 * spice server. */
-	qxl_fbdev_init(qdev);
 	return 0;
 }
 
 void qxl_modeset_fini(struct qxl_device *qdev)
 {
-	qxl_fbdev_fini(qdev);
-
 	qxl_destroy_monitors_object(qdev);
 	drm_mode_config_cleanup(&qdev->ddev);
 }
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 13c8a662f9..3fce7d16df 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -93,6 +93,8 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		goto modeset_cleanup;
 
+	drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "qxl");
+	drm_fbdev_generic_setup(&qdev->ddev, 32);
 	return 0;
 
 modeset_cleanup:
-- 
2.9.3

