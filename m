Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00C9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42987208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MZE8Vz5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42987208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933352AbeFRIAs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:00:48 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38228 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933279AbeFRIAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:00:45 -0400
Received: by mail-pf0-f196.google.com with SMTP id b74-v6so7753644pfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 01:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DPfdvFNwDNfcnDy9ku+EglCSakGBrnrQ9SpFkpgBUcQ=;
        b=MZE8Vz5I0+2DIS/BLOs8T4g8Ood/RC0Qw8ERnKlrznvObhKGmit7YKKHOG2r+Tua1/
         4YnhYlwCtlCT3kDsuvTji6AIjMkA44V9dMQ5DLORy29A1jJhwh5PC7BQlq3Y4RJBwi0D
         MuBe89UXZ6UJ+i8+J3XPnf68qyU52l2s7V9fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DPfdvFNwDNfcnDy9ku+EglCSakGBrnrQ9SpFkpgBUcQ=;
        b=UCWiou3afUJ1m/7F0vWozRoRI8n7CSxv+QecbywEWrf6mgQ2inHqCyPi5SSkzaJHyj
         Pz2QNg3Hx8BcO/h9Dr7xx5wiQEmTfrOJ1rttV5rbXJ3QR1+UaNK80PnyIurmYQkdFV3H
         Xy21XGLTpbEqo/c+mcCvFH/pfJxySTU/SsYg95NDHhwtDUeIR8QD7qAl2EzcLgk3djNr
         quzD/vQXOGm6RbzNbk48Pb1MAXA4qmFE1ZToLXlVqiHXFzdD5HilzUYXEH/e3Zs29oON
         tYvZcKKcsZdzFHTmzhKhZm7FnrNMgX1Jovt65E/dwNv9kM85+MjbWaEuOdvxxeZXBs8m
         aZYQ==
X-Gm-Message-State: APt69E0TYg2MRzFpMMzgi2e562ip9bWwZ4sQa1VFhc1W6jdVMiZkmgHI
        heZyDk639/Kj1M29v0BBb3R70A==
X-Google-Smtp-Source: ADUXVKJB6VXl7P7FCGAK6prVM6cjHuFRAhSOHIt4gQBFsWZetlI7DZICu65hu3gG9FrbaEX9X6vVZw==
X-Received: by 2002:a63:42c7:: with SMTP id p190-v6mr10314568pga.142.1529308844665;
        Mon, 18 Jun 2018 01:00:44 -0700 (PDT)
Received: from keiichiw1.tok.corp.google.com ([2401:fa00:4:4:968c:de0d:27a3:4bef])
        by smtp.gmail.com with ESMTPSA id d9-v6sm23543236pfg.183.2018.06.18.01.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 01:00:43 -0700 (PDT)
From:   Keiichi Watanabe <keiichiw@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Smitha T Murthy <smitha.t@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 1/3] media: v4l2-ctrl: Change control for VP8 profile to menu control
Date:   Mon, 18 Jun 2018 16:58:52 +0900
Message-Id: <20180618075854.12881-2-keiichiw@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180618075854.12881-1-keiichiw@chromium.org>
References: <20180618075854.12881-1-keiichiw@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a menu control V4L2_CID_MPEG_VIDEO_VP8_PROFILE for VP8 profile and make
V4L2_CID_MPEG_VIDEO_VPX_PROFILE an alias of it. This new control is used to
select the desired profile for VP8 encoder and query for supported profiles by
VP8 encoder/decoder.

Though we have originally a control V4L2_CID_MPEG_VIDEO_VPX_PROFILE and its name
contains 'VPX', it works only for VP8 because supported profiles usually differ
between VP8 and VP9. In addition, this control cannot be used for querying since
it is not a menu control but an integer control, which cannot return an
arbitrary set of supported profiles.

The new control V4L2_CID_MPEG_VIDEO_VP8_PROFILE is a menu control as with
controls for other codec profiles. (e.g. H264)

In addition, this patch also fixes the use of V4L2_CID_MPEG_VIDEO_VPX_PROFILE in
drivers of Qualcomm's venus and Samsung's s5p-mfc.

Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
---
 .../media/uapi/v4l/extended-controls.rst      | 25 ++++++++++++++++---
 .../media/platform/qcom/venus/vdec_ctrls.c    | 10 +++++---
 drivers/media/platform/qcom/venus/venc.c      |  4 +--
 .../media/platform/qcom/venus/venc_ctrls.c    | 10 +++++---
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c  | 15 ++++++-----
 drivers/media/v4l2-core/v4l2-ctrls.c          | 12 ++++++++-
 include/uapi/linux/v4l2-controls.h            | 11 +++++++-
 7 files changed, 64 insertions(+), 23 deletions(-)

diff --git a/Documentation/media/uapi/v4l/extended-controls.rst b/Documentation/media/uapi/v4l/extended-controls.rst
index 03931f9b1285..01ef31a934b4 100644
--- a/Documentation/media/uapi/v4l/extended-controls.rst
+++ b/Documentation/media/uapi/v4l/extended-controls.rst
@@ -1955,9 +1955,28 @@ enum v4l2_vp8_golden_frame_sel -
 ``V4L2_CID_MPEG_VIDEO_VPX_P_FRAME_QP (integer)``
     Quantization parameter for a P frame for VP8.

-``V4L2_CID_MPEG_VIDEO_VPX_PROFILE (integer)``
-    Select the desired profile for VPx encoder. Acceptable values are 0,
-    1, 2 and 3 corresponding to encoder profiles 0, 1, 2 and 3.
+.. _v4l2-mpeg-video-vp8-profile:
+
+``V4L2_CID_MPEG_VIDEO_VP8_PROFILE``
+    (enum)
+
+enum v4l2_mpeg_video_vp8_profile -
+    This control allows selecting the profile for VP8 encoder.
+    This is also used to enumerate supported profiles by VP8 encoder or decoder.
+    Possible values are:
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_0``
+      - Profile 0
+    * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_1``
+      - Profile 1
+    * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_2``
+      - Profile 2
+    * - ``V4L2_MPEG_VIDEO_VP8_PROFILE_3``
+      - Profile 3


 High Efficiency Video Coding (HEVC/H.265) Control Reference
diff --git a/drivers/media/platform/qcom/venus/vdec_ctrls.c b/drivers/media/platform/qcom/venus/vdec_ctrls.c
index 032839bbc967..f4604b0cd57e 100644
--- a/drivers/media/platform/qcom/venus/vdec_ctrls.c
+++ b/drivers/media/platform/qcom/venus/vdec_ctrls.c
@@ -29,7 +29,7 @@ static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
 	case V4L2_CID_MPEG_VIDEO_MPEG4_PROFILE:
-	case V4L2_CID_MPEG_VIDEO_VPX_PROFILE:
+	case V4L2_CID_MPEG_VIDEO_VP8_PROFILE:
 		ctr->profile = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_VIDEO_H264_LEVEL:
@@ -54,7 +54,7 @@ static int vdec_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 	switch (ctrl->id) {
 	case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
 	case V4L2_CID_MPEG_VIDEO_MPEG4_PROFILE:
-	case V4L2_CID_MPEG_VIDEO_VPX_PROFILE:
+	case V4L2_CID_MPEG_VIDEO_VP8_PROFILE:
 		ret = hfi_session_get_property(inst, ptype, &hprop);
 		if (!ret)
 			ctr->profile = hprop.profile_level.profile;
@@ -130,8 +130,10 @@ int vdec_ctrl_init(struct venus_inst *inst)
 	if (ctrl)
 		ctrl->flags |= V4L2_CTRL_FLAG_VOLATILE;

-	ctrl = v4l2_ctrl_new_std(&inst->ctrl_handler, &vdec_ctrl_ops,
-				 V4L2_CID_MPEG_VIDEO_VPX_PROFILE, 0, 3, 1, 0);
+	ctrl = v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &vdec_ctrl_ops,
+				      V4L2_CID_MPEG_VIDEO_VP8_PROFILE,
+				      V4L2_MPEG_VIDEO_VP8_PROFILE_3,
+				      0, V4L2_MPEG_VIDEO_VP8_PROFILE_0);
 	if (ctrl)
 		ctrl->flags |= V4L2_CTRL_FLAG_VOLATILE;

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 6b2ce479584e..cba6ef1e2d04 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -223,7 +223,7 @@ static int venc_v4l2_to_hfi(int id, int value)
 		case V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CABAC:
 			return HFI_H264_ENTROPY_CABAC;
 		}
-	case V4L2_CID_MPEG_VIDEO_VPX_PROFILE:
+	case V4L2_CID_MPEG_VIDEO_VP8_PROFILE:
 		switch (value) {
 		case 0:
 		default:
@@ -756,7 +756,7 @@ static int venc_set_properties(struct venus_inst *inst)
 		level = venc_v4l2_to_hfi(V4L2_CID_MPEG_VIDEO_H264_LEVEL,
 					 ctr->level.h264);
 	} else if (inst->fmt_cap->pixfmt == V4L2_PIX_FMT_VP8) {
-		profile = venc_v4l2_to_hfi(V4L2_CID_MPEG_VIDEO_VPX_PROFILE,
+		profile = venc_v4l2_to_hfi(V4L2_CID_MPEG_VIDEO_VP8_PROFILE,
 					   ctr->profile.vpx);
 		level = 0;
 	} else if (inst->fmt_cap->pixfmt == V4L2_PIX_FMT_MPEG4) {
diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index 21e938a28662..459101728d26 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -101,7 +101,7 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
 		ctr->profile.h264 = ctrl->val;
 		break;
-	case V4L2_CID_MPEG_VIDEO_VPX_PROFILE:
+	case V4L2_CID_MPEG_VIDEO_VP8_PROFILE:
 		ctr->profile.vpx = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_VIDEO_MPEG4_LEVEL:
@@ -248,6 +248,11 @@ int venc_ctrl_init(struct venus_inst *inst)
 		V4L2_MPEG_VIDEO_MULTI_SICE_MODE_MAX_BYTES,
 		0, V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_SINGLE);

+	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
+		V4L2_CID_MPEG_VIDEO_VP8_PROFILE,
+		V4L2_MPEG_VIDEO_VP8_PROFILE_3,
+		0, V4L2_MPEG_VIDEO_VP8_PROFILE_0);
+
 	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
 		V4L2_CID_MPEG_VIDEO_BITRATE, BITRATE_MIN, BITRATE_MAX,
 		BITRATE_STEP, BITRATE_DEFAULT);
@@ -256,9 +261,6 @@ int venc_ctrl_init(struct venus_inst *inst)
 		V4L2_CID_MPEG_VIDEO_BITRATE_PEAK, BITRATE_MIN, BITRATE_MAX,
 		BITRATE_STEP, BITRATE_DEFAULT_PEAK);

-	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
-		V4L2_CID_MPEG_VIDEO_VPX_PROFILE, 0, 3, 1, 0);
-
 	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
 		V4L2_CID_MPEG_VIDEO_H264_I_FRAME_QP, 1, 51, 1, 26);

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
index 570f391f2cfd..3ad4f5073002 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
@@ -692,12 +692,12 @@ static struct mfc_control controls[] = {
 		.default_value = 10,
 	},
 	{
-		.id = V4L2_CID_MPEG_VIDEO_VPX_PROFILE,
-		.type = V4L2_CTRL_TYPE_INTEGER,
-		.minimum = 0,
-		.maximum = 3,
-		.step = 1,
-		.default_value = 0,
+		.id = V4L2_CID_MPEG_VIDEO_VP8_PROFILE,
+		.type = V4L2_CTRL_TYPE_MENU,
+		.minimum = V4L2_MPEG_VIDEO_VP8_PROFILE_0,
+		.maximum = V4L2_MPEG_VIDEO_VP8_PROFILE_3,
+		.default_value = V4L2_MPEG_VIDEO_VP8_PROFILE_0,
+		.menu_skip_mask = 0,
 	},
 	{
 		.id = V4L2_CID_MPEG_VIDEO_HEVC_I_FRAME_QP,
@@ -2057,7 +2057,7 @@ static int s5p_mfc_enc_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MPEG_VIDEO_VPX_P_FRAME_QP:
 		p->codec.vp8.rc_p_frame_qp = ctrl->val;
 		break;
-	case V4L2_CID_MPEG_VIDEO_VPX_PROFILE:
+	case V4L2_CID_MPEG_VIDEO_VP8_PROFILE:
 		p->codec.vp8.profile = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_VIDEO_HEVC_I_FRAME_QP:
@@ -2711,4 +2711,3 @@ void s5p_mfc_enc_init(struct s5p_mfc_ctx *ctx)
 	f.fmt.pix_mp.pixelformat = DEF_DST_FMT_ENC;
 	ctx->dst_fmt = find_format(&f, MFC_FMT_ENC);
 }
-
diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index d29e45516eb7..e7e6340b395e 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -431,6 +431,13 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		"Use Previous Specific Frame",
 		NULL,
 	};
+	static const char * const vp8_profile[] = {
+		"0",
+		"1",
+		"2",
+		"3",
+		NULL,
+	};

 	static const char * const flash_led_mode[] = {
 		"Off",
@@ -614,6 +621,8 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		return mpeg4_profile;
 	case V4L2_CID_MPEG_VIDEO_VPX_GOLDEN_FRAME_SEL:
 		return vpx_golden_frame_sel;
+	case V4L2_CID_MPEG_VIDEO_VP8_PROFILE:
+		return vp8_profile;
 	case V4L2_CID_JPEG_CHROMA_SUBSAMPLING:
 		return jpeg_chroma_subsampling;
 	case V4L2_CID_DV_TX_MODE:
@@ -839,7 +848,7 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_VPX_MAX_QP:			return "VPX Maximum QP Value";
 	case V4L2_CID_MPEG_VIDEO_VPX_I_FRAME_QP:		return "VPX I-Frame QP Value";
 	case V4L2_CID_MPEG_VIDEO_VPX_P_FRAME_QP:		return "VPX P-Frame QP Value";
-	case V4L2_CID_MPEG_VIDEO_VPX_PROFILE:			return "VPX Profile";
+	case V4L2_CID_MPEG_VIDEO_VP8_PROFILE:			return "VP8 Profile";

 	/* HEVC controls */
 	case V4L2_CID_MPEG_VIDEO_HEVC_I_FRAME_QP:		return "HEVC I-Frame QP Value";
@@ -1180,6 +1189,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_DEINTERLACING_MODE:
 	case V4L2_CID_TUNE_DEEMPHASIS:
 	case V4L2_CID_MPEG_VIDEO_VPX_GOLDEN_FRAME_SEL:
+	case V4L2_CID_MPEG_VIDEO_VP8_PROFILE:
 	case V4L2_CID_DETECT_MD_MODE:
 	case V4L2_CID_MPEG_VIDEO_HEVC_PROFILE:
 	case V4L2_CID_MPEG_VIDEO_HEVC_LEVEL:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 8d473c979b61..2001823c3072 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -587,7 +587,16 @@ enum v4l2_vp8_golden_frame_sel {
 #define V4L2_CID_MPEG_VIDEO_VPX_MAX_QP			(V4L2_CID_MPEG_BASE+508)
 #define V4L2_CID_MPEG_VIDEO_VPX_I_FRAME_QP		(V4L2_CID_MPEG_BASE+509)
 #define V4L2_CID_MPEG_VIDEO_VPX_P_FRAME_QP		(V4L2_CID_MPEG_BASE+510)
-#define V4L2_CID_MPEG_VIDEO_VPX_PROFILE			(V4L2_CID_MPEG_BASE+511)
+
+#define V4L2_CID_MPEG_VIDEO_VP8_PROFILE			(V4L2_CID_MPEG_BASE+511)
+enum v4l2_mpeg_video_vp8_profile {
+	V4L2_MPEG_VIDEO_VP8_PROFILE_0				= 0,
+	V4L2_MPEG_VIDEO_VP8_PROFILE_1				= 1,
+	V4L2_MPEG_VIDEO_VP8_PROFILE_2				= 2,
+	V4L2_MPEG_VIDEO_VP8_PROFILE_3				= 3,
+};
+/* Deprecated alias for compatibility reasons. */
+#define V4L2_CID_MPEG_VIDEO_VPX_PROFILE	V4L2_CID_MPEG_VIDEO_VP8_PROFILE

 /* CIDs for HEVC encoding. */

--
2.18.0.rc1.244.gcf134e6275-goog
