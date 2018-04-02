Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754495AbeDBKqY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 06:46:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51846 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754417AbeDBKqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 06:46:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0259160224
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
Subject: [PATCH 2/3] clk: qcom: gdsc: Add support to poll for higher timeout value
Date: Mon,  2 Apr 2018 16:15:44 +0530
Message-Id: <1522665945-28147-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522665945-28147-1-git-send-email-tdas@codeaurora.org>
References: <1522665945-28147-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Nischal <anischal@codeaurora.org>

For some gdscs, it might take longer time up to 500us for
updating their status. So add support for the same by
defining a new flag 'GDS_TIMEOUT' to mark such gdsc in
order to poll their status for longer timeout value.

Signed-off-by: Amit Nischal <anischal@codeaurora.org>
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/gdsc.c | 9 +++++++--
 drivers/clk/qcom/gdsc.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 266fefa..e89584e 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -42,6 +42,7 @@
 #define RETAIN_PERIPH		BIT(13)

 #define TIMEOUT_US		100
+#define TIMEOUT_US_GDS		500

 #define domain_to_gdsc(domain) container_of(domain, struct gdsc, pd)

@@ -67,12 +68,14 @@ static int gdsc_hwctrl(struct gdsc *sc, bool en)
 static int gdsc_poll_status(struct gdsc *sc, unsigned int reg, bool en)
 {
 	ktime_t start;
+	ktime_t timeout =
+		(sc->flags & GDS_TIMEOUT) ? TIMEOUT_US_GDS : TIMEOUT_US;

 	start = ktime_get();
 	do {
 		if (gdsc_is_enabled(sc, reg) == en)
 			return 0;
-	} while (ktime_us_delta(ktime_get(), start) < TIMEOUT_US);
+	} while (ktime_us_delta(ktime_get(), start) < timeout);

 	if (gdsc_is_enabled(sc, reg) == en)
 		return 0;
@@ -85,6 +88,8 @@ static int gdsc_toggle_logic(struct gdsc *sc, bool en)
 	int ret;
 	u32 val = en ? 0 : SW_COLLAPSE_MASK;
 	unsigned int status_reg = sc->gdscr;
+	ktime_t timeout =
+		(sc->flags & GDS_TIMEOUT) ? TIMEOUT_US_GDS : TIMEOUT_US;

 	ret = regmap_update_bits(sc->regmap, sc->gdscr, SW_COLLAPSE_MASK, val);
 	if (ret)
@@ -97,7 +102,7 @@ static int gdsc_toggle_logic(struct gdsc *sc, bool en)
 		 * right after it was disabled does not put it in an
 		 * unknown state
 		 */
-		udelay(TIMEOUT_US);
+		udelay(timeout);
 		return 0;
 	}

diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index 9279278..2e3abbf 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -55,6 +55,7 @@ struct gdsc {
 #define HW_CTRL		BIT(2)
 #define SW_RESET	BIT(3)
 #define AON_RESET	BIT(4)
+#define GDS_TIMEOUT	BIT(5)
 	struct reset_controller_dev	*rcdev;
 	unsigned int			*resets;
 	unsigned int			reset_count;
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
