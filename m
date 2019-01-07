Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD3EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3232147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfAGVmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:42:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:19777 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfAGVl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:41:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 13:41:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,451,1539673200"; 
   d="scan'208";a="124046686"
Received: from maru.jf.intel.com ([10.54.51.77])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jan 2019 13:41:55 -0800
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
        Stef van Os <stef.van.os@prodrive-technologies.com>,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Subject: [PATCH v10 11/12] hwmon: Add PECI dimmtemp driver
Date:   Mon,  7 Jan 2019 13:41:35 -0800
Message-Id: <20190107214136.5256-12-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107214136.5256-1-jae.hyun.yoo@linux.intel.com>
References: <20190107214136.5256-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds PECI dimmtemp hwmon driver.

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
 drivers/hwmon/Kconfig         |  14 ++
 drivers/hwmon/Makefile        |   1 +
 drivers/hwmon/peci-dimmtemp.c | 284 ++++++++++++++++++++++++++++++++++
 3 files changed, 299 insertions(+)
 create mode 100644 drivers/hwmon/peci-dimmtemp.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index c2eaadcf6525..996e80590b5b 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1324,6 +1324,20 @@ config SENSORS_PECI_CPUTEMP
 	  This driver can also be built as a module.  If so, the module
 	  will be called peci-cputemp.
 
+config SENSORS_PECI_DIMMTEMP
+	tristate "PECI DIMM temperature monitoring support"
+	depends on PECI
+	select MFD_INTEL_PECI_CLIENT
+	help
+	  If you say yes here you get support for the generic Intel PECI hwmon
+	  driver which provides Digital Thermal Sensor (DTS) thermal readings of
+	  DIMM components that are accessible using the PECI Client Command
+	  Suite via the processor PECI client.
+	  Check Documentation/hwmon/peci-dimmtemp for details.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called peci-dimmtemp.
+
 source "drivers/hwmon/pmbus/Kconfig"
 
 config SENSORS_PWM_FAN
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index f37117fb9af3..c2c8bb55a67a 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -142,6 +142,7 @@ obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_PECI_CPUTEMP)	+= peci-cputemp.o
+obj-$(CONFIG_SENSORS_PECI_DIMMTEMP)	+= peci-dimmtemp.o
 obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
 obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
 obj-$(CONFIG_SENSORS_RASPBERRYPI_HWMON)	+= raspberrypi-hwmon.o
diff --git a/drivers/hwmon/peci-dimmtemp.c b/drivers/hwmon/peci-dimmtemp.c
new file mode 100644
index 000000000000..6e90d9bfeb45
--- /dev/null
+++ b/drivers/hwmon/peci-dimmtemp.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018-2019 Intel Corporation
+
+#include <linux/hwmon.h>
+#include <linux/jiffies.h>
+#include <linux/mfd/intel-peci-client.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/workqueue.h>
+#include "peci-hwmon.h"
+
+#define DIMM_MASK_CHECK_DELAY_JIFFIES  msecs_to_jiffies(5000)
+#define DIMM_MASK_CHECK_RETRY_MAX      60 /* 60 x 5 secs = 5 minutes */
+
+struct peci_dimmtemp {
+	struct peci_client_manager *mgr;
+	struct device *dev;
+	char name[PECI_NAME_SIZE];
+	const struct cpu_gen_info *gen_info;
+	struct workqueue_struct *work_queue;
+	struct delayed_work work_handler;
+	struct temp_data temp[DIMM_NUMS_MAX];
+	u32 dimm_mask;
+	int retry_count;
+	u32 temp_config[DIMM_NUMS_MAX + 1];
+	struct hwmon_channel_info temp_info;
+	const struct hwmon_channel_info *info[2];
+	struct hwmon_chip_info chip;
+};
+
+static const char *dimmtemp_label[CHAN_RANK_MAX][DIMM_IDX_MAX] = {
+	{ "DIMM A1", "DIMM A2", "DIMM A3" },
+	{ "DIMM B1", "DIMM B2", "DIMM B3" },
+	{ "DIMM C1", "DIMM C2", "DIMM C3" },
+	{ "DIMM D1", "DIMM D2", "DIMM D3" },
+	{ "DIMM E1", "DIMM E2", "DIMM E3" },
+	{ "DIMM F1", "DIMM F2", "DIMM F3" },
+	{ "DIMM G1", "DIMM G2", "DIMM G3" },
+	{ "DIMM H1", "DIMM H2", "DIMM H3" },
+};
+
+static int get_dimm_temp(struct peci_dimmtemp *priv, int dimm_no)
+{
+	int dimm_order = dimm_no % priv->gen_info->dimm_idx_max;
+	int chan_rank = dimm_no / priv->gen_info->dimm_idx_max;
+	u8  cfg_data[4];
+	int rc;
+
+	if (!peci_temp_need_update(&priv->temp[dimm_no]))
+		return 0;
+
+	rc = peci_client_read_package_config(priv->mgr,
+					     MBX_INDEX_DDR_DIMM_TEMP,
+					     chan_rank, cfg_data);
+	if (rc)
+		return rc;
+
+	priv->temp[dimm_no].value = cfg_data[dimm_order] * 1000;
+
+	peci_temp_mark_updated(&priv->temp[dimm_no]);
+
+	return 0;
+}
+
+static int dimmtemp_read_string(struct device *dev,
+				enum hwmon_sensor_types type,
+				u32 attr, int channel, const char **str)
+{
+	struct peci_dimmtemp *priv = dev_get_drvdata(dev);
+	u32 dimm_idx_max = priv->gen_info->dimm_idx_max;
+	int chan_rank, dimm_idx;
+
+	if (attr != hwmon_temp_label)
+		return -EOPNOTSUPP;
+
+	chan_rank = channel / dimm_idx_max;
+	dimm_idx = channel % dimm_idx_max;
+	*str = dimmtemp_label[chan_rank][dimm_idx];
+	return 0;
+}
+
+static int dimmtemp_read(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long *val)
+{
+	struct peci_dimmtemp *priv = dev_get_drvdata(dev);
+	int rc;
+
+	if (attr != hwmon_temp_input)
+		return -EOPNOTSUPP;
+
+	rc = get_dimm_temp(priv, channel);
+	if (rc)
+		return rc;
+
+	*val = priv->temp[channel].value;
+	return 0;
+}
+
+static umode_t dimmtemp_is_visible(const void *data,
+				   enum hwmon_sensor_types type,
+				   u32 attr, int channel)
+{
+	const struct peci_dimmtemp *priv = data;
+
+	if (priv->temp_config[channel] & BIT(attr) &&
+	    priv->dimm_mask & BIT(channel))
+		return 0444;
+
+	return 0;
+}
+
+static const struct hwmon_ops dimmtemp_ops = {
+	.is_visible = dimmtemp_is_visible,
+	.read_string = dimmtemp_read_string,
+	.read = dimmtemp_read,
+};
+
+static int check_populated_dimms(struct peci_dimmtemp *priv)
+{
+	u32 chan_rank_max = priv->gen_info->chan_rank_max;
+	u32 dimm_idx_max = priv->gen_info->dimm_idx_max;
+	int chan_rank, dimm_idx, rc;
+	u8  cfg_data[4];
+
+	for (chan_rank = 0; chan_rank < chan_rank_max; chan_rank++) {
+		rc = peci_client_read_package_config(priv->mgr,
+						     MBX_INDEX_DDR_DIMM_TEMP,
+						     chan_rank, cfg_data);
+		if (rc) {
+			priv->dimm_mask = 0;
+			return rc;
+		}
+
+		for (dimm_idx = 0; dimm_idx < dimm_idx_max; dimm_idx++)
+			if (cfg_data[dimm_idx])
+				priv->dimm_mask |= BIT(chan_rank *
+						       dimm_idx_max +
+						       dimm_idx);
+	}
+
+	if (!priv->dimm_mask)
+		return -EAGAIN;
+
+	dev_dbg(priv->dev, "Scanned populated DIMMs: 0x%x\n", priv->dimm_mask);
+	return 0;
+}
+
+static int create_dimm_temp_info(struct peci_dimmtemp *priv)
+{
+	int rc, i, config_idx, channels;
+	struct device *hwmon_dev;
+
+	rc = check_populated_dimms(priv);
+	if (rc) {
+		if (rc == -EAGAIN) {
+			if (priv->retry_count < DIMM_MASK_CHECK_RETRY_MAX) {
+				queue_delayed_work(priv->work_queue,
+						   &priv->work_handler,
+						 DIMM_MASK_CHECK_DELAY_JIFFIES);
+				priv->retry_count++;
+				dev_dbg(priv->dev,
+					"Deferred DIMM temp info creation\n");
+			} else {
+				dev_err(priv->dev,
+					"Timeout DIMM temp info creation\n");
+				rc = -ETIMEDOUT;
+			}
+		}
+
+		return rc;
+	}
+
+	channels = priv->gen_info->chan_rank_max *
+		   priv->gen_info->dimm_idx_max;
+	for (i = 0, config_idx = 0; i < channels; i++)
+		if (priv->dimm_mask & BIT(i))
+			while (i >= config_idx)
+				priv->temp_config[config_idx++] =
+					HWMON_T_LABEL | HWMON_T_INPUT;
+
+	priv->chip.ops = &dimmtemp_ops;
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
+	rc = PTR_ERR_OR_ZERO(hwmon_dev);
+	if (!rc)
+		dev_dbg(priv->dev, "%s: sensor '%s'\n",
+			dev_name(hwmon_dev), priv->name);
+
+	return rc;
+}
+
+static void create_dimm_temp_info_delayed(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct peci_dimmtemp *priv = container_of(dwork, struct peci_dimmtemp,
+						  work_handler);
+	int rc;
+
+	rc = create_dimm_temp_info(priv);
+	if (rc && rc != -EAGAIN)
+		dev_dbg(priv->dev, "Failed to create DIMM temp info\n");
+}
+
+static int peci_dimmtemp_probe(struct platform_device *pdev)
+{
+	struct peci_client_manager *mgr = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct peci_dimmtemp *priv;
+	int rc;
+
+	if ((mgr->client->adapter->cmd_mask &
+	    (BIT(PECI_CMD_GET_TEMP) | BIT(PECI_CMD_RD_PKG_CFG))) !=
+	    (BIT(PECI_CMD_GET_TEMP) | BIT(PECI_CMD_RD_PKG_CFG)))
+		return -ENODEV;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, priv);
+	priv->mgr = mgr;
+	priv->dev = dev;
+	priv->gen_info = mgr->gen_info;
+
+	snprintf(priv->name, PECI_NAME_SIZE, "peci_dimmtemp.cpu%d",
+		 priv->mgr->client->addr - PECI_BASE_ADDR);
+
+	priv->work_queue = alloc_ordered_workqueue(priv->name, 0);
+	if (!priv->work_queue)
+		return -ENOMEM;
+
+	INIT_DELAYED_WORK(&priv->work_handler, create_dimm_temp_info_delayed);
+
+	rc = create_dimm_temp_info(priv);
+	if (rc && rc != -EAGAIN) {
+		dev_err(dev, "Failed to create DIMM temp info\n");
+		goto err_free_wq;
+	}
+
+	return 0;
+
+err_free_wq:
+	destroy_workqueue(priv->work_queue);
+	return rc;
+}
+
+static int peci_dimmtemp_remove(struct platform_device *pdev)
+{
+	struct peci_dimmtemp *priv = dev_get_drvdata(&pdev->dev);
+
+	cancel_delayed_work_sync(&priv->work_handler);
+	destroy_workqueue(priv->work_queue);
+
+	return 0;
+}
+
+static const struct platform_device_id peci_dimmtemp_ids[] = {
+	{ .name = "peci-dimmtemp", .driver_data = 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, peci_dimmtemp_ids);
+
+static struct platform_driver peci_dimmtemp_driver = {
+	.probe    = peci_dimmtemp_probe,
+	.remove   = peci_dimmtemp_remove,
+	.id_table = peci_dimmtemp_ids,
+	.driver   = { .name = "peci-dimmtemp", },
+};
+module_platform_driver(peci_dimmtemp_driver);
+
+MODULE_AUTHOR("Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>");
+MODULE_DESCRIPTION("PECI dimmtemp driver");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

