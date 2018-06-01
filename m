Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbeFAMuq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:50:46 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:56619 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbeFAMun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:50:43 -0400
X-Originating-IP: 96.22.60.141
Date: Fri, 1 Jun 2018 08:50:37 -0400
From: Hugo Lefeuvre <hle@owl.eu.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernelnewbies@kernelnewbies.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: add rw semaphore fixing concurrency issues
Message-ID: <20180601125037.GA2339@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a rw semaphore fixing potential NULL pointer dereferences in the
pi433 driver.

If pi433_release and pi433_ioctl are concurrently called,
pi433_release might set filp->private_data to NULL while pi433_ioctl
is still accessing it, leading to NULL pointer dereference. This issue
might also affect pi433_write and pi433_read.

The newly introduced semaphore makes sure that filp->private_data
will not be freed by pi433_release (writer) as long as pi433_write,
pi433_read or pi433_ioctl (readers) are still executing.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
 drivers/staging/pi433/pi433_if.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index d1e0ddbc79ce..ce83139cc795 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -39,6 +39,7 @@
 #include <linux/kfifo.h>
 #include <linux/errno.h>
 #include <linux/mutex.h>
+#include <linux/rwsem.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/interrupt.h>
@@ -116,6 +117,7 @@ struct pi433_device {
 struct pi433_instance {
 	struct pi433_device	*device;
 	struct pi433_tx_cfg	tx_cfg;
+	struct rw_semaphore     instance_sem;
 };
 
 /*-------------------------------------------------------------------------*/
@@ -778,6 +780,7 @@ pi433_read(struct file *filp, char __user *buf, size_t size, loff_t *f_pos)
 	if (size > MAX_MSG_SIZE)
 		return -EMSGSIZE;
 
+	down_read(&instance->instance_sem);
 	instance = filp->private_data;
 	device = instance->device;
 
@@ -785,6 +788,7 @@ pi433_read(struct file *filp, char __user *buf, size_t size, loff_t *f_pos)
 	mutex_lock(&device->rx_lock);
 	if (device->rx_active) {
 		mutex_unlock(&device->rx_lock);
+		up_read(&instance->instance_sem);
 		return -EAGAIN;
 	}
 
@@ -805,9 +809,11 @@ pi433_read(struct file *filp, char __user *buf, size_t size, loff_t *f_pos)
 	if (bytes_received > 0) {
 		retval = copy_to_user(buf, device->rx_buffer, bytes_received);
 		if (retval)
+			up_read(&instance->instance_sem);
 			return -EFAULT;
 	}
 
+	up_read(&instance->instance_sem);
 	return bytes_received;
 }
 
@@ -820,11 +826,13 @@ pi433_write(struct file *filp, const char __user *buf,
 	int                     retval;
 	unsigned int		copied;
 
+	down_read(&instance->instance_sem);
 	instance = filp->private_data;
 	device = instance->device;
 
 	/* check, whether internal buffer (tx thread) is big enough for requested size */
 	if (count > MAX_MSG_SIZE)
+		up_read(&instance->instance_sem);
 		return -EMSGSIZE;
 
 	/* write the following sequence into fifo:
@@ -851,6 +859,7 @@ pi433_write(struct file *filp, const char __user *buf,
 	/* start transfer */
 	wake_up_interruptible(&device->tx_wait_queue);
 	dev_dbg(device->dev, "write: generated new msg with %d bytes.", copied);
+	up_read(&instance->instance_sem);
 
 	return copied;
 
@@ -858,6 +867,7 @@ pi433_write(struct file *filp, const char __user *buf,
 	dev_dbg(device->dev, "write to fifo failed: 0x%x", retval);
 	kfifo_reset(&device->tx_fifo); // TODO: maybe find a solution, not to discard already stored, valid entries
 	mutex_unlock(&device->tx_fifo_lock);
+	up_read(&instance->instance_sem);
 	return -EAGAIN;
 }
 
@@ -873,29 +883,31 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	if (_IOC_TYPE(cmd) != PI433_IOC_MAGIC)
 		return -ENOTTY;
 
-	/* TODO? guard against device removal before, or while,
-	 * we issue this ioctl. --> device_get()
-	 */
+	down_read(&instance->instance_sem);
 	instance = filp->private_data;
 	device = instance->device;
 
 	if (!device)
+		up_read(&instance->instance_sem);
 		return -ESHUTDOWN;
 
 	switch (cmd) {
 	case PI433_IOC_RD_TX_CFG:
 		if (copy_to_user(argp, &instance->tx_cfg,
 				 sizeof(struct pi433_tx_cfg)))
+			up_read(&instance->instance_sem);
 			return -EFAULT;
 		break;
 	case PI433_IOC_WR_TX_CFG:
 		if (copy_from_user(&instance->tx_cfg, argp,
 				   sizeof(struct pi433_tx_cfg)))
+			up_read(&instance->instance_sem);
 			return -EFAULT;
 		break;
 	case PI433_IOC_RD_RX_CFG:
 		if (copy_to_user(argp, &device->rx_cfg,
 				 sizeof(struct pi433_rx_cfg)))
+			up_read(&instance->instance_sem);
 			return -EFAULT;
 		break;
 	case PI433_IOC_WR_RX_CFG:
@@ -904,21 +916,26 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		/* during pendig read request, change of config not allowed */
 		if (device->rx_active) {
 			mutex_unlock(&device->rx_lock);
+			up_read(&instance->instance_sem);
 			return -EAGAIN;
 		}
 
 		if (copy_from_user(&device->rx_cfg, argp,
 				   sizeof(struct pi433_rx_cfg))) {
 			mutex_unlock(&device->rx_lock);
+			up_read(&instance->instance_sem);
 			return -EFAULT;
 		}
 
 		mutex_unlock(&device->rx_lock);
+		up_read(&instance->instance_sem);
 		break;
 	default:
+		up_read(&instance->instance_sem);
 		retval = -EINVAL;
 	}
 
+	up_read(&instance->instance_sem);
 	return retval;
 }
 
@@ -964,6 +981,7 @@ static int pi433_open(struct inode *inode, struct file *filp)
 	/* setup instance data*/
 	instance->device = device;
 	instance->tx_cfg.bit_rate = 4711;
+	init_rwsem(&instance->instance_sem);
 	// TODO: fill instance->tx_cfg;
 
 	/* instance data as context */
@@ -978,6 +996,7 @@ static int pi433_release(struct inode *inode, struct file *filp)
 	struct pi433_instance	*instance;
 	struct pi433_device	*device;
 
+	down_write(&instance->instance_sem);
 	instance = filp->private_data;
 	device = instance->device;
 	kfree(instance);
-- 
2.17.1
