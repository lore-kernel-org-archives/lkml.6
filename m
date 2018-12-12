Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B83BC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C89D2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C89D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeLLNVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:21:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbeLLNVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:21:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 121FD3082A26;
        Wed, 12 Dec 2018 13:21:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE2255E7DF;
        Wed, 12 Dec 2018 13:21:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5FE8A9993; Wed, 12 Dec 2018 14:21:11 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     spice-devel@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 12/18] drm/qxl: track primary bo
Date:   Wed, 12 Dec 2018 14:21:03 +0100
Message-Id: <20181212132109.8126-13-kraxel@redhat.com>
In-Reply-To: <20181212132109.8126-1-kraxel@redhat.com>
References: <20181212132109.8126-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 12 Dec 2018 13:21:14 +0000 (UTC)
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
index cb767aaef6..150b1a4f66 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -229,7 +229,7 @@ struct qxl_device {
 
 	struct qxl_ram_header *ram_header;
 
-	unsigned int primary_created:1;
+	struct qxl_bo *primary_bo;
 
 	struct qxl_memslot main_slot;
 	struct qxl_memslot surfaces_slot;
diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index 626e803f60..aed0242e11 100644
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
index 79dc8a1fa3..828e4f773c 100644
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

