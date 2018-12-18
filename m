Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B1DC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31132080D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Wf8j9kUG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Kcodba2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeLRCPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 21:15:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59466 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeLRCPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 21:15:51 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 049EF60860; Tue, 18 Dec 2018 02:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545099350;
        bh=ErmrL16E0heg/giXRM5GLnAO5thNlkvBcDzW7GSfOxk=;
        h=From:To:Cc:Subject:Date:From;
        b=Wf8j9kUGfkB6ylSV042GTNRgg3rxBoAb8cL0o/M1F2QnoZKzhvgiL46EOIXHVW8GX
         2sjuEiHsPkboUCUGb42qvdt3HmSDQRNv4U1qsYtDQKktkBgydCIqwGzNPWY8pWAjPT
         +hnZy+rtElU/cUD2QFUGzu/LQd/4khHnSWpVaDIU=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF637601D7;
        Tue, 18 Dec 2018 02:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545099348;
        bh=ErmrL16E0heg/giXRM5GLnAO5thNlkvBcDzW7GSfOxk=;
        h=From:To:Cc:Subject:Date:From;
        b=Kcodba2BNPF5ewrkiklFRpmnaGAj1mvlwGiESF3Y1nVtuV6VZ8SVyNhXAjXzPmH7K
         nB4YNR99K7jBUBVijnT2fpCZTjb8yKb6+DME+wDT0dion5bBcURjiSPYNUQrNAyPuB
         OVEl0jgeTSNB08IGpO4r804OxzWOwhN4OjiOKkm8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF637601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     bjorn.andersson@linaro.org, marc.w.gonzalez@free.fr,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v4] clk: qcom: smd: Add support for MSM8998 rpm clocks
Date:   Mon, 17 Dec 2018 19:15:36 -0700
Message-Id: <1545099336-5615-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rpm smd clocks, PMIC and bus clocks which are required on MSM8998
for clients to vote on.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
v4
-Fix compile issue

v3
-Ensure Marc's hang was addressed by GCC fixes
-Renamed the bb clks to ln_bb to match the schematics

v2
-fix compatible ordering nits per Stephen 

 .../devicetree/bindings/clock/qcom,rpmcc.txt       |  1 +
 drivers/clk/qcom/clk-smd-rpm.c                     | 63 ++++++++++++++++++++++
 include/dt-bindings/clock/qcom,rpmcc.h             | 10 ++++
 3 files changed, 74 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
index 87b4949..944719b 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.txt
@@ -16,6 +16,7 @@ Required properties :
 			"qcom,rpmcc-msm8974", "qcom,rpmcc"
 			"qcom,rpmcc-apq8064", "qcom,rpmcc"
 			"qcom,rpmcc-msm8996", "qcom,rpmcc"
+			"qcom,rpmcc-msm8998", "qcom,rpmcc"
 			"qcom,rpmcc-qcs404", "qcom,rpmcc"
 
 - #clock-cells : shall contain 1
diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index d3aadae..22dd42a 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -655,10 +655,73 @@ static int clk_smd_rpm_enable_scaling(struct qcom_smd_rpm *rpm)
 	.num_clks = ARRAY_SIZE(qcs404_clks),
 };
 
+/* msm8998 */
+DEFINE_CLK_SMD_RPM(msm8998, snoc_clk, snoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 1);
+DEFINE_CLK_SMD_RPM(msm8998, cnoc_clk, cnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 2);
+DEFINE_CLK_SMD_RPM(msm8998, ce1_clk, ce1_a_clk, QCOM_SMD_RPM_CE_CLK, 0);
+DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, div_clk1, div_clk1_a, 0xb);
+DEFINE_CLK_SMD_RPM(msm8998, ipa_clk, ipa_a_clk, QCOM_SMD_RPM_IPA_CLK, 0);
+DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, ln_bb_clk1, ln_bb_clk1_a, 1);
+DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, ln_bb_clk2, ln_bb_clk2_a, 2);
+DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, ln_bb_clk3_pin, ln_bb_clk3_a_pin,
+				     3);
+DEFINE_CLK_SMD_RPM(msm8998, mmssnoc_axi_rpm_clk, mmssnoc_axi_rpm_a_clk,
+		   QCOM_SMD_RPM_MMAXI_CLK, 0);
+DEFINE_CLK_SMD_RPM(msm8998, aggre1_noc_clk, aggre1_noc_a_clk,
+		   QCOM_SMD_RPM_AGGR_CLK, 1);
+DEFINE_CLK_SMD_RPM(msm8998, aggre2_noc_clk, aggre2_noc_a_clk,
+		   QCOM_SMD_RPM_AGGR_CLK, 2);
+DEFINE_CLK_SMD_RPM_QDSS(msm8998, qdss_clk, qdss_a_clk,
+			QCOM_SMD_RPM_MISC_CLK, 1);
+DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, rf_clk1, rf_clk1_a, 4);
+DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, rf_clk2_pin, rf_clk2_a_pin, 5);
+DEFINE_CLK_SMD_RPM_XO_BUFFER(msm8998, rf_clk3, rf_clk3_a, 6);
+DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8998, rf_clk3_pin, rf_clk3_a_pin, 6);
+static struct clk_smd_rpm *msm8998_clks[] = {
+	[RPM_SMD_SNOC_CLK] = &msm8998_snoc_clk,
+	[RPM_SMD_SNOC_A_CLK] = &msm8998_snoc_a_clk,
+	[RPM_SMD_CNOC_CLK] = &msm8998_cnoc_clk,
+	[RPM_SMD_CNOC_A_CLK] = &msm8998_cnoc_a_clk,
+	[RPM_SMD_CE1_CLK] = &msm8998_ce1_clk,
+	[RPM_SMD_CE1_A_CLK] = &msm8998_ce1_a_clk,
+	[RPM_SMD_DIV_CLK1] = &msm8998_div_clk1,
+	[RPM_SMD_DIV_A_CLK1] = &msm8998_div_clk1_a,
+	[RPM_SMD_IPA_CLK] = &msm8998_ipa_clk,
+	[RPM_SMD_IPA_A_CLK] = &msm8998_ipa_a_clk,
+	[RPM_SMD_LN_BB_CLK1] = &msm8998_ln_bb_clk1,
+	[RPM_SMD_LN_BB_CLK1_A] = &msm8998_ln_bb_clk1_a,
+	[RPM_SMD_LN_BB_CLK2] = &msm8998_ln_bb_clk2,
+	[RPM_SMD_LN_BB_CLK2_A] = &msm8998_ln_bb_clk2_a,
+	[RPM_SMD_LN_BB_CLK3_PIN] = &msm8998_ln_bb_clk3_pin,
+	[RPM_SMD_LN_BB_CLK3_A_PIN] = &msm8998_ln_bb_clk3_a_pin,
+	[RPM_SMD_MMAXI_CLK] = &msm8998_mmssnoc_axi_rpm_clk,
+	[RPM_SMD_MMAXI_A_CLK] = &msm8998_mmssnoc_axi_rpm_a_clk,
+	[RPM_SMD_AGGR1_NOC_CLK] = &msm8998_aggre1_noc_clk,
+	[RPM_SMD_AGGR1_NOC_A_CLK] = &msm8998_aggre1_noc_a_clk,
+	[RPM_SMD_AGGR2_NOC_CLK] = &msm8998_aggre2_noc_clk,
+	[RPM_SMD_AGGR2_NOC_A_CLK] = &msm8998_aggre2_noc_a_clk,
+	[RPM_SMD_QDSS_CLK] = &msm8998_qdss_clk,
+	[RPM_SMD_QDSS_A_CLK] = &msm8998_qdss_a_clk,
+	[RPM_SMD_RF_CLK1] = &msm8998_rf_clk1,
+	[RPM_SMD_RF_CLK1_A] = &msm8998_rf_clk1_a,
+	[RPM_SMD_RF_CLK2_PIN] = &msm8998_rf_clk2_pin,
+	[RPM_SMD_RF_CLK2_A_PIN] = &msm8998_rf_clk2_a_pin,
+	[RPM_SMD_RF_CLK3] = &msm8998_rf_clk3,
+	[RPM_SMD_RF_CLK3_A] = &msm8998_rf_clk3_a,
+	[RPM_SMD_RF_CLK3_PIN] = &msm8998_rf_clk3_pin,
+	[RPM_SMD_RF_CLK3_A_PIN] = &msm8998_rf_clk3_a_pin,
+};
+
+static const struct rpm_smd_clk_desc rpm_clk_msm8998 = {
+	.clks = msm8998_clks,
+	.num_clks = ARRAY_SIZE(msm8998_clks),
+};
+
 static const struct of_device_id rpm_smd_clk_match_table[] = {
 	{ .compatible = "qcom,rpmcc-msm8916", .data = &rpm_clk_msm8916 },
 	{ .compatible = "qcom,rpmcc-msm8974", .data = &rpm_clk_msm8974 },
 	{ .compatible = "qcom,rpmcc-msm8996", .data = &rpm_clk_msm8996 },
+	{ .compatible = "qcom,rpmcc-msm8998", .data = &rpm_clk_msm8998 },
 	{ .compatible = "qcom,rpmcc-qcs404",  .data = &rpm_clk_qcs404  },
 	{ }
 };
diff --git a/include/dt-bindings/clock/qcom,rpmcc.h b/include/dt-bindings/clock/qcom,rpmcc.h
index 3658b0c..ede93a0 100644
--- a/include/dt-bindings/clock/qcom,rpmcc.h
+++ b/include/dt-bindings/clock/qcom,rpmcc.h
@@ -127,5 +127,15 @@
 #define RPM_SMD_BIMC_GPU_A_CLK			77
 #define RPM_SMD_QPIC_CLK			78
 #define RPM_SMD_QPIC_CLK_A			79
+#define RPM_SMD_LN_BB_CLK1			80
+#define RPM_SMD_LN_BB_CLK1_A			81
+#define RPM_SMD_LN_BB_CLK2			82
+#define RPM_SMD_LN_BB_CLK2_A			83
+#define RPM_SMD_LN_BB_CLK3_PIN			84
+#define RPM_SMD_LN_BB_CLK3_A_PIN		85
+#define RPM_SMD_RF_CLK3				86
+#define RPM_SMD_RF_CLK3_A			87
+#define RPM_SMD_RF_CLK3_PIN			88
+#define RPM_SMD_RF_CLK3_A_PIN			89
 
 #endif
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

