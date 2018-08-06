Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171BCC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6AF20862
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PpifKeFS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O5iEc7Mw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6AF20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbeHFPhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:37:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55218 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbeHFPhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:37:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D57FF60B73; Mon,  6 Aug 2018 13:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533562116;
        bh=J7OGG7LL9qh/ZRGUOmkWwk6wv8rII3hDWn3YZMx6a+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PpifKeFSzQiEMPVsqUGj30Gadr93JOaJA/dI3J5YguZEi2BbDE6OuMq8ewnVD5Wnl
         LGCQsnedi8p0NLNsPeoD+O8oIMws8HGpLImT9FJ1h4v+xk8apsK8j/BvAvG5cLy/8g
         2RBpqO/TwThXvWPi6Ws3X7QLXu7leA0VH8w9k37w=
Received: from vgarodia-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7401260AD8;
        Mon,  6 Aug 2018 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533562115;
        bh=J7OGG7LL9qh/ZRGUOmkWwk6wv8rII3hDWn3YZMx6a+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O5iEc7Mwa6wqtjnurKNj6Pw/BSftY6H1T8w4flksWToUeYWs5ujnE6iK7+c+vx8oG
         c6i6qBac1uV9MDxhuTU1cuRw/5nOZAhqvA4pioV6pLlttn09AiRd/3OisVbTltIpMs
         Sz5sIgJPBMIx7EJWWTs4RFNuDo1O2ItmMXlTOgWQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7401260AD8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vgarodia@codeaurora.org
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
Subject: [PATCH v4 3/4] venus: firmware: add no TZ boot and shutdown routine
Date:   Mon,  6 Aug 2018 18:58:04 +0530
Message-Id: <1533562085-8773-4-git-send-email-vgarodia@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533562085-8773-1-git-send-email-vgarodia@codeaurora.org>
References: <1533562085-8773-1-git-send-email-vgarodia@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Video hardware is mainly comprised of vcodec subsystem and video
control subsystem. Video control has ARM9 which executes the video
firmware instructions whereas vcodec does the video frame processing.
This change adds support to load the video firmware and bring ARM9
out of reset for platforms which does not have trustzone.

Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
---
 drivers/media/platform/qcom/venus/core.c         |  6 +-
 drivers/media/platform/qcom/venus/core.h         |  6 ++
 drivers/media/platform/qcom/venus/firmware.c     | 91 +++++++++++++++++++++++-
 drivers/media/platform/qcom/venus/firmware.h     |  2 +-
 drivers/media/platform/qcom/venus/hfi_venus_io.h |  1 +
 5 files changed, 99 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 75b9785..393994e 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -76,7 +76,7 @@ static void venus_sys_error_handler(struct work_struct *work)
 	hfi_core_deinit(core, true);
 	hfi_destroy(core);
 	mutex_lock(&core->lock);
-	venus_shutdown(core->dev);
+	venus_shutdown(core);
 
 	pm_runtime_put_sync(core->dev);
 
@@ -323,7 +323,7 @@ static int venus_probe(struct platform_device *pdev)
 err_core_deinit:
 	hfi_core_deinit(core, false);
 err_venus_shutdown:
-	venus_shutdown(dev);
+	venus_shutdown(core);
 err_runtime_disable:
 	pm_runtime_set_suspended(dev);
 	pm_runtime_disable(dev);
@@ -344,7 +344,7 @@ static int venus_remove(struct platform_device *pdev)
 	WARN_ON(ret);
 
 	hfi_destroy(core);
-	venus_shutdown(dev);
+	venus_shutdown(core);
 	of_platform_depopulate(dev);
 
 	pm_runtime_put_sync(dev);
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index eb5ee66..8c64177 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -81,6 +81,11 @@ struct venus_caps {
 	bool valid;	/* used only for Venus v1xx */
 };
 
+struct video_firmware {
+	struct device *dev;
+	struct iommu_domain *iommu_domain;
+};
+
 /**
  * struct venus_core - holds core parameters valid for all instances
  *
@@ -129,6 +134,7 @@ struct venus_core {
 	struct device *dev;
 	struct device *dev_dec;
 	struct device *dev_enc;
+	struct video_firmware fw;
 	bool no_tz;
 	struct mutex lock;
 	struct list_head instances;
diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 4577043..30130d4 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -12,8 +12,10 @@
  *
  */
 
+#include <linux/platform_device.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
+#include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -118,6 +120,76 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
 	return ret;
 }
 
+static int venus_boot_no_tz(struct venus_core *core, phys_addr_t mem_phys,
+			size_t mem_size)
+{
+	struct iommu_domain *iommu_dom;
+	struct device *dev;
+	int ret;
+
+	dev = core->fw.dev;
+	if (!dev)
+		return -EPROBE_DEFER;
+
+	iommu_dom = iommu_domain_alloc(&platform_bus_type);
+	if (!iommu_dom) {
+		dev_err(dev, "Failed to allocate iommu domain\n");
+		return -ENOMEM;
+	}
+
+	ret = iommu_attach_device(iommu_dom, dev);
+	if (ret) {
+		dev_err(dev, "could not attach device\n");
+		goto err_attach;
+	}
+
+	ret = iommu_map(iommu_dom, VENUS_FW_START_ADDR, mem_phys, mem_size,
+			IOMMU_READ | IOMMU_WRITE | IOMMU_PRIV);
+	if (ret) {
+		dev_err(dev, "could not map video firmware region\n");
+		goto err_map;
+	}
+
+	core->fw.iommu_domain = iommu_dom;
+	venus_reset_cpu(core);
+
+	return 0;
+
+err_map:
+	iommu_detach_device(iommu_dom, dev);
+err_attach:
+	iommu_domain_free(iommu_dom);
+	return ret;
+}
+
+static int venus_shutdown_no_tz(struct venus_core *core)
+{
+	struct iommu_domain *iommu;
+	size_t unmapped = 0;
+	u32 reg;
+	struct device *dev = core->fw.dev;
+	void __iomem *reg_base = core->base;
+
+	/* Assert the reset to ARM9 */
+	reg = readl_relaxed(reg_base + WRAPPER_A9SS_SW_RESET);
+	reg |= WRAPPER_A9SS_SW_RESET_BIT;
+	writel_relaxed(reg, reg_base + WRAPPER_A9SS_SW_RESET);
+
+	/* Make sure reset is asserted before the mapping is removed */
+	mb();
+
+	iommu = core->fw.iommu_domain;
+
+	unmapped = iommu_unmap(iommu, VENUS_FW_START_ADDR, VENUS_FW_MEM_SIZE);
+	if (unmapped != VENUS_FW_MEM_SIZE)
+		dev_err(dev, "failed to unmap firmware\n");
+
+	iommu_detach_device(iommu, dev);
+	iommu_domain_free(iommu);
+
+	return 0;
+}
+
 int venus_boot(struct venus_core *core)
 {
 	phys_addr_t mem_phys;
@@ -134,10 +206,23 @@ int venus_boot(struct venus_core *core)
 		dev_err(dev, "fail to load video firmware\n");
 		return -EINVAL;
 	}
-	return qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
+
+	if (core->no_tz)
+		ret = venus_boot_no_tz(core, mem_phys, mem_size);
+	else
+		ret = qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
+
+	return ret;
 }
 
-int venus_shutdown(struct device *dev)
+int venus_shutdown(struct venus_core *core)
 {
-	return qcom_scm_pas_shutdown(VENUS_PAS_ID);
+	int ret;
+
+	if (core->no_tz)
+		ret = venus_shutdown_no_tz(core);
+	else
+		ret = qcom_scm_pas_shutdown(VENUS_PAS_ID);
+
+	return ret;
 }
diff --git a/drivers/media/platform/qcom/venus/firmware.h b/drivers/media/platform/qcom/venus/firmware.h
index 347a893..8456b59 100644
--- a/drivers/media/platform/qcom/venus/firmware.h
+++ b/drivers/media/platform/qcom/venus/firmware.h
@@ -17,7 +17,7 @@
 struct device;
 
 int venus_boot(struct venus_core *core);
-int venus_shutdown(struct device *dev);
+int venus_shutdown(struct venus_core *core);
 int venus_set_hw_state(struct venus_core *core, bool suspend);
 
 static inline int venus_set_hw_state_suspend(struct venus_core *core)
diff --git a/drivers/media/platform/qcom/venus/hfi_venus_io.h b/drivers/media/platform/qcom/venus/hfi_venus_io.h
index d7f838b..e906491 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus_io.h
+++ b/drivers/media/platform/qcom/venus/hfi_venus_io.h
@@ -117,6 +117,7 @@
 #define WRAPPER_FW_START_ADDR			(WRAPPER_BASE + 0x1028)
 #define WRAPPER_FW_END_ADDR			(WRAPPER_BASE + 0x102C)
 #define WRAPPER_A9SS_SW_RESET			(WRAPPER_BASE + 0x3000)
+#define WRAPPER_A9SS_SW_RESET_BIT		BIT(4)
 
 /* Venus 4xx */
 #define WRAPPER_VCODEC0_MMCC_POWER_STATUS	(WRAPPER_BASE + 0x90)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

