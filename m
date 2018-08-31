Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75988C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335BC20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UjaOLdBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335BC20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeHaSsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:48:39 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:44516 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbeHaSsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:48:39 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 59800158B;
        Fri, 31 Aug 2018 16:40:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1535726449;
        bh=Dlnp2XqV2L66jvacBjz+iCTxpHBPB2fV6Cu4HMpP4pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UjaOLdBAQ6uvWYU4lqvR2B8qggdzb/GH4SXBrBXIdL+EFYPj9b4nXMAyqw/Etw7jp
         h+Ntu+qrotk0oESTt6Mhpc2LxoP3TnzhM5DFKwV/T6Af5GXvYV0dWz5TVUrk7vkDho
         mTLHTuv1wvZl8Mb6P6cJwhjDdlN+Ka1SJa1bFP44=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH 1/6] media: vsp1: Remove artificial pixel limitation
Date:   Fri, 31 Aug 2018 15:40:39 +0100
Message-Id: <20180831144044.31713-2-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831144044.31713-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180831144044.31713-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VSP1 has a minimum width and height of a single pixel, with the
exception of pixel formats with sub-sampling.

Remove the artificial minimum width and minimum height limitation, and
instead clamp the minimum dimensions based upon the sub-sampling
parameter of that dimension.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_video.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_video.c b/drivers/media/platform/vsp1/vsp1_video.c
index 81d47a09d7bc..e78eadd0295b 100644
--- a/drivers/media/platform/vsp1/vsp1_video.c
+++ b/drivers/media/platform/vsp1/vsp1_video.c
@@ -38,9 +38,7 @@
 #define VSP1_VIDEO_DEF_WIDTH		1024
 #define VSP1_VIDEO_DEF_HEIGHT		768
 
-#define VSP1_VIDEO_MIN_WIDTH		2U
 #define VSP1_VIDEO_MAX_WIDTH		8190U
-#define VSP1_VIDEO_MIN_HEIGHT		2U
 #define VSP1_VIDEO_MAX_HEIGHT		8190U
 
 /* -----------------------------------------------------------------------------
@@ -136,9 +134,8 @@ static int __vsp1_video_try_format(struct vsp1_video *video,
 	height = round_down(height, info->vsub);
 
 	/* Clamp the width and height. */
-	pix->width = clamp(width, VSP1_VIDEO_MIN_WIDTH, VSP1_VIDEO_MAX_WIDTH);
-	pix->height = clamp(height, VSP1_VIDEO_MIN_HEIGHT,
-			    VSP1_VIDEO_MAX_HEIGHT);
+	pix->width = clamp(width, info->hsub, VSP1_VIDEO_MAX_WIDTH);
+	pix->height = clamp(height, info->vsub, VSP1_VIDEO_MAX_HEIGHT);
 
 	/*
 	 * Compute and clamp the stride and image size. While not documented in
-- 
2.17.1

