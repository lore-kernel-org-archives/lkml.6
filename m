Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524588647; cv=none;
        d=google.com; s=arc-20160816;
        b=MPNHjTFObLQuvrXVjsQxeCu7ybElkQY2Mb2iH97rgzC5b/hn/wfLh5TfmeCdmPD7M5
         svPkEbG8lEx0a2VPglZBv6s6CyppGN7DUly5PqPJy16tUjys4hBU9677XHtyyZWdPVNF
         hOYNk9+rTJ79yJGputyUCNobMO8hrrckq6Rw6sF7XGiWpFKkPfBBoMKsbTvXLXHGW7os
         CL82WWtq0rC6mdpIB0KbXOZu1/UTY2KseJHL/A/PZ0YikwerDuJifALSTYO885nYWcq+
         QUk6z6Aot38DJ+GJHk6qFUP8eDFZNEtrbSr2eygm3tNnNEDT8X6QUYC94yL4/5pCyy3d
         GHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=/qH7SLg5YHCaVXxWSVbNta72BjGbJhpG0+xPCKrgenE=;
        b=OcMwyD5dlC/ZHUYGWPmd+84dp+w2rIE84chE3N5p8cg1/Yp52ZFFQL1YPolHlkgzN5
         PatV+5Y/SsRIFWo+UnC3owAJipyHNAT/edxnCcCtl2WFrHPuad+1AuY4ObRoEaWLI8BI
         g9rAZwE37iYj6Pa0dcrKUJEFv2hs7RBs2Qu/TMPEFDlPgiMdmxDQRbMiEb1ES1WML8fN
         qKsWocW2YemmstER6mDrWacc4ShaWlb7EY9jEHoa7MQdVSPHsn7B22fJHb1kdh6xllq2
         7w9v8sSLMsaKoXe0JNjckyeMATez2IrMdw6IPl81zJQv8DLLAoag8W2giyu9mATi4UqH
         U75w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=E5F2POPh;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=E5F2POPh;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AIpwx4+FUfvUilJ36JlK3JWbAMpTUTgFKlnCSr3yQINYTKxDJsIJtwQOzKZ6tx8q9jfRWyTbPtF2BQ==
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
Subject: [PATCH 7/7] gnss: add driver for sirfstar-based receivers
Date: Tue, 24 Apr 2018 18:34:58 +0200
Message-Id: <20180424163458.11947-8-johan@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424163458.11947-1-johan@kernel.org>
References: <20180424163458.11947-1-johan@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647065685485555?=
X-GMAIL-MSGID: =?utf-8?q?1598647065685485555?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add driver for serial-connected SiRFstar-based GNSS receivers.

These devices typically boot into hibernate mode from which they can be
woken using a pulse on the ON_OFF (enable) input pin. Once active, a
pulse on the same ON_OFF pin is used to put the device back into
hibernate mode. The current state can be determined by sampling the
WAKEUP output.

Hardware configurations where WAKEUP has been connected to ON_OFF (and
where an initial WAKEUP pulse during boot is sufficient to have the
device boot into active mode) are also supported. In this case, device
power is managed using the main-supply regulator only.

Note that configurations where WAKEUP is left not connected, so that the
device power state can only indirectly be determined using the I/O
interface, is currently not supported. It should be fairly
straight-forward to extend the current implementation with such support
however (and this this is the main reason for not using the generic
serial implementation for this driver).

Note that timepulse-support is left unimplemented.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gnss/Kconfig  |  12 ++
 drivers/gnss/Makefile |   3 +
 drivers/gnss/sirf.c   | 415 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 430 insertions(+)
 create mode 100644 drivers/gnss/sirf.c

diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
index 784b8c0367d9..6abc88514512 100644
--- a/drivers/gnss/Kconfig
+++ b/drivers/gnss/Kconfig
@@ -15,6 +15,18 @@ if GNSS
 config GNSS_SERIAL
 	tristate
 
+config GNSS_SIRF_SERIAL
+	tristate "SiRFstar GNSS receiver support"
+	depends on SERIAL_DEV_BUS
+	---help---
+	  Say Y here if you have a SiRFstar-based GNSS receiver which uses a
+	  serial interface.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called gnss-sirf.
+
+	  If unsure, say N.
+
 config GNSS_UBX_SERIAL
 	tristate "u-blox GNSS receiver support"
 	depends on SERIAL_DEV_BUS
diff --git a/drivers/gnss/Makefile b/drivers/gnss/Makefile
index d9295b20b7bc..5cf0ebe0330a 100644
--- a/drivers/gnss/Makefile
+++ b/drivers/gnss/Makefile
@@ -9,5 +9,8 @@ gnss-y := core.o
 obj-$(CONFIG_GNSS_SERIAL)		+= gnss-serial.o
 gnss-serial-y := serial.o
 
+obj-$(CONFIG_GNSS_SIRF_SERIAL)		+= gnss-sirf.o
+gnss-sirf-y := sirf.o
+
 obj-$(CONFIG_GNSS_UBX_SERIAL)		+= gnss-ubx.o
 gnss-ubx-y := ubx.o
diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
new file mode 100644
index 000000000000..9d46da1530ca
--- /dev/null
+++ b/drivers/gnss/sirf.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SiRFstar GNSS receiver driver
+ *
+ * Copyright (C) 2018 Johan Hovold <johan@kernel.org>
+ */
+
+#include <linux/errno.h>
+#include <linux/gnss.h>
+#include <linux/gpio/consumer.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/serdev.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+
+#define SIRF_BOOT_DELAY			500
+#define SIRF_ON_OFF_PULSE_TIME		100
+#define SIRF_ACTIVATE_TIMEOUT		200
+#define SIRF_HIBERNATE_TIMEOUT		200
+
+struct sirf_data {
+	struct gnss_device *gdev;
+	struct serdev_device *serdev;
+	speed_t	speed;
+	struct regulator *vcc;
+	struct gpio_desc *on_off;
+	struct gpio_desc *wakeup;
+	int irq;
+	bool active;
+	wait_queue_head_t power_wait;
+};
+
+static int sirf_open(struct gnss_device *gdev)
+{
+	struct sirf_data *data = gnss_get_drvdata(gdev);
+	struct serdev_device *serdev = data->serdev;
+	int ret;
+
+	ret = serdev_device_open(serdev);
+	if (ret)
+		return ret;
+
+	serdev_device_set_baudrate(serdev, data->speed);
+	serdev_device_set_flow_control(serdev, false);
+
+	ret = pm_runtime_get_sync(&serdev->dev);
+	if (ret < 0) {
+		dev_err(&gdev->dev, "failed to runtime resume: %d\n", ret);
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
+static void sirf_close(struct gnss_device *gdev)
+{
+	struct sirf_data *data = gnss_get_drvdata(gdev);
+	struct serdev_device *serdev = data->serdev;
+
+	serdev_device_close(serdev);
+
+	pm_runtime_put(&serdev->dev);
+}
+
+static int sirf_write_raw(struct gnss_device *gdev,
+		const unsigned char *buf, size_t count)
+{
+	struct sirf_data *data = gnss_get_drvdata(gdev);
+	struct serdev_device *serdev = data->serdev;
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
+static const struct gnss_operations sirf_gnss_ops = {
+	.open		= sirf_open,
+	.close		= sirf_close,
+	.write_raw	= sirf_write_raw,
+};
+
+static int sirf_receive_buf(struct serdev_device *serdev,
+		const unsigned char *buf, size_t count)
+{
+	struct sirf_data *data = serdev_device_get_drvdata(serdev);
+	struct gnss_device *gdev = data->gdev;
+
+	return gnss_insert_raw(gdev, buf, count);
+}
+
+static const struct serdev_device_ops sirf_serdev_ops = {
+	.receive_buf	= sirf_receive_buf,
+	.write_wakeup	= serdev_device_write_wakeup,
+};
+
+static irqreturn_t sirf_wakeup_handler(int irq, void *dev_id)
+{
+	struct sirf_data *data = dev_id;
+	struct device *dev = &data->serdev->dev;
+	int ret;
+
+	ret = gpiod_get_value_cansleep(data->wakeup);
+	dev_dbg(dev, "%s - wakeup = %d\n", __func__, ret);
+	if (ret < 0)
+		goto out;
+
+	data->active = !!ret;
+	wake_up_interruptible(&data->power_wait);
+out:
+	return IRQ_HANDLED;
+}
+
+static int sirf_wait_for_power_state(struct sirf_data *data, bool active,
+		unsigned long timeout)
+{
+	int ret;
+
+	ret = wait_event_interruptible_timeout(data->power_wait,
+			data->active == active, msecs_to_jiffies(timeout));
+	if (ret < 0)
+		return ret;
+
+	if (ret == 0) {
+		dev_warn(&data->serdev->dev, "timeout waiting for active state = %d\n",
+				active);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void sirf_pulse_on_off(struct sirf_data *data)
+{
+	gpiod_set_value_cansleep(data->on_off, 1);
+	msleep(SIRF_ON_OFF_PULSE_TIME);
+	gpiod_set_value_cansleep(data->on_off, 0);
+}
+
+static int sirf_set_active(struct sirf_data *data, bool active)
+{
+	unsigned long timeout;
+	int retries = 3;
+	int ret;
+
+	if (active)
+		timeout = SIRF_ACTIVATE_TIMEOUT;
+	else
+		timeout = SIRF_HIBERNATE_TIMEOUT;
+
+	while (retries-- > 0) {
+		sirf_pulse_on_off(data);
+		ret = sirf_wait_for_power_state(data, active, timeout);
+		if (ret < 0) {
+			if (ret == -ETIMEDOUT)
+				continue;
+
+			return ret;
+		}
+
+		break;
+	}
+
+	if (retries == 0)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int sirf_runtime_suspend(struct device *dev)
+{
+	struct sirf_data *data = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	if (!data->on_off)
+		return regulator_disable(data->vcc);
+
+	return sirf_set_active(data, false);
+}
+
+static int sirf_runtime_resume(struct device *dev)
+{
+	struct sirf_data *data = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	if (!data->on_off)
+		return regulator_enable(data->vcc);
+
+	return sirf_set_active(data, true);
+}
+
+static int __maybe_unused sirf_suspend(struct device *dev)
+{
+	struct sirf_data *data = dev_get_drvdata(dev);
+	int ret = 0;
+
+	dev_dbg(dev, "%s - pm_runtime_suspended = %d\n", __func__,
+			pm_runtime_suspended(dev));
+
+	if (!pm_runtime_suspended(dev))
+		ret = sirf_runtime_suspend(dev);
+
+	if (data->wakeup)
+		disable_irq(data->irq);
+
+	return ret;
+}
+
+static int __maybe_unused sirf_resume(struct device *dev)
+{
+	struct sirf_data *data = dev_get_drvdata(dev);
+	int ret = 0;
+
+	dev_dbg(dev, "%s - pm_runtime_suspended = %d\n", __func__,
+			pm_runtime_suspended(dev));
+
+	if (data->wakeup)
+		enable_irq(data->irq);
+
+	if (!pm_runtime_suspended(dev))
+		ret = sirf_runtime_resume(dev);
+
+	return ret;
+}
+
+static const struct dev_pm_ops sirf_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sirf_suspend, sirf_resume)
+	SET_RUNTIME_PM_OPS(sirf_runtime_suspend, sirf_runtime_resume, NULL)
+};
+
+static int sirf_parse_dt(struct serdev_device *serdev)
+{
+	struct sirf_data *data = serdev_device_get_drvdata(serdev);
+	struct device_node *node = serdev->dev.of_node;
+	u32 speed = 9600;
+
+	of_property_read_u32(node, "current-speed", &speed);
+
+	data->speed = speed;
+
+	return 0;
+}
+
+static int sirf_probe(struct serdev_device *serdev)
+{
+	struct device *dev = &serdev->dev;
+	struct gnss_device *gdev;
+	struct sirf_data *data;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	gdev = gnss_allocate_device(dev);
+	if (!gdev)
+		return -ENOMEM;
+
+	gdev->ops = &sirf_gnss_ops;
+	gnss_set_drvdata(gdev, data);
+
+	data->serdev = serdev;
+	data->gdev = gdev;
+
+	init_waitqueue_head(&data->power_wait);
+
+	serdev_device_set_drvdata(serdev, data);
+	serdev_device_set_client_ops(serdev, &sirf_serdev_ops);
+
+	ret = sirf_parse_dt(serdev);
+	if (ret)
+		goto err_put_device;
+
+	data->vcc = devm_regulator_get(dev, "vcc");
+	if (IS_ERR(data->vcc)) {
+		ret = PTR_ERR(data->vcc);
+		goto err_put_device;
+	}
+
+	data->on_off = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(data->on_off))
+		goto err_put_device;
+
+	if (data->on_off) {
+		data->wakeup = devm_gpiod_get_optional(dev, "wakeup", GPIOD_IN);
+		if (IS_ERR(data->wakeup))
+			goto err_put_device;
+
+		/*
+		 * Configurations where WAKEUP has been left not connected,
+		 * are currently not supported.
+		 */
+		if (!data->wakeup) {
+			dev_err(dev, "no wakeup gpio specified\n");
+			ret = -ENODEV;
+			goto err_put_device;
+		}
+	}
+
+	if (data->wakeup) {
+		ret = gpiod_to_irq(data->wakeup);
+		if (ret < 0)
+			goto err_put_device;
+
+		data->irq = ret;
+
+		ret = devm_request_threaded_irq(dev, data->irq, NULL,
+				sirf_wakeup_handler,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				"wakeup", data);
+		if (ret)
+			goto err_put_device;
+	}
+
+	if (data->on_off) {
+		ret = regulator_enable(data->vcc);
+		if (ret)
+			goto err_put_device;
+
+		/* Wait for chip to boot into hibernate mode */
+		msleep(SIRF_BOOT_DELAY);
+	}
+
+	if (IS_ENABLED(CONFIG_PM)) {
+		pm_runtime_set_suspended(dev);	/* clear runtime_error flag */
+		pm_runtime_enable(dev);
+	} else {
+		ret = sirf_runtime_resume(dev);
+		if (ret < 0)
+			goto err_disable_vcc;
+	}
+
+	ret = gnss_register_device(gdev);
+	if (ret)
+		goto err_disable_rpm;
+
+	return 0;
+
+err_disable_rpm:
+	if (IS_ENABLED(CONFIG_PM))
+		pm_runtime_disable(dev);
+	else
+		sirf_runtime_suspend(dev);
+err_disable_vcc:
+	if (data->on_off)
+		regulator_disable(data->vcc);
+err_put_device:
+	gnss_put_device(data->gdev);
+
+	return ret;
+}
+
+static void sirf_remove(struct serdev_device *serdev)
+{
+	struct sirf_data *data = serdev_device_get_drvdata(serdev);
+
+	gnss_deregister_device(data->gdev);
+
+	if (IS_ENABLED(CONFIG_PM))
+		pm_runtime_disable(&serdev->dev);
+	else
+		sirf_runtime_suspend(&serdev->dev);
+
+	if (data->on_off)
+		regulator_disable(data->vcc);
+
+	gnss_put_device(data->gdev);
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id sirf_of_match[] = {
+	{ .compatible = "fastrax,uc430" },
+	{ .compatible = "linx,r4" },
+	{ .compatible = "wi2wi,w2sg0008i" },
+	{ .compatible = "wi2wi,w2sg0084i" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sirf_of_match);
+#endif
+
+static struct serdev_device_driver sirf_driver = {
+	.driver	= {
+		.name		= "gnss-sirf",
+		.of_match_table	= of_match_ptr(sirf_of_match),
+		.pm		= &sirf_pm_ops,
+	},
+	.probe	= sirf_probe,
+	.remove	= sirf_remove,
+};
+module_serdev_device_driver(sirf_driver);
+
+MODULE_AUTHOR("Johan Hovold <johan@kernel.org>");
+MODULE_DESCRIPTION("SiRFstar GNSS receiver driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.0
