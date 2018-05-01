Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeEAFEA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 01:04:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46960 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbeEAFD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 01:03:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C0E4602CB
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
Subject: [PATCH v1] clk: qcom: gdsc: Add support to poll CFG register to check GDSC state
Date: Tue,  1 May 2018 10:33:33 +0530
Message-Id: <1525151013-28291-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Nischal <anischal@codeaurora.org>

The default behavior of the GDSC enable/disable sequence is to
poll the status bits of either the actual GDSCR or the
corresponding HW_CTRL registers.

On targets which have support for a CFG_GDSCR register, the
status bits might not show the correct state of the GDSC,
especially in the disable sequence, where the status bit
will be cleared even before the core is completely power
collapsed. On targets with this issue, poll the power on/off
bits in the CFG_GDSCR register instead to correctly determine
the GDSC state.

Signed-off-by: Amit Nischal <anischal@codeaurora.org>
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/gdsc.c | 42 ++++++++++++++++++++++++++----------------
 drivers/clk/qcom/gdsc.h |  1 +
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index cb61c15..2a6b0ff 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -33,6 +33,11 @@
 #define GMEM_CLAMP_IO_MASK	BIT(0)
 #define GMEM_RESET_MASK		BIT(4)

+/* CFG_GDSCR */
+#define GDSC_POWER_UP_COMPLETE		BIT(16)
+#define GDSC_POWER_DOWN_COMPLETE	BIT(15)
+#define CFG_GDSCR_OFFSET		0x4
+
 /* Wait 2^n CXO cycles between all states. Here, n=2 (4 cycles). */
 #define EN_REST_WAIT_VAL	(0x2 << 20)
 #define EN_FEW_WAIT_VAL		(0x8 << 16)
@@ -45,15 +50,28 @@

 #define domain_to_gdsc(domain) container_of(domain, struct gdsc, pd)

-static int gdsc_is_enabled(struct gdsc *sc, unsigned int reg)
+static int gdsc_is_enabled(struct gdsc *sc, bool en)
 {
+	unsigned int reg;
 	u32 val;
 	int ret;

+	if (sc->flags & POLL_CFG_GDSCR)
+		reg = sc->gdscr + CFG_GDSCR_OFFSET;
+	else
+		reg = sc->gds_hw_ctrl ? sc->gds_hw_ctrl : sc->gdscr;
+
 	ret = regmap_read(sc->regmap, reg, &val);
 	if (ret)
 		return ret;

+	if (sc->flags & POLL_CFG_GDSCR) {
+		if (en)
+			return !!(val & GDSC_POWER_UP_COMPLETE);
+		else
+			return !(val & GDSC_POWER_DOWN_COMPLETE);
+	}
+
 	return !!(val & PWR_ON_MASK);
 }

@@ -64,17 +82,17 @@ static int gdsc_hwctrl(struct gdsc *sc, bool en)
 	return regmap_update_bits(sc->regmap, sc->gdscr, HW_CONTROL_MASK, val);
 }

-static int gdsc_poll_status(struct gdsc *sc, unsigned int reg, bool en)
+static int gdsc_poll_status(struct gdsc *sc, bool en)
 {
 	ktime_t start;

 	start = ktime_get();
 	do {
-		if (gdsc_is_enabled(sc, reg) == en)
+		if (gdsc_is_enabled(sc, en) == en)
 			return 0;
 	} while (ktime_us_delta(ktime_get(), start) < TIMEOUT_US);

-	if (gdsc_is_enabled(sc, reg) == en)
+	if (gdsc_is_enabled(sc, en) == en)
 		return 0;

 	return -ETIMEDOUT;
@@ -84,7 +102,6 @@ static int gdsc_toggle_logic(struct gdsc *sc, bool en)
 {
 	int ret;
 	u32 val = en ? 0 : SW_COLLAPSE_MASK;
-	unsigned int status_reg = sc->gdscr;

 	ret = regmap_update_bits(sc->regmap, sc->gdscr, SW_COLLAPSE_MASK, val);
 	if (ret)
@@ -101,8 +118,7 @@ static int gdsc_toggle_logic(struct gdsc *sc, bool en)
 		return 0;
 	}

-	if (sc->gds_hw_ctrl) {
-		status_reg = sc->gds_hw_ctrl;
+	if (sc->gds_hw_ctrl)
 		/*
 		 * The gds hw controller asserts/de-asserts the status bit soon
 		 * after it receives a power on/off request from a master.
@@ -114,9 +130,8 @@ static int gdsc_toggle_logic(struct gdsc *sc, bool en)
 		 * and polling the status bit.
 		 */
 		udelay(1);
-	}

-	return gdsc_poll_status(sc, status_reg, en);
+	return gdsc_poll_status(sc, en);
 }

 static inline int gdsc_deassert_reset(struct gdsc *sc)
@@ -240,8 +255,6 @@ static int gdsc_disable(struct generic_pm_domain *domain)

 	/* Turn off HW trigger mode if supported */
 	if (sc->flags & HW_CTRL) {
-		unsigned int reg;
-
 		ret = gdsc_hwctrl(sc, false);
 		if (ret < 0)
 			return ret;
@@ -253,8 +266,7 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 		 */
 		udelay(1);

-		reg = sc->gds_hw_ctrl ? sc->gds_hw_ctrl : sc->gdscr;
-		ret = gdsc_poll_status(sc, reg, true);
+		ret = gdsc_poll_status(sc, true);
 		if (ret)
 			return ret;
 	}
@@ -276,7 +288,6 @@ static int gdsc_init(struct gdsc *sc)
 {
 	u32 mask, val;
 	int on, ret;
-	unsigned int reg;

 	/*
 	 * Disable HW trigger: collapse/restore occur based on registers writes.
@@ -297,8 +308,7 @@ static int gdsc_init(struct gdsc *sc)
 			return ret;
 	}

-	reg = sc->gds_hw_ctrl ? sc->gds_hw_ctrl : sc->gdscr;
-	on = gdsc_is_enabled(sc, reg);
+	on = gdsc_is_enabled(sc, true);
 	if (on < 0)
 		return on;

diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 9279278..b0cbb87 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -55,6 +55,7 @@ struct gdsc {
 #define HW_CTRL		BIT(2)
 #define SW_RESET	BIT(3)
 #define AON_RESET	BIT(4)
+#define POLL_CFG_GDSCR	BIT(5)
 	struct reset_controller_dev	*rcdev;
 	unsigned int			*resets;
 	unsigned int			reset_count;
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
