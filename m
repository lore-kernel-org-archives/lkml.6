Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42C4C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948C126089
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YgfNCVDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948C126089
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934839AbeF0P2F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:28:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34119 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934639AbeF0P2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id l15-v6so18348818wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cFlFkNWCB/XAbvhXkdSY2vZ27efFVAFnjAV1bSmg1kQ=;
        b=YgfNCVDXOIa+b3AMdoAvAFiAdiRaDztJuXjj6qkesGjkUiVyskigOex1Erg6llIB8J
         OCabHllg8FV1GG3I2uo+DIi5EWcUECbeG2k5088+HIWPidgXxodTgKEAsBsET8CgMBL+
         pw9npII+ufQxYJThxwyuPBj0fI22rn/vvbYIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cFlFkNWCB/XAbvhXkdSY2vZ27efFVAFnjAV1bSmg1kQ=;
        b=MN7EymIFFIJ8jP5NxFwGKAOYYPFPnZ34aaEihN/o+SQVERXCh5VTu+foSDUk0QNCa3
         O8/JG6I5Hvng+5qjSrfW0z+tF1Z0FIQsKqkEjQHjNFmW1bmK7JTL7L8sobezvcZZbZOz
         qpxTEAyoGuZN5uoQcK6rJ6EverYDMQ9NUj2HmaUuvToJ0DqlLB6fouWYnMnwy5drcEDK
         h+kqpGIF9P6VZtjUkfLepfDQdEC31s3BWs7S7QqVz9Zm208hn+a4PkhHSRGlmwgKyNA8
         KMX/fWDmwR73U3qSiY/qUxw3dsLWjms7GBbznH0qwYY1TGR2k9lDP2HjvJUNVj7aIcPr
         KUjg==
X-Gm-Message-State: APt69E3yfcnRU0/WZ1Tic0trgEaATgkZ9V3tCRHstc+9reZ8WYc7r4V1
        SzHxCG79aBBVU3hgeEF2EaSewA==
X-Google-Smtp-Source: AAOMgpcDGD+BXHMRmynHgBpFdCIvZpXI3utw/4luzqmpT2qxlI+m7fSrDCW0X6Knv0Glc0x9EMsaYw==
X-Received: by 2002:a1c:78b:: with SMTP id 133-v6mr5668956wmh.59.1530113280157;
        Wed, 27 Jun 2018 08:28:00 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:27:59 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 02/27] venus: hfi: preparation to support venus 4xx
Date:   Wed, 27 Jun 2018 18:27:00 +0300
Message-Id: <20180627152725.9783-3-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This covers the differences between 1xx,3xx and 4xx.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/core.h         |  4 ++
 drivers/media/platform/qcom/venus/helpers.c      | 37 +++++++----
 drivers/media/platform/qcom/venus/hfi_helper.h   | 84 ++++++++++++++++++++++--
 drivers/media/platform/qcom/venus/hfi_venus_io.h |  7 ++
 drivers/media/platform/qcom/venus/vdec.c         |  5 +-
 drivers/media/platform/qcom/venus/venc.c         |  5 +-
 6 files changed, 120 insertions(+), 22 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 0360d295f4c8..8d3e150800c9 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -305,6 +305,10 @@ struct venus_inst {
 	struct hfi_buffer_requirements bufreq[HFI_BUFFER_TYPE_MAX];
 };
 
+#define IS_V1(core)	((core)->res->hfi_version == HFI_VERSION_1XX)
+#define IS_V3(core)	((core)->res->hfi_version == HFI_VERSION_3XX)
+#define IS_V4(core)	((core)->res->hfi_version == HFI_VERSION_4XX)
+
 #define ctrl_to_inst(ctrl)	\
 	container_of((ctrl)->handler, struct venus_inst, ctrl_handler)
 
diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 0ce9559a2924..d9065cc8a7d3 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -166,21 +166,37 @@ static int intbufs_unset_buffers(struct venus_inst *inst)
 	return ret;
 }
 
-static const unsigned int intbuf_types[] = {
-	HFI_BUFFER_INTERNAL_SCRATCH,
-	HFI_BUFFER_INTERNAL_SCRATCH_1,
-	HFI_BUFFER_INTERNAL_SCRATCH_2,
+static const unsigned int intbuf_types_1xx[] = {
+	HFI_BUFFER_INTERNAL_SCRATCH(HFI_VERSION_1XX),
+	HFI_BUFFER_INTERNAL_SCRATCH_1(HFI_VERSION_1XX),
+	HFI_BUFFER_INTERNAL_SCRATCH_2(HFI_VERSION_1XX),
+	HFI_BUFFER_INTERNAL_PERSIST,
+	HFI_BUFFER_INTERNAL_PERSIST_1,
+};
+
+static const unsigned int intbuf_types_4xx[] = {
+	HFI_BUFFER_INTERNAL_SCRATCH(HFI_VERSION_4XX),
+	HFI_BUFFER_INTERNAL_SCRATCH_1(HFI_VERSION_4XX),
+	HFI_BUFFER_INTERNAL_SCRATCH_2(HFI_VERSION_4XX),
 	HFI_BUFFER_INTERNAL_PERSIST,
 	HFI_BUFFER_INTERNAL_PERSIST_1,
 };
 
 static int intbufs_alloc(struct venus_inst *inst)
 {
-	unsigned int i;
+	size_t arr_sz;
+	size_t i;
 	int ret;
 
-	for (i = 0; i < ARRAY_SIZE(intbuf_types); i++) {
-		ret = intbufs_set_buffer(inst, intbuf_types[i]);
+	if (IS_V4(inst->core))
+		arr_sz = ARRAY_SIZE(intbuf_types_4xx);
+	else
+		arr_sz = ARRAY_SIZE(intbuf_types_1xx);
+
+	for (i = 0; i < arr_sz; i++) {
+		ret = intbufs_set_buffer(inst,
+			    IS_V4(inst->core) ? intbuf_types_4xx[i] :
+						intbuf_types_1xx[i]);
 		if (ret)
 			goto error;
 	}
@@ -257,12 +273,11 @@ static int load_scale_clocks(struct venus_core *core)
 
 set_freq:
 
-	if (core->res->hfi_version == HFI_VERSION_3XX) {
-		ret = clk_set_rate(clk, freq);
+	ret = clk_set_rate(clk, freq);
+
+	if (IS_V3(core) || IS_V4(core)) {
 		ret |= clk_set_rate(core->core0_clk, freq);
 		ret |= clk_set_rate(core->core1_clk, freq);
-	} else {
-		ret = clk_set_rate(clk, freq);
 	}
 
 	if (ret) {
diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index 55d8eb21403a..1bc5aab1ce6b 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -121,6 +121,7 @@
 #define HFI_EXTRADATA_METADATA_FILLER			0x7fe00002
 
 #define HFI_INDEX_EXTRADATA_INPUT_CROP			0x0700000e
+#define HFI_INDEX_EXTRADATA_OUTPUT_CROP			0x0700000f
 #define HFI_INDEX_EXTRADATA_DIGITAL_ZOOM		0x07000010
 #define HFI_INDEX_EXTRADATA_ASPECT_RATIO		0x7f100003
 
@@ -376,13 +377,18 @@
 #define HFI_BUFFER_OUTPUT2			0x3
 #define HFI_BUFFER_INTERNAL_PERSIST		0x4
 #define HFI_BUFFER_INTERNAL_PERSIST_1		0x5
-#define HFI_BUFFER_INTERNAL_SCRATCH		0x1000001
-#define HFI_BUFFER_EXTRADATA_INPUT		0x1000002
-#define HFI_BUFFER_EXTRADATA_OUTPUT		0x1000003
-#define HFI_BUFFER_EXTRADATA_OUTPUT2		0x1000004
-#define HFI_BUFFER_INTERNAL_SCRATCH_1		0x1000005
-#define HFI_BUFFER_INTERNAL_SCRATCH_2		0x1000006
-
+#define HFI_BUFFER_INTERNAL_SCRATCH(ver)	\
+	(((ver) == HFI_VERSION_4XX) ? 0x6 : 0x1000001)
+#define HFI_BUFFER_INTERNAL_SCRATCH_1(ver)	\
+	(((ver) == HFI_VERSION_4XX) ? 0x7 : 0x1000005)
+#define HFI_BUFFER_INTERNAL_SCRATCH_2(ver)	\
+	(((ver) == HFI_VERSION_4XX) ? 0x8 : 0x1000006)
+#define HFI_BUFFER_EXTRADATA_INPUT(ver)		\
+	(((ver) == HFI_VERSION_4XX) ? 0xc : 0x1000002)
+#define HFI_BUFFER_EXTRADATA_OUTPUT(ver)	\
+	(((ver) == HFI_VERSION_4XX) ? 0xa : 0x1000003)
+#define HFI_BUFFER_EXTRADATA_OUTPUT2(ver)	\
+	(((ver) == HFI_VERSION_4XX) ? 0xb : 0x1000004)
 #define HFI_BUFFER_TYPE_MAX			11
 
 #define HFI_BUFFER_MODE_STATIC			0x1000001
@@ -424,12 +430,14 @@
 #define HFI_PROPERTY_PARAM_CODEC_MASK_SUPPORTED			0x100e
 #define HFI_PROPERTY_PARAM_MVC_BUFFER_LAYOUT			0x100f
 #define HFI_PROPERTY_PARAM_MAX_SESSIONS_SUPPORTED		0x1010
+#define HFI_PROPERTY_PARAM_WORK_MODE				0x1015
 
 /*
  * HFI_PROPERTY_CONFIG_COMMON_START
  * HFI_DOMAIN_BASE_COMMON + HFI_ARCH_COMMON_OFFSET + 0x2000
  */
 #define HFI_PROPERTY_CONFIG_FRAME_RATE				0x2001
+#define HFI_PROPERTY_CONFIG_VIDEOCORES_USAGE			0x2002
 
 /*
  * HFI_PROPERTY_PARAM_VDEC_COMMON_START
@@ -438,6 +446,9 @@
 #define HFI_PROPERTY_PARAM_VDEC_MULTI_STREAM			0x1003001
 #define HFI_PROPERTY_PARAM_VDEC_CONCEAL_COLOR			0x1003002
 #define HFI_PROPERTY_PARAM_VDEC_NONCP_OUTPUT2			0x1003003
+#define HFI_PROPERTY_PARAM_VDEC_PIXEL_BITDEPTH			0x1003007
+#define HFI_PROPERTY_PARAM_VDEC_PIC_STRUCT			0x1003009
+#define HFI_PROPERTY_PARAM_VDEC_COLOUR_SPACE			0x100300a
 
 /*
  * HFI_PROPERTY_CONFIG_VDEC_COMMON_START
@@ -518,6 +529,7 @@
 enum hfi_version {
 	HFI_VERSION_1XX,
 	HFI_VERSION_3XX,
+	HFI_VERSION_4XX
 };
 
 struct hfi_buffer_info {
@@ -767,12 +779,56 @@ struct hfi_framesize {
 	u32 height;
 };
 
+#define VIDC_CORE_ID_DEFAULT	0
+#define VIDC_CORE_ID_1		1
+#define VIDC_CORE_ID_2		2
+#define VIDC_CORE_ID_3		3
+
+struct hfi_videocores_usage_type {
+	u32 video_core_enable_mask;
+};
+
+#define VIDC_WORK_MODE_1	1
+#define VIDC_WORK_MODE_2	2
+
+struct hfi_video_work_mode {
+	u32 video_work_mode;
+};
+
 struct hfi_h264_vui_timing_info {
 	u32 enable;
 	u32 fixed_framerate;
 	u32 time_scale;
 };
 
+struct hfi_bit_depth {
+	u32 buffer_type;
+	u32 bit_depth;
+};
+
+struct hfi_picture_type {
+	u32 is_sync_frame;
+	u32 picture_type;
+};
+
+struct hfi_pic_struct {
+	u32 progressive_only;
+};
+
+struct hfi_colour_space {
+	u32 colour_space;
+};
+
+struct hfi_extradata_input_crop {
+	u32 size;
+	u32 version;
+	u32 port_index;
+	u32 left;
+	u32 top;
+	u32 width;
+	u32 height;
+};
+
 #define HFI_COLOR_FORMAT_MONOCHROME		0x01
 #define HFI_COLOR_FORMAT_NV12			0x02
 #define HFI_COLOR_FORMAT_NV21			0x03
@@ -961,6 +1017,12 @@ struct hfi_buffer_count_actual {
 	u32 count_actual;
 };
 
+struct hfi_buffer_count_actual_4xx {
+	u32 type;
+	u32 count_actual;
+	u32 count_min_host;
+};
+
 struct hfi_buffer_size_actual {
 	u32 type;
 	u32 size;
@@ -971,6 +1033,14 @@ struct hfi_buffer_display_hold_count_actual {
 	u32 hold_count;
 };
 
+/* HFI 4XX reorder the fields, use these macros */
+#define HFI_BUFREQ_HOLD_COUNT(bufreq, ver)	\
+	((ver) == HFI_VERSION_4XX ? 0 : (bufreq)->hold_count)
+#define HFI_BUFREQ_COUNT_MIN(bufreq, ver)	\
+	((ver) == HFI_VERSION_4XX ? (bufreq)->hold_count : (bufreq)->count_min)
+#define HFI_BUFREQ_COUNT_MIN_HOST(bufreq, ver)	\
+	((ver) == HFI_VERSION_4XX ? (bufreq)->count_min : 0)
+
 struct hfi_buffer_requirements {
 	u32 type;
 	u32 size;
diff --git a/drivers/media/platform/qcom/venus/hfi_venus_io.h b/drivers/media/platform/qcom/venus/hfi_venus_io.h
index 98cc350113ab..d327b5cea334 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus_io.h
+++ b/drivers/media/platform/qcom/venus/hfi_venus_io.h
@@ -110,4 +110,11 @@
 #define WRAPPER_CPU_STATUS			(WRAPPER_BASE + 0x2014)
 #define WRAPPER_SW_RESET			(WRAPPER_BASE + 0x3000)
 
+/* Venus 4xx */
+#define WRAPPER_VCODEC0_MMCC_POWER_STATUS	(WRAPPER_BASE + 0x90)
+#define WRAPPER_VCODEC0_MMCC_POWER_CONTROL	(WRAPPER_BASE + 0x94)
+
+#define WRAPPER_VCODEC1_MMCC_POWER_STATUS	(WRAPPER_BASE + 0x110)
+#define WRAPPER_VCODEC1_MMCC_POWER_CONTROL	(WRAPPER_BASE + 0x114)
+
 #endif
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 49bbd1861d3a..261a51adeef2 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -689,6 +689,7 @@ static int vdec_queue_setup(struct vb2_queue *q,
 
 static int vdec_verify_conf(struct venus_inst *inst)
 {
+	enum hfi_version ver = inst->core->res->hfi_version;
 	struct hfi_buffer_requirements bufreq;
 	int ret;
 
@@ -700,14 +701,14 @@ static int vdec_verify_conf(struct venus_inst *inst)
 		return ret;
 
 	if (inst->num_output_bufs < bufreq.count_actual ||
-	    inst->num_output_bufs < bufreq.count_min)
+	    inst->num_output_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
 		return -EINVAL;
 
 	ret = venus_helper_get_bufreq(inst, HFI_BUFFER_INPUT, &bufreq);
 	if (ret)
 		return ret;
 
-	if (inst->num_input_bufs < bufreq.count_min)
+	if (inst->num_input_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 6b2ce479584e..947001170a77 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -892,6 +892,7 @@ static int venc_queue_setup(struct vb2_queue *q,
 
 static int venc_verify_conf(struct venus_inst *inst)
 {
+	enum hfi_version ver = inst->core->res->hfi_version;
 	struct hfi_buffer_requirements bufreq;
 	int ret;
 
@@ -903,7 +904,7 @@ static int venc_verify_conf(struct venus_inst *inst)
 		return ret;
 
 	if (inst->num_output_bufs < bufreq.count_actual ||
-	    inst->num_output_bufs < bufreq.count_min)
+	    inst->num_output_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
 		return -EINVAL;
 
 	ret = venus_helper_get_bufreq(inst, HFI_BUFFER_INPUT, &bufreq);
@@ -911,7 +912,7 @@ static int venc_verify_conf(struct venus_inst *inst)
 		return ret;
 
 	if (inst->num_input_bufs < bufreq.count_actual ||
-	    inst->num_input_bufs < bufreq.count_min)
+	    inst->num_input_bufs < HFI_BUFREQ_COUNT_MIN(&bufreq, ver))
 		return -EINVAL;
 
 	return 0;
-- 
2.14.1

