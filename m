Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37571C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BCA2412B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5Lk6Xyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BCA2412B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754430AbeGENFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:05:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42500 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754416AbeGENFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id p1-v6so1140251wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e5wWhN2jYs/ZNqU0dtOSF3cvtPwdzRHe2yaBwOQivks=;
        b=a5Lk6Xyoxppfo7CfNnaBtoSzhiIo6gmq1xYEYzgSXWtGTnAOliaJcK5qU8WhddlDn+
         qFlyBi1Zgpf/6d4yOtxJTxNk8uTIl08Z33KeU+f6MjN5AC5DREG9nyz71uOc0QWrqdeK
         ESaO/R0xhk6vmh/yIf8ys6IGg/zohAKcscJZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e5wWhN2jYs/ZNqU0dtOSF3cvtPwdzRHe2yaBwOQivks=;
        b=tMrCrXka2PYVCi/c3uW4aYYU3RIIjdOvpMJaeAL732UG5BgWuecbb0Yd3MrPrd6g57
         Vzl83chi6CPENV9iEj/loUAnlRtUY8yZOi8y6NIwimv/WCvUE+szu/yeg0zJXlzhdOR6
         eBwi4HafEqZQZ7XfuQ9rVzNdXgMp/Dlu6NQezQxLvYBCE9Qmsh3S9a4hYm/860epZm4E
         ob0mcmpX/e3Ww9bT8UniWWIE2Pwmh1DrBz4NKMzJCvRGfR07PRRg52qkUuNbx8RA/pXH
         +d2mfuQlhVO4keYF6S1dPMfvw5z7N5/YbEAmyn+5hx01d28pknj42bGOtMqMYwAZB5YJ
         szgA==
X-Gm-Message-State: APt69E1W8L88cZjqCbFJo2LzGmyQ4/ZDfw4Fw8LG8FAQtP18EFCQSZlP
        I3KNirDI5gWdagTJI7bx6ZloRREYRl4=
X-Google-Smtp-Source: AAOMgpfCCzZ/PpqtCYyNYAJVrxbNW52+hAD86Ps6Plv+0HS5PHOBJ89PLmr19pNbdf818s0P3umBRg==
X-Received: by 2002:adf:9c12:: with SMTP id f18-v6mr4649973wrc.93.1530795922298;
        Thu, 05 Jul 2018 06:05:22 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:21 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 14/27] venus: helpers: add a helper function to set dynamic buffer mode
Date:   Thu,  5 Jul 2018 16:03:48 +0300
Message-Id: <20180705130401.24315-15-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new helper function to set dynamic buffer mode if it is
supported by current HFI version. The dynamic buffer mode is
set unconditionally for both decoder outputs.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 22 ++++++++++++++++++++++
 drivers/media/platform/qcom/venus/helpers.h |  1 +
 drivers/media/platform/qcom/venus/vdec.c    | 15 +++------------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 27c4a4060c4e..29cc84777125 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -524,6 +524,28 @@ int venus_helper_set_color_format(struct venus_inst *inst, u32 pixfmt)
 }
 EXPORT_SYMBOL_GPL(venus_helper_set_color_format);
 
+int venus_helper_set_dyn_bufmode(struct venus_inst *inst)
+{
+	const u32 ptype = HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE;
+	struct hfi_buffer_alloc_mode mode;
+	int ret;
+
+	if (!is_dynamic_bufmode(inst))
+		return 0;
+
+	mode.type = HFI_BUFFER_OUTPUT;
+	mode.mode = HFI_BUFFER_MODE_DYNAMIC;
+
+	ret = hfi_session_set_property(inst, ptype, &mode);
+	if (ret)
+		return ret;
+
+	mode.type = HFI_BUFFER_OUTPUT2;
+
+	return hfi_session_set_property(inst, ptype, &mode);
+}
+EXPORT_SYMBOL_GPL(venus_helper_set_dyn_bufmode);
+
 static void delayed_process_buf_func(struct work_struct *work)
 {
 	struct venus_buffer *buf, *n;
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index 0e64aa95624a..52b961ed491e 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -40,6 +40,7 @@ int venus_helper_set_output_resolution(struct venus_inst *inst,
 int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 			      unsigned int output_bufs);
 int venus_helper_set_color_format(struct venus_inst *inst, u32 fmt);
+int venus_helper_set_dyn_bufmode(struct venus_inst *inst);
 void venus_helper_acquire_buf_ref(struct vb2_v4l2_buffer *vbuf);
 void venus_helper_release_buf_ref(struct venus_inst *inst, unsigned int idx);
 void venus_helper_init_instance(struct venus_inst *inst);
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 95892090e2f3..c37779d82fec 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -557,18 +557,9 @@ static int vdec_set_properties(struct venus_inst *inst)
 			return ret;
 	}
 
-	if (core->res->hfi_version == HFI_VERSION_3XX ||
-	    inst->cap_bufs_mode_dynamic) {
-		struct hfi_buffer_alloc_mode mode;
-
-		ptype = HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE;
-		mode.type = HFI_BUFFER_OUTPUT;
-		mode.mode = HFI_BUFFER_MODE_DYNAMIC;
-
-		ret = hfi_session_set_property(inst, ptype, &mode);
-		if (ret)
-			return ret;
-	}
+	ret = venus_helper_set_dyn_bufmode(inst);
+	if (ret)
+		return ret;
 
 	if (ctr->post_loop_deb_mode) {
 		ptype = HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER;
-- 
2.14.1

