Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524588645; cv=none;
        d=google.com; s=arc-20160816;
        b=ZFiQjnRznApYaWRux6eg7aodBjCeyakkKAmm2IVU24hKMh1jeJuPXFy87WmDMyD/DE
         8gPfFNXXs4g/ofUoGRU5Jtk2cSLpiE11/FrNk55G10aHW2TCLa9OoHefCZuB/xK78Nqz
         3ZWyTeOfpm+PJya9K6ed/agLVhwh95+YpBuPVbWjkwTIgMz4lbEAUE+MwaptUC29QnBY
         w09gYeQxXOt4pFlELSTbsuyjcpspV2xriUgBEwdsLFwvySoqYStA5iozIMclSmlTXGQ3
         uZqQSr+YGSjP9buWhea5D77t+VJ8XQdQBdis8HQpdaKK5K6LOzSAL4th9PNErLn8haX8
         NTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=SI2uMEndzYAzkpxCKSHWnYGKyTVLw+kHWrwb8JC4rsA=;
        b=MYTzOk1l9AS/BpWz6/qx48zf/q+P/LcHZxM2HCm/5sQJxQ8Er2PGLwqZ4UB7fQncNs
         2IXVcXEahS2sZlRjXlmVmtnhX9n55GN6RLVbCu44l0UFwekBNahNSmPbdynHT4NuH7sp
         o50TZAiY2U7JjZxGP5XYr99e5qculBNKrHsf5L7e+/qTqERghZmUKPCcGlZun8Lwsqi9
         NRaeBrL1XFlpmWdv9fScUULk3vpuunf+tyS8+vN61gOQU6Mxkfka+vC9vBnGH08k0hmU
         5vQjrlaFMBnktEvLTKZsKRRzMdTIWRJLckxgsuTjp47IC2v2q+dj1lKY95DQ+I539p0h
         MEHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oeUJuuZv;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oeUJuuZv;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AIpwx4/FQRdbGP2vL2NyBUnIpROFxZN/AVwRPAhkGdeplrZX8wrq2DETLTH5Q/ZX2xByFAj8/K1Oug==
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
Subject: [PATCH 3/7] gnss: add generic serial driver
Date: Tue, 24 Apr 2018 18:34:54 +0200
Message-Id: <20180424163458.11947-4-johan@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424163458.11947-1-johan@kernel.org>
References: <20180424163458.11947-1-johan@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647063920484580?=
X-GMAIL-MSGID: =?utf-8?q?1598647063920484580?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a generic serial GNSS driver (library) which provides a common
implementation for the gnss interface and power management (runtime and
system suspend). This allows GNSS drivers for specific chip to be
implemented by simply providing a set_power() callback to handle three
states: ACTIVE, STANDBY and OFF.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gnss/Kconfig  |   7 +
 drivers/gnss/Makefile |   3 +
 drivers/gnss/serial.c | 288 ++++++++++++++++++++++++++++++++++++++++++
 drivers/gnss/serial.h |  47 +++++++
 4 files changed, 345 insertions(+)
 create mode 100644 drivers/gnss/serial.c
 create mode 100644 drivers/gnss/serial.h

diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
index 103fcc70992e..f8ee54f99a8d 100644
--- a/drivers/gnss/Kconfig
+++ b/drivers/gnss/Kconfig
@@ -9,3 +9,10 @@ menuconfig GNSS
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called gnss.
+
+if GNSS
+
+config GNSS_SERIAL
+	tristate
+
+endif # GNSS
diff --git a/drivers/gnss/Makefile b/drivers/gnss/Makefile
index 1f7a7baab1d9..171aba71684d 100644
--- a/drivers/gnss/Makefile
+++ b/drivers/gnss/Makefile
@@ -5,3 +5,6 @@
 
 obj-$(CONFIG_GNSS)			+= gnss.o
 gnss-y := core.o
+
+obj-$(CONFIG_GNSS_SERIAL)		+= gnss-serial.o
+gnss-serial-y := serial.o
diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
new file mode 100644
index 000000000000..06a4b511f380
--- /dev/null
+++ b/drivers/gnss/serial.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic serial GNSS receiver driver
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
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/serdev.h>
+#include <linux/slab.h>
+
+#include "serial.h"
+
+static int gnss_serial_open(struct gnss_device *gdev)
+{
+	struct gnss_serial *gserial = gnss_get_drvdata(gdev);
+	struct serdev_device *serdev = gserial->serdev;
+	int ret;
+
+	ret = serdev_device_open(serdev);
+	if (ret)
+		return ret;
+
+	serdev_device_set_baudrate(serdev, gserial->speed);
+	serdev_device_set_flow_control(serdev, false);
+
+	ret = pm_runtime_get_sync(&serdev->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&serdev->dev);
+		goto err_close;
+	}
+
+	return 0;
+
+err_close:
+	serdev_device_close(serdev);
+
+	return ret;
+}
+
+static void gnss_serial_close(struct gnss_device *gdev)
+{
+	struct gnss_serial *gserial = gnss_get_drvdata(gdev);
+	struct serdev_device *serdev = gserial->serdev;
+
+	serdev_device_close(serdev);
+
+	pm_runtime_put(&serdev->dev);
+}
+
+static int gnss_serial_write_raw(struct gnss_device *gdev,
+		const unsigned char *buf, size_t count)
+{
+	struct gnss_serial *gserial = gnss_get_drvdata(gdev);
+	struct serdev_device *serdev = gserial->serdev;
+	int ret;
+
+	/* write is only buffered synchronously */
+	ret = serdev_device_write(serdev, buf, count, 0);
+	if (ret < 0)
+		return ret;
+
+	/* FIXME: determine if interrupted? */
+	serdev_device_wait_until_sent(serdev, 0);
+
+	return count;
+}
+
+static const struct gnss_operations gnss_serial_gnss_ops = {
+	.open		= gnss_serial_open,
+	.close		= gnss_serial_close,
+	.write_raw	= gnss_serial_write_raw,
+};
+
+static int gnss_serial_receive_buf(struct serdev_device *serdev,
+		const unsigned char *buf, size_t count)
+{
+	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
+	struct gnss_device *gdev = gserial->gdev;
+
+	return gnss_insert_raw(gdev, buf, count);
+}
+
+static const struct serdev_device_ops gnss_serial_serdev_ops = {
+	.receive_buf	= gnss_serial_receive_buf,
+	.write_wakeup	= serdev_device_write_wakeup,
+};
+
+static int gnss_serial_set_power(struct gnss_serial *gserial,
+		enum gnss_serial_pm_state state)
+{
+	if (!gserial->ops || !gserial->ops->set_power)
+		return 0;
+
+	return gserial->ops->set_power(gserial, state);
+}
+
+/*
+ * FIXME: need to provide subdriver defaults or separate dt parsing from
+ * allocation.
+ */
+static int gnss_serial_parse_dt(struct serdev_device *serdev)
+{
+	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
+	struct device_node *node = serdev->dev.of_node;
+	u32 speed = 4800;
+
+	of_property_read_u32(node, "current-speed", &speed);
+
+	gserial->speed = speed;
+
+	return 0;
+}
+
+struct gnss_serial *
+gnss_serial_allocate(struct serdev_device *serdev, size_t data_size)
+{
+	struct gnss_serial *gserial;
+	struct gnss_device *gdev;
+	int ret;
+
+	gserial = kzalloc(sizeof(*gserial) + data_size, GFP_KERNEL);
+	if (!gserial)
+		return ERR_PTR(-ENOMEM);
+
+	gdev = gnss_allocate_device(&serdev->dev);
+	if (!gdev) {
+		ret = -ENOMEM;
+		goto err_free_gserial;
+	}
+
+	gdev->ops = &gnss_serial_gnss_ops;
+	gnss_set_drvdata(gdev, gserial);
+
+	gserial->serdev = serdev;
+	gserial->gdev = gdev;
+
+	serdev_device_set_drvdata(serdev, gserial);
+	serdev_device_set_client_ops(serdev, &gnss_serial_serdev_ops);
+
+	ret = gnss_serial_parse_dt(serdev);
+	if (ret)
+		goto err_put_device;
+
+	return gserial;
+
+err_put_device:
+	gnss_put_device(gserial->gdev);
+err_free_gserial:
+	kfree(gserial);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(gnss_serial_allocate);
+
+void gnss_serial_free(struct gnss_serial *gserial)
+{
+	gnss_put_device(gserial->gdev);
+	kfree(gserial);
+};
+EXPORT_SYMBOL_GPL(gnss_serial_free);
+
+int gnss_serial_register(struct gnss_serial *gserial)
+{
+	struct serdev_device *serdev = gserial->serdev;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_PM)) {
+		pm_runtime_enable(&serdev->dev);
+	} else {
+		ret = gnss_serial_set_power(gserial, GNSS_SERIAL_ACTIVE);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = gnss_register_device(gserial->gdev);
+	if (ret)
+		goto err_disable_rpm;
+
+	return 0;
+
+err_disable_rpm:
+	if (IS_ENABLED(CONFIG_PM))
+		pm_runtime_disable(&serdev->dev);
+	else
+		gnss_serial_set_power(gserial, GNSS_SERIAL_OFF);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gnss_serial_register);
+
+void gnss_serial_deregister(struct gnss_serial *gserial)
+{
+	struct serdev_device *serdev = gserial->serdev;
+
+	gnss_deregister_device(gserial->gdev);
+
+	if (IS_ENABLED(CONFIG_PM))
+		pm_runtime_disable(&serdev->dev);
+	else
+		gnss_serial_set_power(gserial, GNSS_SERIAL_OFF);
+}
+EXPORT_SYMBOL_GPL(gnss_serial_deregister);
+
+#ifdef CONFIG_PM
+static int gnss_serial_runtime_suspend(struct device *dev)
+{
+	struct gnss_serial *gserial = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	return gnss_serial_set_power(gserial, GNSS_SERIAL_STANDBY);
+}
+
+static int gnss_serial_runtime_resume(struct device *dev)
+{
+	struct gnss_serial *gserial = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	return gnss_serial_set_power(gserial, GNSS_SERIAL_ACTIVE);
+}
+#endif /* CONFIG_PM */
+
+static int gnss_serial_prepare(struct device *dev)
+{
+	dev_dbg(dev, "%s - pm_runtime_suspended = %d\n", __func__,
+			pm_runtime_suspended(dev));
+
+	if (pm_runtime_suspended(dev))
+		return 1;
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int gnss_serial_suspend(struct device *dev)
+{
+	struct gnss_serial *gserial = dev_get_drvdata(dev);
+	int ret = 0;
+
+	dev_dbg(dev, "%s - pm_runtime_suspended = %d\n", __func__,
+			pm_runtime_suspended(dev));
+
+	/*
+	 * FIXME: serdev currently lacks support for managing the underlying
+	 * device's wakeup settings. A workaround would be to close the serdev
+	 * device here if it is open.
+	 */
+
+	if (!pm_runtime_suspended(dev))
+		ret = gnss_serial_set_power(gserial, GNSS_SERIAL_STANDBY);
+
+	return ret;
+}
+
+static int gnss_serial_resume(struct device *dev)
+{
+	struct gnss_serial *gserial = dev_get_drvdata(dev);
+	int ret = 0;
+
+	dev_dbg(dev, "%s - pm_runtime_suspended = %d\n", __func__,
+			pm_runtime_suspended(dev));
+
+	if (!pm_runtime_suspended(dev))
+		ret = gnss_serial_set_power(gserial, GNSS_SERIAL_ACTIVE);
+
+	return ret;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+const struct dev_pm_ops gnss_serial_pm_ops = {
+	.prepare	= gnss_serial_prepare,
+	SET_SYSTEM_SLEEP_PM_OPS(gnss_serial_suspend, gnss_serial_resume)
+	SET_RUNTIME_PM_OPS(gnss_serial_runtime_suspend, gnss_serial_runtime_resume, NULL)
+};
+EXPORT_SYMBOL_GPL(gnss_serial_pm_ops);
+
+MODULE_AUTHOR("Johan Hovold <johan@kernel.org>");
+MODULE_DESCRIPTION("Generic serial GNSS receiver driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/gnss/serial.h b/drivers/gnss/serial.h
new file mode 100644
index 000000000000..01e7573bc473
--- /dev/null
+++ b/drivers/gnss/serial.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Generic serial GNSS receiver driver
+ *
+ * Copyright (C) 2018 Johan Hovold <johan@kernel.org>
+ */
+
+#ifndef _LINUX_GNSS_SERIAL_H
+#define _LINUX_GNSS_SERIAL_H
+
+#include <asm/termbits.h>
+#include <linux/pm.h>
+
+struct gnss_serial {
+	struct serdev_device *serdev;
+	struct gnss_device *gdev;
+	speed_t	speed;
+	const struct gnss_serial_ops *ops;
+	unsigned long drvdata[0];
+};
+
+enum gnss_serial_pm_state {
+	GNSS_SERIAL_OFF,
+	GNSS_SERIAL_ACTIVE,
+	GNSS_SERIAL_STANDBY,
+};
+
+struct gnss_serial_ops {
+	int (*set_power)(struct gnss_serial *gserial,
+			enum gnss_serial_pm_state state);
+};
+
+extern const struct dev_pm_ops gnss_serial_pm_ops;
+
+struct gnss_serial *gnss_serial_allocate(struct serdev_device *gserial,
+		size_t data_size);
+void gnss_serial_free(struct gnss_serial *gserial);
+
+int gnss_serial_register(struct gnss_serial *gserial);
+void gnss_serial_deregister(struct gnss_serial *gserial);
+
+static inline void *gnss_serial_get_drvdata(struct gnss_serial *gserial)
+{
+	return &gserial[1];
+}
+
+#endif /* _LINUX_GNSS_SERIAL_H */
-- 
2.17.0
