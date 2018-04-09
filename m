Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbeDIImV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 04:42:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47936 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbeDIImS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 04:42:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E78660AFB
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
Subject: [PATCH v2 3/3] clk: qcom: gdsc: Add support to poll CFG register to check GDSC state
Date: Mon,  9 Apr 2018 14:11:46 +0530
Message-Id: <1523263306-28665-4-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523263306-28665-1-git-send-email-tdas@codeaurora.org>
References: <1523263306-28665-1-git-send-email-tdas@codeaurora.org>
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
 drivers/clk/qcom/gdsc.c | 39 +++++++++++++++++++++++++++++++++++----
 drivers/clk/qcom/gdsc.h |  1 +
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index cb61c15..2dda2d5 100644
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
@@ -64,18 +69,43 @@ static int gdsc_hwctrl(struct gdsc *sc, bool en)
 	return regmap_update_bits(sc->regmap, sc->gdscr, HW_CONTROL_MASK, val);
 }

+static int gdsc_is_enabled_by_poll_cfg_reg(struct gdsc *sc, bool en)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(sc->regmap, sc->gdscr + CFG_GDSCR_OFFSET, &val);
+	if (ret)
+		return ret;
+
+	if (en)
+		return !!(val & GDSC_POWER_UP_COMPLETE);
+
+	return !(val & GDSC_POWER_DOWN_COMPLETE);
+}
+
 static int gdsc_poll_status(struct gdsc *sc, unsigned int reg, bool en)
 {
 	ktime_t start;

 	start = ktime_get();
 	do {
-		if (gdsc_is_enabled(sc, reg) == en)
-			return 0;
+		if (sc->flags & POLL_CFG_GDSCR) {
+			if (gdsc_is_enabled_by_poll_cfg_reg(sc, en) == en)
+				return 0;
+		} else {
+			if (gdsc_is_enabled(sc, reg) == en)
+				return 0;
+		}
 	} while (ktime_us_delta(ktime_get(), start) < TIMEOUT_US);

-	if (gdsc_is_enabled(sc, reg) == en)
-		return 0;
+	if (sc->flags & POLL_CFG_GDSCR) {
+		if (gdsc_is_enabled_by_poll_cfg_reg(sc, en) == en)
+			return 0;
+	} else {
+		if (gdsc_is_enabled(sc, reg) == en)
+			return 0;
+	}

 	return -ETIMEDOUT;
 }
@@ -254,6 +284,7 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 		udelay(1);

 		reg = sc->gds_hw_ctrl ? sc->gds_hw_ctrl : sc->gdscr;
+
 		ret = gdsc_poll_status(sc, reg, true);
 		if (ret)
 			return ret;
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 9279278..0f992e8 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -55,6 +55,7 @@ struct gdsc {
 #define HW_CTRL		BIT(2)
 #define SW_RESET	BIT(3)
 #define AON_RESET	BIT(4)
+#define POLL_CFG_GDSCR  BIT(5)
 	struct reset_controller_dev	*rcdev;
 	unsigned int			*resets;
 	unsigned int			reset_count;
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
