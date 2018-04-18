Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753599AbeDRK0C (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:26:02 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:27665 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753844AbeDRKZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:25:06 -0400
X-UUID: 19f8559212da480fb187c0e3b408e578-20180418
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <airlied@linux.ie>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-clk@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Sean Wang" <sean.wang@mediatek.com>
Subject: [PATCH v1 3/4] clk: mediatek: add g3dsys support for MT2701 and MT7623
Date: Wed, 18 Apr 2018 18:24:55 +0800
Message-ID: <96dc02879c10388c2efa08b1cf33b77f938908ee.1524044917.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1524044917.git.sean.wang@mediatek.com>
References: <cover.1524044917.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add clock driver support for g3dsys on MT2701 and MT7623, which is
providing essential clock gate and reset controller to Mali-450.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/clk/mediatek/Kconfig              |  6 ++
 drivers/clk/mediatek/Makefile             |  1 +
 drivers/clk/mediatek/clk-mt2701-g3d.c     | 95 +++++++++++++++++++++++++++++++
 include/dt-bindings/clock/mt2701-clk.h    |  4 ++
 include/dt-bindings/reset/mt2701-resets.h |  3 +
 5 files changed, 109 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt2701-g3d.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 92afe59..3dd1dab 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -60,6 +60,12 @@ config COMMON_CLK_MT2701_AUDSYS
 	---help---
 	  This driver supports Mediatek MT2701 audsys clocks.
 
+config COMMON_CLK_MT2701_G3DSYS
+	bool "Clock driver for MediaTek MT2701 g3dsys"
+	depends on COMMON_CLK_MT2701
+	---help---
+	  This driver supports MediaTek MT2701 g3dsys clocks.
+
 config COMMON_CLK_MT2712
 	bool "Clock driver for MediaTek MT2712"
 	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index b80eff2..844b55d 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_COMMON_CLK_MT2701) += clk-mt2701.o
 obj-$(CONFIG_COMMON_CLK_MT2701_AUDSYS) += clk-mt2701-aud.o
 obj-$(CONFIG_COMMON_CLK_MT2701_BDPSYS) += clk-mt2701-bdp.o
 obj-$(CONFIG_COMMON_CLK_MT2701_ETHSYS) += clk-mt2701-eth.o
+obj-$(CONFIG_COMMON_CLK_MT2701_G3DSYS) += clk-mt2701-g3d.o
 obj-$(CONFIG_COMMON_CLK_MT2701_HIFSYS) += clk-mt2701-hif.o
 obj-$(CONFIG_COMMON_CLK_MT2701_IMGSYS) += clk-mt2701-img.o
 obj-$(CONFIG_COMMON_CLK_MT2701_MMSYS) += clk-mt2701-mm.o
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
new file mode 100644
index 0000000..1328c11
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mt2701-clk.h>
+
+#define GATE_G3D(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &g3d_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+static const struct mtk_gate_regs g3d_cg_regs = {
+	.sta_ofs = 0x0,
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+};
+
+static const struct mtk_gate g3d_clks[] = {
+	GATE_G3D(CLK_G3DSYS_CORE, "g3d_core", "mfg_sel", 0),
+};
+
+static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(CLK_G3DSYS_NR);
+
+	mtk_clk_register_gates(node, g3d_clks, ARRAY_SIZE(g3d_clks),
+			       clk_data);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		dev_err(&pdev->dev,
+			"could not register clock provider: %s: %d\n",
+			pdev->name, r);
+
+	mtk_register_reset_controller(node, 1, 0xc);
+
+	return r;
+}
+
+static const struct of_device_id of_match_clk_mt2701_g3d[] = {
+	{
+		.compatible = "mediatek,mt2701-g3dsys",
+		.data = clk_mt2701_g3dsys_init,
+	}, {
+		/* sentinel */
+	}
+};
+
+static int clk_mt2701_g3d_probe(struct platform_device *pdev)
+{
+	int (*clk_init)(struct platform_device *);
+	int r;
+
+	clk_init = of_device_get_match_data(&pdev->dev);
+	if (!clk_init)
+		return -EINVAL;
+
+	r = clk_init(pdev);
+	if (r)
+		dev_err(&pdev->dev,
+			"could not register clock provider: %s: %d\n",
+			pdev->name, r);
+
+	return r;
+}
+
+static struct platform_driver clk_mt2701_g3d_drv = {
+	.probe = clk_mt2701_g3d_probe,
+	.driver = {
+		.name = "clk-mt2701-g3d",
+		.of_match_table = of_match_clk_mt2701_g3d,
+	},
+};
+
+builtin_platform_driver(clk_mt2701_g3d_drv);
diff --git a/include/dt-bindings/clock/mt2701-clk.h b/include/dt-bindings/clock/mt2701-clk.h
index 24e93df..2ac62a6 100644
--- a/include/dt-bindings/clock/mt2701-clk.h
+++ b/include/dt-bindings/clock/mt2701-clk.h
@@ -431,6 +431,10 @@
 #define CLK_ETHSYS_CRYPTO			8
 #define CLK_ETHSYS_NR				9
 
+/* G3DSYS */
+#define CLK_G3DSYS_CORE				1
+#define CLK_G3DSYS_NR				2
+
 /* BDP */
 
 #define CLK_BDP_BRG_BA				1
diff --git a/include/dt-bindings/reset/mt2701-resets.h b/include/dt-bindings/reset/mt2701-resets.h
index 21deb54..50b7f06 100644
--- a/include/dt-bindings/reset/mt2701-resets.h
+++ b/include/dt-bindings/reset/mt2701-resets.h
@@ -87,4 +87,7 @@
 #define MT2701_ETHSYS_GMAC_RST			23
 #define MT2701_ETHSYS_PPE_RST			31
 
+/* G3DSYS resets */
+#define MT2701_G3DSYS_CORE_RST			0
+
 #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT2701 */
-- 
2.7.4
