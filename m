Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2D2C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 04:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD8C26769
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 04:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="if3AKIx7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="if3AKIx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD8C26769
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932814AbeF0ExT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 00:53:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57816 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753144AbeF0ExQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 00:53:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C064660AD8; Wed, 27 Jun 2018 04:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530075195;
        bh=1aPYJ25/wHcEPaX1Uoilk+oVTU96VEWDOvijr9E5e9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=if3AKIx7KZWunoJ5K3/qilQdr3N8pfWD4rCUbKpJnr7eX5rFlTdRomIsjh2YeP5Aa
         i7QnJA6tn7rhexS2k/EVO1GP54GCuP7NOvtGBd+9z07MzSYDrpsWeDfiqQfo+5gxBU
         tTtLqVgpOcpTqvsSm0B+V3BOPQJ0IoDf5LalyYrY=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A2F5060131;
        Wed, 27 Jun 2018 04:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530075195;
        bh=1aPYJ25/wHcEPaX1Uoilk+oVTU96VEWDOvijr9E5e9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=if3AKIx7KZWunoJ5K3/qilQdr3N8pfWD4rCUbKpJnr7eX5rFlTdRomIsjh2YeP5Aa
         i7QnJA6tn7rhexS2k/EVO1GP54GCuP7NOvtGBd+9z07MzSYDrpsWeDfiqQfo+5gxBU
         tTtLqVgpOcpTqvsSm0B+V3BOPQJ0IoDf5LalyYrY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2F5060131
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v4 4/6] soc: qcom: rpmpd: Add support for get/set performance state
Date:   Wed, 27 Jun 2018 10:22:32 +0530
Message-Id: <20180627045234.27403-5-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180627045234.27403-1-rnayak@codeaurora.org>
References: <20180627045234.27403-1-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the .set_performace_state() and .opp_to_performance_state()
callbacks in the rpmpd driver.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 46 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index a0b9f122d793..eb1cfa6a03d6 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/soc/qcom/smd-rpm.h>
 
 #include <dt-bindings/mfd/qcom-rpm.h>
@@ -28,6 +29,8 @@
 #define KEY_ENABLE		0x6e657773 /* swen */
 #define KEY_FLOOR_CORNER	0x636676   /* vfc */
 
+#define MAX_RPMPD_STATE		6
+
 #define DEFINE_RPMPD_CORN_SMPA(_platform, _name, _active, r_id)		\
 	static struct rpmpd _platform##_##_active;			\
 	static struct rpmpd _platform##_##_name = {			\
@@ -221,6 +224,47 @@ static int rpmpd_power_off(struct generic_pm_domain *domain)
 	return ret;
 }
 
+static int rpmpd_set_performance(struct generic_pm_domain *domain,
+				 unsigned int state)
+{
+	int ret = 0;
+	struct rpmpd *pd = domain_to_rpmpd(domain);
+
+	mutex_lock(&rpmpd_lock);
+
+	if (state > MAX_RPMPD_STATE)
+		goto out;
+
+	pd->corner = state;
+
+	if (!pd->enabled && (pd->key != KEY_FLOOR_CORNER))
+		goto out;
+
+	ret = rpmpd_aggregate_corner(pd);
+
+out:
+	mutex_unlock(&rpmpd_lock);
+
+	return ret;
+}
+
+static unsigned int rpmpd_get_performance(struct generic_pm_domain *genpd,
+					  struct dev_pm_opp *opp)
+{
+	struct device_node *np;
+	unsigned int corner = 0;
+
+	np = dev_pm_opp_get_of_node(opp);
+	if (of_property_read_u32(np, "qcom,level", &corner)) {
+		pr_err("%s: missing 'qcom,level' property\n", __func__);
+		return 0;
+	}
+
+	of_node_put(np);
+
+	return corner;
+}
+
 static int rpmpd_probe(struct platform_device *pdev)
 {
 	int i;
@@ -261,6 +305,8 @@ static int rpmpd_probe(struct platform_device *pdev)
 		rpmpds[i]->rpm = rpm;
 		rpmpds[i]->pd.power_off = rpmpd_power_off;
 		rpmpds[i]->pd.power_on = rpmpd_power_on;
+		rpmpds[i]->pd.set_performance_state = rpmpd_set_performance;
+		rpmpds[i]->pd.opp_to_performance_state = rpmpd_get_performance;
 		pm_genpd_init(&rpmpds[i]->pd, NULL, true);
 
 		data->domains[i] = &rpmpds[i]->pd;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

