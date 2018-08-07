Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E13C46472
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A089F21888
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A089F21888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732539AbeHGKTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 06:19:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730869AbeHGKTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 06:19:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9A4440241C4;
        Tue,  7 Aug 2018 08:05:51 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-103.ams2.redhat.com [10.36.117.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 059A62166BA2;
        Tue,  7 Aug 2018 08:05:49 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        John Garry <john.garry@huawei.com>, linux-i2c@vger.kernel.org
Subject: [PATCH v3 4/4] i2c: Add multi-instantiate pseudo driver
Date:   Tue,  7 Aug 2018 10:05:39 +0200
Message-Id: <20180807080539.17811-5-hdegoede@redhat.com>
In-Reply-To: <20180807080539.17811-1-hdegoede@redhat.com>
References: <20180807080539.17811-1-hdegoede@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 07 Aug 2018 08:05:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 07 Aug 2018 08:05:51 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'hdegoede@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems with ACPI instantiated i2c-clients, normally there is 1 fw_node
per i2c-device and that fw-node contains 1 I2cSerialBus resource for that 1
i2c-device.

But in some rare cases the manufacturer has decided to describe multiple
i2c-devices in a single ACPI fwnode with multiple I2cSerialBus resources.

An earlier attempt to fix this in the i2c-core resulted in a lot of extra
code to support this corner-case.

This commit introduces a new i2c-multi-instantiate driver which fixes this
in a different way. This new driver can be built as a module which will
only loaded on affected systems.

This driver will instantiate a new i2c-client per I2cSerialBus resource,
using the driver_data from the acpi_device_id it is binding to to tell it
which chip-type (and optional irq-resource) to use when instantiating.

Note this driver depends on a platform device being instantiated for the
ACPI fwnode, see the i2c_multi_instantiate_ids list of ACPI device-ids in
drivers/acpi/scan.c: acpi_device_enumeration_by_parent().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 MAINTAINERS                                  |   6 +
 drivers/platform/x86/Kconfig                 |  11 ++
 drivers/platform/x86/Makefile                |   1 +
 drivers/platform/x86/i2c-multi-instantiate.c | 131 +++++++++++++++++++
 4 files changed, 149 insertions(+)
 create mode 100644 drivers/platform/x86/i2c-multi-instantiate.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9b377508f24f..09e16d76cab7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6657,6 +6657,12 @@ F:	drivers/i2c/i2c-mux.c
 F:	drivers/i2c/muxes/
 F:	include/linux/i2c-mux.h
 
+I2C MULTI INSTANTIATE DRIVER
+M:	Hans de Goede <hdegoede@redhat.com>
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	drivers/drivers/platform/x86/i2c-multi-instantiate.c
+
 I2C MV64XXX MARVELL AND ALLWINNER DRIVER
 M:	Gregory CLEMENT <gregory.clement@bootlin.com>
 L:	linux-i2c@vger.kernel.org
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 85a93453237c..8256629f58f7 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1219,6 +1219,17 @@ config INTEL_CHTDC_TI_PWRBTN
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel_chtdc_ti_pwrbtn.
 
+config I2C_MULTI_INSTANTIATE
+	tristate "I2C multi instantiate pseudo device driver"
+	depends on I2C && ACPI
+	help
+	  Some ACPI bases systems list multiple i2c-devices in a single ACPI
+	  firmware-node. This driver will instantiate separate i2c-clients
+	  for each device in the firmware-node.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called i2c-multi-instantiate.
+
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 8d9477114fb5..e6d1becf81ce 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -91,3 +91,4 @@ obj-$(CONFIG_PMC_ATOM)		+= pmc_atom.o
 obj-$(CONFIG_MLX_PLATFORM)	+= mlx-platform.o
 obj-$(CONFIG_INTEL_TURBO_MAX_3) += intel_turbo_max_3.o
 obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
+obj-$(CONFIG_I2C_MULTI_INSTANTIATE)	+= i2c-multi-instantiate.o
diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
new file mode 100644
index 000000000000..4db4b8cabfc9
--- /dev/null
+++ b/drivers/platform/x86/i2c-multi-instantiate.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * I2C multi-instantiate driver, pseudo driver to instantiate multiple
+ * i2c-clients from a single fwnode.
+ *
+ * Copyright 2018 Hans de Goede <hdegoede@redhat.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+struct i2c_inst_data {
+	const char *type;
+	int irq_idx;
+};
+
+struct i2c_multi_inst_data {
+	int no_clients;
+	struct i2c_client *clients[0];
+};
+
+static int i2c_multi_inst_probe(struct platform_device *pdev)
+{
+	struct i2c_multi_inst_data *multi;
+	const struct acpi_device_id *match;
+	const struct i2c_inst_data *inst_data;
+	struct i2c_board_info board_info = {};
+	struct device *dev = &pdev->dev;
+	struct acpi_device *adev;
+	char name[32];
+	int i, ret;
+
+	match = acpi_match_device(dev->driver->acpi_match_table, dev);
+	if (!match) {
+		dev_err(dev, "Error ACPI match data is missing\n");
+		return -ENODEV;
+	}
+	inst_data = (const struct i2c_inst_data *)match->driver_data;
+
+	adev = ACPI_COMPANION(dev);
+
+	/* Count number of clients to instantiate */
+	for (i = 0; inst_data[i].type; i++) {}
+
+	multi = devm_kmalloc(dev,
+			offsetof(struct i2c_multi_inst_data, clients[i]),
+			GFP_KERNEL);
+	if (!multi)
+		return -ENOMEM;
+
+	multi->no_clients = i;
+
+	for (i = 0; i < multi->no_clients; i++) {
+		memset(&board_info, 0, sizeof(board_info));
+		strlcpy(board_info.type, inst_data[i].type, I2C_NAME_SIZE);
+		snprintf(name, sizeof(name), "%s-%s", match->id,
+			 inst_data[i].type);
+		board_info.dev_name = name;
+		board_info.irq = 0;
+		if (inst_data[i].irq_idx != -1) {
+			ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
+			if (ret < 0) {
+				dev_err(dev, "Error requesting irq at index %d: %d\n",
+					inst_data[i].irq_idx, ret);
+				goto error;
+			}
+			board_info.irq = ret;
+		}
+		multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
+		if (!multi->clients[i]) {
+			dev_err(dev, "Error creating i2c-client, idx %d\n", i);
+			ret = -ENODEV;
+			goto error;
+		}
+	}
+
+	platform_set_drvdata(pdev, multi);
+	return 0;
+
+error:
+	while (--i >= 0)
+		i2c_unregister_device(multi->clients[i]);
+
+	return ret;
+}
+
+static int i2c_multi_inst_remove(struct platform_device *pdev)
+{
+	struct i2c_multi_inst_data *multi = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < multi->no_clients; i++)
+		i2c_unregister_device(multi->clients[i]);
+
+	return 0;
+}
+
+static const struct i2c_inst_data bsg1160_data[]  = {
+	{ "bmc150_accel", 0 },
+	{ "bmc150_magn", -1 },
+	{ "bmg160", -1 },
+	{}
+};
+
+/*
+ * Note new device-ids must also be added to i2c_multi_instantiate_ids in
+ * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
+ */
+static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
+	{ "BSG1160", (unsigned long)bsg1160_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, i2c_multi_inst_acpi_ids);
+
+static struct platform_driver i2c_multi_inst_driver = {
+	.driver	= {
+		.name = "I2C multi instantiate pseudo device driver",
+		.acpi_match_table = ACPI_PTR(i2c_multi_inst_acpi_ids),
+	},
+	.probe = i2c_multi_inst_probe,
+	.remove = i2c_multi_inst_remove,
+};
+module_platform_driver(i2c_multi_inst_driver);
+
+MODULE_DESCRIPTION("I2C multi instantiate pseudo device driver");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
+MODULE_LICENSE("GPL");
-- 
2.18.0

