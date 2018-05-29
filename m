Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932987AbeE2KOQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:14:16 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:32946 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932866AbeE2KOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:14:10 -0400
From: Tomer Maimon <tmaimon77@gmail.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, jdelvare@suse.com,
        linux@roeck-us.net, avifishman70@gmail.com, yuenn@google.com,
        brendanhiggins@google.com, venture@google.com, joel@jms.id.au
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 2/2] hwmon: npcm-pwm: add NPCM7xx PWM driver
Date: Tue, 29 May 2018 13:02:21 +0300
Message-Id: <1527588141-18639-3-git-send-email-tmaimon77@gmail.com>
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1527588141-18639-1-git-send-email-tmaimon77@gmail.com>
References: <1527588141-18639-1-git-send-email-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Nuvoton BMC NPCM7xx Pulse Width Modulation (PWM) driver.

The Nuvoton BMC NPCM7xx has two identical PWM controller modules,
each module has four PWM controller outputs.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/hwmon/Kconfig       |   6 +
 drivers/hwmon/Makefile      |   1 +
 drivers/hwmon/npcm7xx-pwm.c | 363 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 370 insertions(+)
 create mode 100644 drivers/hwmon/npcm7xx-pwm.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 6ec307c93ece..693ba09cff8e 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1891,6 +1891,12 @@ config SENSORS_XGENE
 	  If you say yes here you get support for the temperature
 	  and power sensors for APM X-Gene SoC.
 
+config SENSORS_NPCM7XX
+	tristate "Nuvoton NPCM7XX PWM driver"
+	help
+	  This driver provides support for Nuvoton NPCM7XX PWM
+	  controller.
+
 if ACPI
 
 comment "ACPI drivers"
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index e7d52a36e6c4..24aad895a3bb 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -174,6 +174,7 @@ obj-$(CONFIG_SENSORS_W83L786NG)	+= w83l786ng.o
 obj-$(CONFIG_SENSORS_WM831X)	+= wm831x-hwmon.o
 obj-$(CONFIG_SENSORS_WM8350)	+= wm8350-hwmon.o
 obj-$(CONFIG_SENSORS_XGENE)	+= xgene-hwmon.o
+obj-$(CONFIG_SENSORS_NPCM7XX)	+= npcm7xx-pwm.o
 
 obj-$(CONFIG_PMBUS)		+= pmbus/
 
diff --git a/drivers/hwmon/npcm7xx-pwm.c b/drivers/hwmon/npcm7xx-pwm.c
new file mode 100644
index 000000000000..6122ca82b94d
--- /dev/null
+++ b/drivers/hwmon/npcm7xx-pwm.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2014-2018 Nuvoton Technology corporation.
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/sysfs.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+
+/* NPCM7XX PWM port base address */
+#define NPCM7XX_PWM_REG_PR		0x0
+#define NPCM7XX_PWM_REG_CSR		0x4
+#define NPCM7XX_PWM_REG_CR		0x8
+#define NPCM7XX_PWM_REG_CNRx(PORT)	(0xC + (12 * PORT))
+#define NPCM7XX_PWM_REG_CMRx(PORT)	(0x10 + (12 * PORT))
+#define NPCM7XX_PWM_REG_PDRx(PORT)	(0x14 + (12 * PORT))
+#define NPCM7XX_PWM_REG_PIER		0x3C
+#define NPCM7XX_PWM_REG_PIIR		0x40
+
+#define NPCM7XX_PWM_CTRL_CH0_MODE_BIT		BIT(3)
+#define NPCM7XX_PWM_CTRL_CH1_MODE_BIT		BIT(11)
+#define NPCM7XX_PWM_CTRL_CH2_MODE_BIT		BIT(15)
+#define NPCM7XX_PWM_CTRL_CH3_MODE_BIT		BIT(19)
+
+#define NPCM7XX_PWM_CTRL_CH0_INV_BIT		BIT(2)
+#define NPCM7XX_PWM_CTRL_CH1_INV_BIT		BIT(10)
+#define NPCM7XX_PWM_CTRL_CH2_INV_BIT		BIT(14)
+#define NPCM7XX_PWM_CTRL_CH3_INV_BIT		BIT(18)
+
+#define NPCM7XX_PWM_CTRL_CH0_EN_BIT		BIT(0)
+#define NPCM7XX_PWM_CTRL_CH1_EN_BIT		BIT(8)
+#define NPCM7XX_PWM_CTRL_CH2_EN_BIT		BIT(12)
+#define NPCM7XX_PWM_CTRL_CH3_EN_BIT		BIT(16)
+
+/* Define the maximum PWM channel number */
+#define NPCM7XX_PWM_MAX_CHN_NUM			8
+#define NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE	4
+#define NPCM7XX_PWM_MAX_MODULES                 2
+
+/* Define the Counter Register, value = 100 for match 100% */
+#define NPCM7XX_PWM_COUNTER_DEFALUT_NUM		255
+#define NPCM7XX_PWM_COMPARATOR_DEFALUT_NUM	127
+
+#define NPCM7XX_PWM_COMPARATOR_MAX		255
+
+
+/* default all PWM channels PRESCALE2 = 1 */
+#define NPCM7XX_PWM_PRESCALE2_DEFALUT_CH0	0x4
+#define NPCM7XX_PWM_PRESCALE2_DEFALUT_CH1	0x40
+#define NPCM7XX_PWM_PRESCALE2_DEFALUT_CH2	0x400
+#define NPCM7XX_PWM_PRESCALE2_DEFALUT_CH3	0x4000
+
+#define PWM_OUTPUT_FREQ_25KHZ			25000
+#define PWN_CNT_DEFAULT				256
+#define MIN_PRESCALE1				2
+#define NPCM7XX_PWM_PRESCALE_SHIFT_CH01		8
+
+#define NPCM7XX_PWM_PRESCALE2_DEFALUT	(NPCM7XX_PWM_PRESCALE2_DEFALUT_CH0 | \
+					NPCM7XX_PWM_PRESCALE2_DEFALUT_CH1 | \
+					NPCM7XX_PWM_PRESCALE2_DEFALUT_CH2 | \
+					NPCM7XX_PWM_PRESCALE2_DEFALUT_CH3)
+
+#define NPCM7XX_PWM_CTRL_MODE_DEFALUT	(NPCM7XX_PWM_CTRL_CH0_MODE_BIT | \
+					NPCM7XX_PWM_CTRL_CH1_MODE_BIT | \
+					NPCM7XX_PWM_CTRL_CH2_MODE_BIT | \
+					NPCM7XX_PWM_CTRL_CH3_MODE_BIT)
+
+#define NPCM7XX_PWM_CTRL_EN_DEFALUT	(NPCM7XX_PWM_CTRL_CH0_EN_BIT | \
+					NPCM7XX_PWM_CTRL_CH1_EN_BIT | \
+					NPCM7XX_PWM_CTRL_CH2_EN_BIT | \
+					NPCM7XX_PWM_CTRL_CH3_EN_BIT)
+
+struct npcm7xx_pwm_data {
+	unsigned long clk_freq;
+	void __iomem *pwm_base[NPCM7XX_PWM_MAX_MODULES];
+	struct mutex npcm7xx_pwm_lock[NPCM7XX_PWM_MAX_CHN_NUM];
+};
+
+static const struct of_device_id pwm_dt_id[];
+
+static int npcm7xx_pwm_config_set(struct npcm7xx_pwm_data *data, int channel,
+				  u16 val)
+{
+	u32 PWMChannel = (channel % NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE);
+	u32 n_module = (channel / NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE);
+	u32 u32TmpBuf = 0, ctrl_en_bit;
+
+	/*
+	 * Config PWM Comparator register for setting duty cycle
+	 */
+	if (val < 0 || val > NPCM7XX_PWM_COMPARATOR_MAX)
+		return -EINVAL;
+
+	/* write new CMR value  */
+	iowrite32(val, data->pwm_base[n_module] +
+		  NPCM7XX_PWM_REG_CMRx(PWMChannel));
+
+	u32TmpBuf = ioread32(data->pwm_base[n_module] + NPCM7XX_PWM_REG_CR);
+
+	switch (PWMChannel) {
+	case 0:
+		ctrl_en_bit = NPCM7XX_PWM_CTRL_CH0_EN_BIT;
+		break;
+	case 1:
+		ctrl_en_bit = NPCM7XX_PWM_CTRL_CH1_EN_BIT;
+		break;
+	case 2:
+		ctrl_en_bit = NPCM7XX_PWM_CTRL_CH2_EN_BIT;
+		break;
+	case 3:
+		ctrl_en_bit = NPCM7XX_PWM_CTRL_CH3_EN_BIT;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	if (val == 0)
+		/* Disable PWM */
+		u32TmpBuf &= ~(ctrl_en_bit);
+	else
+		/* Enable PWM */
+		u32TmpBuf |= ctrl_en_bit;
+
+	mutex_lock(&data->npcm7xx_pwm_lock[n_module]);
+	iowrite32(u32TmpBuf, data->pwm_base[n_module] + NPCM7XX_PWM_REG_CR);
+	mutex_unlock(&data->npcm7xx_pwm_lock[n_module]);
+
+	return 0;
+}
+
+static int npcm7xx_read_pwm(struct device *dev, u32 attr, int channel,
+			     long *val)
+{
+	struct npcm7xx_pwm_data *data = dev_get_drvdata(dev);
+	u32 PWMChannel = (channel % NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE);
+	u32 n_module = (channel / NPCM7XX_PWM_MAX_CHN_NUM_IN_A_MODULE);
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	switch (attr) {
+	case hwmon_pwm_input:
+		*val = (long)ioread32(data->pwm_base[n_module] +
+				      NPCM7XX_PWM_REG_CMRx(PWMChannel));
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int npcm7xx_write_pwm(struct device *dev, u32 attr, int channel,
+			      long val)
+{
+	struct npcm7xx_pwm_data *data = dev_get_drvdata(dev);
+	int err = 0;
+
+	switch (attr) {
+	case hwmon_pwm_input:
+		err = npcm7xx_pwm_config_set(data, channel, (u16)val);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+static umode_t npcm7xx_pwm_is_visible(const void *_data, u32 attr, int channel)
+{
+	switch (attr) {
+	case hwmon_pwm_input:
+		return 0644;
+	default:
+		return 0;
+	}
+}
+
+static int npcm7xx_read(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long *val)
+{
+	switch (type) {
+	case hwmon_pwm:
+		return npcm7xx_read_pwm(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int npcm7xx_write(struct device *dev, enum hwmon_sensor_types type,
+			  u32 attr, int channel, long val)
+{
+	switch (type) {
+	case hwmon_pwm:
+		return npcm7xx_write_pwm(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t npcm7xx_is_visible(const void *data,
+				   enum hwmon_sensor_types type,
+				   u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_pwm:
+		return npcm7xx_pwm_is_visible(data, attr, channel);
+	default:
+		return 0;
+	}
+}
+
+static const u32 npcm7xx_pwm_config[] = {
+	HWMON_PWM_INPUT,
+	HWMON_PWM_INPUT,
+	HWMON_PWM_INPUT,
+	HWMON_PWM_INPUT,
+	HWMON_PWM_INPUT,
+	HWMON_PWM_INPUT,
+	HWMON_PWM_INPUT,
+	HWMON_PWM_INPUT,
+	0
+};
+
+static const struct hwmon_channel_info npcm7xx_pwm = {
+	.type = hwmon_pwm,
+	.config = npcm7xx_pwm_config,
+};
+
+static const struct hwmon_channel_info *npcm7xx_info[] = {
+	&npcm7xx_pwm,
+	NULL
+};
+
+static const struct hwmon_ops npcm7xx_hwmon_ops = {
+	.is_visible = npcm7xx_is_visible,
+	.read = npcm7xx_read,
+	.write = npcm7xx_write,
+};
+
+static const struct hwmon_chip_info npcm7xx_chip_info = {
+	.ops = &npcm7xx_hwmon_ops,
+	.info = npcm7xx_info,
+};
+
+static int npcm7xx_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct npcm7xx_pwm_data *data;
+	struct resource res[NPCM7XX_PWM_MAX_MODULES];
+	struct device *hwmon;
+	struct clk *clk;
+	int m, ch, res_cnt, ret;
+	u32 Prescale_val, output_freq;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	for (res_cnt = 0; res_cnt < NPCM7XX_PWM_MAX_MODULES  ; res_cnt++) {
+		ret = of_address_to_resource(dev->of_node, res_cnt,
+					     &res[res_cnt]);
+		if (ret) {
+			pr_err("PWM of_address_to_resource fail ret %d\n",
+			       ret);
+			return -EINVAL;
+		}
+
+		data->pwm_base[res_cnt] =
+			devm_ioremap_resource(dev, &(res[res_cnt]));
+		pr_debug("pwm%d base is 0x%08X, res.start 0x%08X , size 0x%08X\n",
+			 res_cnt, (u32)data->pwm_base[res_cnt],
+			 res[res_cnt].start, resource_size(&(res[res_cnt])));
+
+		if (!data->pwm_base[res_cnt]) {
+			pr_err("pwm probe failed: can't read pwm base address for resource %d.\n",
+			       res_cnt);
+			return -ENOMEM;
+		}
+
+		mutex_init(&data->npcm7xx_pwm_lock[res_cnt]);
+	}
+
+	clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(clk))
+		return -ENODEV;
+
+	data->clk_freq = clk_get_rate(clk);
+
+	/* Adjust NPCM7xx PWMs output frequency to ~25Khz */
+	output_freq = data->clk_freq / PWN_CNT_DEFAULT;
+	Prescale_val = DIV_ROUND_CLOSEST(output_freq, PWM_OUTPUT_FREQ_25KHZ);
+
+	/* If Prescale_val = 0, then the prescale output clock is stopped */
+	if (Prescale_val < MIN_PRESCALE1)
+		Prescale_val = MIN_PRESCALE1;
+	/*
+	 * Prescale_val need to decrement in one because in the PWM Prescale
+	 * register the Prescale value increment by one
+	 */
+	Prescale_val--;
+
+	/* Setting PWM Prescale Register value register to both modules */
+	Prescale_val |= (Prescale_val << NPCM7XX_PWM_PRESCALE_SHIFT_CH01);
+
+	for (m = 0; m < NPCM7XX_PWM_MAX_MODULES  ; m++) {
+		iowrite32(Prescale_val,
+			  data->pwm_base[m] + NPCM7XX_PWM_REG_PR);
+		iowrite32(NPCM7XX_PWM_PRESCALE2_DEFALUT,
+			  data->pwm_base[m] + NPCM7XX_PWM_REG_CSR);
+		iowrite32(NPCM7XX_PWM_CTRL_MODE_DEFALUT,
+			  data->pwm_base[m] + NPCM7XX_PWM_REG_CR);
+
+		for (ch = 0; ch < NPCM7XX_PWM_MAX_CHN_NUM; ch++) {
+			iowrite32(NPCM7XX_PWM_COUNTER_DEFALUT_NUM,
+				  data->pwm_base[m] + NPCM7XX_PWM_REG_CNRx(ch));
+			iowrite32(NPCM7XX_PWM_COMPARATOR_DEFALUT_NUM,
+				  data->pwm_base[m] + NPCM7XX_PWM_REG_CMRx(ch));
+		}
+
+		iowrite32(NPCM7XX_PWM_CTRL_MODE_DEFALUT |
+			  NPCM7XX_PWM_CTRL_EN_DEFALUT,
+			  data->pwm_base[m] + NPCM7XX_PWM_REG_CR);
+	}
+
+	hwmon = devm_hwmon_device_register_with_info(dev, "npcm7xx_pwm", data,
+						     &npcm7xx_chip_info, NULL);
+
+	if (IS_ERR(hwmon)) {
+		pr_err("PWM Driver failed - devm_hwmon_device_register_with_groups failed\n");
+		return PTR_ERR(hwmon);
+	}
+
+	pr_info("NPCM7XX PWM Driver probed, PWM output Freq %dHz\n",
+		output_freq / ((Prescale_val & 0xf) + 1));
+
+	return 0;
+}
+
+static const struct of_device_id of_pwm_match_table[] = {
+	{ .compatible = "nuvoton,npcm750-pwm", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_pwm_match_table);
+
+static struct platform_driver npcm7xx_pwm_driver = {
+	.probe		= npcm7xx_pwm_probe,
+	.driver		= {
+		.name	= "npcm7xx_pwm",
+		.of_match_table = of_pwm_match_table,
+	},
+};
+
+module_platform_driver(npcm7xx_pwm_driver);
+
+MODULE_DESCRIPTION("Nuvoton NPCM7XX PWM Driver");
+MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.14.1
