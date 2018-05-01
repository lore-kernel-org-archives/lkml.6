Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754485AbeEAImJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 04:42:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54414 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754262AbeEAImC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 04:42:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E88E60FF6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From: Taniya Das <tdas@codeaurora.org>
To: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [v5 2/2] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
Date: Tue,  1 May 2018 14:11:33 +0530
Message-Id: <1525164093-16645-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525164093-16645-1-git-send-email-tdas@codeaurora.org>
References: <1525164093-16645-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the RPMh clock driver to control the RPMh managed clock resources on
some of the Qualcomm Technologies, Inc. SoCs.

Signed-off-by: Amit Nischal <anischal@codeaurora.org>
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/Kconfig              |   9 +
 drivers/clk/qcom/Makefile             |   1 +
 drivers/clk/qcom/clk-rpmh.c           | 387 ++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/qcom,rpmh.h |   2 -
 4 files changed, 397 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/qcom/clk-rpmh.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index e42e1af..627e6e1 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -59,6 +59,15 @@ config QCOM_CLK_SMD_RPM
 	  Say Y if you want to support the clocks exposed by the RPM on
 	  platforms such as apq8016, apq8084, msm8974 etc.

+config QCOM_CLK_RPMH
+	tristate "RPMh Clock Driver"
+	depends on COMMON_CLK_QCOM && QCOM_RPMH
+	help
+	 RPMh manages shared resources on some Qualcomm Technologies, Inc.
+	 SoCs. It accepts requests from other hardware subsystems via RSC.
+	 Say Y if you want to support the clocks exposed by RPMh on
+	 platforms such as SDM845.
+
 config APQ_GCC_8084
 	tristate "APQ8084 Global Clock Controller"
 	select QCOM_GDSC
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 7c09ab1..246a721 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -37,5 +37,6 @@ obj-$(CONFIG_MSM_MMCC_8996) += mmcc-msm8996.o
 obj-$(CONFIG_QCOM_A53PLL) += a53-pll.o
 obj-$(CONFIG_QCOM_CLK_APCS_MSM8916) += apcs-msm8916.o
 obj-$(CONFIG_QCOM_CLK_RPM) += clk-rpm.o
+obj-$(CONFIG_QCOM_CLK_RPMH) += clk-rpmh.o
 obj-$(CONFIG_QCOM_CLK_SMD_RPM) += clk-smd-rpm.o
 obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
new file mode 100644
index 0000000..9cb7aa4
--- /dev/null
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <soc/qcom/cmd-db.h>
+#include <soc/qcom/rpmh.h>
+
+#include <dt-bindings/clock/qcom,rpmh.h>
+
+#define CLK_RPMH_ARC_EN_OFFSET		0
+#define CLK_RPMH_VRM_EN_OFFSET		4
+
+/**
+ * struct clk_rpmh - individual rpmh clock data structure
+ * @hw:			handle between common and hardware-specific interfaces
+ * @res_name:		resource name for the rpmh clock
+ * @div:		clock divider to compute the clock rate
+ * @res_addr:		base address of the rpmh resource within the RPMh
+ * @res_on_val:		rpmh clock enable value
+ * @res_off_val:	rpmh clock disable value
+ * @state:		rpmh clock requested state
+ * @aggr_state:		rpmh clock aggregated state
+ * @last_sent_aggr_state: rpmh clock last aggr state sent to RPMh
+ * @valid_state_mask:	mask to determine the state of the rpmh clock
+ * @rpmh_client:	handle used for rpmh communications
+ * @dev:		device to which it is attached
+ * @peer:		pointer to the clock rpmh sibling
+ */
+struct clk_rpmh {
+	struct clk_hw hw;
+	const char *res_name;
+	u8  div;
+	u32 res_addr;
+	u32 res_on_val;
+	u32 res_off_val;
+	u32 state;
+	u32 aggr_state;
+	u32 last_sent_aggr_state;
+	u32 valid_state_mask;
+	struct rpmh_client *rpmh_client;
+	struct device *dev;
+	struct clk_rpmh *peer;
+};
+
+struct clk_rpmh_desc {
+	struct clk_hw **clks;
+	size_t num_clks;
+};
+
+static DEFINE_MUTEX(rpmh_clk_lock);
+
+#define __DEFINE_CLK_RPMH(_platform, _name, _name_active, _res_name,	\
+			  _res_en_offset, _res_on, _res_off)		\
+	static struct clk_rpmh _platform##_##_name_active;		\
+	static struct clk_rpmh _platform##_##_name = {			\
+		.res_name = _res_name,					\
+		.res_addr = _res_en_offset,				\
+		.res_on_val = _res_on,					\
+		.res_off_val = _res_off,				\
+		.peer = &_platform##_##_name_active,			\
+		.valid_state_mask = (BIT(RPMH_WAKE_ONLY_STATE) |	\
+				      BIT(RPMH_ACTIVE_ONLY_STATE) |	\
+				      BIT(RPMH_SLEEP_STATE)),		\
+		.hw.init = &(struct clk_init_data){			\
+			.ops = &clk_rpmh_ops,				\
+			.name = #_name,					\
+			.parent_names = (const char *[]){ "xo_board" },	\
+			.num_parents = 1,				\
+		},							\
+	};								\
+	static struct clk_rpmh _platform##_##_name_active = {		\
+		.res_name = _res_name,					\
+		.res_addr = _res_en_offset,				\
+		.res_on_val = _res_on,					\
+		.res_off_val = _res_off,				\
+		.peer = &_platform##_##_name,				\
+		.valid_state_mask = (BIT(RPMH_WAKE_ONLY_STATE) |	\
+					BIT(RPMH_ACTIVE_ONLY_STATE)),	\
+		.hw.init = &(struct clk_init_data){			\
+			.ops = &clk_rpmh_ops,				\
+			.name = #_name_active,				\
+			.parent_names = (const char *[]){ "xo_board" },	\
+			.num_parents = 1,				\
+		},							\
+	}
+
+#define DEFINE_CLK_RPMH_ARC(_platform, _name, _name_active, _res_name,	\
+			    _res_on, _res_off)				\
+	__DEFINE_CLK_RPMH(_platform, _name, _name_active, _res_name,	\
+			  CLK_RPMH_ARC_EN_OFFSET, _res_on, _res_off)
+
+#define DEFINE_CLK_RPMH_VRM(_platform, _name, _name_active, _res_name)	\
+	__DEFINE_CLK_RPMH(_platform, _name, _name_active, _res_name,	\
+			  CLK_RPMH_VRM_EN_OFFSET, true, false)
+
+static inline struct clk_rpmh *to_clk_rpmh(struct clk_hw *_hw)
+{
+	return container_of(_hw, struct clk_rpmh, hw);
+}
+
+static inline bool has_state_changed(struct clk_rpmh *c, u32 state)
+{
+	return (c->last_sent_aggr_state & BIT(state))
+		!= (c->aggr_state & BIT(state));
+}
+
+static int clk_rpmh_send_aggregate_command(struct clk_rpmh *c)
+{
+	struct tcs_cmd cmd = { 0 };
+	u32 cmd_state, on_val;
+	enum rpmh_state state = RPMH_SLEEP_STATE;
+	int ret;
+
+	cmd.addr = c->res_addr;
+	cmd_state = c->aggr_state;
+	on_val = c->res_on_val;
+
+	for (; state <= RPMH_ACTIVE_ONLY_STATE; state++) {
+		if (has_state_changed(c, state)) {
+			cmd.data = (cmd_state & BIT(state)) ? on_val : 0;
+			ret = rpmh_write_async(c->rpmh_client, state,
+						&cmd, 1);
+			if (ret) {
+				dev_err(c->dev, "set %s state of %s failed: (%d)\n",
+					!state ? "sleep" :
+					state == RPMH_WAKE_ONLY_STATE	?
+					"wake" : "active", c->res_name, ret);
+				return ret;
+			}
+		}
+	}
+
+	c->last_sent_aggr_state = c->aggr_state;
+	c->peer->last_sent_aggr_state =  c->last_sent_aggr_state;
+
+	return 0;
+}
+
+/*
+ * Update state and aggregate state values based on enable value.
+ */
+static int clk_rpmh_aggregate_state_send_command(struct clk_rpmh *c,
+						bool enable)
+{
+	int ret;
+
+	c->state = enable ? c->valid_state_mask : 0;
+	c->aggr_state = c->state | c->peer->state;
+	c->peer->aggr_state = c->aggr_state;
+
+	ret = clk_rpmh_send_aggregate_command(c);
+	if (ret && enable) {
+		c->state = 0;
+	} else if (ret) {
+		c->state = c->valid_state_mask;
+		WARN(1, "clk: %s failed to disable\n", c->res_name);
+	}
+
+	return ret;
+}
+
+static int clk_rpmh_prepare(struct clk_hw *hw)
+{
+	struct clk_rpmh *c = to_clk_rpmh(hw);
+	int ret = 0;
+
+	mutex_lock(&rpmh_clk_lock);
+
+	if (!c->state)
+		ret = clk_rpmh_aggregate_state_send_command(c, true);
+
+	mutex_unlock(&rpmh_clk_lock);
+	return ret;
+};
+
+static void clk_rpmh_unprepare(struct clk_hw *hw)
+{
+	struct clk_rpmh *c = to_clk_rpmh(hw);
+
+	mutex_lock(&rpmh_clk_lock);
+
+	if (c->state)
+		clk_rpmh_aggregate_state_send_command(c, false);
+
+	mutex_unlock(&rpmh_clk_lock);
+};
+
+static unsigned long clk_rpmh_recalc_rate(struct clk_hw *hw,
+						unsigned long prate)
+{
+	struct clk_rpmh *r = to_clk_rpmh(hw);
+	unsigned long rate;
+
+	/*
+	 * RPMh clocks have a fixed rate.
+	 */
+	rate =  prate;
+	do_div(rate, r->div);
+
+	return rate;
+}
+
+static const struct clk_ops clk_rpmh_ops = {
+	.prepare	= clk_rpmh_prepare,
+	.unprepare	= clk_rpmh_unprepare,
+	.recalc_rate	= clk_rpmh_recalc_rate,
+};
+
+/* Resource name must match resource id present in cmd-db. */
+DEFINE_CLK_RPMH_ARC(sdm845, bi_tcxo, bi_tcxo_ao, "xo.lvl", 0x3, 0x0);
+DEFINE_CLK_RPMH_VRM(sdm845, ln_bb_clk2, ln_bb_clk2_ao, "lnbclka2");
+DEFINE_CLK_RPMH_VRM(sdm845, ln_bb_clk3, ln_bb_clk3_ao, "lnbclka3");
+DEFINE_CLK_RPMH_VRM(sdm845, rf_clk1, rf_clk1_ao, "rfclka1");
+DEFINE_CLK_RPMH_VRM(sdm845, rf_clk2, rf_clk2_ao, "rfclka2");
+DEFINE_CLK_RPMH_VRM(sdm845, rf_clk3, rf_clk3_ao, "rfclka3");
+
+static struct clk_hw *sdm845_rpmh_clocks[] = {
+	[RPMH_CXO_CLK]		= &sdm845_bi_tcxo.hw,
+	[RPMH_CXO_CLK_A]	= &sdm845_bi_tcxo_ao.hw,
+	[RPMH_LN_BB_CLK2]	= &sdm845_ln_bb_clk2.hw,
+	[RPMH_LN_BB_CLK2_A]	= &sdm845_ln_bb_clk2_ao.hw,
+	[RPMH_LN_BB_CLK3]	= &sdm845_ln_bb_clk3.hw,
+	[RPMH_LN_BB_CLK3_A]	= &sdm845_ln_bb_clk3_ao.hw,
+	[RPMH_RF_CLK1]		= &sdm845_rf_clk1.hw,
+	[RPMH_RF_CLK1_A]	= &sdm845_rf_clk1_ao.hw,
+	[RPMH_RF_CLK2]		= &sdm845_rf_clk2.hw,
+	[RPMH_RF_CLK2_A]	= &sdm845_rf_clk2_ao.hw,
+	[RPMH_RF_CLK3]		= &sdm845_rf_clk3.hw,
+	[RPMH_RF_CLK3_A]	= &sdm845_rf_clk3_ao.hw,
+};
+
+static const struct clk_rpmh_desc clk_rpmh_sdm845 = {
+	.clks = sdm845_rpmh_clocks,
+	.num_clks = ARRAY_SIZE(sdm845_rpmh_clocks),
+};
+
+static int clk_rpmh_probe(struct platform_device *pdev)
+{
+	struct clk *clk;
+	struct clk_hw_onecell_data *hw_data;
+	struct clk_hw **hw_clks;
+	struct clk_rpmh *rpmh_clk;
+	const struct clk_rpmh_desc *desc;
+	struct rpmh_client *rpmh_client;
+	struct device *dev;
+	size_t num_clks, i;
+	int ret;
+
+	dev = &pdev->dev;
+
+	ret = cmd_db_ready();
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Command DB not available (%d)\n",	ret);
+		return ret;
+	}
+
+	rpmh_client = rpmh_get_client(pdev);
+	if (IS_ERR(rpmh_client)) {
+		ret = PTR_ERR(rpmh_client);
+		dev_err(dev, "Failed to request RPMh client, ret=%d\n",	ret);
+		return ret;
+	}
+
+	desc = of_device_get_match_data(&pdev->dev);
+	hw_clks = desc->clks;
+	num_clks = desc->num_clks;
+
+	hw_data = devm_kzalloc(dev,
+			sizeof(*hw_data) + num_clks * sizeof(struct clk_hw *),
+			GFP_KERNEL);
+	if (!hw_data)
+		return -ENOMEM;
+
+	hw_data->num = num_clks;
+
+	for (i = 0; i < num_clks; i++) {
+		const char *clk_name;
+		struct property *prop;
+		const __be32 *p;
+		u32 res_addr;
+		int div, j = 0;
+
+		rpmh_clk = to_clk_rpmh(hw_clks[i]);
+		res_addr = cmd_db_read_addr(rpmh_clk->res_name);
+		if (!res_addr) {
+			dev_err(dev, "missing RPMh resource address for %s\n",
+					rpmh_clk->res_name);
+			ret = -ENODEV;
+			goto err;
+		}
+		rpmh_clk->res_addr += res_addr;
+
+		rpmh_clk->rpmh_client = rpmh_client;
+
+		/* default div for all clocks */
+		if (!rpmh_clk->div)
+			rpmh_clk->div = 1;
+
+		of_property_for_each_u32(pdev->dev.of_node, "assigned-clk-divs",
+						prop, p, div) {
+			of_property_read_string_index(pdev->dev.of_node,
+					"clk-output-names", j, &clk_name);
+			if (!strcmp(clk_name, hw_clks[i]->init->name)) {
+				rpmh_clk->div = div;
+				rpmh_clk->peer->div = div;
+			}
+			j++;
+		}
+
+		clk = devm_clk_register(&pdev->dev, hw_clks[i]);
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			dev_err(dev, "failed to register %s\n",
+					hw_clks[i]->init->name);
+			goto err;
+		}
+
+		rpmh_clk->dev = &pdev->dev;
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+				      hw_data);
+	if (ret) {
+		dev_err(dev, "Failed to add clock provider\n");
+		goto err;
+	}
+
+	dev_dbg(dev, "Registered RPMh clocks\n");
+
+	return 0;
+err:
+	if (rpmh_client)
+		rpmh_release(rpmh_client);
+
+	return ret;
+}
+
+static int clk_rpmh_remove(struct platform_device *pdev)
+{
+	const struct clk_rpmh_desc *desc =
+			of_device_get_match_data(&pdev->dev);
+	struct clk_hw **hw_clks = desc->clks;
+	struct clk_rpmh *rpmh_clk = to_clk_rpmh(hw_clks[0]);
+
+	rpmh_release(rpmh_clk->rpmh_client);
+
+	return 0;
+}
+
+static const struct of_device_id clk_rpmh_match_table[] = {
+	{ .compatible = "qcom,sdm845-rpmh-clk", .data = &clk_rpmh_sdm845},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, clk_rpmh_match_table);
+
+static struct platform_driver clk_rpmh_driver = {
+	.probe		= clk_rpmh_probe,
+	.remove		= clk_rpmh_remove,
+	.driver		= {
+		.name	= "clk-rpmh",
+		.of_match_table = clk_rpmh_match_table,
+	},
+};
+
+static int __init clk_rpmh_init(void)
+{
+	return platform_driver_register(&clk_rpmh_driver);
+}
+subsys_initcall(clk_rpmh_init);
+
+static void __exit clk_rpmh_exit(void)
+{
+	platform_driver_unregister(&clk_rpmh_driver);
+}
+module_exit(clk_rpmh_exit);
+
+MODULE_DESCRIPTION("QCOM RPMh Clock Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/dt-bindings/clock/qcom,rpmh.h b/include/dt-bindings/clock/qcom,rpmh.h
index 36caab2..f48fbd6 100644
--- a/include/dt-bindings/clock/qcom,rpmh.h
+++ b/include/dt-bindings/clock/qcom,rpmh.h
@@ -18,7 +18,5 @@
 #define RPMH_RF_CLK2_A				9
 #define RPMH_RF_CLK3				10
 #define RPMH_RF_CLK3_A				11
-#define RPMH_RF_CLK4				12
-#define RPMH_RF_CLK4_A				13

 #endif
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
