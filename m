Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A61AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D2D20866
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbeLTLWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:22:20 -0500
Received: from mail.netline.ch ([148.251.143.178]:35869 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbeLTLWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:22:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id AF3AA2A6054;
        Thu, 20 Dec 2018 12:22:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id AmUEAlPW9ZJG; Thu, 20 Dec 2018 12:22:09 +0100 (CET)
Received: from kaveri (39.1.199.178.dynamic.wline.res.cust.swisscom.ch [178.199.1.39])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id C62682A6053;
        Thu, 20 Dec 2018 12:22:09 +0100 (CET)
Received: from daenzer by kaveri with local (Exim 4.91)
        (envelope-from <michel@daenzer.net>)
        id 1gZwP3-00026m-GY; Thu, 20 Dec 2018 12:22:09 +0100
From:   =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To:     Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/ttm: Use drm_debug_printer for all ttm_bo_mem_space_debug output
Date:   Thu, 20 Dec 2018 12:22:09 +0100
Message-Id: <20181220112209.8063-1-michel@daenzer.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michel Dänzer <michel.daenzer@amd.com>

No need for pr_err here, the pr_err message in ttm_bo_evict is enough
to draw attention to something not going as planned.

Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
---

Similar to a previous patch, but this one leaves the pr_err messages in
ttm_bo_evict untouched.

 drivers/gpu/drm/ttm/ttm_bo.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index d87935bf8e30..0ec08394e17a 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -77,38 +77,39 @@ static inline int ttm_mem_type_from_place(const struct ttm_place *place,
 	return 0;
 }
 
-static void ttm_mem_type_debug(struct ttm_bo_device *bdev, int mem_type)
+static void ttm_mem_type_debug(struct ttm_bo_device *bdev, struct drm_printer *p,
+			       int mem_type)
 {
 	struct ttm_mem_type_manager *man = &bdev->man[mem_type];
-	struct drm_printer p = drm_debug_printer(TTM_PFX);
 
-	pr_err("    has_type: %d\n", man->has_type);
-	pr_err("    use_type: %d\n", man->use_type);
-	pr_err("    flags: 0x%08X\n", man->flags);
-	pr_err("    gpu_offset: 0x%08llX\n", man->gpu_offset);
-	pr_err("    size: %llu\n", man->size);
-	pr_err("    available_caching: 0x%08X\n", man->available_caching);
-	pr_err("    default_caching: 0x%08X\n", man->default_caching);
+	drm_printf(p, "    has_type: %d\n", man->has_type);
+	drm_printf(p, "    use_type: %d\n", man->use_type);
+	drm_printf(p, "    flags: 0x%08X\n", man->flags);
+	drm_printf(p, "    gpu_offset: 0x%08llX\n", man->gpu_offset);
+	drm_printf(p, "    size: %llu\n", man->size);
+	drm_printf(p, "    available_caching: 0x%08X\n", man->available_caching);
+	drm_printf(p, "    default_caching: 0x%08X\n", man->default_caching);
 	if (mem_type != TTM_PL_SYSTEM)
-		(*man->func->debug)(man, &p);
+		(*man->func->debug)(man, p);
 }
 
 static void ttm_bo_mem_space_debug(struct ttm_buffer_object *bo,
 					struct ttm_placement *placement)
 {
+	struct drm_printer p = drm_debug_printer(TTM_PFX);
 	int i, ret, mem_type;
 
-	pr_err("No space for %p (%lu pages, %luK, %luM)\n",
-	       bo, bo->mem.num_pages, bo->mem.size >> 10,
-	       bo->mem.size >> 20);
+	drm_printf(&p, "No space for %p (%lu pages, %luK, %luM)\n",
+		   bo, bo->mem.num_pages, bo->mem.size >> 10,
+		   bo->mem.size >> 20);
 	for (i = 0; i < placement->num_placement; i++) {
 		ret = ttm_mem_type_from_place(&placement->placement[i],
 						&mem_type);
 		if (ret)
 			return;
-		pr_err("  placement[%d]=0x%08X (%d)\n",
-		       i, placement->placement[i].flags, mem_type);
-		ttm_mem_type_debug(bo->bdev, mem_type);
+		drm_printf(&p, "  placement[%d]=0x%08X (%d)\n",
+			   i, placement->placement[i].flags, mem_type);
+		ttm_mem_type_debug(bo->bdev, &p, mem_type);
 	}
 }
 
-- 
2.20.1

