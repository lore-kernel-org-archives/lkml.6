Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E400C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A26820838
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="kO2HRlyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfBVCJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 21:09:40 -0500
Received: from smtpbguseast2.qq.com ([54.204.34.130]:51178 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfBVCJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 21:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1550801364;
        bh=g9/nBb3MeZC4xAYWNMZuDNW/W9yRKjsO6YSRKD5IMYw=;
        h=From:To:Subject:Date:Message-Id;
        b=kO2HRlyUY6Iqt6P25PbIOzccefcFSDX/DGJFQqRO4NLKhJRhOm3Xb+61L+cuqu33O
         BSdDtump9zOfMLoL8vlysNEDprTDZIJrhLCjr3SeH3tgS++O58ORchGF0Qxfr6G8+F
         egEnAaVxvfvvWzkky/ikB3I6y9bDkSgNK+ZwYfm4=
X-QQ-mid: esmtp7t1550801362t5m7dr2ic
Received: from PC-penghong.localdomain (unknown [124.192.213.2])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 22 Feb 2019 10:09:21 +0800 (CST)
X-QQ-SSF: B1000000000000F0FM400F00000000V
X-QQ-FEAT: /3rRwsqtIUGBy9YGN3qbuqIcrB254+lNmr2yyjJ4wJC49lo3JRxIIJhfG1nnK
        p5XgWIxmSmjOMljEnG37jQqFtKJwor2f2av6J3b+imdoYEBycQIRgGFadNYUu+pBey5TLXn
        EZysKUOFhIuLbKvEJkKIlLRTL3xHGjTxHStRzwgyLyCpFdNM5CnprebdtAFtGzfD6TYBDzC
        2T4SH7KG21Ur0Tfc9rtNoawpl/XVfoYe2x2k4I64ngYxh99arDseUDEsYZt4VNPFJXNqPh+
        WkPwJblwjHWEarOlaGqFWgWNaZt6NSF5I5RNenp55/l9XaXq4c7pEikjk=
X-QQ-GoodBg: 0
From:   Hong Peng <elicec@foxmail.com>
To:     elicec@foxmail.com, sre@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] power:supply:Add silergy sy6410 gas gauge support,
Date:   Fri, 22 Feb 2019 10:08:32 +0800
Message-Id: <20190222020832.83-1-elicec@foxmail.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign2
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the silergy sy6410 single cell Li+ battery gas
gauge ic support,which is used to calculate the battery capacity.

Signed-off-by: Hong Peng <elicec@foxmail.com>

---
 drivers/power/supply/Kconfig          |   7 +
 drivers/power/supply/Makefile         |   1 +
 drivers/power/supply/sy6410_battery.c | 554 ++++++++++++++++++++++++++
 3 files changed, 562 insertions(+)
 create mode 100644 drivers/power/supply/sy6410_battery.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index e901b9879e7e..7e37598f68c3 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -660,4 +660,11 @@ config FUEL_GAUGE_SC27XX
 	 Say Y here to enable support for fuel gauge with SC27XX
 	 PMIC chips.
 
+config SY6410_BATTERY
+	tristate "Silergy sy6410 single cell Li+ battery fuel gauge driver"
+	depends on I2C
+	help
+	 Say Y here to enable support for fuel gauge with sy6410
+	 PMIC chips,which is used to calculate the battery capacity
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index b731c2a9b695..330dbaa5319e 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -87,3 +87,4 @@ obj-$(CONFIG_AXP288_CHARGER)	+= axp288_charger.o
 obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
+obj-$(CONFIG_SY6410_BATTERY)    += sy6410_battery.o
diff --git a/drivers/power/supply/sy6410_battery.c b/drivers/power/supply/sy6410_battery.c
index 000000000000..537dd1cf3e7f
--- /dev/null
+++ b/drivers/power/supply/sy6410_battery.c
@@ -0,0 +1,554 @@
+/**
+ * I2C client/driver for the Silergy sy6410 single Cell Li+ Battery Fuel Gauge
+ *
+ * Author: elicec
+ *
+ * Date: 2017-12-12 15:15:05
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/swab.h>
+#include <linux/debugfs.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/power_supply.h>
+#include <linux/slab.h>
+#include <linux/qpnp/qpnp-adc.h>
+
+
+#define SY6410_VBAT_REG	0x02        /* The Voltage of Battery */
+#define SY6410_SOC_REG		0x04	    /* The SOC of battery */
+#define SY6410_MODE_REG	0x06	    /* mode register */
+#define SY6410_VERSION_REG	0x08	    /* production version of this IC */
+#define SY6410_CONFIG_REG	0x0c
+#define SY6410_VRESET_REG	0x18        /* the reset voltage */
+#define SY6410_STATUS_REG	0x1a
+
+#define SY6410_STATUS_MASK	0x0001
+
+#define SY6410_DELAY		1000
+
+#define SY6410_DEBUG_REG(x)    {#x, x##_REG}
+
+struct debug_reg {
+	char *name;
+	u8 reg;
+};
+
+static struct debug_reg sy6410_debug_regs[] = {
+	SY6410_DEBUG_REG(SY6410_VBAT),
+	SY6410_DEBUG_REG(SY6410_SOC),
+	SY6410_DEBUG_REG(SY6410_MODE),
+	SY6410_DEBUG_REG(SY6410_VRESET),
+	SY6410_DEBUG_REG(SY6410_CONFIG),
+	SY6410_DEBUG_REG(SY6410_VERSION),
+	SY6410_DEBUG_REG(SY6410_STATUS),
+};
+
+struct sy6410_info;
+
+struct sy6410_battery_ops {
+	int (*get_battery_status)(struct sy6410_info *info, int *status);
+	int (*get_battery_voltage)(struct sy6410_info *info, int *voltage_uV);
+	int (*get_battery_capacity)(struct sy6410_info *info, int *capacity);
+	int (*get_battery_temp)(struct sy6410_info *info, int *temp);
+};
+
+#define to_sy6410_info(x) container_of(x, struct sy6410_info, battery)
+
+struct sy6410_info {
+	struct i2c_client	*client;
+	struct power_supply	battery;
+	struct sy6410_battery_ops  *ops;
+	struct delayed_work	bat_work;
+	struct dentry *debug_root;
+	struct qpnp_vadc_chip *vadc_dev;
+	s16			version;
+	int			capacity;
+	int			status;		/* State Of Charge */
+};
+
+static struct sy6410_info *the_chip;
+
+static inline int sy6410_read_reg(struct sy6410_info *info, int reg, u8 *val)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(info->client, reg);
+	if (ret < 0) {
+		dev_err(&info->client->dev, "register read failed\n");
+		return ret;
+	}
+
+	*val = ret;
+	return 0;
+}
+
+static inline int sy6410_write_reg16(struct sy6410_info *info, int reg_msb,
+				    u16 val)
+{
+	int ret;
+
+	ret = i2c_smbus_write_word_data(info->client, reg_msb, val);
+	if (ret < 0)
+		dev_err(&info->client->dev, "register write failed\n");
+
+	return ret;
+}
+
+static inline int sy6410_read_reg16(struct sy6410_info *info, int reg_msb,
+				    s16 *val)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(info->client, reg_msb);
+	if (ret < 0) {
+		dev_err(&info->client->dev, "register read failed\n");
+		return ret;
+	}
+
+	*val = swab16(ret);
+	return 0;
+}
+
+//TODO get temp
+static int sy6410_get_temp(struct sy6410_info *info, int *temp)
+{
+	struct qpnp_vadc_result result;
+	int ret;
+	int batt_temp = 25;
+
+	if (PTR_ERR(info->vadc_dev) == -EPROBE_DEFER) {
+		pr_err("vadc not found try again\n");
+		info->vadc_dev = qpnp_get_vadc(&info->client->dev,
+									"batterytemp");
+	}
+	ret = qpnp_vadc_read(info->vadc_dev, LR_MUX1_BATT_THERM, &result);
+	if (ret)
+		pr_err("unable to read battery temp:ret=%d\n", ret);
+	else
+		batt_temp = (int)result.physical;
+
+	pr_info("read battery temp:raw=%lld\n", result.physical);
+	*temp = batt_temp;
+	*temp = 25;
+
+	return 0;
+}
+
+static int sy6410_get_voltage(struct sy6410_info *info, int *voltage_uV)
+{
+	s16 raw;
+	int err;
+
+	/*
+	 * Voltage is measured in units of 0.61mv,offset 2.5v. The voltage is
+	 * a 12-bit number plus sign, in the upper bits of a 16-bit register
+	 */
+	err = sy6410_read_reg16(info, SY6410_VBAT_REG, &raw);
+	if (err)
+		return err;
+	*voltage_uV = raw * 610 + 2500000;
+	dev_dbg(&info->client->dev, "vbat reg(%02x) = %02x\n", SY6410_VBAT_REG,
+		raw);
+
+	return 0;
+}
+
+static int sy6410_get_capacity(struct sy6410_info *info, int *capacity)
+{
+	int err;
+	u16 raw;
+
+	err = sy6410_read_reg16(info, SY6410_SOC_REG, &raw);
+	dev_dbg(&info->client->dev, "capacity reg(%02x) = %04x\n",
+		SY6410_SOC_REG, raw);
+	if (err)
+		return err;
+
+	*capacity = raw * 100/65535;
+
+	return 0;
+}
+
+#define SLEEP_REG_MASK 0x2000
+static int sy6410_sleep_enable(struct sy6410_info *info, bool enable)
+{
+	int err;
+	s16 raw;
+
+	err = sy6410_read_reg16(info, SY6410_MODE_REG, &raw);
+	if (err) {
+		dev_dbg(&info->client->dev, "sleep enable err! read reg(%02x)
+			error = %d\n", SY6410_MODE_REG, err);
+		return err;
+	}
+	/*the MSB 13bit is the sleep enable*/
+	raw &= ~SLEEP_REG_MASK;
+	raw |= (enable << 13) & SLEEP_REG_MASK;
+
+	err = sy6410_write_reg16(info, SY6410_MODE_REG, raw);
+	dev_dbg(&info->client->dev, "mode reg(%02x) = %02x\n", SY6410_MODE_REG,
+		raw);
+
+	return err;
+
+}
+
+static int sy6410_get_charge_status(struct sy6410_info *info, int *status)
+{
+	int err;
+	s16 raw;
+
+	err = sy6410_read_reg16(info, SY6410_STATUS_REG, &raw);
+	dev_dbg(&info->client->dev, "status reg(%02x) = %04x\n",
+		SY6410_STATUS_REG, raw);
+	if (err)
+		return err;
+	*status = raw & SY6410_STATUS_MASK;
+	return 0;
+}
+
+static int sy6410_get_status(struct sy6410_info *info, int *status)
+{
+	int err;
+	int state;
+	int capacity;
+
+	err = info->ops->get_battery_capacity(info, &capacity);
+	err = info->ops->get_battery_status(info, &state);
+	if (err)
+		return err;
+
+	info->capacity = capacity;
+	info->status = state;
+
+	if (capacity == 100)
+		*status = POWER_SUPPLY_STATUS_FULL;
+	else if (state == 1)
+		*status = POWER_SUPPLY_STATUS_CHARGING;
+	else if (state == 0)
+		*status = POWER_SUPPLY_STATUS_DISCHARGING;
+	else
+		*status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+
+	return 0;
+}
+
+static int sy6410_battery_get_property(struct power_supply *psy,
+				       enum power_supply_property prop,
+				       union power_supply_propval *val)
+{
+	struct sy6410_info *info = to_sy6410_info(psy);
+	int ret;
+
+	switch (prop) {
+	case POWER_SUPPLY_PROP_CAPACITY:
+		ret = info->ops->get_battery_capacity(info, &val->intval);
+		break;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = info->ops->get_battery_voltage(info, &val->intval);
+		break;
+
+	case POWER_SUPPLY_PROP_TEMP:
+		ret = info->ops->get_battery_temp(info, &val->intval);
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static void sy6410_battery_update(struct sy6410_info *info)
+{
+	/*TODO add temp*/
+	int old_status = info->status;
+	int old_capacity = info->capacity;
+
+	sy6410_get_status(info, &info->status);
+
+	if ((old_status != info->status) || (old_capacity != info->capacity))
+		power_supply_changed(&info->battery);
+}
+
+static void sy6410_battery_work(struct work_struct *work)
+{
+	struct sy6410_info *info;
+
+	info = container_of(work, struct sy6410_info, bat_work.work);
+	sy6410_battery_update(info);
+
+	schedule_delayed_work(&info->bat_work, SY6410_DELAY);
+}
+
+static int show_config_regs(struct seq_file *m, void *data)
+{
+	struct sy6410_info *info = m->private;
+	int rc;
+	int n;
+	u16 reg;
+	u8 addrs[] = {0x02, 0x04, 0x06, 0x08, 0x0c, 0x18, 0x1a};

+	for (n = 0; n < ARRAY_SIZE(addrs); n++) {
+		rc = sy6410_read_reg16(info, addrs[n], &reg);
+		seq_printf(m, "0x%02x = 0x%04x\n", addrs[n], reg);
+	}
+	return 0;
+}
+
+static int cnfg_debugfs_open(struct inode *inode, struct file *file)
+{
+	struct sy6410_info *info = inode->i_private;

+	return single_open(file, show_config_regs, info);
+}
+
+static const struct file_operations cnfg_debugfs_ops = {
+	.owner = THIS_MODULE,
+	.open = cnfg_debugfs_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int sy6410_set_reg(void *data, u64 val)
+{
+	u32 addr = (long) data;
+	int ret;
+
+	ret = sy6410_write_reg16(the_chip, addr, (u16) val);
+
+	return ret;
+}
+
+static int sy6410_get_reg(void *data, u64 *val)
+{
+	u32 addr = (long) data;
+	int ret;
+	u16 raw;
+
+	ret = sy6410_read_reg16(the_chip, addr, &raw);
+	if (ret < 0)
+		return ret;
+
+	*val = raw;
+
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(reg_fops, sy6410_get_reg, sy6410_set_reg,
+		"0x%02llx\n");
+
+static int sy6410_create_debugfs_entries(struct sy6410_info *info)
+{
+	int i;
+
+	info->debug_root = debugfs_create_dir("SY6410", NULL);
+	if (!info->debug_root)
+		dev_err(&info->client->dev, "Couldn't create debug dir\n");
+	if (info->debug_root) {
+		struct dentry *ent;
+
+		ent = debugfs_create_file("registers", 0444,
+				info->debug_root, info, &cnfg_debugfs_ops);
+		if (!ent)
+			dev_err(&info->client->dev, "Couldn't create debug file\n");
+	}
+
+	for (i = 0; i < ARRAY_SIZE(sy6410_debug_regs); i++) {
+		char *name = sy6410_debug_regs[i].name;
+		u32 reg = sy6410_debug_regs[i].reg;
+		struct dentry *file;
+
+		file = debugfs_create_file(name, 0644,
+				info->debug_root, (void *)(long)reg, &reg_fops);
+
+		if (IS_ERR(file)) {
+			pr_err("debugfs_create_file %s failed.\n", name);
+			return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
+static enum power_supply_property sy6410_battery_props[] = {
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_TEMP,
+};
+
+static void sy6410_power_supply_init(struct power_supply *battery)
+{
+	battery->name = "sy6410_battery";
+	battery->type			= POWER_SUPPLY_TYPE_BATTERY;
+	battery->properties		= sy6410_battery_props;
+	battery->num_properties		= ARRAY_SIZE(sy6410_battery_props);
+	battery->get_property		= sy6410_battery_get_property;
+	battery->external_power_changed	= NULL;
+}
+
+static int sy6410_battery_remove(struct i2c_client *client)
+{
+	struct sy6410_info *info = i2c_get_clientdata(client);
+
+	power_supply_unregister(&info->battery);
+	kfree(info->battery.name);
+
+	cancel_delayed_work(&info->bat_work);
+	the_chip = NULL;
+
+	kfree(info);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+
+static int sy6410_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct sy6410_info *info = i2c_get_clientdata(client);
+
+	cancel_delayed_work(&info->bat_work);
+	return 0;
+}
+
+static int sy6410_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct sy6410_info *info = i2c_get_clientdata(client);
+
+	schedule_delayed_work(&info->bat_work, SY6410_DELAY);
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(sy6410_battery_pm_ops, sy6410_suspend,
+		sy6410_resume);
+#define SY6410_BATTERY_PM_OPS (&sy6410_battery_pm_ops)
+
+#else
+#define SY6410_BATTERY_PM_OPS NULL
+#endif /* CONFIG_PM_SLEEP */
+
+enum sy6410_num_id {
+	SY6410 = 0,
+	SY641X,
+};
+
+static struct sy6410_battery_ops sy6410_ops[] = {
+	[SY6410] = {
+		.get_battery_status  = sy6410_get_charge_status,
+		.get_battery_voltage  = sy6410_get_voltage,
+		.get_battery_capacity = sy6410_get_capacity,
+		.get_battery_temp = sy6410_get_temp,
+	},
+	[SY641X] = {
+		.get_battery_status  = sy6410_get_charge_status,
+		.get_battery_voltage  = sy6410_get_voltage,
+		.get_battery_capacity = sy6410_get_capacity,
+		.get_battery_temp = sy6410_get_temp,
+	}
+};
+
+static int sy6410_battery_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
+{
+	struct sy6410_info *info;
+	int ret;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		ret = -ENOMEM;
+		goto fail_id;
+	}
+
+	info->client = client;
+	info->ops  = &sy6410_ops[0];
+	info->capacity = 75;
+	info->status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+	info->vadc_dev = qpnp_get_vadc(&client->dev, "batterytemp");
+	if (IS_ERR(info->vadc_dev)) {
+		ret = PTR_ERR(info->vadc_dev);
+		if (ret == -EPROBE_DEFER)
+			dev_err(&client->dev, "vadc not found rc=%d\n", ret);
+		else
+			dev_err(&client->dev, "vadc prop rc=%d\n", ret);
+	}
+	ret = sy6410_read_reg16(info, SY6410_VERSION_REG, &info->version);
+	if (ret) {
+		pr_err("unable to read sy6410 version, absent?ret=%d\n", ret);
+		return -ENODEV;
+	}
+
+	i2c_set_clientdata(client, info);
+	sy6410_power_supply_init(&info->battery);
+	INIT_DELAYED_WORK(&info->bat_work, sy6410_battery_work);
+
+	ret = power_supply_register(&client->dev, &info->battery);
+	if (ret) {
+		dev_err(&client->dev, "failed to register battery\n");
+		goto fail_register;
+	} else {
+		schedule_delayed_work(&info->bat_work, SY6410_DELAY);
+	}
+
+	sy6410_sleep_enable(info, false);
+	the_chip = info;
+
+	sy6410_create_debugfs_entries(info);
+
+	dev_info(&client->dev, "sy6410 HW version: 0x%X\n", info->version);
+
+	return 0;
+
+fail_register:
+	kfree(info->battery.name);
+fail_id:
+	return ret;
+}
+
+static const struct i2c_device_id sy6410_id[] = {
+	{"sy6410", SY6410},
+	{},
+};
+
+MODULE_DEVICE_TABLE(i2c, sy6410_id);
+
+static const struct of_device_id sy6410_match[] = {
+	{ .compatible = "silergy,sy6410-battery", },
+	{  },
+};
+
+static struct i2c_driver sy6410_battery_driver = {
+	.driver	= {
+		.name	= "sy6410-battery",
+		.pm	= SY6410_BATTERY_PM_OPS,
+		.of_match_table = of_match_ptr(sy6410_match),
+	},
+	.probe		= sy6410_battery_probe,
+	.remove		= sy6410_battery_remove,
+	.id_table	= sy6410_id,
+};
+module_i2c_driver(sy6410_battery_driver);
+
+static int __init sy6410_init(void)
+{
+	return i2c_add_driver(&sy6410_battery_driver);
+}
+module_init(sy6410_init);
+
+static void __exit sy6410_exit(void)
+{
+	return i2c_del_driver(&sy6410_battery_driver);
+}
+module_exit(sy6410_exit);
+
+MODULE_AUTHOR("elicec");
+MODULE_DESCRIPTION("Silergy SY6410 single cell Li+ Fuel Gauage IC driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

b¡C
