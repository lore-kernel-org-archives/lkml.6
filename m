Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85D7C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F23214FF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F23214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeJPBoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:44:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:61673 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbeJPBog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:44:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 10:58:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,385,1534834800"; 
   d="scan'208";a="78200139"
Received: from maru.jf.intel.com ([10.54.51.77])
  by fmsmga007.fm.intel.com with ESMTP; 15 Oct 2018 10:58:09 -0700
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Wu Hao <hao.wu@intel.com>,
        Tomohiro Kusumi <kusumi.tomohiro@gmail.com>,
        "Bryant G . Ly" <bryantly@linux.vnet.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        David Kershner <david.kershner@unisys.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Johan Hovold <johan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Stef van Os <stef.van.os@prodrive-technologies.com>
Subject: [RESEND PATCH v8 10/12] hwmon: Add PECI cputemp driver
Date:   Mon, 15 Oct 2018 10:57:10 -0700
Message-Id: <20181015175712.1500-11-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181015175712.1500-1-jae.hyun.yoo@linux.intel.com>
References: <20181015175712.1500-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds PECI cputemp hwmon driver.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jason M Biils <jason.m.bills@linux.intel.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Stef van Os <stef.van.os@prodrive-technologies.com>
Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
Reviewed-by: James Feist <james.feist@linux.intel.com>
Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/Kconfig        |  14 ++
 drivers/hwmon/Makefile       |   1 +
 drivers/hwmon/peci-cputemp.c | 392 +++++++++++++++++++++++++++++++++++
 3 files changed, 407 insertions(+)
 create mode 100644 drivers/hwmon/peci-cputemp.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 81da17a42dc9..f08b4a670ac5 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1306,6 +1306,20 @@ config SENSORS_PCF8591
 	  These devices are hard to detect and rarely found on mainstream
 	  hardware.  If unsure, say N.
 
+config SENSORS_PECI_CPUTEMP
+	tristate "PECI CPU temperature monitoring support"
+	depends on PECI
+	select MFD_INTEL_PECI_CLIENT
+	help
+	  If you say yes here you get support for the generic Intel PECI
+	  cputemp driver which provides Digital Thermal Sensor (DTS) thermal
+	  readings of the CPU package and CPU cores that are accessible using
+	  the PECI Client Command Suite via the processor PECI client.
+	  Check Documentation/hwmon/peci-cputemp for details.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called peci-cputemp.
+
 source drivers/hwmon/pmbus/Kconfig
 
 config SENSORS_PWM_FAN
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 93f7f41ea4ad..13ebde089ad5 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -141,6 +141,7 @@ obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+= ntc_thermistor.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
+obj-$(CONFIG_SENSORS_PECI_CPUTEMP)	+= peci-cputemp.o
 obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
 obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
 obj-$(CONFIG_SENSORS_RASPBERRYPI_HWMON)	+= raspberrypi-hwmon.o
diff --git a/drivers/hwmon/peci-cputemp.c b/drivers/hwmon/peci-cputemp.c
new file mode 100644
index 000000000000..20a48200c786
--- /dev/null
+++ b/drivers/hwmon/peci-cputemp.c
@@ -0,0 +1,392 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 Intel Corporation
+
+#include <linux/hwmon.h>
+#include <linux/jiffies.h>
+#include <linux/mfd/intel-peci-client.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#define DEFAULT_CHANNEL_NUMS   4
+#define CORETEMP_CHANNEL_NUMS  CORE_NUMS_MAX
+#define CPUTEMP_CHANNEL_NUMS   (DEFAULT_CHANNEL_NUMS + CORETEMP_CHANNEL_NUMS)
+
+/* The RESOLVED_CORES register in PCU of a client CPU */
+#define REG_RESOLVED_CORES_BUS      1
+#define REG_RESOLVED_CORES_DEVICE   30
+#define REG_RESOLVED_CORES_FUNCTION 3
+#define REG_RESOLVED_CORES_OFFSET   0xB4
+
+struct temp_group {
+	struct temp_data die;
+	struct temp_data tcontrol;
+	struct temp_data tthrottle;
+	struct temp_data tjmax;
+	struct temp_data core[CORETEMP_CHANNEL_NUMS];
+};
+
+struct peci_cputemp {
+	struct peci_mfd *mfd;
+	struct device *dev;
+	char name[PECI_NAME_SIZE];
+	u8 addr;
+	const struct cpu_gen_info *gen_info;
+	struct temp_group temp;
+	u32 core_mask;
+	u32 temp_config[CPUTEMP_CHANNEL_NUMS + 1];
+	uint config_idx;
+	struct hwmon_channel_info temp_info;
+	const struct hwmon_channel_info *info[2];
+	struct hwmon_chip_info chip;
+};
+
+enum cputemp_channels {
+	channel_die,
+	channel_tcontrol,
+	channel_tthrottle,
+	channel_tjmax,
+	channel_core,
+};
+
+static const u32 config_table[DEFAULT_CHANNEL_NUMS + 1] = {
+	/* Die temperature */
+	HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+	HWMON_T_CRIT_HYST,
+
+	/* Tcontrol temperature */
+	HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_CRIT,
+
+	/* Tthrottle temperature */
+	HWMON_T_LABEL | HWMON_T_INPUT,
+
+	/* Tjmax temperature */
+	HWMON_T_LABEL | HWMON_T_INPUT,
+
+	/* Core temperature - for all core channels */
+	HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+	HWMON_T_CRIT_HYST,
+};
+
+static const char *cputemp_label[CPUTEMP_CHANNEL_NUMS] = {
+	"Die",
+	"Tcontrol",
+	"Tthrottle",
+	"Tjmax",
+	"Core 0", "Core 1", "Core 2", "Core 3",
+	"Core 4", "Core 5", "Core 6", "Core 7",
+	"Core 8", "Core 9", "Core 10", "Core 11",
+	"Core 12", "Core 13", "Core 14", "Core 15",
+	"Core 16", "Core 17", "Core 18", "Core 19",
+	"Core 20", "Core 21", "Core 22", "Core 23",
+};
+
+static s32 ten_dot_six_to_millidegree(s32 val)
+{
+	return ((val ^ 0x8000) - 0x8000) * 1000 / 64;
+}
+
+static int get_temp_targets(struct peci_cputemp *priv)
+{
+	s32 tthrottle_offset;
+	s32 tcontrol_margin;
+	u8  pkg_cfg[4];
+	int rc;
+
+	/**
+	 * Just use only the tcontrol marker to determine if target values need
+	 * update.
+	 */
+	if (!peci_temp_need_update(&priv->temp.tcontrol))
+		return 0;
+
+	rc = peci_client_rd_pkg_cfg_cmd(priv->mfd, MBX_INDEX_TEMP_TARGET,
+					0, pkg_cfg);
+	if (rc)
+		return rc;
+
+	priv->temp.tjmax.value = pkg_cfg[2] * 1000;
+
+	tcontrol_margin = pkg_cfg[1];
+	tcontrol_margin = ((tcontrol_margin ^ 0x80) - 0x80) * 1000;
+	priv->temp.tcontrol.value = priv->temp.tjmax.value - tcontrol_margin;
+
+	tthrottle_offset = (pkg_cfg[3] & 0x2f) * 1000;
+	priv->temp.tthrottle.value = priv->temp.tjmax.value - tthrottle_offset;
+
+	peci_temp_mark_updated(&priv->temp.tcontrol);
+
+	return 0;
+}
+
+static int get_die_temp(struct peci_cputemp *priv)
+{
+	struct peci_get_temp_msg msg;
+	int rc;
+
+	if (!peci_temp_need_update(&priv->temp.die))
+		return 0;
+
+	msg.addr = priv->addr;
+
+	rc = peci_client_command(priv->mfd, PECI_CMD_GET_TEMP, &msg);
+	if (rc)
+		return rc;
+
+	/* Note that the tjmax should be available before calling it */
+	priv->temp.die.value = priv->temp.tjmax.value +
+			       (msg.temp_raw * 1000 / 64);
+
+	peci_temp_mark_updated(&priv->temp.die);
+
+	return 0;
+}
+
+static int get_core_temp(struct peci_cputemp *priv, int core_index)
+{
+	s32 core_dts_margin;
+	u8  pkg_cfg[4];
+	int rc;
+
+	if (!peci_temp_need_update(&priv->temp.core[core_index]))
+		return 0;
+
+	rc = peci_client_rd_pkg_cfg_cmd(priv->mfd, MBX_INDEX_PER_CORE_DTS_TEMP,
+					core_index, pkg_cfg);
+	if (rc)
+		return rc;
+
+	core_dts_margin = le16_to_cpup((__le16 *)pkg_cfg);
+
+	/**
+	 * Processors return a value of the core DTS reading in 10.6 format
+	 * (10 bits signed decimal, 6 bits fractional).
+	 * Error codes:
+	 *   0x8000: General sensor error
+	 *   0x8001: Reserved
+	 *   0x8002: Underflow on reading value
+	 *   0x8003-0x81ff: Reserved
+	 */
+	if (core_dts_margin >= 0x8000 && core_dts_margin <= 0x81ff)
+		return -EIO;
+
+	core_dts_margin = ten_dot_six_to_millidegree(core_dts_margin);
+
+	/* Note that the tjmax should be available before calling it */
+	priv->temp.core[core_index].value = priv->temp.tjmax.value +
+					    core_dts_margin;
+
+	peci_temp_mark_updated(&priv->temp.core[core_index]);
+
+	return 0;
+}
+
+static int cputemp_read_string(struct device *dev,
+			       enum hwmon_sensor_types type,
+			       u32 attr, int channel, const char **str)
+{
+	if (attr != hwmon_temp_label)
+		return -EOPNOTSUPP;
+
+	*str = cputemp_label[channel];
+	return 0;
+}
+
+static int cputemp_read(struct device *dev,
+			enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	struct peci_cputemp *priv = dev_get_drvdata(dev);
+	int rc, core_index;
+
+	if (channel >= CPUTEMP_CHANNEL_NUMS ||
+	    !(priv->temp_config[channel] & BIT(attr)))
+		return -EOPNOTSUPP;
+
+	rc = get_temp_targets(priv);
+	if (rc)
+		return rc;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		switch (channel) {
+		case channel_die:
+			rc = get_die_temp(priv);
+			if (rc)
+				break;
+
+			*val = priv->temp.die.value;
+			break;
+		case channel_tcontrol:
+			*val = priv->temp.tcontrol.value;
+			break;
+		case channel_tthrottle:
+			*val = priv->temp.tthrottle.value;
+			break;
+		case channel_tjmax:
+			*val = priv->temp.tjmax.value;
+			break;
+		default:
+			core_index = channel - DEFAULT_CHANNEL_NUMS;
+			rc = get_core_temp(priv, core_index);
+			if (rc)
+				break;
+
+			*val = priv->temp.core[core_index].value;
+			break;
+		}
+		break;
+	case hwmon_temp_max:
+		*val = priv->temp.tcontrol.value;
+		break;
+	case hwmon_temp_crit:
+		*val = priv->temp.tjmax.value;
+		break;
+	case hwmon_temp_crit_hyst:
+		*val = priv->temp.tjmax.value - priv->temp.tcontrol.value;
+		break;
+	default:
+		rc = -EOPNOTSUPP;
+		break;
+	}
+
+	return rc;
+}
+
+static umode_t cputemp_is_visible(const void *data,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	const struct peci_cputemp *priv = data;
+
+	if (priv->temp_config[channel] & BIT(attr))
+		if (channel < DEFAULT_CHANNEL_NUMS ||
+		    (channel >= DEFAULT_CHANNEL_NUMS &&
+		     (priv->core_mask & BIT(channel - DEFAULT_CHANNEL_NUMS))))
+			return 0444;
+
+	return 0;
+}
+
+static const struct hwmon_ops cputemp_ops = {
+	.is_visible = cputemp_is_visible,
+	.read_string = cputemp_read_string,
+	.read = cputemp_read,
+};
+
+static int check_resolved_cores(struct peci_cputemp *priv)
+{
+	struct peci_rd_pci_cfg_local_msg msg;
+	int rc;
+
+	/* Get the RESOLVED_CORES register value */
+	msg.addr = priv->addr;
+	msg.bus = REG_RESOLVED_CORES_BUS;
+	msg.device = REG_RESOLVED_CORES_DEVICE;
+	msg.function = REG_RESOLVED_CORES_FUNCTION;
+	msg.reg = REG_RESOLVED_CORES_OFFSET;
+	msg.rx_len = 4;
+
+	rc = peci_client_command(priv->mfd, PECI_CMD_RD_PCI_CFG_LOCAL, &msg);
+	if (rc)
+		return rc;
+
+	priv->core_mask = le32_to_cpup((__le32 *)msg.pci_config);
+	if (!priv->core_mask)
+		return -EAGAIN;
+
+	dev_dbg(priv->dev, "Scanned resolved cores: 0x%x\n", priv->core_mask);
+	return 0;
+}
+
+static int create_core_temp_info(struct peci_cputemp *priv)
+{
+	int rc, i;
+
+	rc = check_resolved_cores(priv);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < priv->gen_info->core_max; i++)
+		if (priv->core_mask & BIT(i))
+			while (i + DEFAULT_CHANNEL_NUMS >= priv->config_idx)
+				priv->temp_config[priv->config_idx++] =
+					config_table[channel_core];
+
+	return 0;
+}
+
+static int peci_cputemp_probe(struct platform_device *pdev)
+{
+	struct peci_mfd *mfd = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct peci_cputemp *priv;
+	struct device *hwmon_dev;
+	int rc;
+
+	if ((mfd->adapter->cmd_mask &
+	    (BIT(PECI_CMD_GET_TEMP) | BIT(PECI_CMD_RD_PKG_CFG))) !=
+	    (BIT(PECI_CMD_GET_TEMP) | BIT(PECI_CMD_RD_PKG_CFG)))
+		return -ENODEV;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, priv);
+	priv->mfd = mfd;
+	priv->dev = dev;
+	priv->addr = mfd->addr;
+	priv->gen_info = mfd->gen_info;
+
+	snprintf(priv->name, PECI_NAME_SIZE, "peci_cputemp.cpu%d", mfd->cpu_no);
+
+	priv->temp_config[priv->config_idx++] = config_table[channel_die];
+	priv->temp_config[priv->config_idx++] = config_table[channel_tcontrol];
+	priv->temp_config[priv->config_idx++] = config_table[channel_tthrottle];
+	priv->temp_config[priv->config_idx++] = config_table[channel_tjmax];
+
+	rc = create_core_temp_info(priv);
+	if (rc)
+		dev_dbg(dev, "Skipped creating core temp info\n");
+
+	priv->chip.ops = &cputemp_ops;
+	priv->chip.info = priv->info;
+
+	priv->info[0] = &priv->temp_info;
+
+	priv->temp_info.type = hwmon_temp;
+	priv->temp_info.config = priv->temp_config;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(priv->dev,
+							 priv->name,
+							 priv,
+							 &priv->chip,
+							 NULL);
+
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
+
+	dev_dbg(dev, "%s: sensor '%s'\n", dev_name(hwmon_dev), priv->name);
+
+	return 0;
+}
+
+static const struct platform_device_id peci_cputemp_ids[] = {
+	{ .name = "peci-cputemp", .driver_data = 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, peci_cputemp_ids);
+
+static struct platform_driver peci_cputemp_driver = {
+	.probe    = peci_cputemp_probe,
+	.id_table = peci_cputemp_ids,
+	.driver   = {
+			.name           = "peci-cputemp",
+	},
+};
+module_platform_driver(peci_cputemp_driver);
+
+MODULE_AUTHOR("Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>");
+MODULE_DESCRIPTION("PECI cputemp driver");
+MODULE_LICENSE("GPL v2");
-- 
2.19.1

