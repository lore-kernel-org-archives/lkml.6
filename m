Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56163ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1265321523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hUivYby6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g2mccGeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1265321523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeJQVOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:14:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37616 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeJQVOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:14:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EC69D601B4; Wed, 17 Oct 2018 13:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539782334;
        bh=3Pq4zqDqbzzf9vWbDCQURnU0CrbXKmtkHIeV0trTFlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hUivYby64xXMtN2nIeV7XYbf83BNonoxrTXj9nOmhC89UplgX4CDYvu7gytsqY2Cu
         ZKOr6To8ZjWdDMZzmz3Uj0O7GT2w8tuDcLdn1Bcq+aKMaGHtY3wySyNhKmpsEIgWmv
         L6xQGnVxg5uosZrWpMFyleuTGADQNk7on2xlffas=
Received: from vgarodia-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98F9761312;
        Wed, 17 Oct 2018 13:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539782331;
        bh=3Pq4zqDqbzzf9vWbDCQURnU0CrbXKmtkHIeV0trTFlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2mccGeqRU33Wwyfz/1oN73mEXl69JASIljJA76lMwjzGjOOrg6+9ONyRJvqVUvbV
         s5v9gDdwPm6LsdOEcu7W6coafvVkA35YDD7Imdzg9UsjRDUyyeY2YRJMI/v58KFi+S
         LjopUVVVV+P4hWc6Xc/Wa55WVKvrpElou2zmK2BI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98F9761312
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vgarodia@codeaurora.org
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
Subject: [PATCH v12 3/5] venus: firmware: register separate platform_device for firmware loader
Date:   Wed, 17 Oct 2018 18:48:21 +0530
Message-Id: <1539782303-4091-4-git-send-email-vgarodia@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539782303-4091-1-git-send-email-vgarodia@codeaurora.org>
References: <1539782303-4091-1-git-send-email-vgarodia@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanimir Varbanov <stanimir.varbanov@linaro.org>

This registers a firmware platform_device and associate it with
video-firmware DT subnode. Then calls dma configure to initialize
dma and iommu.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c     | 14 +++++--
 drivers/media/platform/qcom/venus/core.h     |  3 ++
 drivers/media/platform/qcom/venus/firmware.c | 55 ++++++++++++++++++++++++++++
 drivers/media/platform/qcom/venus/firmware.h |  2 +
 4 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 75b9785..440f25f 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -284,6 +284,14 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_runtime_disable;
 
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret)
+		goto err_runtime_disable;
+
+	ret = venus_firmware_init(core);
+	if (ret)
+		goto err_runtime_disable;
+
 	ret = venus_boot(core);
 	if (ret)
 		goto err_runtime_disable;
@@ -308,10 +316,6 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_core_deinit;
 
-	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
-	if (ret)
-		goto err_dev_unregister;
-
 	ret = pm_runtime_put_sync(dev);
 	if (ret)
 		goto err_dev_unregister;
@@ -347,6 +351,8 @@ static int venus_remove(struct platform_device *pdev)
 	venus_shutdown(dev);
 	of_platform_depopulate(dev);
 
+	venus_firmware_deinit(core);
+
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 8b85dc8..c629666 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -131,6 +131,9 @@ struct venus_core {
 	struct device *dev_dec;
 	struct device *dev_enc;
 	unsigned int use_tz;
+	struct video_firmware {
+		struct device *dev;
+	} fw;
 	struct mutex lock;
 	struct list_head instances;
 	atomic_t insts_count;
diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
index 1d4f066..98b3b16 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -18,6 +18,8 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
 #include <linux/qcom_scm.h>
 #include <linux/sizes.h>
 #include <linux/soc/qcom/mdt_loader.h>
@@ -144,3 +146,56 @@ int venus_shutdown(struct device *dev)
 {
 	return qcom_scm_pas_shutdown(VENUS_PAS_ID);
 }
+
+int venus_firmware_init(struct venus_core *core)
+{
+	struct platform_device_info info;
+	struct platform_device *pdev;
+	struct device_node *np;
+	int ret;
+
+	np = of_get_child_by_name(core->dev->of_node, "video-firmware");
+	if (!np) {
+		core->use_tz = true;
+		return 0;
+	}
+
+	memset(&info, 0, sizeof(info));
+	info.fwnode = &np->fwnode;
+	info.parent = core->dev;
+	info.name = np->name;
+	info.dma_mask = DMA_BIT_MASK(32);
+
+	pdev = platform_device_register_full(&info);
+	if (IS_ERR(pdev)) {
+		of_node_put(np);
+		return PTR_ERR(pdev);
+	}
+
+	pdev->dev.of_node = np;
+
+	ret = of_dma_configure(&pdev->dev, np, true);
+	if (ret) {
+		dev_err(core->dev, "dma configure fail\n");
+		goto err_unregister;
+	}
+
+	core->fw.dev = &pdev->dev;
+
+	of_node_put(np);
+
+	return 0;
+
+err_unregister:
+	platform_device_unregister(pdev);
+	of_node_put(np);
+	return ret;
+}
+
+void venus_firmware_deinit(struct venus_core *core)
+{
+	if (!core->fw.dev)
+		return;
+
+	platform_device_unregister(to_platform_device(core->fw.dev));
+}
diff --git a/drivers/media/platform/qcom/venus/firmware.h b/drivers/media/platform/qcom/venus/firmware.h
index 1343747..fd7edf0 100644
--- a/drivers/media/platform/qcom/venus/firmware.h
+++ b/drivers/media/platform/qcom/venus/firmware.h
@@ -16,6 +16,8 @@
 
 struct device;
 
+int venus_firmware_init(struct venus_core *core);
+void venus_firmware_deinit(struct venus_core *core);
 int venus_boot(struct venus_core *core);
 int venus_shutdown(struct device *dev);
 int venus_set_hw_state(struct venus_core *core, bool suspend);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

