Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDF1C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371CA20818
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371CA20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbeKJNSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 08:18:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15081 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728094AbeKJNSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 08:18:49 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1E98D26460644;
        Sat, 10 Nov 2018 11:35:17 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 10 Nov 2018 11:35:08 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "David Airlie" <airlied@linux.ie>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <virtualization@lists.linux-foundation.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/qxl: remove set but not used variable 'map'
Date:   Sat, 10 Nov 2018 03:44:46 +0000
Message-ID: <1541821486-40631-1-git-send-email-yuehaibing@huawei.com>
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

drivers/gpu/drm/qxl/qxl_object.c: In function 'qxl_bo_kunmap_atomic_page':
drivers/gpu/drm/qxl/qxl_object.c:189:21: warning:
 variable 'map' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/qxl/qxl_object.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index f67a3c5..b1706cb 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -186,13 +186,9 @@ void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev,
 			       struct qxl_bo *bo, void *pmap)
 {
 	struct ttm_mem_type_manager *man = &bo->tbo.bdev->man[bo->tbo.mem.mem_type];
-	struct io_mapping *map;
 
-	if (bo->tbo.mem.mem_type == TTM_PL_VRAM)
-		map = qdev->vram_mapping;
-	else if (bo->tbo.mem.mem_type == TTM_PL_PRIV)
-		map = qdev->surface_mapping;
-	else
+	if ((bo->tbo.mem.mem_type != TTM_PL_VRAM) &&
+	    (bo->tbo.mem.mem_type != TTM_PL_PRIV))
 		goto fallback;
 
 	io_mapping_unmap_atomic(pmap);
@@ -200,7 +196,7 @@ void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev,
 	(void) ttm_mem_io_lock(man, false);
 	ttm_mem_io_free(bo->tbo.bdev, &bo->tbo.mem);
 	ttm_mem_io_unlock(man);
-	return ;
+	return;
  fallback:
 	qxl_bo_kunmap(bo);
 }



