Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CE7C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FC52170D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BDFMHqZZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eX92GosV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5FC52170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbeHNPBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:01:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42064 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbeHNPBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:01:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9114960D73; Tue, 14 Aug 2018 12:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534248859;
        bh=oPzBWrJqOQpgPDh0NZfQEDAZcc1621b/nyifppGiLGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BDFMHqZZ10tLVRPoUMrSQvvApXUVWq0PbWsuNd3ZsPzLOpH8IYW3LrZVRQ0WGgLhW
         7J4N2B5RZER99FrHr1tZLbdRxaRjO1euYDcloXdujo6YlH+UQu3sVb0ScuHoKhdEuM
         cwuyMuVePsn/ZvyhFDBs242Gvdlh/NcMq720sO3M=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2100960D70;
        Tue, 14 Aug 2018 12:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534248818;
        bh=oPzBWrJqOQpgPDh0NZfQEDAZcc1621b/nyifppGiLGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eX92GosVtciLPSqB5G4lCUByOqfjYyUdRKWXjd0wpRyfCqdyjrL/wQBBunl/4NohP
         fyqVPKJnYHeh9Bs4Vwctz4rZ1kjWJ++G8L42y7HTvUw+RXd9tQKX06Vb2e5re4D3YB
         8oc5LImuV8BuPGdyYYoYvNgUb3rIym9ZCcnZ+lSk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2100960D70
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
Subject: [PATCH v12 07/14] clk: qcom: Add support for Krait clocks
Date:   Tue, 14 Aug 2018 17:42:26 +0530
Message-Id: <1534248753-2440-8-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

The Krait clocks are made up of a series of muxes and a divider
that choose between a fixed rate clock and dedicated HFPLLs for
each CPU. Instead of using mmio accesses to remux parents, the
Krait implementation exposes the remux control via cp15
registers. Support these clocks.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/clk/qcom/Kconfig     |   4 ++
 drivers/clk/qcom/Makefile    |   1 +
 drivers/clk/qcom/clk-krait.c | 124 +++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clk-krait.h |  37 +++++++++++++
 4 files changed, 166 insertions(+)
 create mode 100644 drivers/clk/qcom/clk-krait.c
 create mode 100644 drivers/clk/qcom/clk-krait.h

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 21aec10..ada4160 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -280,3 +280,7 @@ config QCOM_HFPLL
 	  Support for the high-frequency PLLs present on Qualcomm devices.
 	  Say Y if you want to support CPU frequency scaling on devices
 	  such as MSM8974, APQ8084, etc.
+
+config KRAIT_CLOCKS
+	bool
+	select KRAIT_L2_ACCESSORS
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index f82eeac..506c4cf 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -11,6 +11,7 @@ clk-qcom-y += clk-branch.o
 clk-qcom-y += clk-regmap-divider.o
 clk-qcom-y += clk-regmap-mux.o
 clk-qcom-y += clk-regmap-mux-div.o
+clk-qcom-$(CONFIG_KRAIT_CLOCKS) += clk-krait.o
 clk-qcom-y += clk-hfpll.o
 clk-qcom-y += reset.o
 clk-qcom-$(CONFIG_QCOM_GDSC) += gdsc.o
diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
new file mode 100644
index 0000000..2e41767
--- /dev/null
+++ b/drivers/clk/qcom/clk-krait.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/clk-provider.h>
+#include <linux/spinlock.h>
+
+#include <asm/krait-l2-accessors.h>
+
+#include "clk-krait.h"
+
+/* Secondary and primary muxes share the same cp15 register */
+static DEFINE_SPINLOCK(krait_clock_reg_lock);
+
+#define LPL_SHIFT	8
+static void __krait_mux_set_sel(struct krait_mux_clk *mux, int sel)
+{
+	unsigned long flags;
+	u32 regval;
+
+	spin_lock_irqsave(&krait_clock_reg_lock, flags);
+	regval = krait_get_l2_indirect_reg(mux->offset);
+	regval &= ~(mux->mask << mux->shift);
+	regval |= (sel & mux->mask) << mux->shift;
+	if (mux->lpl) {
+		regval &= ~(mux->mask << (mux->shift + LPL_SHIFT));
+		regval |= (sel & mux->mask) << (mux->shift + LPL_SHIFT);
+	}
+	krait_set_l2_indirect_reg(mux->offset, regval);
+	spin_unlock_irqrestore(&krait_clock_reg_lock, flags);
+
+	/* Wait for switch to complete. */
+	mb();
+	udelay(1);
+}
+
+static int krait_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct krait_mux_clk *mux = to_krait_mux_clk(hw);
+	u32 sel;
+
+	sel = clk_mux_reindex(index, mux->parent_map, 0);
+	mux->en_mask = sel;
+	/* Don't touch mux if CPU is off as it won't work */
+	if (__clk_is_enabled(hw->clk))
+		__krait_mux_set_sel(mux, sel);
+
+	return 0;
+}
+
+static u8 krait_mux_get_parent(struct clk_hw *hw)
+{
+	struct krait_mux_clk *mux = to_krait_mux_clk(hw);
+	u32 sel;
+
+	sel = krait_get_l2_indirect_reg(mux->offset);
+	sel >>= mux->shift;
+	sel &= mux->mask;
+	mux->en_mask = sel;
+
+	return clk_mux_get_parent(hw, sel, mux->parent_map, 0);
+}
+
+const struct clk_ops krait_mux_clk_ops = {
+	.set_parent = krait_mux_set_parent,
+	.get_parent = krait_mux_get_parent,
+	.determine_rate = __clk_mux_determine_rate_closest,
+};
+EXPORT_SYMBOL_GPL(krait_mux_clk_ops);
+
+/* The divider can divide by 2, 4, 6 and 8. But we only really need div-2. */
+static long krait_div2_round_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long *parent_rate)
+{
+	*parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), rate * 2);
+	return DIV_ROUND_UP(*parent_rate, 2);
+}
+
+static int krait_div2_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct krait_div2_clk *d = to_krait_div2_clk(hw);
+	unsigned long flags;
+	u32 val;
+	u32 mask = BIT(d->width) - 1;
+
+	if (d->lpl)
+		mask = mask << (d->shift + LPL_SHIFT) | mask << d->shift;
+
+	spin_lock_irqsave(&krait_clock_reg_lock, flags);
+	val = krait_get_l2_indirect_reg(d->offset);
+	val &= ~mask;
+	krait_set_l2_indirect_reg(d->offset, val);
+	spin_unlock_irqrestore(&krait_clock_reg_lock, flags);
+
+	return 0;
+}
+
+static unsigned long
+krait_div2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct krait_div2_clk *d = to_krait_div2_clk(hw);
+	u32 mask = BIT(d->width) - 1;
+	u32 div;
+
+	div = krait_get_l2_indirect_reg(d->offset);
+	div >>= d->shift;
+	div &= mask;
+	div = (div + 1) * 2;
+
+	return DIV_ROUND_UP(parent_rate, div);
+}
+
+const struct clk_ops krait_div2_clk_ops = {
+	.round_rate = krait_div2_round_rate,
+	.set_rate = krait_div2_set_rate,
+	.recalc_rate = krait_div2_recalc_rate,
+};
+EXPORT_SYMBOL_GPL(krait_div2_clk_ops);
diff --git a/drivers/clk/qcom/clk-krait.h b/drivers/clk/qcom/clk-krait.h
new file mode 100644
index 0000000..441ba1e
--- /dev/null
+++ b/drivers/clk/qcom/clk-krait.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __QCOM_CLK_KRAIT_H
+#define __QCOM_CLK_KRAIT_H
+
+#include <linux/clk-provider.h>
+
+struct krait_mux_clk {
+	unsigned int	*parent_map;
+	u32		offset;
+	u32		mask;
+	u32		shift;
+	u32		en_mask;
+	bool		lpl;
+
+	struct clk_hw	hw;
+	struct notifier_block   clk_nb;
+};
+
+#define to_krait_mux_clk(_hw) container_of(_hw, struct krait_mux_clk, hw)
+
+extern const struct clk_ops krait_mux_clk_ops;
+
+struct krait_div2_clk {
+	u32		offset;
+	u8		width;
+	u32		shift;
+	bool		lpl;
+
+	struct clk_hw	hw;
+};
+
+#define to_krait_div2_clk(_hw) container_of(_hw, struct krait_div2_clk, hw)
+
+extern const struct clk_ops krait_div2_clk_ops;
+
+#endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

