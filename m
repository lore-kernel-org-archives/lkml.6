Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAAEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCB520658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wwb0cd9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCB520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeH3DMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 23:12:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34361 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbeH3DMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 23:12:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so2972240pfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 16:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HX4F/rdiOP0kU6rBurqBeHoRoGC1++7SAIga+ZKr2rE=;
        b=Wwb0cd9nxM6/lBhhSkAx8Cs01gZ12pfgPMg9+/CqlkeVS1DgWjbcKvRXzuK5WYE0NA
         SHReuJkQY8HZu1n2eHl8eQF0T0OTTlCXexoaowP9+06h1Hyp47337jImfMfR2roIfsez
         1PnJQ0/S5KiW0YwkR/vORlw8sMFu3QdkUHzs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HX4F/rdiOP0kU6rBurqBeHoRoGC1++7SAIga+ZKr2rE=;
        b=lB+jNnBUDE2h+QgNuiMqpuEfTo7vBRjOAq3FDUVGsjuGT8bO/WsIoYgOGD22xe2VZb
         Vj8EXPN+x32CZAq96gVUwoDHFas5BxhrXmZktx7AKa/lIZBgrMJuwbrLC9IpMlbhapmm
         uVYr/K7Zs8q/IpB/zoDR/gqV3VpRwZvqcVKTu+R9Uyz22948exoE76tjhBvb7liU9/UF
         2ZTb7jFAYNqgYPaZP/uUl1tJw4OAmv5h65XN/BQUXil8f5HkIwBgvTkMMrkFDTh9CzmY
         Hz+jXD08g+5Rj3d46lT0mXXsq3ls1dxydDS+u00DI+44ysxi6olT1J7WuSV9gj4RIpOk
         3u5A==
X-Gm-Message-State: APzg51Axy3uxuNhHka466qWwoXE5q2UFfcHheW/2mw8738kgCsPh/808
        RY/nBakwEEXhK8BG25bZgUT1TnJCm0U=
X-Google-Smtp-Source: ANB0VdbT+wJrJePhRlUBIhXSQpDf89AYHX6I/k0y8D93YaDvppDjby/EI56kMsxViI3JqS90oYokJA==
X-Received: by 2002:a63:6745:: with SMTP id b66-v6mr7627496pgc.248.1535584408381;
        Wed, 29 Aug 2018 16:13:28 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w69-v6sm14035404pgd.37.2018.08.29.16.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 16:13:27 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     Sricharan R <sricharan@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Craig Tatlor <ctatlor97@gmail.com>
Subject: [PATCH 2/3] firmware: qcom: scm: Refactor clock handling
Date:   Wed, 29 Aug 2018 16:15:04 -0700
Message-Id: <20180829231505.22660-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829231505.22660-1-bjorn.andersson@linaro.org>
References: <20180829231505.22660-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At one point in time all "future" platforms required three clocks, so
the binding and driver was written to treat this as the default case.
But new platforms has no clock requirements, which currently makes them
all a special case, causing the need for a patch in the binding and
driver for each new platform added.

This patch reworks the driver logic so that it will attempt to acquire
all three clocks and fail based on the given compatible. This allow us
to drop the clock requirement from "qcom,scm", in a way that will remain
backwards compatible with existing DT files.

Specific compatibles are added for apq8084, msm8916 and msm8974 to match
the updated binding and although equivalent to qcom,scm both ipq4019 and
msm8996 are kept as these have been used without fallback to qcom,scm.

The result of this patch is that new platforms, that require no clocks,
can be use the fallback compatible of "qcom,scm".

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/firmware/qcom_scm.c | 74 +++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index e778af766fae..af4eee86919d 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -525,34 +525,44 @@ static int qcom_scm_probe(struct platform_device *pdev)
 		return ret;
 
 	clks = (unsigned long)of_device_get_match_data(&pdev->dev);
-	if (clks & SCM_HAS_CORE_CLK) {
-		scm->core_clk = devm_clk_get(&pdev->dev, "core");
-		if (IS_ERR(scm->core_clk)) {
-			if (PTR_ERR(scm->core_clk) != -EPROBE_DEFER)
-				dev_err(&pdev->dev,
-					"failed to acquire core clk\n");
+
+	scm->core_clk = devm_clk_get(&pdev->dev, "core");
+	if (IS_ERR(scm->core_clk)) {
+		if (PTR_ERR(scm->core_clk) == -EPROBE_DEFER)
+			return PTR_ERR(scm->core_clk);
+
+		if (clks & SCM_HAS_CORE_CLK) {
+			dev_err(&pdev->dev, "failed to acquire core clk\n");
 			return PTR_ERR(scm->core_clk);
 		}
+
+		scm->core_clk = NULL;
 	}
 
-	if (clks & SCM_HAS_IFACE_CLK) {
-		scm->iface_clk = devm_clk_get(&pdev->dev, "iface");
-		if (IS_ERR(scm->iface_clk)) {
-			if (PTR_ERR(scm->iface_clk) != -EPROBE_DEFER)
-				dev_err(&pdev->dev,
-					"failed to acquire iface clk\n");
+	scm->iface_clk = devm_clk_get(&pdev->dev, "iface");
+	if (IS_ERR(scm->iface_clk)) {
+		if (PTR_ERR(scm->iface_clk) == -EPROBE_DEFER)
+			return PTR_ERR(scm->iface_clk);
+
+		if (clks & SCM_HAS_IFACE_CLK) {
+			dev_err(&pdev->dev, "failed to acquire iface clk\n");
 			return PTR_ERR(scm->iface_clk);
 		}
+
+		scm->iface_clk = NULL;
 	}
 
-	if (clks & SCM_HAS_BUS_CLK) {
-		scm->bus_clk = devm_clk_get(&pdev->dev, "bus");
-		if (IS_ERR(scm->bus_clk)) {
-			if (PTR_ERR(scm->bus_clk) != -EPROBE_DEFER)
-				dev_err(&pdev->dev,
-					"failed to acquire bus clk\n");
+	scm->bus_clk = devm_clk_get(&pdev->dev, "bus");
+	if (IS_ERR(scm->bus_clk)) {
+		if (PTR_ERR(scm->bus_clk) == -EPROBE_DEFER)
+			return PTR_ERR(scm->bus_clk);
+
+		if (clks & SCM_HAS_BUS_CLK) {
+			dev_err(&pdev->dev, "failed to acquire bus clk\n");
 			return PTR_ERR(scm->bus_clk);
 		}
+
+		scm->bus_clk = NULL;
 	}
 
 	scm->reset.ops = &qcom_scm_pas_reset_ops;
@@ -594,23 +604,23 @@ static const struct of_device_id qcom_scm_dt_match[] = {
 	{ .compatible = "qcom,scm-apq8064",
 	  /* FIXME: This should have .data = (void *) SCM_HAS_CORE_CLK */
 	},
-	{ .compatible = "qcom,scm-msm8660",
-	  .data = (void *) SCM_HAS_CORE_CLK,
-	},
-	{ .compatible = "qcom,scm-msm8960",
-	  .data = (void *) SCM_HAS_CORE_CLK,
-	},
-	{ .compatible = "qcom,scm-msm8996",
-	  .data = NULL, /* no clocks */
+	{ .compatible = "qcom,scm-apq8084", .data = (void *)(SCM_HAS_CORE_CLK |
+							     SCM_HAS_IFACE_CLK |
+							     SCM_HAS_BUS_CLK)
 	},
-	{ .compatible = "qcom,scm-ipq4019",
-	  .data = NULL, /* no clocks */
+	{ .compatible = "qcom,scm-ipq4019" },
+	{ .compatible = "qcom,scm-msm8660", .data = (void *) SCM_HAS_CORE_CLK },
+	{ .compatible = "qcom,scm-msm8960", .data = (void *) SCM_HAS_CORE_CLK },
+	{ .compatible = "qcom,scm-msm8916", .data = (void *)(SCM_HAS_CORE_CLK |
+							     SCM_HAS_IFACE_CLK |
+							     SCM_HAS_BUS_CLK)
 	},
-	{ .compatible = "qcom,scm",
-	  .data = (void *)(SCM_HAS_CORE_CLK
-			   | SCM_HAS_IFACE_CLK
-			   | SCM_HAS_BUS_CLK),
+	{ .compatible = "qcom,scm-msm8974", .data = (void *)(SCM_HAS_CORE_CLK |
+							     SCM_HAS_IFACE_CLK |
+							     SCM_HAS_BUS_CLK)
 	},
+	{ .compatible = "qcom,scm-msm8996" },
+	{ .compatible = "qcom,scm" },
 	{}
 };
 
-- 
2.18.0

