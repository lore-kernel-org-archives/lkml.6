Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756034AbeDYQeU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:34:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52140 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755449AbeDYQdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:33:16 -0400
X-Google-Smtp-Source: AB8JxZpOmkD2nqgvDqU2yomtZ4Huz2c9OhQcPZ50jiYSuu5Lvf01YiU5YJWZEga7rWOmDPJ6p5zbhw==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] clk: meson: add triple phase clock driver
Date: Wed, 25 Apr 2018 18:33:00 +0200
Message-Id: <20180425163304.10852-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180425163304.10852-1-jbrunet@baylibre.com>
References: <20180425163304.10852-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver to control the output of the sample clock generator found
in the axg audio clock controller.

The goal of this driver is to coherently control the phase provided to
the different element using the sample clock generator. This simplify
the usage of the sample clock generator a lot, without comprising the
ability of the SoC.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Kconfig        |  5 +++
 drivers/clk/meson/Makefile       |  1 +
 drivers/clk/meson/clk-triphase.c | 68 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/clkc-audio.h   | 20 ++++++++++++
 4 files changed, 94 insertions(+)
 create mode 100644 drivers/clk/meson/clk-triphase.c
 create mode 100644 drivers/clk/meson/clkc-audio.h

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 87d69573e172..7f7fd6fb3809 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -3,6 +3,11 @@ config COMMON_CLK_AMLOGIC
 	depends on ARCH_MESON || COMPILE_TEST
 	select COMMON_CLK_REGMAP_MESON
 
+config COMMON_CLK_AMLOGIC_AUDIO
+	bool
+	depends on ARCH_MESON || COMPILE_TEST
+	select COMMON_CLK_AMLOGIC
+
 config COMMON_CLK_REGMAP_MESON
 	bool
 	select REGMAP
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 352fb848c406..64bb917fe1f0 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -4,6 +4,7 @@
 
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-audio-divider.o
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-phase.o
+obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
 obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
 obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o
diff --git a/drivers/clk/meson/clk-triphase.c b/drivers/clk/meson/clk-triphase.c
new file mode 100644
index 000000000000..9508c03c73c1
--- /dev/null
+++ b/drivers/clk/meson/clk-triphase.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2018 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#include <linux/clk-provider.h>
+#include "clkc-audio.h"
+
+/*
+ * This is a special clock for the audio controller.
+ * The phase of mst_sclk clock output can be controlled independently
+ * for the outside world (ph0), the tdmout (ph1) and tdmin (ph2).
+ * Controlling these 3 phases as just one makes things simpler and
+ * give the same clock view to all the element on the i2s bus.
+ * If necessary, we can still control the phase in the tdm block
+ * which makes these independent control redundant.
+ */
+static inline struct meson_clk_triphase_data *
+meson_clk_triphase_data(struct clk_regmap *clk)
+{
+	return (struct meson_clk_triphase_data *)clk->data;
+}
+
+static void meson_clk_triphase_sync(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_triphase_data *tph = meson_clk_triphase_data(clk);
+	unsigned int val;
+
+	/* Get phase 0 and sync it to phase 1 and 2 */
+	val = meson_parm_read(clk->map, &tph->ph0);
+	meson_parm_write(clk->map, &tph->ph1, val);
+	meson_parm_write(clk->map, &tph->ph2, val);
+}
+
+static int meson_clk_triphase_get_phase(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_triphase_data *tph = meson_clk_triphase_data(clk);
+	unsigned int val;
+
+	/* Phase are in sync, reading phase 0 is enough */
+	val = meson_parm_read(clk->map, &tph->ph0);
+
+	return meson_clk_degrees_from_val(val, tph->ph0.width);
+}
+
+static int meson_clk_triphase_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_triphase_data *tph = meson_clk_triphase_data(clk);
+	unsigned int val;
+
+	val = meson_clk_degrees_to_val(degrees, tph->ph0.width);
+	meson_parm_write(clk->map, &tph->ph0, val);
+	meson_parm_write(clk->map, &tph->ph1, val);
+	meson_parm_write(clk->map, &tph->ph2, val);
+
+	return 0;
+}
+
+const struct clk_ops meson_clk_triphase_ops = {
+	.init		= meson_clk_triphase_sync,
+	.get_phase	= meson_clk_triphase_get_phase,
+	.set_phase	= meson_clk_triphase_set_phase,
+};
+EXPORT_SYMBOL_GPL(meson_clk_triphase_ops);
diff --git a/drivers/clk/meson/clkc-audio.h b/drivers/clk/meson/clkc-audio.h
new file mode 100644
index 000000000000..286ff1201258
--- /dev/null
+++ b/drivers/clk/meson/clkc-audio.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef __MESON_CLKC_AUDIO_H
+#define __MESON_CLKC_AUDIO_H
+
+#include "clkc.h"
+
+struct meson_clk_triphase_data {
+	struct parm ph0;
+	struct parm ph1;
+	struct parm ph2;
+};
+
+extern const struct clk_ops meson_clk_triphase_ops;
+
+#endif /* __MESON_CLKC_AUDIO_H */
-- 
2.14.3
