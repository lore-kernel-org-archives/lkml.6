Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524588644; cv=none;
        d=google.com; s=arc-20160816;
        b=BsbpP3UAddN8bu5+IIe/5e4vO/gfqm7BsMR8ScPD55iaidpzRjz0XOKNkRBd01UHvd
         rDJrMpHe9/LQQJHe2nNEgDuY66hPpaLp0BsENaD1HnifDHQLT0A0uvrjxyB1iGQAZgHj
         w0Q5JFNyNzpb599N6+hWNyK6gV+dSOI4CFg49IWhRUk6LSnpeaMgl6UjBbhxnfPB+JRE
         0CwyNosQGp+m+xPOcCvzvMnXjHhhHtQXqDEHJv0FKOBmH/3F/B6pwZPIG4UKRNwJxuum
         Aiuj5HOZFVgCHrf9077XMR1uyP68sHRcn++OMMG5kqIONspdHNBOyUjNxxslj3NukVPi
         gNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=DnwqPWZNZQNlyD0aJd3F4WOBssn/vUMK1V6gVrb2Cfw=;
        b=y1gqfPc8QYTSHaZ16N8v2v/BtajzHwdIkD6DGcIuZIojtwHcoSv13G+XeUw0Qq/Nfe
         GtNdjXqaPcac1KuhBmOWvYBAMESjQILwzccZVHdzL1U0Nm3G5u8b8d3dC90o8sJwOz7T
         Qa1wDS/hqxYxMxQ3w5OkDmACoSMcL/W8arY/ugFA44yuzVznVgvZvIplwloDcrid6ryr
         5atVMhgxXKalis/yIvVf0s6x2lBbi0nYfR2pelgu8Iw2JA9OFxnrMFZ1DMf5uaff3v00
         HNyk3pUg20hAaF1izOAaXKCmknsnfw3p+ai08Ub3T368CnHiZA3yWzOCSQCi8oUk8kQx
         94XA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cTn+OjzB;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cTn+OjzB;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AIpwx49ek47NwZCyq1YdBfMs24dW3FCOwHupGXinKH16J2zcJAIbAw9o19b+6onoJi3wRgzdJXwxUw==
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
Subject: [PATCH 1/7] gnss: add GNSS receiver subsystem
Date: Tue, 24 Apr 2018 18:34:52 +0200
Message-Id: <20180424163458.11947-2-johan@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424163458.11947-1-johan@kernel.org>
References: <20180424163458.11947-1-johan@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647062102212642?=
X-GMAIL-MSGID: =?utf-8?q?1598647062102212642?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a new subsystem for GNSS (e.g. GPS) receivers.

While GNSS receivers are typically accessed using a UART interface they
often also support other I/O interfaces such as I2C, SPI and USB, while
yet other devices use iomem or even some form of remote-processor
messaging (rpmsg).

The new GNSS subsystem abstracts the underlying interface and provides a
new "gnss" class type, which exposes a character-device interface (e.g.
/dev/gnss0) to user space. This allows GNSS receivers to have a
representation in the Linux device model, something which is important
not least for power management purposes.

Note that the character-device interface provides raw access to whatever
protocol the receiver is (currently) using, such as NMEA 0183, UBX or
SiRF Binary. These protocols are expected to be continued to be handled
by user space for the time being, even if some hybrid solutions are also
conceivable (e.g. to have kernel drivers issue management commands).

This will still allow for better platform integration by allowing GNSS
devices and their resources (e.g. regulators and enable-gpios) to be
described by firmware and managed by kernel drivers rather than
platform-specific scripts and services.

While the current interface is kept minimal, it could be extended using
IOCTLs, sysfs or uevents as needs and proper abstraction levels are
identified and determined (e.g. for device and feature identification).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 MAINTAINERS           |   6 +
 drivers/Kconfig       |   2 +
 drivers/Makefile      |   1 +
 drivers/gnss/Kconfig  |  11 ++
 drivers/gnss/Makefile |   7 +
 drivers/gnss/core.c   | 385 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/gnss.h  |  64 +++++++
 7 files changed, 476 insertions(+)
 create mode 100644 drivers/gnss/Kconfig
 create mode 100644 drivers/gnss/Makefile
 create mode 100644 drivers/gnss/core.c
 create mode 100644 include/linux/gnss.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a1410d5a621..dc3df211c1a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5962,6 +5962,12 @@ F:	Documentation/isdn/README.gigaset
 F:	drivers/isdn/gigaset/
 F:	include/uapi/linux/gigaset_dev.h
 
+GNSS SUBSYSTEM
+M:	Johan Hovold <johan@kernel.org>
+S:	Maintained
+F:	drivers/gnss/
+F:	include/linux/gnss.h
+
 GO7007 MPEG CODEC
 M:	Hans Verkuil <hans.verkuil@cisco.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 95b9ccc08165..ab4d43923c4d 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -9,6 +9,8 @@ source "drivers/bus/Kconfig"
 
 source "drivers/connector/Kconfig"
 
+source "drivers/gnss/Kconfig"
+
 source "drivers/mtd/Kconfig"
 
 source "drivers/of/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 24cd47014657..cc9a7c5f7d2c 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -185,3 +185,4 @@ obj-$(CONFIG_TEE)		+= tee/
 obj-$(CONFIG_MULTIPLEXER)	+= mux/
 obj-$(CONFIG_UNISYS_VISORBUS)	+= visorbus/
 obj-$(CONFIG_SIOX)		+= siox/
+obj-$(CONFIG_GNSS)		+= gnss/
diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
new file mode 100644
index 000000000000..103fcc70992e
--- /dev/null
+++ b/drivers/gnss/Kconfig
@@ -0,0 +1,11 @@
+#
+# GNSS receiver configuration
+#
+
+menuconfig GNSS
+	tristate "GNSS receiver support"
+	---help---
+	  Say Y here if you have a GNSS receiver (e.g. a GPS receiver).
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called gnss.
diff --git a/drivers/gnss/Makefile b/drivers/gnss/Makefile
new file mode 100644
index 000000000000..1f7a7baab1d9
--- /dev/null
+++ b/drivers/gnss/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the GNSS subsystem.
+#
+
+obj-$(CONFIG_GNSS)			+= gnss.o
+gnss-y := core.o
diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
new file mode 100644
index 000000000000..9b88c7e72233
--- /dev/null
+++ b/drivers/gnss/core.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GNSS receiver core
+ *
+ * Copyright (C) 2018 Johan Hovold <johan@kernel.org>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cdev.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/gnss.h>
+#include <linux/idr.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/wait.h>
+
+#define GNSS_MINORS	16
+
+static DEFINE_IDA(gnss_minors);
+static dev_t gnss_first;
+
+/* FIFO size must be a power of two */
+#define GNSS_READ_FIFO_SIZE	4096
+#define GNSS_WRITE_BUF_SIZE	1024
+
+#define to_gnss_device(d) container_of((d), struct gnss_device, dev)
+
+static int gnss_open(struct inode *inode, struct file *file)
+{
+	struct gnss_device *gdev;
+	int ret = 0;
+
+	gdev = container_of(inode->i_cdev, struct gnss_device, cdev);
+
+	get_device(&gdev->dev);
+
+	nonseekable_open(inode, file);
+	file->private_data = gdev;
+
+	down_write(&gdev->rwsem);
+	if (gdev->disconnected) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
+	if (gdev->count++ == 0) {
+		ret = gdev->ops->open(gdev);
+		if (ret)
+			gdev->count--;
+	}
+unlock:
+	up_write(&gdev->rwsem);
+
+	if (ret)
+		goto err_put_device;
+
+	return 0;
+
+err_put_device:
+	put_device(&gdev->dev);
+
+	return ret;
+}
+
+static int gnss_release(struct inode *inode, struct file *file)
+{
+	struct gnss_device *gdev = file->private_data;
+
+	down_write(&gdev->rwsem);
+	if (gdev->disconnected)
+		goto unlock;
+
+	if (--gdev->count == 0) {
+		gdev->ops->close(gdev);
+		kfifo_reset(&gdev->read_fifo);
+	}
+unlock:
+	up_write(&gdev->rwsem);
+
+	put_device(&gdev->dev);
+
+	return 0;
+}
+
+static ssize_t gnss_read(struct file *file, char __user *buf,
+		size_t count, loff_t *pos)
+{
+	struct gnss_device *gdev = file->private_data;
+	unsigned int copied;
+	int ret;
+
+	mutex_lock(&gdev->read_mutex);
+	while (kfifo_is_empty(&gdev->read_fifo)) {
+		mutex_unlock(&gdev->read_mutex);
+
+		if (gdev->disconnected)
+			return 0;
+
+		if (file->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		ret = wait_event_interruptible(gdev->read_queue,
+				gdev->disconnected ||
+				!kfifo_is_empty(&gdev->read_fifo));
+		if (ret)
+			return -ERESTARTSYS;
+
+		mutex_lock(&gdev->read_mutex);
+	}
+
+	ret = kfifo_to_user(&gdev->read_fifo, buf, count, &copied);
+	if (ret)
+		goto out_unlock;
+
+	ret = copied;
+
+	dev_dbg(&gdev->dev, "%s - count = %zu\n", __func__, copied);
+
+out_unlock:
+	mutex_unlock(&gdev->read_mutex);
+
+	return ret;
+}
+
+static ssize_t gnss_write(struct file *file, const char __user *buf,
+		size_t count, loff_t *pos)
+{
+	struct gnss_device *gdev = file->private_data;
+	size_t written = 0;
+	int ret;
+
+	dev_dbg(&gdev->dev, "%s - count = %zu\n", __func__, count);
+
+	if (gdev->disconnected) {
+		dev_dbg(&gdev->dev, "%s - disconnected\n", __func__);
+		return -EIO;
+	}
+
+	if (!count)
+		return 0;
+
+	if (!gdev->ops->write_raw)
+		return -EIO;
+
+	/* Ignoring O_NONBLOCK, write_raw() is synchronous. */
+
+	ret = mutex_lock_interruptible(&gdev->write_mutex);
+	if (ret)
+		return -ERESTARTSYS;
+
+	for (;;) {
+		size_t n = count - written;
+
+		if (n > GNSS_WRITE_BUF_SIZE)
+			n = GNSS_WRITE_BUF_SIZE;
+
+		if (copy_from_user(gdev->write_buf, buf, n)) {
+			ret = -EFAULT;
+			goto out_unlock;
+		}
+
+		/*
+		 * Assumes write_raw can always accept GNSS_WRITE_BUF_SIZE
+		 * bytes.
+		 *
+		 * FIXME: revisit
+		 */
+		down_read(&gdev->rwsem);
+		if (!gdev->disconnected)
+			ret = gdev->ops->write_raw(gdev, gdev->write_buf, n);
+		else
+			ret = -EIO;
+		up_read(&gdev->rwsem);
+
+		if (ret < 0)
+			break;
+
+		written += ret;
+		buf += ret;
+
+		if (written == count)
+			break;
+	}
+
+	if (written)
+		ret = written;
+out_unlock:
+	mutex_unlock(&gdev->write_mutex);
+
+	return ret;
+}
+
+static __poll_t gnss_poll(struct file *file, poll_table *wait)
+{
+	struct gnss_device *gdev = file->private_data;
+	__poll_t mask = 0;
+
+	poll_wait(file, &gdev->read_queue, wait);
+
+	if (!kfifo_is_empty(&gdev->read_fifo))
+		mask |= EPOLLIN | EPOLLRDNORM;
+	if (gdev->disconnected)
+		mask |= EPOLLHUP;
+
+	dev_dbg(&gdev->dev, "%s - mask = 0x%04x\n", __func__, mask);
+
+	return mask;
+}
+
+static const struct file_operations gnss_fops = {
+	.owner		= THIS_MODULE,
+	.open		= gnss_open,
+	.release	= gnss_release,
+	.read		= gnss_read,
+	.write		= gnss_write,
+	.poll		= gnss_poll,
+	.llseek		= no_llseek,
+};
+
+static struct class *gnss_class;
+
+static void gnss_device_release(struct device *dev)
+{
+	struct gnss_device *gdev = to_gnss_device(dev);
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	kfree(gdev->write_buf);
+	kfifo_free(&gdev->read_fifo);
+	ida_simple_remove(&gnss_minors, gdev->id);
+	kfree(gdev);
+}
+
+struct gnss_device *gnss_allocate_device(struct device *parent)
+{
+	struct gnss_device *gdev;
+	struct device *dev;
+	int id;
+	int ret;
+
+	gdev = kzalloc(sizeof(*gdev), GFP_KERNEL);
+	if (!gdev)
+		return NULL;
+
+	id = ida_simple_get(&gnss_minors, 0, GNSS_MINORS, GFP_KERNEL);
+	if (id < 0) {
+		kfree(gdev);
+		return ERR_PTR(id);
+	}
+
+	gdev->id = id;
+
+	dev = &gdev->dev;
+	device_initialize(dev);
+	dev->devt = gnss_first + id;
+	dev->class = gnss_class;
+	dev->parent = parent;
+	dev->release = gnss_device_release;
+	dev_set_drvdata(dev, gdev);
+	dev_set_name(dev, "gnss%d", id);
+
+	init_rwsem(&gdev->rwsem);
+	mutex_init(&gdev->read_mutex);
+	mutex_init(&gdev->write_mutex);
+	init_waitqueue_head(&gdev->read_queue);
+
+	ret = kfifo_alloc(&gdev->read_fifo, GNSS_READ_FIFO_SIZE, GFP_KERNEL);
+	if (ret)
+		goto err_put_device;
+
+	gdev->write_buf = kzalloc(GNSS_WRITE_BUF_SIZE, GFP_KERNEL);
+	if (!gdev->write_buf)
+		goto err_put_device;
+
+	cdev_init(&gdev->cdev, &gnss_fops);
+	gdev->cdev.owner = THIS_MODULE;
+
+	return gdev;
+
+err_put_device:
+	put_device(dev);
+
+	return ERR_PTR(-ENOMEM);
+}
+EXPORT_SYMBOL_GPL(gnss_allocate_device);
+
+void gnss_put_device(struct gnss_device *gdev)
+{
+	put_device(&gdev->dev);
+}
+EXPORT_SYMBOL_GPL(gnss_put_device);
+
+int gnss_register_device(struct gnss_device *gdev)
+{
+	int ret;
+
+	ret = cdev_device_add(&gdev->cdev, &gdev->dev);
+	if (ret) {
+		dev_err(&gdev->dev, "failed to add device: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gnss_register_device);
+
+void gnss_deregister_device(struct gnss_device *gdev)
+{
+	down_write(&gdev->rwsem);
+	gdev->disconnected = true;
+	if (gdev->count) {
+		wake_up_interruptible(&gdev->read_queue);
+		gdev->ops->close(gdev);
+	}
+	up_write(&gdev->rwsem);
+
+	cdev_device_del(&gdev->cdev, &gdev->dev);
+}
+EXPORT_SYMBOL_GPL(gnss_deregister_device);
+
+/*
+ * Caller guarantees serialisation.
+ *
+ * Must not be called for a closed device.
+ */
+int gnss_insert_raw(struct gnss_device *gdev, const unsigned char *buf,
+		size_t count)
+{
+	int ret;
+
+	dev_dbg(&gdev->dev, "%s - count = %zu\n", __func__, count);
+
+	ret = kfifo_in(&gdev->read_fifo, buf, count);
+
+	wake_up_interruptible(&gdev->read_queue);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gnss_insert_raw);
+
+static int __init gnss_module_init(void)
+{
+	int ret;
+
+	ret = alloc_chrdev_region(&gnss_first, 0, GNSS_MINORS, "gnss");
+	if (ret < 0) {
+		pr_err("failed to allocate device numbers: %d\n", ret);
+		return ret;
+	}
+
+	gnss_class = class_create(THIS_MODULE, "gnss");
+	if (IS_ERR(gnss_class)) {
+		ret = PTR_ERR(gnss_class);
+		pr_err("failed to create class: %d\n", ret);
+		goto err_unregister_chrdev;
+	}
+
+	pr_info("GNSS driver registered with major %d\n", MAJOR(gnss_first));
+
+	return 0;
+
+err_unregister_chrdev:
+	unregister_chrdev_region(gnss_first, GNSS_MINORS);
+
+	return ret;
+}
+module_init(gnss_module_init);
+
+static void __exit gnss_module_exit(void)
+{
+	class_destroy(gnss_class);
+	unregister_chrdev_region(gnss_first, GNSS_MINORS);
+	ida_destroy(&gnss_minors);
+}
+module_exit(gnss_module_exit);
+
+MODULE_AUTHOR("Johan Hovold <johan@kernel.org>");
+MODULE_DESCRIPTION("GNSS receiver core");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/gnss.h b/include/linux/gnss.h
new file mode 100644
index 000000000000..cf69cfe4c48d
--- /dev/null
+++ b/include/linux/gnss.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * GNSS receiver support
+ *
+ * Copyright (C) 2018 Johan Hovold <johan@kernel.org>
+ */
+
+#ifndef _LINUX_GNSS_H
+#define _LINUX_GNSS_H
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/kfifo.h>
+#include <linux/mutex.h>
+#include <linux/rwsem.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+
+struct gnss_device;
+
+struct gnss_operations {
+	int (*open)(struct gnss_device *gdev);
+	void (*close)(struct gnss_device *gdev);
+	int (*write_raw)(struct gnss_device *gdev, const unsigned char *buf,
+			size_t count);
+};
+
+struct gnss_device {
+	struct device dev;
+	struct cdev cdev;
+	int id;
+
+	struct rw_semaphore rwsem;
+	const struct gnss_operations *ops;
+	unsigned int count;
+	unsigned int disconnected:1;
+
+	struct mutex read_mutex;
+	struct kfifo read_fifo;
+	wait_queue_head_t read_queue;
+
+	struct mutex write_mutex;
+	char *write_buf;
+};
+
+struct gnss_device *gnss_allocate_device(struct device *parent);
+void gnss_put_device(struct gnss_device *gdev);
+int gnss_register_device(struct gnss_device *gdev);
+void gnss_deregister_device(struct gnss_device *gdev);
+
+int gnss_insert_raw(struct gnss_device *gdev, const unsigned char *buf,
+		size_t count);
+
+static inline void gnss_set_drvdata(struct gnss_device *gdev, void *data)
+{
+	dev_set_drvdata(&gdev->dev, data);
+}
+
+static inline void *gnss_get_drvdata(struct gnss_device *gdev)
+{
+	return dev_get_drvdata(&gdev->dev);
+}
+
+#endif /* _LINUX_GNSS_H */
-- 
2.17.0
