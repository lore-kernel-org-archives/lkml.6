Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CCFC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0B120850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfAHLZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:25:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbfAHLZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:25:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41DA1637FE;
        Tue,  8 Jan 2019 11:25:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com [10.36.116.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B08B5C21C;
        Tue,  8 Jan 2019 11:25:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B9CA55EE7; Tue,  8 Jan 2019 12:25:21 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 15/15] drm/bochs: reserve bo for pin/unpin
Date:   Tue,  8 Jan 2019 12:25:19 +0100
Message-Id: <20190108112519.27473-16-kraxel@redhat.com>
In-Reply-To: <20190108112519.27473-1-kraxel@redhat.com>
References: <20190108112519.27473-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 08 Jan 2019 11:25:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer object must be reserved before calling
ttm_bo_validate for pinning/unpinning.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_mm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index cfe061c25f..970a591908 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -223,7 +223,11 @@ int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag)
 	bochs_ttm_placement(bo, pl_flag);
 	for (i = 0; i < bo->placement.num_placement; i++)
 		bo->placements[i].flags |= TTM_PL_FLAG_NO_EVICT;
+	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
+	if (ret)
+		return ret;
 	ret = ttm_bo_validate(&bo->bo, &bo->placement, &ctx);
+	ttm_bo_unreserve(&bo->bo);
 	if (ret)
 		return ret;
 
@@ -247,7 +251,11 @@ int bochs_bo_unpin(struct bochs_bo *bo)
 
 	for (i = 0; i < bo->placement.num_placement; i++)
 		bo->placements[i].flags &= ~TTM_PL_FLAG_NO_EVICT;
+	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
+	if (ret)
+		return ret;
 	ret = ttm_bo_validate(&bo->bo, &bo->placement, &ctx);
+	ttm_bo_unreserve(&bo->bo);
 	if (ret)
 		return ret;
 
-- 
2.9.3

