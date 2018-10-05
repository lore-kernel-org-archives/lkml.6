Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91A7C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608962084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608962084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeJEOEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:04:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13190 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727133AbeJEOEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:04:42 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3B079696D5849;
        Fri,  5 Oct 2018 15:07:18 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.399.0; Fri, 5 Oct 2018 15:07:10 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/omap: remove set but not used variable 'plane'
Date:   Fri, 5 Oct 2018 07:18:42 +0000
Message-ID: <1538723922-175599-1-git-send-email-yuehaibing@huawei.com>
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

drivers/gpu/drm/omapdrm/omap_fb.c: In function 'omap_framebuffer_update_scanout':
drivers/gpu/drm/omapdrm/omap_fb.c:130:16: warning:
 variable 'plane' set but not used [-Wunused-but-set-variable]
  struct plane *plane = &omap_fb->planes[0];
  
After commit 2ecceeb53b19 ("drm/omap: Move buffer pitch/offset to drm_framebuffer")
'plane' is not used any more.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/omapdrm/omap_fb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
index 4d264fd..e3e47aa 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -127,7 +127,6 @@ void omap_framebuffer_update_scanout(struct drm_framebuffer *fb,
 {
 	struct omap_framebuffer *omap_fb = to_omap_framebuffer(fb);
 	const struct drm_format_info *format = omap_fb->format;
-	struct plane *plane = &omap_fb->planes[0];
 	u32 x, y, orient = 0;
 
 	info->fourcc = fb->format->format;
@@ -201,8 +200,6 @@ void omap_framebuffer_update_scanout(struct drm_framebuffer *fb,
 	info->screen_width /= format->cpp[0];
 
 	if (fb->format->format == DRM_FORMAT_NV12) {
-		plane = &omap_fb->planes[1];
-
 		if (info->rotation_type == OMAP_DSS_ROT_TILER) {
 			WARN_ON(!(omap_gem_flags(fb->obj[1]) & OMAP_BO_TILED));
 			omap_gem_rotated_dma_addr(fb->obj[1], orient, x/2, y/2,



