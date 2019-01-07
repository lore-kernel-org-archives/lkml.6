Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89B8C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B8420854
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="itS94wRB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jZ9kzgVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfAGKK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:10:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57068 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfAGKKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:10:54 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 54B7160C69; Mon,  7 Jan 2019 10:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546855853;
        bh=j4/HRuALrdelYuSkk9txqmXQSHP8W2hpRZg0r21rZbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itS94wRBPijETo49+Km7wcX6ikJ+5vhFasqi8+S9Z73YUjKd0Zr0jeD4Q+y8Nu71w
         H2uPhlrZwJ7wPVeWAgt5cRFemyuTdLpeBQLSz83V8+rI87q+HhTFlK2jNp56HbKSsz
         zccAwHBnyCjzuVtUflmyOnazhojA+i6RZj7m0ZQk=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB3FF60A08;
        Mon,  7 Jan 2019 10:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546855850;
        bh=j4/HRuALrdelYuSkk9txqmXQSHP8W2hpRZg0r21rZbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZ9kzgVSHMPb6WzFBmLR0UJdXXwFF6lS+iwMO4yL2oZxLsfWpHBOfHDZS72WdFyEm
         pNEm8SoU+S1L/f+khqOCmNOqKWoOmj//DRVn7DFXliIcx53re6cEIJuvlbIGY61qfs
         fkO6FGAeNlHvFARpeqGtKv0xrwic3Lt/OZpyJoPY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB3FF60A08
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v9 09/10] soc: qcom: rpmpd: Use dev_pm_opp_of_get_level() helper
Date:   Mon,  7 Jan 2019 15:39:58 +0530
Message-Id: <20190107100959.14528-10-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190107100959.14528-1-rnayak@codeaurora.org>
References: <20190107100959.14528-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of the duplicate code across rpmpd and rpmhpd to read the
performance state value (opp-level) from Device tree and use the
dev_pm_opp_of_get_level() helper instead.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/soc/qcom/rpmhpd.c | 11 +----------
 drivers/soc/qcom/rpmpd.c  | 11 +----------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 521aa2a571bb..38c8a11c92c8 100644
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
-	if (of_property_read_u32(np, "opp-level", &level))
-		pr_err("%s: missing 'opp-level' property\n", __func__);
-
-	of_node_put(np);
-
-	return level;
+	return dev_pm_opp_of_get_level(opp);
 }
 
 static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 1c6c5dec2667..68179e4bac3d 100644
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
-	if (of_property_read_u32(np, "opp-level", &corner))
-		pr_err("%s: missing 'opp-level' property\n", __func__);
-
-	of_node_put(np);
-
-	return corner;
+	return dev_pm_opp_of_get_level(opp);
 }
 
 static int rpmpd_probe(struct platform_device *pdev)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

