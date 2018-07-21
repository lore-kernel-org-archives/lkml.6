Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB70ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE3D20868
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ce+qe2EB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RDeAd7u/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE3D20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeGUTJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 15:09:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54520 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeGUTJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 15:09:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 424C460B1E; Sat, 21 Jul 2018 18:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532196927;
        bh=+3J8fdutGWhw3xn9P/ApyA69ixoM6Oh7GFOy0rTJkLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ce+qe2EB8VNcLJzSPgD3CvDbyuZsjFVyDcJgjBAWCRMj7T8ihqexnqiTSuvMIJ0IQ
         FQbnjREXsGEYz64qptF/l+zcR/fw1H9fIsMelKw/Z9RfnR5QRona0Wf0R0v1pb1pQK
         MV+1ht8R+K43LB6fA3PomI7w81c6UX2FcGRGIaf8=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D95B60AD9;
        Sat, 21 Jul 2018 18:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532196926;
        bh=+3J8fdutGWhw3xn9P/ApyA69ixoM6Oh7GFOy0rTJkLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RDeAd7u/8pisV3QwFtlFwEAqbQrFRVYHy8pGo7CKOm38OJArTd2vFQoE4NoOJ5dEJ
         FDm//EigMhL2z1FHsrOX2aol2r0WZHObZEXuZRAgMjaqIh+k0gr+wLDAbtyV13/RTO
         Q4yJx5jxdO03WlD1JRWl/z3LV/I3HK2dsH9DPIRE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D95B60AD9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        grahamr@qti.qualcomm.com, Taniya Das <tdas@codeaurora.org>
Subject: [RFC PATCH 2/4] clk: qcom: Initialize the power domain class for each clock
Date:   Sat, 21 Jul 2018 23:45:00 +0530
Message-Id: <1532196902-28570-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532196902-28570-1-git-send-email-tdas@codeaurora.org>
References: <1532196902-28570-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power domain class is being initialized for clocks which has
an associated power domains before registering the clocks with
the clock framework.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/clk-regmap.h |  5 +++++
 drivers/clk/qcom/common.c     | 17 +++++++----------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/qcom/clk-regmap.h b/drivers/clk/qcom/clk-regmap.h
index 90d95cd..6265d91 100644
--- a/drivers/clk/qcom/clk-regmap.h
+++ b/drivers/clk/qcom/clk-regmap.h
@@ -17,22 +17,27 @@
 #include <linux/clk-provider.h>
 
 struct regmap;
+struct clk_powerdomain_class;
 
 /**
  * struct clk_regmap - regmap supporting clock
  * @hw:		handle between common and hardware-specific interfaces
  * @regmap:	regmap to use for regmap helpers and/or by providers
+ * @pd:		power domain scaling requirement class
  * @enable_reg: register when using regmap enable/disable ops
  * @enable_mask: mask when using regmap enable/disable ops
  * @enable_is_inverted: flag to indicate set enable_mask bits to disable
  *                      when using clock_enable_regmap and friends APIs.
+ * @rate_max:	maximum clock rate in Hz supported at each power domain.
  */
 struct clk_regmap {
 	struct clk_hw hw;
 	struct regmap *regmap;
+	struct clk_powerdomain_class *pd;
 	unsigned int enable_reg;
 	unsigned int enable_mask;
 	bool enable_is_inverted;
+	unsigned long *rate_max;
 };
 #define to_clk_regmap(_hw) container_of(_hw, struct clk_regmap, hw)
 
diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 39ce64c..b0684bf 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -1,14 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * Copyright (c) 2013-2014, 2018, The Linux Foundation. All rights reserved.
  */
 
 #include <linux/export.h>
@@ -20,6 +12,7 @@
 #include <linux/of.h>
 
 #include "common.h"
+#include "clk-pd.h"
 #include "clk-rcg.h"
 #include "clk-regmap.h"
 #include "reset.h"
@@ -263,6 +256,10 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 		if (!rclks[i])
 			continue;
 
+		ret = clk_power_domain_class_init(dev, rclks[i]->pd);
+		if (ret)
+			return ret;
+
 		ret = devm_clk_register_regmap(dev, rclks[i]);
 		if (ret)
 			return ret;
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

