Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B055C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9792147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FZcNa2Or"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfBUGoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 01:44:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42512 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfBUGoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 01:44:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id n74so13259984pfi.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 22:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/tCAF+6qYZ4v3albO6Hwzpgn40ANVmjeSJ8wHTFMDAs=;
        b=FZcNa2Or4S3vBYhXqk1xMtNXcQkxO172ndZWtV9HGE7VLfiin4ilKRs7C7sWFgsgJ/
         nFgQBZKZXcFO97MlCrrxvgAeOhUNDTI6bDa24jx4uc3LtwJtmO6319JBze/AFBY25szB
         Sn4GDiDmbrI32qU5OZX3znuXtEjil9Zn/O+Xq41uP/WY4ojkHFo4DJl/m7pD2rIjaoey
         PKzXZ8DMJSUkRXiAlmacpB3WIGesViGeRV8LWuDdfOOayDZ0Y9Ucs5mcIxBWeuZAMAV7
         vXN4JKSrxMP5r8tY7iUs3MysS+ld/wOvq7RpeC9mRsgSNlq7F3wCr0btB21Yo0S+XqrF
         5Brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/tCAF+6qYZ4v3albO6Hwzpgn40ANVmjeSJ8wHTFMDAs=;
        b=FUC0GtC8xrGzAvjAxKBw8v1uVy6XcTrkLcVZjLcu+/eGa/ivbnEWEXZ8x7NCfvkoxt
         4wUPucde6J5AlHexR6CtcNMJLp/7qYP58w9EWcT3x/AmOIyJo7hFUli5d2ZZPpzGEsYF
         llmEoBFt5UA7eMlKL5JCnO0Ed3NKDGQFblA+WUsyLBHWmk5IUcF+Asq8ylXYEuR5DzZ0
         nMpexgO+DVXeaQ2PQHRlyM2/GP91Yy8chQgZxcvWzCs+2PsydCDXApZxWTlYfymkXuLU
         kDOYTou9MOJqWrJkZRs8W4ToefS2EbQCiIowIGYDj5ASM3oRJEDnruft4V/gkfT1gbWV
         YWIg==
X-Gm-Message-State: AHQUAuaTM8XO6JdlPX8cHZ/c2oLIQKirIfNZP6B5mC6lazqXSC8xU6Rl
        2IAddl86ddfcaprrkwuXSBaowA==
X-Google-Smtp-Source: AHgI3IYCBsMCblxoea6M8gKDf4L6MaXub6gyAx+grnGVc5G+lLmN6Wy7D/4MawjPpGMDEHwNDAhWuA==
X-Received: by 2002:a63:1ce:: with SMTP id 197mr32756167pgb.47.1550731454565;
        Wed, 20 Feb 2019 22:44:14 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b4sm22777892pgq.57.2019.02.20.22.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 22:44:13 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] soc: qcom: rpmpd: Add QCS404 corners
Date:   Wed, 20 Feb 2019 22:44:33 -0800
Message-Id: <20190221064434.2760-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190221064434.2760-1-bjorn.andersson@linaro.org>
References: <20190221064434.2760-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the shared cx/mx and the low-power-island's cx and mx power-domains
found on QCS404.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../devicetree/bindings/power/qcom,rpmpd.txt  |  1 +
 drivers/soc/qcom/rpmpd.c                      | 29 +++++++++++++++++++
 include/dt-bindings/power/qcom-rpmpd.h        |  9 ++++++
 3 files changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
index 980e5413d18f..b6c596883ea4 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
@@ -6,6 +6,7 @@ which then translates it into a corresponding voltage on a rail
 Required Properties:
  - compatible: Should be one of the following
 	* qcom,msm8996-rpmpd: RPM Power domain for the msm8996 family of SoC
+	* qcom,qcs404-rpmpd: RPM Power domain for the qcs404
 	* qcom,sdm845-rpmhpd: RPMh Power domain for the sdm845 family of SoC
  - #power-domain-cells: number of cells in Power domain specifier
 	must be 1.
diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 74b2f001b9c6..0001fcafaf97 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -19,6 +19,9 @@
 /* Resource types */
 #define RPMPD_SMPA 0x61706d73 /* smpa */
 #define RPMPD_LDOA 0x616f646c /* ldoa */
+#define RPMPD_RWMX 0x786d7772 /* rwmx */
+#define RPMPD_RWLC 0x636c7772 /* rwlc */
+#define RPMPD_RWLM 0x6d6c7772 /* rwlm */
 
 /* Operation Keys */
 #define KEY_CORNER		0x6e726f63 /* corn */
@@ -110,8 +113,34 @@ static const struct rpmpd_desc msm8996_desc = {
 	.num_pds = ARRAY_SIZE(msm8996_rpmpds),
 };
 
+/* qcs404 RPM Power domains */
+DEFINE_RPMPD_CORNER_PAIR(qcs404, vddmx, vddmx_ao, RWMX, 0);
+DEFINE_RPMPD_VFC(qcs404, vddmx_vfc, RWMX, 0);
+
+DEFINE_RPMPD_CORNER(qcs404, vdd_lpicx, RWLC, 0);
+DEFINE_RPMPD_VFC(qcs404, vdd_lpicx_vfc, RWLC, 0);
+
+DEFINE_RPMPD_CORNER(qcs404, vdd_lpimx, RWLM, 0);
+DEFINE_RPMPD_VFC(qcs404, vdd_lpimx_vfc, RWLM, 0);
+
+static struct rpmpd *qcs404_rpmpds[] = {
+	[QCS404_VDDMX] = &qcs404_vddmx,
+	[QCS404_VDDMX_AO] = &qcs404_vddmx_ao,
+	[QCS404_VDDMX_VFC] = &qcs404_vddmx_vfc,
+	[QCS404_LPICX] = &qcs404_vdd_lpicx,
+	[QCS404_LPICX_VFC] = &qcs404_vdd_lpicx_vfc,
+	[QCS404_LPIMX] = &qcs404_vdd_lpimx,
+	[QCS404_LPIMX_VFC] = &qcs404_vdd_lpimx_vfc,
+};
+
+static const struct rpmpd_desc qcs404_desc = {
+	.rpmpds = qcs404_rpmpds,
+	.num_pds = ARRAY_SIZE(qcs404_rpmpds),
+};
+
 static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,msm8996-rpmpd", .data = &msm8996_desc },
+	{ .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
 	{ }
 };
 
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 87d9c6611682..0b1b147292a3 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -36,4 +36,13 @@
 #define MSM8996_VDDSSCX		5
 #define MSM8996_VDDSSCX_VFC	6
 
+/* QCS404 Power Domains */
+#define QCS404_VDDMX		0
+#define QCS404_VDDMX_AO		1
+#define QCS404_VDDMX_VFC	2
+#define QCS404_LPICX		3
+#define QCS404_LPICX_VFC	4
+#define QCS404_LPIMX		5
+#define QCS404_LPIMX_VFC	6
+
 #endif
-- 
2.18.0

