Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32408C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C37920652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfARMVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:21:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbfARMU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:20:28 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93965804F5;
        Fri, 18 Jan 2019 12:20:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-38.ams2.redhat.com [10.36.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFA6019745;
        Fri, 18 Jan 2019 12:20:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8E5FB59E3; Fri, 18 Jan 2019 13:20:22 +0100 (CET)
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
Subject: [PATCH v3 15/23] drm/qxl: use qxl_num_crtc directly
Date:   Fri, 18 Jan 2019 13:20:12 +0100
Message-Id: <20190118122020.27596-16-kraxel@redhat.com>
In-Reply-To: <20190118122020.27596-1-kraxel@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 18 Jan 2019 12:20:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qdev->monitors_config->max_allowed is effectively set by the
qxl.num_heads module parameter, stored in the qxl_num_crtc variable.
Lets get rid of the indirection and use the variable qxl_num_crtc
directly.  The kernel doesn't need to dereference pointers each time it
needs the value, and when reading the code you don't have to trace where
and why qdev->monitors_config->max_allowed is set.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index d9de43e5fd..ef832f98ab 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -80,10 +80,10 @@ static int qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
 		DRM_DEBUG_KMS("no client monitors configured\n");
 		return status;
 	}
-	if (num_monitors > qdev->monitors_config->max_allowed) {
+	if (num_monitors > qxl_num_crtc) {
 		DRM_DEBUG_KMS("client monitors list will be truncated: %d < %d\n",
-			      qdev->monitors_config->max_allowed, num_monitors);
-		num_monitors = qdev->monitors_config->max_allowed;
+			      qxl_num_crtc, num_monitors);
+		num_monitors = qxl_num_crtc;
 	} else {
 		num_monitors = qdev->rom->client_monitors_config.count;
 	}
@@ -96,8 +96,7 @@ static int qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
 		return status;
 	}
 	/* we copy max from the client but it isn't used */
-	qdev->client_monitors_config->max_allowed =
-				qdev->monitors_config->max_allowed;
+	qdev->client_monitors_config->max_allowed = qxl_num_crtc;
 	for (i = 0 ; i < qdev->client_monitors_config->count ; ++i) {
 		struct qxl_urect *c_rect =
 			&qdev->rom->client_monitors_config.heads[i];
@@ -204,7 +203,7 @@ static int qxl_add_monitors_config_modes(struct drm_connector *connector,
 
 	if (!qdev->monitors_config)
 		return 0;
-	if (h >= qdev->monitors_config->max_allowed)
+	if (h >= qxl_num_crtc)
 		return 0;
 	if (!qdev->client_monitors_config)
 		return 0;
@@ -307,8 +306,7 @@ static void qxl_crtc_update_monitors_config(struct drm_crtc *crtc,
 		return;
 	}
 
-	if (!qdev->monitors_config ||
-	    qdev->monitors_config->max_allowed <= i)
+	if (!qdev->monitors_config || qxl_num_crtc <= i)
 		return;
 
 	head.id = i;
@@ -350,9 +348,10 @@ static void qxl_crtc_update_monitors_config(struct drm_crtc *crtc,
 	if (oldcount != qdev->monitors_config->count)
 		DRM_DEBUG_KMS("active heads %d -> %d (%d total)\n",
 			      oldcount, qdev->monitors_config->count,
-			      qdev->monitors_config->max_allowed);
+			      qxl_num_crtc);
 
 	qdev->monitors_config->heads[i] = head;
+	qdev->monitors_config->max_allowed = qxl_num_crtc;
 	qxl_send_monitors_config(qdev);
 }
 
@@ -1146,9 +1145,8 @@ int qxl_create_monitors_object(struct qxl_device *qdev)
 {
 	int ret;
 	struct drm_gem_object *gobj;
-	int max_allowed = qxl_num_crtc;
 	int monitors_config_size = sizeof(struct qxl_monitors_config) +
-		max_allowed * sizeof(struct qxl_head);
+		qxl_num_crtc * sizeof(struct qxl_head);
 
 	ret = qxl_gem_object_create(qdev, monitors_config_size, 0,
 				    QXL_GEM_DOMAIN_VRAM,
@@ -1170,9 +1168,8 @@ int qxl_create_monitors_object(struct qxl_device *qdev)
 		qxl_bo_physical_address(qdev, qdev->monitors_config_bo, 0);
 
 	memset(qdev->monitors_config, 0, monitors_config_size);
-	qdev->monitors_config->max_allowed = max_allowed;
-
-	qdev->dumb_heads = kcalloc(max_allowed, sizeof(qdev->dumb_heads[0]), GFP_KERNEL);
+	qdev->dumb_heads = kcalloc(qxl_num_crtc, sizeof(qdev->dumb_heads[0]),
+				   GFP_KERNEL);
 	return 0;
 }
 
-- 
2.9.3

