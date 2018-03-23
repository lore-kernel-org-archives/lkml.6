Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeCWOil (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:38:41 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:11642 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbeCWOii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:38:38 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
CC: Yixun Lan <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/7] clk: meson: aoclk: refactor common code into dedicated file
Date: Fri, 23 Mar 2018 22:38:11 +0800
Message-ID: <20180323143816.200573-3-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180323143816.200573-1-yixun.lan@amlogic.com>
References: <20180323143816.200573-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We try to refactor the common code into one dedicated file,
while preparing to add new Meson-AXG aoclk driver, this would
help us to better share the code by all aoclk drivers.

Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/clk/meson/Makefile      |  2 +-
 drivers/clk/meson/gxbb-aoclk.c  | 81 +++++++++++++----------------------------
 drivers/clk/meson/gxbb-aoclk.h  |  7 ++++
 drivers/clk/meson/meson-aoclk.c | 76 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/meson-aoclk.h | 30 +++++++++++++++
 5 files changed, 139 insertions(+), 57 deletions(-)
 create mode 100644 drivers/clk/meson/meson-aoclk.c
 create mode 100644 drivers/clk/meson/meson-aoclk.h

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index ffee82e60b7a..555ab9c6ab64 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -4,6 +4,6 @@
 
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-audio-divider.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
-obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
+obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o meson-aoclk.o gxbb-aoclk.o gxbb-aoclk-32k.o
 obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o
 obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index 9ec23ae9a219..0f089cbce594 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -52,39 +52,13 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
-#include <linux/clk-provider.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/mfd/syscon.h>
-#include <linux/regmap.h>
 #include <linux/init.h>
-#include <linux/delay.h>
-#include <dt-bindings/clock/gxbb-aoclkc.h>
-#include <dt-bindings/reset/gxbb-aoclkc.h>
 #include "clk-regmap.h"
 #include "gxbb-aoclk.h"
 
-struct gxbb_aoclk_reset_controller {
-	struct reset_controller_dev reset;
-	unsigned int *data;
-	struct regmap *regmap;
-};
-
-static int gxbb_aoclk_do_reset(struct reset_controller_dev *rcdev,
-			       unsigned long id)
-{
-	struct gxbb_aoclk_reset_controller *reset =
-		container_of(rcdev, struct gxbb_aoclk_reset_controller, reset);
-
-	return regmap_write(reset->regmap, AO_RTI_GEN_CNTL_REG0,
-			    BIT(reset->data[id]));
-}
-
-static const struct reset_control_ops gxbb_aoclk_reset_ops = {
-	.reset = gxbb_aoclk_do_reset,
-};
-
 #define GXBB_AO_GATE(_name, _bit)					\
 static struct clk_regmap _name##_ao = {					\
 	.data = &(struct clk_regmap_gate_data) {			\
@@ -145,19 +119,15 @@ static struct clk_hw_onecell_data gxbb_aoclk_onecell_data = {
 		[CLKID_AO_IR_BLASTER] = &ir_blaster_ao.hw,
 		[CLKID_AO_CEC_32K] = &cec_32k_ao.hw,
 	},
-	.num = 7,
+	.num = NR_CLKS,
 };
 
-static int gxbb_aoclkc_probe(struct platform_device *pdev)
+static int gxbb_aoclkc_register_specific_clk(
+		struct platform_device *pdev)
 {
-	struct gxbb_aoclk_reset_controller *rstc;
 	struct device *dev = &pdev->dev;
 	struct regmap *regmap;
-	int ret, clkid;
-
-	rstc = devm_kzalloc(dev, sizeof(*rstc), GFP_KERNEL);
-	if (!rstc)
-		return -ENOMEM;
+	int ret;
 
 	regmap = syscon_node_to_regmap(of_get_parent(dev->of_node));
 	if (IS_ERR(regmap)) {
@@ -165,34 +135,33 @@ static int gxbb_aoclkc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	/* Reset Controller */
-	rstc->regmap = regmap;
-	rstc->data = gxbb_aoclk_reset;
-	rstc->reset.ops = &gxbb_aoclk_reset_ops;
-	rstc->reset.nr_resets = ARRAY_SIZE(gxbb_aoclk_reset);
-	rstc->reset.of_node = dev->of_node;
-	ret = devm_reset_controller_register(dev, &rstc->reset);
-
-	/*
-	 * Populate regmap and register all clks
-	 */
-	for (clkid = 0; clkid < ARRAY_SIZE(gxbb_aoclk_gate); clkid++) {
-		gxbb_aoclk_gate[clkid]->map = regmap;
-
-		ret = devm_clk_hw_register(dev,
-					   gxbb_aoclk_onecell_data.hws[clkid]);
-		if (ret)
-			return ret;
-	}
-
 	/* Specific clocks */
 	cec_32k_ao.regmap = regmap;
 	ret = devm_clk_hw_register(dev, &cec_32k_ao.hw);
-	if (ret)
+	if (ret) {
+		dev_err(&pdev->dev, "clk cec_32k_ao register failed.\n");
 		return ret;
+	}
+
+	return 0;
+}
 
-	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
+static int gxbb_aoclkc_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = meson_aoclkc_probe(pdev, AO_RTI_GEN_CNTL_REG0,
+			gxbb_aoclk_reset,
+			ARRAY_SIZE(gxbb_aoclk_reset),
+			gxbb_aoclk_gate,
+			ARRAY_SIZE(gxbb_aoclk_gate),
 			&gxbb_aoclk_onecell_data);
+	if (ret) {
+		dev_err(&pdev->dev, "aoclk probe failed.\n");
+		return ret;
+	}
+
+	return gxbb_aoclkc_register_specific_clk(pdev);
 }
 
 static const struct of_device_id gxbb_aoclkc_match_table[] = {
diff --git a/drivers/clk/meson/gxbb-aoclk.h b/drivers/clk/meson/gxbb-aoclk.h
index badc4c22b4ee..b031f1a0213e 100644
--- a/drivers/clk/meson/gxbb-aoclk.h
+++ b/drivers/clk/meson/gxbb-aoclk.h
@@ -8,6 +8,10 @@
 #ifndef __GXBB_AOCLKC_H
 #define __GXBB_AOCLKC_H
 
+#include "meson-aoclk.h"
+
+#define NR_CLKS	7
+
 /* AO Configuration Clock registers offsets */
 #define AO_RTI_PWR_CNTL_REG1	0x0c
 #define AO_RTI_PWR_CNTL_REG0	0x10
@@ -26,4 +30,7 @@ struct aoclk_cec_32k {
 
 extern const struct clk_ops meson_aoclk_cec_32k_ops;
 
+#include <dt-bindings/clock/gxbb-aoclkc.h>
+#include <dt-bindings/reset/gxbb-aoclkc.h>
+
 #endif /* __GXBB_AOCLKC_H */
diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
new file mode 100644
index 000000000000..b47c4008e15b
--- /dev/null
+++ b/drivers/clk/meson/meson-aoclk.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Amlogic Meson-AXG Clock Controller Driver
+ *
+ * Copyright (c) 2016 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * Copyright (c) 2018 Amlogic, inc.
+ * Author: Qiufang Dai <qiufang.dai@amlogic.com>
+ * Author: Yixun Lan <yixun.lan@amlogic.com>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/mfd/syscon.h>
+#include <linux/init.h>
+#include "clk-regmap.h"
+#include "meson-aoclk.h"
+
+static int meson_aoclk_do_reset(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct meson_aoclk_reset_controller *reset =
+		container_of(rcdev, struct meson_aoclk_reset_controller, reset);
+
+	return regmap_write(reset->regmap, reset->reg,
+			    BIT(reset->data[id]));
+}
+
+static const struct reset_control_ops meson_aoclk_reset_ops = {
+	.reset = meson_aoclk_do_reset,
+};
+
+int meson_aoclkc_probe(struct platform_device *pdev, unsigned int reg,
+		unsigned int *reset, int num_reset,
+		struct clk_regmap **clks, int num_clks,
+		struct clk_hw_onecell_data *data)
+{
+	struct meson_aoclk_reset_controller *rstc;
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	int ret, clkid;
+
+	rstc = devm_kzalloc(dev, sizeof(*rstc), GFP_KERNEL);
+	if (!rstc)
+		return -ENOMEM;
+
+	regmap = syscon_node_to_regmap(of_get_parent(dev->of_node));
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "failed to get regmap\n");
+		return -ENODEV;
+	}
+
+	/* Reset Controller */
+	rstc->regmap = regmap;
+	rstc->data = reset;
+	rstc->reg = reg;
+	rstc->reset.ops = &meson_aoclk_reset_ops;
+	rstc->reset.nr_resets = num_reset,
+	rstc->reset.of_node = dev->of_node;
+	ret = devm_reset_controller_register(dev, &rstc->reset);
+
+	/*
+	 * Populate regmap and register all clks
+	 */
+	for (clkid = 0; clkid < num_clks; clkid++) {
+		clks[clkid]->map = regmap;
+
+		ret = devm_clk_hw_register(dev, data->hws[clkid]);
+		if (ret)
+			return ret;
+	}
+
+	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
+			data);
+}
diff --git a/drivers/clk/meson/meson-aoclk.h b/drivers/clk/meson/meson-aoclk.h
new file mode 100644
index 000000000000..c82bce1728b8
--- /dev/null
+++ b/drivers/clk/meson/meson-aoclk.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2017 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * Copyright (c) 2018 Amlogic, inc.
+ * Author: Qiufang Dai <qiufang.dai@amlogic.com>
+ * Author: Yixun Lan <yixun.lan@amlogic.com>
+ */
+
+#ifndef __MESON_AOCLK_H__
+#define __MESON_AOCLK_H__
+
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include "clk-regmap.h"
+
+struct meson_aoclk_reset_controller {
+	struct reset_controller_dev reset;
+	unsigned int *data;
+	unsigned int reg;
+	struct regmap *regmap;
+};
+
+int meson_aoclkc_probe(struct platform_device *pdev, unsigned int reg,
+		unsigned int *reset, int num_reset,
+		struct clk_regmap **clks, int num_clks,
+		struct clk_hw_onecell_data *data);
+#endif
+
-- 
2.15.1
