Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B80C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB84720883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h8yvxVLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB84720883
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932899AbeFUIL1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:11:27 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:35554 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932528AbeFUILU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:11:20 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllnx209.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5L8BIHP027381;
        Thu, 21 Jun 2018 03:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529568678;
        bh=Weg7f9qi6x/8kAvKCLew8vFIGtHWXgHu+ifOV7oNdF4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=h8yvxVLfsMs0Z5l9zqVZibHifEYqAE6rsbkJGsmvl6oNCirQQECpI4IYr7ABuMMt3
         Yw4v7ta8nwnZrsgitkuNZvxP1uGTDDTzsuSgmGcrZC5Jd+F8j8pzGnPyAmnHg/FcKJ
         Ys6gVQ1gVpV9NklApg0KqdnLtIFS/Mg51Cg0wYg0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5L8BH0T020258;
        Thu, 21 Jun 2018 03:11:18 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 21
 Jun 2018 03:11:16 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 21 Jun 2018 03:11:16 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5L8B5aX024513;
        Thu, 21 Jun 2018 03:11:14 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <t-kristo@ti.com>, <sboyd@kernel.org>, <tony@atomide.com>
CC:     <linux-clk@vger.kernel.org>, <d-gerlach@ti.com>,
        <linux-omap@vger.kernel.org.org>, <linux-kernel@vger.kernel.org>,
        <j-keerthy@ti.com>, Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH v2 3/4] clk: ti: Add functions to save/restore clk context
Date:   Thu, 21 Jun 2018 13:40:19 +0530
Message-ID: <1529568620-19765-4-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529568620-19765-1-git-send-email-j-keerthy@ti.com>
References: <1529568620-19765-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russ Dill <Russ.Dill@ti.com>

SoCs like AM43XX lose clock registers context during RTC-only
suspend. Hence add functions to save/restore the clock registers
context.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---

Changes in v2:

        * Replaced clk_dflt_restore instances to clk_gate_restore_context

 drivers/clk/ti/clock.h    |   2 +
 drivers/clk/ti/divider.c  |  36 ++++++++++++++
 drivers/clk/ti/dpll.c     |   6 +++
 drivers/clk/ti/dpll3xxx.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/ti/gate.c     |   3 ++
 drivers/clk/ti/mux.c      |  29 +++++++++++
 include/linux/clk/ti.h    |   6 +++
 7 files changed, 206 insertions(+)

diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index b582780..26fbdf2 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -24,6 +24,7 @@ struct clk_omap_divider {
 	u8			flags;
 	s8			latch;
 	const struct clk_div_table	*table;
+	u32		context;
 };
 
 #define to_clk_omap_divider(_hw) container_of(_hw, struct clk_omap_divider, hw)
@@ -36,6 +37,7 @@ struct clk_omap_mux {
 	u8			shift;
 	s8			latch;
 	u8			flags;
+	u8			saved_parent;
 };
 
 #define to_clk_omap_mux(_hw) container_of(_hw, struct clk_omap_mux, hw)
diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index aaa277d..4418e0d 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -268,10 +268,46 @@ static int ti_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+/**
+ * clk_divider_save_context - Save the divider value
+ * @hw: pointer  struct clk_hw
+ *
+ * Save the divider value
+ */
+static int clk_divider_save_context(struct clk_hw *hw)
+{
+	struct clk_omap_divider *divider = to_clk_omap_divider(hw);
+	u32 val;
+
+	val = ti_clk_ll_ops->clk_readl(&divider->reg) >> divider->shift;
+	divider->context = val & div_mask(divider);
+
+	return 0;
+}
+
+/**
+ * clk_divider_restore_context - restore the saved the divider value
+ * @hw: pointer  struct clk_hw
+ *
+ * Restore the saved the divider value
+ */
+static void clk_divider_restore_context(struct clk_hw *hw)
+{
+	struct clk_omap_divider *divider = to_clk_omap_divider(hw);
+	u32 val;
+
+	val = ti_clk_ll_ops->clk_readl(&divider->reg);
+	val &= ~(div_mask(divider) << divider->shift);
+	val |= divider->context << divider->shift;
+	ti_clk_ll_ops->clk_writel(val, &divider->reg);
+}
+
 const struct clk_ops ti_clk_divider_ops = {
 	.recalc_rate = ti_clk_divider_recalc_rate,
 	.round_rate = ti_clk_divider_round_rate,
 	.set_rate = ti_clk_divider_set_rate,
+	.save_context = clk_divider_save_context,
+	.restore_context = clk_divider_restore_context,
 };
 
 static struct clk *_register_divider(struct device *dev, const char *name,
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 7d33ca9..b1c4d8a 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -39,6 +39,8 @@
 	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
 	.determine_rate	= &omap4_dpll_regm4xen_determine_rate,
 	.get_parent	= &omap2_init_dpll_parent,
+	.save_context	= &omap3_core_dpll_save_context,
+	.restore_context = &omap3_core_dpll_restore_context,
 };
 #else
 static const struct clk_ops dpll_m4xen_ck_ops = {};
@@ -62,6 +64,8 @@
 	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
 	.determine_rate	= &omap3_noncore_dpll_determine_rate,
 	.get_parent	= &omap2_init_dpll_parent,
+	.save_context	= &omap3_noncore_dpll_save_context,
+	.restore_context = &omap3_noncore_dpll_restore_context,
 };
 
 static const struct clk_ops dpll_no_gate_ck_ops = {
@@ -72,6 +76,8 @@
 	.set_parent	= &omap3_noncore_dpll_set_parent,
 	.set_rate_and_parent	= &omap3_noncore_dpll_set_rate_and_parent,
 	.determine_rate	= &omap3_noncore_dpll_determine_rate,
+	.save_context	= &omap3_noncore_dpll_save_context,
+	.restore_context = &omap3_noncore_dpll_restore_context
 };
 #else
 static const struct clk_ops dpll_core_ck_ops = {};
diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
index 4534de2..44b6b64 100644
--- a/drivers/clk/ti/dpll3xxx.c
+++ b/drivers/clk/ti/dpll3xxx.c
@@ -782,6 +782,130 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 	return rate;
 }
 
+/**
+ * omap3_core_dpll_save_context - Save the m and n values of the divider
+ * @hw: pointer  struct clk_hw
+ *
+ * Before the dpll registers are lost save the last rounded rate m and n
+ * and the enable mask.
+ */
+int omap3_core_dpll_save_context(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	struct dpll_data *dd;
+	u32 v;
+
+	dd = clk->dpll_data;
+
+	v = ti_clk_ll_ops->clk_readl(&dd->control_reg);
+	clk->context = (v & dd->enable_mask) >> __ffs(dd->enable_mask);
+
+	if (clk->context == DPLL_LOCKED) {
+		v = ti_clk_ll_ops->clk_readl(&dd->mult_div1_reg);
+		dd->last_rounded_m = (v & dd->mult_mask) >>
+						__ffs(dd->mult_mask);
+		dd->last_rounded_n = ((v & dd->div1_mask) >>
+						__ffs(dd->div1_mask)) + 1;
+	}
+
+	return 0;
+}
+
+/**
+ * omap3_core_dpll_restore_context - restore the m and n values of the divider
+ * @hw: pointer  struct clk_hw
+ *
+ * Restore the last rounded rate m and n
+ * and the enable mask.
+ */
+void omap3_core_dpll_restore_context(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	const struct dpll_data *dd;
+	u32 v;
+
+	dd = clk->dpll_data;
+
+	if (clk->context == DPLL_LOCKED) {
+		_omap3_dpll_write_clken(clk, 0x4);
+		_omap3_wait_dpll_status(clk, 0);
+
+		v = ti_clk_ll_ops->clk_readl(&dd->mult_div1_reg);
+		v &= ~(dd->mult_mask | dd->div1_mask);
+		v |= dd->last_rounded_m << __ffs(dd->mult_mask);
+		v |= (dd->last_rounded_n - 1) << __ffs(dd->div1_mask);
+		ti_clk_ll_ops->clk_writel(v, &dd->mult_div1_reg);
+
+		_omap3_dpll_write_clken(clk, DPLL_LOCKED);
+		_omap3_wait_dpll_status(clk, 1);
+	} else {
+		_omap3_dpll_write_clken(clk, clk->context);
+	}
+}
+
+/**
+ * omap3_non_core_dpll_save_context - Save the m and n values of the divider
+ * @hw: pointer  struct clk_hw
+ *
+ * Before the dpll registers are lost save the last rounded rate m and n
+ * and the enable mask.
+ */
+int omap3_noncore_dpll_save_context(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	struct dpll_data *dd;
+	u32 v;
+
+	dd = clk->dpll_data;
+
+	v = ti_clk_ll_ops->clk_readl(&dd->control_reg);
+	clk->context = (v & dd->enable_mask) >> __ffs(dd->enable_mask);
+
+	if (clk->context == DPLL_LOCKED) {
+		v = ti_clk_ll_ops->clk_readl(&dd->mult_div1_reg);
+		dd->last_rounded_m = (v & dd->mult_mask) >>
+						__ffs(dd->mult_mask);
+		dd->last_rounded_n = ((v & dd->div1_mask) >>
+						__ffs(dd->div1_mask)) + 1;
+	}
+
+	return 0;
+}
+
+/**
+ * omap3_core_dpll_restore_context - restore the m and n values of the divider
+ * @hw: pointer  struct clk_hw
+ *
+ * Restore the last rounded rate m and n
+ * and the enable mask.
+ */
+void omap3_noncore_dpll_restore_context(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	const struct dpll_data *dd;
+	u32 ctrl, mult_div1;
+
+	dd = clk->dpll_data;
+
+	ctrl = ti_clk_ll_ops->clk_readl(&dd->control_reg);
+	mult_div1 = ti_clk_ll_ops->clk_readl(&dd->mult_div1_reg);
+
+	if (clk->context == ((ctrl & dd->enable_mask) >>
+			     __ffs(dd->enable_mask)) &&
+	    dd->last_rounded_m == ((mult_div1 & dd->mult_mask) >>
+				   __ffs(dd->mult_mask)) &&
+	    dd->last_rounded_n == ((mult_div1 & dd->div1_mask) >>
+				   __ffs(dd->div1_mask)) + 1) {
+		/* nothing to be done */
+		return;
+	}
+
+	if (clk->context == DPLL_LOCKED)
+		omap3_noncore_dpll_program(clk, 0);
+	else
+		_omap3_dpll_write_clken(clk, clk->context);
+}
+
 /* OMAP3/4 non-CORE DPLL clkops */
 const struct clk_hw_omap_ops clkhwops_omap3_dpll = {
 	.allow_idle	= omap3_dpll_allow_idle,
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index 935b2de..2453b36 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -33,6 +33,7 @@
 	.init		= &omap2_init_clk_clkdm,
 	.enable		= &omap2_clkops_enable_clkdm,
 	.disable	= &omap2_clkops_disable_clkdm,
+	.restore_context = clk_gate_restore_context,
 };
 
 const struct clk_ops omap_gate_clk_ops = {
@@ -40,6 +41,7 @@
 	.enable		= &omap2_dflt_clk_enable,
 	.disable	= &omap2_dflt_clk_disable,
 	.is_enabled	= &omap2_dflt_clk_is_enabled,
+	.restore_context = clk_gate_restore_context,
 };
 
 static const struct clk_ops omap_gate_clk_hsdiv_restore_ops = {
@@ -47,6 +49,7 @@
 	.enable		= &omap36xx_gate_clk_enable_with_hsdiv_restore,
 	.disable	= &omap2_dflt_clk_disable,
 	.is_enabled	= &omap2_dflt_clk_is_enabled,
+	.restore_context = clk_gate_restore_context,
 };
 
 /**
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index 69a4308..5749b2b 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -91,10 +91,39 @@ static int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	return 0;
 }
 
+/**
+ * clk_mux_save_context - Save the parent selcted in the mux
+ * @hw: pointer  struct clk_hw
+ *
+ * Save the parent mux value.
+ */
+static int clk_mux_save_context(struct clk_hw *hw)
+{
+	struct clk_omap_mux *mux = to_clk_omap_mux(hw);
+
+	mux->saved_parent = ti_clk_mux_get_parent(hw);
+	return 0;
+}
+
+/**
+ * clk_mux_restore_context - Restore the parent in the mux
+ * @hw: pointer  struct clk_hw
+ *
+ * Restore the saved parent mux value.
+ */
+static void clk_mux_restore_context(struct clk_hw *hw)
+{
+	struct clk_omap_mux *mux = to_clk_omap_mux(hw);
+
+	ti_clk_mux_set_parent(hw, mux->saved_parent);
+}
+
 const struct clk_ops ti_clk_mux_ops = {
 	.get_parent = ti_clk_mux_get_parent,
 	.set_parent = ti_clk_mux_set_parent,
 	.determine_rate = __clk_mux_determine_rate,
+	.save_context = clk_mux_save_context,
+	.restore_context = clk_mux_restore_context,
 };
 
 static struct clk *_register_mux(struct device *dev, const char *name,
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index a8faa38..c1b13bb 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -159,6 +159,7 @@ struct clk_hw_omap {
 	const char		*clkdm_name;
 	struct clockdomain	*clkdm;
 	const struct clk_hw_omap_ops	*ops;
+	u32			context;
 };
 
 /*
@@ -293,6 +294,11 @@ struct ti_clk_features {
 
 void ti_clk_setup_features(struct ti_clk_features *features);
 const struct ti_clk_features *ti_clk_get_features(void);
+int omap3_noncore_dpll_save_context(struct clk_hw *hw);
+void omap3_noncore_dpll_restore_context(struct clk_hw *hw);
+
+int omap3_core_dpll_save_context(struct clk_hw *hw);
+void omap3_core_dpll_restore_context(struct clk_hw *hw);
 
 extern const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll;
 
-- 
1.9.1

