Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbeELBrL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 21:47:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47280 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeELBq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 21:46:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B8C46085F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
From: David Collins <collinsd@codeaurora.org>
To: broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc: David Collins <collinsd@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org, sboyd@kernel.org,
        dianders@chromium.org
Subject: [PATCH 2/2] regulator: of: add support for allowed modes configuration
Date: Fri, 11 May 2018 18:46:47 -0700
Message-Id: <58bb4f965515a67a6cbbc726b0d7b092c22b79d7.1526088289.git.collinsd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1526088289.git.collinsd@codeaurora.org>
References: <cover.1526088289.git.collinsd@codeaurora.org>
In-Reply-To: <cover.1526088289.git.collinsd@codeaurora.org>
References: <cover.1526088289.git.collinsd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for configuring the machine constraints
valid_modes_mask element based on a list of allowed modes
specified via a device tree property.

Signed-off-by: David Collins <collinsd@codeaurora.org>
---
 drivers/regulator/of_regulator.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 0d3f73e..d61fed2 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -32,7 +32,7 @@ static void of_get_regulation_constraints(struct device_node *np,
 	struct regulator_state *suspend_state;
 	struct device_node *suspend_np;
 	unsigned int mode;
-	int ret, i;
+	int ret, i, len;
 	u32 pval;
 
 	constraints->name = of_get_property(np, "regulator-name", NULL);
@@ -136,6 +136,33 @@ static void of_get_regulation_constraints(struct device_node *np,
 		}
 	}
 
+	len = of_property_count_elems_of_size(np, "regulator-allowed-modes",
+						sizeof(u32));
+	if (len > 0) {
+		if (desc && desc->of_map_mode) {
+			for (i = 0; i < len; i++) {
+				ret = of_property_read_u32_index(np,
+					"regulator-allowed-modes", i, &pval);
+				if (ret) {
+					pr_err("%s: couldn't read allowed modes index %d, ret=%d\n",
+						np->name, i, ret);
+					break;
+				}
+				mode = desc->of_map_mode(pval);
+				if (mode == REGULATOR_MODE_INVALID)
+					pr_err("%s: invalid regulator-allowed-modes element %u\n",
+						np->name, pval);
+				else
+					constraints->valid_modes_mask |= mode;
+			}
+			if (constraints->valid_modes_mask)
+				constraints->valid_ops_mask
+					|= REGULATOR_CHANGE_MODE;
+		} else {
+			pr_warn("%s: mode mapping not defined\n", np->name);
+		}
+	}
+
 	if (!of_property_read_u32(np, "regulator-system-load", &pval))
 		constraints->system_load = pval;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
