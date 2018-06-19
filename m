Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E43C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948B620836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TtLmkKYd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mQ/7qt1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948B620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966630AbeFSNtr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:49:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38254 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966202AbeFSNpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:45:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0AA5D60B1E; Tue, 19 Jun 2018 13:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529415950;
        bh=OKDAmkWdwEhXWEQ1Lox4B9bOvx+ohdXq7GQjl95CoH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TtLmkKYdq2ww0t57bTa0omo0XkW8Ex1fk2F0s/aWhVEEb0G8FBgQUfO1IO2qG7frx
         hzagD1PJQKc8yOlUqHgDFxeyt0YbNEVyvk7IJFCBgS9dOrb5bH6nt1AdIuygRfYdhj
         YKkqErkddMgSFlsZ69eHxS9aaNM9Ef5PvVgvvGB0=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3DF4060B10;
        Tue, 19 Jun 2018 13:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529415948;
        bh=OKDAmkWdwEhXWEQ1Lox4B9bOvx+ohdXq7GQjl95CoH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mQ/7qt1uQyu5wkcZjJBhBzgsvd1FG3xeI3pGk23C2gAyahffI6L2oltOBF/oxgYK8
         v2+T02lVmEuBWSSduqDL0LMGhvV9FN+9WlpnVNacXjWLXbfwChkBZ4Wzrce1Xxrj4P
         Y0Fe5tqX13F/ZlNKsFgi4c1tvMFKj9pthJ0fBo5k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3DF4060B10
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk,
        thierry.escande@linaro.org, ctatlor97@gmail.com
Cc:     sricharan@codeaurora.org
Subject: [PATCH v10 02/14] clk: qcom: Add support for High-Frequency PLLs (HFPLLs)
Date:   Tue, 19 Jun 2018 19:15:13 +0530
Message-Id: <1529415925-28915-3-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
References: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
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
1.9.1

