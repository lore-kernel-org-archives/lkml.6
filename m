Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFE0C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77F721855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899911;
	bh=A2DZ+MSvyOohz41YdRakkGxktNHoidN9mQKYpP30khA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qk6Alb6ix/jjOlWFQhOHrW1LJemonEgV8R5KZK7c9b+FY0qnIRuCECp06qaAATAzf
	 GS8+TZOY32chLXArCF+oka62vcNppDz9023txODBTmsXeT94mY0rtncXM1i9TYPMJD
	 +mEH0s+87aBCXvcP0kU+rJ3vF8hnn1j+g40578hA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732741AbfBKOnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:43:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732713AbfBKOns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:43:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A1BA222A1;
        Mon, 11 Feb 2019 14:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896227;
        bh=A2DZ+MSvyOohz41YdRakkGxktNHoidN9mQKYpP30khA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6Eo08gvcDLANL1pSbTuK9qr7ZT8yUQihFYicjQSvCAd+CoQTetLuR4InWcIX7Z9E
         tEX6TRGmaIW15fr2r0AJv4kS1MTWm/aNQQXig25l9N7sGtI02H3V8H1LpD8NPb3WO2
         ZFpBOshK0CVJ5edUaIdX3N5zoOFNsn5sa0kZxgps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 114/313] media: coda: fix H.264 deblocking filter controls
Date:   Mon, 11 Feb 2019 15:16:34 +0100
Message-Id: <20190211141901.477620178@linuxfoundation.org>
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
index d26c2d85a009..d20d3df5778b 100644
--- a/drivers/media/platform/coda/coda-bit.c
+++ b/drivers/media/platform/coda/coda-bit.c
@@ -991,16 +991,15 @@ static int coda_start_encoding(struct coda_ctx *ctx)
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
index bf7b8417c27f..19d92edcc981 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -1793,14 +1793,13 @@ static int coda_s_ctrl(struct v4l2_ctrl *ctrl)
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
@@ -1882,13 +1881,13 @@ static void coda_encode_ctrls(struct coda_ctx *ctx)
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
index 19ac0b9dc6eb..2469ca1dc598 100644
--- a/drivers/media/platform/coda/coda.h
+++ b/drivers/media/platform/coda/coda.h
@@ -115,9 +115,9 @@ struct coda_params {
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
index 5e7b00a97671..e675e38f3475 100644
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



