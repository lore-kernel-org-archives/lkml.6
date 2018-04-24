Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524588646; cv=none;
        d=google.com; s=arc-20160816;
        b=APqzVa6CetxrS67+i2PH3WPGGW8yNhIq9Nzb7uEOYlQvColy3WpoggWheHeCash3e8
         jczhw13j2BRIosd+fTN3bf/QVTmFc1MW1f83RQdhMwn6sFgVxmzPv6lU4XZRuotWA4Z3
         ezinx2B/FQ66TTrVtuQS1hbe6dpJBOsOVwoJv54BcDjQ9ewxmJZm7qsX3Hx9REEpsy7a
         XIETS+6l0hicItIdcle/p9xcMtfri6KX4CWkmN5Bg0RPgsDeFYiBtWKUAMRcwsFNiteB
         YpMgC7vSX75vGAJ8jabWXauVl/WZ4aDHeFF82xFx4pTMT9AC7DcllvkA53s+WOddtzft
         UoCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=ObXg4l/kVak6gliRmKsWYJqBBwDYsaqAprR++xnaDFQ=;
        b=IQe2Udp85DdNZMYvvonoZmoKOuk0zaDjCUYdqAQQqhTWh5qHJ3OB4lC+kV536b6LRw
         1O5bqvzi1NEHA6YXOlNs4rYsUBLdeINdY3sZ4V7zEZsLyMah8AxpR0BMNwl7sBapA7YO
         N72KFhrSKyVZgNaoyCp7zesfHkbmQUf10f+GggyAmpFB8b7kRlSbbfUGrOY0EBsREkSv
         v3Y/DC3bC6maVdL5w0cA4lXTCnbFHh1j3fOPxMRXAZPedlRo2ivEn8LggjKI+nK87J3p
         JRCI8JrNchWoI4JuEcIzwMJ/iQbtxX+45TCzr8a+Uhtxfu3gExcpEpCJCX53uaBUDycD
         lp4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fj3i7AqP;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fj3i7AqP;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AIpwx4/heOtPBGSBXfmfqVkr95V+mXiH1p99V9/L50xAYhKwEygxgFoicB7fmqjuCWIh3B6wi1/gVw==
Sender: Johan Hovold <jhovold@gmail.com>
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Pavel Machek <pavel@ucw.cz>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5/7] gnss: add driver for u-blox receivers
Date: Tue, 24 Apr 2018 18:34:56 +0200
Message-Id: <20180424163458.11947-6-johan@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424163458.11947-1-johan@kernel.org>
References: <20180424163458.11947-1-johan@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064896706902?=
X-GMAIL-MSGID: =?utf-8?q?1598647064896706902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add driver for serial-connected u-blox GNSS receivers.

Note that the driver uses the generic GNSS serial implementation and
therefore essentially only manages power abstracted into three power
states: ACTIVE, STANDBY, and OFF.

For u-blox receivers with a single supply and no enable-gpios, this
simply means that the main supply is disabled in STANDBY and OFF.

Note that timepulse-support is not yet implemented.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gnss/Kconfig  |  13 +++++
 drivers/gnss/Makefile |   3 +
 drivers/gnss/ubx.c    | 133 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+)
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
index 000000000000..2f2f00202b5b
--- /dev/null
+++ b/drivers/gnss/ubx.c
@@ -0,0 +1,133 @@
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
+	struct regulator *vcc;
+};
+
+static int ubx_set_active(struct gnss_serial *gserial)
+{
+	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
+	int ret;
+
+	dev_dbg(&gserial->serdev->dev, "%s\n", __func__);
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
+	dev_dbg(&gserial->serdev->dev, "%s\n", __func__);
+
+	ret = regulator_disable(data->vcc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int
+ubx_set_power(struct gnss_serial *gserial, enum gnss_serial_pm_state state)
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
+	ret = gnss_serial_register(gserial);
+	if (ret)
+		goto err_free_gserial;
+
+	return 0;
+
+err_free_gserial:
+	gnss_serial_free(gserial);
+
+	return ret;
+}
+
+static void ubx_remove(struct serdev_device *serdev)
+{
+	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
+
+	gnss_serial_deregister(gserial);
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
2.17.0
