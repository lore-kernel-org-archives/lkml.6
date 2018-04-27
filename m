Return-Path: <sdias@qualcomm.com>
X-Google-Smtp-Source: AB8JxZpPLu3j6GuWxP1hje288RDlXBugTNvJFPhtkrK0u2t7SQlJcDIRFm/I/MWvlkP5yjAjA7gh
ARC-Seal: i=1; a=rsa-sha256; t=1524795827; cv=none;
        d=google.com; s=arc-20160816;
        b=0R6Dl/UrBBJfP/ZytJ1+oWy7h+XqhhMhDwUAiBQSIzhVTQrc02lJaYJelD8i6unWVO
         WqLd8CRht+1YYhzaz99JXfELuxwZWrgc7RQuY25cAEMalk9Nz1CXYrTycwov1aIlxPai
         mkEoCNAO+7Ap0bnIT5rIaHBNb/cKO5kP2QPIpn/j+zIoSGU1wcS46xswb7eP59AwcxYh
         hgDR2P17JgQgHK7ePLCJ3kk/sA7hIKUZ8qg0xnPt97B4ig7YMuUB8caX9vOtOUFLM8We
         TUpUDzMFalcjkyIy1r+oFr1H3JOBI1t1ILyODFB09BqfjXCJoo4lr4wox0A3KdsN9bpp
         gfFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=1QRvK4wl6geJi+4onfpmT7nO/oVnDIie5SuRFV97cr4=;
        b=f8xsG0dXH4qPlT/sKbMzhCowTdk+Ut3EOPTwdBrPK/qyCheribSVtwhoRId+S95Lwj
         gNZ1i0VzW17xU4ZnbllznIav3iTIh9CWYOpgVQ2IWgGcYBDjaKeM4EpiN1yIZ5GFHkow
         g6xYDJOejBijwJHp7pCHA7aM/i+OyY7H6Wo29P89sFpmIpJbrayj9eOKGpXx1gcucKwi
         Osqxb3eP5OKF4Qht1BQnYU/zgnrB64usMjryKrAjzw0FmmVbyMc+NlUG5ya0BNxHG5yN
         4/y4cZCP1nJaDi6alVcAPUumXnZowjpGe8dfWERjaM6f2bLXSJfcR4KEX/4WnrZbFJEK
         74nQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sdias@qualcomm.com designates 65.197.215.72 as permitted sender) smtp.mailfrom=sdias@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sdias@qualcomm.com designates 65.197.215.72 as permitted sender) smtp.mailfrom=sdias@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,333,1520924400";
   d="scan'208";a="126208375"
X-IronPort-AV: E=McAfee;i="5900,7806,8875"; a="71568992"
From: Sujeev Dias <sdias@codeaurora.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Sujeev Dias <sdias@codeaurora.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Tony Truong <truong@codeaurora.org>
Subject: [PATCH v1 4/4] mhi_bus: dev: uci: add user space interface driver
Date: Thu, 26 Apr 2018 19:23:31 -0700
Message-Id: <1524795811-21399-5-git-send-email-sdias@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598864310335409607?=
X-GMAIL-MSGID: =?utf-8?q?1598864310335409607?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This module allows user space clients to transfer data
between external modem and host using standard file
operations.

Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
---
 drivers/bus/mhi/devices/Kconfig   |   9 +
 drivers/bus/mhi/devices/Makefile  |   1 +
 drivers/bus/mhi/devices/mhi_uci.c | 662 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 672 insertions(+)
 create mode 100644 drivers/bus/mhi/devices/mhi_uci.c

diff --git a/drivers/bus/mhi/devices/Kconfig b/drivers/bus/mhi/devices/Kconfig
index 40f964d..83b9673 100644
--- a/drivers/bus/mhi/devices/Kconfig
+++ b/drivers/bus/mhi/devices/Kconfig
@@ -7,4 +7,13 @@ config MHI_NETDEV
 	  MHI based net device driver for transferring IP traffic
 	  between host and modem. By enabling this driver, clients
 	  can transfer data using standard network interface.
+
+config MHI_UCI
+       tristate "MHI UCI"
+       depends on MHI_BUS
+       help
+	  MHI based uci driver is for transferring data between host and
+	  modem using standard file operations from user space. Open, read,
+	  write, ioctl, and close operations are supported by this driver.
+
 endmenu
diff --git a/drivers/bus/mhi/devices/Makefile b/drivers/bus/mhi/devices/Makefile
index ee12a64..300eed1 100644
--- a/drivers/bus/mhi/devices/Makefile
+++ b/drivers/bus/mhi/devices/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_MHI_NETDEV) +=mhi_netdev.o
+obj-$(CONFIG_MHI_UCI) +=mhi_uci.o
diff --git a/drivers/bus/mhi/devices/mhi_uci.c b/drivers/bus/mhi/devices/mhi_uci.c
new file mode 100644
index 0000000..11b7b1f
--- /dev/null
+++ b/drivers/bus/mhi/devices/mhi_uci.c
@@ -0,0 +1,662 @@
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/uaccess.h>
+#include <linux/mhi.h>
+
+#define DEVICE_NAME "mhi"
+#define MHI_UCI_DRIVER_NAME "mhi_uci"
+
+struct uci_chan {
+	wait_queue_head_t wq;
+	spinlock_t lock;
+	struct list_head pending; /* user space waiting to read */
+	struct uci_buf *cur_buf; /* current buffer user space reading */
+	size_t rx_size;
+};
+
+struct uci_buf {
+	void *data;
+	size_t len;
+	struct list_head node;
+};
+
+struct uci_dev {
+	struct list_head node;
+	dev_t devt;
+	struct device *dev;
+	struct mhi_device *mhi_dev;
+	const char *chan;
+	struct mutex mutex; /* sync open and close */
+	struct uci_chan ul_chan;
+	struct uci_chan dl_chan;
+	size_t mtu;
+	int ref_count;
+	bool enabled;
+};
+
+struct mhi_uci_drv {
+	struct list_head head;
+	struct mutex lock;
+	struct class *class;
+	int major;
+	dev_t dev_t;
+};
+
+enum MHI_DEBUG_LEVEL msg_lvl = MHI_MSG_LVL_ERROR;
+
+#ifdef CONFIG_MHI_DEBUG
+
+#define MSG_VERB(fmt, ...) do { \
+		if (msg_lvl <= MHI_MSG_LVL_VERBOSE) \
+			pr_err("[D][%s] " fmt, __func__, ##__VA_ARGS__); \
+	} while (0)
+
+#else
+
+#define MSG_VERB(fmt, ...)
+
+#endif
+
+#define MSG_LOG(fmt, ...) do { \
+		if (msg_lvl <= MHI_MSG_LVL_INFO) \
+			pr_err("[I][%s] " fmt, __func__, ##__VA_ARGS__); \
+	} while (0)
+
+#define MSG_ERR(fmt, ...) do { \
+		if (msg_lvl <= MHI_MSG_LVL_ERROR) \
+			pr_err("[E][%s] " fmt, __func__, ##__VA_ARGS__); \
+	} while (0)
+
+#define MAX_UCI_DEVICES (64)
+
+static DECLARE_BITMAP(uci_minors, MAX_UCI_DEVICES);
+static struct mhi_uci_drv mhi_uci_drv;
+
+static int mhi_queue_inbound(struct uci_dev *uci_dev)
+{
+	struct mhi_device *mhi_dev = uci_dev->mhi_dev;
+	int nr_trbs = mhi_get_no_free_descriptors(mhi_dev, DMA_FROM_DEVICE);
+	size_t mtu = uci_dev->mtu;
+	void *buf;
+	struct uci_buf *uci_buf;
+	int ret = -EIO, i;
+
+	for (i = 0; i < nr_trbs; i++) {
+		buf = kmalloc(mtu + sizeof(*uci_buf), GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+
+		uci_buf = buf + mtu;
+		uci_buf->data = buf;
+
+		MSG_VERB("Allocated buf %d of %d size %ld\n", i, nr_trbs, mtu);
+
+		ret = mhi_queue_transfer(mhi_dev, DMA_FROM_DEVICE, buf, mtu,
+					 MHI_EOT);
+		if (ret) {
+			kfree(buf);
+			MSG_ERR("Failed to queue buffer %d\n", i);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static long mhi_uci_ioctl(struct file *file,
+			  unsigned int cmd,
+			  unsigned long arg)
+{
+	struct uci_dev *uci_dev = file->private_data;
+	struct mhi_device *mhi_dev = uci_dev->mhi_dev;
+	long ret = -ERESTARTSYS;
+
+	mutex_lock(&uci_dev->mutex);
+	if (uci_dev->enabled)
+		ret = mhi_ioctl(mhi_dev, cmd, arg);
+	mutex_unlock(&uci_dev->mutex);
+
+	return ret;
+}
+
+static int mhi_uci_release(struct inode *inode, struct file *file)
+{
+	struct uci_dev *uci_dev = file->private_data;
+
+	mutex_lock(&uci_dev->mutex);
+	uci_dev->ref_count--;
+	if (!uci_dev->ref_count) {
+		struct uci_buf *itr, *tmp;
+		struct uci_chan *uci_chan;
+
+		MSG_LOG("Last client left, closing node\n");
+
+		if (uci_dev->enabled)
+			mhi_unprepare_from_transfer(uci_dev->mhi_dev);
+
+		/* clean inbound channel */
+		uci_chan = &uci_dev->dl_chan;
+		list_for_each_entry_safe(itr, tmp, &uci_chan->pending, node) {
+			list_del(&itr->node);
+			kfree(itr->data);
+		}
+		if (uci_chan->cur_buf)
+			kfree(uci_chan->cur_buf->data);
+
+		uci_chan->cur_buf = NULL;
+
+		if (!uci_dev->enabled) {
+			MSG_LOG("Node is deleted, freeing dev node\n");
+			mutex_unlock(&uci_dev->mutex);
+			mutex_destroy(&uci_dev->mutex);
+			clear_bit(MINOR(uci_dev->devt), uci_minors);
+			kfree(uci_dev);
+			return 0;
+		}
+	}
+
+	mutex_unlock(&uci_dev->mutex);
+
+	MSG_LOG("exit: ref_count:%d\n", uci_dev->ref_count);
+
+	return 0;
+}
+
+static unsigned int mhi_uci_poll(struct file *file, poll_table *wait)
+{
+	struct uci_dev *uci_dev = file->private_data;
+	struct mhi_device *mhi_dev = uci_dev->mhi_dev;
+	struct uci_chan *uci_chan;
+	unsigned int mask = 0;
+
+	poll_wait(file, &uci_dev->dl_chan.wq, wait);
+	poll_wait(file, &uci_dev->ul_chan.wq, wait);
+
+	uci_chan = &uci_dev->dl_chan;
+	spin_lock_bh(&uci_chan->lock);
+	if (!uci_dev->enabled) {
+		mask = POLLERR;
+	} else if (!list_empty(&uci_chan->pending) || uci_chan->cur_buf) {
+		MSG_VERB("Client can read from node\n");
+		mask |= POLLIN | POLLRDNORM;
+	}
+	spin_unlock_bh(&uci_chan->lock);
+
+	uci_chan = &uci_dev->ul_chan;
+	spin_lock_bh(&uci_chan->lock);
+	if (!uci_dev->enabled) {
+		mask |= POLLERR;
+	} else if (mhi_get_no_free_descriptors(mhi_dev, DMA_TO_DEVICE) > 0) {
+		MSG_VERB("Client can write to node\n");
+		mask |= POLLOUT | POLLWRNORM;
+	}
+	spin_unlock_bh(&uci_chan->lock);
+
+	MSG_LOG("Client attempted to poll, returning mask 0x%x\n", mask);
+
+	return mask;
+}
+
+static ssize_t mhi_uci_write(struct file *file,
+			     const char __user *buf,
+			     size_t count,
+			     loff_t *offp)
+{
+	struct uci_dev *uci_dev = file->private_data;
+	struct mhi_device *mhi_dev = uci_dev->mhi_dev;
+	struct uci_chan *uci_chan = &uci_dev->ul_chan;
+	size_t bytes_xfered = 0;
+	int ret;
+
+	if (!buf || !count)
+		return -EINVAL;
+
+	/* confirm channel is active */
+	spin_lock_bh(&uci_chan->lock);
+	if (!uci_dev->enabled) {
+		spin_unlock_bh(&uci_chan->lock);
+		return -ERESTARTSYS;
+	}
+
+	MSG_VERB("Enter: to xfer:%lu bytes\n", count);
+
+	while (count) {
+		size_t xfer_size;
+		void *kbuf;
+		enum MHI_FLAGS flags;
+
+		spin_unlock_bh(&uci_chan->lock);
+
+		/* wait for free descriptors */
+		ret = wait_event_interruptible(uci_chan->wq,
+			(!uci_dev->enabled) ||
+			mhi_get_no_free_descriptors
+					       (mhi_dev, DMA_TO_DEVICE) > 0);
+
+		if (ret == -ERESTARTSYS) {
+			MSG_LOG("Exit signal caught for node\n");
+			return -ERESTARTSYS;
+		}
+
+		xfer_size = min_t(size_t, count, uci_dev->mtu);
+		kbuf = kmalloc(xfer_size, GFP_KERNEL);
+		if (!kbuf) {
+			MSG_ERR("Failed to allocate memory %lu\n", xfer_size);
+			return -ENOMEM;
+		}
+
+		ret = copy_from_user(kbuf, buf, xfer_size);
+		if (unlikely(ret)) {
+			kfree(kbuf);
+			return ret;
+		}
+
+		spin_lock_bh(&uci_chan->lock);
+		flags = (count - xfer_size) ? MHI_EOB : MHI_EOT;
+		if (uci_dev->enabled)
+			ret = mhi_queue_transfer(mhi_dev, DMA_TO_DEVICE, kbuf,
+						 xfer_size, flags);
+		else
+			ret = -ERESTARTSYS;
+
+		if (ret) {
+			kfree(kbuf);
+			goto sys_interrupt;
+		}
+
+		bytes_xfered += xfer_size;
+		count -= xfer_size;
+		buf += xfer_size;
+	}
+
+	spin_unlock_bh(&uci_chan->lock);
+	MSG_VERB("Exit: Number of bytes xferred:%lu\n", bytes_xfered);
+
+	return bytes_xfered;
+
+sys_interrupt:
+	spin_unlock_bh(&uci_chan->lock);
+
+	return ret;
+}
+
+static ssize_t mhi_uci_read(struct file *file,
+			    char __user *buf,
+			    size_t count,
+			    loff_t *ppos)
+{
+	struct uci_dev *uci_dev = file->private_data;
+	struct mhi_device *mhi_dev = uci_dev->mhi_dev;
+	struct uci_chan *uci_chan = &uci_dev->dl_chan;
+	struct uci_buf *uci_buf;
+	char *ptr;
+	size_t to_copy;
+	int ret = 0;
+
+	if (!buf)
+		return -EINVAL;
+
+	MSG_VERB("Client provided buf len:%lu\n", count);
+
+	/* confirm channel is active */
+	spin_lock_bh(&uci_chan->lock);
+	if (!uci_dev->enabled) {
+		spin_unlock_bh(&uci_chan->lock);
+		return -ERESTARTSYS;
+	}
+
+	/* No data available to read, wait */
+	if (!uci_chan->cur_buf && list_empty(&uci_chan->pending)) {
+		MSG_VERB("No data available to read waiting\n");
+
+		spin_unlock_bh(&uci_chan->lock);
+		ret = wait_event_interruptible(uci_chan->wq,
+				(!uci_dev->enabled ||
+				 !list_empty(&uci_chan->pending)));
+		if (ret == -ERESTARTSYS) {
+			MSG_LOG("Exit signal caught for node\n");
+			return -ERESTARTSYS;
+		}
+
+		spin_lock_bh(&uci_chan->lock);
+		if (!uci_dev->enabled) {
+			MSG_LOG("node is disabled\n");
+			ret = -ERESTARTSYS;
+			goto read_error;
+		}
+	}
+
+	/* new read, get the next descriptor from the list */
+	if (!uci_chan->cur_buf) {
+		uci_buf = list_first_entry_or_null(&uci_chan->pending,
+						   struct uci_buf, node);
+		if (unlikely(!uci_buf)) {
+			ret = -EIO;
+			goto read_error;
+		}
+
+		list_del(&uci_buf->node);
+		uci_chan->cur_buf = uci_buf;
+		uci_chan->rx_size = uci_buf->len;
+		MSG_VERB("Got pkt of size:%zu\n", uci_chan->rx_size);
+	}
+
+	uci_buf = uci_chan->cur_buf;
+	spin_unlock_bh(&uci_chan->lock);
+
+	/* Copy the buffer to user space */
+	to_copy = min_t(size_t, count, uci_chan->rx_size);
+	ptr = uci_buf->data + (uci_buf->len - uci_chan->rx_size);
+	ret = copy_to_user(buf, ptr, to_copy);
+	if (ret)
+		return ret;
+
+	MSG_VERB("Copied %lu of %lu bytes\n", to_copy, uci_chan->rx_size);
+	uci_chan->rx_size -= to_copy;
+
+	/* we finished with this buffer, queue it back to hardware */
+	if (!uci_chan->rx_size) {
+		spin_lock_bh(&uci_chan->lock);
+		uci_chan->cur_buf = NULL;
+
+		if (uci_dev->enabled)
+			ret = mhi_queue_transfer(mhi_dev, DMA_FROM_DEVICE,
+						 uci_buf->data, uci_dev->mtu,
+						 MHI_EOT);
+		else
+			ret = -ERESTARTSYS;
+
+		if (ret) {
+			MSG_ERR("Failed to recycle element\n");
+			kfree(uci_buf->data);
+			goto read_error;
+		}
+
+		spin_unlock_bh(&uci_chan->lock);
+	}
+
+	MSG_VERB("Returning %lu bytes\n", to_copy);
+
+	return to_copy;
+
+read_error:
+	spin_unlock_bh(&uci_chan->lock);
+
+	return ret;
+}
+
+static int mhi_uci_open(struct inode *inode, struct file *filp)
+{
+	struct uci_dev *uci_dev;
+	int ret = -EIO;
+	struct uci_buf *buf_itr, *tmp;
+	struct uci_chan *dl_chan;
+
+	mutex_lock(&mhi_uci_drv.lock);
+	list_for_each_entry(uci_dev, &mhi_uci_drv.head, node) {
+		if (uci_dev->devt == inode->i_rdev) {
+			ret = 0;
+			break;
+		}
+	}
+	mutex_unlock(&mhi_uci_drv.lock);
+
+	/* could not find a minor node */
+	if (ret)
+		return ret;
+
+	mutex_lock(&uci_dev->mutex);
+	if (!uci_dev->enabled) {
+		MSG_ERR("Node exist, but not in active state!\n");
+		goto error_open_chan;
+	}
+
+	uci_dev->ref_count++;
+
+	MSG_LOG("Node open, ref counts %u\n", uci_dev->ref_count);
+
+	if (uci_dev->ref_count == 1) {
+		MSG_LOG("Starting channel\n");
+		ret = mhi_prepare_for_transfer(uci_dev->mhi_dev);
+		if (ret) {
+			MSG_ERR("Error starting transfer channels\n");
+			uci_dev->ref_count--;
+			goto error_open_chan;
+		}
+
+		ret = mhi_queue_inbound(uci_dev);
+		if (ret)
+			goto error_rx_queue;
+	}
+
+	filp->private_data = uci_dev;
+	mutex_unlock(&uci_dev->mutex);
+
+	return 0;
+
+ error_rx_queue:
+	dl_chan = &uci_dev->dl_chan;
+	mhi_unprepare_from_transfer(uci_dev->mhi_dev);
+	list_for_each_entry_safe(buf_itr, tmp, &dl_chan->pending, node) {
+		list_del(&buf_itr->node);
+		kfree(buf_itr->data);
+	}
+
+ error_open_chan:
+	mutex_unlock(&uci_dev->mutex);
+
+	return ret;
+}
+
+static const struct file_operations mhidev_fops = {
+	.open = mhi_uci_open,
+	.release = mhi_uci_release,
+	.read = mhi_uci_read,
+	.write = mhi_uci_write,
+	.poll = mhi_uci_poll,
+	.unlocked_ioctl = mhi_uci_ioctl,
+};
+
+static void mhi_uci_remove(struct mhi_device *mhi_dev)
+{
+	struct uci_dev *uci_dev = mhi_device_get_devdata(mhi_dev);
+
+	MSG_LOG("Enter\n");
+
+	/* disable the node */
+	mutex_lock(&uci_dev->mutex);
+	spin_lock_irq(&uci_dev->dl_chan.lock);
+	spin_lock_irq(&uci_dev->ul_chan.lock);
+	uci_dev->enabled = false;
+	spin_unlock_irq(&uci_dev->ul_chan.lock);
+	spin_unlock_irq(&uci_dev->dl_chan.lock);
+	wake_up(&uci_dev->dl_chan.wq);
+	wake_up(&uci_dev->ul_chan.wq);
+
+	/* delete the node to prevent new opens */
+	device_destroy(mhi_uci_drv.class, uci_dev->devt);
+	uci_dev->dev = NULL;
+	mutex_lock(&mhi_uci_drv.lock);
+	list_del(&uci_dev->node);
+	mutex_unlock(&mhi_uci_drv.lock);
+
+	/* safe to free memory only if all file nodes are closed */
+	if (!uci_dev->ref_count) {
+		mutex_unlock(&uci_dev->mutex);
+		mutex_destroy(&uci_dev->mutex);
+		clear_bit(MINOR(uci_dev->devt), uci_minors);
+		kfree(uci_dev);
+		return;
+	}
+
+	mutex_unlock(&uci_dev->mutex);
+	MSG_LOG("Exit\n");
+}
+
+static int mhi_uci_probe(struct mhi_device *mhi_dev,
+			 const struct mhi_device_id *id)
+{
+	struct uci_dev *uci_dev;
+	int minor;
+	int dir;
+
+	uci_dev = kzalloc(sizeof(*uci_dev), GFP_KERNEL);
+	if (!uci_dev)
+		return -ENOMEM;
+
+	mutex_init(&uci_dev->mutex);
+	uci_dev->mhi_dev = mhi_dev;
+
+	minor = find_first_zero_bit(uci_minors, MAX_UCI_DEVICES);
+	if (minor >= MAX_UCI_DEVICES) {
+		kfree(uci_dev);
+		return -ENOSPC;
+	}
+
+	mutex_lock(&uci_dev->mutex);
+	mutex_lock(&mhi_uci_drv.lock);
+
+	uci_dev->devt = MKDEV(mhi_uci_drv.major, minor);
+	uci_dev->dev = device_create(mhi_uci_drv.class, &mhi_dev->dev,
+				     uci_dev->devt, uci_dev,
+				     DEVICE_NAME "_%04x_%02u.%02u.%02u%s%d",
+				     mhi_dev->dev_id, mhi_dev->domain,
+				     mhi_dev->bus, mhi_dev->slot, "_pipe_",
+				     mhi_dev->ul_chan_id);
+	set_bit(minor, uci_minors);
+
+	for (dir = 0; dir < 2; dir++) {
+		struct uci_chan *uci_chan = (dir) ?
+			&uci_dev->ul_chan : &uci_dev->dl_chan;
+		spin_lock_init(&uci_chan->lock);
+		init_waitqueue_head(&uci_chan->wq);
+		INIT_LIST_HEAD(&uci_chan->pending);
+	};
+
+	uci_dev->mtu = id->driver_data;
+	mhi_device_set_devdata(mhi_dev, uci_dev);
+	uci_dev->enabled = true;
+
+	list_add(&uci_dev->node, &mhi_uci_drv.head);
+	mutex_unlock(&mhi_uci_drv.lock);
+	mutex_unlock(&uci_dev->mutex);
+
+	MSG_LOG("channel:%s successfully probed\n", mhi_dev->chan_name);
+
+	return 0;
+};
+
+static void mhi_ul_xfer_cb(struct mhi_device *mhi_dev,
+			   struct mhi_result *mhi_result)
+{
+	struct uci_dev *uci_dev = mhi_device_get_devdata(mhi_dev);
+	struct uci_chan *uci_chan = &uci_dev->ul_chan;
+
+	MSG_VERB("status:%d xfer_len:%zu\n", mhi_result->transaction_status,
+		 mhi_result->bytes_xferd);
+
+	kfree(mhi_result->buf_addr);
+	if (!mhi_result->transaction_status)
+		wake_up(&uci_chan->wq);
+}
+
+static void mhi_dl_xfer_cb(struct mhi_device *mhi_dev,
+			   struct mhi_result *mhi_result)
+{
+	struct uci_dev *uci_dev = mhi_device_get_devdata(mhi_dev);
+	struct uci_chan *uci_chan = &uci_dev->dl_chan;
+	unsigned long flags;
+	struct uci_buf *buf;
+
+	MSG_VERB("status:%d receive_len:%zu\n", mhi_result->transaction_status,
+		 mhi_result->bytes_xferd);
+
+	if (mhi_result->transaction_status == -ENOTCONN) {
+		kfree(mhi_result->buf_addr);
+		return;
+	}
+
+	spin_lock_irqsave(&uci_chan->lock, flags);
+	buf = mhi_result->buf_addr + uci_dev->mtu;
+	buf->data = mhi_result->buf_addr;
+	buf->len = mhi_result->bytes_xferd;
+	list_add_tail(&buf->node, &uci_chan->pending);
+	spin_unlock_irqrestore(&uci_chan->lock, flags);
+
+	wake_up(&uci_chan->wq);
+}
+
+/* .driver_data stores max mtu */
+static const struct mhi_device_id mhi_uci_match_table[] = {
+	{ .chan = "LOOPBACK", .driver_data = 0x1000 },
+	{ .chan = "SAHARA", .driver_data = 0x8000 },
+	{ .chan = "EFS", .driver_data = 0x1000 },
+	{ .chan = "QMI0", .driver_data = 0x1000 },
+	{ .chan = "QMI1", .driver_data = 0x1000 },
+	{ .chan = "TF", .driver_data = 0x1000 },
+	{ .chan = "BL", .driver_data = 0x1000 },
+	{ .chan = "DUN", .driver_data = 0x1000 },
+	{ NULL },
+};
+
+static struct mhi_driver mhi_uci_driver = {
+	.id_table = mhi_uci_match_table,
+	.remove = mhi_uci_remove,
+	.probe = mhi_uci_probe,
+	.ul_xfer_cb = mhi_ul_xfer_cb,
+	.dl_xfer_cb = mhi_dl_xfer_cb,
+	.driver = {
+		.name = MHI_UCI_DRIVER_NAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int mhi_uci_init(void)
+{
+	int ret;
+
+	ret = register_chrdev(0, MHI_UCI_DRIVER_NAME, &mhidev_fops);
+	if (ret < 0)
+		return ret;
+
+	mhi_uci_drv.major = ret;
+	mhi_uci_drv.class = class_create(THIS_MODULE, MHI_UCI_DRIVER_NAME);
+	if (IS_ERR(mhi_uci_drv.class))
+		return -ENODEV;
+
+	mutex_init(&mhi_uci_drv.lock);
+	INIT_LIST_HEAD(&mhi_uci_drv.head);
+
+	ret = mhi_driver_register(&mhi_uci_driver);
+	if (ret)
+		class_destroy(mhi_uci_drv.class);
+
+	return ret;
+}
+
+module_init(mhi_uci_init);
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("MHI_UCI");
+MODULE_DESCRIPTION("MHI UCI Driver");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
