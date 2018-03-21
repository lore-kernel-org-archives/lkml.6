Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AG47ELvlP5IZ5PsI1RL8vsVD41LTbNSA6DX+RPV2XMeDrNnZXZbScj4CgwqIoP81Yiq7y/u+BEns
ARC-Seal: i=1; a=rsa-sha256; t=1521607300; cv=none;
        d=google.com; s=arc-20160816;
        b=x2IvVDKbh45l3DMkJ2T7K3mBrVT9tLoHHzImWHPmggS1e7Kx5YZWsNp7LN0g8giJiS
         OD6OpbVOQebX42fsqwDXKsu/Hi2r6nNZia6PHJFR9x/FGaKqVfZv5atfzMOwynKQjMgT
         EWQ1z67bEFWMHNfcGpFku2jv3OZi/AeFZE2JmRVbfvmJ/SZ8LeVmfySfhM5AjpmuqVpi
         tNFJx5Oj88fq+V82Y5zmsfVHaTSd/zCeNofARl7vMzkPQVu3dELQcX3BIbWLCJlJ7ruk
         Po5Kti7n+As5GQurfQSL+AoAEKzNgnOqXxEBEUuQnzIvipPPOOq1oPrNzW23b7FJ13RB
         Tl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=x0nkDoZedsjYHIIK3HN68ooPdnJm3R4ph9cjRTcC0Ls=;
        b=L+nFxMUJfPY6X3NXyMEjL5xjOx9YjnOjC9wJatvLNa3/7o3VWw1+KeSxS8aMhBbOUx
         OvJvgK3nZJ3eZYqT4QHGoQC8vTo6Z0DQ8jQDE+7eEkHHUUG/OfHHL9imVB8RBb4wqegs
         kUf6Nzj+zTRqAOrCmLHEt+WDSEl2x7mF1YiS7yWSszd/9qobZ0VcxBtkc8eKqji1XbJ3
         loT5lMg8e3EORG7wjqn4ZDAdtJ+odULWq6j9hN1+HbuXiTzTRzPllwacL1GeOKqmXBjn
         fMkkcBKXOG9cEq3y3azAb8K2xaoXA/qBaIEmmKBddMRIJH1A9gtgj/5f9cUOKpr0/FZ/
         PWaA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 20 Mar 2018 21:41:38 -0700
From: Rajkumar Rampelli <rrajk@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <jdelvare@suse.com>, <linux@roeck-us.net>,
	<corbet@lwn.net>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
	<pombredanne@nexb.com>, <mmaddireddy@nvidia.com>, <mperttunen@nvidia.com>,
	<arnd@arndb.de>, <timur@codeaurora.org>, <andy.gross@linaro.org>,
	<xuwei5@hisilicon.com>, <elder@linaro.org>, <heiko@sntech.de>,
	<krzk@kernel.org>, <ard.biesheuvel@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ldewangan@nvidia.com>,
	<rrajk@nvidia.com>
Subject: [PATCH V2 5/9] pwm: tegra: Add PWM based Tachometer driver
Date: Wed, 21 Mar 2018 10:10:40 +0530
Message-ID: <1521607244-29734-6-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520896318631182?=
X-GMAIL-MSGID: =?utf-8?q?1595520896318631182?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

PWM Tachometer driver capture the PWM signal which is output of FAN
in general and provide the period of PWM signal which is converted to
RPM by SW.

Add Tegra Tachometer driver which implements the pwm-capture to
measure period.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---

V2: Renamed compatible string to "nvidia-tegra186-pwm-tachometer"
    Renamed arguments of reset and clk apis to "tachometer" from "tach"
 
 drivers/pwm/Kconfig                |  10 ++
 drivers/pwm/Makefile               |   1 +
 drivers/pwm/pwm-tegra-tachometer.c | 303 +++++++++++++++++++++++++++++++++++++
 3 files changed, 314 insertions(+)
 create mode 100644 drivers/pwm/pwm-tegra-tachometer.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 763ee50..29aeeeb 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -454,6 +454,16 @@ config PWM_TEGRA
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-tegra.
 
+config PWM_TEGRA_TACHOMETER
+	tristate "NVIDIA Tegra Tachometer PWM driver"
+	depends on ARCH_TEGRA
+	help
+	  NVIDIA Tegra Tachometer reads the PWM signal and reports the PWM
+	  signal periods. This helps in measuring the fan speed where Fan
+	  output for speed is PWM signal.
+
+	  This driver support the Tachometer driver in PWM framework.
+
 config  PWM_TIECAP
 	tristate "ECAP PWM support"
 	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 0258a74..14c183e 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
 obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
 obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
+obj-$(CONFIG_PWM_TEGRA_TACHOMETER)	+= pwm-tegra-tachometer.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
 obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
 obj-$(CONFIG_PWM_TIPWMSS)	+= pwm-tipwmss.o
diff --git a/drivers/pwm/pwm-tegra-tachometer.c b/drivers/pwm/pwm-tegra-tachometer.c
new file mode 100644
index 0000000..bcc44ce
--- /dev/null
+++ b/drivers/pwm/pwm-tegra-tachometer.c
@@ -0,0 +1,303 @@
+/*
+ * Tegra Tachometer Pulse-Width-Modulation driver
+ *
+ * Copyright (c) 2017-2018, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+
+/* Since oscillator clock (38.4MHz) serves as a clock source for
+ * the tach input controller, 1.0105263MHz (i.e. 38.4/38) has to be
+ * used as a clock value in the RPM calculations
+ */
+#define TACH_COUNTER_CLK			1010526
+
+#define TACH_FAN_TACH0				0x0
+#define TACH_FAN_TACH0_PERIOD_MASK		0x7FFFF
+#define TACH_FAN_TACH0_PERIOD_MAX		0x7FFFF
+#define TACH_FAN_TACH0_PERIOD_MIN		0x0
+#define TACH_FAN_TACH0_WIN_LENGTH_SHIFT		25
+#define TACH_FAN_TACH0_WIN_LENGTH_MASK		0x3
+#define TACH_FAN_TACH0_OVERFLOW_MASK		BIT(24)
+
+#define TACH_FAN_TACH1				0x4
+#define TACH_FAN_TACH1_HI_MASK			0x7FFFF
+/*
+ * struct pwm_tegra_tach - Tegra tachometer object
+ * @dev: device providing the Tachometer
+ * @pulse_per_rev: Pulses per revolution of a Fan
+ * @capture_window_len: Defines the window of the FAN TACH monitor
+ * @regs: physical base addresses of the controller
+ * @clk: phandle list of tachometer clocks
+ * @rst: phandle to reset the controller
+ * @chip: PWM chip providing this PWM device
+ */
+struct pwm_tegra_tach {
+	struct device		*dev;
+	void __iomem		*regs;
+	struct clk		*clk;
+	struct reset_control	*rst;
+	u32			pulse_per_rev;
+	u32			capture_window_len;
+	struct pwm_chip		chip;
+};
+
+static struct pwm_tegra_tach *to_tegra_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct pwm_tegra_tach, chip);
+}
+
+static u32 tachometer_readl(struct pwm_tegra_tach *ptt, unsigned long reg)
+{
+	return readl(ptt->regs + reg);
+}
+
+static inline void tachometer_writel(struct pwm_tegra_tach *ptt, u32 val,
+				     unsigned long reg)
+{
+	writel(val, ptt->regs + reg);
+}
+
+static int pwm_tegra_tach_set_wlen(struct pwm_tegra_tach *ptt,
+				   u32 window_length)
+{
+	u32 tach0, wlen;
+
+	/*
+	 * As per FAN Spec, the window length value should be greater than or
+	 * equal to Pulses Per Revolution value to measure the time period
+	 * values accurately.
+	 */
+	if (ptt->pulse_per_rev > ptt->capture_window_len) {
+		dev_err(ptt->dev,
+			"Window length value < pulses per revolution value\n");
+		return -EINVAL;
+	}
+
+	if (hweight8(window_length) != 1) {
+		dev_err(ptt->dev,
+			"Valid value of window length is {1, 2, 4 or 8}\n");
+		return -EINVAL;
+	}
+
+	wlen = ffs(window_length) - 1;
+	tach0 = tachometer_readl(ptt, TACH_FAN_TACH0);
+	tach0 &= ~(TACH_FAN_TACH0_WIN_LENGTH_MASK <<
+			TACH_FAN_TACH0_WIN_LENGTH_SHIFT);
+	tach0 |= wlen << TACH_FAN_TACH0_WIN_LENGTH_SHIFT;
+	tachometer_writel(ptt, tach0, TACH_FAN_TACH0);
+
+	return 0;
+}
+
+static int pwm_tegra_tach_capture(struct pwm_chip *chip,
+				  struct pwm_device *pwm,
+				  struct pwm_capture *result,
+				  unsigned long timeout)
+{
+	struct pwm_tegra_tach *ptt = to_tegra_pwm_chip(chip);
+	unsigned long period;
+	u32 tach;
+
+	tach = tachometer_readl(ptt, TACH_FAN_TACH1);
+	result->duty_cycle = tach & TACH_FAN_TACH1_HI_MASK;
+
+	tach = tachometer_readl(ptt, TACH_FAN_TACH0);
+	if (tach & TACH_FAN_TACH0_OVERFLOW_MASK) {
+		/* Fan is stalled, clear overflow state by writing 1 */
+		dev_dbg(ptt->dev, "Tachometer Overflow is detected\n");
+		tachometer_writel(ptt, tach, TACH_FAN_TACH0);
+	}
+
+	period = tach & TACH_FAN_TACH0_PERIOD_MASK;
+	if ((period == TACH_FAN_TACH0_PERIOD_MIN) ||
+	    (period == TACH_FAN_TACH0_PERIOD_MAX)) {
+		dev_dbg(ptt->dev, "Period set to min/max 0x%lx, Invalid RPM\n",
+			period);
+		result->period = 0;
+		result->duty_cycle = 0;
+		return 0;
+	}
+
+	period = period + 1;
+
+	period = DIV_ROUND_CLOSEST_ULL(period * ptt->pulse_per_rev * 1000000ULL,
+				       ptt->capture_window_len *
+				       TACH_COUNTER_CLK);
+
+	/*
+	 * period & duty cycle values are in units of micro seconds.
+	 * Hence, convert them into nano seconds and store.
+	 */
+	result->period = period * 1000;
+	result->duty_cycle = result->duty_cycle * 1000;
+
+	return 0;
+}
+
+static const struct pwm_ops pwm_tegra_tach_ops = {
+	.capture = pwm_tegra_tach_capture,
+	.owner = THIS_MODULE,
+};
+
+static int pwm_tegra_tach_read_platform_data(struct pwm_tegra_tach *ptt)
+{
+	struct device_node *np = ptt->dev->of_node;
+	u32 pval;
+	int err = 0;
+
+	err = of_property_read_u32(np, "nvidia,pulse-per-rev", &pval);
+	if (err < 0) {
+		dev_err(ptt->dev,
+			"\"nvidia,pulse-per-rev\" property is missing\n");
+		return err;
+	}
+	ptt->pulse_per_rev = pval;
+
+	err = of_property_read_u32(np, "nvidia,capture-window-len", &pval);
+	if (err < 0) {
+		dev_err(ptt->dev,
+			"\"nvidia,capture-window-len\" property is missing\n");
+		return err;
+	}
+	ptt->capture_window_len = pval;
+
+	return err;
+}
+
+static int pwm_tegra_tach_probe(struct platform_device *pdev)
+{
+	struct pwm_tegra_tach *ptt;
+	struct resource *res;
+	int err = 0;
+
+	ptt = devm_kzalloc(&pdev->dev, sizeof(*ptt), GFP_KERNEL);
+	if (!ptt)
+		return -ENOMEM;
+
+	ptt->dev = &pdev->dev;
+
+	err = pwm_tegra_tach_read_platform_data(ptt);
+	if (err < 0)
+		return err;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ptt->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ptt->regs)) {
+		dev_err(&pdev->dev, "Failed to remap I/O memory\n");
+		return PTR_ERR(ptt->regs);
+	}
+
+	platform_set_drvdata(pdev, ptt);
+
+	ptt->clk = devm_clk_get(&pdev->dev, "tachometer");
+	if (IS_ERR(ptt->clk)) {
+		err = PTR_ERR(ptt->clk);
+		dev_err(&pdev->dev, "Failed to get Tachometer clk: %d\n", err);
+		return err;
+	}
+
+	ptt->rst = devm_reset_control_get(&pdev->dev, "tachometer");
+	if (IS_ERR(ptt->rst)) {
+		err = PTR_ERR(ptt->rst);
+		dev_err(&pdev->dev, "Failed to get reset handle: %d\n", err);
+		return err;
+	}
+
+	err = clk_prepare_enable(ptt->clk);
+	if (err < 0) {
+		dev_err(&pdev->dev, "Failed to prepare clock: %d\n", err);
+		return err;
+	}
+
+	err = clk_set_rate(ptt->clk, TACH_COUNTER_CLK);
+	if (err < 0) {
+		dev_err(&pdev->dev, "Failed to set clock rate %d: %d\n",
+			TACH_COUNTER_CLK, err);
+		goto clk_unprep;
+	}
+
+	reset_control_reset(ptt->rst);
+
+	ptt->chip.dev = &pdev->dev;
+	ptt->chip.ops = &pwm_tegra_tach_ops;
+	ptt->chip.base = -1;
+	ptt->chip.npwm = 1;
+
+	err = pwmchip_add(&ptt->chip);
+	if (err < 0) {
+		dev_err(&pdev->dev, "Failed to add tachometer PWM: %d\n", err);
+		goto reset_assert;
+	}
+
+	err = pwm_tegra_tach_set_wlen(ptt, ptt->capture_window_len);
+	if (err < 0) {
+		dev_err(ptt->dev, "Failed to set window length: %d\n", err);
+		goto pwm_remove;
+	}
+
+	return 0;
+
+pwm_remove:
+	pwmchip_remove(&ptt->chip);
+
+reset_assert:
+	reset_control_assert(ptt->rst);
+
+clk_unprep:
+	clk_disable_unprepare(ptt->clk);
+
+	return err;
+}
+
+static int pwm_tegra_tach_remove(struct platform_device *pdev)
+{
+	struct pwm_tegra_tach *ptt = platform_get_drvdata(pdev);
+
+	reset_control_assert(ptt->rst);
+
+	clk_disable_unprepare(ptt->clk);
+
+	return pwmchip_remove(&ptt->chip);
+}
+
+static const struct of_device_id pwm_tegra_tach_of_match[] = {
+	{ .compatible = "nvidia,tegra186-pwm-tachometer" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pwm_tegra_tach_of_match);
+
+static struct platform_driver tegra_tach_driver = {
+	.driver = {
+		.name = "pwm-tegra-tachometer",
+		.of_match_table = pwm_tegra_tach_of_match,
+	},
+	.probe = pwm_tegra_tach_probe,
+	.remove = pwm_tegra_tach_remove,
+};
+
+module_platform_driver(tegra_tach_driver);
+
+MODULE_DESCRIPTION("PWM based NVIDIA Tegra Tachometer driver");
+MODULE_AUTHOR("Rajkumar Rampelli <rrajk@nvidia.com>");
+MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4
