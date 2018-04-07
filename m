Return-Path: <ctatlor97@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523108840; cv=none;
        d=google.com; s=arc-20160816;
        b=lHc3wk21pfZKNAqWqNwWdbtV5DZ0LA0aVwkDOE6lPqNYwhc0Vp4ttQpo7V2Q+KJnt9
         20kfgk4VTLExuWMfEYK8o+5eHKsy56nWDhGvyMDfQ0DiWWoBAw4W14MYzSyWOjzcl5nK
         jr1XBYn+5eCH6RYHHvsjsEJIW7NZIFwFOSGgVSyhkXHWYAZw7dBkx3YOprHVmmiNGP9G
         dFqCgFw1wY27bVfWgpEsRdavJNlv9glZTdBnxqVkYhYTlSsShQOmG8gn43XYdHtpXok3
         Q7fpPq7R07LkoOmhIpNFf0u8s30WmtjEtx2GQvt5yi0mkzqApKjNLdWdDnyIzrbbAEBa
         HJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=80/5tlLDQ0JO8vlYLH/hPAyCmPHTnoqSyrD1WZ7pvRU=;
        b=NA83/4I1tIZ9a13N0mtKshbMfV8CpofGYZc8Y85cYIbko+CFiJw3hAG/njQgksiPaT
         kcDvFDL71N71LDmZaAdAtVGq8haYOoeBf6LImu+vfgpD3tqSYScGbZMdh1bYOVaz4sEJ
         3/CZZXVoKF/gNXaUwgjpkMYtGIVV82sFa46+/CDhqS/68h8ogiHzSGu7/HfNoeZ+D8DI
         qv+YBDNAjVVnC00ExexP1FoYauKRFC5zUAN/srExUnB5+8+2C/R++qMxkgTQQqQdoIkW
         XSRDFyVBA3jB5TNCZ2gNoeXbAoxuRXGPyLa/hhizLoIQ0NXiLDwSP71y4r0qCtN3DbuG
         WjJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VcdUyDP5;
       spf=pass (google.com: domain of ctatlor97@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ctatlor97@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VcdUyDP5;
       spf=pass (google.com: domain of ctatlor97@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ctatlor97@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+ZXdjI+SqiFPDSOD5DGAH7hvb6w5cGxaVpFobwbohOotF4GqagGPA6lydFwgGY7rJ4PhG5qA==
From: Craig Tatlor <ctatlor97@gmail.com>
To: 
Cc: ctatlor97@gmail.com,
	linux-arm-msm@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] power: supply: Add support for the Qualcomm Battery Monitoring System
Date: Sat,  7 Apr 2018 14:46:56 +0100
Message-Id: <20180407134712.23131-1-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597095374964030475?=
X-GMAIL-MSGID: =?utf-8?q?1597095374964030475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds a driver for the BMS (Battery Monitoring System)
block of the PM8941 PMIC, it uses a lookup table defined in the
device tree to generate a capacity from the BMS supplied OCV, it
then ammends the coulomb counter to that to increase the accuracy
of the estimated capacity.

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
 drivers/power/supply/Kconfig    |   9 +
 drivers/power/supply/Makefile   |   1 +
 drivers/power/supply/qcom_bms.c | 500 ++++++++++++++++++++++++++++++++
 3 files changed, 510 insertions(+)
 create mode 100644 drivers/power/supply/qcom_bms.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 428b426842f4..6c354c37bc55 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -82,6 +82,15 @@ config BATTERY_ACT8945A
 	  Say Y here to enable support for power supply provided by
 	  Active-semi ActivePath ACT8945A charger.
 
+config BATTERY_BMS
+	tristate "Qualcomm Battery Monitoring System driver"
+	depends on MFD_SPMI_PMIC || COMPILE_TEST
+	depends on OF
+	depends on REGMAP_SPMI
+	help
+	  Say Y to include support for the Battery Monitoring hardware
+	  found in some Qualcomm PM series PMICs.
+
 config BATTERY_CPCAP
 	tristate "Motorola CPCAP PMIC battery driver"
 	depends on MFD_CPCAP && IIO
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index e83aa843bcc6..04204174b047 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_BATTERY_88PM860X)	+= 88pm860x_battery.o
 obj-$(CONFIG_BATTERY_ACT8945A)	+= act8945a_charger.o
 obj-$(CONFIG_BATTERY_AXP20X)	+= axp20x_battery.o
 obj-$(CONFIG_CHARGER_AXP20X)	+= axp20x_ac_power.o
+obj-$(CONFIG_BATTERY_BMS)	+= qcom_bms.o
 obj-$(CONFIG_BATTERY_CPCAP)	+= cpcap-battery.o
 obj-$(CONFIG_BATTERY_DS2760)	+= ds2760_battery.o
 obj-$(CONFIG_BATTERY_DS2780)	+= ds2780_battery.o
diff --git a/drivers/power/supply/qcom_bms.c b/drivers/power/supply/qcom_bms.c
new file mode 100644
index 000000000000..5aa6e906d1b9
--- /dev/null
+++ b/drivers/power/supply/qcom_bms.c
@@ -0,0 +1,500 @@
+// SPDX-License-Identifier: GPL
+
+/*
+ * Qualcomm Battery Monitoring System driver
+ *
+ * Copyright (C) 2018 Craig Tatlor <ctatlor97@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/param.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/iio/consumer.h>
+
+#define REG_BMS_OCV_FOR_SOC_DATA0	0x90
+#define REG_BMS_SHDW_CC_DATA0		0xA8
+#define REG_BMS_CC_DATA_CTL		0x42
+#define REG_BMS_CC_CLEAR_CTL		0x4
+
+#define BMS_HOLD_OREG_DATA		BIT(0)
+#define BMS_CLEAR_SHDW_CC		BIT(6)
+
+#define CC_36_BIT_MASK			0xFFFFFFFFFLL
+#define SIGN_EXTEND_36_TO_64_MASK	(-1LL ^ CC_36_BIT_MASK)
+
+#define BMS_CC_READING_RESOLUTION_N	542535
+#define BMS_CC_READING_RESOLUTION_D	10000
+#define BMS_CC_READING_TICKS		56
+#define BMS_SLEEP_CLK_HZ		32764
+
+#define SECONDS_PER_HOUR		3600
+#define TEMPERATURE_COLS		5
+#define MAX_CAPACITY_ROWS		50
+
+/* lookup table for ocv -> capacity conversion */
+struct bms_ocv_lut {
+	int rows;
+	s8 temp_legend[TEMPERATURE_COLS];
+	u8 capacity_legend[MAX_CAPACITY_ROWS];
+	u16 lut[MAX_CAPACITY_ROWS][TEMPERATURE_COLS];
+};
+
+/* lookup table for battery temperature -> fcc conversion */
+struct bms_fcc_lut {
+	s8 temp_legend[TEMPERATURE_COLS];
+	u16 lut[TEMPERATURE_COLS];
+};
+
+struct bms_device_info {
+	struct device *dev;
+	struct regmap *regmap;
+	struct power_supply *bat;
+	struct power_supply_desc bat_desc;
+	struct bms_ocv_lut ocv_lut;
+	struct bms_fcc_lut fcc_lut;
+	struct iio_channel *adc;
+	spinlock_t bms_output_lock;
+	int base_addr;
+
+	int ocv_thr_irq;
+	int ocv;
+};
+
+static s64 sign_extend_s36(uint64_t raw)
+{
+	raw = raw & CC_36_BIT_MASK;
+
+	return (raw >> 35) == 0LL ?
+		raw : (SIGN_EXTEND_36_TO_64_MASK | raw);
+}
+
+static unsigned int interpolate(int y0, int x0, int y1, int x1, int x)
+{
+	if (y0 == y1 || x == x0)
+		return y0;
+	if (x1 == x0 || x == x1)
+		return y1;
+
+	return y0 + ((y1 - y0) * (x - x0) / (x1 - x0));
+}
+
+static unsigned int between(int left, int right, int val)
+{
+	if (left <= val && val >= right)
+		return 1;
+
+	return 0;
+}
+
+static unsigned int interpolate_capacity(int temp, u16 ocv,
+				struct bms_ocv_lut ocv_lut)
+{
+	unsigned int pcj_minus_one = 0, pcj = 0;
+	int i, j;
+
+	for (j = 0; j < TEMPERATURE_COLS; j++)
+		if (temp <= ocv_lut.temp_legend[j])
+			break;
+
+	if (ocv >= ocv_lut.lut[0][j])
+		return ocv_lut.capacity_legend[0];
+
+	if (ocv <= ocv_lut.lut[ocv_lut.rows - 1][j - 1])
+		return ocv_lut.capacity_legend[ocv_lut.rows - 1];
+
+	for (i = 0; i < ocv_lut.rows - 1; i++) {
+		if (pcj == 0 && between(ocv_lut.lut[i][j],
+					ocv_lut.lut[i+1][j], ocv))
+			pcj = interpolate(ocv_lut.capacity_legend[i],
+					  ocv_lut.lut[i][j],
+					  ocv_lut.capacity_legend[i + 1],
+					  ocv_lut.lut[i+1][j],
+					  ocv);
+
+		if (pcj_minus_one == 0 && between(ocv_lut.lut[i][j-1],
+						  ocv_lut.lut[i+1][j-1], ocv))
+			pcj_minus_one = interpolate(ocv_lut.capacity_legend[i],
+						    ocv_lut.lut[i][j-1],
+						    ocv_lut.capacity_legend[i + 1],
+						    ocv_lut.lut[i+1][j-1],
+						    ocv);
+
+		if (pcj && pcj_minus_one)
+			return interpolate(pcj_minus_one,
+					   ocv_lut.temp_legend[j-1],
+					   pcj,
+					   ocv_lut.temp_legend[j],
+					   temp);
+	}
+
+	if (pcj)
+		return pcj;
+
+	if (pcj_minus_one)
+		return pcj_minus_one;
+
+	return 100;
+}
+
+static unsigned long interpolate_fcc(int temp, struct bms_fcc_lut fcc_lut)
+{
+	int i, fcc_mv;
+
+	for (i = 0; i < TEMPERATURE_COLS; i++)
+		if (temp <= fcc_lut.temp_legend[i])
+			break;
+
+	fcc_mv = interpolate(fcc_lut.lut[i - 1],
+			     fcc_lut.temp_legend[i - 1],
+			     fcc_lut.lut[i],
+			     fcc_lut.temp_legend[i],
+			     temp);
+
+	return fcc_mv * 10000;
+}
+
+static int bms_lock_output_data(struct bms_device_info *di)
+{
+	int ret;
+
+	ret = regmap_update_bits(di->regmap, di->base_addr +
+				 REG_BMS_CC_DATA_CTL,
+				 BMS_HOLD_OREG_DATA, BMS_HOLD_OREG_DATA);
+	if (ret < 0) {
+		dev_err(di->dev, "failed to lock bms output: %d", ret);
+		return ret;
+	}
+
+	/*
+	 * Sleep for 100 microseconds here to make sure there has
+	 * been at least three cycles of the sleep clock so that
+	 * the registers are correctly locked.
+	 */
+	udelay(100);
+
+	return 0;
+}
+
+static int bms_unlock_output_data(struct bms_device_info *di)
+{
+	int ret;
+
+	ret = regmap_update_bits(di->regmap, di->base_addr +
+				 REG_BMS_CC_DATA_CTL,
+				 BMS_HOLD_OREG_DATA, 0);
+	if (ret < 0) {
+		dev_err(di->dev, "failed to unlock bms output: %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int bms_read_ocv(struct bms_device_info *di, int *ocv)
+{
+	unsigned long flags;
+	int ret;
+	u16 read_ocv;
+
+	spin_lock_irqsave(&di->bms_output_lock, flags);
+
+	ret = bms_lock_output_data(di);
+	if (ret < 0)
+		goto err_lock;
+
+	ret = regmap_bulk_read(di->regmap, di->base_addr +
+			       REG_BMS_OCV_FOR_SOC_DATA0, &read_ocv, 2);
+	if (ret < 0) {
+		dev_err(di->dev, "OCV read failed: %d", ret);
+		return ret;
+	}
+
+	dev_dbg(di->dev, "read OCV value of: %d", read_ocv);
+	*ocv = read_ocv;
+
+	ret = bms_unlock_output_data(di);
+
+err_lock:
+	spin_unlock_irqrestore(&di->bms_output_lock, flags);
+
+	return ret;
+}
+
+static int bms_read_cc(struct bms_device_info *di, s64 *cc_uah)
+{
+	unsigned long flags;
+	int ret;
+	s64 cc_raw_s36, cc_raw, cc_uv, cc_pvh;
+
+	spin_lock_irqsave(&di->bms_output_lock, flags);
+
+	ret = bms_lock_output_data(di);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_bulk_read(di->regmap, di->base_addr +
+			       REG_BMS_SHDW_CC_DATA0,
+			       &cc_raw_s36, 5);
+	if (ret < 0) {
+		dev_err(di->dev, "coulomb counter read failed: %d", ret);
+		return ret;
+	}
+
+	ret = bms_unlock_output_data(di);
+	if (ret < 0)
+		return ret;
+
+	spin_unlock_irqrestore(&di->bms_output_lock, flags);
+
+	cc_raw = sign_extend_s36(cc_raw_s36);
+
+	/* convert raw to uv */
+	cc_uv = div_s64(cc_raw * BMS_CC_READING_RESOLUTION_N,
+			BMS_CC_READING_RESOLUTION_D);
+
+	/* convert uv to pvh */
+	cc_pvh = div_s64(cc_uv * BMS_CC_READING_TICKS * 100000,
+			 BMS_SLEEP_CLK_HZ * SECONDS_PER_HOUR) * 10;
+
+	/* divide by impedance */
+	*cc_uah = div_s64(cc_pvh, 10000);
+
+	dev_dbg(di->dev, "read coulomb counter value of: %lld", *cc_uah);
+
+	return 0;
+}
+
+static void bms_reset_cc(struct bms_device_info *di)
+{
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&di->bms_output_lock, flags);
+
+	ret = regmap_update_bits(di->regmap, di->base_addr +
+				 REG_BMS_CC_CLEAR_CTL,
+				 BMS_CLEAR_SHDW_CC,
+				 BMS_CLEAR_SHDW_CC);
+	if (ret < 0) {
+		dev_err(di->dev, "coulomb counter reset failed: %d", ret);
+		goto err_lock;
+	}
+
+	/* wait two sleep cycles for cc to reset */
+	udelay(100);
+
+	ret = regmap_update_bits(di->regmap, di->base_addr +
+				 REG_BMS_CC_CLEAR_CTL,
+				 BMS_CLEAR_SHDW_CC, 0);
+	if (ret < 0)
+		dev_err(di->dev, "coulomb counter re-enable failed: %d", ret);
+
+err_lock:
+	spin_unlock_irqrestore(&di->bms_output_lock, flags);
+}
+
+static int bms_calculate_capacity(struct bms_device_info *di, int *capacity)
+{
+	unsigned long ocv_capacity, fcc;
+	int ret, temp, temp_degc;
+	s64 cc, capacity_nodiv;
+
+	ret = iio_read_channel_raw(di->adc, &temp);
+	if (ret < 0) {
+		dev_err(di->dev, "failed to read temperature: %d", ret);
+		return ret;
+	}
+
+	temp_degc = (temp + 500) / 1000;
+
+	ret = bms_read_cc(di, &cc);
+	if (ret < 0) {
+		dev_err(di->dev, "failed to read coulomb counter: %d", ret);
+		return ret;
+	}
+
+	ocv_capacity = interpolate_capacity(temp_degc, (di->ocv + 5) / 10,
+					    di->ocv_lut);
+	fcc = interpolate_fcc(temp_degc, di->fcc_lut);
+
+	capacity_nodiv = ((fcc * ocv_capacity) / 100 - cc) * 100;
+	*capacity = div64_ul(capacity_nodiv, fcc);
+
+	return 0;
+}
+
+
+
+/*
+ * Return power_supply property
+ */
+static int bms_get_property(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   union power_supply_propval *val)
+{
+	struct bms_device_info *di = power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CAPACITY:
+		ret = bms_calculate_capacity(di, &val->intval);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (val->intval == INT_MAX || val->intval == INT_MIN)
+		ret = -EINVAL;
+
+	return ret;
+}
+
+static enum power_supply_property bms_props[] = {
+	POWER_SUPPLY_PROP_CAPACITY,
+};
+
+static irqreturn_t bms_ocv_thr_irq_handler(int irq, void *dev_id)
+{
+	struct bms_device_info *di = dev_id;
+
+	if (bms_read_ocv(di, &di->ocv) < 0)
+		return IRQ_HANDLED;
+
+	bms_reset_cc(di);
+	return IRQ_HANDLED;
+}
+
+static int bms_probe(struct platform_device *pdev)
+{
+	struct power_supply_config psy_cfg = {};
+	struct bms_device_info *di;
+	int ret;
+
+	di = devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
+	if (!di)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, di);
+
+	di->dev = &pdev->dev;
+
+	di->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!di->regmap) {
+		dev_err(di->dev, "Unable to get regmap");
+		return -EINVAL;
+	}
+
+	di->adc = devm_iio_channel_get(&pdev->dev, "temp");
+	if (IS_ERR(di->adc))
+		return PTR_ERR(di->adc);
+
+	ret = of_property_read_u32(di->dev->of_node, "reg", &di->base_addr);
+	if (ret < 0)
+		return ret;
+
+	ret = of_property_read_u8_array(di->dev->of_node,
+						 "qcom,ocv-temp-legend",
+						 (u8 *)di->ocv_lut.temp_legend,
+						 TEMPERATURE_COLS);
+	if (ret < 0) {
+		dev_err(di->dev, "no ocv temperature legend found");
+		return ret;
+	}
+
+	di->ocv_lut.rows = of_property_read_variable_u8_array(di->dev->of_node,
+						 "qcom,ocv-capacity-legend",
+						 di->ocv_lut.capacity_legend, 0,
+						 MAX_CAPACITY_ROWS);
+	if (di->ocv_lut.rows < 0) {
+		dev_err(di->dev, "no ocv capacity legend found");
+		return ret;
+	}
+
+	ret = of_property_read_variable_u16_array(di->dev->of_node,
+						  "qcom,ocv-lut",
+						  (u16 *)di->ocv_lut.lut,
+						  TEMPERATURE_COLS,
+						  TEMPERATURE_COLS *
+						  MAX_CAPACITY_ROWS);
+	if (ret < 0) {
+		dev_err(di->dev, "no ocv lut array found");
+		return ret;
+	}
+
+	ret = of_property_read_u8_array(di->dev->of_node,
+						 "qcom,fcc-temp-legend",
+						 (u8 *)di->fcc_lut.temp_legend,
+						 TEMPERATURE_COLS);
+	if (ret < 0) {
+		dev_err(di->dev, "no fcc temperature legend found");
+		return ret;
+	}
+
+	ret = of_property_read_u16_array(di->dev->of_node,
+						  "qcom,fcc-lut",
+						  di->fcc_lut.lut,
+						  TEMPERATURE_COLS);
+	if (ret < 0) {
+		dev_err(di->dev, "no fcc lut array found");
+		return ret;
+	}
+
+	ret = bms_read_ocv(di, &di->ocv);
+	if (ret < 0) {
+		dev_err(di->dev, "failed to read initial ocv: %d", ret);
+		return ret;
+	}
+
+	di->ocv_thr_irq = platform_get_irq_byname(pdev, "ocv_thr");
+
+	ret = devm_request_irq(di->dev, di->ocv_thr_irq,
+					bms_ocv_thr_irq_handler,
+					IRQF_TRIGGER_RISING,
+					pdev->name, di);
+	if (ret < 0) {
+		dev_err(di->dev, "failed to request handler for ocv threshold IRQ");
+		return ret;
+	}
+
+	spin_lock_init(&di->bms_output_lock);
+
+	di->bat_desc.name = "bms";
+	di->bat_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	di->bat_desc.properties = bms_props;
+	di->bat_desc.num_properties = ARRAY_SIZE(bms_props);
+	di->bat_desc.get_property = bms_get_property;
+
+	psy_cfg.drv_data = di;
+	di->bat = devm_power_supply_register(di->dev, &di->bat_desc, &psy_cfg);
+	if (IS_ERR(di->bat))
+		return PTR_ERR(di->bat);
+
+	return 0;
+}
+
+static const struct of_device_id bms_of_match[] = {
+	{.compatible = "qcom,pm8941-bms", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bms_of_match);
+
+static struct platform_driver bms_driver = {
+	.probe = bms_probe,
+	.driver = {
+		.name = "qcom-bms",
+		.of_match_table = of_match_ptr(bms_of_match),
+	},
+};
+module_platform_driver(bms_driver);
+
+MODULE_AUTHOR("Craig Tatlor <ctatlor97@gmail.com>");
+MODULE_DESCRIPTION("Qualcomm BMS driver");
+MODULE_LICENSE("GPL");
-- 
2.17.0
