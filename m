Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3B3ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 06:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A47E2081D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 06:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTIN85M0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A47E2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeKCQGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 12:06:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41350 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbeKCQGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 12:06:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id k13so1915734pga.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 23:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JfWafiBXzY3GqjbsFuSucku0AXH/F1fMBMNCXmqm9Bo=;
        b=jTIN85M0e6ssJS2pgY1mxXpIKlMwc/fumm323nDFfbO/lCC1UUFxjEp5KYImaWgEOJ
         urXdZiihu3RvQY8NwT6UeoQowWffDDKqbsavC6nGiVU0j8MRAgipxxslaZiRdCPA9YuQ
         HSjUj54e6DdBAelP9paOtaX1lHbBAQvAazd0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JfWafiBXzY3GqjbsFuSucku0AXH/F1fMBMNCXmqm9Bo=;
        b=guqZQODhPtoTdz8fl6dg0kERIJ/72hXV9ceB15M94+xK3YbtwuP7bhpeTvpwSCydPh
         Q8wG8KmQJCyzyqH7rB+rRTIjTrmyKfbyrMq6AoHsI5rXtfxGGb4isbS5YiXOqlw2EbC7
         IxRM1R6GxVeB//y+A3/89gOds/Q8LkgVilOD1jOBSZAHLE9fnpURJ99hJUKq2gCGoM1G
         be30q3gt0FXQG4F/zgw+Z5bDbQJpzJ48Dg8aqE7O3yJsfZ5ohKhH+7666mE/Iz9B4XEg
         R4qPCp/TwgzGWko71dCJphMQB+vPsYJeqvm2ewpI48fVAtN82rYd9rIM5yW8wiRBGzn5
         kX8w==
X-Gm-Message-State: AGRZ1gL+7gXwHyqlCyhU+kDvV5jW/iu5jZ61I4Q5XldR/SGGWt8f5m4/
        Pjsh80v15y6z5PGsBainaCymZA==
X-Google-Smtp-Source: AJdET5cv4jZDeako57nyoNlHrq9Y+KYf6FHxGMyH7tQ8QOlT0OfaLw5adWHs7M2IU3An62Ej3z/OOg==
X-Received: by 2002:a62:9f90:: with SMTP id v16-v6mr14603111pfk.207.1541228187577;
        Fri, 02 Nov 2018 23:56:27 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p64-v6sm36254870pfi.22.2018.11.02.23.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 23:56:26 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Subject: [PATCH] clk: qcom: smd: Add support for QCS404 rpm clocks
Date:   Sat,  3 Nov 2018 00:00:02 -0700
Message-Id: <20181103070002.19106-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <tdas@codeaurora.org>

Add rpm smd clocks, PMIC and bus clocks which are required on QCS404
for clients to vote on.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Anu Ramanathan <anur@codeaurora.org>
[bjorn: Dropped cxo, voter clocks and static initialization]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/clock/qcom,rpmcc.txt  |  1 +
 drivers/clk/qcom/clk-smd-rpm.c                | 45 +++++++++++++++++++
 include/dt-bindings/clock/qcom,rpmcc.h        |  4 ++
 3 files changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
index 4491d1c104aa..87b4949e9bc8 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
@@ -16,6 +16,7 @@ Required properties :
 			"qcom,rpmcc-msm8974", "qcom,rpmcc"
 			"qcom,rpmcc-apq8064", "qcom,rpmcc"
 			"qcom,rpmcc-msm8996", "qcom,rpmcc"
+			"qcom,rpmcc-qcs404", "qcom,rpmcc"
 
 - #clock-cells : shall contain 1
 
diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 850c02a52248..d3aadaeb2903 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -611,10 +611,55 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8996 = {
 	.num_clks = ARRAY_SIZE(msm8996_clks),
 };
 
+/* QCS404 */
+DEFINE_CLK_SMD_RPM_QDSS(qcs404, qdss_clk, qdss_a_clk, QCOM_SMD_RPM_MISC_CLK, 1);
+
+DEFINE_CLK_SMD_RPM(qcs404, pnoc_clk, pnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 0);
+DEFINE_CLK_SMD_RPM(qcs404, snoc_clk, snoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 1);
+
+DEFINE_CLK_SMD_RPM(qcs404, bimc_clk, bimc_a_clk, QCOM_SMD_RPM_MEM_CLK, 0);
+DEFINE_CLK_SMD_RPM(qcs404, bimc_gpu_clk, bimc_gpu_a_clk, QCOM_SMD_RPM_MEM_CLK, 2);
+
+DEFINE_CLK_SMD_RPM(qcs404, qpic_clk, qpic_a_clk, QCOM_SMD_RPM_QPIC_CLK, 0);
+DEFINE_CLK_SMD_RPM(qcs404, ce1_clk, ce1_a_clk, QCOM_SMD_RPM_CE_CLK, 0);
+
+DEFINE_CLK_SMD_RPM_XO_BUFFER(qcs404, rf_clk1, rf_clk1_a, 4);
+DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(qcs404, rf_clk1_pin, rf_clk1_a_pin, 4);
+
+DEFINE_CLK_SMD_RPM_XO_BUFFER(qcs404, ln_bb_clk, ln_bb_a_clk, 8);
+DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(qcs404, ln_bb_clk_pin, ln_bb_clk_a_pin, 8);
+
+static struct clk_smd_rpm *qcs404_clks[] = {
+	[RPM_SMD_QDSS_CLK] = &qcs404_qdss_clk,
+	[RPM_SMD_QDSS_A_CLK] = &qcs404_qdss_a_clk,
+	[RPM_SMD_PNOC_CLK] = &qcs404_pnoc_clk,
+	[RPM_SMD_PNOC_A_CLK] = &qcs404_pnoc_a_clk,
+	[RPM_SMD_SNOC_CLK] = &qcs404_snoc_clk,
+	[RPM_SMD_SNOC_A_CLK] = &qcs404_snoc_a_clk,
+	[RPM_SMD_BIMC_CLK] = &qcs404_bimc_clk,
+	[RPM_SMD_BIMC_A_CLK] = &qcs404_bimc_a_clk,
+	[RPM_SMD_BIMC_GPU_CLK] = &qcs404_bimc_gpu_clk,
+	[RPM_SMD_BIMC_GPU_A_CLK] = &qcs404_bimc_gpu_a_clk,
+	[RPM_SMD_QPIC_CLK] = &qcs404_qpic_clk,
+	[RPM_SMD_QPIC_CLK_A] = &qcs404_qpic_a_clk,
+	[RPM_SMD_CE1_CLK] = &qcs404_ce1_clk,
+	[RPM_SMD_CE1_A_CLK] = &qcs404_ce1_a_clk,
+	[RPM_SMD_RF_CLK1] = &qcs404_rf_clk1,
+	[RPM_SMD_RF_CLK1_A] = &qcs404_rf_clk1_a,
+	[RPM_SMD_LN_BB_CLK] = &qcs404_ln_bb_clk,
+	[RPM_SMD_LN_BB_A_CLK] = &qcs404_ln_bb_a_clk,
+};
+
+static const struct rpm_smd_clk_desc rpm_clk_qcs404 = {
+	.clks = qcs404_clks,
+	.num_clks = ARRAY_SIZE(qcs404_clks),
+};
+
 static const struct of_device_id rpm_smd_clk_match_table[] = {
 	{ .compatible = "qcom,rpmcc-msm8916", .data = &rpm_clk_msm8916 },
 	{ .compatible = "qcom,rpmcc-msm8974", .data = &rpm_clk_msm8974 },
 	{ .compatible = "qcom,rpmcc-msm8996", .data = &rpm_clk_msm8996 },
+	{ .compatible = "qcom,rpmcc-qcs404",  .data = &rpm_clk_qcs404  },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rpm_smd_clk_match_table);
diff --git a/include/dt-bindings/clock/qcom,rpmcc.h b/include/dt-bindings/clock/qcom,rpmcc.h
index c585b82b9c05..3658b0c14966 100644
--- a/include/dt-bindings/clock/qcom,rpmcc.h
+++ b/include/dt-bindings/clock/qcom,rpmcc.h
@@ -123,5 +123,9 @@
 #define RPM_SMD_DIV_A_CLK3			73
 #define RPM_SMD_LN_BB_CLK			74
 #define RPM_SMD_LN_BB_A_CLK			75
+#define RPM_SMD_BIMC_GPU_CLK			76
+#define RPM_SMD_BIMC_GPU_A_CLK			77
+#define RPM_SMD_QPIC_CLK			78
+#define RPM_SMD_QPIC_CLK_A			79
 
 #endif
-- 
2.18.0

