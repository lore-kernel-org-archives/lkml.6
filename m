Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbeDIImI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 04:42:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47722 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751801AbeDIImD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 04:42:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E84896076A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From: Taniya Das <tdas@codeaurora.org>
To: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 1/3] clk: qcom: gdsc: Add support to reset AON and block reset logic
Date: Mon,  9 Apr 2018 14:11:44 +0530
Message-Id: <1523263306-28665-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523263306-28665-1-git-send-email-tdas@codeaurora.org>
References: <1523263306-28665-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Nischal <anischal@codeaurora.org>

For some of the gdsc power domains, there could be need to reset the
AON logic or assert/deassert the block control reset before removing
the clamp_io. Add support for the same by introducing new flags
SW_RESET and AON_RESET. Both SW reset and AON reset requires to be
asserted for at least 1us before being de-asserted.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Amit Nischal <anischal@codeaurora.org>
---
 drivers/clk/qcom/gdsc.c | 22 ++++++++++++++++++++--
 drivers/clk/qcom/gdsc.h |  4 +++-
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index a4f3580..266fefa 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2015, 2017-2018, The Linux Foundation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -31,6 +31,7 @@
 #define HW_CONTROL_MASK		BIT(1)
 #define SW_COLLAPSE_MASK	BIT(0)
 #define GMEM_CLAMP_IO_MASK	BIT(0)
+#define GMEM_RESET_MASK		BIT(4)

 /* Wait 2^n CXO cycles between all states. Here, n=2 (4 cycles). */
 #define EN_REST_WAIT_VAL	(0x2 << 20)
@@ -166,6 +167,14 @@ static inline void gdsc_assert_clamp_io(struct gdsc *sc)
 			   GMEM_CLAMP_IO_MASK, 1);
 }

+static inline void gdsc_assert_reset_aon(struct gdsc *sc)
+{
+	regmap_update_bits(sc->regmap, sc->clamp_io_ctrl,
+			   GMEM_RESET_MASK, 1);
+	udelay(1);
+	regmap_update_bits(sc->regmap, sc->clamp_io_ctrl,
+			   GMEM_RESET_MASK, 0);
+}
 static int gdsc_enable(struct generic_pm_domain *domain)
 {
 	struct gdsc *sc = domain_to_gdsc(domain);
@@ -174,8 +183,17 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 	if (sc->pwrsts == PWRSTS_ON)
 		return gdsc_deassert_reset(sc);

-	if (sc->flags & CLAMP_IO)
+	if (sc->flags & SW_RESET) {
+		gdsc_assert_reset(sc);
+		udelay(1);
+		gdsc_deassert_reset(sc);
+	}
+
+	if (sc->flags & CLAMP_IO) {
+		if (sc->flags & AON_RESET)
+			gdsc_assert_reset_aon(sc);
 		gdsc_deassert_clamp_io(sc);
+	}

 	ret = gdsc_toggle_logic(sc, true);
 	if (ret)
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 3964834..9279278 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2015, 2017-2018, The Linux Foundation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -53,6 +53,8 @@ struct gdsc {
 #define VOTABLE		BIT(0)
 #define CLAMP_IO	BIT(1)
 #define HW_CTRL		BIT(2)
+#define SW_RESET	BIT(3)
+#define AON_RESET	BIT(4)
 	struct reset_controller_dev	*rcdev;
 	unsigned int			*resets;
 	unsigned int			reset_count;
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
