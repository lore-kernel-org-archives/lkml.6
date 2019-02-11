Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5F9C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C02222A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897059;
	bh=vJN6CS1t9aCsy5/TXMj3nIZoEuwRD1y7YYngXiHvN5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LLs6qJFAIDBJSIRKY+2m4HfSDFY1HBs7OaTc+Keaz0XpWCRUHBH01rMIqs8Nno0ND
	 YOlg9wjOEVrW7LpVfMuojXpLst2rVGCjCcJm4J4I8Og8KmNaKeDpbTfY4x1tpUXNXr
	 jxLnpG/fYTs8R98e3cnYH7h+RmCH9C4R0hy7PVPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389394AbfBKO5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:57:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389372AbfBKO5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:57:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5F6C222AB;
        Mon, 11 Feb 2019 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897053;
        bh=vJN6CS1t9aCsy5/TXMj3nIZoEuwRD1y7YYngXiHvN5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UF5GiM1JcqLWVFffSVrRjcwHdvdlYhSVnZE8mXmFEw5rMoh4VOEO50nAqJ9kRjeWQ
         /fvhuPxcbxwQ1T4Cdez+t7PFApv4CSm9GHMPk1kwSICCYAzSaAkDhkVhBgBT60eI5d
         p2clbP2rI6JAIFHMjfkk/Z7rTz1hXIoeaWxDYElk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 075/205] media: coda: fix H.264 deblocking filter controls
Date:   Mon, 11 Feb 2019 15:17:53 +0100
Message-Id: <20190211141833.624997387@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 75fa6e4f83a0923fe753827d354998d448b4fd6a ]

Add support for the third loop filter mode
V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_DISABLED_AT_SLICE_BOUNDARY,
and fix V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_ALPHA and
V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_BETA controls.

The filter offset controls are signed values in the -6 to 6 range and
are stored into the slice header fields slice_alpha_c0_offset_div2 and
slice_beta_offset_div2. The actual filter offsets FilterOffsetA/B are
double their value, in range of -12 to 12.

Rename variables to more closely match the nomenclature in the H.264
specification.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/coda/coda-bit.c    | 19 +++++++++----------
 drivers/media/platform/coda/coda-common.c | 15 +++++++--------
 drivers/media/platform/coda/coda.h        |  6 +++---
 drivers/media/platform/coda/coda_regs.h   |  2 +-
 4 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/media/platform/coda/coda-bit.c b/drivers/media/platform/coda/coda-bit.c
index 291c40933935..3457a5f1c8a8 100644
--- a/drivers/media/platform/coda/coda-bit.c
+++ b/drivers/media/platform/coda/coda-bit.c
@@ -953,16 +953,15 @@ static int coda_start_encoding(struct coda_ctx *ctx)
 		else
 			coda_write(dev, CODA_STD_H264,
 				   CODA_CMD_ENC_SEQ_COD_STD);
-		if (ctx->params.h264_deblk_enabled) {
-			value = ((ctx->params.h264_deblk_alpha &
-				  CODA_264PARAM_DEBLKFILTEROFFSETALPHA_MASK) <<
-				 CODA_264PARAM_DEBLKFILTEROFFSETALPHA_OFFSET) |
-				((ctx->params.h264_deblk_beta &
-				  CODA_264PARAM_DEBLKFILTEROFFSETBETA_MASK) <<
-				 CODA_264PARAM_DEBLKFILTEROFFSETBETA_OFFSET);
-		} else {
-			value = 1 << CODA_264PARAM_DISABLEDEBLK_OFFSET;
-		}
+		value = ((ctx->params.h264_disable_deblocking_filter_idc &
+			  CODA_264PARAM_DISABLEDEBLK_MASK) <<
+			 CODA_264PARAM_DISABLEDEBLK_OFFSET) |
+			((ctx->params.h264_slice_alpha_c0_offset_div2 &
+			  CODA_264PARAM_DEBLKFILTEROFFSETALPHA_MASK) <<
+			 CODA_264PARAM_DEBLKFILTEROFFSETALPHA_OFFSET) |
+			((ctx->params.h264_slice_beta_offset_div2 &
+			  CODA_264PARAM_DEBLKFILTEROFFSETBETA_MASK) <<
+			 CODA_264PARAM_DEBLKFILTEROFFSETBETA_OFFSET);
 		coda_write(dev, value, CODA_CMD_ENC_SEQ_264_PARA);
 		break;
 	case V4L2_PIX_FMT_JPEG:
diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index 99d138d3f87f..2e1472fadc2c 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -1675,14 +1675,13 @@ static int coda_s_ctrl(struct v4l2_ctrl *ctrl)
 		ctx->params.h264_max_qp = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_ALPHA:
-		ctx->params.h264_deblk_alpha = ctrl->val;
+		ctx->params.h264_slice_alpha_c0_offset_div2 = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_BETA:
-		ctx->params.h264_deblk_beta = ctrl->val;
+		ctx->params.h264_slice_beta_offset_div2 = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_MODE:
-		ctx->params.h264_deblk_enabled = (ctrl->val ==
-				V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_ENABLED);
+		ctx->params.h264_disable_deblocking_filter_idc = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
 		/* TODO: switch between baseline and constrained baseline */
@@ -1764,13 +1763,13 @@ static void coda_encode_ctrls(struct coda_ctx *ctx)
 	v4l2_ctrl_new_std(&ctx->ctrls, &coda_ctrl_ops,
 		V4L2_CID_MPEG_VIDEO_H264_MAX_QP, 0, 51, 1, 51);
 	v4l2_ctrl_new_std(&ctx->ctrls, &coda_ctrl_ops,
-		V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_ALPHA, 0, 15, 1, 0);
+		V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_ALPHA, -6, 6, 1, 0);
 	v4l2_ctrl_new_std(&ctx->ctrls, &coda_ctrl_ops,
-		V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_BETA, 0, 15, 1, 0);
+		V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_BETA, -6, 6, 1, 0);
 	v4l2_ctrl_new_std_menu(&ctx->ctrls, &coda_ctrl_ops,
 		V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_MODE,
-		V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_DISABLED, 0x0,
-		V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_ENABLED);
+		V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_DISABLED_AT_SLICE_BOUNDARY,
+		0x0, V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_ENABLED);
 	v4l2_ctrl_new_std_menu(&ctx->ctrls, &coda_ctrl_ops,
 		V4L2_CID_MPEG_VIDEO_H264_PROFILE,
 		V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE, 0x0,
diff --git a/drivers/media/platform/coda/coda.h b/drivers/media/platform/coda/coda.h
index c5f504d8cf67..389a882cc3da 100644
--- a/drivers/media/platform/coda/coda.h
+++ b/drivers/media/platform/coda/coda.h
@@ -114,9 +114,9 @@ struct coda_params {
 	u8			h264_inter_qp;
 	u8			h264_min_qp;
 	u8			h264_max_qp;
-	u8			h264_deblk_enabled;
-	u8			h264_deblk_alpha;
-	u8			h264_deblk_beta;
+	u8			h264_disable_deblocking_filter_idc;
+	s8			h264_slice_alpha_c0_offset_div2;
+	s8			h264_slice_beta_offset_div2;
 	u8			h264_profile_idc;
 	u8			h264_level_idc;
 	u8			mpeg4_intra_qp;
diff --git a/drivers/media/platform/coda/coda_regs.h b/drivers/media/platform/coda/coda_regs.h
index 38df5fd9a2fa..546f5762357c 100644
--- a/drivers/media/platform/coda/coda_regs.h
+++ b/drivers/media/platform/coda/coda_regs.h
@@ -292,7 +292,7 @@
 #define		CODA_264PARAM_DEBLKFILTEROFFSETALPHA_OFFSET	8
 #define		CODA_264PARAM_DEBLKFILTEROFFSETALPHA_MASK	0x0f
 #define		CODA_264PARAM_DISABLEDEBLK_OFFSET		6
-#define		CODA_264PARAM_DISABLEDEBLK_MASK		0x01
+#define		CODA_264PARAM_DISABLEDEBLK_MASK		0x03
 #define		CODA_264PARAM_CONSTRAINEDINTRAPREDFLAG_OFFSET	5
 #define		CODA_264PARAM_CONSTRAINEDINTRAPREDFLAG_MASK	0x01
 #define		CODA_264PARAM_CHROMAQPOFFSET_OFFSET		0
-- 
2.19.1



