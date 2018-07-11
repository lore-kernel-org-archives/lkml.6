Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E084C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5316B2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5316B2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388784AbeGKOoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:44:17 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1668 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388756AbeGKOoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:44:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b46167b0000>; Wed, 11 Jul 2018 07:38:51 -0700
Received: from HQMAIL103.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 11 Jul 2018 07:39:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 11 Jul 2018 07:39:35 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 11 Jul
 2018 14:39:34 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Wed, 11 Jul 2018 14:39:34 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b4616a40000>; Wed, 11 Jul 2018 07:39:34 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v5 2/4] clk: tegra: refactor 7.1 div calculation
Date:   Wed, 11 Jul 2018 17:39:23 +0300
Message-ID: <1531319965-19689-3-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531319965-19689-1-git-send-email-avienamo@nvidia.com>
References: <1531319965-19689-1-git-send-email-avienamo@nvidia.com>
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
---
 drivers/clk/tegra/Makefile      |  1 +
 drivers/clk/tegra/clk-divider.c | 30 +++++-----------------------
 drivers/clk/tegra/clk.h         |  3 +++
 drivers/clk/tegra/div-frac.c    | 43 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 25 deletions(-)
 create mode 100644 drivers/clk/tegra/div-frac.c

diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
index b716923..c79319d 100644
--- a/drivers/clk/tegra/Makefile
+++ b/drivers/clk/tegra/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_ARCH_TEGRA_132_SOC)	+= clk-tegra124.o
 obj-y					+= cvb.o
 obj-$(CONFIG_ARCH_TEGRA_210_SOC)	+= clk-tegra210.o
 obj-$(CONFIG_CLK_TEGRA_BPMP)		+= clk-bpmp.o
+obj-y					+= div-frac.o
diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
index 16e0aee..9305df8 100644
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
+	div = div_frac_get(rate, parent_rate, divider->width, divider->frac_width,
+			   divider->flags);
 
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
diff --git a/drivers/clk/tegra/div-frac.c b/drivers/clk/tegra/div-frac.c
new file mode 100644
index 0000000..b75e19a
--- /dev/null
+++ b/drivers/clk/tegra/div-frac.c
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
+	         u8 frac_width, u8 flags)
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
-- 
2.7.4

