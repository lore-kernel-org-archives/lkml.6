Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4B7C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD2F2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690886;
	bh=2yuJoPFDlraP0ePikmMQJ7ezoOJCyfO+4uykqvk2Od8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rwDZFxkXLV3OWpCuDDjBTNSpgGxoWBebqEVrFIvYtZsYUaOfpC09zdoQGBzFqvjPN
	 p7nkIczbK5mvc0DFPj6jMaFhFNc7QjLiw1A4cqFzE+wjX1wIRC7bou2fFkpeb3VVS1
	 CNyMRlVPFGtDpjvnpfgaLzCXk29kVRtB0r77NEpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbfA1Pyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:54:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfA1Pym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:54:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E939020989;
        Mon, 28 Jan 2019 15:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690882;
        bh=2yuJoPFDlraP0ePikmMQJ7ezoOJCyfO+4uykqvk2Od8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GqKwXQWyHiObixOOXz/mhFf0bvHwlYI7Wwz45kon/+6336xZSWGjtlN14Z9yJM86g
         bpAIgoL7af68J1VemgiGxtumF/776NLbKQONajIwJwg61Lb1onPtPE73kY5RkrBLca
         ugnq73xxsvZM6P7Ksd3WMpsnXENivoHv2nYsS66M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Yang <Eric.Yang2@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 221/304] drm/amd/display: fix YCbCr420 blank color
Date:   Mon, 28 Jan 2019 10:42:18 -0500
Message-Id: <20190128154341.47195-221-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
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
index a6bcb90e8419..4443a916a0fb 100644
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
index 32e4c653b1b4..220ba828748d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2165,6 +2165,15 @@ static void dcn10_blank_pixel_data(
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

