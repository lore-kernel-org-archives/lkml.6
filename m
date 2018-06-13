Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 81156C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D951208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H7f/O1Ds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D951208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964898AbeFMPMG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:12:06 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43111 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964844AbeFMPJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:37 -0400
Received: by mail-wr0-f194.google.com with SMTP id d2-v6so3128877wrm.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ohBxby42Vxzlh/dYlM+pRHCgvQbfNHDMttBaQvAQZWk=;
        b=H7f/O1Dst8IxOrlnNncGoCWuFd2oJBWShALTTD/eyJOH8rlaGkoKD9oXT1vxdtVA8P
         Ja7WZ9EaCn27fTrPCuB3jvCk6xwTkXWY8/bhXRcxyDuiWjqlcFdimUoNCkIqk2ReR2Xw
         /Ku73REc5Sf2G4D8XoIrEYA/4RdP1SkWQucIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ohBxby42Vxzlh/dYlM+pRHCgvQbfNHDMttBaQvAQZWk=;
        b=c3whar/dU5OzHENpRKjKELRRzpQJubDleOwvM1N8ESsTvgKmufZgxC+wd03P0M2bu2
         YHciA3truF8XWvXAScN8mVbfP28qlRP8HsQoflcamk6p5nDmrtyC6BBz5xWAmLe43FKc
         DqcZztuX8gmzHnxI0ApzPk2koWX8Eiag5frGUeZ07U0sAfIRrqaOy4V1E/Hn8Mk9n6n9
         U5MdKN+uXuCp4pJC1iWCf00HPekqR5cAwC61iYk7ZP8yzR2NhqEu7gDHlsKk12AJOgZe
         zBfosBbCyNlYvVl2IBrW0OtjbRmfZQcl/ifJ2r0lSNIfn2pXXa9VTgAI8oDBFGKff+Go
         862g==
X-Gm-Message-State: APt69E1kpARxpqeAOHl9i3Vcx2mx5z9URJb+VhQgKNwDj05pptfj2WAI
        vJ3dHQdashLDFV/3u9jrBDA6DA==
X-Google-Smtp-Source: ADUXVKKI3/pY4hkAeZjmuSflHuyCclIuBU6Vg/jYC82fTv/0guJ4eaq1NJ74/wvDhCXinLycBa+uuA==
X-Received: by 2002:adf:f712:: with SMTP id r18-v6mr4847201wrp.85.1528902575794;
        Wed, 13 Jun 2018 08:09:35 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:35 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 20/27] venus: helpers: extend set_num_bufs helper with one more argument
Date:   Wed, 13 Jun 2018 18:07:54 +0300
Message-Id: <20180613150801.11702-21-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend venus_helper_set_num_bufs() helper function with one more
argument to set number of output buffers for the secondary decoder
output.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 16 ++++++++++++++--
 drivers/media/platform/qcom/venus/helpers.h |  3 ++-
 drivers/media/platform/qcom/venus/vdec.c    |  2 +-
 drivers/media/platform/qcom/venus/venc.c    |  2 +-
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 2295cca3c22a..e332c9682b9c 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -510,7 +510,8 @@ int venus_helper_set_core_usage(struct venus_inst *inst, u32 usage)
 EXPORT_SYMBOL_GPL(venus_helper_set_core_usage);
 
 int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
-			      unsigned int output_bufs)
+			      unsigned int output_bufs,
+			      unsigned int output2_bufs)
 {
 	u32 ptype = HFI_PROPERTY_PARAM_BUFFER_COUNT_ACTUAL;
 	struct hfi_buffer_count_actual buf_count;
@@ -526,7 +527,18 @@ int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 	buf_count.type = HFI_BUFFER_OUTPUT;
 	buf_count.count_actual = output_bufs;
 
-	return hfi_session_set_property(inst, ptype, &buf_count);
+	ret = hfi_session_set_property(inst, ptype, &buf_count);
+	if (ret)
+		return ret;
+
+	if (output2_bufs) {
+		buf_count.type = HFI_BUFFER_OUTPUT2;
+		buf_count.count_actual = output2_bufs;
+
+		ret = hfi_session_set_property(inst, ptype, &buf_count);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(venus_helper_set_num_bufs);
 
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index d5e727e1ecab..8ff4bd3ef958 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -41,7 +41,8 @@ int venus_helper_set_output_resolution(struct venus_inst *inst,
 int venus_helper_set_work_mode(struct venus_inst *inst, u32 mode);
 int venus_helper_set_core_usage(struct venus_inst *inst, u32 usage);
 int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
-			      unsigned int output_bufs);
+			      unsigned int output_bufs,
+			      unsigned int output2_bufs);
 int venus_helper_set_raw_format(struct venus_inst *inst, u32 hfi_format,
 				u32 buftype);
 int venus_helper_set_color_format(struct venus_inst *inst, u32 fmt);
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index f1cf4678d013..5d8bf288bd2a 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -758,7 +758,7 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 		goto deinit_sess;
 
 	ret = venus_helper_set_num_bufs(inst, inst->num_input_bufs,
-					VB2_MAX_FRAME);
+					VB2_MAX_FRAME, VB2_MAX_FRAME);
 	if (ret)
 		goto deinit_sess;
 
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 4f0a5daa97e2..abde7d6d123f 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -963,7 +963,7 @@ static int venc_start_streaming(struct vb2_queue *q, unsigned int count)
 		goto deinit_sess;
 
 	ret = venus_helper_set_num_bufs(inst, inst->num_input_bufs,
-					inst->num_output_bufs);
+					inst->num_output_bufs, 0);
 	if (ret)
 		goto deinit_sess;
 
-- 
2.14.1

