Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386F1C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073A3218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbeL2CuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 21:50:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:17071 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727180AbeL2CuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 21:50:03 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AE1F086258ABF;
        Sat, 29 Dec 2018 10:50:00 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Sat, 29 Dec 2018
 10:49:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <maarten.lankhorst@linux.intel.com>, <maxime.ripard@bootlin.com>,
        <sean@poorly.run>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm: Fix error handling in drm_legacy_addctx
Date:   Sat, 29 Dec 2018 10:49:07 +0800
Message-ID: <20181229024907.12852-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ctx->handle' is unsigned, it never less than zero.
This patch use int 'tmp_handle' to handle the err condition.

Fixes: 62968144e673 ("drm: convert drm context code to use Linux idr")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/drm_context.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_context.c b/drivers/gpu/drm/drm_context.c
index 506663c..8e73fab 100644
--- a/drivers/gpu/drm/drm_context.c
+++ b/drivers/gpu/drm/drm_context.c
@@ -361,23 +361,26 @@ int drm_legacy_addctx(struct drm_device *dev, void *data,
 {
 	struct drm_ctx_list *ctx_entry;
 	struct drm_ctx *ctx = data;
+	int tmp_handle;
 
 	if (!drm_core_check_feature(dev, DRIVER_KMS_LEGACY_CONTEXT) &&
 	    !drm_core_check_feature(dev, DRIVER_LEGACY))
 		return -EOPNOTSUPP;
 
-	ctx->handle = drm_legacy_ctxbitmap_next(dev);
-	if (ctx->handle == DRM_KERNEL_CONTEXT) {
+	tmp_handle = drm_legacy_ctxbitmap_next(dev);
+	if (tmp_handle == DRM_KERNEL_CONTEXT) {
 		/* Skip kernel's context and get a new one. */
-		ctx->handle = drm_legacy_ctxbitmap_next(dev);
+		tmp_handle = drm_legacy_ctxbitmap_next(dev);
 	}
-	DRM_DEBUG("%d\n", ctx->handle);
-	if (ctx->handle < 0) {
+	DRM_DEBUG("%d\n", tmp_handle);
+	if (tmp_handle < 0) {
 		DRM_DEBUG("Not enough free contexts.\n");
 		/* Should this return -EBUSY instead? */
-		return -ENOMEM;
+		return tmp_handle;
 	}
 
+	ctx->handle = tmp_handle;
+
 	ctx_entry = kmalloc(sizeof(*ctx_entry), GFP_KERNEL);
 	if (!ctx_entry) {
 		DRM_DEBUG("out of memory\n");
-- 
2.7.0


