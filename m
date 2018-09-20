Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8D7C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769292150E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BhAI0jd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769292150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbeITHSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 03:18:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35305 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeITHSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 03:18:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id 205-v6so2651939pgd.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FLPwzN4T2S6MfpJnysgQHqsb5+qmQyHpMhTvk7cYcS8=;
        b=BhAI0jd+3wGEGErERXBTcUUqIUcboFp4Vh++pnky7Roe+D4RHF2EYMMoWDq0ruTciu
         2iF+ZUq5w7tvbWsx+A1rR3KLJc3U8fr1lWSyq/NqWXGxcwiWyiN6OkMhVuGYDfn1Wfea
         RJLCM6uk3RVhckY2ljK6ZZ3F1opaDFAEaGsLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FLPwzN4T2S6MfpJnysgQHqsb5+qmQyHpMhTvk7cYcS8=;
        b=MaEEJdzuatvXPxps1HRTeIsPy+x2VPz5N7hAll7VXNbzyh4wsPNK4rJA40xOye6FP5
         qknia9b2vuIsEhE0igWDeM+2uX3l4eMvywdNYX5MDazRGIL3BeeYuyAtSAhbFWI2yf0g
         qBFfc8AeQfepoj5JkzPNN+iEbyBmmX3Pd3xpk84aW34WPnaX4GRdtK6kP1eRlGt4c/PE
         NmOE7zZlRhrOqnDzmE8x2YmmvTGFE1wcwaZN1KvHCgc0iajVoowOhh1RONjiqPjRw7e4
         Y63Oo8soZCSR7I8gVIHFMabwdgPsXQpFZ5tHZnL1Dv2V77jcWQB4EjEVJ7kB3k8i8H9G
         Hfdg==
X-Gm-Message-State: APzg51B9+tsFTg1XS6KytcmFoo74nNBet4p20aOnJ8FB2GyQgr4kLq6h
        nlm0bowF0VFwQlaGPda1nundJA==
X-Google-Smtp-Source: ANB0Vda+5ePmdMgFc7a8ppL29kSq/cdtymy17stKBxHUqDpS49jcZVOOJp+M+YXrnnhzOG5t+rSsZQ==
X-Received: by 2002:a62:6711:: with SMTP id b17-v6mr38811893pfc.243.1537407483784;
        Wed, 19 Sep 2018 18:38:03 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e7-v6sm28813229pgc.55.2018.09.19.18.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 18:38:03 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] regulators: qcom: Add PMS405 regulators
Date:   Wed, 19 Sep 2018 18:40:20 -0700
Message-Id: <20180920014020.14408-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMS405 provdies 5 SMPS regulators and 13 LDOs, add these to the RPM
regulator driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../regulator/qcom,smd-rpm-regulator.txt      | 23 ++++++
 drivers/regulator/qcom_smd-regulator.c        | 77 +++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
index 58a1d97972f5..45025b5b67f6 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
@@ -26,6 +26,7 @@ Regulator nodes are identified by their compatible:
 		    "qcom,rpm-pm8998-regulators"
 		    "qcom,rpm-pma8084-regulators"
 		    "qcom,rpm-pmi8998-regulators"
+		    "qcom,rpm-pms405-regulators"
 
 - vdd_s1-supply:
 - vdd_s2-supply:
@@ -188,6 +189,24 @@ Regulator nodes are identified by their compatible:
 	Definition: reference to regulator supplying the input pin, as
 		    described in the data sheet
 
+- vdd_s1-supply:
+- vdd_s2-supply:
+- vdd_s3-supply:
+- vdd_s4-supply:
+- vdd_s5-supply:
+- vdd_l1_l2-supply:
+- vdd_l3_l8-supply:
+- vdd_l4-supply:
+- vdd_l5_l6-supply:
+- vdd_l7-supply:
+- vdd_l3_l8-supply:
+- vdd_l9-supply:
+- vdd_l10_l11_l12_l13-supply:
+	Usage: optional (pms405 only)
+	Value type: <phandle>
+	Definition: reference to regulator supplying the input pin, as
+		    described in the data sheet
+
 The regulator node houses sub-nodes for each regulator within the device. Each
 sub-node is identified using the node's name, with valid values listed for each
 of the pmics below.
@@ -222,6 +241,10 @@ pma8084:
 pmi8998:
 	bob
 
+pms405:
+	s1, s2, s3, s4, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12,
+	l13
+
 The content of each sub-node is defined by the standard binding for regulators -
 see regulator.txt.
 
diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index fe2fb36803e0..f5bca77d67c1 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -420,6 +420,60 @@ static const struct regulator_desc pmi8998_bob = {
 	.ops = &rpm_bob_ops,
 };
 
+static const struct regulator_desc pms405_hfsmps3 = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 216,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pms405_nldo300 = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 128,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pms405_nldo1200 = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 128,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pms405_pldo50 = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1664000, 0, 128, 16000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 129,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pms405_pldo150 = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1664000, 0, 128, 16000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 129,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pms405_pldo600 = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1256000, 0, 98, 8000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 99,
+	.ops = &rpm_smps_ldo_ops,
+};
+
 struct rpm_regulator_data {
 	const char *name;
 	u32 type;
@@ -661,6 +715,28 @@ static const struct rpm_regulator_data rpm_pmi8998_regulators[] = {
 	{}
 };
 
+static const struct rpm_regulator_data rpm_pms405_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pms405_hfsmps3, "vdd_s1" },
+	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pms405_hfsmps3, "vdd_s2" },
+	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pms405_hfsmps3, "vdd_s3" },
+	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pms405_hfsmps3, "vdd_s4" },
+	{ "s5", QCOM_SMD_RPM_SMPA, 5, &pms405_hfsmps3, "vdd_s5" },
+	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pms405_nldo1200, "vdd_l1_l2" },
+	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pms405_nldo1200, "vdd_l1_l2" },
+	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pms405_nldo1200, "vdd_l3_l8" },
+	{ "l4", QCOM_SMD_RPM_LDOA, 4, &pms405_nldo300, "vdd_l4" },
+	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pms405_pldo600, "vdd_l5_l6" },
+	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pms405_pldo600, "vdd_l5_l6" },
+	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pms405_pldo150, "vdd_l7" },
+	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pms405_nldo1200, "vdd_l3_l8" },
+	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pms405_nldo1200, "vdd_l9" },
+	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pms405_pldo50, "vdd_l10_l11_l12_l13" },
+	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pms405_pldo150, "vdd_l10_l11_l12_l13" },
+	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pms405_pldo150, "vdd_l10_l11_l12_l13" },
+	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pms405_pldo150, "vdd_l10_l11_l12_l13" },
+	{}
+};
+
 static const struct of_device_id rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-pm8841-regulators", .data = &rpm_pm8841_regulators },
 	{ .compatible = "qcom,rpm-pm8916-regulators", .data = &rpm_pm8916_regulators },
@@ -669,6 +745,7 @@ static const struct of_device_id rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-pm8998-regulators", .data = &rpm_pm8998_regulators },
 	{ .compatible = "qcom,rpm-pma8084-regulators", .data = &rpm_pma8084_regulators },
 	{ .compatible = "qcom,rpm-pmi8998-regulators", .data = &rpm_pmi8998_regulators },
+	{ .compatible = "qcom,rpm-pms405-regulators", .data = &rpm_pms405_regulators },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rpm_of_match);
-- 
2.18.0

