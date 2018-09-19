Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD356ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892BF2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Zwko4mI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892BF2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbeISVfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:35:40 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:37230 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732545AbeISVfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:35:39 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E5DC421A8;
        Wed, 19 Sep 2018 17:57:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1537372624;
        bh=2uI8uIDNLq2Qzm/PM6NUQ/Gtge+VHpW2lG+QaBnn9W4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zwko4mI38zlJTagmSLfzIU7hOlz9QM5JXRLeWjg/zuHE1cnSD/eaWpAl+Pnr18NAm
         WsuAnMKZrF0/62eG5qj6vgo7hFrGbeWQOWElF11WWA20nFKVEHTdHfok7pRhKwOc9L
         BLodIHigXd0wzfLgXPMtG2zyfJdr26mHa3b2PLd8=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/atomic: Initialise planes with opaque alpha values
Date:   Wed, 19 Sep 2018 16:56:58 +0100
Message-Id: <20180919155700.10342-2-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919155700.10342-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180919155700.10342-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Planes without an alpha property, using __drm_atomic_helper_plane_reset
will have their plane state alpha initialised as zero, which represents
a transparent alpha.

If this value is then used for the plane, it may not be visible by
default, and thus doesn't represent a good initialisation state.

Update the default state->alpha value to DRM_BLEND_ALPHA_OPAQUE
unconditionally when the plane is reset.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 3cf1aa132778..e49b22381048 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3569,9 +3569,7 @@ void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
 	state->plane = plane;
 	state->rotation = DRM_MODE_ROTATE_0;
 
-	/* Reset the alpha value to fully opaque if it matters */
-	if (plane->alpha_property)
-		state->alpha = plane->alpha_property->values[1];
+	state->alpha = DRM_BLEND_ALPHA_OPAQUE;
 	state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
 
 	plane->state = state;
-- 
2.17.1

