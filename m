Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4EFC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7588A20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SwXPTXce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfAVTCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:02:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34588 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAVTCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:02:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so12227496pfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 11:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PkqxUXjTLADjZMxeF8I5ld6pkxlurpzsvRpzU0lAhq4=;
        b=SwXPTXceVb1O69PtsWZuVzPscMSEm8wrgDOGjTf+PRXJwmGopp4zrxIJQKhdmCJJQh
         oP0qhz17RxEk+eb5EH4myebBOX8pX0mmX8+OOaVDEBNAuSAUBJ8r1M0r9XDEvbrzLVfj
         yo8pxYbH0Wy7AHID9JKEJ4/LgE7WEV15oF1hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PkqxUXjTLADjZMxeF8I5ld6pkxlurpzsvRpzU0lAhq4=;
        b=F04ECoHXcfBBTO6xKZkTSLTy8cnzQDg2SppIHkZayCGQ4mjHBsABYnW3YVznSZqq4l
         quMLjK8MIllriUM9FI3K9jZGp5MxFGY4L0EtGi9lvbgMezXBrnDcTnCy3jKcM2KJB1vs
         SHWiUX0YxQIchOLWAemoRreFHxylBSbyk/6ln5MSnzy+RBrlN/qCfoGmeOykBVuWsAxL
         glnUM+ZoT89YJ50FkrOzTITZGxrdjOpZYAF9RWZB5eDn0Uc8rtL1ZpRTJ2lImN7F6yfN
         1mNzGXFxKR7pcNPhB1lUuI/OvwWkJcJNqUKAinn/wQ05e4hoeUQiNi0thoZYkZCsQS8u
         LuIQ==
X-Gm-Message-State: AJcUukfPBLVUnqgG3KulLcGIKJ6otmUWe+pmnQf2giWDJ7faELRJFdEq
        /Avgj4jHpbNFJIXTHdGk73YPmw==
X-Google-Smtp-Source: ALg8bN4mDXL362xFXAwKV9PSGwanDDrSmMHLhtIiuFQl4hJA7J/e00E/uQibpqe4b+6fx+BciN5y4w==
X-Received: by 2002:a63:30c8:: with SMTP id w191mr34098245pgw.120.1548183737970;
        Tue, 22 Jan 2019 11:02:17 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z62sm24598296pfi.4.2019.01.22.11.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 11:02:17 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] regulator: qcom-smd: Batch up requests for disabled regulators
Date:   Tue, 22 Jan 2019 11:01:47 -0800
Message-Id: <20190122190147.26735-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some scenarios the early stages of the boot chain has configured
regulators to be in a required state, but the later stages has skipped
to inform the RPM about it's requirements.

But as the SMD RPM regulators are being initialized voltage change
requests will be issued to align the voltage with the valid ranges. The
RPM aggregates all parameters for the specific regulator, the voltage
will be adjusted and the "enabled" state will be "off" - and the
regulator is turned off.

This patch addresses this problem by caching the requested enable state,
voltage and load and send the parameters in a batch, depending on the
enable state - effectively delaying the voltage request for disabled
regulators.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/regulator/qcom_smd-regulator.c | 104 ++++++++++++++++---------
 1 file changed, 69 insertions(+), 35 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index f5bca77d67c1..dfdc67da5cec 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -31,6 +31,11 @@ struct qcom_rpm_reg {
 
 	int is_enabled;
 	int uV;
+	u32 load;
+
+	unsigned int enabled_updated:1;
+	unsigned int uv_updated:1;
+	unsigned int load_updated:1;
 };
 
 struct rpm_regulator_req {
@@ -43,30 +48,59 @@ struct rpm_regulator_req {
 #define RPM_KEY_UV	0x00007675 /* "uv" */
 #define RPM_KEY_MA	0x0000616d /* "ma" */
 
-static int rpm_reg_write_active(struct qcom_rpm_reg *vreg,
-				struct rpm_regulator_req *req,
-				size_t size)
+static int rpm_reg_write_active(struct qcom_rpm_reg *vreg)
 {
-	return qcom_rpm_smd_write(vreg->rpm,
-				  QCOM_SMD_RPM_ACTIVE_STATE,
-				  vreg->type,
-				  vreg->id,
-				  req, size);
+	struct rpm_regulator_req req[3];
+	int reqlen = 0;
+	int ret;
+
+	if (vreg->enabled_updated) {
+		req[reqlen].key = cpu_to_le32(RPM_KEY_SWEN);
+		req[reqlen].nbytes = cpu_to_le32(sizeof(u32));
+		req[reqlen].value = cpu_to_le32(vreg->is_enabled);
+		reqlen++;
+	}
+
+	if (vreg->uv_updated && vreg->is_enabled) {
+		req[reqlen].key = cpu_to_le32(RPM_KEY_UV);
+		req[reqlen].nbytes = cpu_to_le32(sizeof(u32));
+		req[reqlen].value = cpu_to_le32(vreg->uV);
+		reqlen++;
+	}
+
+	if (vreg->load_updated && vreg->is_enabled) {
+		req[reqlen].key = cpu_to_le32(RPM_KEY_MA);
+		req[reqlen].nbytes = cpu_to_le32(sizeof(u32));
+		req[reqlen].value = cpu_to_le32(vreg->load / 1000);
+		reqlen++;
+	}
+
+	if (!reqlen)
+		return 0;
+
+	ret = qcom_rpm_smd_write(vreg->rpm, QCOM_SMD_RPM_ACTIVE_STATE,
+				 vreg->type, vreg->id,
+				 req, sizeof(req[0]) * reqlen);
+	if (!ret) {
+		vreg->enabled_updated = 0;
+		vreg->uv_updated = 0;
+		vreg->load_updated = 0;
+	}
+
+	return ret;
 }
 
 static int rpm_reg_enable(struct regulator_dev *rdev)
 {
 	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
-	struct rpm_regulator_req req;
 	int ret;
 
-	req.key = cpu_to_le32(RPM_KEY_SWEN);
-	req.nbytes = cpu_to_le32(sizeof(u32));
-	req.value = cpu_to_le32(1);
+	vreg->is_enabled = 1;
+	vreg->enabled_updated = 1;
 
-	ret = rpm_reg_write_active(vreg, &req, sizeof(req));
-	if (!ret)
-		vreg->is_enabled = 1;
+	ret = rpm_reg_write_active(vreg);
+	if (ret)
+		vreg->is_enabled = 0;
 
 	return ret;
 }
@@ -81,16 +115,14 @@ static int rpm_reg_is_enabled(struct regulator_dev *rdev)
 static int rpm_reg_disable(struct regulator_dev *rdev)
 {
 	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
-	struct rpm_regulator_req req;
 	int ret;
 
-	req.key = cpu_to_le32(RPM_KEY_SWEN);
-	req.nbytes = cpu_to_le32(sizeof(u32));
-	req.value = 0;
+	vreg->is_enabled = 0;
+	vreg->enabled_updated = 1;
 
-	ret = rpm_reg_write_active(vreg, &req, sizeof(req));
-	if (!ret)
-		vreg->is_enabled = 0;
+	ret = rpm_reg_write_active(vreg);
+	if (ret)
+		vreg->is_enabled = 1;
 
 	return ret;
 }
@@ -108,16 +140,15 @@ static int rpm_reg_set_voltage(struct regulator_dev *rdev,
 			       unsigned *selector)
 {
 	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
-	struct rpm_regulator_req req;
-	int ret = 0;
+	int ret;
+	int old_uV = vreg->uV;
 
-	req.key = cpu_to_le32(RPM_KEY_UV);
-	req.nbytes = cpu_to_le32(sizeof(u32));
-	req.value = cpu_to_le32(min_uV);
+	vreg->uV = min_uV;
+	vreg->uv_updated = 1;
 
-	ret = rpm_reg_write_active(vreg, &req, sizeof(req));
-	if (!ret)
-		vreg->uV = min_uV;
+	ret = rpm_reg_write_active(vreg);
+	if (ret)
+		vreg->uV = old_uV;
 
 	return ret;
 }
@@ -125,13 +156,16 @@ static int rpm_reg_set_voltage(struct regulator_dev *rdev,
 static int rpm_reg_set_load(struct regulator_dev *rdev, int load_uA)
 {
 	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
-	struct rpm_regulator_req req;
+	u32 old_load = vreg->load;
+	int ret;
 
-	req.key = cpu_to_le32(RPM_KEY_MA);
-	req.nbytes = cpu_to_le32(sizeof(u32));
-	req.value = cpu_to_le32(load_uA / 1000);
+	vreg->load = load_uA;
+	vreg->load_updated = 1;
+	ret = rpm_reg_write_active(vreg);
+	if (ret)
+		vreg->load = old_load;
 
-	return rpm_reg_write_active(vreg, &req, sizeof(req));
+	return ret;
 }
 
 static const struct regulator_ops rpm_smps_ldo_ops = {
-- 
2.18.0

