Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF1AC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754C724090
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IaURN6Rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754C724090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754619AbeGENI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:08:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33761 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754364AbeGENF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id k7-v6so1139336wrq.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s6eEw4UbdmaZpmqddL4ZXrgf6lhtP7B9Q+xVZrUXqY4=;
        b=IaURN6RbJnr2GMMKhrWMGNQnZ5g5nlbItsW3TZfXDzpsCUf12ZKKQXi6Vbho9q8jYz
         xWfoJsLTP9EYwUHgT2pA51llZyDBV01W1JzE0mWjr2PE0e+ps5xx59VxsDsEYYwylc+n
         pO9iZseXRavlF4UHa8WrGI8IDriern4PX0AyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s6eEw4UbdmaZpmqddL4ZXrgf6lhtP7B9Q+xVZrUXqY4=;
        b=sFKiL50Mjt52bNPqvf272I1OP1nluGa3u1h4yg61gIw5z817Ggir6WIP+9sfL16e2M
         EDfBga8rJ4c7t/HxNKwN6WEUKz0ojHi/ty6bvkg9Y9PtQvPTVTBjN8ZYNTXNxWALxL2W
         2YjzVHEBm+JlWgLidxSXATTrao/LTlIaQy2YpO/uEEtj522HW2EXbGhFjcRSg7Lw4fgN
         IV/vmR9JQlne9k8ZFnY99xKVXWVEWsBsEOLvF6pd29G4XCtoiXkO/5+ZiHlzD51t6tBX
         awSceeMFHvv4LUCX43eCK3y4oLLvbiD367ijnB1K383s/b4KTA8DNZ7dhY22mf0C30Co
         315g==
X-Gm-Message-State: APt69E2/bQ8xDujEHxrQaDsftR6hIue2bW9+QAe4IgMjQ55smE3WEUFC
        Slt8KjLwFxbPm9R52/ILn2k9CA==
X-Google-Smtp-Source: AAOMgpeRimNT3CpOFDUZ0rM7KCZ19q4tBO4WXjc/tjd6xiIV9lWcvJ97kHg/NBjsudlYcUDBhBETxg==
X-Received: by 2002:adf:a015:: with SMTP id k21-v6mr4442731wrk.202.1530795928009;
        Thu, 05 Jul 2018 06:05:28 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:27 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 19/27] venus: helpers,vdec,venc: add helpers to set work mode and core usage
Date:   Thu,  5 Jul 2018 16:03:53 +0300
Message-Id: <20180705130401.24315-20-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are new properties applicable to Venus version 4xx. Add the
helpers and call them from decoder and encoder drivers.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 28 ++++++++++++++++++++++++++++
 drivers/media/platform/qcom/venus/helpers.h |  2 ++
 drivers/media/platform/qcom/venus/vdec.c    |  8 ++++++++
 drivers/media/platform/qcom/venus/venc.c    |  8 ++++++++
 4 files changed, 46 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 4e4109e80988..3cd25e25aa70 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -486,6 +486,34 @@ int venus_helper_set_output_resolution(struct venus_inst *inst,
 }
 EXPORT_SYMBOL_GPL(venus_helper_set_output_resolution);
 
+int venus_helper_set_work_mode(struct venus_inst *inst, u32 mode)
+{
+	const u32 ptype = HFI_PROPERTY_PARAM_WORK_MODE;
+	struct hfi_video_work_mode wm;
+
+	if (!IS_V4(inst->core))
+		return 0;
+
+	wm.video_work_mode = mode;
+
+	return hfi_session_set_property(inst, ptype, &wm);
+}
+EXPORT_SYMBOL_GPL(venus_helper_set_work_mode);
+
+int venus_helper_set_core_usage(struct venus_inst *inst, u32 usage)
+{
+	const u32 ptype = HFI_PROPERTY_CONFIG_VIDEOCORES_USAGE;
+	struct hfi_videocores_usage_type cu;
+
+	if (!IS_V4(inst->core))
+		return 0;
+
+	cu.video_core_enable_mask = usage;
+
+	return hfi_session_set_property(inst, ptype, &cu);
+}
+EXPORT_SYMBOL_GPL(venus_helper_set_core_usage);
+
 int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 			      unsigned int output_bufs)
 {
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index 79af7845efbd..d5e727e1ecab 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -38,6 +38,8 @@ int venus_helper_set_input_resolution(struct venus_inst *inst,
 int venus_helper_set_output_resolution(struct venus_inst *inst,
 				       unsigned int width, unsigned int height,
 				       u32 buftype);
+int venus_helper_set_work_mode(struct venus_inst *inst, u32 mode);
+int venus_helper_set_core_usage(struct venus_inst *inst, u32 usage);
 int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 			      unsigned int output_bufs);
 int venus_helper_set_raw_format(struct venus_inst *inst, u32 hfi_format,
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index d2a53c0eab86..75f622c73222 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -550,6 +550,14 @@ static int vdec_set_properties(struct venus_inst *inst)
 	u32 ptype;
 	int ret;
 
+	ret = venus_helper_set_work_mode(inst, VIDC_WORK_MODE_2);
+	if (ret)
+		return ret;
+
+	ret = venus_helper_set_core_usage(inst, VIDC_CORE_ID_1);
+	if (ret)
+		return ret;
+
 	if (core->res->hfi_version == HFI_VERSION_1XX) {
 		ptype = HFI_PROPERTY_PARAM_VDEC_CONTINUE_DATA_TRANSFER;
 		ret = hfi_session_set_property(inst, ptype, &en);
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 650e6b0a01d2..6dc153f16d88 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -643,6 +643,14 @@ static int venc_set_properties(struct venus_inst *inst)
 	u32 ptype, rate_control, bitrate, profile = 0, level = 0;
 	int ret;
 
+	ret = venus_helper_set_work_mode(inst, VIDC_WORK_MODE_2);
+	if (ret)
+		return ret;
+
+	ret = venus_helper_set_core_usage(inst, VIDC_CORE_ID_2);
+	if (ret)
+		return ret;
+
 	ptype = HFI_PROPERTY_CONFIG_FRAME_RATE;
 	frate.buffer_type = HFI_BUFFER_OUTPUT;
 	frate.framerate = inst->fps * (1 << 16);
-- 
2.14.1

