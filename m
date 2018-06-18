Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7998DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBE220874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBE220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935923AbeFRIXl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:23:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55840 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935894AbeFRIXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:23:37 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6C9C1C49;
        Mon, 18 Jun 2018 08:23:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 181/279] drm/exynos: mixer: avoid Oops in vp_video_buffer()
Date:   Mon, 18 Jun 2018 10:12:46 +0200
Message-Id: <20180618080616.430684344@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

[ Upstream commit 0ccc1c8f0282e237a0bd6dca7cdac4ed5e318ee7 ]

If an interlaced video mode is selected, a IOMMU pagefault is
triggered by vp_video_buffer().

Fix the most apparent bugs:
- pitch value for chroma plane
- divide by two of height and vpos of source and destination

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
[ a.hajda: Halved also destination height and vpos, updated commit message ]
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/exynos/exynos_mixer.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -485,7 +485,7 @@ static void vp_video_buffer(struct mixer
 			chroma_addr[1] = chroma_addr[0] + 0x40;
 		} else {
 			luma_addr[1] = luma_addr[0] + fb->pitches[0];
-			chroma_addr[1] = chroma_addr[0] + fb->pitches[0];
+			chroma_addr[1] = chroma_addr[0] + fb->pitches[1];
 		}
 	} else {
 		luma_addr[1] = 0;
@@ -508,21 +508,23 @@ static void vp_video_buffer(struct mixer
 	vp_reg_write(ctx, VP_IMG_SIZE_Y, VP_IMG_HSIZE(fb->pitches[0]) |
 		VP_IMG_VSIZE(fb->height));
 	/* chroma plane for NV12/NV21 is half the height of the luma plane */
-	vp_reg_write(ctx, VP_IMG_SIZE_C, VP_IMG_HSIZE(fb->pitches[0]) |
+	vp_reg_write(ctx, VP_IMG_SIZE_C, VP_IMG_HSIZE(fb->pitches[1]) |
 		VP_IMG_VSIZE(fb->height / 2));
 
 	vp_reg_write(ctx, VP_SRC_WIDTH, state->src.w);
-	vp_reg_write(ctx, VP_SRC_HEIGHT, state->src.h);
 	vp_reg_write(ctx, VP_SRC_H_POSITION,
 			VP_SRC_H_POSITION_VAL(state->src.x));
-	vp_reg_write(ctx, VP_SRC_V_POSITION, state->src.y);
-
 	vp_reg_write(ctx, VP_DST_WIDTH, state->crtc.w);
 	vp_reg_write(ctx, VP_DST_H_POSITION, state->crtc.x);
+
 	if (test_bit(MXR_BIT_INTERLACE, &ctx->flags)) {
+		vp_reg_write(ctx, VP_SRC_HEIGHT, state->src.h / 2);
+		vp_reg_write(ctx, VP_SRC_V_POSITION, state->src.y / 2);
 		vp_reg_write(ctx, VP_DST_HEIGHT, state->crtc.h / 2);
 		vp_reg_write(ctx, VP_DST_V_POSITION, state->crtc.y / 2);
 	} else {
+		vp_reg_write(ctx, VP_SRC_HEIGHT, state->src.h);
+		vp_reg_write(ctx, VP_SRC_V_POSITION, state->src.y);
 		vp_reg_write(ctx, VP_DST_HEIGHT, state->crtc.h);
 		vp_reg_write(ctx, VP_DST_V_POSITION, state->crtc.y);
 	}


