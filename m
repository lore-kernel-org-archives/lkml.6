Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1304C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF95C2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF95C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeLERCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:02:24 -0500
Received: from mail.netline.ch ([148.251.143.178]:43558 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLERCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:02:23 -0500
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Dec 2018 12:02:21 EST
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 243312A604B;
        Wed,  5 Dec 2018 17:56:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 6kANUdsGjnjo; Wed,  5 Dec 2018 17:56:22 +0100 (CET)
Received: from kaveri (39.1.199.178.dynamic.wline.res.cust.swisscom.ch [178.199.1.39])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 828B72A604A;
        Wed,  5 Dec 2018 17:56:22 +0100 (CET)
Received: from daenzer by kaveri with local (Exim 4.91)
        (envelope-from <michel@daenzer.net>)
        id 1gUaTF-0001WP-Vb; Wed, 05 Dec 2018 17:56:21 +0100
From:   =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To:     Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/ttm: Use pr_debug for all output from ttm_bo_evict
Date:   Wed,  5 Dec 2018 17:56:21 +0100
Message-Id: <20181205165621.5805-2-michel@daenzer.net>
X-Mailer: git-send-email 2.20.0.rc2
In-Reply-To: <20181205165621.5805-1-michel@daenzer.net>
References: <20181205165621.5805-1-michel@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michel Dänzer <michel.daenzer@amd.com>

All the output is related, so it should all be printed the same way.
Some of it was using pr_debug, but some of it appeared in dmesg by
default. The caller should handle failure, so there's no need to spam
dmesg with potentially quite a lot of output by default.

Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 39 ++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index d87935bf8e30..5e9b9dd91629 100644
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
 
@@ -728,8 +729,8 @@ static int ttm_bo_evict(struct ttm_buffer_object *bo,
 	ret = ttm_bo_mem_space(bo, &placement, &evict_mem, ctx);
 	if (ret) {
 		if (ret != -ERESTARTSYS) {
-			pr_err("Failed to find memory space for buffer 0x%p eviction\n",
-			       bo);
+			pr_debug("Failed to find memory space for buffer 0x%p eviction\n",
+				 bo);
 			ttm_bo_mem_space_debug(bo, &placement);
 		}
 		goto out;
@@ -738,7 +739,7 @@ static int ttm_bo_evict(struct ttm_buffer_object *bo,
 	ret = ttm_bo_handle_move_mem(bo, &evict_mem, true, ctx);
 	if (unlikely(ret)) {
 		if (ret != -ERESTARTSYS)
-			pr_err("Buffer eviction failed\n");
+			pr_debug("Buffer eviction failed\n");
 		ttm_bo_mem_put(bo, &evict_mem);
 		goto out;
 	}
-- 
2.20.0.rc2

