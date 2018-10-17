Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACB4ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F9621523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SkUeSg+W";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FVrjd+Th"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F9621523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeJQVO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:14:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37480 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeJQVO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:14:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5AA0D60A34; Wed, 17 Oct 2018 13:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539782327;
        bh=au+DdCLnjRnVoVQ1LSmOAwNGCxOeoC4eB7lxO6mPKQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SkUeSg+WaZ1sxLRqvTNKy92efRiAG0KRMFCmAeMb57IjlmKeGmEXjmzWsUxzcw1my
         FYhCQ1DRhinykx6P4sShpWVmqR3JD9YdbejB4ZTSFAqnKW4voQ6YBX1CNbrnJw5woc
         aDQwqwhi+w0a+pcPMX/7tu1T9hGbABvT8iHY0tTU=
Received: from vgarodia-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B90861313;
        Wed, 17 Oct 2018 13:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539782326;
        bh=au+DdCLnjRnVoVQ1LSmOAwNGCxOeoC4eB7lxO6mPKQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVrjd+ThuitP/KDvSanbXuD6+R6n3sq2KJQwu0eoOVBwUB4QsIKdMHFe6g9bJtEdi
         4feh3oQGKuGfMj1eTfFxXyA7lZ+mroDeV5VDH/aC+VqNeiAeAOY4Ir1elOtZfYM345
         eteUJtwcWkDL3DpZw2q3wgWzdVJx7SvAKLsGNgzM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B90861313
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vgarodia@codeaurora.org
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
Subject: [PATCH v12 2/5] venus: firmware: move load firmware in a separate function
Date:   Wed, 17 Oct 2018 18:48:20 +0530
Message-Id: <1539782303-4091-3-git-send-email-vgarodia@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539782303-4091-1-git-send-email-vgarodia@codeaurora.org>
References: <1539782303-4091-1-git-send-email-vgarodia@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate firmware loading part into a new function.

Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
---
 drivers/media/platform/qcom/venus/core.c     |  4 +-
 drivers/media/platform/qcom/venus/firmware.c | 55 ++++++++++++++++++----------
 drivers/media/platform/qcom/venus/firmware.h |  2 +-
 3 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index bb6add9..75b9785 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -84,7 +84,7 @@ static void venus_sys_error_handler(struct work_struct *work)
 
 	pm_runtime_get_sync(core->dev);
 
-	ret |= venus_boot(core->dev, core->res->fwname);
+	ret |= venus_boot(core);
 
 	ret |= hfi_core_resume(core, true);
 
@@ -284,7 +284,7 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_runtime_disable;
 
-	ret = venus_boot(dev, core->res->fwname);
+	ret = venus_boot(core);
 	if (ret)
 		goto err_runtime_disable;
 
diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 0e21a90..1d4f066 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -60,20 +60,18 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
 	return 0;
 }
 
-int venus_boot(struct device *dev, const char *fwname)
+static int venus_load_fw(struct venus_core *core, const char *fwname,
+			 phys_addr_t *mem_phys, size_t *mem_size)
 {
 	const struct firmware *mdt;
 	struct device_node *node;
-	phys_addr_t mem_phys;
+	struct device *dev;
 	struct resource r;
 	ssize_t fw_size;
-	size_t mem_size;
 	void *mem_va;
 	int ret;
 
-	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) || !qcom_scm_is_available())
-		return -EPROBE_DEFER;
-
+	dev = core->dev;
 	node = of_parse_phandle(dev->of_node, "memory-region", 0);
 	if (!node) {
 		dev_err(dev, "no memory-region specified\n");
@@ -84,16 +82,16 @@ int venus_boot(struct device *dev, const char *fwname)
 	if (ret)
 		return ret;
 
-	mem_phys = r.start;
-	mem_size = resource_size(&r);
+	*mem_phys = r.start;
+	*mem_size = resource_size(&r);
 
-	if (mem_size < VENUS_FW_MEM_SIZE)
+	if (*mem_size < VENUS_FW_MEM_SIZE)
 		return -EINVAL;
 
-	mem_va = memremap(r.start, mem_size, MEMREMAP_WC);
+	mem_va = memremap(r.start, *mem_size, MEMREMAP_WC);
 	if (!mem_va) {
 		dev_err(dev, "unable to map memory region: %pa+%zx\n",
-			&r.start, mem_size);
+			&r.start, *mem_size);
 		return -ENOMEM;
 	}
 
@@ -108,23 +106,40 @@ int venus_boot(struct device *dev, const char *fwname)
 		goto err_unmap;
 	}
 
-	ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID, mem_va, mem_phys,
-			    mem_size, NULL);
+	if (core->use_tz)
+		ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID,
+				    mem_va, *mem_phys, *mem_size, NULL);
+	else
+		ret = qcom_mdt_load_no_init(dev, mdt, fwname, VENUS_PAS_ID,
+					    mem_va, *mem_phys, *mem_size, NULL);
 
 	release_firmware(mdt);
 
-	if (ret)
-		goto err_unmap;
-
-	ret = qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
-	if (ret)
-		goto err_unmap;
-
 err_unmap:
 	memunmap(mem_va);
 	return ret;
 }
 
+int venus_boot(struct venus_core *core)
+{
+	struct device *dev = core->dev;
+	phys_addr_t mem_phys;
+	size_t mem_size;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
+	    (core->use_tz && !qcom_scm_is_available()))
+		return -EPROBE_DEFER;
+
+	ret = venus_load_fw(core, core->res->fwname, &mem_phys, &mem_size);
+	if (ret) {
+		dev_err(dev, "fail to load video firmware\n");
+		return -EINVAL;
+	}
+
+	return qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
+}
+
 int venus_shutdown(struct device *dev)
 {
 	return qcom_scm_pas_shutdown(VENUS_PAS_ID);
diff --git a/drivers/media/platform/qcom/venus/firmware.h b/drivers/media/platform/qcom/venus/firmware.h
index 397570c..1343747 100644
--- a/drivers/media/platform/qcom/venus/firmware.h
+++ b/drivers/media/platform/qcom/venus/firmware.h
@@ -16,7 +16,7 @@
 
 struct device;
 
-int venus_boot(struct device *dev, const char *fwname);
+int venus_boot(struct venus_core *core);
 int venus_shutdown(struct device *dev);
 int venus_set_hw_state(struct venus_core *core, bool suspend);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

