Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755475AbeCVNx6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:53:58 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36853 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755701AbeCVNwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:52:35 -0400
X-Google-Smtp-Source: AG47ELsY3YPwzNRo/f4d6LXZWK2kfQ+iYriyoEqq5OOJFC0kL5zWR+sObRrvOs+lDMFCXhVGVxn48Q==
From: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Subject: [RFC v2] pwm: Add Xilinx AXI Timer in PWM mode support
Date: Thu, 22 Mar 2018 14:53:16 +0100
Message-Id: <20180322135316.19685-1-alvaro.gamez@hazent.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the IP core provided by Xilinx.
This IP core can function as a two independent timers, but also use both
counters as values for period and duty cycle of a PWM output.

There can be many instances of this IP in a design, but the first one of
them will be used to generate system's clock. If we were to use this driver
against the first timer instance found on the DT, we would expose it as a
PWM controller, and reconfiguring it will break the clock.

To avoid this we add an attribute pwm-outputs to this device declaration.
This new driver will fail to probe when pwm-outputs is different than 1.

We could use a boolean, but future versions of this IP core could implement
several PWM and counters, so when (if) this happens, we would only have to
adjust the pwm-outputs comparison to allow more than one PWM devices.

Signed-off-by: Alvaro Gamez Machado <alvaro.gamez@hazent.com>
---

This is the second proposal on getting AXI Timer PWM capability into Linux. 
The other alternative, which was sent un June past year, didn't look for
pwm-output attribute, so in order not to kidnap control from
arch/microblaze/kernel/timer.c it used a different compatible string. That's
not wrong per se, but raises the question: can one piece of hardware have
two compatible strings depending on its intended use, rather than on the
nature of the hardware itself?

If there's interest in mainlining this or the proposal I sent last year, I'd
be grateful to hear from the devicetree maintainers and maybe approve or
suggest any different aproach.

Best regards

 drivers/pwm/Kconfig         |   9 ++
 drivers/pwm/Makefile        |   1 +
 drivers/pwm/pwm-axi-timer.c | 204 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+)
 create mode 100644 drivers/pwm/pwm-axi-timer.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 763ee50ea57d..8c246e58810f 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -74,6 +74,15 @@ config PWM_ATMEL_TCB
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-atmel-tcb.
 
+config PWM_AXI_TIMER
+	tristate "AXI Timer PWM support"
+	depends on ARCH_ZYNQ || MICROBLAZE
+	help
+	  Generic PWM framework driver for Xilinx's AXI Timer
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-axi-timer.
+
 config PWM_BCM_IPROC
 	tristate "iProc PWM support"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 0258a745f30c..963bf0f64daa 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
 obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
+obj-$(CONFIG_PWM_AXI_TIMER)	+= pwm-axi-timer.o
 obj-$(CONFIG_PWM_BCM_IPROC)	+= pwm-bcm-iproc.o
 obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
 obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
diff --git a/drivers/pwm/pwm-axi-timer.c b/drivers/pwm/pwm-axi-timer.c
new file mode 100644
index 000000000000..6cabdd1672c3
--- /dev/null
+++ b/drivers/pwm/pwm-axi-timer.c
@@ -0,0 +1,204 @@
+/*
+ * Copyright 2017 Alvaro Gamez Machado <alvaro.gamez@hazent.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+
+struct axi_timer_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *regs;  /* virt. address of the control registers */
+};
+
+#define TCSR0   (0x00)
+#define TLR0    (0x04)
+#define TCR0    (0x08)
+#define TCSR1   (0x10)
+#define TLR1    (0x14)
+#define TCR1    (0x18)
+
+#define TCSR_MDT        BIT(0)
+#define TCSR_UDT        BIT(1)
+#define TCSR_GENT       BIT(2)
+#define TCSR_CAPT       BIT(3)
+#define TCSR_ARHT       BIT(4)
+#define TCSR_LOAD       BIT(5)
+#define TCSR_ENIT       BIT(6)
+#define TCSR_ENT        BIT(7)
+#define TCSR_TINT       BIT(8)
+#define TCSR_PWMA       BIT(9)
+#define TCSR_ENALL      BIT(10)
+#define TCSR_CASC       BIT(11)
+
+#define to_axi_timer_pwm_chip(_chip) \
+	container_of(_chip, struct axi_timer_pwm_chip, chip)
+
+static int axi_timer_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+				int duty_ns, int period_ns)
+{
+	struct axi_timer_pwm_chip *axi_timer = to_axi_timer_pwm_chip(chip);
+	unsigned long long c;
+	int period_cycles, duty_cycles;
+	u32 tcsr;
+
+	c = clk_get_rate(axi_timer->clk);
+
+	/* When counters are configured to count down, UDT=1 (see datasheet):
+	 * PWM_PERIOD = (TLR0 + 2) * AXI_CLOCK_PERIOD
+	 * PWM_HIGH_TIME = (TLR1 + 2) * AXI_CLOCK_PERIOD
+	 */
+	period_cycles = div64_u64(c * period_ns, NSEC_PER_SEC) - 2;
+	duty_cycles = div64_u64(c * duty_ns, NSEC_PER_SEC) - 2;
+
+	iowrite32(period_cycles, axi_timer->regs + TLR0);
+	iowrite32(duty_cycles, axi_timer->regs + TLR1);
+
+	/* Load timer values */
+	tcsr = ioread32(axi_timer->regs + TCSR0);
+	iowrite32(tcsr | TCSR_LOAD, axi_timer->regs + TCSR0);
+	iowrite32(tcsr, axi_timer->regs + TCSR0);
+
+	tcsr = ioread32(axi_timer->regs + TCSR1);
+	iowrite32(tcsr | TCSR_LOAD, axi_timer->regs + TCSR1);
+	iowrite32(tcsr, axi_timer->regs + TCSR1);
+
+	return 0;
+}
+
+static int axi_timer_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct axi_timer_pwm_chip *axi_timer = to_axi_timer_pwm_chip(chip);
+
+	/* see timer data sheet for detail
+	 * !CASC - disable cascaded operation
+	 * ENALL - enable all
+	 * PWMA - enable PWM
+	 * !TINT - don't care about interrupts
+	 * ENT- enable timer itself
+	 * !ENIT - disable interrupt
+	 * !LOAD - clear the bit to let go
+	 * ARHT - auto reload
+	 * !CAPT - no external trigger
+	 * GENT - required for PWM
+	 * UDT - set the timer as down counter
+	 * !MDT - generate mode
+	 */
+	iowrite32(TCSR_ENALL | TCSR_PWMA | TCSR_ENT | TCSR_ARHT |
+		  TCSR_GENT | TCSR_UDT, axi_timer->regs + TCSR0);
+	iowrite32(TCSR_ENALL | TCSR_PWMA | TCSR_ENT | TCSR_ARHT |
+		  TCSR_GENT | TCSR_UDT, axi_timer->regs + TCSR1);
+
+	return 0;
+}
+
+static void axi_timer_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct axi_timer_pwm_chip *axi_timer = to_axi_timer_pwm_chip(chip);
+
+	u32 tcsr;
+
+	tcsr = ioread32(axi_timer->regs + TCSR0);
+	iowrite32(tcsr & ~TCSR_PWMA, axi_timer->regs + TCSR0);
+
+	tcsr = ioread32(axi_timer->regs + TCSR1);
+	iowrite32(tcsr & ~TCSR_PWMA, axi_timer->regs + TCSR1);
+}
+
+static const struct pwm_ops axi_timer_pwm_ops = {
+	.config = axi_timer_pwm_config,
+	.enable = axi_timer_pwm_enable,
+	.disable = axi_timer_pwm_disable,
+	.owner = THIS_MODULE,
+};
+
+static int axi_timer_pwm_probe(struct platform_device *pdev)
+{
+	struct axi_timer_pwm_chip *axi_timer;
+	struct resource *res;
+	int ret;
+	u32 pwm_outputs = 0;
+
+	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,pwm-outputs",
+				   &pwm_outputs);
+	if (!ret || pwm_outputs != 1) {
+		dev_warn(&pdev->dev, "invalid pwm-output (maybe this is your clock?)\n");
+		return -EINVAL;
+	}
+
+	axi_timer = devm_kzalloc(&pdev->dev, sizeof(*axi_timer), GFP_KERNEL);
+	if (!axi_timer)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	axi_timer->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(axi_timer->regs))
+		return PTR_ERR(axi_timer->regs);
+
+	axi_timer->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(axi_timer->clk))
+		return PTR_ERR(axi_timer->clk);
+
+	axi_timer->chip.dev = &pdev->dev;
+	axi_timer->chip.ops = &axi_timer_pwm_ops;
+	axi_timer->chip.npwm = 1;
+	axi_timer->chip.base = -1;
+
+	dev_info(&pdev->dev, "at 0x%08llX mapped to 0x%p\n",
+		 (unsigned long long)res->start, axi_timer->regs);
+
+	ret = pwmchip_add(&axi_timer->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to add PWM chip, error %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, axi_timer);
+
+	return 0;
+}
+
+static int axi_timer_pwm_remove(struct platform_device *pdev)
+{
+	struct axi_timer_pwm_chip *axi_timer = platform_get_drvdata(pdev);
+	unsigned int i;
+
+	for (i = 0; i < axi_timer->chip.npwm; i++)
+		pwm_disable(&axi_timer->chip.pwms[i]);
+
+	return pwmchip_remove(&axi_timer->chip);
+}
+
+static const struct of_device_id axi_timer_pwm_dt_ids[] = {
+	{ .compatible = "xlnx,axi-timer-2.0", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, axi_timer_pwm_dt_ids);
+
+static struct platform_driver axi_timer_pwm_driver = {
+	.driver = {
+		.name = "axi_timer-pwm",
+		.of_match_table = axi_timer_pwm_dt_ids,
+	},
+	.probe = axi_timer_pwm_probe,
+	.remove = axi_timer_pwm_remove,
+};
+module_platform_driver(axi_timer_pwm_driver);
+
+MODULE_ALIAS("platform:axi_timer-pwm");
+MODULE_AUTHOR("Alvaro Gamez Machado <alvaro.gamez@hazent.com>");
+MODULE_DESCRIPTION("AXI TIMER PWM Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.16.2
