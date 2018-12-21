Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB47FC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0B0218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jUrCckvP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jUrCckvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbeLUI4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:56:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35706 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388486AbeLUI4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:56:49 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E1092608CB; Fri, 21 Dec 2018 08:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545382608;
        bh=fR6Rf2sFg62NX7SbCiacseBN81PNon3xVk+LaKrehW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUrCckvPlUL4A6LIRmcMLeeAfscawAwnRacl9RPXUvGybXKcVkbzysuIvwvnvLli/
         Hmh+vqHXmNLRiSAbohPjHG5dogYs2f0fJb/eCKND1YWsWJ71uvFHZD/XYVxVW/ugPk
         O0L0BLAYxiAvPU+RHkM9CtXXvWEajD3dV3X5Snao=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 13CFE608CB;
        Fri, 21 Dec 2018 08:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545382608;
        bh=fR6Rf2sFg62NX7SbCiacseBN81PNon3xVk+LaKrehW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUrCckvPlUL4A6LIRmcMLeeAfscawAwnRacl9RPXUvGybXKcVkbzysuIvwvnvLli/
         Hmh+vqHXmNLRiSAbohPjHG5dogYs2f0fJb/eCKND1YWsWJ71uvFHZD/XYVxVW/ugPk
         O0L0BLAYxiAvPU+RHkM9CtXXvWEajD3dV3X5Snao=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13CFE608CB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v8 04/10] soc: qcom: rpmpd: Add support for get/set performance state
Date:   Fri, 21 Dec 2018 14:26:16 +0530
Message-Id: <20181221085622.25573-5-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221085622.25573-1-rnayak@codeaurora.org>
References: <20181221085622.25573-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the .set_performace_state() and .opp_to_performance_state()
callbacks in the rpmpd driver.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/rpmpd.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 7715ba7c9157..59e21c88a144 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -10,6 +10,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/soc/qcom/smd-rpm.h>
 
 #include <dt-bindings/mfd/qcom-rpm.h>
@@ -26,6 +27,8 @@
 #define KEY_ENABLE		0x6e657773 /* swen */
 #define KEY_FLOOR_CORNER	0x636676   /* vfc */
 
+#define MAX_RPMPD_STATE		6
+
 #define DEFINE_RPMPD_CORNER_SMPA(_platform, _name, _active, r_id)		\
 	static struct rpmpd _platform##_##_active;			\
 	static struct rpmpd _platform##_##_name = {			\
@@ -218,6 +221,45 @@ static int rpmpd_power_off(struct generic_pm_domain *domain)
 	return ret;
 }
 
+static int rpmpd_set_performance(struct generic_pm_domain *domain,
+				 unsigned int state)
+{
+	int ret = 0;
+	struct rpmpd *pd = domain_to_rpmpd(domain);
+
+	if (state > MAX_RPMPD_STATE)
+		goto out;
+
+	mutex_lock(&rpmpd_lock);
+
+	pd->corner = state;
+
+	if (!pd->enabled && pd->key != KEY_FLOOR_CORNER)
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
+	if (of_property_read_u32(np, "qcom,level", &corner))
+		pr_err("%s: missing 'qcom,level' property\n", __func__);
+
+	of_node_put(np);
+
+	return corner;
+}
+
 static int rpmpd_probe(struct platform_device *pdev)
 {
 	int i;
@@ -258,6 +300,8 @@ static int rpmpd_probe(struct platform_device *pdev)
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

