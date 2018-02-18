Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeBRQSK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 11:18:10 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32924 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbeBRQSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 11:18:07 -0500
X-Google-Smtp-Source: AH8x224S1XZEF2XMgJj7T5lCT1JCdk//kFstl29kaz0DxwKPBkYjv/ZAAGshtv0kGnYh06gZTdeUcQ==
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v5] input: pxrc: new driver for PhoenixRC Flight Controller Adapter
Date: Sun, 18 Feb 2018 17:17:46 +0100
Message-Id: <20180218161747.21110-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver let you plug in your RC controller to the adapter and
use it as input device in various RC simulators.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

v5:
	- Drop autosuspend support
	- Use pm_mutex instead of input_dev->mutex
	- Use pxrc->is_open instead of input_dev->users
v4:
	- Add call to usb_mark_last_busy() in irq
	- Move code from pxrc_resume() to pxrc_reset_resume()
v3:
	- Use RUDDER and MISC instead of TILT_X and TILT_Y
	- Drop kref and anchor
	- Rework URB handling
	- Add PM support
v2:
	- Change module license to GPLv2 to match SPDX tag


 Documentation/input/devices/pxrc.rst |  57 +++++++
 drivers/input/joystick/Kconfig       |   9 ++
 drivers/input/joystick/Makefile      |   1 +
 drivers/input/joystick/pxrc.c        | 303 +++++++++++++++++++++++++++++++++++
 4 files changed, 370 insertions(+)
 create mode 100644 Documentation/input/devices/pxrc.rst
 create mode 100644 drivers/input/joystick/pxrc.c

diff --git a/Documentation/input/devices/pxrc.rst b/Documentation/input/devices/pxrc.rst
new file mode 100644
index 000000000000..ca11f646bae8
--- /dev/null
+++ b/Documentation/input/devices/pxrc.rst
@@ -0,0 +1,57 @@
+=======================================================
+pxrc - PhoenixRC Flight Controller Adapter
+=======================================================
+
+:Author: Marcus Folkesson <marcus.folkesson@gmail.com>
+
+This driver let you use your own RC controller plugged into the
+adapter that comes with PhoenixRC [1]_ or other compatible adapters.
+
+The adapter supports 7 analog channels and 1 digital input switch.
+
+Notes
+=====
+
+Many RC controllers is able to configure which stick goes to which channel.
+This is also configurable in most simulators, so a matching is not necessary.
+
+The driver is generating the following input event for analog channels:
+
++---------+----------------+
+| Channel |      Event     |
++=========+================+
+|     1   |  ABS_X         |
++---------+----------------+
+|     2   |  ABS_Y         |
++---------+----------------+
+|     3   |  ABS_RX        |
++---------+----------------+
+|     4   |  ABS_RY        |
++---------+----------------+
+|     5   |  ABS_RUDDER    |
++---------+----------------+
+|     6   |  ABS_THROTTLE  |
++---------+----------------+
+|     7   |  ABS_MISC      |
++---------+----------------+
+
+The digital input switch is generated as an `BTN_A` event.
+
+Manual Testing
+==============
+
+To test this driver's functionality you may use `input-event` which is part of
+the `input layer utilities` suite [2]_.
+
+For example::
+
+    > modprobe pxrc
+    > input-events <devnr>
+
+To print all input events from input `devnr`.
+
+References
+==========
+
+.. [1] http://www.phoenix-sim.com/
+.. [2] https://www.kraxel.org/cgit/input/
diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index f3c2f6ea8b44..332c0cc1b2ab 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -351,4 +351,13 @@ config JOYSTICK_PSXPAD_SPI_FF
 
 	  To drive rumble motor a dedicated power supply is required.
 
+config JOYSTICK_PXRC
+	tristate "PhoenixRC Flight Controller Adapter"
+	depends on USB_ARCH_HAS_HCD
+	depends on USB
+	help
+	  Say Y here if you want to use the PhoenixRC Flight Controller Adapter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called pxrc.
 endif
diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Makefile
index 67651efda2e1..dd0492ebbed7 100644
--- a/drivers/input/joystick/Makefile
+++ b/drivers/input/joystick/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_JOYSTICK_JOYDUMP)		+= joydump.o
 obj-$(CONFIG_JOYSTICK_MAGELLAN)		+= magellan.o
 obj-$(CONFIG_JOYSTICK_MAPLE)		+= maplecontrol.o
 obj-$(CONFIG_JOYSTICK_PSXPAD_SPI)	+= psxpad-spi.o
+obj-$(CONFIG_JOYSTICK_PXRC)			+= pxrc.o
 obj-$(CONFIG_JOYSTICK_SIDEWINDER)	+= sidewinder.o
 obj-$(CONFIG_JOYSTICK_SPACEBALL)	+= spaceball.o
 obj-$(CONFIG_JOYSTICK_SPACEORB)		+= spaceorb.o
diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
new file mode 100644
index 000000000000..07a0dbd3ced2
--- /dev/null
+++ b/drivers/input/joystick/pxrc.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Phoenix RC Flight Controller Adapter
+ *
+ * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <linux/usb.h>
+#include <linux/usb/input.h>
+#include <linux/mutex.h>
+#include <linux/input.h>
+
+#define PXRC_VENDOR_ID	(0x1781)
+#define PXRC_PRODUCT_ID	(0x0898)
+
+static const struct usb_device_id pxrc_table[] = {
+	{ USB_DEVICE(PXRC_VENDOR_ID, PXRC_PRODUCT_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(usb, pxrc_table);
+
+struct pxrc {
+	struct input_dev	*input;
+	struct usb_device	*udev;
+	struct usb_interface	*intf;
+	struct urb		*urb;
+	struct mutex		pm_mutex;
+	bool			is_open;
+	__u8			epaddr;
+	char			phys[64];
+	unsigned char           *data;
+	size_t			bsize;
+};
+
+static void pxrc_usb_irq(struct urb *urb)
+{
+	struct pxrc *pxrc = urb->context;
+	int error;
+
+	switch (urb->status) {
+	case 0:
+		/* success */
+		break;
+	case -ETIME:
+		/* this urb is timing out */
+		dev_dbg(&pxrc->intf->dev,
+			"%s - urb timed out - was the device unplugged?\n",
+			__func__);
+		return;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+	case -EPIPE:
+		/* this urb is terminated, clean up */
+		dev_dbg(&pxrc->intf->dev, "%s - urb shutting down with status: %d\n",
+			__func__, urb->status);
+		return;
+	default:
+		dev_dbg(&pxrc->intf->dev, "%s - nonzero urb status received: %d\n",
+			__func__, urb->status);
+		goto exit;
+	}
+
+	if (urb->actual_length == 8) {
+		input_report_abs(pxrc->input, ABS_X, pxrc->data[0]);
+		input_report_abs(pxrc->input, ABS_Y, pxrc->data[2]);
+		input_report_abs(pxrc->input, ABS_RX, pxrc->data[3]);
+		input_report_abs(pxrc->input, ABS_RY, pxrc->data[4]);
+		input_report_abs(pxrc->input, ABS_RUDDER, pxrc->data[5]);
+		input_report_abs(pxrc->input, ABS_THROTTLE, pxrc->data[6]);
+		input_report_abs(pxrc->input, ABS_MISC, pxrc->data[7]);
+
+		input_report_key(pxrc->input, BTN_A, pxrc->data[1]);
+	}
+
+exit:
+	/* Resubmit to fetch new fresh URBs */
+	error = usb_submit_urb(urb, GFP_ATOMIC);
+	if (error && error != -EPERM)
+		dev_err(&pxrc->intf->dev,
+			"%s - usb_submit_urb failed with result: %d",
+			__func__, error);
+}
+
+static int pxrc_open(struct input_dev *input)
+{
+	struct pxrc *pxrc = input_get_drvdata(input);
+	int retval;
+
+	mutex_lock(&pxrc->pm_mutex);
+	retval = usb_submit_urb(pxrc->urb, GFP_KERNEL);
+	if (retval) {
+		dev_err(&pxrc->intf->dev,
+			"%s - usb_submit_urb failed, error: %d\n",
+			__func__, retval);
+		retval = -EIO;
+		goto out;
+	}
+
+	pxrc->is_open = true;
+
+out:
+	mutex_unlock(&pxrc->pm_mutex);
+	return retval;
+}
+
+static void pxrc_close(struct input_dev *input)
+{
+	struct pxrc *pxrc = input_get_drvdata(input);
+
+	mutex_lock(&pxrc->pm_mutex);
+	usb_kill_urb(pxrc->urb);
+	pxrc->is_open = false;
+	mutex_unlock(&pxrc->pm_mutex);
+}
+
+static int pxrc_usb_init(struct pxrc *pxrc)
+{
+	struct usb_endpoint_descriptor *epirq;
+	unsigned int pipe;
+	int retval;
+
+	/* Set up the endpoint information */
+	/* This device only has an interrupt endpoint */
+	retval = usb_find_common_endpoints(pxrc->intf->cur_altsetting,
+			NULL, NULL, &epirq, NULL);
+	if (retval) {
+		dev_err(&pxrc->intf->dev,
+			"Could not find endpoint\n");
+		goto error;
+	}
+
+	pxrc->bsize = usb_endpoint_maxp(epirq);
+	pxrc->epaddr = epirq->bEndpointAddress;
+	pxrc->data = devm_kmalloc(&pxrc->intf->dev, pxrc->bsize, GFP_KERNEL);
+	if (!pxrc->data) {
+		retval = -ENOMEM;
+		goto error;
+	}
+
+	usb_set_intfdata(pxrc->intf, pxrc);
+	usb_make_path(pxrc->udev, pxrc->phys, sizeof(pxrc->phys));
+	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
+
+	pxrc->urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!pxrc->urb) {
+		retval = -ENOMEM;
+		goto error;
+	}
+
+	pipe = usb_rcvintpipe(pxrc->udev, pxrc->epaddr),
+	usb_fill_int_urb(pxrc->urb, pxrc->udev, pipe, pxrc->data, pxrc->bsize,
+						pxrc_usb_irq, pxrc, 1);
+
+error:
+	return retval;
+
+
+}
+
+static int pxrc_input_init(struct pxrc *pxrc)
+{
+	pxrc->input = devm_input_allocate_device(&pxrc->intf->dev);
+	if (pxrc->input == NULL) {
+		dev_err(&pxrc->intf->dev, "couldn't allocate input device\n");
+		return -ENOMEM;
+	}
+
+	pxrc->input->name = "PXRC Flight Controller Adapter";
+	pxrc->input->phys = pxrc->phys;
+	usb_to_input_id(pxrc->udev, &pxrc->input->id);
+
+	pxrc->input->open = pxrc_open;
+	pxrc->input->close = pxrc_close;
+
+	input_set_capability(pxrc->input, EV_KEY, BTN_A);
+	input_set_abs_params(pxrc->input, ABS_X, 0, 255, 0, 0);
+	input_set_abs_params(pxrc->input, ABS_Y, 0, 255, 0, 0);
+	input_set_abs_params(pxrc->input, ABS_RX, 0, 255, 0, 0);
+	input_set_abs_params(pxrc->input, ABS_RY, 0, 255, 0, 0);
+	input_set_abs_params(pxrc->input, ABS_RUDDER, 0, 255, 0, 0);
+	input_set_abs_params(pxrc->input, ABS_THROTTLE, 0, 255, 0, 0);
+	input_set_abs_params(pxrc->input, ABS_MISC, 0, 255, 0, 0);
+
+	input_set_drvdata(pxrc->input, pxrc);
+
+	return input_register_device(pxrc->input);
+}
+
+static int pxrc_probe(struct usb_interface *intf,
+		      const struct usb_device_id *id)
+{
+	struct pxrc *pxrc;
+	int retval;
+
+	pxrc = devm_kzalloc(&intf->dev, sizeof(*pxrc), GFP_KERNEL);
+	if (!pxrc)
+		return -ENOMEM;
+
+	mutex_init(&pxrc->pm_mutex);
+	pxrc->udev = usb_get_dev(interface_to_usbdev(intf));
+	pxrc->intf = intf;
+
+	retval = pxrc_usb_init(pxrc);
+	if (retval)
+		goto error;
+
+	retval = pxrc_input_init(pxrc);
+	if (retval)
+		goto err_free_urb;
+
+	return 0;
+
+err_free_urb:
+	usb_free_urb(pxrc->urb);
+
+error:
+	return retval;
+}
+
+static void pxrc_disconnect(struct usb_interface *intf)
+{
+	struct pxrc *pxrc = usb_get_intfdata(intf);
+
+	usb_free_urb(pxrc->urb);
+	usb_set_intfdata(intf, NULL);
+}
+
+static int pxrc_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct pxrc *pxrc = usb_get_intfdata(intf);
+
+	mutex_lock(&pxrc->pm_mutex);
+	if (pxrc->is_open)
+		usb_kill_urb(pxrc->urb);
+	mutex_unlock(&pxrc->pm_mutex);
+
+	return 0;
+}
+
+static int pxrc_resume(struct usb_interface *intf)
+{
+	struct pxrc *pxrc = usb_get_intfdata(intf);
+	int retval = 0;
+
+	mutex_lock(&pxrc->pm_mutex);
+	if (pxrc->is_open && usb_submit_urb(pxrc->urb, GFP_KERNEL) < 0)
+		retval = -EIO;
+
+	mutex_unlock(&pxrc->pm_mutex);
+	return retval;
+}
+
+static int pxrc_pre_reset(struct usb_interface *intf)
+{
+	struct pxrc *pxrc = usb_get_intfdata(intf);
+
+	mutex_lock(&pxrc->pm_mutex);
+	usb_kill_urb(pxrc->urb);
+	return 0;
+}
+
+static int pxrc_post_reset(struct usb_interface *intf)
+{
+	struct pxrc *pxrc = usb_get_intfdata(intf);
+	int retval = 0;
+
+	if (pxrc->is_open && usb_submit_urb(pxrc->urb, GFP_KERNEL) < 0)
+		retval = -EIO;
+
+	mutex_unlock(&pxrc->pm_mutex);
+
+	return retval;
+}
+
+static int pxrc_reset_resume(struct usb_interface *intf)
+{
+	return pxrc_resume(intf);
+}
+
+static struct usb_driver pxrc_driver = {
+	.name =		"pxrc",
+	.probe =	pxrc_probe,
+	.disconnect =	pxrc_disconnect,
+	.id_table =	pxrc_table,
+	.suspend	= pxrc_suspend,
+	.resume		= pxrc_resume,
+	.pre_reset	= pxrc_pre_reset,
+	.post_reset	= pxrc_post_reset,
+	.reset_resume	= pxrc_reset_resume,
+};
+
+module_usb_driver(pxrc_driver);
+
+MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
+MODULE_DESCRIPTION("PhoenixRC Flight Controller Adapter");
+MODULE_LICENSE("GPL v2");
-- 
2.15.1
