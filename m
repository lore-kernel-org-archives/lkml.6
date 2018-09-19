Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD1EECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95302151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EVh5/8Fd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95302151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbeISVfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:35:39 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:37242 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732513AbeISVfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:35:39 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A053421A9;
        Wed, 19 Sep 2018 17:57:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1537372624;
        bh=uLeCUIDi1SzI5LeSNLUziacTEo1k1TFiXoSXc6wd164=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EVh5/8FdV3fzkfe4rCrP6PjI0O/g8ybsO181+5sUlGY0nfJzwogGaMdy4ngEYAJIj
         bUT2ptvX/XgkmSKST+9VLUCxkGeyeS4zPsTzEcfEFLDbn9AM3cyoh5+I9k7Eg/C8uZ
         hhxgjk6WleoBHBs0Sf2pTMRF8eQnqvdhn7yoILOI=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm: rcar-du: Enable alpha property on primary planes
Date:   Wed, 19 Sep 2018 16:56:59 +0100
Message-Id: <20180919155700.10342-3-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919155700.10342-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180919155700.10342-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the alpha property is not added to a plane, a default value will be
used, which can result in a non-visible layer if the alpha is
initialised as 0.

Provide an alpha blend property on all planes.

Fixes: 161ad653d6c9 ("drm: rcar-du: Use __drm_atomic_helper_plane_reset
instead of copying the logic")

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index 9e07758a755c..72399a19d8a6 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -783,13 +783,18 @@ int rcar_du_planes_init(struct rcar_du_group *rgrp)
 		drm_plane_helper_add(&plane->plane,
 				     &rcar_du_plane_helper_funcs);
 
+		/*
+		 * The alpha property needs to be initialised on all planes
+		 * to ensure the correct setting at the output.
+		 */
+		drm_plane_create_alpha_property(&plane->plane);
+
 		if (type == DRM_PLANE_TYPE_PRIMARY)
 			continue;
 
 		drm_object_attach_property(&plane->plane.base,
 					   rcdu->props.colorkey,
 					   RCAR_DU_COLORKEY_NONE);
-		drm_plane_create_alpha_property(&plane->plane);
 		drm_plane_create_zpos_property(&plane->plane, 1, 1, 7);
 	}
 
-- 
2.17.1

