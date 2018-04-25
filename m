Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755931AbeDYQd0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:33:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56312 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755314AbeDYQdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:33:14 -0400
X-Google-Smtp-Source: AIpwx4+rhD8Cm/XHn0BuHZ+Bg9jmYP5nvSUU3fS7OY1abEBiHlmJeBdfbQ3iYSPHjM+sQOOErWGH7g==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] clk: meson: add clk-phase clock driver
Date: Wed, 25 Apr 2018 18:32:59 +0200
Message-Id: <20180425163304.10852-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180425163304.10852-1-jbrunet@baylibre.com>
References: <20180425163304.10852-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver based meson clk-regmap to control clock phase on
amlogic SoCs

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Makefile    |  1 +
 drivers/clk/meson/clk-phase.c | 63 +++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/clkc.h      |  8 ++++++
 3 files changed, 72 insertions(+)
 create mode 100644 drivers/clk/meson/clk-phase.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index ffee82e60b7a..352fb848c406 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-audio-divider.o
+obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-phase.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
 obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
 obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o
diff --git a/drivers/clk/meson/clk-phase.c b/drivers/clk/meson/clk-phase.c
new file mode 100644
index 000000000000..96e70497ef1b
--- /dev/null
+++ b/drivers/clk/meson/clk-phase.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#include <linux/clk-provider.h>
+#include "clkc.h"
+
+#define phase_step(_width) (360 / (1 << (_width)))
+
+static inline struct meson_clk_phase_data *
+meson_clk_phase_data(struct clk_regmap *clk)
+{
+	return (struct meson_clk_phase_data *)clk->data;
+}
+
+int meson_clk_degrees_from_val(unsigned int val, unsigned int width)
+{
+	return phase_step(width) * val;
+}
+EXPORT_SYMBOL_GPL(meson_clk_degrees_from_val);
+
+unsigned int meson_clk_degrees_to_val(int degrees, unsigned int width)
+{
+	unsigned int val = DIV_ROUND_CLOSEST(degrees, phase_step(width));
+
+	/*
+	 * This last calculation is here for cases when degrees is rounded
+	 * to 360, in which case val == (1 << width).
+	 */
+	return val % (1 << width);
+}
+EXPORT_SYMBOL_GPL(meson_clk_degrees_to_val);
+
+static int meson_clk_phase_get_phase(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_phase_data *phase = meson_clk_phase_data(clk);
+	unsigned int val;
+
+	val = meson_parm_read(clk->map, &phase->ph);
+
+	return meson_clk_degrees_from_val(val, phase->ph.width);
+}
+
+static int meson_clk_phase_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_phase_data *phase = meson_clk_phase_data(clk);
+	unsigned int val;
+
+	val = meson_clk_degrees_to_val(degrees, phase->ph.width);
+	meson_parm_write(clk->map, &phase->ph, val);
+
+	return 0;
+}
+
+const struct clk_ops meson_clk_phase_ops = {
+	.get_phase	= meson_clk_phase_get_phase,
+	.set_phase	= meson_clk_phase_set_phase,
+};
+EXPORT_SYMBOL_GPL(meson_clk_phase_ops);
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 8fe73c4edca8..9a17d6705e0a 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -104,6 +104,13 @@ struct meson_clk_audio_div_data {
 	u8 flags;
 };
 
+struct meson_clk_phase_data {
+	struct parm ph;
+};
+
+int meson_clk_degrees_from_val(unsigned int val, unsigned int width);
+unsigned int meson_clk_degrees_to_val(int degrees, unsigned int width);
+
 #define MESON_GATE(_name, _reg, _bit)					\
 struct clk_regmap _name = {						\
 	.data = &(struct clk_regmap_gate_data){				\
@@ -127,5 +134,6 @@ extern const struct clk_ops meson_clk_mpll_ro_ops;
 extern const struct clk_ops meson_clk_mpll_ops;
 extern const struct clk_ops meson_clk_audio_divider_ro_ops;
 extern const struct clk_ops meson_clk_audio_divider_ops;
+extern const struct clk_ops meson_clk_phase_ops;
 
 #endif /* __CLKC_H */
-- 
2.14.3
