Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E3FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EF420838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895459;
	bh=1N667BoU1/HsfPDWcZ1IiGUGYXm6kohOxYFl0c+0n54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jX6C+FW44+3JHxrGOSQ7nkiqRHBvxtKb17xEuS2YRLLZunfPm2ChuQ7B5B59ws18D
	 VRkFUtJAocxsI0HRKGlM11CfZlvaGhDoNpZh/3MI74Vg9bDxXzKDZOpfoewGqZNPlW
	 RoKqVXRkmXDrD4A/Qc6PVK5kTXCtQZ12nVmEkNig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfBKOa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:30:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:37464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730187AbfBKOa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:30:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CF5C20675;
        Mon, 11 Feb 2019 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895455;
        bh=1N667BoU1/HsfPDWcZ1IiGUGYXm6kohOxYFl0c+0n54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v1easLxnW4Qua6bLEz5i5tnYBOk8ZRt2ReVqc9zpPQ8uPK3bkeDUVrjFi+MgpSiJD
         Gbgb/03mwtQnAEoT3gwqa6wfLXlNgp8iac2Tw1AeoiO3LcQt+ulvVYb8pRrQLPXrHV
         +3gRUA3NJW7TSfO5b0Dky9mrlmpEZVduZLLbABhg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Yang <Eric.Yang2@amd.com>,
        Hugo Hu <Hugo.Hu@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 209/352] drm/amd/display: fix YCbCr420 blank color
Date:   Mon, 11 Feb 2019 15:17:16 +0100
Message-Id: <20190211141900.485555710@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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



