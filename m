Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753797AbeAaSKD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:10:03 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53170 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753684AbeAaSJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:09:57 -0500
X-Google-Smtp-Source: AH8x225QNIiIUv1QRAJ4hh/ppUznIuwe7bTdusisRQuOrFyqXGE0cl8ieiHZ+zKgH9pVG9DyquIbsA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/19] clk: meson: switch gxbb ao_clk to clk_regmap
Date: Wed, 31 Jan 2018 19:09:32 +0100
Message-Id: <20180131180945.18025-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131180945.18025-1-jbrunet@baylibre.com>
References: <20180131180945.18025-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the gxbb ao specific regmap based clock and use the
meson clk_regmap based clock instead.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Kconfig      |  1 +
 drivers/clk/meson/Makefile     |  2 +-
 drivers/clk/meson/gxbb-aoclk.c | 20 ++++++++++----------
 drivers/clk/meson/gxbb-aoclk.h |  1 -
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index e97e85077da1..33d148e19066 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -20,6 +20,7 @@ config COMMON_CLK_GXBB
 	bool
 	depends on COMMON_CLK_AMLOGIC
 	select RESET_CONTROLLER
+	select COMMON_CLK_REGMAP_MESON
 	help
 	  Support for the clock controller on AmLogic S905 devices, aka gxbb.
 	  Say Y if you want peripherals and CPU frequency scaling to work.
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 11a50586666a..465086118d62 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -4,6 +4,6 @@
 
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-cpu.o clk-mpll.o clk-audio-divider.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
-obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-regmap.o gxbb-aoclk-32k.o
+obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
 obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o
 obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index 6c161e0a8e59..9ec23ae9a219 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -62,10 +62,9 @@
 #include <linux/delay.h>
 #include <dt-bindings/clock/gxbb-aoclkc.h>
 #include <dt-bindings/reset/gxbb-aoclkc.h>
+#include "clk-regmap.h"
 #include "gxbb-aoclk.h"
 
-static DEFINE_SPINLOCK(gxbb_aoclk_lock);
-
 struct gxbb_aoclk_reset_controller {
 	struct reset_controller_dev reset;
 	unsigned int *data;
@@ -87,12 +86,14 @@ static const struct reset_control_ops gxbb_aoclk_reset_ops = {
 };
 
 #define GXBB_AO_GATE(_name, _bit)					\
-static struct aoclk_gate_regmap _name##_ao = {				\
-	.bit_idx = (_bit),						\
-	.lock = &gxbb_aoclk_lock,					\
+static struct clk_regmap _name##_ao = {					\
+	.data = &(struct clk_regmap_gate_data) {			\
+		.offset = AO_RTI_GEN_CNTL_REG0,				\
+		.bit_idx = (_bit),					\
+	},								\
 	.hw.init = &(struct clk_init_data) {				\
 		.name = #_name "_ao",					\
-		.ops = &meson_aoclk_gate_regmap_ops,			\
+		.ops = &clk_regmap_gate_ops,				\
 		.parent_names = (const char *[]){ "clk81" },		\
 		.num_parents = 1,					\
 		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),	\
@@ -107,7 +108,6 @@ GXBB_AO_GATE(uart2, 5);
 GXBB_AO_GATE(ir_blaster, 6);
 
 static struct aoclk_cec_32k cec_32k_ao = {
-	.lock = &gxbb_aoclk_lock,
 	.hw.init = &(struct clk_init_data) {
 		.name = "cec_32k_ao",
 		.ops = &meson_aoclk_cec_32k_ops,
@@ -126,7 +126,7 @@ static unsigned int gxbb_aoclk_reset[] = {
 	[RESET_AO_IR_BLASTER] = 23,
 };
 
-static struct aoclk_gate_regmap *gxbb_aoclk_gate[] = {
+static struct clk_regmap *gxbb_aoclk_gate[] = {
 	[CLKID_AO_REMOTE] = &remote_ao,
 	[CLKID_AO_I2C_MASTER] = &i2c_master_ao,
 	[CLKID_AO_I2C_SLAVE] = &i2c_slave_ao,
@@ -177,10 +177,10 @@ static int gxbb_aoclkc_probe(struct platform_device *pdev)
 	 * Populate regmap and register all clks
 	 */
 	for (clkid = 0; clkid < ARRAY_SIZE(gxbb_aoclk_gate); clkid++) {
-		gxbb_aoclk_gate[clkid]->regmap = regmap;
+		gxbb_aoclk_gate[clkid]->map = regmap;
 
 		ret = devm_clk_hw_register(dev,
-					gxbb_aoclk_onecell_data.hws[clkid]);
+					   gxbb_aoclk_onecell_data.hws[clkid]);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/clk/meson/gxbb-aoclk.h b/drivers/clk/meson/gxbb-aoclk.h
index e8604c8f7eee..127d58954cca 100644
--- a/drivers/clk/meson/gxbb-aoclk.h
+++ b/drivers/clk/meson/gxbb-aoclk.h
@@ -32,7 +32,6 @@ extern const struct clk_ops meson_aoclk_gate_regmap_ops;
 struct aoclk_cec_32k {
 	struct clk_hw hw;
 	struct regmap *regmap;
-	spinlock_t *lock;
 };
 
 #define to_aoclk_cec_32k(_hw) container_of(_hw, struct aoclk_cec_32k, hw)
-- 
2.14.3
