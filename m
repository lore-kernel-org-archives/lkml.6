Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4544C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D7A2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LHFx+VwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D7A2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbeHaSsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:48:41 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:44524 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbeHaSsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:48:40 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C901B1A8D;
        Fri, 31 Aug 2018 16:40:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1535726450;
        bh=4j1chr/qnHmRgnaCZZnSKXZl9lYKmysazAxTrdbubno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LHFx+VwLaBL9T6JPinYQuGvp37q2qUwQVgYyGRnULKkpGk+I4xgJWYmQ7p8YThl21
         WwCYp7O+sjDkK0mVdEBtMPwlq1D766peKLYASu5C9mhyEtXZUIPWsYP8Rkbj63ASvJ
         8LTCJ4ipdHfQb9rWWtbILFMyVz7Hivix/bNmgsjA=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH 2/6] media: vsp1: Correct the pitch on multiplanar formats
Date:   Fri, 31 Aug 2018 15:40:40 +0100
Message-Id: <20180831144044.31713-3-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831144044.31713-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180831144044.31713-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM pipelines now support tri-planar as well as packed formats with
YCbCr, however the pitch calculation was not updated to support this.

Correct this by adjusting the bytesperline accordingly when 3 planes are
used.

Fixes: 7863ac504bc5 ("drm: rcar-du: Add tri-planar memory formats support")
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_drm.c | 10 ++++++++++
 include/media/vsp1.h                   |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/vsp1/vsp1_drm.c b/drivers/media/platform/vsp1/vsp1_drm.c
index b9c0f695d002..b9afd98f6867 100644
--- a/drivers/media/platform/vsp1/vsp1_drm.c
+++ b/drivers/media/platform/vsp1/vsp1_drm.c
@@ -814,6 +814,16 @@ int vsp1_du_atomic_update(struct device *dev, unsigned int pipe_index,
 	rpf->format.num_planes = fmtinfo->planes;
 	rpf->format.plane_fmt[0].bytesperline = cfg->pitch;
 	rpf->format.plane_fmt[1].bytesperline = cfg->pitch;
+
+	/*
+	 * Packed YUV formats are subsampled, but the packing of two components
+	 * into a single plane compensates for this leaving the bytesperline
+	 * to be the correct value. For multiplanar formats we must adjust the
+	 * pitch accordingly.
+	 */
+	if (fmtinfo->planes == 3)
+		rpf->format.plane_fmt[1].bytesperline /= fmtinfo->hsub;
+
 	rpf->alpha = cfg->alpha;
 
 	rpf->mem.addr[0] = cfg->mem[0];
diff --git a/include/media/vsp1.h b/include/media/vsp1.h
index 3093b9cb9067..0ce19b595cc7 100644
--- a/include/media/vsp1.h
+++ b/include/media/vsp1.h
@@ -46,7 +46,7 @@ int vsp1_du_setup_lif(struct device *dev, unsigned int pipe_index,
 /**
  * struct vsp1_du_atomic_config - VSP atomic configuration parameters
  * @pixelformat: plane pixel format (V4L2 4CC)
- * @pitch: line pitch in bytes, for all planes
+ * @pitch: line pitch in bytes
  * @mem: DMA memory address for each plane of the frame buffer
  * @src: source rectangle in the frame buffer (integer coordinates)
  * @dst: destination rectangle on the display (integer coordinates)
-- 
2.17.1

