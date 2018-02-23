Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELuBluwKoodqbFFBmBJSUgUUl+LVt3bSVTopcaJ39pm3OUw0FELajwWHc+fJyHQBBCJvlbaU
ARC-Seal: i=1; a=rsa-sha256; t=1519403078; cv=none;
        d=google.com; s=arc-20160816;
        b=amC7+/cinTbu5anG8WNWmUsksco56mD8ub5GJivEwlN+HrTEdaZaklcYpgNgmE9o60
         iaHomu1LYiE3nJvPp8wGHqVVdIiTl2IHR4t40bPE5ZjAbXDCzVjEkLRWCM6GP5YLKP0a
         Z4iHZtE401Alf14KXrLPx0JuN3w1T7DCPJkpK5b9qt8PQ/3jl2qfGuQLNx+RyHHSANiA
         gp93fdPjX+5OKWKlLp1eWGteq365RD5dMfq6GdgbB0FW5pmU9j1ibzo1UnqLiYHKcyJF
         OuPkNuldqr2aJnpu8DvI/+xLFT3guiDNTovZljbXufWHtgjc8njOxae5WDBh/bIS55lI
         Ly8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ilGoSJT72DstUnBFF82hCPLdyeIBpj1EQ+wsVvfvAm4=;
        b=THyLBQ1OoAEVxEOQqRHklbWzr2oyMAi0GaOKBRi8GjYBlhFu2i5lBcnqMa5N3Lg3UX
         KGhZpm9PEHfPjawTsd9+EnFFHYRckb0iDYirzmSoVZpRT5nd6xybyGbA0/W+DItR0JQK
         srZsh3Qr4IO8bG/Lhq4kDN/ouYbntzw0dmvmCDurjWDBabdzDq0vrE1EM5q7lNNECrbU
         hUXR+PhJkm6OXp0M79J8cLLWcksvFGyaHXwwBD1nRLyZ4PMLKIIG74H1HvbXvZez2R1M
         GiUFqXWCIoTdZMwiOlovQBrk7A1nZu4nbFIsZ0n+H1/cHwqYqRsceIB8zawxPw72pYrH
         7pXw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
From: Sudeep Holla <sudeep.holla@arm.com>
To: ALKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v6 18/20] hwmon: add support for sensors exported via ARM SCMI
Date: Fri, 23 Feb 2018 16:23:48 +0000
Message-Id: <1519403030-21189-19-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209602295100981?=
X-GMAIL-MSGID: =?utf-8?q?1593209602295100981?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Create a driver to add support for SoC sensors exported by the System
Control Processor (SCP) via the System Control and Management Interface
(SCMI). The supported sensor types is one of voltage, temperature,
current, and power.

The sensor labels and values provided by the SCP are exported via the
hwmon sysfs interface.

Cc: linux-hwmon@vger.kernel.org
Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/hwmon/Kconfig      |  12 +++
 drivers/hwmon/Makefile     |   1 +
 drivers/hwmon/scmi-hwmon.c | 233 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 246 insertions(+)
 create mode 100644 drivers/hwmon/scmi-hwmon.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index ef23553ff5cb..033e57366d56 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -317,6 +317,18 @@ config SENSORS_APPLESMC
 	  Say Y here if you have an applicable laptop and want to experience
 	  the awesome power of applesmc.
 
+config SENSORS_ARM_SCMI
+	tristate "ARM SCMI Sensors"
+	depends on ARM_SCMI_PROTOCOL
+	depends on THERMAL || !THERMAL_OF
+	help
+	  This driver provides support for temperature, voltage, current
+	  and power sensors available on SCMI based platforms. The actual
+	  number and type of sensors exported depend on the platform.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called scmi-hwmon.
+
 config SENSORS_ARM_SCPI
 	tristate "ARM SCPI Sensors"
 	depends on ARM_SCPI_PROTOCOL
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index f814b4ace138..e7d52a36e6c4 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_SENSORS_ADT7462)	+= adt7462.o
 obj-$(CONFIG_SENSORS_ADT7470)	+= adt7470.o
 obj-$(CONFIG_SENSORS_ADT7475)	+= adt7475.o
 obj-$(CONFIG_SENSORS_APPLESMC)	+= applesmc.o
+obj-$(CONFIG_SENSORS_ARM_SCMI)	+= scmi-hwmon.o
 obj-$(CONFIG_SENSORS_ARM_SCPI)	+= scpi-hwmon.o
 obj-$(CONFIG_SENSORS_ASC7621)	+= asc7621.o
 obj-$(CONFIG_SENSORS_ASPEED)	+= aspeed-pwm-tacho.o
diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
new file mode 100644
index 000000000000..7a0ab768d4b5
--- /dev/null
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -0,0 +1,233 @@
+/*
+ * System Control and Management Interface(SCMI) based hwmon sensor driver
+ *
+ * Copyright (C) 2017 ARM Ltd.
+ * Sudeep Holla <sudeep.holla@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/hwmon.h>
+#include <linux/module.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/thermal.h>
+
+struct scmi_sensors {
+	const struct scmi_handle *handle;
+	const struct scmi_sensor_info **info[hwmon_max];
+};
+
+static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			   u32 attr, int channel, long *val)
+{
+	int ret;
+	u64 value;
+	const struct scmi_sensor_info *sensor;
+	struct scmi_sensors *scmi_sensors = dev_get_drvdata(dev);
+	const struct scmi_handle *h = scmi_sensors->handle;
+
+	sensor = *(scmi_sensors->info[type] + channel);
+	ret = h->sensor_ops->reading_get(h, sensor->id, false, &value);
+	if (!ret)
+		*val = value;
+
+	return ret;
+}
+
+static int
+scmi_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
+		       u32 attr, int channel, const char **str)
+{
+	const struct scmi_sensor_info *sensor;
+	struct scmi_sensors *scmi_sensors = dev_get_drvdata(dev);
+
+	sensor = *(scmi_sensors->info[type] + channel);
+	*str = sensor->name;
+
+	return 0;
+}
+
+static umode_t
+scmi_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_types type,
+		      u32 attr, int channel)
+{
+	const struct scmi_sensor_info *sensor;
+	const struct scmi_sensors *scmi_sensors = drvdata;
+
+	sensor = *(scmi_sensors->info[type] + channel);
+	if (sensor && sensor->name)
+		return S_IRUGO;
+
+	return 0;
+}
+
+static const struct hwmon_ops scmi_hwmon_ops = {
+	.is_visible = scmi_hwmon_is_visible,
+	.read = scmi_hwmon_read,
+	.read_string = scmi_hwmon_read_string,
+};
+
+static struct hwmon_chip_info scmi_chip_info = {
+	.ops = &scmi_hwmon_ops,
+	.info = NULL,
+};
+
+static int scmi_hwmon_add_chan_info(struct hwmon_channel_info *scmi_hwmon_chan,
+				    struct device *dev, int num,
+				    enum hwmon_sensor_types type, u32 config)
+{
+	int i;
+	u32 *cfg = devm_kcalloc(dev, num + 1, sizeof(*cfg), GFP_KERNEL);
+
+	if (!cfg)
+		return -ENOMEM;
+
+	scmi_hwmon_chan->type = type;
+	scmi_hwmon_chan->config = cfg;
+	for (i = 0; i < num; i++, cfg++)
+		*cfg = config;
+
+	return 0;
+}
+
+static enum hwmon_sensor_types scmi_types[] = {
+	[TEMPERATURE_C] = hwmon_temp,
+	[VOLTAGE] = hwmon_in,
+	[CURRENT] = hwmon_curr,
+	[POWER] = hwmon_power,
+	[ENERGY] = hwmon_energy,
+};
+
+static u32 hwmon_attributes[] = {
+	[hwmon_chip] = HWMON_C_REGISTER_TZ,
+	[hwmon_temp] = HWMON_T_INPUT | HWMON_T_LABEL,
+	[hwmon_in] = HWMON_I_INPUT | HWMON_I_LABEL,
+	[hwmon_curr] = HWMON_C_INPUT | HWMON_C_LABEL,
+	[hwmon_power] = HWMON_P_INPUT | HWMON_P_LABEL,
+	[hwmon_energy] = HWMON_E_INPUT | HWMON_E_LABEL,
+};
+
+static int scmi_hwmon_probe(struct scmi_device *sdev)
+{
+	int i, idx;
+	u16 nr_sensors;
+	enum hwmon_sensor_types type;
+	struct scmi_sensors *scmi_sensors;
+	const struct scmi_sensor_info *sensor;
+	int nr_count[hwmon_max] = {0}, nr_types = 0;
+	const struct hwmon_chip_info *chip_info;
+	struct device *hwdev, *dev = &sdev->dev;
+	struct hwmon_channel_info *scmi_hwmon_chan;
+	const struct hwmon_channel_info **ptr_scmi_ci;
+	const struct scmi_handle *handle = sdev->handle;
+
+	if (!handle || !handle->sensor_ops)
+		return -ENODEV;
+
+	nr_sensors = handle->sensor_ops->count_get(handle);
+	if (!nr_sensors)
+		return -EIO;
+
+	scmi_sensors = devm_kzalloc(dev, sizeof(*scmi_sensors), GFP_KERNEL);
+	if (!scmi_sensors)
+		return -ENOMEM;
+
+	scmi_sensors->handle = handle;
+
+	for (i = 0; i < nr_sensors; i++) {
+		sensor = handle->sensor_ops->info_get(handle, i);
+		if (!sensor)
+			return PTR_ERR(sensor);
+
+		switch (sensor->type) {
+		case TEMPERATURE_C:
+		case VOLTAGE:
+		case CURRENT:
+		case POWER:
+		case ENERGY:
+			type = scmi_types[sensor->type];
+			if (!nr_count[type])
+				nr_types++;
+			nr_count[type]++;
+			break;
+		}
+	}
+
+	if (nr_count[hwmon_temp])
+		nr_count[hwmon_chip]++, nr_types++;
+
+	scmi_hwmon_chan = devm_kcalloc(dev, nr_types, sizeof(*scmi_hwmon_chan),
+				       GFP_KERNEL);
+	if (!scmi_hwmon_chan)
+		return -ENOMEM;
+
+	ptr_scmi_ci = devm_kcalloc(dev, nr_types + 1, sizeof(*ptr_scmi_ci),
+				   GFP_KERNEL);
+	if (!ptr_scmi_ci)
+		return -ENOMEM;
+
+	scmi_chip_info.info = ptr_scmi_ci;
+	chip_info = &scmi_chip_info;
+
+	for (type = 0; type < hwmon_max && nr_count[type]; type++) {
+		scmi_hwmon_add_chan_info(scmi_hwmon_chan, dev, nr_count[type],
+					 type, hwmon_attributes[type]);
+		*ptr_scmi_ci++ = scmi_hwmon_chan++;
+
+		scmi_sensors->info[type] =
+			devm_kcalloc(dev, nr_count[type],
+				     sizeof(*scmi_sensors->info), GFP_KERNEL);
+		if (!scmi_sensors->info[type])
+			return -ENOMEM;
+	}
+
+	for (i = nr_sensors - 1; i >= 0 ; i--) {
+		sensor = handle->sensor_ops->info_get(handle, i);
+		if (!sensor)
+			continue;
+
+		switch (sensor->type) {
+		case TEMPERATURE_C:
+		case VOLTAGE:
+		case CURRENT:
+		case POWER:
+		case ENERGY:
+			type = scmi_types[sensor->type];
+			idx = --nr_count[type];
+			*(scmi_sensors->info[type] + idx) = sensor;
+			break;
+		}
+	}
+
+	hwdev = devm_hwmon_device_register_with_info(dev, "scmi_sensors",
+						     scmi_sensors, chip_info,
+						     NULL);
+
+	return PTR_ERR_OR_ZERO(hwdev);
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_SENSOR },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_hwmon_drv = {
+	.name		= "scmi-hwmon",
+	.probe		= scmi_hwmon_probe,
+	.id_table	= scmi_id_table,
+};
+module_scmi_driver(scmi_hwmon_drv);
+
+MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
+MODULE_DESCRIPTION("ARM SCMI HWMON interface driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
