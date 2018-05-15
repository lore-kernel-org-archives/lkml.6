Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeEOH75 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:59:57 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36849 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752560AbeEOH7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:59:55 -0400
X-Google-Smtp-Source: AB8JxZqUaTO0OUZVRdBLcLvNegOGXGl1jI+TsHeTb5H7eyJjokMABrMTX/t/8xPbFFXlBe9theTLrg==
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 25/29] venus: vdec: new function for output configuration
Date: Tue, 15 May 2018 10:58:55 +0300
Message-Id: <20180515075859.17217-26-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180515075859.17217-1-stanimir.varbanov@linaro.org>
References: <20180515075859.17217-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make a new function vdec_output_conf() for decoder output
configuration. vdec_output_conf() will set properties via
HFI interface related to the output configuration, and
keep vdec_set_properties() which will set properties
related to decoding parameters.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 35 ++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 5a5e3e2fece4..3a699af0ab58 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -545,6 +545,23 @@ static const struct v4l2_ioctl_ops vdec_ioctl_ops = {
 static int vdec_set_properties(struct venus_inst *inst)
 {
 	struct vdec_controls *ctr = &inst->controls.dec;
+	struct hfi_enable en = { .enable = 1 };
+	u32 ptype;
+	int ret;
+
+	if (ctr->post_loop_deb_mode) {
+		ptype = HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER;
+		en.enable = 1;
+		ret = hfi_session_set_property(inst, ptype, &en);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int vdec_output_conf(struct venus_inst *inst)
+{
 	struct venus_core *core = inst->core;
 	struct hfi_enable en = { .enable = 1 };
 	u32 ptype;
@@ -569,14 +586,6 @@ static int vdec_set_properties(struct venus_inst *inst)
 	if (ret)
 		return ret;
 
-	if (ctr->post_loop_deb_mode) {
-		ptype = HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER;
-		en.enable = 1;
-		ret = hfi_session_set_property(inst, ptype, &en);
-		if (ret)
-			return ret;
-	}
-
 	return 0;
 }
 
@@ -724,7 +733,6 @@ static int vdec_verify_conf(struct venus_inst *inst)
 static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 {
 	struct venus_inst *inst = vb2_get_drv_priv(q);
-	struct venus_core *core = inst->core;
 	int ret;
 
 	mutex_lock(&inst->lock);
@@ -753,12 +761,9 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 	if (ret)
 		goto deinit_sess;
 
-	if (core->res->hfi_version == HFI_VERSION_3XX) {
-		ret = venus_helper_set_bufsize(inst, inst->output_buf_size,
-					       HFI_BUFFER_OUTPUT);
-		if (ret)
-			goto deinit_sess;
-	}
+	ret = vdec_output_conf(inst);
+	if (ret)
+		goto deinit_sess;
 
 	ret = vdec_verify_conf(inst);
 	if (ret)
-- 
2.14.1
