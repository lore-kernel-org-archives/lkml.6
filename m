Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78689C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F2E2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F2E2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeJIPPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:15:25 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:33323 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbeJIPPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:15:25 -0400
X-IronPort-AV: E=Sophos;i="5.54,359,1534789800"; 
   d="scan'208";a="240318"
Received: from ironmsg03-blr.qualcomm.com ([10.86.208.132])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Oct 2018 13:20:32 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9040"; a="1605164"
Received: from mgottam-linux.qualcomm.com ([10.204.66.66])
  by ironmsg03-blr.qualcomm.com with ESMTP; 09 Oct 2018 13:20:30 +0530
Received: by mgottam-linux.qualcomm.com (Postfix, from userid 2305155)
        id 5800B2E3B; Tue,  9 Oct 2018 13:20:29 +0530 (IST)
From:   Malathi Gottam <mgottam@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org, mgottam@codeaurora.org
Subject: [PATCH] media: venus: queue initial buffers
Date:   Tue,  9 Oct 2018 13:20:26 +0530
Message-Id: <1539071426-1282-1-git-send-email-mgottam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buffers can be queued to driver before the planes are
set to start streaming. Queue those buffers to firmware
once start streaming is called on both the planes.

Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 22 ++++++++++++++++++++++
 drivers/media/platform/qcom/venus/helpers.h |  1 +
 drivers/media/platform/qcom/venus/venc.c    |  5 +++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index e436385..2679adb 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -1041,6 +1041,28 @@ void venus_helper_vb2_stop_streaming(struct vb2_queue *q)
 }
 EXPORT_SYMBOL_GPL(venus_helper_vb2_stop_streaming);
 
+int venus_helper_queue_initial_bufs(struct venus_inst *inst)
+{
+	struct v4l2_m2m_ctx *m2m_ctx = inst->m2m_ctx;
+	struct v4l2_m2m_buffer *buf, *n;
+	int ret;
+
+	v4l2_m2m_for_each_dst_buf_safe(m2m_ctx, buf, n)	{
+		ret = session_process_buf(inst, &buf->vb);
+		if (ret)
+			return_buf_error(inst, &buf->vb);
+	}
+
+	v4l2_m2m_for_each_src_buf_safe(m2m_ctx, buf, n) {
+		ret = session_process_buf(inst, &buf->vb);
+		if (ret)
+			return_buf_error(inst, &buf->vb);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(venus_helper_queue_initial_bufs);
+
 int venus_helper_vb2_start_streaming(struct venus_inst *inst)
 {
 	struct venus_core *core = inst->core;
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index 2475f284..f4d76ab 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -31,6 +31,7 @@ void venus_helper_buffers_done(struct venus_inst *inst,
 int venus_helper_vb2_start_streaming(struct venus_inst *inst);
 void venus_helper_m2m_device_run(void *priv);
 void venus_helper_m2m_job_abort(void *priv);
+int venus_helper_queue_initial_bufs(struct venus_inst *inst);
 int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
 			    struct hfi_buffer_requirements *req);
 u32 venus_helper_get_framesz_raw(u32 hfi_fmt, u32 width, u32 height);
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index ce85962..ef11495 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -989,6 +989,11 @@ static int venc_start_streaming(struct vb2_queue *q, unsigned int count)
 	if (ret)
 		goto deinit_sess;
 
+	ret = venus_helper_queue_initial_bufs(inst);
+	if (ret)
+		goto deinit_sess;
+	}
+
 	mutex_unlock(&inst->lock);
 
 	return 0;
-- 
1.9.1

