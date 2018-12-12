Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB91C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0E92084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OfsiKu4K";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oFJaBDi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0E92084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbeLLMp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:45:27 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50788 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeLLMp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:45:26 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 178DC60350; Wed, 12 Dec 2018 12:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544618725;
        bh=GffpiDb9XR0K7CRkXl38gkIZhx6Gev42B7ujZ5rL4yE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OfsiKu4K+fmQu6U4i8iSu+R8QotUoSJvHnxpx4UxRx75bR9BrKKQW+P9I+iD0jnSW
         WOh5h4tTtUH7Q/wOkyxY9qylKWYmvAtexX/TNmVp5AcZ4e9nTaSar+5HV+YcrNflfL
         qmsnxqynkUtg6bPmyNYo0DceQ5b/KVOfL8UUMzOk=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 390EC602FB;
        Wed, 12 Dec 2018 12:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544618724;
        bh=GffpiDb9XR0K7CRkXl38gkIZhx6Gev42B7ujZ5rL4yE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oFJaBDi16R9lTRW8bxmq//DpwWXbNY0/eyNtTo3yaXKM1TptRUPxMsHYODicz14+F
         JgsBp6ENgF3iygR9S8xpa4bfWvJBxECHa+6XsPbkFcg1EWdC4KtVFPiPdLcrIAq7hP
         Yj7LSNdPcuE367XGo8+KWfhR48Yqa07S9FMPVxqM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 390EC602FB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org
Cc:     briannorris@chromium.org, akdwived@codeaurora.org,
        clew@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 2/2] remoteproc: qcom: q6v5-mss: Add support for parsing fw dt bindings
Date:   Wed, 12 Dec 2018 18:14:56 +0530
Message-Id: <20181212124456.3164-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212124456.3164-1-sibis@codeaurora.org>
References: <20181212124456.3164-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for parsing "qcom,firmware" dt bindings which specifies
the relative paths of mba and modem metadata as a list of strings.
Fallback to the default paths for mba/modem on -EINVAL.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 49 +++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 01be7314e176..c4e7700aee0f 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -30,6 +31,7 @@
 #include <linux/remoteproc.h>
 #include <linux/reset.h>
 #include <linux/soc/qcom/mdt_loader.h>
+#include <linux/string.h>
 #include <linux/iopoll.h>
 
 #include "remoteproc_internal.h"
@@ -188,6 +190,7 @@ struct q6v5 {
 	bool has_alt_reset;
 	int mpss_perm;
 	int mba_perm;
+	const char *hexagon_mdt_image;
 	int version;
 };
 
@@ -860,17 +863,29 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 	phys_addr_t min_addr = PHYS_ADDR_MAX;
 	phys_addr_t max_addr = 0;
 	bool relocate = false;
-	char seg_name[10];
+	char seg_name[35];
+	char *fw_prefix;
+	char *tmp;
 	ssize_t offset;
 	size_t size = 0;
 	void *ptr;
 	int ret;
 	int i;
 
-	ret = request_firmware(&fw, "modem.mdt", qproc->dev);
+	fw_prefix = kstrdup(qproc->hexagon_mdt_image, GFP_KERNEL);
+	if (!fw_prefix)
+		return -ENOMEM;
+
+	/* strip out the fw extn */
+	tmp = strrchr(fw_prefix, '.');
+	if (tmp)
+		*tmp = '\0';
+
+	ret = request_firmware(&fw, qproc->hexagon_mdt_image, qproc->dev);
 	if (ret < 0) {
-		dev_err(qproc->dev, "unable to load modem.mdt\n");
-		return ret;
+		dev_err(qproc->dev, "unable to load %s\n",
+			qproc->hexagon_mdt_image);
+		goto release_fw_prefix;
 	}
 
 	/* Initialize the RMB validator */
@@ -918,7 +933,8 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 		ptr = qproc->mpss_region + offset;
 
 		if (phdr->p_filesz) {
-			snprintf(seg_name, sizeof(seg_name), "modem.b%02d", i);
+			snprintf(seg_name, sizeof(seg_name), "%s.b%02d",
+				 fw_prefix, i);
 			ret = request_firmware(&seg_fw, seg_name, qproc->dev);
 			if (ret) {
 				dev_err(qproc->dev, "failed to load %s\n", seg_name);
@@ -960,6 +976,8 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 
 release_firmware:
 	release_firmware(fw);
+release_fw_prefix:
+	kfree(fw_prefix);
 
 	return ret < 0 ? ret : 0;
 }
@@ -1075,9 +1093,10 @@ static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
 	unsigned long i;
 	int ret;
 
-	ret = request_firmware(&fw, "modem.mdt", qproc->dev);
+	ret = request_firmware(&fw, qproc->hexagon_mdt_image, qproc->dev);
 	if (ret < 0) {
-		dev_err(qproc->dev, "unable to load modem.mdt\n");
+		dev_err(qproc->dev, "unable to load %s\n",
+			qproc->hexagon_mdt_image);
 		return ret;
 	}
 
@@ -1253,6 +1272,8 @@ static int q6v5_probe(struct platform_device *pdev)
 	const struct rproc_hexagon_res *desc;
 	struct q6v5 *qproc;
 	struct rproc *rproc;
+	const char *mba_image;
+	const char *fw_name[2];
 	int ret;
 
 	desc = of_device_get_match_data(&pdev->dev);
@@ -1262,8 +1283,19 @@ static int q6v5_probe(struct platform_device *pdev)
 	if (desc->need_mem_protection && !qcom_scm_is_available())
 		return -EPROBE_DEFER;
 
+	ret = of_property_count_strings(pdev->dev.of_node, "qcom,firmware");
+	if (ret != -EINVAL && ret != 2)
+		return -EINVAL;
+
+	ret = of_property_read_string_array(pdev->dev.of_node, "qcom,firmware",
+					    fw_name, 2);
+	if (ret != -EINVAL && ret != 2)
+		return -EINVAL;
+
+	mba_image = (ret != 2) ? desc->hexagon_mba_image : fw_name[0];
+
 	rproc = rproc_alloc(&pdev->dev, pdev->name, &q6v5_ops,
-			    desc->hexagon_mba_image, sizeof(*qproc));
+			    mba_image, sizeof(*qproc));
 	if (!rproc) {
 		dev_err(&pdev->dev, "failed to allocate rproc\n");
 		return -ENOMEM;
@@ -1272,6 +1304,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	qproc = (struct q6v5 *)rproc->priv;
 	qproc->dev = &pdev->dev;
 	qproc->rproc = rproc;
+	qproc->hexagon_mdt_image = (ret != 2) ? "modem.mdt" : fw_name[1];
 	platform_set_drvdata(pdev, qproc);
 
 	ret = q6v5_init_mem(qproc, pdev);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

