Return-Path: <chunfeng.yun@mediatek.com>
X-Google-Smtp-Source: AG47ELsttcFT+WMqZJLQV6jU18sdjSqKH2Em1KTGcwe8IOZtVb210GlRRzYlcF4JB7pLnhIHVNal
ARC-Seal: i=1; a=rsa-sha256; t=1521007393; cv=none;
        d=google.com; s=arc-20160816;
        b=G5wWQsPDtK9RcoQ/wqT7z/fO/ptW6c2o/nStVxx/HGP5D+A0gXBi+wSlkmQqZQVkvV
         iBbGpDzrZkVQK4IohPGgPfTnruu7qPXVsQWKi38Per2jA2IDQGLAmsqcTEo9sTpgMuCC
         2MPkPT1RPinVG1iAr9vLhNihYsgD6nz6+lXxjjAqgXl62K6m3Bfv4UqeJEA619L3fbBR
         4571XZVEWINFwdcIOSbVC74NNroPUEw4jz6o/t3vyXfS2tnglhZqSHxVHnEgr2aXz5wj
         nVVa0kTEznWV2FYkwAdgjHNn+Osp3f1NGaxFPaR3hY0DrHubmbQH7UkUDzuZNcbCPvS5
         EbnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=CrXXgLRWUqzXGBKZI3P3b9KZqoKblCe+80vyvIiIJhA=;
        b=LaHTgLMUCUAfk6n8aDhPpa2ZtM8FFanugzsSTLyXFhjS4QcdMmtJYh5ttt0DCL85vF
         9hI1OgInCwht7NmfuEyyK7vQOmZBOdhB3q6TWS6yEK9UizvIV7Faepb3cCB2EuM4NTLZ
         l4XBBDCXftSWR4fhZdxK8uQ2vW/ndofWfWCgQAF00IqfmDkdBvQyIrq2wB+yG+ADD65L
         UG4elPDNQoj61otjCoPwcXFBoOECKMVtB4Qks112SXzNW94nkhqiGuaifwKWcN3EiO/v
         JMtXz2+Dr16F7bTl6FhE1GVvBBs+3Sg9SWtdkN8X704UWu3EgfxyWvt0ToH8ERJjVanl
         nSyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.78 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
X-UUID: a352ee4261e3465e80877d0821e7c2a2-20180314
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>, Heikki Krogerus
	<heikki.krogerus@linux.intel.com>, Serge Semin <fancer.lancer@gmail.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>, Guenter Roeck <linux@roeck-us.net>,
	Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, Alan Stern <stern@rowland.harvard.edu>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH] usb: misc: supports Apple Carplay driver
Date: Wed, 14 Mar 2018 14:02:36 +0800
Message-ID: <1521007356-12306-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1521007356-12306-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1521007356-12306-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594891848677699255?=
X-GMAIL-MSGID: =?utf-8?q?1594891848677699255?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The driver is used to support Apple carplay feature by a debugfs
interface which can force the driver to send a USB Vendor Request
of "Apple Device to Host Mode Switch" to switch Apple Device
into host mode.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/misc/Kconfig   |    9 ++
 drivers/usb/misc/Makefile  |    1 +
 drivers/usb/misc/carplay.c |  205 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 215 insertions(+)
 create mode 100644 drivers/usb/misc/carplay.c

diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 68d2f2c..c010c95 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -275,3 +275,12 @@ config USB_CHAOSKEY
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called chaoskey.
+
+config USB_CARPLAY
+	tristate "USB carplay driver support"
+	help
+	  The driver is used to support Apple carplay feature.
+	  It is realized by sending a USB Vendor Request of "Apple Device to
+	  Host Mode Switch" to switch Apple Device into host mode.
+	  When the users want to use carplay, they can force the driver to send
+	  this Vendor Request by a debugfs interface.
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index 109f54f..94380e7 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -29,5 +29,6 @@ obj-$(CONFIG_USB_HSIC_USB3503)		+= usb3503.o
 obj-$(CONFIG_USB_HSIC_USB4604)		+= usb4604.o
 obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
 
+obj-$(CONFIG_USB_CARPLAY)		+= carplay.o
 obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
 obj-$(CONFIG_USB_LINK_LAYER_TEST)	+= lvstest.o
diff --git a/drivers/usb/misc/carplay.c b/drivers/usb/misc/carplay.c
new file mode 100644
index 0000000..bfd41f3
--- /dev/null
+++ b/drivers/usb/misc/carplay.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * carplay.c - carplay usb driver
+ *
+ * Copyright (C) 2018 MediaTek Inc.
+ *
+ * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
+ *
+ */
+
+#include <linux/debugfs.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/seq_file.h>
+#include <linux/uaccess.h>
+#include <linux/usb.h>
+
+/*
+ * usage:
+ * The requirement for the platform using Carplay feature is that support
+ * the USB Dual Role Switch feature, and must have a USB-A receptacle
+ * that is capable of functioning in both USB Host and USB Device roles.
+ *
+ * 1. Apple iphone is enumerated as a usb device
+ * 2. switch Apple iphone to host mode, by, e.g.
+ *    echo host > /sys/kernel/debug/usb/carplay.1-1/mode
+ * 3. switch the platform to device mode, but meanwhile should keep vbus alive;
+ * 4. use carplay feature after the platform is enumerated as a usb device;
+ * 5. when unplug usb cable, switch the platform back to host mode.
+ *
+ * step 2 is supported by this driver;
+ * step 1, 3, 4, 5 should be supported by the USB Dual-Role Controller Driver
+ *    on the platform.
+ *
+ * For more detailed information, please refer to "Chapter 46. USB Role Switch"
+ * in MFI Accessroy Interface Specification.pdf
+ */
+
+#define CARPLAY_NAME "carplay"
+#define VENDER_REQ_DEV_TO_HOST 0x51
+
+struct usb_carplay {
+	struct usb_interface *intf;
+	struct usb_device *udev;
+	struct dentry *droot;
+	struct device *idev;
+	bool is_host;
+};
+
+static int carplay_switch_to_host(struct usb_carplay *ucp)
+{
+	struct usb_device *udev = ucp->udev;
+	int retval;
+
+	if (!ucp->udev)
+		return -ENODEV;
+
+	retval = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
+			VENDER_REQ_DEV_TO_HOST, USB_TYPE_VENDOR,
+			1, 0, NULL, 0, USB_CTRL_GET_TIMEOUT);
+
+	dev_dbg(ucp->idev, "%s retval = %d\n", __func__, retval);
+
+	if (retval != 0) {
+		dev_err(ucp->idev, "%s fail retval = %d\n", __func__, retval);
+		return retval;
+	}
+	ucp->is_host = true;
+
+	return 0;
+}
+
+static int carplay_mode_show(struct seq_file *sf, void *unused)
+{
+	struct usb_carplay *ucp = sf->private;
+
+	seq_printf(sf, "current mode: %s\n(usage: echo host > mode)\n",
+		ucp->is_host ? "host" : "device");
+
+	return 0;
+}
+
+static int carplay_mode_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, carplay_mode_show, inode->i_private);
+}
+
+static ssize_t carplay_mode_write(struct file *file,
+	const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	struct seq_file *sf = file->private_data;
+	struct usb_carplay *ucp = sf->private;
+	char buf[16];
+
+	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	if (!strncmp(buf, "host", 4) && !ucp->is_host) {
+		carplay_switch_to_host(ucp);
+	} else {
+		dev_err(ucp->idev, "wrong setting\n");
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations carplay_mode_fops = {
+	.open = carplay_mode_open,
+	.write = carplay_mode_write,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static struct dentry *carplay_debugfs_init(struct usb_carplay *ucp)
+{
+	struct dentry *root;
+	const char *udev_name = dev_name(&ucp->udev->dev);
+	char name[16];
+
+	snprintf(name, sizeof(name), "%s.%s", CARPLAY_NAME, udev_name);
+	root = debugfs_create_dir(name, usb_debug_root);
+	if (!root) {
+		dev_err(ucp->idev, "create debugfs root failed\n");
+		return root;
+	}
+	ucp->droot = root;
+
+	return debugfs_create_file("mode", 0664, root, ucp,
+			&carplay_mode_fops);
+}
+
+static void carplay_debugfs_exit(struct usb_carplay *ucp)
+{
+	debugfs_remove_recursive(ucp->droot);
+}
+
+static int carplay_probe(struct usb_interface *intf,
+	const struct usb_device_id *id)
+{
+	struct usb_device *udev;
+	struct usb_carplay *ucp;
+	struct dentry *de;
+
+	udev = interface_to_usbdev(intf);
+
+	ucp = kzalloc(sizeof(*ucp), GFP_KERNEL);
+	if (!ucp)
+		return -ENOMEM;
+
+	ucp->udev = usb_get_dev(udev);
+	ucp->intf = intf;
+	ucp->idev = &intf->dev;
+	usb_set_intfdata(intf, ucp);
+	ucp->is_host = false;
+
+	de = carplay_debugfs_init(ucp);
+	if (IS_ERR_OR_NULL(de)) {
+		usb_set_intfdata(intf, NULL);
+		usb_put_dev(ucp->udev);
+		kfree(ucp);
+		return -ENOMEM;
+	}
+
+	dev_info(ucp->idev, "carplay attached\n");
+	return 0;
+}
+
+static void carplay_disconnect(struct usb_interface *intf)
+{
+	struct usb_carplay *ucp = usb_get_intfdata(intf);
+
+	usb_set_intfdata(intf, NULL);
+	usb_put_dev(ucp->udev);
+	carplay_debugfs_exit(ucp);
+	kfree(ucp);
+	dev_info(&intf->dev, "carplay disconnected\n");
+}
+
+static const struct usb_device_id carplay_id_table[] = {
+	/* generic EZ-USB FX2 controller (or development board) */
+	{ USB_DEVICE(0x05ac, 0x12a8) },
+	{}
+};
+
+MODULE_DEVICE_TABLE(usb, carplay_id_table);
+
+static struct usb_driver carplay_driver = {
+	.name = CARPLAY_NAME,
+	.id_table = carplay_id_table,
+	.probe = carplay_probe,
+	.disconnect = carplay_disconnect,
+};
+
+module_usb_driver(carplay_driver);
+
+MODULE_AUTHOR("Chunfeng Yun <chunfeng.yun@mediatek.com>");
+MODULE_DESCRIPTION("USB Carplay Driver");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
