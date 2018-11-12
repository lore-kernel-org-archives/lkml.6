Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E028C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080C5223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080C5223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbeKLXQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:16:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727103AbeKLXQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:16:47 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E9208F07630ED;
        Mon, 12 Nov 2018 21:23:15 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Mon, 12 Nov 2018 21:23:06 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "David Airlie" <airlied@linux.ie>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <virtualization@lists.linux-foundation.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/qxl: remove set but not used variables 'driver, qbo'
Date:   Mon, 12 Nov 2018 13:32:36 +0000
Message-ID: <1542029556-88107-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/qxl/qxl_release.c: In function 'qxl_release_fence_buffer_objects':
drivers/gpu/drm/qxl/qxl_release.c:431:17: warning:
 variable 'qbo' set but not used [-Wunused-but-set-variable]

drivers/gpu/drm/qxl/qxl_release.c:430:24: warning:
 variable 'driver' set but not used [-Wunused-but-set-variable]

'qbo' not used since commit f2c24b83ae90 ("drm/ttm: flip the switch, and convert
to dma_fence")

And 'driver' never used since introduction in
8002db6336dd ("qxl: convert qxl driver to proper use for reservations")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/qxl/qxl_release.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 3813ec1..0a693fe 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -427,8 +427,6 @@ void qxl_release_fence_buffer_objects(struct qxl_release *release)
 	struct ttm_buffer_object *bo;
 	struct ttm_bo_global *glob;
 	struct ttm_bo_device *bdev;
-	struct ttm_bo_driver *driver;
-	struct qxl_bo *qbo;
 	struct ttm_validate_buffer *entry;
 	struct qxl_device *qdev;
 
@@ -449,14 +447,12 @@ void qxl_release_fence_buffer_objects(struct qxl_release *release)
 		       release->id | 0xf0000000, release->base.seqno);
 	trace_dma_fence_emit(&release->base);
 
-	driver = bdev->driver;
 	glob = bdev->glob;
 
 	spin_lock(&glob->lru_lock);
 
 	list_for_each_entry(entry, &release->bos, head) {
 		bo = entry->bo;
-		qbo = to_qxl_bo(bo);
 
 		reservation_object_add_shared_fence(bo->resv, &release->base);
 		ttm_bo_add_to_lru(bo);



