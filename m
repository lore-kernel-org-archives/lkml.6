Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A21C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9687A20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfARMUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:20:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbfARMUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:20:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0919BDF87A;
        Fri, 18 Jan 2019 12:20:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-38.ams2.redhat.com [10.36.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3D475D965;
        Fri, 18 Jan 2019 12:20:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 15C1F9AB4; Fri, 18 Jan 2019 13:20:21 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Frediano Ziglio <fziglio@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 04/23] drm/qxl: change the way slot is detected
Date:   Fri, 18 Jan 2019 13:20:01 +0100
Message-Id: <20190118122020.27596-5-kraxel@redhat.com>
In-Reply-To: <20190118122020.27596-1-kraxel@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 18 Jan 2019 12:20:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frediano Ziglio <fziglio@redhat.com>

Instead of relaying on surface type use the actual placement.
This allow to have different placement for a single type of
surface.

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>

[ kraxel: rebased, adapted to upstream changes ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index f9dddfe7d9..d015d4fff1 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -311,7 +311,8 @@ static inline uint64_t
 qxl_bo_physical_address(struct qxl_device *qdev, struct qxl_bo *bo,
 			unsigned long offset)
 {
-	struct qxl_memslot *slot = bo->type == QXL_GEM_DOMAIN_VRAM
+	struct qxl_memslot *slot =
+		(bo->tbo.mem.mem_type == TTM_PL_VRAM)
 		? &qdev->main_slot : &qdev->surfaces_slot;
 
 	/* TODO - need to hold one of the locks to read tbo.offset */
-- 
2.9.3

