Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAF4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411A6208E1
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411A6208E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933506AbeGIUOl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:14:41 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:21907 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933025AbeGIUOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:14:36 -0400
X-IronPort-AV: E=Sophos;i="5.51,330,1526367600"; 
   d="scan'208";a="39007204"
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by labrats.qualcomm.com with ESMTP; 09 Jul 2018 13:08:25 -0700
X-IronPort-AV: E=McAfee;i="5900,7806,8949"; a="115965966"
Received: from sdias-linux.qualcomm.com (HELO sdias-linux1.qualcomm.com) ([192.168.140.71])
  by ironmsg04-sd.qualcomm.com with ESMTP; 09 Jul 2018 13:08:25 -0700
Received: by sdias-linux1.qualcomm.com (Postfix, from userid 84243)
        id 225A3150B; Mon,  9 Jul 2018 13:08:25 -0700 (PDT)
From:   Sujeev Dias <sdias@codeaurora.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Sujeev Dias <sdias@codeaurora.org>,
        Tony Truong <truong@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: [PATCH v2 7/7] mhi_bus: dev: uci: add user space interface driver
Date:   Mon,  9 Jul 2018 13:08:14 -0700
Message-Id: <1531166894-30984-8-git-send-email-sdias@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1531166894-30984-1-git-send-email-sdias@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This module allows user space clients to transfer data
between external modem and host using standard file
operations.

Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
Reviewed-by: Tony Truong <truong@codeaurora.org>
Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
---
 arch/arm64/configs/defconfig      |   1 +
 drivers/bus/Kconfig               |   1 +
 drivers/bus/mhi/Makefile          |   3 +-
 drivers/bus/mhi/devices/Kconfig   |  13 +
 drivers/bus/mhi/devices/Makefile  |   1 +
 drivers/bus/mhi/devices/mhi_uci.c | 590 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 608 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bus/mhi/devices/Kconfig
 create mode 100644 drivers/bus/mhi/devices/Makefile
 create mode 100644 drivers/bus/mhi/devices/mhi_uci.c

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fd36426..7f68d706 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -169,6 +169,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
 CONFIG_MHI_BUS=y
 CONFIG_MHI_QCOM=y
+CONFIG_MHI_UCI=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 8c6827a..cb10366 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -181,5 +181,6 @@ config MHI_BUS
 
 source "drivers/bus/fsl-mc/Kconfig"
 source drivers/bus/mhi/controllers/Kconfig
+source drivers/bus/mhi/devices/Kconfig
 
 endmenu
diff --git a/drivers/bus/mhi/Makefile b/drivers/bus/mhi/Makefile
index 3458ba3..2382e04 100644
--- a/drivers/bus/mhi/Makefile
+++ b/drivers/bus/mhi/Makefile
@@ -4,4 +4,5 @@
 
 # core layer
 obj-y += core/
-obj-y += controllers/
\ No newline at end of file
+obj-y += controllers/
+obj-y += devices/
diff --git a/drivers/bus/mhi/devices/Kconfig b/drivers/bus/mhi/devices/Kconfig
new file mode 100644
index 0000000..45cd742
--- /dev/null
+++ b/drivers/bus/mhi/devices/Kconfig
@@ -0,0 +1,13 @@
+menu "MHI device support"
+
+config MHI_UCI
+       tristate "MHI UCI"
+       depends on MHI_BUS
+       help
+	  MHI based uci driver is for transferring data between host and
+	  modem using standard file operations from user space. Open, read,
+	  write, ioctl, and close operations are supported by this driver.
+	  Please check mhi_uci_match_table for all supported channels that
+	  are exposed to userspace.
+
+endmenu
diff --git a/drivers/bus/mhi/devices/Makefile b/drivers/bus/mhi/devices/Makefile
new file mode 100644
index 0000000..ddc0613
--- /dev/null
+++ b/drivers/bus/mhi/devices/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MHI_UCI) +=mhi_uci.o
diff --git a/drivers/bus/mhi/devices/mhi_uci.c b/drivers/bus/mhi/devices/mhi_uci.c
new file mode 100644
index 0000000..ad60a15
--- /dev/null
+++ b/drivers/bus/mhi/devices/mhi_uci.c
@@ -0,0 +1,590 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
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
+		ret = mhi_queue_transfer(mhi_dev, DMA_FROM_DEVICE, buf, mtu,
+					 MHI_EOT);
+		if (ret) {
+			kfree(buf);
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
+	if (!uci_dev->enabled)
+		mask = POLLERR;
+	else if (!list_empty(&uci_chan->pending) || uci_chan->cur_buf)
+		mask |= POLLIN | POLLRDNORM;
+
+	spin_unlock_bh(&uci_chan->lock);
+
+	uci_chan = &uci_dev->ul_chan;
+	spin_lock_bh(&uci_chan->lock);
+	if (!uci_dev->enabled)
+		mask |= POLLERR;
+	else if (mhi_get_no_free_descriptors(mhi_dev, DMA_TO_DEVICE) > 0)
+		mask |= POLLOUT | POLLWRNORM;
+
+	spin_unlock_bh(&uci_chan->lock);
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
+	int ret, nr_avail;
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
+			(nr_avail = mhi_get_no_free_descriptors(mhi_dev,
+							DMA_TO_DEVICE)) > 0);
+
+		if (ret == -ERESTARTSYS || !uci_dev->enabled)
+			return -ERESTARTSYS;
+
+		xfer_size = min_t(size_t, count, uci_dev->mtu);
+		kbuf = kmalloc(xfer_size, GFP_KERNEL);
+		if (!kbuf)
+			return -ENOMEM;
+
+		ret = copy_from_user(kbuf, buf, xfer_size);
+		if (unlikely(ret)) {
+			kfree(kbuf);
+			return ret;
+		}
+
+		spin_lock_bh(&uci_chan->lock);
+
+		/* if ring is full after this force EOT */
+		if (nr_avail > 1 && (count - xfer_size))
+			flags = MHI_CHAIN;
+		else
+			flags = MHI_EOT;
+
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
+	/* confirm channel is active */
+	spin_lock_bh(&uci_chan->lock);
+	if (!uci_dev->enabled) {
+		spin_unlock_bh(&uci_chan->lock);
+		return -ERESTARTSYS;
+	}
+
+	/* No data available to read, wait */
+	if (!uci_chan->cur_buf && list_empty(&uci_chan->pending)) {
+
+		spin_unlock_bh(&uci_chan->lock);
+		ret = wait_event_interruptible(uci_chan->wq,
+				(!uci_dev->enabled ||
+				 !list_empty(&uci_chan->pending)));
+		if (ret == -ERESTARTSYS)
+			return -ERESTARTSYS;
+
+		spin_lock_bh(&uci_chan->lock);
+		if (!uci_dev->enabled) {
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
+			kfree(uci_buf->data);
+			goto read_error;
+		}
+
+		spin_unlock_bh(&uci_chan->lock);
+	}
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
+	if (!uci_dev->enabled)
+		goto error_open_chan;
+
+	uci_dev->ref_count++;
+
+	if (uci_dev->ref_count == 1) {
+		ret = mhi_prepare_for_transfer(uci_dev->mhi_dev);
+		if (ret) {
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
+	}
+
+	uci_dev->mtu = min_t(size_t, id->driver_data, mhi_dev->mtu);
+	mhi_device_set_devdata(mhi_dev, uci_dev);
+	uci_dev->enabled = true;
+
+	list_add(&uci_dev->node, &mhi_uci_drv.head);
+	mutex_unlock(&mhi_uci_drv.lock);
+	mutex_unlock(&uci_dev->mutex);
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
+	{},
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

