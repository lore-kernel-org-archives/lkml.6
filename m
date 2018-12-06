Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235D4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6AC20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6AC20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeLFKd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:33:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeLFKd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:33:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9B023082143;
        Thu,  6 Dec 2018 10:33:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com [10.36.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 693D85D9CD;
        Thu,  6 Dec 2018 10:33:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7D4479D8C; Thu,  6 Dec 2018 11:33:52 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/qxl: use qxl_num_crtc directly
Date:   Thu,  6 Dec 2018 11:33:52 +0100
Message-Id: <20181206103352.20587-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 06 Dec 2018 10:33:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just use qxl_num_crtc directly everywhere instead of using
qdev->monitors_config->max_allowed.  Drops pointless indirection
and also is less confusing.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index ce0b9c40fc..6437369a31 100644
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
@@ -348,9 +346,10 @@ static void qxl_crtc_update_monitors_config(struct drm_crtc *crtc,
 	if (oldcount != qdev->monitors_config->count)
 		DRM_DEBUG_KMS("active heads %d -> %d (%d total)\n",
 			      oldcount, qdev->monitors_config->count,
-			      qdev->monitors_config->max_allowed);
+			      qxl_num_crtc);
 
 	qdev->monitors_config->heads[i] = head;
+	qdev->monitors_config->max_allowed = qxl_num_crtc;
 	qxl_send_monitors_config(qdev);
 }
 
@@ -1097,9 +1096,8 @@ int qxl_create_monitors_object(struct qxl_device *qdev)
 {
 	int ret;
 	struct drm_gem_object *gobj;
-	int max_allowed = qxl_num_crtc;
 	int monitors_config_size = sizeof(struct qxl_monitors_config) +
-		max_allowed * sizeof(struct qxl_head);
+		qxl_num_crtc * sizeof(struct qxl_head);
 
 	ret = qxl_gem_object_create(qdev, monitors_config_size, 0,
 				    QXL_GEM_DOMAIN_VRAM,
@@ -1121,7 +1119,6 @@ int qxl_create_monitors_object(struct qxl_device *qdev)
 		qxl_bo_physical_address(qdev, qdev->monitors_config_bo, 0);
 
 	memset(qdev->monitors_config, 0, monitors_config_size);
-	qdev->monitors_config->max_allowed = max_allowed;
 	return 0;
 }
 
-- 
2.9.3

