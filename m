Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756020AbeDYQeN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:34:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54850 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755565AbeDYQdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:33:18 -0400
X-Google-Smtp-Source: AB8JxZpSmoQg32Xu+k3u4TkIdlhLWN8+aB3oIafx0mUhfWxLYoBRF/4Gy2B/vCjLwtw1BvCe+qwxNg==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] clk: meson: add axg audio sclk divider driver
Date: Wed, 25 Apr 2018 18:33:01 +0200
Message-Id: <20180425163304.10852-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180425163304.10852-1-jbrunet@baylibre.com>
References: <20180425163304.10852-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver to control the clock divider found in the sample clock
generator of the axg audio clock controller.

The sclk divider accumulates specific features which make the generic
divider unsuitable to control it:
- zero based divider (div = val + 1), but zero value gates the clock,
  so minimum divider value is 2.
- lrclk variant may adjust the duty cycle depending the divider value
  and the 'hi' value.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Makefile     |   2 +-
 drivers/clk/meson/clkc-audio.h |   8 ++
 drivers/clk/meson/sclk-div.c   | 243 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 252 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/meson/sclk-div.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 64bb917fe1f0..f51b4754c31b 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-audio-divider.o
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-phase.o
-obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o
+obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o sclk-div.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
 obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
 obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o
diff --git a/drivers/clk/meson/clkc-audio.h b/drivers/clk/meson/clkc-audio.h
index 286ff1201258..0a7c157ebf81 100644
--- a/drivers/clk/meson/clkc-audio.h
+++ b/drivers/clk/meson/clkc-audio.h
@@ -15,6 +15,14 @@ struct meson_clk_triphase_data {
 	struct parm ph2;
 };
 
+struct meson_sclk_div_data {
+	struct parm div;
+	struct parm hi;
+	unsigned int cached_div;
+	struct clk_duty cached_duty;
+};
+
 extern const struct clk_ops meson_clk_triphase_ops;
+extern const struct clk_ops meson_sclk_div_ops;
 
 #endif /* __MESON_CLKC_AUDIO_H */
diff --git a/drivers/clk/meson/sclk-div.c b/drivers/clk/meson/sclk-div.c
new file mode 100644
index 000000000000..8c0bc914a6d7
--- /dev/null
+++ b/drivers/clk/meson/sclk-div.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ *
+ * Sample clock generator divider:
+ * This HW divider gates with value 0 but is otherwise a zero based divider:
+ *
+ * val >= 1
+ * divider = val + 1
+ *
+ * The duty cycle may also be set for the LR clock variant. The duty cycle
+ * ratio is:
+ *
+ * hi = [0 - val]
+ * duty_cycle = (1 + hi) / (1 + val)
+ */
+
+#include "clkc-audio.h"
+
+static inline struct meson_sclk_div_data *
+meson_sclk_div_data(struct clk_regmap *clk)
+{
+	return (struct meson_sclk_div_data *)clk->data;
+}
+
+static int sclk_div_maxval(struct meson_sclk_div_data *sclk)
+{
+	return (1 << sclk->div.width) - 1;
+}
+
+static int sclk_div_maxdiv(struct meson_sclk_div_data *sclk)
+{
+	return sclk_div_maxval(sclk) + 1;
+}
+
+static int sclk_div_getdiv(struct clk_hw *hw, unsigned long rate,
+			   unsigned long prate, int maxdiv)
+{
+	int div = DIV_ROUND_CLOSEST_ULL((u64)prate, rate);
+
+	return clamp(div, 2, maxdiv);
+}
+
+static int sclk_div_bestdiv(struct clk_hw *hw, unsigned long rate,
+			    unsigned long *prate,
+			    struct meson_sclk_div_data *sclk)
+{
+	struct clk_hw *parent = clk_hw_get_parent(hw);
+	int bestdiv = 0, i;
+	unsigned long maxdiv, now, parent_now;
+	unsigned long best = 0, best_parent = 0;
+
+	if (!rate)
+		rate = 1;
+
+	maxdiv = sclk_div_maxdiv(sclk);
+
+	if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT))
+		return sclk_div_getdiv(hw, rate, *prate, maxdiv);
+
+	/*
+	 * The maximum divider we can use without overflowing
+	 * unsigned long in rate * i below
+	 */
+	maxdiv = min(ULONG_MAX / rate, maxdiv);
+
+	for (i = 2; i <= maxdiv; i++) {
+		/*
+		 * It's the most ideal case if the requested rate can be
+		 * divided from parent clock without needing to change
+		 * parent rate, so return the divider immediately.
+		 */
+		if (rate * i == *prate)
+			return i;
+
+		parent_now = clk_hw_round_rate(parent, rate * i);
+		now = DIV_ROUND_UP_ULL((u64)parent_now, i);
+
+		if (abs(rate - now) < abs(rate - best)) {
+			bestdiv = i;
+			best = now;
+			best_parent = parent_now;
+		}
+	}
+
+	if (!bestdiv)
+		bestdiv = sclk_div_maxdiv(sclk);
+	else
+		*prate = best_parent;
+
+	return bestdiv;
+}
+
+static long sclk_div_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
+	int div;
+
+	div = sclk_div_bestdiv(hw, rate, prate, sclk);
+
+	return DIV_ROUND_UP_ULL((u64)*prate, div);
+}
+
+static void sclk_apply_ratio(struct clk_regmap *clk,
+			     struct meson_sclk_div_data *sclk)
+{
+	unsigned int hi = DIV_ROUND_CLOSEST(sclk->cached_div *
+					    sclk->cached_duty.num,
+					    sclk->cached_duty.den);
+
+	if (hi)
+		hi -= 1;
+
+	meson_parm_write(clk->map, &sclk->hi, hi);
+}
+
+static int sclk_div_set_duty_cycle(struct clk_hw *hw,
+				   struct clk_duty *duty)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
+
+	if (MESON_PARM_APPLICABLE(&sclk->hi)) {
+		memcpy(&sclk->cached_duty, duty, sizeof(*duty));
+		sclk_apply_ratio(clk, sclk);
+	}
+
+	return 0;
+}
+
+static int sclk_div_get_duty_cycle(struct clk_hw *hw,
+				   struct clk_duty *duty)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
+	int hi;
+
+	if (!MESON_PARM_APPLICABLE(&sclk->hi)) {
+		duty->num = 1;
+		duty->den = 2;
+		return 0;
+	}
+
+	hi = meson_parm_read(clk->map, &sclk->hi);
+	duty->num = hi + 1;
+	duty->den = sclk->cached_div;
+	return 0;
+}
+
+static void sclk_apply_divider(struct clk_regmap *clk,
+			       struct meson_sclk_div_data *sclk)
+{
+	if (MESON_PARM_APPLICABLE(&sclk->hi))
+		sclk_apply_ratio(clk, sclk);
+
+	meson_parm_write(clk->map, &sclk->div, sclk->cached_div - 1);
+}
+
+static int sclk_div_set_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long prate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
+	unsigned long maxdiv = sclk_div_maxdiv(sclk);
+
+	sclk->cached_div = sclk_div_getdiv(hw, rate, prate, maxdiv);
+
+	if (clk_hw_is_enabled(hw))
+		sclk_apply_divider(clk, sclk);
+
+	return 0;
+}
+
+static unsigned long sclk_div_recalc_rate(struct clk_hw *hw,
+					  unsigned long prate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
+
+	return DIV_ROUND_UP_ULL((u64)prate, sclk->cached_div);
+}
+
+static int sclk_div_enable(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
+
+	sclk_apply_divider(clk, sclk);
+
+	return 0;
+}
+
+static void sclk_div_disable(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
+
+	meson_parm_write(clk->map, &sclk->div, 0);
+}
+
+static int sclk_div_is_enabled(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
+
+	if (meson_parm_read(clk->map, &sclk->div))
+		return 1;
+
+	return 0;
+}
+
+static void sclk_div_init(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
+	unsigned int val;
+
+	val = meson_parm_read(clk->map, &sclk->div);
+
+	/* if the divider is initially disabled, assume max */
+	if (!val)
+		sclk->cached_div = sclk_div_maxdiv(sclk);
+	else
+		sclk->cached_div = val + 1;
+
+	sclk_div_get_duty_cycle(hw, &sclk->cached_duty);
+}
+
+const struct clk_ops meson_sclk_div_ops = {
+	.recalc_rate	= sclk_div_recalc_rate,
+	.round_rate	= sclk_div_round_rate,
+	.set_rate	= sclk_div_set_rate,
+	.enable		= sclk_div_enable,
+	.disable	= sclk_div_disable,
+	.is_enabled	= sclk_div_is_enabled,
+	.get_duty_cycle	= sclk_div_get_duty_cycle,
+	.set_duty_cycle = sclk_div_set_duty_cycle,
+	.init		= sclk_div_init,
+};
+EXPORT_SYMBOL_GPL(meson_sclk_div_ops);
-- 
2.14.3
