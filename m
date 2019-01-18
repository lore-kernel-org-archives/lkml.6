Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACCBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D492086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfARMVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:21:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727632AbfARMUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:20:31 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A59E40F35;
        Fri, 18 Jan 2019 12:20:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-38.ams2.redhat.com [10.36.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9423F101960A;
        Fri, 18 Jan 2019 12:20:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B4741491B; Fri, 18 Jan 2019 13:20:20 +0100 (CET)
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
Subject: [PATCH v3 01/23] drm/qxl: drop ttm_mem_reg arg from qxl_hw_surface_alloc()
Date:   Fri, 18 Jan 2019 13:19:58 +0100
Message-Id: <20190118122020.27596-2-kraxel@redhat.com>
In-Reply-To: <20190118122020.27596-1-kraxel@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 18 Jan 2019 12:20:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not used, is always NULL.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h    |  3 +--
 drivers/gpu/drm/qxl/qxl_cmd.c    | 14 ++------------
 drivers/gpu/drm/qxl/qxl_object.c |  2 +-
 3 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 13a0254b59..38c5a8b1df 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -497,8 +497,7 @@ int qxl_surface_id_alloc(struct qxl_device *qdev,
 void qxl_surface_id_dealloc(struct qxl_device *qdev,
 			    uint32_t surface_id);
 int qxl_hw_surface_alloc(struct qxl_device *qdev,
-			 struct qxl_bo *surf,
-			 struct ttm_mem_reg *mem);
+			 struct qxl_bo *surf);
 int qxl_hw_surface_dealloc(struct qxl_device *qdev,
 			   struct qxl_bo *surf);
 
diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index 2e100f6442..5ba831c78c 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -460,8 +460,7 @@ void qxl_surface_id_dealloc(struct qxl_device *qdev,
 }
 
 int qxl_hw_surface_alloc(struct qxl_device *qdev,
-			 struct qxl_bo *surf,
-			 struct ttm_mem_reg *new_mem)
+			 struct qxl_bo *surf)
 {
 	struct qxl_surface_cmd *cmd;
 	struct qxl_release *release;
@@ -487,16 +486,7 @@ int qxl_hw_surface_alloc(struct qxl_device *qdev,
 	cmd->u.surface_create.width = surf->surf.width;
 	cmd->u.surface_create.height = surf->surf.height;
 	cmd->u.surface_create.stride = surf->surf.stride;
-	if (new_mem) {
-		int slot_id = surf->type == QXL_GEM_DOMAIN_VRAM ? qdev->main_mem_slot : qdev->surfaces_mem_slot;
-		struct qxl_memslot *slot = &(qdev->mem_slots[slot_id]);
-
-		/* TODO - need to hold one of the locks to read tbo.offset */
-		cmd->u.surface_create.data = slot->high_bits;
-
-		cmd->u.surface_create.data |= (new_mem->start << PAGE_SHIFT) + surf->tbo.bdev->man[new_mem->mem_type].gpu_offset;
-	} else
-		cmd->u.surface_create.data = qxl_bo_physical_address(qdev, surf, 0);
+	cmd->u.surface_create.data = qxl_bo_physical_address(qdev, surf, 0);
 	cmd->surface_id = surf->surface_id;
 	qxl_release_unmap(qdev, release, &cmd->release_info);
 
diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 91f3bbc73e..34eff8b21e 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -332,7 +332,7 @@ int qxl_bo_check_id(struct qxl_device *qdev, struct qxl_bo *bo)
 		if (ret)
 			return ret;
 
-		ret = qxl_hw_surface_alloc(qdev, bo, NULL);
+		ret = qxl_hw_surface_alloc(qdev, bo);
 		if (ret)
 			return ret;
 	}
-- 
2.9.3

