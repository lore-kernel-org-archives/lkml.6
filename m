Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB93C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C654B20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RQ+4TpZp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MUowM0MY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C654B20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeLLJ03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:26:29 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58390 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbeLLJ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:26:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 842946030C; Wed, 12 Dec 2018 09:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544606784;
        bh=loUAJ0iboL6djJPrZSB0IL3O5omoEDQdV+xk5yNOd6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQ+4TpZptU0KLXw83KuZ2+Opgx244eP5mspJ4va3M9XsQzrQPcueo3NeHq2KOETb0
         DMGLz46ofaiVFIUXQr3CYeR+NKppp5h07XiAuD/Kks3MtlfO836lhUEP0xOtdX3Lcs
         krfyIu99MwkVNthAruEh/DDkUE5IwJ0NjCsvyXMU=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1641C6083E;
        Wed, 12 Dec 2018 09:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544606766;
        bh=loUAJ0iboL6djJPrZSB0IL3O5omoEDQdV+xk5yNOd6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MUowM0MY15GNHIb+XEA5X01xRt9j9lk6UTV/qKiRN2TAHbXrxVdeJASHf5UHZrN87
         mV6Z9o2XR38PGQVmSc2zKsgZh9hc6kwz1iKpCCy7Wpv0wK2+0OmPKOSTyTNGQ2LLEu
         8UXVmiiocix8xLuTyxi8PZuXNILTrJiEVd7TxHG4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1641C6083E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v7 09/10] soc: qcom: rpmpd: Use simple_opp_to_performance_state() helper
Date:   Wed, 12 Dec 2018 14:51:30 +0530
Message-Id: <20181212092131.13046-10-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181212092131.13046-1-rnayak@codeaurora.org>
References: <20181212092131.13046-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of the duplicate code across rpmpd and rpmhpd to read the
performance state value from Device tree and use the
simple_opp_to_performance_state() helper instead.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/rpmhpd.c | 11 +----------
 drivers/soc/qcom/rpmpd.c  | 11 +----------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index e37976e87370..f7fbe57f31ae 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -276,16 +276,7 @@ static int rpmhpd_set_performance_state(struct generic_pm_domain *domain,
 static unsigned int rpmhpd_get_performance_state(struct generic_pm_domain *genpd,
 						 struct dev_pm_opp *opp)
 {
-	struct device_node *np;
-	unsigned int level = 0;
-
-	np = dev_pm_opp_get_of_node(opp);
-	if (of_property_read_u32(np, "qcom,level", &level))
-		pr_err("%s: missing 'qcom,level' property\n", __func__);
-
-	of_node_put(np);
-
-	return level;
+	return simple_opp_to_performance_state(genpd, opp, "qcom,level");
 }
 
 static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 59e21c88a144..29288af502b0 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -248,16 +248,7 @@ static int rpmpd_set_performance(struct generic_pm_domain *domain,
 static unsigned int rpmpd_get_performance(struct generic_pm_domain *genpd,
 					  struct dev_pm_opp *opp)
 {
-	struct device_node *np;
-	unsigned int corner = 0;
-
-	np = dev_pm_opp_get_of_node(opp);
-	if (of_property_read_u32(np, "qcom,level", &corner))
-		pr_err("%s: missing 'qcom,level' property\n", __func__);
-
-	of_node_put(np);
-
-	return corner;
+	return simple_opp_to_performance_state(genpd, opp, "qcom,level");
 }
 
 static int rpmpd_probe(struct platform_device *pdev)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

