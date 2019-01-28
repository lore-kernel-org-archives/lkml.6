Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8546C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BA82171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691694;
	bh=65Zfj6BcI6f12litBoEQgNcOV3JapBerVXX1HVlLm4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZE4Yq8zkMo/DVToMmQExpE/GOUntVbQuf3skK8fGde1kmwVTqiXfeY0BCJMvtAPk6
	 UBEklRXLgWdCLn86o++T0878RgOtkufa2bd1JeMnMKX2L9yztm5zZGkdT1g5eokJ2D
	 3SR/MdYs+ZPsNtHrn5CUMtjndanAE3aRoiiTl61I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbfA1QIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:08:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:59604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731912AbfA1QIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:08:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A55F420989;
        Mon, 28 Jan 2019 16:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691689;
        bh=65Zfj6BcI6f12litBoEQgNcOV3JapBerVXX1HVlLm4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NzFGDeofWx5A7TBzYsuBn7R2LlFnVjNblq+/RBzbSKuryzpbrby6LvPl3JIOIPb4k
         k5YjSNbJ+UHOxzcNzHaSjE1DJ2QeL0SLngqi8QZyuNCidXacvcpTcvvHnTFMc66UvV
         sM6oYDt9xAVjM0s/P6tiKM+jZz1hf0ngs8qZBuxY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Yang <Eric.Yang2@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 185/258] drm/amd/display: fix YCbCr420 blank color
Date:   Mon, 28 Jan 2019 10:58:11 -0500
Message-Id: <20190128155924.51521-185-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Yang <Eric.Yang2@amd.com>

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

