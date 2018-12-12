Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE3DC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FA72086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76FA72086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeLLNVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:21:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbeLLNVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:21:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCB5D3097023;
        Wed, 12 Dec 2018 13:21:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EF891054FD3;
        Wed, 12 Dec 2018 13:21:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id ABD829D8A; Wed, 12 Dec 2018 14:21:09 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     spice-devel@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 01/18] drm/qxl: drop ttm_mem_reg arg from qxl_hw_surface_alloc()
Date:   Wed, 12 Dec 2018 14:20:52 +0100
Message-Id: <20181212132109.8126-2-kraxel@redhat.com>
In-Reply-To: <20181212132109.8126-1-kraxel@redhat.com>
References: <20181212132109.8126-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 12 Dec 2018 13:21:19 +0000 (UTC)
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
index dffc5093ff..73ef41ac5f 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -458,8 +458,7 @@ void qxl_surface_id_dealloc(struct qxl_device *qdev,
 }
 
 int qxl_hw_surface_alloc(struct qxl_device *qdev,
-			 struct qxl_bo *surf,
-			 struct ttm_mem_reg *new_mem)
+			 struct qxl_bo *surf)
 {
 	struct qxl_surface_cmd *cmd;
 	struct qxl_release *release;
@@ -485,16 +484,7 @@ int qxl_hw_surface_alloc(struct qxl_device *qdev,
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

