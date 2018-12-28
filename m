Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE62C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 04:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446B02148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 04:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m3aMZp7s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="diWERArP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbeL1Es6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 23:48:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41158 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbeL1Es5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 23:48:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BBE5E6090F; Fri, 28 Dec 2018 04:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545972535;
        bh=ryH/2egY4Zlt+ep7xo7/xqU7OMbF4ez1VbeR3zkkFfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m3aMZp7sL0orNag8/AhAquCwbLxsFfZr0xtPe2dhKofH2WnfrO5EgdXmA1FtWw0V7
         C03RCmIyYEcd9ghRDVshONZwUXpK8CN7iaPx8XHM9d6wzPpaTv8P4HL7q0vcdjT1qN
         H/oS0vTzDbT4AE7LZgDiTC+FM4fxmxu5Me7Ctynw=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F9E96089D;
        Fri, 28 Dec 2018 04:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545972534;
        bh=ryH/2egY4Zlt+ep7xo7/xqU7OMbF4ez1VbeR3zkkFfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=diWERArPk0DrBHtXEmY+ELw9y+VSRW4iUpy0OyCd9kAULo8eG4eVCDSmlwq8RCyiL
         aie7/yNiG+Gd5wesGL4Vz0akjvn/jEHC3OwP4iDNJKjjRjKCtBmQ/REEt6hO0UGiEM
         5UjISr/Oe0Nb4e7FVntr7HhE7QPyO6P1voBRG9SY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F9E96089D
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
Subject: [PATCH v2 2/2] remoteproc: qcom: Add support for parsing fw dt bindings
Date:   Fri, 28 Dec 2018 10:18:19 +0530
Message-Id: <20181228044819.5697-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181228044819.5697-1-sibis@codeaurora.org>
References: <20181228044819.5697-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for parsing "firmware-name" dt bindings which specifies
the relative paths of mba/modem/pas image as strings. Fallback to
the default paths for mba/modem/pas image on -EINVAL.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 46 +++++++++++++++++++++++-------
 drivers/remoteproc/qcom_q6v5_pas.c | 11 ++++++-
 2 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 01be7314e176..c75179006e24 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -188,6 +188,7 @@ struct q6v5 {
 	bool has_alt_reset;
 	int mpss_perm;
 	int mba_perm;
+	const char *hexagon_mdt_image;
 	int version;
 };
 
@@ -860,17 +861,27 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 	phys_addr_t min_addr = PHYS_ADDR_MAX;
 	phys_addr_t max_addr = 0;
 	bool relocate = false;
-	char seg_name[10];
+	char *fw_name;
+	size_t fw_name_len;
 	ssize_t offset;
 	size_t size = 0;
 	void *ptr;
 	int ret;
 	int i;
 
-	ret = request_firmware(&fw, "modem.mdt", qproc->dev);
+	fw_name_len = strlen(qproc->hexagon_mdt_image);
+	if (fw_name_len <= 4)
+		return -EINVAL;
+
+	fw_name = kstrdup(qproc->hexagon_mdt_image, GFP_KERNEL);
+	if (!fw_name)
+		return -ENOMEM;
+
+	ret = request_firmware(&fw, qproc->hexagon_mdt_image, qproc->dev);
 	if (ret < 0) {
-		dev_err(qproc->dev, "unable to load modem.mdt\n");
-		return ret;
+		dev_err(qproc->dev, "unable to load %s\n",
+			qproc->hexagon_mdt_image);
+		goto out;
 	}
 
 	/* Initialize the RMB validator */
@@ -918,10 +929,12 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 		ptr = qproc->mpss_region + offset;
 
 		if (phdr->p_filesz) {
-			snprintf(seg_name, sizeof(seg_name), "modem.b%02d", i);
-			ret = request_firmware(&seg_fw, seg_name, qproc->dev);
+			snprintf(fw_name + fw_name_len - 3, fw_name_len,
+				 "b%02d", i);
+			ret = request_firmware(&seg_fw, fw_name, qproc->dev);
 			if (ret) {
-				dev_err(qproc->dev, "failed to load %s\n", seg_name);
+				dev_err(qproc->dev, "failed to load %s\n",
+					fw_name);
 				goto release_firmware;
 			}
 
@@ -960,6 +973,8 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 
 release_firmware:
 	release_firmware(fw);
+out:
+	kfree(fw_name);
 
 	return ret < 0 ? ret : 0;
 }
@@ -1075,9 +1090,10 @@ static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
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
 
@@ -1253,6 +1269,8 @@ static int q6v5_probe(struct platform_device *pdev)
 	const struct rproc_hexagon_res *desc;
 	struct q6v5 *qproc;
 	struct rproc *rproc;
+	const char *mba_image;
+	const char *fw_name[2];
 	int ret;
 
 	desc = of_device_get_match_data(&pdev->dev);
@@ -1262,8 +1280,15 @@ static int q6v5_probe(struct platform_device *pdev)
 	if (desc->need_mem_protection && !qcom_scm_is_available())
 		return -EPROBE_DEFER;
 
+	ret = of_property_read_string_array(pdev->dev.of_node, "firmware-name",
+					    fw_name, 2);
+	if (ret != -EINVAL && ret != 2)
+		return ret > 0 ? -EINVAL : ret;
+
+	mba_image = (ret != 2) ? desc->hexagon_mba_image : fw_name[0];
+
 	rproc = rproc_alloc(&pdev->dev, pdev->name, &q6v5_ops,
-			    desc->hexagon_mba_image, sizeof(*qproc));
+			    mba_image, sizeof(*qproc));
 	if (!rproc) {
 		dev_err(&pdev->dev, "failed to allocate rproc\n");
 		return -ENOMEM;
@@ -1272,6 +1297,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	qproc = (struct q6v5 *)rproc->priv;
 	qproc->dev = &pdev->dev;
 	qproc->rproc = rproc;
+	qproc->hexagon_mdt_image = (ret != 2) ? "modem.mdt" : fw_name[1];
 	platform_set_drvdata(pdev, qproc);
 
 	ret = q6v5_init_mem(qproc, pdev);
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index b1e63fcd5fdf..141c7da29e9a 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -258,6 +258,8 @@ static int adsp_probe(struct platform_device *pdev)
 	const struct adsp_data *desc;
 	struct qcom_adsp *adsp;
 	struct rproc *rproc;
+	const char *fw_name;
+	const char *of_fw_name;
 	int ret;
 
 	desc = of_device_get_match_data(&pdev->dev);
@@ -267,8 +269,15 @@ static int adsp_probe(struct platform_device *pdev)
 	if (!qcom_scm_is_available())
 		return -EPROBE_DEFER;
 
+	ret = of_property_read_string(pdev->dev.of_node, "firmware-name",
+				      &of_fw_name);
+	if (ret && ret != -EINVAL)
+		return ret;
+
+	fw_name = ret ? desc->firmware_name : of_fw_name;
+
 	rproc = rproc_alloc(&pdev->dev, pdev->name, &adsp_ops,
-			    desc->firmware_name, sizeof(*adsp));
+			    fw_name, sizeof(*adsp));
 	if (!rproc) {
 		dev_err(&pdev->dev, "unable to allocate remoteproc\n");
 		return -ENOMEM;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

