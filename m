Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeBWDdK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 22:33:10 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36961 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeBWDdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 22:33:08 -0500
X-Google-Smtp-Source: AH8x227zyMMQupo8LoM2OyBP/7bF0doyyJSGwlpAXfXEUAjWxYixyKZXXNk7q7fN49PRYo38v/mCig==
From: Baolin Wang <baolin.wang@linaro.org>
To: sre@kernel.org
Cc: broonie@kernel.org, baolin.wang@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3] power: reset: Add Spreadtrum SC27xx PMIC power off support
Date: Fri, 23 Feb 2018 11:32:38 +0800
Message-Id: <b0c82288ac8594b501191dfc5b5b320c04079725.1519356443.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Spreadtrum platform, we need power off system through external SC27xx
series PMICs including the SC2720, SC2721, SC2723, SC2730 and SC2731 chips.
Thus this patch adds SC27xx series PMICs power-off support.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v2:
 - Change to build-in this driver.

Changes since v1:
 - Add remove interface.
 - Add regmap checking when probing the driver.
 - Add MODULE_ALIAS()
---
 drivers/power/reset/Kconfig           |    9 +++++
 drivers/power/reset/Makefile          |    1 +
 drivers/power/reset/sc27xx-poweroff.c |   64 +++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)
 create mode 100644 drivers/power/reset/sc27xx-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index ca0de1a..01543f5 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -227,5 +227,14 @@ config SYSCON_REBOOT_MODE
 	  register, then the bootloader can read it to take different
 	  action according to the mode.
 
+config POWER_RESET_SC27XX
+	bool "Spreadtrum SC27xx PMIC power-off driver"
+	depends on MFD_SC27XX_PMIC || COMPILE_TEST
+	help
+	  This driver supports powering off a system through
+	  Spreadtrum SC27xx series PMICs. The SC27xx series
+	  PMICs includes the SC2720, SC2721, SC2723, SC2730
+	  and SC2731 chips.
+
 endif
 
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index aeb65ed..225d645 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -27,3 +27,4 @@ obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
 obj-$(CONFIG_POWER_RESET_ZX) += zx-reboot.o
 obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
+obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/reset/sc27xx-poweroff.c
new file mode 100644
index 0000000..e3925a9
--- /dev/null
+++ b/drivers/power/reset/sc27xx-poweroff.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Spreadtrum Communications Inc.
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+
+#include <linux/cpu.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/syscore_ops.h>
+
+#define SC27XX_PWR_PD_HW	0xc2c
+#define SC27XX_PWR_OFF_EN	BIT(0)
+
+static struct regmap *regmap;
+
+/*
+ * On Spreadtrum platform, we need power off system through external SC27xx
+ * series PMICs, and it is one similar SPI bus mapped by regmap to access PMIC,
+ * which is not fast io access.
+ *
+ * So before stopping other cores, we need release other cores' resource by
+ * taking cpus down to avoid racing regmap or spi mutex lock when poweroff
+ * system through PMIC.
+ */
+void sc27xx_poweroff_shutdown(void)
+{
+	int cpu = smp_processor_id();
+
+	freeze_secondary_cpus(cpu);
+}
+
+static struct syscore_ops poweroff_syscore_ops = {
+	.shutdown = sc27xx_poweroff_shutdown,
+};
+
+static void sc27xx_poweroff_do_poweroff(void)
+{
+	regmap_write(regmap, SC27XX_PWR_PD_HW, SC27XX_PWR_OFF_EN);
+}
+
+static int sc27xx_poweroff_probe(struct platform_device *pdev)
+{
+	if (regmap)
+		return -EINVAL;
+
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap)
+		return -ENODEV;
+
+	pm_power_off = sc27xx_poweroff_do_poweroff;
+	register_syscore_ops(&poweroff_syscore_ops);
+	return 0;
+}
+
+static struct platform_driver sc27xx_poweroff_driver = {
+	.probe = sc27xx_poweroff_probe,
+	.driver = {
+		.name = "sc27xx-poweroff",
+	},
+};
+builtin_platform_driver(sc27xx_poweroff_driver);
-- 
1.7.9.5
