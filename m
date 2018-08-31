Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F8CC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D2C2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EUZ8XuMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D2C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeHaWVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:21:45 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46828 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeHaWVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:21:44 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DC6EC1A9D;
        Fri, 31 Aug 2018 20:13:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1535739184;
        bh=HuZXVMaDz7OsWJH4waZjlCY/TDjzKogBXusv6dA8VzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUZ8XuMvX4/Zsfyq1R6d/d3tweO6FOg9d65oun5sfABUUlIh0r0yxdNBVTI/n0867
         YO+Nbvt2T7gEhcqQ9NNTkO/nlvgKShHG/z5sX3ETPeaB9CTqVl0SP2q/Kn4fI5sjPZ
         KOXMYEctarQTyV3JOBNnQpOs47cCXGad50iIzeOU=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH 3/3] drm: rcar-du: Update framebuffer pitch and alignment limits for Gen3
Date:   Fri, 31 Aug 2018 19:12:59 +0100
Message-Id: <20180831181259.29529-4-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831181259.29529-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180831181259.29529-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The framebuffer pitch and alignment constraints reflect the limitations
of the Gen2 DU hardware. On Gen3, the DU has no memory interface and
thus doesn't impose any constraint. The limitations come instead from
the VSP that has a limit of 65535 bytes for the pitch and no alignment
constraint. Update the checks accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 35 ++++++++++++++++++---------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index d1bd174ec893..1d5f49503b93 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -204,7 +204,6 @@ rcar_du_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 	const struct rcar_du_format_info *format;
 	unsigned int max_pitch;
 	unsigned int align;
-	unsigned int bpp;
 	unsigned int i;
 
 	format = rcar_du_format_info(mode_cmd->pixel_format);
@@ -214,20 +213,32 @@ rcar_du_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 		return ERR_PTR(-EINVAL);
 	}
 
-	/*
-	 * The pitch and alignment constraints are expressed in pixels on the
-	 * hardware side and in bytes in the DRM API.
-	 */
-	bpp = format->planes == 1 ? format->bpp / 8 : 1;
-	max_pitch =  4096 * bpp;
+	if (rcdu->info->gen < 3) {
+		/*
+		 * On Gen2 the DU limits the pitch to 4095 pixels and requires
+		 * buffers to be aligned to a 16 pixels boundary (or 128 bytes
+		 * on some platforms).
+		 */
+		unsigned int bpp = format->planes == 1 ? format->bpp / 8 : 1;
 
-	if (rcar_du_needs(rcdu, RCAR_DU_QUIRK_ALIGN_128B))
-		align = 128;
-	else
-		align = 16 * bpp;
+		max_pitch = 4095 * bpp;
+
+		if (rcar_du_needs(rcdu, RCAR_DU_QUIRK_ALIGN_128B))
+			align = 128;
+		else
+			align = 16 * bpp;
+	} else {
+		/*
+		 * On Gen3 the memory interface is handled by the VSP that
+		 * limits the pitch to 65535 bytes and has no alignment
+		 * constraint.
+		 */
+		max_pitch = 65535;
+		align = 1;
+	}
 
 	if (mode_cmd->pitches[0] & (align - 1) ||
-	    mode_cmd->pitches[0] >= max_pitch) {
+	    mode_cmd->pitches[0] > max_pitch) {
 		dev_dbg(dev->dev, "invalid pitch value %u\n",
 			mode_cmd->pitches[0]);
 		return ERR_PTR(-EINVAL);
-- 
2.17.1

