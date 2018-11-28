Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CF7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF7E20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF7E20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeK1Vfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:35:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbeK1Vfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:35:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 997D3169750;
        Wed, 28 Nov 2018 10:34:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com [10.36.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 50FE660141;
        Wed, 28 Nov 2018 10:34:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A12A25E4E5; Wed, 28 Nov 2018 11:34:18 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     David Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/6] drm/qxl: track primary bo
Date:   Wed, 28 Nov 2018 11:34:15 +0100
Message-Id: <20181128103418.28023-4-kraxel@redhat.com>
In-Reply-To: <20181128103418.28023-1-kraxel@redhat.com>
References: <20181128103418.28023-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 28 Nov 2018 10:34:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Track which bo is used as primary surface.  With that in place we don't
need the primary_created flag any more, we can just check the primary bo
pointer instead.

Also verify we don't already have a primary surface in
qxl_io_create_primary().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h     | 2 +-
 drivers/gpu/drm/qxl/qxl_cmd.c     | 7 +++++--
 drivers/gpu/drm/qxl/qxl_display.c | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 6b8d28a23f..92140e0d71 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -229,7 +229,7 @@ struct qxl_device {
 
 	struct qxl_ram_header *ram_header;
 
-	unsigned int primary_created:1;
+	struct qxl_bo *primary_bo;
 
 	struct qxl_memslot	*mem_slots;
 	uint8_t		n_mem_slots;
diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index f263d83775..3c606f0f7a 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -372,13 +372,16 @@ void qxl_io_flush_surfaces(struct qxl_device *qdev)
 void qxl_io_destroy_primary(struct qxl_device *qdev)
 {
 	wait_for_io_cmd(qdev, 0, QXL_IO_DESTROY_PRIMARY_ASYNC);
-	qdev->primary_created = false;
+	qdev->primary_bo = NULL;
 }
 
 void qxl_io_create_primary(struct qxl_device *qdev, struct qxl_bo *bo)
 {
 	struct qxl_surface_create *create;
 
+	if (WARN_ON(qdev->primary_bo))
+		return;
+
 	DRM_DEBUG_DRIVER("qdev %p, ram_header %p\n", qdev, qdev->ram_header);
 	create = &qdev->ram_header->create_surface;
 	create->format = bo->surf.format;
@@ -397,7 +400,7 @@ void qxl_io_create_primary(struct qxl_device *qdev, struct qxl_bo *bo)
 	create->type = QXL_SURF_TYPE_PRIMARY;
 
 	wait_for_io_cmd(qdev, 0, QXL_IO_CREATE_PRIMARY_ASYNC);
-	qdev->primary_created = true;
+	qdev->primary_bo = bo;
 }
 
 void qxl_io_memslot_add(struct qxl_device *qdev, uint8_t id)
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index d875cae02f..69b180735d 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -302,7 +302,7 @@ static void qxl_crtc_update_monitors_config(struct drm_crtc *crtc,
 	struct qxl_head head;
 	int oldcount, i = qcrtc->index;
 
-	if (!qdev->primary_created) {
+	if (!qdev->primary_bo) {
 		DRM_DEBUG_KMS("no primary surface, skip (%s)\n", reason);
 		return;
 	}
-- 
2.9.3

