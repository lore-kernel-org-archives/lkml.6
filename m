Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D25C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8552084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8552084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeLLNVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:21:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbeLLNVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:21:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FA034E936;
        Wed, 12 Dec 2018 13:21:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F3165E7DF;
        Wed, 12 Dec 2018 13:21:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7D05C9016; Wed, 12 Dec 2018 14:21:10 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     spice-devel@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 06/18] drm/qxl: use separate offset spaces for the two slots / ttm memory types.
Date:   Wed, 12 Dec 2018 14:20:57 +0100
Message-Id: <20181212132109.8126-7-kraxel@redhat.com>
In-Reply-To: <20181212132109.8126-1-kraxel@redhat.com>
References: <20181212132109.8126-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 12 Dec 2018 13:21:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without that ttm offsets are not unique, they can refer to objects
in both VRAM and PRIV memory (aka main and surfaces slot).

One of those "why things didn't blow up without this" moments.
Probably offset conflicts are rare enough by pure luck.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h |  5 ++++-
 drivers/gpu/drm/qxl/qxl_kms.c |  5 +++--
 drivers/gpu/drm/qxl/qxl_ttm.c | 10 +++++++++-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 3ebe66abf2..27e0a3fc08 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -136,6 +136,7 @@ struct qxl_memslot {
 	uint64_t	start_phys_addr;
 	uint64_t	size;
 	uint64_t	high_bits;
+	uint64_t        gpu_offset;
 };
 
 enum {
@@ -312,8 +313,10 @@ qxl_bo_physical_address(struct qxl_device *qdev, struct qxl_bo *bo,
 		(bo->tbo.mem.mem_type == TTM_PL_VRAM)
 		? &qdev->main_slot : &qdev->surfaces_slot;
 
+	WARN_ON_ONCE((bo->tbo.offset & slot->gpu_offset) != slot->gpu_offset);
+
 	/* TODO - need to hold one of the locks to read tbo.offset */
-	return slot->high_bits | (bo->tbo.offset + offset);
+	return slot->high_bits | (bo->tbo.offset - slot->gpu_offset + offset);
 }
 
 /* qxl_fb.c */
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index 3c1753667d..82c764623f 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -83,10 +83,11 @@ static void setup_slot(struct qxl_device *qdev,
 	high_bits <<= (64 - (qdev->rom->slot_gen_bits + qdev->rom->slot_id_bits));
 	slot->high_bits = high_bits;
 
-	DRM_INFO("slot %d (%s): base 0x%08lx, size 0x%08lx\n",
+	DRM_INFO("slot %d (%s): base 0x%08lx, size 0x%08lx, gpu_offset 0x%lx\n",
 		 slot->index, slot->name,
 		 (unsigned long)slot->start_phys_addr,
-		 (unsigned long)slot->size);
+		 (unsigned long)slot->size,
+		 (unsigned long)slot->gpu_offset);
 }
 
 void qxl_reinit_memslots(struct qxl_device *qdev)
diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 886f61e94f..36ea993aac 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -100,6 +100,11 @@ static int qxl_invalidate_caches(struct ttm_bo_device *bdev, uint32_t flags)
 static int qxl_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 			     struct ttm_mem_type_manager *man)
 {
+	struct qxl_device *qdev = qxl_get_qdev(bdev);
+	unsigned int gpu_offset_shift =
+		64 - (qdev->rom->slot_gen_bits + qdev->rom->slot_id_bits + 8);
+	struct qxl_memslot *slot;
+
 	switch (type) {
 	case TTM_PL_SYSTEM:
 		/* System memory */
@@ -110,8 +115,11 @@ static int qxl_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 	case TTM_PL_VRAM:
 	case TTM_PL_PRIV:
 		/* "On-card" video ram */
+		slot = (type == TTM_PL_VRAM) ?
+			&qdev->main_slot : &qdev->surfaces_slot;
+		slot->gpu_offset = (uint64_t)type << gpu_offset_shift;
 		man->func = &ttm_bo_manager_func;
-		man->gpu_offset = 0;
+		man->gpu_offset = slot->gpu_offset;
 		man->flags = TTM_MEMTYPE_FLAG_FIXED |
 			     TTM_MEMTYPE_FLAG_MAPPABLE;
 		man->available_caching = TTM_PL_MASK_CACHING;
-- 
2.9.3

