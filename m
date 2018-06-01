Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeFAIYH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:24:07 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43181 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeFAIX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:23:29 -0400
X-Google-Smtp-Source: ADUXVKKZga/PlFQ3CxUr/HZH3BHkcIRRMwI2g8y0e8nj3D6uYaZLZ1AEmCfpKpr7USyR5fYWhLKATw==
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 5/8] gnss: add driver for u-blox receivers
Date: Fri,  1 Jun 2018 10:22:56 +0200
Message-Id: <20180601082259.17563-6-johan@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180601082259.17563-1-johan@kernel.org>
References: <20180601082259.17563-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for serial-connected u-blox GNSS receivers.

Note that the driver uses the generic GNSS serial implementation and
therefore essentially only manages power abstracted into three power
states: ACTIVE, STANDBY, and OFF.

For u-blox receivers with a main supply and no enable-gpios, this simply
means that the main supply is disabled in STANDBY and OFF (the optional
backup supply is kept enabled while the driver is bound).

Note that timepulse-support is not yet implemented.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gnss/Kconfig  |  13 ++++
 drivers/gnss/Makefile |   3 +
 drivers/gnss/ubx.c    | 151 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)
 create mode 100644 drivers/gnss/ubx.c

diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
index f8ee54f99a8d..784b8c0367d9 100644
--- a/drivers/gnss/Kconfig
+++ b/drivers/gnss/Kconfig
@@ -15,4 +15,17 @@ if GNSS
 config GNSS_SERIAL
 	tristate
 
+config GNSS_UBX_SERIAL
+	tristate "u-blox GNSS receiver support"
+	depends on SERIAL_DEV_BUS
+	select GNSS_SERIAL
+	---help---
+	  Say Y here if you have a u-blox GNSS receiver which uses a serial
+	  interface.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called gnss-ubx.
+
+	  If unsure, say N.
+
 endif # GNSS
diff --git a/drivers/gnss/Makefile b/drivers/gnss/Makefile
index 171aba71684d..d9295b20b7bc 100644
--- a/drivers/gnss/Makefile
+++ b/drivers/gnss/Makefile
@@ -8,3 +8,6 @@ gnss-y := core.o
 
 obj-$(CONFIG_GNSS_SERIAL)		+= gnss-serial.o
 gnss-serial-y := serial.o
+
+obj-$(CONFIG_GNSS_UBX_SERIAL)		+= gnss-ubx.o
+gnss-ubx-y := ubx.o
diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
new file mode 100644
index 000000000000..ecddfb362a6f
--- /dev/null
+++ b/drivers/gnss/ubx.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * u-blox GNSS receiver driver
+ *
+ * Copyright (C) 2018 Johan Hovold <johan@kernel.org>
+ */
+
+#include <linux/errno.h>
+#include <linux/gnss.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+#include <linux/serdev.h>
+
+#include "serial.h"
+
+struct ubx_data {
+	struct regulator *v_bckp;
+	struct regulator *vcc;
+};
+
+static int ubx_set_active(struct gnss_serial *gserial)
+{
+	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
+	int ret;
+
+	ret = regulator_enable(data->vcc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ubx_set_standby(struct gnss_serial *gserial)
+{
+	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
+	int ret;
+
+	ret = regulator_disable(data->vcc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ubx_set_power(struct gnss_serial *gserial,
+				enum gnss_serial_pm_state state)
+{
+	switch (state) {
+	case GNSS_SERIAL_ACTIVE:
+		return ubx_set_active(gserial);
+	case GNSS_SERIAL_OFF:
+	case GNSS_SERIAL_STANDBY:
+		return ubx_set_standby(gserial);
+	}
+
+	return -EINVAL;
+}
+
+const struct gnss_serial_ops ubx_gserial_ops = {
+	.set_power = ubx_set_power,
+};
+
+static int ubx_probe(struct serdev_device *serdev)
+{
+	struct gnss_serial *gserial;
+	struct ubx_data *data;
+	int ret;
+
+	gserial = gnss_serial_allocate(serdev, sizeof(*data));
+	if (IS_ERR(gserial)) {
+		ret = PTR_ERR(gserial);
+		return ret;
+	}
+
+	gserial->ops = &ubx_gserial_ops;
+
+	data = gnss_serial_get_drvdata(gserial);
+
+	data->vcc = devm_regulator_get(&serdev->dev, "vcc");
+	if (IS_ERR(data->vcc)) {
+		ret = PTR_ERR(data->vcc);
+		goto err_free_gserial;
+	}
+
+	data->v_bckp = devm_regulator_get_optional(&serdev->dev, "v-bckp");
+	if (IS_ERR(data->v_bckp)) {
+		ret = PTR_ERR(data->v_bckp);
+		if (ret == -ENODEV)
+			data->v_bckp = NULL;
+		else
+			goto err_free_gserial;
+	}
+
+	if (data->v_bckp) {
+		ret = regulator_enable(data->v_bckp);
+		if (ret)
+			goto err_free_gserial;
+	}
+
+	ret = gnss_serial_register(gserial);
+	if (ret)
+		goto err_disable_v_bckp;
+
+	return 0;
+
+err_disable_v_bckp:
+	if (data->v_bckp)
+		regulator_disable(data->v_bckp);
+err_free_gserial:
+	gnss_serial_free(gserial);
+
+	return ret;
+}
+
+static void ubx_remove(struct serdev_device *serdev)
+{
+	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
+	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
+
+	gnss_serial_deregister(gserial);
+	if (data->v_bckp)
+		regulator_disable(data->v_bckp);
+	gnss_serial_free(gserial);
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id ubx_of_match[] = {
+	{ .compatible = "u-blox,neo-8" },
+	{ .compatible = "u-blox,neo-m8" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ubx_of_match);
+#endif
+
+static struct serdev_device_driver ubx_driver = {
+	.driver	= {
+		.name		= "gnss-ubx",
+		.of_match_table	= of_match_ptr(ubx_of_match),
+		.pm		= &gnss_serial_pm_ops,
+	},
+	.probe	= ubx_probe,
+	.remove	= ubx_remove,
+};
+module_serdev_device_driver(ubx_driver);
+
+MODULE_AUTHOR("Johan Hovold <johan@kernel.org>");
+MODULE_DESCRIPTION("u-blox GNSS receiver driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1
