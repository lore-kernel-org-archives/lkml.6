Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9F9C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD8521A35
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DGqaNafg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OEub2baf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD8521A35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbeHFPhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:37:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55010 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeHFPhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:37:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E6F2C60B7A; Mon,  6 Aug 2018 13:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533562111;
        bh=l4huC+NhSDrGVizKfuQuqT9NflbJ3CnYMsbR99v3ngY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DGqaNafgudgpqbOCtDWPqohZryzHjbpZ0Z8Q+L4Mu+q63qOjUl6kT3pdhMe8A+myC
         VTdD5001WVgygKmIz8e0jyY6If2lylpO5B2Qf8cVdVXQK4aYLmV7OJxEL3p+Miph/Q
         U5qwLyBWniQzgvZqTG+4HC2UUoxDBknp94s0yGVA=
Received: from vgarodia-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2A0760117;
        Mon,  6 Aug 2018 13:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533562110;
        bh=l4huC+NhSDrGVizKfuQuqT9NflbJ3CnYMsbR99v3ngY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OEub2bafeV6dxDHnIDPjLRxhvPz6DLjEv7JFRZy227tLIECM8oDLWjiNS7+9yY6Al
         cbkOpMomYUhrAlVzswaKksCXC3E8KiEtsIESl0ggf0/yDaqPWIRHsc9ji8WleOKsiX
         eLOjaL/pj9gidMNRn49blqqOlRq+yCUa+Kl7SUMw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2A0760117
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
Subject: [PATCH v4 2/4] venus: firmware: move load firmware in a separate function
Date:   Mon,  6 Aug 2018 18:58:03 +0530
Message-Id: <1533562085-8773-3-git-send-email-vgarodia@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533562085-8773-1-git-send-email-vgarodia@codeaurora.org>
References: <1533562085-8773-1-git-send-email-vgarodia@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate firmware loading part into a new function.

Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
---
 drivers/media/platform/qcom/venus/core.c     |  4 +--
 drivers/media/platform/qcom/venus/firmware.c | 54 +++++++++++++++++-----------
 drivers/media/platform/qcom/venus/firmware.h |  2 +-
 3 files changed, 37 insertions(+), 23 deletions(-)

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
index 3aa6b37..4577043 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -58,20 +58,18 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
 	return 0;
 }
 
-int venus_boot(struct device *dev, const char *fwname)
+static int venus_load_fw(struct venus_core *core, const char *fwname,
+			phys_addr_t *mem_phys, size_t *mem_size)
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
@@ -82,16 +80,16 @@ int venus_boot(struct device *dev, const char *fwname)
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
 
@@ -106,23 +104,39 @@ int venus_boot(struct device *dev, const char *fwname)
 		goto err_unmap;
 	}
 
-	ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID, mem_va, mem_phys,
-			    mem_size, NULL);
+	if (core->no_tz)
+		ret = qcom_mdt_load_no_init(dev, mdt, fwname, VENUS_PAS_ID,
+					mem_va, *mem_phys, *mem_size, NULL);
+	else
+		ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID,
+				mem_va, *mem_phys, *mem_size, NULL);
 
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
+	phys_addr_t mem_phys;
+	struct device *dev = core->dev;
+	size_t mem_size;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
+		(!core->no_tz && !qcom_scm_is_available()))
+		return -EPROBE_DEFER;
+
+	ret = venus_load_fw(core, core->res->fwname, &mem_phys, &mem_size);
+	if (ret) {
+		dev_err(dev, "fail to load video firmware\n");
+		return -EINVAL;
+	}
+	return qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
+}
+
 int venus_shutdown(struct device *dev)
 {
 	return qcom_scm_pas_shutdown(VENUS_PAS_ID);
diff --git a/drivers/media/platform/qcom/venus/firmware.h b/drivers/media/platform/qcom/venus/firmware.h
index efa449a..347a893 100644
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

