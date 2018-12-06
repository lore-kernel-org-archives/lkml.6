Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1857CC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5F4208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5F4208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbeLFKqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:46:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbeLFKqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:46:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6998308429A;
        Thu,  6 Dec 2018 10:46:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com [10.36.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B22AC600C4;
        Thu,  6 Dec 2018 10:46:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BFD949D3C; Thu,  6 Dec 2018 11:46:38 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] drm/qxl: allow both PRIV and VRAM placement for QXL_GEM_DOMAIN_SURFACE
Date:   Thu,  6 Dec 2018 11:46:36 +0100
Message-Id: <20181206104638.23330-2-kraxel@redhat.com>
In-Reply-To: <20181206104638.23330-1-kraxel@redhat.com>
References: <20181206104638.23330-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 06 Dec 2018 10:46:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qxl surfaces (used for framebuffers and gem objects) can live in both
VRAM and PRIV ttm domains.  Update placement setup to include both.  Put
PRIV first in the list so it is preferred, so VRAM will have more room
for objects which must be allocated there.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 91f3bbc73e..f7f9f4f4fe 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -58,10 +58,10 @@ void qxl_ttm_placement_from_domain(struct qxl_bo *qbo, u32 domain, bool pinned)
 
 	qbo->placement.placement = qbo->placements;
 	qbo->placement.busy_placement = qbo->placements;
-	if (domain == QXL_GEM_DOMAIN_VRAM)
-		qbo->placements[c++].flags = TTM_PL_FLAG_CACHED | TTM_PL_FLAG_VRAM | pflag;
 	if (domain == QXL_GEM_DOMAIN_SURFACE)
 		qbo->placements[c++].flags = TTM_PL_FLAG_CACHED | TTM_PL_FLAG_PRIV | pflag;
+	if (domain == QXL_GEM_DOMAIN_SURFACE || domain == QXL_GEM_DOMAIN_VRAM)
+		qbo->placements[c++].flags = TTM_PL_FLAG_CACHED | TTM_PL_FLAG_VRAM | pflag;
 	if (domain == QXL_GEM_DOMAIN_CPU)
 		qbo->placements[c++].flags = TTM_PL_MASK_CACHING | TTM_PL_FLAG_SYSTEM | pflag;
 	if (!c)
-- 
2.9.3

