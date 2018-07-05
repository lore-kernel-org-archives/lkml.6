Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C217C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B502924135
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bo4+9xL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B502924135
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754420AbeGENFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:05:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37582 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754364AbeGENFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so1140591wrd.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4LZFZzSH1cRFIf4n3VOHvIhe79lNAPTHETW3VnI/rv4=;
        b=Bo4+9xL91Vm2CkFjAEZIbjab2osn9RgCmHOaB+JWmjs/e/chjsWomctes5hqXI/9ik
         NFLQRfFtMAnPerbZXjZ/F/7gOXLfBkHHaK5r7RmWQy+uTftaTienZVUWwfUiBbYmLXEj
         Bg6yAyKuonMWzABrP1ZoXRguevH+XQs+fRreE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4LZFZzSH1cRFIf4n3VOHvIhe79lNAPTHETW3VnI/rv4=;
        b=FprTjxFprcRih/KcLuxaJDmWkRATyUd0vpXZCUaN+2x0f5qJylntAoX1XqS9j81mvw
         QZt+8OtyGkUCVfzhTEkFkG/ZwLatjrRf9PsgUAJlHP1NNa5DJpkW7HzCEH48I4zxm1oz
         bTFoH5vHDOI/yUsfoXXuHXxmc5H9IU4VO6t/lhF9ekxuQhVxFa0Dv2QDsphDgo40FBUN
         efLDJuwmax3W70bQmSr23/F4e4h0vmscDS3QikN8WKbacTDZ886J3ZMTE3idNTIg5Ch4
         QJfwUGftMRK4XPrObG1SX64zuODrYoShuxhp/IcGpR4r5LGZapdLnmL+gWPZ7sBTv07u
         URCA==
X-Gm-Message-State: APt69E23ELG2ANPKdYR4NR0Rn24Rme1cHFVyb+FjHKZv3KdPVD+X/+p6
        EmYU6mCtgLG0Zggw5xtGzW8yiQEdlLs=
X-Google-Smtp-Source: AAOMgpcBRom8fn29gHCuxKtJl/sD9AhAdbLhhn2l5HD347rDrM32t1YXnd6lLt0EH2Co3Ttmihzowg==
X-Received: by 2002:adf:8895:: with SMTP id f21-v6mr4470733wrf.250.1530795918860;
        Thu, 05 Jul 2018 06:05:18 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:18 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 11/27] venus: core,helpers: add two more clocks found in Venus 4xx
Date:   Thu,  5 Jul 2018 16:03:45 +0300
Message-Id: <20180705130401.24315-12-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two more clocks for Venus 4xx in core structure and create
a new power enable function to handle it for 3xx/4xx versions.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/core.h    |  4 +++
 drivers/media/platform/qcom/venus/helpers.c | 51 +++++++++++++++++++++++++++++
 drivers/media/platform/qcom/venus/helpers.h |  2 ++
 drivers/media/platform/qcom/venus/vdec.c    | 44 ++++++++++++++++++++-----
 drivers/media/platform/qcom/venus/venc.c    | 44 ++++++++++++++++++++-----
 5 files changed, 129 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 8d3e150800c9..2bf8839784fa 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -65,6 +65,8 @@ struct venus_format {
  * @clks:	an array of struct clk pointers
  * @core0_clk:	a struct clk pointer for core0
  * @core1_clk:	a struct clk pointer for core1
+ * @core0_bus_clk: a struct clk pointer for core0 bus clock
+ * @core1_bus_clk: a struct clk pointer for core1 bus clock
  * @vdev_dec:	a reference to video device structure for decoder instances
  * @vdev_enc:	a reference to video device structure for encoder instances
  * @v4l2_dev:	a holder for v4l2 device structure
@@ -94,6 +96,8 @@ struct venus_core {
 	struct clk *clks[VIDC_CLKS_NUM_MAX];
 	struct clk *core0_clk;
 	struct clk *core1_clk;
+	struct clk *core0_bus_clk;
+	struct clk *core1_bus_clk;
 	struct video_device *vdev_dec;
 	struct video_device *vdev_enc;
 	struct v4l2_device v4l2_dev;
diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index a08ecd263e73..c8c4a4be78e3 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -13,6 +13,7 @@
  *
  */
 #include <linux/clk.h>
+#include <linux/iopoll.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
@@ -24,6 +25,7 @@
 #include "core.h"
 #include "helpers.h"
 #include "hfi_helper.h"
+#include "hfi_venus_io.h"
 
 struct intbuf {
 	struct list_head list;
@@ -786,3 +788,52 @@ void venus_helper_init_instance(struct venus_inst *inst)
 	}
 }
 EXPORT_SYMBOL_GPL(venus_helper_init_instance);
+
+int venus_helper_power_enable(struct venus_core *core, u32 session_type,
+			      bool enable)
+{
+	void __iomem *ctrl, *stat;
+	u32 val;
+	int ret;
+
+	if (!IS_V3(core) && !IS_V4(core))
+		return 0;
+
+	if (IS_V3(core)) {
+		if (session_type == VIDC_SESSION_TYPE_DEC)
+			ctrl = core->base + WRAPPER_VDEC_VCODEC_POWER_CONTROL;
+		else
+			ctrl = core->base + WRAPPER_VENC_VCODEC_POWER_CONTROL;
+		if (enable)
+			writel(0, ctrl);
+		else
+			writel(1, ctrl);
+
+		return 0;
+	}
+
+	if (session_type == VIDC_SESSION_TYPE_DEC) {
+		ctrl = core->base + WRAPPER_VCODEC0_MMCC_POWER_CONTROL;
+		stat = core->base + WRAPPER_VCODEC0_MMCC_POWER_STATUS;
+	} else {
+		ctrl = core->base + WRAPPER_VCODEC1_MMCC_POWER_CONTROL;
+		stat = core->base + WRAPPER_VCODEC1_MMCC_POWER_STATUS;
+	}
+
+	if (enable) {
+		writel(0, ctrl);
+
+		ret = readl_poll_timeout(stat, val, val & BIT(1), 1, 100);
+		if (ret)
+			return ret;
+	} else {
+		writel(1, ctrl);
+
+		ret = readl_poll_timeout(stat, val, !(val & BIT(1)), 1, 100);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(venus_helper_power_enable);
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index 971392be5df5..0e64aa95624a 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -43,4 +43,6 @@ int venus_helper_set_color_format(struct venus_inst *inst, u32 fmt);
 void venus_helper_acquire_buf_ref(struct vb2_v4l2_buffer *vbuf);
 void venus_helper_release_buf_ref(struct venus_inst *inst, unsigned int idx);
 void venus_helper_init_instance(struct venus_inst *inst);
+int venus_helper_power_enable(struct venus_core *core, u32 session_type,
+			      bool enable);
 #endif
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 261a51adeef2..d22969d2758a 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1081,12 +1081,18 @@ static int vdec_probe(struct platform_device *pdev)
 	if (!core)
 		return -EPROBE_DEFER;
 
-	if (core->res->hfi_version == HFI_VERSION_3XX) {
+	if (IS_V3(core) || IS_V4(core)) {
 		core->core0_clk = devm_clk_get(dev, "core");
 		if (IS_ERR(core->core0_clk))
 			return PTR_ERR(core->core0_clk);
 	}
 
+	if (IS_V4(core)) {
+		core->core0_bus_clk = devm_clk_get(dev, "bus");
+		if (IS_ERR(core->core0_bus_clk))
+			return PTR_ERR(core->core0_bus_clk);
+	}
+
 	platform_set_drvdata(pdev, core);
 
 	vdev = video_device_alloc();
@@ -1131,15 +1137,21 @@ static int vdec_remove(struct platform_device *pdev)
 static __maybe_unused int vdec_runtime_suspend(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
+	int ret;
 
-	if (core->res->hfi_version == HFI_VERSION_1XX)
+	if (IS_V1(core))
 		return 0;
 
-	writel(0, core->base + WRAPPER_VDEC_VCODEC_POWER_CONTROL);
+	ret = venus_helper_power_enable(core, VIDC_SESSION_TYPE_DEC, true);
+	if (ret)
+		return ret;
+
+	if (IS_V4(core))
+		clk_disable_unprepare(core->core0_bus_clk);
+
 	clk_disable_unprepare(core->core0_clk);
-	writel(1, core->base + WRAPPER_VDEC_VCODEC_POWER_CONTROL);
 
-	return 0;
+	return venus_helper_power_enable(core, VIDC_SESSION_TYPE_DEC, false);
 }
 
 static __maybe_unused int vdec_runtime_resume(struct device *dev)
@@ -1147,13 +1159,29 @@ static __maybe_unused int vdec_runtime_resume(struct device *dev)
 	struct venus_core *core = dev_get_drvdata(dev);
 	int ret;
 
-	if (core->res->hfi_version == HFI_VERSION_1XX)
+	if (IS_V1(core))
 		return 0;
 
-	writel(0, core->base + WRAPPER_VDEC_VCODEC_POWER_CONTROL);
+	ret = venus_helper_power_enable(core, VIDC_SESSION_TYPE_DEC, true);
+	if (ret)
+		return ret;
+
 	ret = clk_prepare_enable(core->core0_clk);
-	writel(1, core->base + WRAPPER_VDEC_VCODEC_POWER_CONTROL);
+	if (ret)
+		goto err_power_disable;
+
+	if (IS_V4(core))
+		ret = clk_prepare_enable(core->core0_bus_clk);
 
+	if (ret)
+		goto err_unprepare_core0;
+
+	return venus_helper_power_enable(core, VIDC_SESSION_TYPE_DEC, false);
+
+err_unprepare_core0:
+	clk_disable_unprepare(core->core0_clk);
+err_power_disable:
+	venus_helper_power_enable(core, VIDC_SESSION_TYPE_DEC, false);
 	return ret;
 }
 
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 947001170a77..596539d433c9 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -1225,12 +1225,18 @@ static int venc_probe(struct platform_device *pdev)
 	if (!core)
 		return -EPROBE_DEFER;
 
-	if (core->res->hfi_version == HFI_VERSION_3XX) {
+	if (IS_V3(core) || IS_V4(core)) {
 		core->core1_clk = devm_clk_get(dev, "core");
 		if (IS_ERR(core->core1_clk))
 			return PTR_ERR(core->core1_clk);
 	}
 
+	if (IS_V4(core)) {
+		core->core1_bus_clk = devm_clk_get(dev, "bus");
+		if (IS_ERR(core->core1_bus_clk))
+			return PTR_ERR(core->core1_bus_clk);
+	}
+
 	platform_set_drvdata(pdev, core);
 
 	vdev = video_device_alloc();
@@ -1275,15 +1281,21 @@ static int venc_remove(struct platform_device *pdev)
 static __maybe_unused int venc_runtime_suspend(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
+	int ret;
 
-	if (core->res->hfi_version == HFI_VERSION_1XX)
+	if (IS_V1(core))
 		return 0;
 
-	writel(0, core->base + WRAPPER_VENC_VCODEC_POWER_CONTROL);
+	ret = venus_helper_power_enable(core, VIDC_SESSION_TYPE_ENC, true);
+	if (ret)
+		return ret;
+
+	if (IS_V4(core))
+		clk_disable_unprepare(core->core1_bus_clk);
+
 	clk_disable_unprepare(core->core1_clk);
-	writel(1, core->base + WRAPPER_VENC_VCODEC_POWER_CONTROL);
 
-	return 0;
+	return venus_helper_power_enable(core, VIDC_SESSION_TYPE_ENC, false);
 }
 
 static __maybe_unused int venc_runtime_resume(struct device *dev)
@@ -1291,13 +1303,29 @@ static __maybe_unused int venc_runtime_resume(struct device *dev)
 	struct venus_core *core = dev_get_drvdata(dev);
 	int ret;
 
-	if (core->res->hfi_version == HFI_VERSION_1XX)
+	if (IS_V1(core))
 		return 0;
 
-	writel(0, core->base + WRAPPER_VENC_VCODEC_POWER_CONTROL);
+	ret = venus_helper_power_enable(core, VIDC_SESSION_TYPE_ENC, true);
+	if (ret)
+		return ret;
+
 	ret = clk_prepare_enable(core->core1_clk);
-	writel(1, core->base + WRAPPER_VENC_VCODEC_POWER_CONTROL);
+	if (ret)
+		goto err_power_disable;
+
+	if (IS_V4(core))
+		ret = clk_prepare_enable(core->core1_bus_clk);
 
+	if (ret)
+		goto err_unprepare_core1;
+
+	return venus_helper_power_enable(core, VIDC_SESSION_TYPE_ENC, false);
+
+err_unprepare_core1:
+	clk_disable_unprepare(core->core1_clk);
+err_power_disable:
+	venus_helper_power_enable(core, VIDC_SESSION_TYPE_ENC, false);
 	return ret;
 }
 
-- 
2.14.1

