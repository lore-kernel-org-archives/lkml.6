Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1E1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA1420652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfARMUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:20:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727617AbfARMU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:20:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1B9242BDF;
        Fri, 18 Jan 2019 12:20:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-38.ams2.redhat.com [10.36.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C38CE5C554;
        Fri, 18 Jan 2019 12:20:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7AED799B8; Fri, 18 Jan 2019 13:20:21 +0100 (CET)
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
Subject: [PATCH v3 07/23] drm/qxl: allow both PRIV and VRAM placement for QXL_GEM_DOMAIN_SURFACE
Date:   Fri, 18 Jan 2019 13:20:04 +0100
Message-Id: <20190118122020.27596-8-kraxel@redhat.com>
In-Reply-To: <20190118122020.27596-1-kraxel@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 18 Jan 2019 12:20:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qxl surfaces (used for framebuffers and gem objects) can live in both
VRAM and PRIV ttm domains.  Update placement setup to include both.
Put PRIV first in the list so it is preferred, so VRAM will have more
room for objects which must be allocated there.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_object.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 34eff8b21e..024c8dd317 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -60,8 +60,10 @@ void qxl_ttm_placement_from_domain(struct qxl_bo *qbo, u32 domain, bool pinned)
 	qbo->placement.busy_placement = qbo->placements;
 	if (domain == QXL_GEM_DOMAIN_VRAM)
 		qbo->placements[c++].flags = TTM_PL_FLAG_CACHED | TTM_PL_FLAG_VRAM | pflag;
-	if (domain == QXL_GEM_DOMAIN_SURFACE)
+	if (domain == QXL_GEM_DOMAIN_SURFACE) {
 		qbo->placements[c++].flags = TTM_PL_FLAG_CACHED | TTM_PL_FLAG_PRIV | pflag;
+		qbo->placements[c++].flags = TTM_PL_FLAG_CACHED | TTM_PL_FLAG_VRAM | pflag;
+	}
 	if (domain == QXL_GEM_DOMAIN_CPU)
 		qbo->placements[c++].flags = TTM_PL_MASK_CACHING | TTM_PL_FLAG_SYSTEM | pflag;
 	if (!c)
-- 
2.9.3

