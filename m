Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854E7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5513F20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfBTOgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:36:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfBTOgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:36:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1F0313BF4C;
        Wed, 20 Feb 2019 14:36:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-228.ams2.redhat.com [10.36.116.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68E3E60BE8;
        Wed, 20 Feb 2019 14:36:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3A5C211AAF; Wed, 20 Feb 2019 15:36:40 +0100 (CET)
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
Subject: [PATCH] drm/qxl: unbind vgacon
Date:   Wed, 20 Feb 2019 15:36:40 +0100
Message-Id: <20190220143640.9970-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 20 Feb 2019 14:36:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:  qxl switches from native mode back into vga compatibility mode
when it notices someone is accessing vga registers.  And vgacon does
exactly that before fbcon takes over.

Before qxl switched to the generic fbdev emulation that didn't cause any
problems.  With the generic fbdev emulation the switch to vga mode
happens now and then, probably caused by a initialization order change
and triggered by a printk in a bad moment.

So make sure we take vgacon out of the picture by making dummycon
taking over the console early enough.

Not entriely happy with the approach, I'm open to better ideas.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index bb81e310eb..88349dc13e 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -30,6 +30,7 @@
 
 #include <linux/module.h>
 #include <linux/console.h>
+#include <linux/vt_kern.h>
 
 #include <drm/drmP.h>
 #include <drm/drm.h>
@@ -89,6 +90,11 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	drm_kms_helper_poll_init(&qdev->ddev);
 
+	/* unbind vgacon to make sure it doesn't touch our vga registers */
+	console_lock();
+	ret = do_take_over_console(&dummy_con, 0, MAX_NR_CONSOLES - 1, true);
+	console_unlock();
+
 	/* Complete initialization. */
 	ret = drm_dev_register(&qdev->ddev, ent->driver_data);
 	if (ret)
-- 
2.9.3

