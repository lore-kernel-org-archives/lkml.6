Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeECNi7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:38:59 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:9146 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbeECNiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:38:55 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Mark Brown <broonie@kernel.org>
CC: Sunny Luo <sunny.luo@amlogic.com>, Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        <linux-spi@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] spi: meson-axg: add a linear clock divider support
Date: Thu, 3 May 2018 21:36:44 +0000
Message-ID: <20180503213645.20694-4-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180503213645.20694-1-yixun.lan@amlogic.com>
References: <20180503213645.20694-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunny Luo <sunny.luo@amlogic.com>

The SPICC controller in Meson-AXG SoC is capable of using
a linear clock divider to reach a much fine tuned range of clocks,
while the old controller only use a power of two clock divider,
result at a more coarse clock range.

Also convert the clock registeration into Common Clock Framework.

Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/spi/spi-meson-spicc.c | 209 +++++++++++++++++++++++++++-------
 1 file changed, 169 insertions(+), 40 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 90b15f7d50dd..e8389d7e62e5 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -116,6 +116,9 @@
 #define SPICC_DWADDR	0x24	/* Write Address of DMA */
 
 #define SPICC_ENH_CTL0	0x38	/* Enhanced Feature */
+#define SPICC_ENH_CLK_CS_DELAY_MASK	GENMASK(15, 0)
+#define SPICC_ENH_DATARATE_MASK		GENMASK(23, 16)
+#define SPICC_ENH_DATARATE_EN		BIT(24)
 #define SPICC_ENH_MOSI_OEN		BIT(25)
 #define SPICC_ENH_CLK_OEN		BIT(26)
 #define SPICC_ENH_CS_OEN		BIT(27)
@@ -131,6 +134,7 @@
 struct meson_spicc_data {
 	unsigned int			max_speed_hz;
 	bool				has_oen;
+	bool				has_enhance_clk_div;
 };
 
 struct meson_spicc_device {
@@ -138,6 +142,7 @@ struct meson_spicc_device {
 	struct platform_device		*pdev;
 	void __iomem			*base;
 	struct clk			*core;
+	struct clk			*clk;
 	struct spi_message		*message;
 	struct spi_transfer		*xfer;
 	const struct meson_spicc_data	*data;
@@ -325,40 +330,6 @@ static irqreturn_t meson_spicc_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static u32 meson_spicc_setup_speed(struct meson_spicc_device *spicc, u32 conf,
-				   u32 speed)
-{
-	unsigned long parent, value;
-	unsigned int i, div;
-
-	parent = clk_get_rate(spicc->core);
-
-	/* Find closest inferior/equal possible speed */
-	for (i = 0 ; i < 7 ; ++i) {
-		/* 2^(data_rate+2) */
-		value = parent >> (i + 2);
-
-		if (value <= speed)
-			break;
-	}
-
-	/* If provided speed it lower than max divider, use max divider */
-	if (i > 7) {
-		div = 7;
-		dev_warn_once(&spicc->pdev->dev, "unable to get close to speed %u\n",
-			      speed);
-	} else
-		div = i;
-
-	dev_dbg(&spicc->pdev->dev, "parent %lu, speed %u -> %lu (%u)\n",
-		parent, speed, value, div);
-
-	conf &= ~SPICC_DATARATE_MASK;
-	conf |= FIELD_PREP(SPICC_DATARATE_MASK, div);
-
-	return conf;
-}
-
 static void meson_spicc_setup_xfer(struct meson_spicc_device *spicc,
 				   struct spi_transfer *xfer)
 {
@@ -367,9 +338,6 @@ static void meson_spicc_setup_xfer(struct meson_spicc_device *spicc,
 	/* Read original configuration */
 	conf = conf_orig = readl_relaxed(spicc->base + SPICC_CONREG);
 
-	/* Select closest divider */
-	conf = meson_spicc_setup_speed(spicc, conf, xfer->speed_hz);
-
 	/* Setup word width */
 	conf &= ~SPICC_BITLENGTH_MASK;
 	conf |= FIELD_PREP(SPICC_BITLENGTH_MASK,
@@ -378,6 +346,8 @@ static void meson_spicc_setup_xfer(struct meson_spicc_device *spicc,
 	/* Ignore if unchanged */
 	if (conf != conf_orig)
 		writel_relaxed(conf, spicc->base + SPICC_CONREG);
+
+	clk_set_rate(spicc->clk, xfer->speed_hz);
 }
 
 static int meson_spicc_transfer_one(struct spi_master *master,
@@ -486,9 +456,6 @@ static int meson_spicc_unprepare_transfer(struct spi_master *master)
 	/* Disable all IRQs */
 	writel(0, spicc->base + SPICC_INTREG);
 
-	/* Disable controller */
-	writel_bits_relaxed(SPICC_ENABLE, 0, spicc->base + SPICC_CONREG);
-
 	device_reset_optional(&spicc->pdev->dev);
 
 	return 0;
@@ -528,6 +495,157 @@ static void meson_spicc_cleanup(struct spi_device *spi)
 	spi->controller_state = NULL;
 }
 
+/*
+ * The Clock Mux
+ *            x-----------------x   x------------x    x------\
+ *        |---| 0) fixed factor |---| 1) old div |----|      |
+ *        |   x-----------------x   x------------x    |      |
+ * src ---|                                           |5) mux|-- out
+ *        |   x-----------------x   x------------x    |      |
+ *        |---| 2) fixed factor |---| 3) new div |0---|      |
+ *            x-----------------x   x------------x    x------/
+ *
+ * Clk path for GX series:
+ *    src -> 0 -> 1 -> out
+ *
+ * Clk path for AXG series:
+ *    src -> 0 -> 1 -> 5 -> out
+ *    src -> 2 -> 3 -> 5 -> out
+ */
+
+/* algorithm for div0 + div1: rate = freq / 4 / (2 ^ N) */
+static struct clk_fixed_factor meson_spicc_div0 = {
+	.mult	= 1,
+	.div	= 4,
+};
+
+static struct clk_divider meson_spicc_div1 = {
+	.reg	= (void *) SPICC_CONREG,
+	.shift	= 16,
+	.width	= 3,
+	.flags	= CLK_DIVIDER_POWER_OF_TWO,
+};
+
+/* algorithm for div2 + div3: rate = freq / 2 / (N + 1) */
+static struct clk_fixed_factor meson_spicc_div2 = {
+	.mult	= 1,
+	.div	= 2,
+};
+
+static struct clk_divider meson_spicc_div3 = {
+	.reg	= (void *) SPICC_ENH_CTL0,
+	.shift	= 16,
+	.width	= 8,
+};
+
+static struct clk_mux meson_spicc_sel = {
+	.reg	= (void *) SPICC_ENH_CTL0,
+	.mask	= 0x1,
+	.shift	= 24,
+};
+
+static int meson_spicc_clk_init(struct meson_spicc_device *spicc)
+{
+	struct device *dev = &spicc->pdev->dev;
+	struct clk_fixed_factor *div0;
+	struct clk_divider *div1;
+	struct clk_mux *mux;
+	struct clk_init_data init;
+	struct clk *clk;
+	const char *parent_names[1];
+	const char *mux_parent_names[2];
+	char name[32];
+
+	div0 = &meson_spicc_div0;
+	snprintf(name, sizeof(name), "%s#_div0", dev_name(dev));
+	init.name = name;
+	init.ops = &clk_fixed_factor_ops;
+	init.flags = 0;
+	parent_names[0] = __clk_get_name(spicc->core);
+	init.parent_names = parent_names;
+	init.num_parents = 1;
+
+	div0->hw.init = &init;
+
+	clk = devm_clk_register(dev, &div0->hw);
+	if (WARN_ON(IS_ERR(clk)))
+		return PTR_ERR(clk);
+
+	div1 = &meson_spicc_div1;
+	snprintf(name, sizeof(name), "%s#_div1", dev_name(dev));
+	init.name = name;
+	init.ops = &clk_divider_ops;
+	init.flags = CLK_SET_RATE_PARENT;
+	parent_names[0] = __clk_get_name(clk);
+	init.parent_names = parent_names;
+	init.num_parents = 1;
+
+	div1->reg = spicc->base + (u64) div1->reg;
+	div1->hw.init = &init;
+
+	clk = devm_clk_register(dev, &div1->hw);
+	if (WARN_ON(IS_ERR(clk)))
+		return PTR_ERR(clk);
+
+	if (spicc->data->has_enhance_clk_div == false) {
+		spicc->clk = clk;
+		return 0;
+	}
+
+	mux_parent_names[0] = __clk_get_name(clk);
+
+	div0 = &meson_spicc_div2;
+	snprintf(name, sizeof(name), "%s#_div2", dev_name(dev));
+	init.name = name;
+	init.ops = &clk_fixed_factor_ops;
+	init.flags = 0;
+	parent_names[0] = __clk_get_name(spicc->core);
+	init.parent_names = parent_names;
+	init.num_parents = 1;
+
+	div0->hw.init = &init;
+
+	clk = devm_clk_register(dev, &div0->hw);
+	if (WARN_ON(IS_ERR(clk)))
+		return PTR_ERR(clk);
+
+	div1 = &meson_spicc_div3;
+	snprintf(name, sizeof(name), "%s#_div3", dev_name(dev));
+	init.name = name;
+	init.ops = &clk_divider_ops;
+	init.flags = CLK_SET_RATE_PARENT;
+	parent_names[0] = __clk_get_name(clk);
+	init.parent_names = parent_names;
+	init.num_parents = 1;
+
+	div1->reg = spicc->base + (u64) div1->reg;
+	div1->hw.init = &init;
+
+	clk = devm_clk_register(dev, &div1->hw);
+	if (WARN_ON(IS_ERR(clk)))
+		return PTR_ERR(clk);
+
+	mux_parent_names[1] = __clk_get_name(clk);
+
+	mux = &meson_spicc_sel;
+	snprintf(name, sizeof(name), "%s#_sel", dev_name(dev));
+	init.name = name;
+	init.ops = &clk_mux_ops;
+	init.parent_names = mux_parent_names;
+	init.num_parents = 2;
+	init.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT;
+
+	mux->reg = spicc->base + (u64) mux->reg;
+	mux->hw.init = &init;
+
+	spicc->clk = devm_clk_register(dev, &mux->hw);
+	if (WARN_ON(IS_ERR(spicc->clk)))
+		return PTR_ERR(spicc->clk);
+
+	clk_set_parent(spicc->clk, clk);
+	return 0;
+}
+
 static int meson_spicc_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
@@ -557,6 +675,10 @@ static int meson_spicc_probe(struct platform_device *pdev)
 		goto out_master;
 	}
 
+	/* Set master mode and enable controller */
+	writel_relaxed(SPICC_ENABLE | SPICC_MODE_MASTER,
+			spicc->base + SPICC_CONREG);
+
 	/* Disable all IRQs */
 	writel_relaxed(0, spicc->base + SPICC_INTREG);
 
@@ -603,6 +725,12 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	master->max_speed_hz = min_t(unsigned int, rate >> 1,
 			spicc->data->max_speed_hz);
 
+	ret = meson_spicc_clk_init(spicc);
+	if (ret) {
+		dev_err(&pdev->dev, "clock registration failed\n");
+		goto out_master;
+	}
+
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (!ret)
 		return 0;
@@ -634,6 +762,7 @@ static const struct meson_spicc_data meson_spicc_gx_data = {
 static const struct meson_spicc_data meson_spicc_axg_data = {
 	.max_speed_hz		= 80000000,
 	.has_oen		= true,
+	.has_enhance_clk_div 	= true,
 };
 
 static const struct of_device_id meson_spicc_of_match[] = {
-- 
2.17.0
