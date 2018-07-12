Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953E1C468C7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5943F213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5943F213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeGLMCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:02:25 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19783 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeGLMCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:02:24 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b4741220000>; Thu, 12 Jul 2018 04:53:06 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 12 Jul 2018 04:53:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 12 Jul 2018 04:53:11 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 12 Jul
 2018 11:53:11 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Thu, 12 Jul 2018 11:53:11 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b4741250000>; Thu, 12 Jul 2018 04:53:11 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v6 2/4] clk: tegra: Refactor fractional divider calculation
Date:   Thu, 12 Jul 2018 14:53:00 +0300
Message-ID: <1531396382-5579-3-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531396382-5579-1-git-send-email-avienamo@nvidia.com>
References: <1531396382-5579-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter De Schrijver <pdeschrijver@nvidia.com>

Move this to a separate file so it can be used to calculate the sdmmc
clock dividers.

Signed-off-by: Peter De-Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/clk/tegra/Makefile      |  1 +
 drivers/clk/tegra/clk-divider.c | 30 +++++-----------------------
 drivers/clk/tegra/clk-utils.c   | 43 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/tegra/clk.h         |  3 +++
 4 files changed, 52 insertions(+), 25 deletions(-)
 create mode 100644 drivers/clk/tegra/clk-utils.c

diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
index b716923..c77d072 100644
--- a/drivers/clk/tegra/Makefile
+++ b/drivers/clk/tegra/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_ARCH_TEGRA_132_SOC)	+= clk-tegra124.o
 obj-y					+= cvb.o
 obj-$(CONFIG_ARCH_TEGRA_210_SOC)	+= clk-tegra210.o
 obj-$(CONFIG_CLK_TEGRA_BPMP)		+= clk-bpmp.o
+obj-y					+= clk-utils.o
diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
index 16e0aee..8f175ff 100644
--- a/drivers/clk/tegra/clk-divider.c
+++ b/drivers/clk/tegra/clk-divider.c
@@ -32,35 +32,15 @@
 static int get_div(struct tegra_clk_frac_div *divider, unsigned long rate,
 		   unsigned long parent_rate)
 {
-	u64 divider_ux1 = parent_rate;
-	u8 flags = divider->flags;
-	int mul;
-
-	if (!rate)
-		return 0;
-
-	mul = get_mul(divider);
-
-	if (!(flags & TEGRA_DIVIDER_INT))
-		divider_ux1 *= mul;
-
-	if (flags & TEGRA_DIVIDER_ROUND_UP)
-		divider_ux1 += rate - 1;
-
-	do_div(divider_ux1, rate);
-
-	if (flags & TEGRA_DIVIDER_INT)
-		divider_ux1 *= mul;
+	int div;
 
-	divider_ux1 -= mul;
+	div = div_frac_get(rate, parent_rate, divider->width,
+			   divider->frac_width, divider->flags);
 
-	if ((s64)divider_ux1 < 0)
+	if (div < 0)
 		return 0;
 
-	if (divider_ux1 > get_max_div(divider))
-		return get_max_div(divider);
-
-	return divider_ux1;
+	return div;
 }
 
 static unsigned long clk_frac_div_recalc_rate(struct clk_hw *hw,
diff --git a/drivers/clk/tegra/clk-utils.c b/drivers/clk/tegra/clk-utils.c
new file mode 100644
index 0000000..1a5daae
--- /dev/null
+++ b/drivers/clk/tegra/clk-utils.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
+ */
+
+#include <asm/div64.h>
+
+#include "clk.h"
+
+#define div_mask(w) ((1 << (w)) - 1)
+
+int div_frac_get(unsigned long rate, unsigned parent_rate, u8 width,
+		 u8 frac_width, u8 flags)
+{
+	u64 divider_ux1 = parent_rate;
+	int mul;
+
+	if (!rate)
+		return 0;
+
+	mul = 1 << frac_width;
+
+	if (!(flags & TEGRA_DIVIDER_INT))
+		divider_ux1 *= mul;
+
+	if (flags & TEGRA_DIVIDER_ROUND_UP)
+		divider_ux1 += rate - 1;
+
+	do_div(divider_ux1, rate);
+
+	if (flags & TEGRA_DIVIDER_INT)
+		divider_ux1 *= mul;
+
+	if (divider_ux1 < mul)
+		return 0;
+
+	divider_ux1 -= mul;
+
+	if (divider_ux1 > div_mask(width))
+		return div_mask(width);
+
+	return divider_ux1;
+}
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index e3b9c22..c733841 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -812,6 +812,9 @@ extern tegra_clk_apply_init_table_func tegra_clk_apply_init_table;
 int tegra_pll_wait_for_lock(struct tegra_clk_pll *pll);
 u16 tegra_pll_get_fixed_mdiv(struct clk_hw *hw, unsigned long input_rate);
 int tegra_pll_p_div_to_hw(struct tegra_clk_pll *pll, u8 p_div);
+int div_frac_get(unsigned long rate, unsigned parent_rate, u8 width,
+		 u8 frac_width, u8 flags);
+
 
 /* Combined read fence with delay */
 #define fence_udelay(delay, reg)	\
-- 
2.7.4

