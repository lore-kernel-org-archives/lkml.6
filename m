Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E2CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3F9217BC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jUYnGeVN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OF9Z6f4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3F9217BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbeHMQS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:18:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51836 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbeHMQS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:18:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DF44160BE8; Mon, 13 Aug 2018 13:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534167397;
        bh=WG6rA8ZTIE5sy8qHFSEycl1t3b5j4Rf+ynXKXdwbx7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUYnGeVNs/cWQyKf3oQ/5hHdsj9fSIp3/084Pf23y3QalrCOAL+81db1PEdhfeozz
         4J3azTvTSl+jDvlAS6dFe8ZAybw56iTePGEJVy2KK9/OxJjdhGqsu2xdu2MkGHwLb4
         b/LMIbmC6veu2v+b1sCDmw1n2Pawip5yr/HuTVdA=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D0D860B1A;
        Mon, 13 Aug 2018 13:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534167394;
        bh=WG6rA8ZTIE5sy8qHFSEycl1t3b5j4Rf+ynXKXdwbx7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OF9Z6f4okvef+6JGJggSel0sek78wLHs5JZZLADo3JnlV8fwWIbf05wTkUbUK1csG
         wNylE1EqEXnWCRSWZ8QJY1f/pDQncw57OFSYc/1iCoHNXcwD5p8jByIqWhEYE6FUkc
         Xb2VOafTp9szzlxABPbSxtFT3LfBjjL8r3BW0A1Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D0D860B1A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     mark.rutland@arm.com, robh@kernel.org, sudeep.holla@arm.com,
        linux@arm.linux.org.uk, ctatlor97@gmail.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, sboyd@codeaurora.org,
        linux@armlinux.org.uk, thierry.escande@linaro.org,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        niklas.cassel@linaro.org
Cc:     sricharan@codeaurora.org
Subject: [PATCH 02/14] clk: qcom: Add support for High-Frequency PLLs (HFPLLs)
Date:   Mon, 13 Aug 2018 19:05:55 +0530
Message-Id: <1534167367-17545-3-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534167367-17545-1-git-send-email-sricharan@codeaurora.org>
References: <1534167367-17545-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

HFPLLs are the main frequency source for Krait CPU clocks. Add
support for changing the rate of these PLLs.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/Makefile    |   1 +
 drivers/clk/qcom/clk-hfpll.c | 244 +++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clk-hfpll.h |  44 ++++++++
 3 files changed, 289 insertions(+)
 create mode 100644 drivers/clk/qcom/clk-hfpll.c
 create mode 100644 drivers/clk/qcom/clk-hfpll.h

diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 762c011..1331ed7 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -11,6 +11,7 @@ clk-qcom-y += clk-branch.o
 clk-qcom-y += clk-regmap-divider.o
 clk-qcom-y += clk-regmap-mux.o
 clk-qcom-y += clk-regmap-mux-div.o
+clk-qcom-y += clk-hfpll.o
 clk-qcom-y += reset.o
 clk-qcom-$(CONFIG_QCOM_GDSC) += gdsc.o
 
diff --git a/drivers/clk/qcom/clk-hfpll.c b/drivers/clk/qcom/clk-hfpll.c
new file mode 100644
index 0000000..3c04805
--- /dev/null
+++ b/drivers/clk/qcom/clk-hfpll.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/clk-provider.h>
+#include <linux/spinlock.h>
+
+#include "clk-regmap.h"
+#include "clk-hfpll.h"
+
+#define PLL_OUTCTRL	BIT(0)
+#define PLL_BYPASSNL	BIT(1)
+#define PLL_RESET_N	BIT(2)
+
+/* Initialize a HFPLL at a given rate and enable it. */
+static void __clk_hfpll_init_once(struct clk_hw *hw)
+{
+	struct clk_hfpll *h = to_clk_hfpll(hw);
+	struct hfpll_data const *hd = h->d;
+	struct regmap *regmap = h->clkr.regmap;
+
+	if (likely(h->init_done))
+		return;
+
+	/* Configure PLL parameters for integer mode. */
+	if (hd->config_val)
+		regmap_write(regmap, hd->config_reg, hd->config_val);
+	regmap_write(regmap, hd->m_reg, 0);
+	regmap_write(regmap, hd->n_reg, 1);
+
+	if (hd->user_reg) {
+		u32 regval = hd->user_val;
+		unsigned long rate;
+
+		rate = clk_hw_get_rate(hw);
+
+		/* Pick the right VCO. */
+		if (hd->user_vco_mask && rate > hd->low_vco_max_rate)
+			regval |= hd->user_vco_mask;
+		regmap_write(regmap, hd->user_reg, regval);
+	}
+
+	if (hd->droop_reg)
+		regmap_write(regmap, hd->droop_reg, hd->droop_val);
+
+	h->init_done = true;
+}
+
+static void __clk_hfpll_enable(struct clk_hw *hw)
+{
+	struct clk_hfpll *h = to_clk_hfpll(hw);
+	struct hfpll_data const *hd = h->d;
+	struct regmap *regmap = h->clkr.regmap;
+	u32 val;
+
+	__clk_hfpll_init_once(hw);
+
+	/* Disable PLL bypass mode. */
+	regmap_update_bits(regmap, hd->mode_reg, PLL_BYPASSNL, PLL_BYPASSNL);
+
+	/*
+	 * H/W requires a 5us delay between disabling the bypass and
+	 * de-asserting the reset. Delay 10us just to be safe.
+	 */
+	udelay(10);
+
+	/* De-assert active-low PLL reset. */
+	regmap_update_bits(regmap, hd->mode_reg, PLL_RESET_N, PLL_RESET_N);
+
+	/* Wait for PLL to lock. */
+	if (hd->status_reg) {
+		do {
+			regmap_read(regmap, hd->status_reg, &val);
+		} while (!(val & BIT(hd->lock_bit)));
+	} else {
+		udelay(60);
+	}
+
+	/* Enable PLL output. */
+	regmap_update_bits(regmap, hd->mode_reg, PLL_OUTCTRL, PLL_OUTCTRL);
+}
+
+/* Enable an already-configured HFPLL. */
+static int clk_hfpll_enable(struct clk_hw *hw)
+{
+	unsigned long flags;
+	struct clk_hfpll *h = to_clk_hfpll(hw);
+	struct hfpll_data const *hd = h->d;
+	struct regmap *regmap = h->clkr.regmap;
+	u32 mode;
+
+	spin_lock_irqsave(&h->lock, flags);
+	regmap_read(regmap, hd->mode_reg, &mode);
+	if (!(mode & (PLL_BYPASSNL | PLL_RESET_N | PLL_OUTCTRL)))
+		__clk_hfpll_enable(hw);
+	spin_unlock_irqrestore(&h->lock, flags);
+
+	return 0;
+}
+
+static void __clk_hfpll_disable(struct clk_hfpll *h)
+{
+	struct hfpll_data const *hd = h->d;
+	struct regmap *regmap = h->clkr.regmap;
+
+	/*
+	 * Disable the PLL output, disable test mode, enable the bypass mode,
+	 * and assert the reset.
+	 */
+	regmap_update_bits(regmap, hd->mode_reg,
+			   PLL_BYPASSNL | PLL_RESET_N | PLL_OUTCTRL, 0);
+}
+
+static void clk_hfpll_disable(struct clk_hw *hw)
+{
+	struct clk_hfpll *h = to_clk_hfpll(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(&h->lock, flags);
+	__clk_hfpll_disable(h);
+	spin_unlock_irqrestore(&h->lock, flags);
+}
+
+static long clk_hfpll_round_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long *parent_rate)
+{
+	struct clk_hfpll *h = to_clk_hfpll(hw);
+	struct hfpll_data const *hd = h->d;
+	unsigned long rrate;
+
+	rate = clamp(rate, hd->min_rate, hd->max_rate);
+
+	rrate = DIV_ROUND_UP(rate, *parent_rate) * *parent_rate;
+	if (rrate > hd->max_rate)
+		rrate -= *parent_rate;
+
+	return rrate;
+}
+
+/*
+ * For optimization reasons, assumes no downstream clocks are actively using
+ * it.
+ */
+static int clk_hfpll_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	struct clk_hfpll *h = to_clk_hfpll(hw);
+	struct hfpll_data const *hd = h->d;
+	struct regmap *regmap = h->clkr.regmap;
+	unsigned long flags;
+	u32 l_val, val;
+	bool enabled;
+
+	l_val = rate / parent_rate;
+
+	spin_lock_irqsave(&h->lock, flags);
+
+	enabled = __clk_is_enabled(hw->clk);
+	if (enabled)
+		__clk_hfpll_disable(h);
+
+	/* Pick the right VCO. */
+	if (hd->user_reg && hd->user_vco_mask) {
+		regmap_read(regmap, hd->user_reg, &val);
+		if (rate <= hd->low_vco_max_rate)
+			val &= ~hd->user_vco_mask;
+		else
+			val |= hd->user_vco_mask;
+		regmap_write(regmap, hd->user_reg, val);
+	}
+
+	regmap_write(regmap, hd->l_reg, l_val);
+
+	if (enabled)
+		__clk_hfpll_enable(hw);
+
+	spin_unlock_irqrestore(&h->lock, flags);
+
+	return 0;
+}
+
+static unsigned long clk_hfpll_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct clk_hfpll *h = to_clk_hfpll(hw);
+	struct hfpll_data const *hd = h->d;
+	struct regmap *regmap = h->clkr.regmap;
+	u32 l_val;
+
+	regmap_read(regmap, hd->l_reg, &l_val);
+
+	return l_val * parent_rate;
+}
+
+static void clk_hfpll_init(struct clk_hw *hw)
+{
+	struct clk_hfpll *h = to_clk_hfpll(hw);
+	struct hfpll_data const *hd = h->d;
+	struct regmap *regmap = h->clkr.regmap;
+	u32 mode, status;
+
+	regmap_read(regmap, hd->mode_reg, &mode);
+	if (mode != (PLL_BYPASSNL | PLL_RESET_N | PLL_OUTCTRL)) {
+		__clk_hfpll_init_once(hw);
+		return;
+	}
+
+	if (hd->status_reg) {
+		regmap_read(regmap, hd->status_reg, &status);
+		if (!(status & BIT(hd->lock_bit))) {
+			WARN(1, "HFPLL %s is ON, but not locked!\n",
+			     __clk_get_name(hw->clk));
+			clk_hfpll_disable(hw);
+			__clk_hfpll_init_once(hw);
+		}
+	}
+}
+
+static int hfpll_is_enabled(struct clk_hw *hw)
+{
+	struct clk_hfpll *h = to_clk_hfpll(hw);
+	struct hfpll_data const *hd = h->d;
+	struct regmap *regmap = h->clkr.regmap;
+	u32 mode;
+
+	regmap_read(regmap, hd->mode_reg, &mode);
+	mode &= 0x7;
+	return mode == (PLL_BYPASSNL | PLL_RESET_N | PLL_OUTCTRL);
+}
+
+const struct clk_ops clk_ops_hfpll = {
+	.enable = clk_hfpll_enable,
+	.disable = clk_hfpll_disable,
+	.is_enabled = hfpll_is_enabled,
+	.round_rate = clk_hfpll_round_rate,
+	.set_rate = clk_hfpll_set_rate,
+	.recalc_rate = clk_hfpll_recalc_rate,
+	.init = clk_hfpll_init,
+};
+EXPORT_SYMBOL_GPL(clk_ops_hfpll);
diff --git a/drivers/clk/qcom/clk-hfpll.h b/drivers/clk/qcom/clk-hfpll.h
new file mode 100644
index 0000000..2a57b2f
--- /dev/null
+++ b/drivers/clk/qcom/clk-hfpll.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __QCOM_CLK_HFPLL_H__
+#define __QCOM_CLK_HFPLL_H__
+
+#include <linux/clk-provider.h>
+#include <linux/spinlock.h>
+#include "clk-regmap.h"
+
+struct hfpll_data {
+	u32 mode_reg;
+	u32 l_reg;
+	u32 m_reg;
+	u32 n_reg;
+	u32 user_reg;
+	u32 droop_reg;
+	u32 config_reg;
+	u32 status_reg;
+	u8  lock_bit;
+
+	u32 droop_val;
+	u32 config_val;
+	u32 user_val;
+	u32 user_vco_mask;
+	unsigned long low_vco_max_rate;
+
+	unsigned long min_rate;
+	unsigned long max_rate;
+};
+
+struct clk_hfpll {
+	struct hfpll_data const *d;
+	int init_done;
+
+	struct clk_regmap clkr;
+	spinlock_t lock;
+};
+
+#define to_clk_hfpll(_hw) \
+	container_of(to_clk_regmap(_hw), struct clk_hfpll, clkr)
+
+extern const struct clk_ops clk_ops_hfpll;
+
+#endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

