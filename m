Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeBZJy4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 04:54:56 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45708 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752608AbeBZJyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 04:54:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 264D460FE9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: viresh.kumar@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, robh@kernel.org
Cc: sricharan@codeaurora.org
Subject: [PATCH v7 09/15] clk: qcom: Add KPSS ACC/GCC driver
Date: Mon, 26 Feb 2018 15:23:25 +0530
Message-Id: <1519638811-17269-10-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519638811-17269-1-git-send-email-sricharan@codeaurora.org>
References: <1519638811-17269-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

The ACC and GCC regions present in KPSSv1 contain registers to
control clocks and power to each Krait CPU and L2. For CPUfreq
purposes probe these devices and expose a mux clock that chooses
between PXO and PLL8.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/Kconfig    |  8 +++++
 drivers/clk/qcom/Makefile   |  1 +
 drivers/clk/qcom/kpss-xcc.c | 87 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 drivers/clk/qcom/kpss-xcc.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index bf14f56..8fca65d 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -235,6 +235,14 @@ config QCOM_HFPLL
 	  Say Y if you want to support CPU frequency scaling on devices
 	  such as MSM8974, APQ8084, etc.
 
+config KPSS_XCC
+	tristate "KPSS Clock Controller"
+	depends on COMMON_CLK_QCOM
+	help
+	  Support for the Krait ACC and GCC clock controllers. Say Y
+	  if you want to support CPU frequency scaling on devices such
+	  as MSM8960, APQ8064, etc.
+
 config KRAIT_CLOCKS
 	bool
 	select KRAIT_L2_ACCESSORS
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index e1e96f6..24e598a 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -40,4 +40,5 @@ obj-$(CONFIG_QCOM_CLK_APCS_MSM8916) += apcs-msm8916.o
 obj-$(CONFIG_QCOM_CLK_RPM) += clk-rpm.o
 obj-$(CONFIG_QCOM_CLK_SMD_RPM) += clk-smd-rpm.o
 obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
+obj-$(CONFIG_KPSS_XCC) += kpss-xcc.o
 obj-$(CONFIG_QCOM_HFPLL) += hfpll.o
diff --git a/drivers/clk/qcom/kpss-xcc.c b/drivers/clk/qcom/kpss-xcc.c
new file mode 100644
index 0000000..8590b5e
--- /dev/null
+++ b/drivers/clk/qcom/kpss-xcc.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+
+static const char *aux_parents[] = {
+	"pll8_vote",
+	"pxo",
+};
+
+static unsigned int aux_parent_map[] = {
+	3,
+	0,
+};
+
+static const struct of_device_id kpss_xcc_match_table[] = {
+	{ .compatible = "qcom,kpss-acc-v1", .data = (void *)1UL },
+	{ .compatible = "qcom,kpss-gcc" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, kpss_xcc_match_table);
+
+static int kpss_xcc_driver_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *id;
+	struct clk *clk;
+	struct resource *res;
+	void __iomem *base;
+	const char *name;
+
+	id = of_match_device(kpss_xcc_match_table, &pdev->dev);
+	if (!id)
+		return -ENODEV;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	if (id->data) {
+		if (of_property_read_string_index(pdev->dev.of_node,
+						  "clock-output-names",
+						  0, &name))
+			return -ENODEV;
+		base += 0x14;
+	} else {
+		name = "acpu_l2_aux";
+		base += 0x28;
+	}
+
+	clk = clk_register_mux_table(&pdev->dev, name, aux_parents,
+				     ARRAY_SIZE(aux_parents), 0, base, 0, 0x3,
+				     0, aux_parent_map, NULL);
+
+	platform_set_drvdata(pdev, clk);
+
+	return PTR_ERR_OR_ZERO(clk);
+}
+
+static int kpss_xcc_driver_remove(struct platform_device *pdev)
+{
+	clk_unregister_mux(platform_get_drvdata(pdev));
+	return 0;
+}
+
+static struct platform_driver kpss_xcc_driver = {
+	.probe = kpss_xcc_driver_probe,
+	.remove = kpss_xcc_driver_remove,
+	.driver = {
+		.name = "kpss-xcc",
+		.of_match_table = kpss_xcc_match_table,
+	},
+};
+module_platform_driver(kpss_xcc_driver);
+
+MODULE_DESCRIPTION("Krait Processor Sub System (KPSS) Clock Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:kpss-xcc");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
