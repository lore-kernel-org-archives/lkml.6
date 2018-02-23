Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeBWKYk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:24:40 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46216 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbeBWKYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:24:34 -0500
X-Google-Smtp-Source: AH8x227buZQoj8jj3eF7GbtOKX4AM7M5Bo4NRq5NK2bbRbqJKJlYoZrODMyQgpEG7g8r5z2rodgTpg==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robdclark@gmail.com,
        s.hauer@pengutronix.de, l.stach@pengutronix.de, shawnguo@kernel.org,
        fabio.estevam@nxp.com, nm@ti.com, xuwei5@hisilicon.com,
        robh+dt@kernel.org, olof@lixom.net
Subject: [PATCH V7 11/13] boot_constraint: Add Qualcomm display controller constraints
Date: Fri, 23 Feb 2018 15:53:50 +0530
Message-Id: <f64dab629806633a78400bd663b4b2cf3e41283e.1519380923.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sets boot constraints for the display controller used on Qualcomm
dragonboard 410c.

The display controlled is enabled by the bootloader to show a flash
screen during kernel boot. The handover to kernel should be without any
glitches on the screen.The resources of the display controller (like
regulators) are shared with other peripherals, which may reconfigure
those resources before the display driver comes up. The same problem can
happen if the display driver probes first, as the constraints of the
other devices (sharing same resources with display controller) may not
be honored anymore by the kernel.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/soc/qcom/Kconfig           |   8 +++
 drivers/soc/qcom/Makefile          |   1 +
 drivers/soc/qcom/boot_constraint.c | 122 +++++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+)
 create mode 100644 drivers/soc/qcom/boot_constraint.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index e050eb83341d..7bbe87f9c775 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -107,4 +107,12 @@ config QCOM_WCNSS_CTRL
 	  Client driver for the WCNSS_CTRL SMD channel, used to download nv
 	  firmware to a newly booted WCNSS chip.
 
+config QCOM_BOOT_CONSTRAINT
+	bool "Qualcomm Boot Constraints"
+	depends on ARCH_QCOM
+	select DEV_BOOT_CONSTRAINT
+	default y
+	help
+	  Say y here to enable Boot Constraints on Qualcomm platforms.
+
 endmenu
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index dcebf2814e6d..fcff64ec6538 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_QCOM_BOOT_CONSTRAINT) += boot_constraint.o
 obj-$(CONFIG_QCOM_GLINK_SSR) +=	glink_ssr.o
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
 obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
diff --git a/drivers/soc/qcom/boot_constraint.c b/drivers/soc/qcom/boot_constraint.c
new file mode 100644
index 000000000000..ca01eb50d9a9
--- /dev/null
+++ b/drivers/soc/qcom/boot_constraint.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This sets up Dragonboard 410c constraints on behalf of the bootloader, which
+ * uses display controller to display a flash screen during system boot.
+ *
+ * Copyright (c) 2018 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ * Rajendra Nayak <rnayak@codeaurora.org>
+ */
+
+#include <linux/boot_constraint.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+
+static struct dev_boot_constraint_clk_info iface_clk_info = {
+	.name = "iface_clk",
+};
+
+static struct dev_boot_constraint_clk_info bus_clk_info = {
+	.name = "bus_clk",
+};
+
+static struct dev_boot_constraint_clk_info core_clk_info = {
+	.name = "core_clk",
+};
+
+static struct dev_boot_constraint_clk_info vsync_clk_info = {
+	.name = "vsync_clk",
+};
+
+static struct dev_boot_constraint_clk_info esc0_clk_info = {
+	.name = "core_clk",
+};
+
+static struct dev_boot_constraint_clk_info byte_clk_info = {
+	.name = "byte_clk",
+};
+
+static struct dev_boot_constraint_clk_info pixel_clk_info = {
+	.name = "pixel_clk",
+};
+
+static struct dev_boot_constraint_supply_info vdda_info = {
+	.name = "vdda"
+};
+
+static struct dev_boot_constraint_supply_info vddio_info = {
+	.name = "vddio"
+};
+
+static struct dev_boot_constraint constraints_mdss[] = {
+	{
+		.type = DEV_BOOT_CONSTRAINT_PM,
+		.data = NULL,
+	},
+};
+
+static struct dev_boot_constraint constraints_mdp[] = {
+	{
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &iface_clk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &bus_clk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &core_clk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &vsync_clk_info,
+	},
+};
+
+static struct dev_boot_constraint constraints_dsi[] = {
+	{
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &esc0_clk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &byte_clk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &pixel_clk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_SUPPLY,
+		.data = &vdda_info,
+
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_SUPPLY,
+		.data = &vddio_info,
+	},
+};
+
+static struct dev_boot_constraint_of constraints[] = {
+	{
+		.compat = "qcom,mdss",
+		.constraints = constraints_mdss,
+		.count = ARRAY_SIZE(constraints_mdss),
+	}, {
+		.compat = "qcom,mdp5",
+		.constraints = constraints_mdp,
+		.count = ARRAY_SIZE(constraints_mdp),
+	}, {
+		.compat = "qcom,mdss-dsi-ctrl",
+		.constraints = constraints_dsi,
+		.count = ARRAY_SIZE(constraints_dsi),
+	},
+};
+
+static int __init qcom_constraints_init(void)
+{
+	/* Only Dragonboard 410c is supported for now */
+	if (!of_machine_is_compatible("qcom,apq8016-sbc"))
+		return 0;
+
+	dev_boot_constraint_add_deferrable_of(constraints,
+					      ARRAY_SIZE(constraints));
+
+	return 0;
+}
+subsys_initcall(qcom_constraints_init);
-- 
2.15.0.194.g9af6a3dea062
