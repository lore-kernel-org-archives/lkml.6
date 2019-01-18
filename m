Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04885C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7ECD2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfARMUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:20:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbfARMU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:20:26 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96E9080503;
        Fri, 18 Jan 2019 12:20:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-38.ams2.redhat.com [10.36.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30C0C19745;
        Fri, 18 Jan 2019 12:20:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C831F9294; Fri, 18 Jan 2019 13:20:21 +0100 (CET)
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
Subject: [PATCH v3 10/23] drm/qxl: move qxl_primary_apply_cursor to correct place
Date:   Fri, 18 Jan 2019 13:20:07 +0100
Message-Id: <20190118122020.27596-11-kraxel@redhat.com>
In-Reply-To: <20190118122020.27596-1-kraxel@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 18 Jan 2019 12:20:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cursor must be set again after creating the primary surface.
Also drop the error message.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 86bfc19bea..1b700ef503 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -533,7 +533,6 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 	    .x2 = plane->state->fb->width,
 	    .y2 = plane->state->fb->height
 	};
-	int ret;
 	bool same_shadow = false;
 
 	if (old_state->fb) {
@@ -554,16 +553,13 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 		if (!same_shadow)
 			qxl_io_destroy_primary(qdev);
 		bo_old->is_primary = false;
-
-		ret = qxl_primary_apply_cursor(plane);
-		if (ret)
-			DRM_ERROR(
-			"could not set cursor after creating primary");
 	}
 
 	if (!bo->is_primary) {
-		if (!same_shadow)
+		if (!same_shadow) {
 			qxl_io_create_primary(qdev, 0, bo);
+			qxl_primary_apply_cursor(plane);
+		}
 		bo->is_primary = true;
 	}
 
-- 
2.9.3

