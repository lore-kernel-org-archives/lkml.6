Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8112FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4302175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfA2IZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:25:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbfA2IZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:25:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D31183F3E;
        Tue, 29 Jan 2019 08:25:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-116.ams2.redhat.com [10.36.116.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5A4517591;
        Tue, 29 Jan 2019 08:25:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D5EE99D85; Tue, 29 Jan 2019 09:25:41 +0100 (CET)
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
Subject: [PATCH v2] drm/qxl: use ttm_tt
Date:   Tue, 29 Jan 2019 09:25:41 +0100
Message-Id: <20190129082541.1392-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 29 Jan 2019 08:25:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qxl device will not dma, so we don't need ttm_dma_tt.  Go use ttm_tt
instead, to avoid wasting resources (swiotlb bounce buffers for
example).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_ttm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 36ea993aac..92f5db5b29 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -204,7 +204,7 @@ static void qxl_ttm_io_mem_free(struct ttm_bo_device *bdev,
  * TTM backend functions.
  */
 struct qxl_ttm_tt {
-	struct ttm_dma_tt		ttm;
+	struct ttm_tt		        ttm;
 	struct qxl_device		*qdev;
 	u64				offset;
 };
@@ -233,7 +233,7 @@ static void qxl_ttm_backend_destroy(struct ttm_tt *ttm)
 {
 	struct qxl_ttm_tt *gtt = (void *)ttm;
 
-	ttm_dma_tt_fini(&gtt->ttm);
+	ttm_tt_fini(&gtt->ttm);
 	kfree(gtt);
 }
 
@@ -253,13 +253,13 @@ static struct ttm_tt *qxl_ttm_tt_create(struct ttm_buffer_object *bo,
 	gtt = kzalloc(sizeof(struct qxl_ttm_tt), GFP_KERNEL);
 	if (gtt == NULL)
 		return NULL;
-	gtt->ttm.ttm.func = &qxl_backend_func;
+	gtt->ttm.func = &qxl_backend_func;
 	gtt->qdev = qdev;
-	if (ttm_dma_tt_init(&gtt->ttm, bo, page_flags)) {
+	if (ttm_tt_init(&gtt->ttm, bo, page_flags)) {
 		kfree(gtt);
 		return NULL;
 	}
-	return &gtt->ttm.ttm;
+	return &gtt->ttm;
 }
 
 static void qxl_move_null(struct ttm_buffer_object *bo,
-- 
2.9.3

