Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966533AbeBNBwW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 20:52:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:56118 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966457AbeBNBv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 20:51:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,510,1511856000";
   d="scan'208";a="34498958"
From: Dongwon Kim <dongwon.kim@intel.com>
To: linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        xen-devel@lists.xenproject.org
Cc: dri-devel@lists.freedesktop.org, dongwon.kim@intel.com,
        mateuszx.potrola@intel.com, sumit.semwal@linaro.org
Subject: [RFC PATCH v2 8/9] hyper_dmabuf: event-polling mechanism for detecting a new hyper_DMABUF
Date: Tue, 13 Feb 2018 17:50:07 -0800
Message-Id: <20180214015008.9513-9-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180214015008.9513-1-dongwon.kim@intel.com>
References: <20180214015008.9513-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New method based on polling for a importing VM to know about a new
hyper_DMABUF exported to it.

For this, the userspace now can poll the device node to check if
there a new event, which is created if there's a new hyper_DMABUF
available in importing VM (just exported).

A poll function call was added to the device driver interface for this
new functionality. Event-generation functionalitywas also implemented in
all other relavant parts of driver.

This "event-polling" mechanism is optional feature and can be enabled
by setting a Kernel config option, "HYPER_DMABUF_EVENT_GEN".

Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Signed-off-by: Mateusz Polrola <mateuszx.potrola@intel.com>
---
 drivers/dma-buf/hyper_dmabuf/Kconfig              |  20 +++
 drivers/dma-buf/hyper_dmabuf/Makefile             |   1 +
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.c   | 146 ++++++++++++++++++++++
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.h   |  11 ++
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_event.c | 122 ++++++++++++++++++
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_event.h |  38 ++++++
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_list.c  |   1 +
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c   |  11 ++
 include/uapi/linux/hyper_dmabuf.h                 |  11 ++
 9 files changed, 361 insertions(+)
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_event.c
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_event.h

diff --git a/drivers/dma-buf/hyper_dmabuf/Kconfig b/drivers/dma-buf/hyper_dmabuf/Kconfig
index 68f3d6ce2c1f..92510731af25 100644
--- a/drivers/dma-buf/hyper_dmabuf/Kconfig
+++ b/drivers/dma-buf/hyper_dmabuf/Kconfig
@@ -20,6 +20,16 @@ config HYPER_DMABUF_SYSFS
 
 	  The location of sysfs is under "...."
 
+config HYPER_DMABUF_EVENT_GEN
+        bool "Enable event-generation and polling operation"
+        default n
+        depends on HYPER_DMABUF
+        help
+          With this config enabled, hyper_dmabuf driver on the importer side
+          generates events and queue those up in the event list whenever a new
+          shared DMA-BUF is available. Events in the list can be retrieved by
+          read operation.
+
 config HYPER_DMABUF_XEN
         bool "Configure hyper_dmabuf for XEN hypervisor"
         default y
@@ -27,4 +37,14 @@ config HYPER_DMABUF_XEN
         help
           Enabling Hyper_DMABUF Backend for XEN hypervisor
 
+config HYPER_DMABUF_XEN_AUTO_RX_CH_ADD
+        bool "Enable automatic rx-ch add with 10 secs interval"
+        default y
+        depends on HYPER_DMABUF && HYPER_DMABUF_XEN
+        help
+          If enabled, driver reads a node in xenstore every 10 seconds
+          to check whether there is any tx comm ch configured by another
+          domain then initialize matched rx comm ch automatically for any
+          existing tx comm chs.
+
 endmenu
diff --git a/drivers/dma-buf/hyper_dmabuf/Makefile b/drivers/dma-buf/hyper_dmabuf/Makefile
index 578a669a0d3e..f573dd5c4054 100644
--- a/drivers/dma-buf/hyper_dmabuf/Makefile
+++ b/drivers/dma-buf/hyper_dmabuf/Makefile
@@ -11,6 +11,7 @@ ifneq ($(KERNELRELEASE),)
 				 hyper_dmabuf_id.o \
 				 hyper_dmabuf_remote_sync.o \
 				 hyper_dmabuf_query.o \
+				 hyper_dmabuf_event.o \
 
 ifeq ($(CONFIG_HYPER_DMABUF_XEN), y)
 	$(TARGET_MODULE)-objs += backends/xen/hyper_dmabuf_xen_comm.o \
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.c
index 3320f9dcc769..087f091ccae9 100644
--- a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.c
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.c
@@ -41,6 +41,7 @@
 #include "hyper_dmabuf_ioctl.h"
 #include "hyper_dmabuf_list.h"
 #include "hyper_dmabuf_id.h"
+#include "hyper_dmabuf_event.h"
 
 #ifdef CONFIG_HYPER_DMABUF_XEN
 #include "backends/xen/hyper_dmabuf_xen_drv.h"
@@ -91,10 +92,138 @@ static int hyper_dmabuf_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+#ifdef CONFIG_HYPER_DMABUF_EVENT_GEN
+
+static unsigned int hyper_dmabuf_event_poll(struct file *filp,
+				     struct poll_table_struct *wait)
+{
+	poll_wait(filp, &hy_drv_priv->event_wait, wait);
+
+	if (!list_empty(&hy_drv_priv->event_list))
+		return POLLIN | POLLRDNORM;
+
+	return 0;
+}
+
+static ssize_t hyper_dmabuf_event_read(struct file *filp, char __user *buffer,
+		size_t count, loff_t *offset)
+{
+	int ret;
+
+	/* only root can read events */
+	if (!capable(CAP_DAC_OVERRIDE)) {
+		dev_err(hy_drv_priv->dev,
+			"Only root can read events\n");
+		return -EPERM;
+	}
+
+	/* make sure user buffer can be written */
+	if (!access_ok(VERIFY_WRITE, buffer, count)) {
+		dev_err(hy_drv_priv->dev,
+			"User buffer can't be written.\n");
+		return -EINVAL;
+	}
+
+	ret = mutex_lock_interruptible(&hy_drv_priv->event_read_lock);
+	if (ret)
+		return ret;
+
+	while (1) {
+		struct hyper_dmabuf_event *e = NULL;
+
+		spin_lock_irq(&hy_drv_priv->event_lock);
+		if (!list_empty(&hy_drv_priv->event_list)) {
+			e = list_first_entry(&hy_drv_priv->event_list,
+					struct hyper_dmabuf_event, link);
+			list_del(&e->link);
+		}
+		spin_unlock_irq(&hy_drv_priv->event_lock);
+
+		if (!e) {
+			if (ret)
+				break;
+
+			if (filp->f_flags & O_NONBLOCK) {
+				ret = -EAGAIN;
+				break;
+			}
+
+			mutex_unlock(&hy_drv_priv->event_read_lock);
+			ret = wait_event_interruptible(hy_drv_priv->event_wait,
+				  !list_empty(&hy_drv_priv->event_list));
+
+			if (ret == 0)
+				ret = mutex_lock_interruptible(
+					&hy_drv_priv->event_read_lock);
+
+			if (ret)
+				return ret;
+		} else {
+			unsigned int length = (sizeof(e->event_data.hdr) +
+						      e->event_data.hdr.size);
+
+			if (length > count - ret) {
+put_back_event:
+				spin_lock_irq(&hy_drv_priv->event_lock);
+				list_add(&e->link, &hy_drv_priv->event_list);
+				spin_unlock_irq(&hy_drv_priv->event_lock);
+				break;
+			}
+
+			if (copy_to_user(buffer + ret, &e->event_data.hdr,
+					 sizeof(e->event_data.hdr))) {
+				if (ret == 0)
+					ret = -EFAULT;
+
+				goto put_back_event;
+			}
+
+			ret += sizeof(e->event_data.hdr);
+
+			if (copy_to_user(buffer + ret, e->event_data.data,
+					 e->event_data.hdr.size)) {
+				/* error while copying void *data */
+
+				struct hyper_dmabuf_event_hdr dummy_hdr = {0};
+
+				ret -= sizeof(e->event_data.hdr);
+
+				/* nullifying hdr of the event in user buffer */
+				if (copy_to_user(buffer + ret, &dummy_hdr,
+						 sizeof(dummy_hdr))) {
+					dev_err(hy_drv_priv->dev,
+						"failed to nullify invalid hdr already in userspace\n");
+				}
+
+				ret = -EFAULT;
+
+				goto put_back_event;
+			}
+
+			ret += e->event_data.hdr.size;
+			hy_drv_priv->pending--;
+			kfree(e);
+		}
+	}
+
+	mutex_unlock(&hy_drv_priv->event_read_lock);
+
+	return ret;
+}
+
+#endif
+
 static const struct file_operations hyper_dmabuf_driver_fops = {
 	.owner = THIS_MODULE,
 	.open = hyper_dmabuf_open,
 	.release = hyper_dmabuf_release,
+
+/* poll and read interfaces are needed only for event-polling */
+#ifdef CONFIG_HYPER_DMABUF_EVENT_GEN
+	.read = hyper_dmabuf_event_read,
+	.poll = hyper_dmabuf_event_poll,
+#endif
+
 	.unlocked_ioctl = hyper_dmabuf_ioctl,
 };
 
@@ -194,6 +323,18 @@ static int __init hyper_dmabuf_drv_init(void)
 	}
 #endif
 
+#ifdef CONFIG_HYPER_DMABUF_EVENT_GEN
+	mutex_init(&hy_drv_priv->event_read_lock);
+	spin_lock_init(&hy_drv_priv->event_lock);
+
+	/* Initialize event queue */
+	INIT_LIST_HEAD(&hy_drv_priv->event_list);
+	init_waitqueue_head(&hy_drv_priv->event_wait);
+
+	/* resetting number of pending events */
+	hy_drv_priv->pending = 0;
+#endif
+
 	if (hy_drv_priv->bknd_ops->init) {
 		ret = hy_drv_priv->bknd_ops->init();
 
@@ -250,6 +391,11 @@ static void hyper_dmabuf_drv_exit(void)
 	if (hy_drv_priv->id_queue)
 		hyper_dmabuf_free_hid_list();
 
+#ifdef CONFIG_HYPER_DMABUF_EVENT_GEN
+	/* clean up event queue */
+	hyper_dmabuf_events_release();
+#endif
+
 	mutex_unlock(&hy_drv_priv->lock);
 
 	dev_info(hy_drv_priv->dev,
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.h b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.h
index 46119d762430..282a507b33bc 100644
--- a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.h
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.h
@@ -32,6 +32,11 @@
 
 struct hyper_dmabuf_req;
 
+struct hyper_dmabuf_event {
+	struct hyper_dmabuf_event_data event_data;
+	struct list_head link;
+};
+
 struct hyper_dmabuf_private {
 	struct device *dev;
 
@@ -54,6 +59,12 @@ struct hyper_dmabuf_private {
 	/* flag that shows whether backend is initialized */
 	bool initialized;
 
+	wait_queue_head_t event_wait;
+	struct list_head event_list;
+
+	spinlock_t event_lock;
+	struct mutex event_read_lock;
+
 	/* # of pending events */
 	int pending;
 };
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_event.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_event.c
new file mode 100644
index 000000000000..942a1bb78755
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_event.c
@@ -0,0 +1,122 @@
+/*
+ * Copyright © 2018 Intel Corporation
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ *
+ * Authors:
+ *    Dongwon Kim <dongwon.kim@intel.com>
+ *    Mateusz Polrola <mateuszx.potrola@intel.com>
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include "hyper_dmabuf_drv.h"
+#include "hyper_dmabuf_struct.h"
+#include "hyper_dmabuf_list.h"
+#include "hyper_dmabuf_event.h"
+
+static void send_event(struct hyper_dmabuf_event *e)
+{
+	struct hyper_dmabuf_event *oldest;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&hy_drv_priv->event_lock, irqflags);
+
+	/* check current number of event then if it hits the max num allowed
+	 * then remove the oldest event in the list
+	 */
+	if (hy_drv_priv->pending > MAX_DEPTH_EVENT_QUEUE - 1) {
+		oldest = list_first_entry(&hy_drv_priv->event_list,
+				struct hyper_dmabuf_event, link);
+		list_del(&oldest->link);
+		hy_drv_priv->pending--;
+		kfree(oldest);
+	}
+
+	list_add_tail(&e->link,
+		      &hy_drv_priv->event_list);
+
+	hy_drv_priv->pending++;
+
+	wake_up_interruptible(&hy_drv_priv->event_wait);
+
+	spin_unlock_irqrestore(&hy_drv_priv->event_lock, irqflags);
+}
+
+void hyper_dmabuf_events_release(void)
+{
+	struct hyper_dmabuf_event *e, *et;
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&hy_drv_priv->event_lock, irqflags);
+
+	list_for_each_entry_safe(e, et, &hy_drv_priv->event_list,
+				 link) {
+		list_del(&e->link);
+		kfree(e);
+		hy_drv_priv->pending--;
+	}
+
+	if (hy_drv_priv->pending) {
+		dev_err(hy_drv_priv->dev,
+			"possible leak on event_list\n");
+	}
+
+	spin_unlock_irqrestore(&hy_drv_priv->event_lock, irqflags);
+}
+
+int hyper_dmabuf_import_event(hyper_dmabuf_id_t hid)
+{
+	struct hyper_dmabuf_event *e;
+	struct imported_sgt_info *imported;
+
+	imported = hyper_dmabuf_find_imported(hid);
+
+	if (!imported) {
+		dev_err(hy_drv_priv->dev,
+			"can't find imported_sgt_info in the list\n");
+		return -EINVAL;
+	}
+
+	e = kzalloc(sizeof(*e), GFP_KERNEL);
+
+	if (!e)
+		return -ENOMEM;
+
+	e->event_data.hdr.event_type = HYPER_DMABUF_NEW_IMPORT;
+	e->event_data.hdr.hid = hid;
+	e->event_data.data = (void *)imported->priv;
+	e->event_data.hdr.size = imported->sz_priv;
+
+	send_event(e);
+
+	dev_dbg(hy_drv_priv->dev,
+		"event number = %d :", hy_drv_priv->pending);
+
+	dev_dbg(hy_drv_priv->dev,
+		"generating events for {%d, %d, %d, %d}\n",
+		imported->hid.id, imported->hid.rng_key[0],
+		imported->hid.rng_key[1], imported->hid.rng_key[2]);
+
+	return 0;
+}
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_event.h b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_event.h
new file mode 100644
index 000000000000..8f61198e623c
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_event.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright © 2018 Intel Corporation
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __HYPER_DMABUF_EVENT_H__
+#define __HYPER_DMABUF_EVENT_H__
+
+#define MAX_DEPTH_EVENT_QUEUE 32
+
+enum hyper_dmabuf_event_type {
+	HYPER_DMABUF_NEW_IMPORT = 0x10000,
+};
+
+void hyper_dmabuf_events_release(void);
+
+int hyper_dmabuf_import_event(hyper_dmabuf_id_t hid);
+
+#endif /* __HYPER_DMABUF_EVENT_H__ */
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_list.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_list.c
index f2f65a8ec47f..30c3af65fcde 100644
--- a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_list.c
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_list.c
@@ -36,6 +36,7 @@
 #include "hyper_dmabuf_drv.h"
 #include "hyper_dmabuf_list.h"
 #include "hyper_dmabuf_id.h"
+#include "hyper_dmabuf_event.h"
 
 DECLARE_HASHTABLE(hyper_dmabuf_hash_imported, MAX_ENTRY_IMPORTED);
 DECLARE_HASHTABLE(hyper_dmabuf_hash_exported, MAX_ENTRY_EXPORTED);
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c
index 1592d5cfaa52..8f2cf7ea827d 100644
--- a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c
@@ -35,6 +35,7 @@
 #include "hyper_dmabuf_drv.h"
 #include "hyper_dmabuf_msg.h"
 #include "hyper_dmabuf_remote_sync.h"
+#include "hyper_dmabuf_event.h"
 #include "hyper_dmabuf_list.h"
 
 struct cmd_process {
@@ -179,6 +180,11 @@ static void cmd_process_work(struct work_struct *work)
 			/* updating priv data */
 			memcpy(imported->priv, &req->op[9], req->op[8]);
 
+#ifdef CONFIG_HYPER_DMABUF_EVENT_GEN
+			/* generating import event */
+			hyper_dmabuf_import_event(imported->hid);
+#endif
+
 			break;
 		}
 
@@ -219,6 +225,11 @@ static void cmd_process_work(struct work_struct *work)
 		imported->valid = true;
 		hyper_dmabuf_register_imported(imported);
 
+#ifdef CONFIG_HYPER_DMABUF_EVENT_GEN
+		/* generating import event */
+		hyper_dmabuf_import_event(imported->hid);
+#endif
+
 		break;
 
 	case HYPER_DMABUF_OPS_TO_REMOTE:
diff --git a/include/uapi/linux/hyper_dmabuf.h b/include/uapi/linux/hyper_dmabuf.h
index 4f8e8ac0375b..dd73db9bf37d 100644
--- a/include/uapi/linux/hyper_dmabuf.h
+++ b/include/uapi/linux/hyper_dmabuf.h
@@ -32,6 +32,17 @@ typedef struct {
 	int rng_key[3]; /* 12bytes long random number */
 } hyper_dmabuf_id_t;
 
+struct hyper_dmabuf_event_hdr {
+	int event_type; /* one type only for now - new import */
+	hyper_dmabuf_id_t hid; /* hyper_dmabuf_id of specific hyper_dmabuf */
+	int size; /* size of data */
+};
+
+struct hyper_dmabuf_event_data {
+	struct hyper_dmabuf_event_hdr hdr;
+	void *data; /* private data */
+};
+
 #define IOCTL_HYPER_DMABUF_TX_CH_SETUP \
 _IOC(_IOC_NONE, 'G', 0, sizeof(struct ioctl_hyper_dmabuf_tx_ch_setup))
 struct ioctl_hyper_dmabuf_tx_ch_setup {
-- 
2.16.1
