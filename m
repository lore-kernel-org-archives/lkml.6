Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380A5C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08807206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896418;
	bh=vSKdeS93I5i7AWT6HJNxD3BNW6YpAc4rU1KasHIoVp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kHVuzi8yPmxXyRVGAMgo2qaZBycWTAQxUZDS7IbfFsBdDMZQ/dOq7mvegKdtxlHb2
	 qKgETM1fsHd51ipX8TI/QeVu6+OX8bR0zenmPoiZf1JSTD+t4fFp3TwlzjnhnjiVMY
	 EooTyIa7HXJL2KN2RJrFkj3uDBDH/jG8muHEUV3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbfBKOq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:46:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732327AbfBKOqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:46:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96F0820700;
        Mon, 11 Feb 2019 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896415;
        bh=vSKdeS93I5i7AWT6HJNxD3BNW6YpAc4rU1KasHIoVp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I2xM5Ly+JomYdaaACBDo6ZwoCCZ7HNMW9Bf+/lGvEZ02pmxuLUo+04o9ru0QgsYMz
         Qzv2SiWLrZg1MGXnwaEDxmrtgiJIPBzoui3+AEXX7VCOU/N2Bhi85q206nqx8dXxiH
         DkKHCgPaXUCrmGFKxGyHfWhrGx1Adragizai8YS4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Yang <Eric.Yang2@amd.com>,
        Hugo Hu <Hugo.Hu@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 176/313] drm/amd/display: fix YCbCr420 blank color
Date:   Mon, 11 Feb 2019 15:17:36 +0100
Message-Id: <20190211141905.116002491@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 12750d1647f118496f1da727146f255f5e44d500 ]

[Why]
YCbCr420 packing format uses two chanels for luma, and 1
channel for both chroma component. Our previous implementation
did not account for this and results in every other pixel having
very high luma value, showing greyish color instead of black.

YCbCr444 = <Y1, Cb1, Cr1>; <Y2, Cb2, Cr2> .....
YCbCr420 = <Y1, Y2,  Cb1>; <Y3, Y4,  Cr1> .....

[How]
Program the second channel with the black color value for luma
as well.

Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
Reviewed-by: Hugo Hu <Hugo.Hu@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/dce110/dce110_hw_sequencer.c   | 11 ++++++++++-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c |  9 +++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 0941f3c689bc..580e7e82034f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1268,10 +1268,19 @@ static void program_scaler(const struct dc *dc,
 		pipe_ctx->plane_res.scl_data.lb_params.depth,
 		&pipe_ctx->stream->bit_depth_params);
 
-	if (pipe_ctx->stream_res.tg->funcs->set_overscan_blank_color)
+	if (pipe_ctx->stream_res.tg->funcs->set_overscan_blank_color) {
+		/*
+		 * The way 420 is packed, 2 channels carry Y component, 1 channel
+		 * alternate between Cb and Cr, so both channels need the pixel
+		 * value for Y
+		 */
+		if (pipe_ctx->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420)
+			color.color_r_cr = color.color_g_y;
+
 		pipe_ctx->stream_res.tg->funcs->set_overscan_blank_color(
 				pipe_ctx->stream_res.tg,
 				&color);
+	}
 
 	pipe_ctx->plane_res.xfm->funcs->transform_set_scaler(pipe_ctx->plane_res.xfm,
 		&pipe_ctx->plane_res.scl_data);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 33a9d0c58966..4058b59d9bea 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2121,6 +2121,15 @@ static void dcn10_blank_pixel_data(
 	color_space = stream->output_color_space;
 	color_space_to_black_color(dc, color_space, &black_color);
 
+	/*
+	 * The way 420 is packed, 2 channels carry Y component, 1 channel
+	 * alternate between Cb and Cr, so both channels need the pixel
+	 * value for Y
+	 */
+	if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420)
+		black_color.color_r_cr = black_color.color_g_y;
+
+
 	if (stream_res->tg->funcs->set_blank_color)
 		stream_res->tg->funcs->set_blank_color(
 				stream_res->tg,
-- 
2.19.1



