Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D536C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D11B206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DYZz/MMD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bs6tIYO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfANTuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:50:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51956 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbfANTuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:50:18 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5A11460591; Mon, 14 Jan 2019 19:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547495417;
        bh=um/UlgWzAqzVRoeLSDlUGM5/iJ1nOd4NnMwHuslHi/Y=;
        h=From:To:Cc:Subject:Date:From;
        b=DYZz/MMDHLLP+De/j5d0Oj9p5Zs4THQnUoGlmVlXcnKcGi8KE+MT/if/HoME9W5pG
         bnnatB9djZp2h+2NlUbc0TqmUJVzDGerKpCFDkiKVJw9ylffmOrh7DVOPMUSi25vX6
         jvucotlz2k1UaOP/57y8OP2J1f7r/1xUsqFcDJWc=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 065E760591;
        Mon, 14 Jan 2019 19:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547495416;
        bh=um/UlgWzAqzVRoeLSDlUGM5/iJ1nOd4NnMwHuslHi/Y=;
        h=From:To:Cc:Subject:Date:From;
        b=bs6tIYO2ss5EXEEr+tfOcw+dGUFCs0+iXuAxwpYsEVg72XKtfDwpkVNJK6owVkBcQ
         qitV104rm3ljbVAIxeLNo+r7nnuBpnKiLjqMxSxRxgo9VkUu0oJ5A/tdrBXxyEvqGA
         2uxRWYFFRwE/8uYvsdjHVFWuh6sENSJEWuHonZGE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 065E760591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, briannorris@chromium.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org
Cc:     akdwived@codeaurora.org, clew@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3] remoteproc: qcom: Add support for parsing fw dt bindings
Date:   Tue, 15 Jan 2019 01:20:01 +0530
Message-Id: <20190114195001.7016-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
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

v3:
 * Fixed minor code style issues
 * Add comments for firmware blob name generation
   and use sprintf instead

 drivers/remoteproc/qcom_q6v5_mss.c | 47 +++++++++++++++++++++++-------
 drivers/remoteproc/qcom_q6v5_pas.c |  9 +++++-
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index c86dc40cfb8c..41e92a025d21 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -188,6 +188,7 @@ struct q6v5 {
 	bool has_alt_reset;
 	int mpss_perm;
 	int mba_perm;
+	const char *hexagon_mdt_image;
 	int version;
 };
 
@@ -860,17 +861,26 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
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
+	ret = request_firmware(&fw, fw_name, qproc->dev);
 	if (ret < 0) {
-		dev_err(qproc->dev, "unable to load modem.mdt\n");
-		return ret;
+		dev_err(qproc->dev, "unable to load %s\n", fw_name);
+		goto out;
 	}
 
 	/* Initialize the RMB validator */
@@ -918,10 +928,11 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 		ptr = qproc->mpss_region + offset;
 
 		if (phdr->p_filesz) {
-			snprintf(seg_name, sizeof(seg_name), "modem.b%02d", i);
-			ret = request_firmware(&seg_fw, seg_name, qproc->dev);
+			/* Replace "xxx.xxx" with "xxx.bxx" */
+			sprintf(fw_name + fw_name_len - 3, "b%02d", i);
+			ret = request_firmware(&seg_fw, fw_name, qproc->dev);
 			if (ret) {
-				dev_err(qproc->dev, "failed to load %s\n", seg_name);
+				dev_err(qproc->dev, "failed to load %s\n", fw_name);
 				goto release_firmware;
 			}
 
@@ -960,6 +971,8 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 
 release_firmware:
 	release_firmware(fw);
+out:
+	kfree(fw_name);
 
 	return ret < 0 ? ret : 0;
 }
@@ -1075,9 +1088,10 @@ static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
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
 
@@ -1253,6 +1267,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	const struct rproc_hexagon_res *desc;
 	struct q6v5 *qproc;
 	struct rproc *rproc;
+	const char *mba_image;
 	int ret;
 
 	desc = of_device_get_match_data(&pdev->dev);
@@ -1262,8 +1277,14 @@ static int q6v5_probe(struct platform_device *pdev)
 	if (desc->need_mem_protection && !qcom_scm_is_available())
 		return -EPROBE_DEFER;
 
+	mba_image = desc->hexagon_mba_image;
+	ret = of_property_read_string_index(pdev->dev.of_node, "firmware-name",
+					    0, &mba_image);
+	if (ret < 0 && ret != -EINVAL)
+		return ret;
+
 	rproc = rproc_alloc(&pdev->dev, pdev->name, &q6v5_ops,
-			    desc->hexagon_mba_image, sizeof(*qproc));
+			    mba_image, sizeof(*qproc));
 	if (!rproc) {
 		dev_err(&pdev->dev, "failed to allocate rproc\n");
 		return -ENOMEM;
@@ -1272,6 +1293,12 @@ static int q6v5_probe(struct platform_device *pdev)
 	qproc = (struct q6v5 *)rproc->priv;
 	qproc->dev = &pdev->dev;
 	qproc->rproc = rproc;
+	qproc->hexagon_mdt_image = "modem.mdt";
+	ret = of_property_read_string_index(pdev->dev.of_node, "firmware-name",
+					    1, &qproc->hexagon_mdt_image);
+	if (ret < 0 && ret != -EINVAL)
+		return ret;
+
 	platform_set_drvdata(pdev, qproc);
 
 	ret = q6v5_init_mem(qproc, pdev);
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index b1e63fcd5fdf..cfdafd68e2cd 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -258,6 +258,7 @@ static int adsp_probe(struct platform_device *pdev)
 	const struct adsp_data *desc;
 	struct qcom_adsp *adsp;
 	struct rproc *rproc;
+	const char *fw_name;
 	int ret;
 
 	desc = of_device_get_match_data(&pdev->dev);
@@ -267,8 +268,14 @@ static int adsp_probe(struct platform_device *pdev)
 	if (!qcom_scm_is_available())
 		return -EPROBE_DEFER;
 
+	fw_name = desc->firmware_name;
+	ret = of_property_read_string(pdev->dev.of_node, "firmware-name",
+				      &fw_name);
+	if (ret < 0 && ret != -EINVAL)
+		return ret;
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

