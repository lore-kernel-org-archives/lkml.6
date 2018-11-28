Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BE3C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB29820832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB29820832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeK1Vfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:35:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbeK1Vfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:35:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2DD4C4E928;
        Wed, 28 Nov 2018 10:34:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com [10.36.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2709260BE3;
        Wed, 28 Nov 2018 10:34:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 78C5F5E4E4; Wed, 28 Nov 2018 11:34:18 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     David Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/6] drm/qxl: drop unused offset parameter from qxl_io_create_primary()
Date:   Wed, 28 Nov 2018 11:34:14 +0100
Message-Id: <20181128103418.28023-3-kraxel@redhat.com>
In-Reply-To: <20181128103418.28023-1-kraxel@redhat.com>
References: <20181128103418.28023-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 28 Nov 2018 10:34:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h     | 1 -
 drivers/gpu/drm/qxl/qxl_cmd.c     | 7 +++----
 drivers/gpu/drm/qxl/qxl_display.c | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 14d3fa8557..6b8d28a23f 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -395,7 +395,6 @@ void qxl_update_screen(struct qxl_device *qxl);
 /* qxl io operations (qxl_cmd.c) */
 
 void qxl_io_create_primary(struct qxl_device *qdev,
-			   unsigned int offset,
 			   struct qxl_bo *bo);
 void qxl_io_destroy_primary(struct qxl_device *qdev);
 void qxl_io_memslot_add(struct qxl_device *qdev, uint8_t id);
diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index dffc5093ff..f263d83775 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -375,8 +375,7 @@ void qxl_io_destroy_primary(struct qxl_device *qdev)
 	qdev->primary_created = false;
 }
 
-void qxl_io_create_primary(struct qxl_device *qdev,
-			   unsigned int offset, struct qxl_bo *bo)
+void qxl_io_create_primary(struct qxl_device *qdev, struct qxl_bo *bo)
 {
 	struct qxl_surface_create *create;
 
@@ -387,9 +386,9 @@ void qxl_io_create_primary(struct qxl_device *qdev,
 	create->height = bo->surf.height;
 	create->stride = bo->surf.stride;
 	if (bo->shadow) {
-		create->mem = qxl_bo_physical_address(qdev, bo->shadow, offset);
+		create->mem = qxl_bo_physical_address(qdev, bo->shadow, 0);
 	} else {
-		create->mem = qxl_bo_physical_address(qdev, bo, offset);
+		create->mem = qxl_bo_physical_address(qdev, bo, 0);
 	}
 
 	DRM_DEBUG_DRIVER("mem = %llx, from %p\n", create->mem, bo->kptr);
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 58fb2c4308..d875cae02f 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -557,7 +557,7 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 
 	if (!bo->is_primary) {
 		if (!same_shadow) {
-			qxl_io_create_primary(qdev, 0, bo);
+			qxl_io_create_primary(qdev, bo);
 			qxl_primary_apply_cursor(plane);
 		}
 		bo->is_primary = true;
-- 
2.9.3

