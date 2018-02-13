Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965142AbeBMQ4K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:56:10 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:17056 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934514AbeBMQ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:56:06 -0500
From: Tero Kristo <t-kristo@ti.com>
To: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>, <ssantosh@kernel.org>, <mturquette@baylibre.com>
Subject: [PATCH] clk: keystone: sci-clk: add support for dynamically probing clocks
Date: Tue, 13 Feb 2018 18:55:42 +0200
Message-ID: <1518540942-25213-1-git-send-email-t-kristo@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the driver contains a large hints table for clocks that exist
on a device, however, it is possible to probe the clocks from the firmware
also. Add support for this, and drop the clock hints table support from
the driver completely. This causes the driver to send a few extra sci-clk
messages during boot, basically one extra for each device that exists on
the SoC; on K2G this is approx 80.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/keystone/sci-clk.c | 380 ++++++++++-------------------------------
 1 file changed, 90 insertions(+), 290 deletions(-)

diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
index 9cdf9d5..4cb70be 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -29,21 +29,10 @@
 #define SCI_CLK_INPUT_TERMINATION	BIT(2)
 
 /**
- * struct sci_clk_data - TI SCI clock data
- * @dev: device index
- * @num_clks: number of clocks for this device
- */
-struct sci_clk_data {
-	u16 dev;
-	u16 num_clks;
-};
-
-/**
  * struct sci_clk_provider - TI SCI clock provider representation
  * @sci: Handle to the System Control Interface protocol handler
  * @ops: Pointer to the SCI ops to be used by the clocks
  * @dev: Device pointer for the clock provider
- * @clk_data: Clock data
  * @clocks: Clocks array for this device
  * @num_clocks: Total number of clocks for this provider
  */
@@ -51,8 +40,7 @@ struct sci_clk_provider {
 	const struct ti_sci_handle *sci;
 	const struct ti_sci_clk_ops *ops;
 	struct device *dev;
-	const struct sci_clk_data *clk_data;
-	struct clk_hw **clocks;
+	struct sci_clk **clocks;
 	int num_clocks;
 };
 
@@ -61,6 +49,7 @@ struct sci_clk_provider {
  * @hw:		 Hardware clock cookie for common clock framework
  * @dev_id:	 Device index
  * @clk_id:	 Clock index
+ * @num_parents: Number of parents for this clock
  * @provider:	 Master clock provider
  * @flags:	 Flags for the clock
  */
@@ -68,6 +57,7 @@ struct sci_clk {
 	struct clk_hw hw;
 	u16 dev_id;
 	u8 clk_id;
+	u8 num_parents;
 	struct sci_clk_provider *provider;
 	u8 flags;
 };
@@ -273,38 +263,22 @@ static int sci_clk_set_parent(struct clk_hw *hw, u8 index)
 /**
  * _sci_clk_get - Gets a handle for an SCI clock
  * @provider: Handle to SCI clock provider
- * @dev_id: device ID for the clock to register
- * @clk_id: clock ID for the clock to register
+ * @sci_clk: Handle to the SCI clock to populate
  *
  * Gets a handle to an existing TI SCI hw clock, or builds a new clock
  * entry and registers it with the common clock framework. Called from
  * the common clock framework, when a corresponding of_clk_get call is
  * executed, or recursively from itself when parsing parent clocks.
- * Returns a pointer to the hw clock struct, or ERR_PTR value in failure.
+ * Returns 0 on success, negative error code on failure.
  */
-static struct clk_hw *_sci_clk_build(struct sci_clk_provider *provider,
-				     u16 dev_id, u8 clk_id)
+static int _sci_clk_build(struct sci_clk_provider *provider,
+			  struct sci_clk *sci_clk)
 {
 	struct clk_init_data init = { NULL };
-	struct sci_clk *sci_clk = NULL;
 	char *name = NULL;
 	char **parent_names = NULL;
 	int i;
-	int ret;
-
-	sci_clk = devm_kzalloc(provider->dev, sizeof(*sci_clk), GFP_KERNEL);
-	if (!sci_clk)
-		return ERR_PTR(-ENOMEM);
-
-	sci_clk->dev_id = dev_id;
-	sci_clk->clk_id = clk_id;
-	sci_clk->provider = provider;
-
-	ret = provider->ops->get_num_parents(provider->sci, dev_id,
-					     clk_id,
-					     &init.num_parents);
-	if (ret)
-		goto err;
+	int ret = 0;
 
 	name = kasprintf(GFP_KERNEL, "%s:%d:%d", dev_name(provider->dev),
 			 sci_clk->dev_id, sci_clk->clk_id);
@@ -317,11 +291,11 @@ static struct clk_hw *_sci_clk_build(struct sci_clk_provider *provider,
 	 * to have mux functionality. Otherwise it is going to act as a root
 	 * clock.
 	 */
-	if (init.num_parents < 2)
-		init.num_parents = 0;
+	if (sci_clk->num_parents < 2)
+		sci_clk->num_parents = 0;
 
-	if (init.num_parents) {
-		parent_names = kcalloc(init.num_parents, sizeof(char *),
+	if (sci_clk->num_parents) {
+		parent_names = kcalloc(sci_clk->num_parents, sizeof(char *),
 				       GFP_KERNEL);
 
 		if (!parent_names) {
@@ -329,7 +303,7 @@ static struct clk_hw *_sci_clk_build(struct sci_clk_provider *provider,
 			goto err;
 		}
 
-		for (i = 0; i < init.num_parents; i++) {
+		for (i = 0; i < sci_clk->num_parents; i++) {
 			char *parent_name;
 
 			parent_name = kasprintf(GFP_KERNEL, "%s:%d:%d",
@@ -346,6 +320,7 @@ static struct clk_hw *_sci_clk_build(struct sci_clk_provider *provider,
 	}
 
 	init.ops = &sci_clk_ops;
+	init.num_parents = sci_clk->num_parents;
 	sci_clk->hw.init = &init;
 
 	ret = devm_clk_hw_register(provider->dev, &sci_clk->hw);
@@ -354,7 +329,7 @@ static struct clk_hw *_sci_clk_build(struct sci_clk_provider *provider,
 
 err:
 	if (parent_names) {
-		for (i = 0; i < init.num_parents; i++)
+		for (i = 0; i < sci_clk->num_parents; i++)
 			kfree(parent_names[i]);
 
 		kfree(parent_names);
@@ -362,10 +337,7 @@ static struct clk_hw *_sci_clk_build(struct sci_clk_provider *provider,
 
 	kfree(name);
 
-	if (ret)
-		return ERR_PTR(ret);
-
-	return &sci_clk->hw;
+	return ret;
 }
 
 static int _cmp_sci_clk(const void *a, const void *b)
@@ -414,253 +386,20 @@ static struct clk_hw *sci_clk_get(struct of_phandle_args *clkspec, void *data)
 
 static int ti_sci_init_clocks(struct sci_clk_provider *p)
 {
-	const struct sci_clk_data *data = p->clk_data;
-	struct clk_hw *hw;
 	int i;
-	int num_clks = 0;
-
-	while (data->num_clks) {
-		num_clks += data->num_clks;
-		data++;
-	}
-
-	p->num_clocks = num_clks;
-
-	p->clocks = devm_kcalloc(p->dev, num_clks, sizeof(struct sci_clk),
-				 GFP_KERNEL);
-	if (!p->clocks)
-		return -ENOMEM;
-
-	num_clks = 0;
-
-	data = p->clk_data;
-
-	while (data->num_clks) {
-		for (i = 0; i < data->num_clks; i++) {
-			hw = _sci_clk_build(p, data->dev, i);
-			if (!IS_ERR(hw)) {
-				p->clocks[num_clks++] = hw;
-				continue;
-			}
-
-			/* Skip any holes in the clock lists */
-			if (PTR_ERR(hw) == -ENODEV)
-				continue;
+	int ret;
 
-			return PTR_ERR(hw);
-		}
-		data++;
+	for (i = 0; i < p->num_clocks; i++) {
+		ret = _sci_clk_build(p, p->clocks[i]);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
 }
 
-static const struct sci_clk_data k2g_clk_data[] = {
-	/* pmmc */
-	{ .dev = 0x0, .num_clks = 4 },
-
-	/* mlb0 */
-	{ .dev = 0x1, .num_clks = 5 },
-
-	/* dss0 */
-	{ .dev = 0x2, .num_clks = 2 },
-
-	/* mcbsp0 */
-	{ .dev = 0x3, .num_clks = 8 },
-
-	/* mcasp0 */
-	{ .dev = 0x4, .num_clks = 8 },
-
-	/* mcasp1 */
-	{ .dev = 0x5, .num_clks = 8 },
-
-	/* mcasp2 */
-	{ .dev = 0x6, .num_clks = 8 },
-
-	/* dcan0 */
-	{ .dev = 0x8, .num_clks = 2 },
-
-	/* dcan1 */
-	{ .dev = 0x9, .num_clks = 2 },
-
-	/* emif0 */
-	{ .dev = 0xa, .num_clks = 6 },
-
-	/* mmchs0 */
-	{ .dev = 0xb, .num_clks = 3 },
-
-	/* mmchs1 */
-	{ .dev = 0xc, .num_clks = 3 },
-
-	/* gpmc0 */
-	{ .dev = 0xd, .num_clks = 1 },
-
-	/* elm0 */
-	{ .dev = 0xe, .num_clks = 1 },
-
-	/* spi0 */
-	{ .dev = 0x10, .num_clks = 1 },
-
-	/* spi1 */
-	{ .dev = 0x11, .num_clks = 1 },
-
-	/* spi2 */
-	{ .dev = 0x12, .num_clks = 1 },
-
-	/* spi3 */
-	{ .dev = 0x13, .num_clks = 1 },
-
-	/* icss0 */
-	{ .dev = 0x14, .num_clks = 6 },
-
-	/* icss1 */
-	{ .dev = 0x15, .num_clks = 6 },
-
-	/* usb0 */
-	{ .dev = 0x16, .num_clks = 7 },
-
-	/* usb1 */
-	{ .dev = 0x17, .num_clks = 7 },
-
-	/* nss0 */
-	{ .dev = 0x18, .num_clks = 14 },
-
-	/* pcie0 */
-	{ .dev = 0x19, .num_clks = 1 },
-
-	/* gpio0 */
-	{ .dev = 0x1b, .num_clks = 1 },
-
-	/* gpio1 */
-	{ .dev = 0x1c, .num_clks = 1 },
-
-	/* timer64_0 */
-	{ .dev = 0x1d, .num_clks = 9 },
-
-	/* timer64_1 */
-	{ .dev = 0x1e, .num_clks = 9 },
-
-	/* timer64_2 */
-	{ .dev = 0x1f, .num_clks = 9 },
-
-	/* timer64_3 */
-	{ .dev = 0x20, .num_clks = 9 },
-
-	/* timer64_4 */
-	{ .dev = 0x21, .num_clks = 9 },
-
-	/* timer64_5 */
-	{ .dev = 0x22, .num_clks = 9 },
-
-	/* timer64_6 */
-	{ .dev = 0x23, .num_clks = 9 },
-
-	/* msgmgr0 */
-	{ .dev = 0x25, .num_clks = 1 },
-
-	/* bootcfg0 */
-	{ .dev = 0x26, .num_clks = 1 },
-
-	/* arm_bootrom0 */
-	{ .dev = 0x27, .num_clks = 1 },
-
-	/* dsp_bootrom0 */
-	{ .dev = 0x29, .num_clks = 1 },
-
-	/* debugss0 */
-	{ .dev = 0x2b, .num_clks = 8 },
-
-	/* uart0 */
-	{ .dev = 0x2c, .num_clks = 1 },
-
-	/* uart1 */
-	{ .dev = 0x2d, .num_clks = 1 },
-
-	/* uart2 */
-	{ .dev = 0x2e, .num_clks = 1 },
-
-	/* ehrpwm0 */
-	{ .dev = 0x2f, .num_clks = 1 },
-
-	/* ehrpwm1 */
-	{ .dev = 0x30, .num_clks = 1 },
-
-	/* ehrpwm2 */
-	{ .dev = 0x31, .num_clks = 1 },
-
-	/* ehrpwm3 */
-	{ .dev = 0x32, .num_clks = 1 },
-
-	/* ehrpwm4 */
-	{ .dev = 0x33, .num_clks = 1 },
-
-	/* ehrpwm5 */
-	{ .dev = 0x34, .num_clks = 1 },
-
-	/* eqep0 */
-	{ .dev = 0x35, .num_clks = 1 },
-
-	/* eqep1 */
-	{ .dev = 0x36, .num_clks = 1 },
-
-	/* eqep2 */
-	{ .dev = 0x37, .num_clks = 1 },
-
-	/* ecap0 */
-	{ .dev = 0x38, .num_clks = 1 },
-
-	/* ecap1 */
-	{ .dev = 0x39, .num_clks = 1 },
-
-	/* i2c0 */
-	{ .dev = 0x3a, .num_clks = 1 },
-
-	/* i2c1 */
-	{ .dev = 0x3b, .num_clks = 1 },
-
-	/* i2c2 */
-	{ .dev = 0x3c, .num_clks = 1 },
-
-	/* edma0 */
-	{ .dev = 0x3f, .num_clks = 2 },
-
-	/* semaphore0 */
-	{ .dev = 0x40, .num_clks = 1 },
-
-	/* intc0 */
-	{ .dev = 0x41, .num_clks = 1 },
-
-	/* gic0 */
-	{ .dev = 0x42, .num_clks = 1 },
-
-	/* qspi0 */
-	{ .dev = 0x43, .num_clks = 5 },
-
-	/* arm_64b_counter0 */
-	{ .dev = 0x44, .num_clks = 2 },
-
-	/* tetris0 */
-	{ .dev = 0x45, .num_clks = 2 },
-
-	/* cgem0 */
-	{ .dev = 0x46, .num_clks = 2 },
-
-	/* msmc0 */
-	{ .dev = 0x47, .num_clks = 1 },
-
-	/* cbass0 */
-	{ .dev = 0x49, .num_clks = 1 },
-
-	/* board0 */
-	{ .dev = 0x4c, .num_clks = 36 },
-
-	/* edma1 */
-	{ .dev = 0x4f, .num_clks = 2 },
-	{ .num_clks = 0 },
-};
-
 static const struct of_device_id ti_sci_clk_of_match[] = {
-	{ .compatible = "ti,k2g-sci-clk", .data = &k2g_clk_data },
+	{ .compatible = "ti,k2g-sci-clk" },
 	{ /* Sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, ti_sci_clk_of_match);
@@ -681,12 +420,16 @@ static int ti_sci_clk_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct sci_clk_provider *provider;
 	const struct ti_sci_handle *handle;
-	const struct sci_clk_data *data;
 	int ret;
-
-	data = of_device_get_match_data(dev);
-	if (!data)
-		return -EINVAL;
+	int num_clks = 0;
+	struct sci_clk **clks = NULL;
+	struct sci_clk **tmp_clks;
+	struct sci_clk *sci_clk;
+	int max_clks = 0;
+	int clk_id = 0;
+	int dev_id = 0;
+	u8 num_parents;
+	int gap_size = 0;
 
 	handle = devm_ti_sci_get_handle(dev);
 	if (IS_ERR(handle))
@@ -696,12 +439,69 @@ static int ti_sci_clk_probe(struct platform_device *pdev)
 	if (!provider)
 		return -ENOMEM;
 
-	provider->clk_data = data;
-
 	provider->sci = handle;
 	provider->ops = &handle->ops.clk_ops;
 	provider->dev = dev;
 
+	while (1) {
+		ret = provider->ops->get_num_parents(provider->sci, dev_id,
+						     clk_id, &num_parents);
+		if (ret) {
+			gap_size++;
+			if (!clk_id) {
+				if (gap_size >= 5)
+					break;
+				dev_id++;
+			} else {
+				if (gap_size >= 2) {
+					dev_id++;
+					clk_id = 0;
+					gap_size = 0;
+				} else {
+					clk_id++;
+				}
+			}
+			continue;
+		}
+
+		gap_size = 0;
+
+		if (num_clks == max_clks) {
+			tmp_clks = devm_kmalloc_array(dev, max_clks + 64,
+						      sizeof(sci_clk),
+						      GFP_KERNEL);
+			memcpy(tmp_clks, clks, max_clks * sizeof(sci_clk));
+			if (max_clks)
+				devm_kfree(dev, clks);
+			max_clks += 64;
+			clks = tmp_clks;
+		}
+
+		sci_clk = devm_kzalloc(dev, sizeof(*sci_clk), GFP_KERNEL);
+		if (!sci_clk)
+			return -ENOMEM;
+		sci_clk->dev_id = dev_id;
+		sci_clk->clk_id = clk_id;
+		sci_clk->provider = provider;
+		sci_clk->num_parents = num_parents;
+
+		clks[num_clks] = sci_clk;
+
+		clk_id++;
+		num_clks++;
+	}
+
+	provider->clocks = devm_kmalloc_array(dev, num_clks, sizeof(sci_clk),
+					      GFP_KERNEL);
+	if (!provider->clocks)
+		return -ENOMEM;
+
+	memcpy(provider->clocks, clks, num_clks * sizeof(sci_clk));
+
+	provider->num_clocks = num_clks;
+
+	devm_kfree(dev, clks);
+
 	ret = ti_sci_init_clocks(provider);
 	if (ret) {
 		pr_err("ti-sci-init-clocks failed.\n");
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
