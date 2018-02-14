Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966578AbeBNBxJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 20:53:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:56116 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966401AbeBNBvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 20:51:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,510,1511856000";
   d="scan'208";a="34498934"
From: Dongwon Kim <dongwon.kim@intel.com>
To: linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        xen-devel@lists.xenproject.org
Cc: dri-devel@lists.freedesktop.org, dongwon.kim@intel.com,
        mateuszx.potrola@intel.com, sumit.semwal@linaro.org
Subject: [RFC PATCH v2 1/9] hyper_dmabuf: initial upload of hyper_dmabuf drv core framework
Date: Tue, 13 Feb 2018 17:50:00 -0800
Message-Id: <20180214015008.9513-2-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180214015008.9513-1-dongwon.kim@intel.com>
References: <20180214015008.9513-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upload of intial version of core framework in hyper_DMABUF driver
enabling DMA_BUF exchange between two different VMs in virtualized
platform based on Hypervisor such as XEN.

Hyper_DMABUF drv's primary role is to import a DMA_BUF from originator
then re-export it to another Linux VM so that it can be mapped and
accessed in there.

This driver has two layers, one is so called, "core framework", which
contains driver interface and core functions handling export/import of
new hyper_DMABUF and its maintenance. This part of the driver is
independent from Hypervisor so can work as is with any Hypervisor.

The other layer is called "Hypervisor Backend". This layer represents
the interface between "core framework" and actual Hypervisor, handling
memory sharing and communication. Not like "core framework", every
Hypervisor needs it's own backend interface designed using its native
mechanism for memory sharing and inter-VM communication.

This patch contains the first part, "core framework", which consists of
7 source files and 11 header files. Some brief description of these
source code are attached below:

hyper_dmabuf_drv.c

- Linux driver interface and initialization/cleaning-up routines

hyper_dmabuf_ioctl.c

- IOCTLs calls for export/import of DMA-BUF comm channel's creation and
  destruction.

hyper_dmabuf_sgl_proc.c

- Provides methods to managing DMA-BUF for exporing and importing. For
  exporting, extraction of pages, sharing pages via procedures in
  "Backend" and notifying importing VM exist. For importing, all
  operations related to the reconstruction of DMA-BUF (with shared
  pages) on importer's side are defined.

hyper_dmabuf_ops.c

- Standard DMA-BUF operations for hyper_DMABUF reconstructed on
  importer's side.

hyper_dmabuf_list.c

- Lists for storing exported and imported hyper_DMABUF to keep track of
  remote usage of hyper_DMABUF currently being shared.

hyper_dmabuf_msg.c

- Defines messages exchanged between VMs (exporter and importer) and
  function calls for sending and parsing (when received) those.

hyper_dmabuf_id.c

- Contains methods to generate and manage "hyper_DMABUF id" for each
  hyper_DMABUF being exported. It is a global handle for a hyper_DMABUF,
  which another VM needs to know to import it.

hyper_dmabuf_struct.h

- Contains data structures of importer or exporter hyper_DMABUF

include/uapi/linux/hyper_dmabuf.h

- Contains definition of data types and structures referenced by user
  application to interact with driver

Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Signed-off-by: Mateusz Polrola <mateuszx.potrola@intel.com>
---
 drivers/dma-buf/Kconfig                            |   2 +
 drivers/dma-buf/Makefile                           |   1 +
 drivers/dma-buf/hyper_dmabuf/Kconfig               |  23 +
 drivers/dma-buf/hyper_dmabuf/Makefile              |  34 ++
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.c    | 254 ++++++++
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.h    | 111 ++++
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_id.c     | 135 +++++
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_id.h     |  53 ++
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.c  | 672 +++++++++++++++++++++
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.h  |  52 ++
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_list.c   | 294 +++++++++
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_list.h   |  73 +++
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c    | 320 ++++++++++
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.h    |  87 +++
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ops.c    | 264 ++++++++
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ops.h    |  34 ++
 .../dma-buf/hyper_dmabuf/hyper_dmabuf_sgl_proc.c   | 256 ++++++++
 .../dma-buf/hyper_dmabuf/hyper_dmabuf_sgl_proc.h   |  43 ++
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_struct.h | 131 ++++
 include/uapi/linux/hyper_dmabuf.h                  |  87 +++
 20 files changed, 2926 insertions(+)
 create mode 100644 drivers/dma-buf/hyper_dmabuf/Kconfig
 create mode 100644 drivers/dma-buf/hyper_dmabuf/Makefile
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.c
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.h
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_id.c
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_id.h
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.c
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.h
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_list.c
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_list.h
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.h
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ops.c
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ops.h
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_sgl_proc.c
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_sgl_proc.h
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_struct.h
 create mode 100644 include/uapi/linux/hyper_dmabuf.h

diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index ed3b785bae37..09ccac1768e3 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -30,4 +30,6 @@ config SW_SYNC
 	  WARNING: improper use of this can result in deadlocking kernel
 	  drivers from userspace. Intended for test and debug only.
 
+source "drivers/dma-buf/hyper_dmabuf/Kconfig"
+
 endmenu
diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
index c33bf8863147..445749babb19 100644
--- a/drivers/dma-buf/Makefile
+++ b/drivers/dma-buf/Makefile
@@ -1,3 +1,4 @@
 obj-y := dma-buf.o dma-fence.o dma-fence-array.o reservation.o seqno-fence.o
 obj-$(CONFIG_SYNC_FILE)		+= sync_file.o
 obj-$(CONFIG_SW_SYNC)		+= sw_sync.o sync_debug.o
+obj-$(CONFIG_HYPER_DMABUF)      += ./hyper_dmabuf/
diff --git a/drivers/dma-buf/hyper_dmabuf/Kconfig b/drivers/dma-buf/hyper_dmabuf/Kconfig
new file mode 100644
index 000000000000..5ebf516d65eb
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/Kconfig
@@ -0,0 +1,23 @@
+menu "HYPER_DMABUF"
+
+config HYPER_DMABUF
+	tristate "Enables hyper dmabuf driver"
+	default y
+	help
+	  This option enables Hyper_DMABUF driver.
+
+	  This driver works as abstraction layer that export and import
+	  DMA_BUF from/to another virtual OS running on the same HW platform
+	  powered by a hypervisor
+
+config HYPER_DMABUF_SYSFS
+	bool "Enable sysfs information about hyper DMA buffers"
+	default y
+	depends on HYPER_DMABUF
+	help
+	  Expose run-time information about currently imported and exported buffers
+	  registered in EXPORT and IMPORT list in Hyper_DMABUF driver.
+
+	  The location of sysfs is under "...."
+
+endmenu
diff --git a/drivers/dma-buf/hyper_dmabuf/Makefile b/drivers/dma-buf/hyper_dmabuf/Makefile
new file mode 100644
index 000000000000..3908522b396a
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/Makefile
@@ -0,0 +1,34 @@
+TARGET_MODULE:=hyper_dmabuf
+
+# If we running by kernel building system
+ifneq ($(KERNELRELEASE),)
+	$(TARGET_MODULE)-objs := hyper_dmabuf_drv.o \
+                                 hyper_dmabuf_ioctl.o \
+                                 hyper_dmabuf_list.o \
+				 hyper_dmabuf_sgl_proc.o \
+				 hyper_dmabuf_ops.o \
+				 hyper_dmabuf_msg.o \
+				 hyper_dmabuf_id.o \
+
+obj-$(CONFIG_HYPER_DMABUF) := $(TARGET_MODULE).o
+
+# If we are running without kernel build system
+else
+BUILDSYSTEM_DIR?=../../../
+PWD:=$(shell pwd)
+
+all :
+# run kernel build system to make module
+$(MAKE) -C $(BUILDSYSTEM_DIR) M=$(PWD) modules
+
+clean:
+# run kernel build system to cleanup in current directory
+$(MAKE) -C $(BUILDSYSTEM_DIR) M=$(PWD) clean
+
+load:
+	insmod ./$(TARGET_MODULE).ko
+
+unload:
+	rmmod ./$(TARGET_MODULE).ko
+
+endif
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.c
new file mode 100644
index 000000000000..18c1cd735ea2
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.c
@@ -0,0 +1,254 @@
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
+ * SPDX-License-Identifier: (MIT OR GPL-2.0)
+ *
+ * Authors:
+ *    Dongwon Kim <dongwon.kim@intel.com>
+ *    Mateusz Polrola <mateuszx.potrola@intel.com>
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/miscdevice.h>
+#include <linux/workqueue.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/uaccess.h>
+#include <linux/poll.h>
+#include <linux/dma-buf.h>
+#include "hyper_dmabuf_drv.h"
+#include "hyper_dmabuf_ioctl.h"
+#include "hyper_dmabuf_list.h"
+#include "hyper_dmabuf_id.h"
+
+MODULE_LICENSE("GPL and additional rights");
+MODULE_AUTHOR("Intel Corporation");
+
+struct hyper_dmabuf_private *hy_drv_priv;
+
+static void force_free(struct exported_sgt_info *exported,
+		       void *attr)
+{
+	struct ioctl_hyper_dmabuf_unexport unexport_attr;
+	struct file *filp = (struct file *)attr;
+
+	if (!filp || !exported)
+		return;
+
+	if (exported->filp == filp) {
+		dev_dbg(hy_drv_priv->dev,
+			"Forcefully releasing buffer {id:%d key:%d %d %d}\n",
+			 exported->hid.id, exported->hid.rng_key[0],
+			 exported->hid.rng_key[1], exported->hid.rng_key[2]);
+
+		unexport_attr.hid = exported->hid;
+		unexport_attr.delay_ms = 0;
+
+		hyper_dmabuf_unexport_ioctl(filp, &unexport_attr);
+	}
+}
+
+static int hyper_dmabuf_open(struct inode *inode, struct file *filp)
+{
+	int ret = 0;
+
+	/* Do not allow exclusive open */
+	if (filp->f_flags & O_EXCL)
+		return -EBUSY;
+
+	return ret;
+}
+
+static int hyper_dmabuf_release(struct inode *inode, struct file *filp)
+{
+	hyper_dmabuf_foreach_exported(force_free, filp);
+
+	return 0;
+}
+
+static const struct file_operations hyper_dmabuf_driver_fops = {
+	.owner = THIS_MODULE,
+	.open = hyper_dmabuf_open,
+	.release = hyper_dmabuf_release,
+	.unlocked_ioctl = hyper_dmabuf_ioctl,
+};
+
+static struct miscdevice hyper_dmabuf_miscdev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "hyper_dmabuf",
+	.fops = &hyper_dmabuf_driver_fops,
+};
+
+static int register_device(void)
+{
+	int ret = 0;
+
+	ret = misc_register(&hyper_dmabuf_miscdev);
+
+	if (ret) {
+		pr_err("hyper_dmabuf: driver can't be registered\n");
+		return ret;
+	}
+
+	hy_drv_priv->dev = hyper_dmabuf_miscdev.this_device;
+
+	/* TODO: Check if there is a different way to initialize dma mask */
+	dma_coerce_mask_and_coherent(hy_drv_priv->dev, DMA_BIT_MASK(64));
+
+	return ret;
+}
+
+static void unregister_device(void)
+{
+	dev_info(hy_drv_priv->dev,
+		"hyper_dmabuf: %s is called\n", __func__);
+
+	misc_deregister(&hyper_dmabuf_miscdev);
+}
+
+static int __init hyper_dmabuf_drv_init(void)
+{
+	int ret = 0;
+
+	pr_notice("hyper_dmabuf_starting: Initialization started\n");
+
+	hy_drv_priv = kcalloc(1, sizeof(struct hyper_dmabuf_private),
+			      GFP_KERNEL);
+
+	if (!hy_drv_priv)
+		return -ENOMEM;
+
+	ret = register_device();
+	if (ret < 0) {
+		kfree(hy_drv_priv);
+		return ret;
+	}
+
+	hy_drv_priv->bknd_ops = NULL;
+
+	if (hy_drv_priv->bknd_ops == NULL) {
+		pr_err("Hyper_dmabuf: no backend found\n");
+		kfree(hy_drv_priv);
+		return -1;
+	}
+
+	mutex_init(&hy_drv_priv->lock);
+
+	mutex_lock(&hy_drv_priv->lock);
+
+	hy_drv_priv->initialized = false;
+
+	dev_info(hy_drv_priv->dev,
+		 "initializing database for imported/exported dmabufs\n");
+
+	hy_drv_priv->work_queue = create_workqueue("hyper_dmabuf_wqueue");
+
+	ret = hyper_dmabuf_table_init();
+	if (ret < 0) {
+		dev_err(hy_drv_priv->dev,
+			"fail to init table for exported/imported entries\n");
+		mutex_unlock(&hy_drv_priv->lock);
+		kfree(hy_drv_priv);
+		return ret;
+	}
+
+#ifdef CONFIG_HYPER_DMABUF_SYSFS
+	ret = hyper_dmabuf_register_sysfs(hy_drv_priv->dev);
+	if (ret < 0) {
+		dev_err(hy_drv_priv->dev,
+			"failed to initialize sysfs\n");
+		mutex_unlock(&hy_drv_priv->lock);
+		kfree(hy_drv_priv);
+		return ret;
+	}
+#endif
+
+	if (hy_drv_priv->bknd_ops->init) {
+		ret = hy_drv_priv->bknd_ops->init();
+
+		if (ret < 0) {
+			dev_dbg(hy_drv_priv->dev,
+				"failed to initialize backend.\n");
+			mutex_unlock(&hy_drv_priv->lock);
+			kfree(hy_drv_priv);
+			return ret;
+		}
+	}
+
+	hy_drv_priv->domid = hy_drv_priv->bknd_ops->get_vm_id();
+
+	ret = hy_drv_priv->bknd_ops->init_comm_env();
+	if (ret < 0) {
+		dev_dbg(hy_drv_priv->dev,
+			"failed to initialize comm-env.\n");
+	} else {
+		hy_drv_priv->initialized = true;
+	}
+
+	mutex_unlock(&hy_drv_priv->lock);
+
+	dev_info(hy_drv_priv->dev,
+		"Finishing up initialization of hyper_dmabuf drv\n");
+
+	/* interrupt for comm should be registered here: */
+	return ret;
+}
+
+static void hyper_dmabuf_drv_exit(void)
+{
+#ifdef CONFIG_HYPER_DMABUF_SYSFS
+	hyper_dmabuf_unregister_sysfs(hy_drv_priv->dev);
+#endif
+
+	mutex_lock(&hy_drv_priv->lock);
+
+	/* hash tables for export/import entries and ring_infos */
+	hyper_dmabuf_table_destroy();
+
+	hy_drv_priv->bknd_ops->destroy_comm();
+
+	if (hy_drv_priv->bknd_ops->cleanup) {
+		hy_drv_priv->bknd_ops->cleanup();
+	};
+
+	/* destroy workqueue */
+	if (hy_drv_priv->work_queue)
+		destroy_workqueue(hy_drv_priv->work_queue);
+
+	/* destroy id_queue */
+	if (hy_drv_priv->id_queue)
+		hyper_dmabuf_free_hid_list();
+
+	mutex_unlock(&hy_drv_priv->lock);
+
+	dev_info(hy_drv_priv->dev,
+		 "hyper_dmabuf driver: Exiting\n");
+
+	kfree(hy_drv_priv);
+
+	unregister_device();
+}
+
+module_init(hyper_dmabuf_drv_init);
+module_exit(hyper_dmabuf_drv_exit);
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.h b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.h
new file mode 100644
index 000000000000..46119d762430
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_drv.h
@@ -0,0 +1,111 @@
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
+ * SPDX-License-Identifier: (MIT OR GPL-2.0)
+ *
+ */
+
+#ifndef __LINUX_HYPER_DMABUF_DRV_H__
+#define __LINUX_HYPER_DMABUF_DRV_H__
+
+#include <linux/device.h>
+#include <linux/hyper_dmabuf.h>
+
+struct hyper_dmabuf_req;
+
+struct hyper_dmabuf_private {
+	struct device *dev;
+
+	/* VM(domain) id of current VM instance */
+	int domid;
+
+	/* workqueue dedicated to hyper_dmabuf driver */
+	struct workqueue_struct *work_queue;
+
+	/* list of reusable hyper_dmabuf_ids */
+	struct list_reusable_id *id_queue;
+
+	/* backend ops - hypervisor specific */
+	struct hyper_dmabuf_bknd_ops *bknd_ops;
+
+	/* device global lock */
+	/* TODO: might need a lock per resource (e.g. EXPORT LIST) */
+	struct mutex lock;
+
+	/* flag that shows whether backend is initialized */
+	bool initialized;
+
+	/* # of pending events */
+	int pending;
+};
+
+struct list_reusable_id {
+	hyper_dmabuf_id_t hid;
+	struct list_head list;
+};
+
+struct hyper_dmabuf_bknd_ops {
+	/* backend initialization routine (optional) */
+	int (*init)(void);
+
+	/* backend cleanup routine (optional) */
+	int (*cleanup)(void);
+
+	/* retreiving id of current virtual machine */
+	int (*get_vm_id)(void);
+
+	/* get pages shared via hypervisor-specific method */
+	int (*share_pages)(struct page **pages, int vm_id,
+			   int nents, void **refs_info);
+
+	/* make shared pages unshared via hypervisor specific method */
+	int (*unshare_pages)(void **refs_info, int nents);
+
+	/* map remotely shared pages on importer's side via
+	 * hypervisor-specific method
+	 */
+	struct page ** (*map_shared_pages)(unsigned long ref, int vm_id,
+					   int nents, void **refs_info);
+
+	/* unmap and free shared pages on importer's side via
+	 * hypervisor-specific method
+	 */
+	int (*unmap_shared_pages)(void **refs_info, int nents);
+
+	/* initialize communication environment */
+	int (*init_comm_env)(void);
+
+	void (*destroy_comm)(void);
+
+	/* upstream ch setup (receiving and responding) */
+	int (*init_rx_ch)(int vm_id);
+
+	/* downstream ch setup (transmitting and parsing responses) */
+	int (*init_tx_ch)(int vm_id);
+
+	int (*send_req)(int vm_id, struct hyper_dmabuf_req *req, int wait);
+};
+
+/* exporting global drv private info */
+extern struct hyper_dmabuf_private *hy_drv_priv;
+
+#endif /* __LINUX_HYPER_DMABUF_DRV_H__ */
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_id.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_id.c
new file mode 100644
index 000000000000..f2e994a4957d
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_id.c
@@ -0,0 +1,135 @@
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
+ * SPDX-License-Identifier: (MIT OR GPL-2.0)
+ *
+ * Authors:
+ *    Dongwon Kim <dongwon.kim@intel.com>
+ *    Mateusz Polrola <mateuszx.potrola@intel.com>
+ *
+ */
+
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/random.h>
+#include "hyper_dmabuf_drv.h"
+#include "hyper_dmabuf_id.h"
+
+void hyper_dmabuf_store_hid(hyper_dmabuf_id_t hid)
+{
+	struct list_reusable_id *reusable_head = hy_drv_priv->id_queue;
+	struct list_reusable_id *new_reusable;
+
+	new_reusable = kmalloc(sizeof(*new_reusable), GFP_KERNEL);
+
+	if (!new_reusable)
+		return;
+
+	new_reusable->hid = hid;
+
+	list_add(&new_reusable->list, &reusable_head->list);
+}
+
+static hyper_dmabuf_id_t get_reusable_hid(void)
+{
+	struct list_reusable_id *reusable_head = hy_drv_priv->id_queue;
+	hyper_dmabuf_id_t hid = {-1, {0, 0, 0} };
+
+	/* check there is reusable id */
+	if (!list_empty(&reusable_head->list)) {
+		reusable_head = list_first_entry(&reusable_head->list,
+						 struct list_reusable_id,
+						 list);
+
+		list_del(&reusable_head->list);
+		hid = reusable_head->hid;
+		kfree(reusable_head);
+	}
+
+	return hid;
+}
+
+void hyper_dmabuf_free_hid_list(void)
+{
+	struct list_reusable_id *reusable_head = hy_drv_priv->id_queue;
+	struct list_reusable_id *temp_head;
+
+	if (reusable_head) {
+		/* freeing mem space all reusable ids in the stack */
+		while (!list_empty(&reusable_head->list)) {
+			temp_head = list_first_entry(&reusable_head->list,
+						     struct list_reusable_id,
+						     list);
+			list_del(&temp_head->list);
+			kfree(temp_head);
+		}
+
+		/* freeing head */
+		kfree(reusable_head);
+	}
+}
+
+hyper_dmabuf_id_t hyper_dmabuf_get_hid(void)
+{
+	static int count;
+	hyper_dmabuf_id_t hid;
+	struct list_reusable_id *reusable_head;
+
+	/* first call to hyper_dmabuf_get_id */
+	if (count == 0) {
+		reusable_head = kmalloc(sizeof(*reusable_head), GFP_KERNEL);
+
+		if (!reusable_head)
+			return (hyper_dmabuf_id_t){-1, {0, 0, 0} };
+
+		/* list head has an invalid count */
+		reusable_head->hid.id = -1;
+		INIT_LIST_HEAD(&reusable_head->list);
+		hy_drv_priv->id_queue = reusable_head;
+	}
+
+	hid = get_reusable_hid();
+
+	/*creating a new H-ID only if nothing in the reusable id queue
+	 * and count is less than maximum allowed
+	 */
+	if (hid.id == -1 && count < HYPER_DMABUF_ID_MAX)
+		hid.id = HYPER_DMABUF_ID_CREATE(hy_drv_priv->domid, count++);
+
+	/* random data embedded in the id for security */
+	get_random_bytes(&hid.rng_key[0], 12);
+
+	return hid;
+}
+
+bool hyper_dmabuf_hid_keycomp(hyper_dmabuf_id_t hid1, hyper_dmabuf_id_t hid2)
+{
+	int i;
+
+	/* compare keys */
+	for (i = 0; i < 3; i++) {
+		if (hid1.rng_key[i] != hid2.rng_key[i])
+			return false;
+	}
+
+	return true;
+}
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_id.h b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_id.h
new file mode 100644
index 000000000000..11f530e2c8f6
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_id.h
@@ -0,0 +1,53 @@
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
+ * SPDX-License-Identifier: (MIT OR GPL-2.0)
+ *
+ */
+
+#ifndef __HYPER_DMABUF_ID_H__
+#define __HYPER_DMABUF_ID_H__
+
+#define HYPER_DMABUF_ID_CREATE(domid, cnt) \
+	((((domid) & 0xFF) << 24) | ((cnt) & 0xFFFFFF))
+
+#define HYPER_DMABUF_DOM_ID(hid) \
+	(((hid.id) >> 24) & 0xFF)
+
+/* currently maximum number of buffers shared
+ * at any given moment is limited to 1000
+ */
+#define HYPER_DMABUF_ID_MAX 1000
+
+/* adding freed hid to the reusable list */
+void hyper_dmabuf_store_hid(hyper_dmabuf_id_t hid);
+
+/* freeing the reusasble list */
+void hyper_dmabuf_free_hid_list(void);
+
+/* getting a hid available to use. */
+hyper_dmabuf_id_t hyper_dmabuf_get_hid(void);
+
+/* comparing two different hid */
+bool hyper_dmabuf_hid_keycomp(hyper_dmabuf_id_t hid1, hyper_dmabuf_id_t hid2);
+
+#endif /*__HYPER_DMABUF_ID_H*/
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.c
new file mode 100644
index 000000000000..020a5590a254
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.c
@@ -0,0 +1,672 @@
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
+ * SPDX-License-Identifier: (MIT OR GPL-2.0)
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
+#include <linux/uaccess.h>
+#include <linux/dma-buf.h>
+#include "hyper_dmabuf_drv.h"
+#include "hyper_dmabuf_id.h"
+#include "hyper_dmabuf_struct.h"
+#include "hyper_dmabuf_ioctl.h"
+#include "hyper_dmabuf_list.h"
+#include "hyper_dmabuf_msg.h"
+#include "hyper_dmabuf_sgl_proc.h"
+#include "hyper_dmabuf_ops.h"
+
+static int hyper_dmabuf_tx_ch_setup_ioctl(struct file *filp, void *data)
+{
+	struct ioctl_hyper_dmabuf_tx_ch_setup *tx_ch_attr;
+	struct hyper_dmabuf_bknd_ops *bknd_ops = hy_drv_priv->bknd_ops;
+	int ret = 0;
+
+	if (!data) {
+		dev_err(hy_drv_priv->dev, "user data is NULL\n");
+		return -EINVAL;
+	}
+	tx_ch_attr = (struct ioctl_hyper_dmabuf_tx_ch_setup *)data;
+
+	ret = bknd_ops->init_tx_ch(tx_ch_attr->remote_domain);
+
+	return ret;
+}
+
+static int hyper_dmabuf_rx_ch_setup_ioctl(struct file *filp, void *data)
+{
+	struct ioctl_hyper_dmabuf_rx_ch_setup *rx_ch_attr;
+	struct hyper_dmabuf_bknd_ops *bknd_ops = hy_drv_priv->bknd_ops;
+	int ret = 0;
+
+	if (!data) {
+		dev_err(hy_drv_priv->dev, "user data is NULL\n");
+		return -EINVAL;
+	}
+
+	rx_ch_attr = (struct ioctl_hyper_dmabuf_rx_ch_setup *)data;
+
+	ret = bknd_ops->init_rx_ch(rx_ch_attr->source_domain);
+
+	return ret;
+}
+
+static int send_export_msg(struct exported_sgt_info *exported,
+			   struct pages_info *pg_info)
+{
+	struct hyper_dmabuf_bknd_ops *bknd_ops = hy_drv_priv->bknd_ops;
+	struct hyper_dmabuf_req *req;
+	int op[MAX_NUMBER_OF_OPERANDS] = {0};
+	int ret, i;
+
+	/* now create request for importer via ring */
+	op[0] = exported->hid.id;
+
+	for (i = 0; i < 3; i++)
+		op[i+1] = exported->hid.rng_key[i];
+
+	if (pg_info) {
+		op[4] = pg_info->nents;
+		op[5] = pg_info->frst_ofst;
+		op[6] = pg_info->last_len;
+		op[7] = bknd_ops->share_pages(pg_info->pgs, exported->rdomid,
+					 pg_info->nents, &exported->refs_info);
+		if (op[7] < 0) {
+			dev_err(hy_drv_priv->dev, "pages sharing failed\n");
+			return op[7];
+		}
+	}
+
+	req = kcalloc(1, sizeof(*req), GFP_KERNEL);
+
+	if (!req)
+		return -ENOMEM;
+
+	/* composing a message to the importer */
+	hyper_dmabuf_create_req(req, HYPER_DMABUF_EXPORT, &op[0]);
+
+	ret = bknd_ops->send_req(exported->rdomid, req, true);
+
+	kfree(req);
+
+	return ret;
+}
+
+/* Fast path exporting routine in case same buffer is already exported.
+ *
+ * If same buffer is still valid and exist in EXPORT LIST it returns 0 so
+ * that remaining normal export process can be skipped.
+ *
+ * If "unexport" is scheduled for the buffer, it cancels it since the buffer
+ * is being re-exported.
+ *
+ * return '1' if reexport is needed, return '0' if succeeds, return
+ * Kernel error code if something goes wrong
+ */
+static int fastpath_export(hyper_dmabuf_id_t hid)
+{
+	int reexport = 1;
+	int ret = 0;
+	struct exported_sgt_info *exported;
+
+	exported = hyper_dmabuf_find_exported(hid);
+
+	if (!exported)
+		return reexport;
+
+	if (exported->valid == false)
+		return reexport;
+
+	/*
+	 * Check if unexport is already scheduled for that buffer,
+	 * if so try to cancel it. If that will fail, buffer needs
+	 * to be reexport once again.
+	 */
+	if (exported->unexport_sched) {
+		if (!cancel_delayed_work_sync(&exported->unexport))
+			return reexport;
+
+		exported->unexport_sched = false;
+	}
+
+	return ret;
+}
+
+static int hyper_dmabuf_export_remote_ioctl(struct file *filp, void *data)
+{
+	struct ioctl_hyper_dmabuf_export_remote *export_remote_attr =
+			(struct ioctl_hyper_dmabuf_export_remote *)data;
+	struct dma_buf *dma_buf;
+	struct dma_buf_attachment *attachment;
+	struct sg_table *sgt;
+	struct pages_info *pg_info;
+	struct exported_sgt_info *exported;
+	hyper_dmabuf_id_t hid;
+	int ret = 0;
+
+	if (hy_drv_priv->domid == export_remote_attr->remote_domain) {
+		dev_err(hy_drv_priv->dev,
+			"exporting to the same VM is not permitted\n");
+		return -EINVAL;
+	}
+
+	dma_buf = dma_buf_get(export_remote_attr->dmabuf_fd);
+
+	if (IS_ERR(dma_buf)) {
+		dev_err(hy_drv_priv->dev, "Cannot get dma buf\n");
+		return PTR_ERR(dma_buf);
+	}
+
+	/* we check if this specific attachment was already exported
+	 * to the same domain and if yes and it's valid sgt_info,
+	 * it returns hyper_dmabuf_id of pre-exported sgt_info
+	 */
+	hid = hyper_dmabuf_find_hid_exported(dma_buf,
+					     export_remote_attr->remote_domain);
+
+	if (hid.id != -1) {
+		ret = fastpath_export(hid);
+
+		/* return if fastpath_export succeeds or
+		 * gets some fatal error
+		 */
+		if (ret <= 0) {
+			dma_buf_put(dma_buf);
+			export_remote_attr->hid = hid;
+			return ret;
+		}
+	}
+
+	attachment = dma_buf_attach(dma_buf, hy_drv_priv->dev);
+	if (IS_ERR(attachment)) {
+		dev_err(hy_drv_priv->dev, "cannot get attachment\n");
+		ret = PTR_ERR(attachment);
+		goto fail_attach;
+	}
+
+	sgt = dma_buf_map_attachment(attachment, DMA_BIDIRECTIONAL);
+
+	if (IS_ERR(sgt)) {
+		dev_err(hy_drv_priv->dev, "cannot map attachment\n");
+		ret = PTR_ERR(sgt);
+		goto fail_map_attachment;
+	}
+
+	exported = kcalloc(1, sizeof(*exported), GFP_KERNEL);
+
+	if (!exported) {
+		ret = -ENOMEM;
+		goto fail_sgt_info_creation;
+	}
+
+	exported->hid = hyper_dmabuf_get_hid();
+
+	/* no more exported dmabuf allowed */
+	if (exported->hid.id == -1) {
+		dev_err(hy_drv_priv->dev,
+			"exceeds allowed number of dmabuf to be exported\n");
+		ret = -ENOMEM;
+		goto fail_sgt_info_creation;
+	}
+
+	exported->rdomid = export_remote_attr->remote_domain;
+	exported->dma_buf = dma_buf;
+	exported->valid = true;
+
+	exported->active_sgts = kmalloc(sizeof(struct sgt_list), GFP_KERNEL);
+	if (!exported->active_sgts) {
+		ret = -ENOMEM;
+		goto fail_map_active_sgts;
+	}
+
+	exported->active_attached = kmalloc(sizeof(struct attachment_list),
+					    GFP_KERNEL);
+	if (!exported->active_attached) {
+		ret = -ENOMEM;
+		goto fail_map_active_attached;
+	}
+
+	exported->va_kmapped = kmalloc(sizeof(struct kmap_vaddr_list),
+				       GFP_KERNEL);
+	if (!exported->va_kmapped) {
+		ret = -ENOMEM;
+		goto fail_map_va_kmapped;
+	}
+
+	exported->va_vmapped = kmalloc(sizeof(struct vmap_vaddr_list),
+				       GFP_KERNEL);
+	if (!exported->va_vmapped) {
+		ret = -ENOMEM;
+		goto fail_map_va_vmapped;
+	}
+
+	exported->active_sgts->sgt = sgt;
+	exported->active_attached->attach = attachment;
+	exported->va_kmapped->vaddr = NULL;
+	exported->va_vmapped->vaddr = NULL;
+
+	/* initialize list of sgt, attachment and vaddr for dmabuf sync
+	 * via shadow dma-buf
+	 */
+	INIT_LIST_HEAD(&exported->active_sgts->list);
+	INIT_LIST_HEAD(&exported->active_attached->list);
+	INIT_LIST_HEAD(&exported->va_kmapped->list);
+	INIT_LIST_HEAD(&exported->va_vmapped->list);
+
+	if (ret) {
+		dev_err(hy_drv_priv->dev,
+			"failed to load private data\n");
+		ret = -EINVAL;
+		goto fail_export;
+	}
+
+	pg_info = hyper_dmabuf_ext_pgs(sgt);
+	if (!pg_info) {
+		dev_err(hy_drv_priv->dev,
+			"failed to construct pg_info\n");
+		ret = -ENOMEM;
+		goto fail_export;
+	}
+
+	exported->nents = pg_info->nents;
+
+	/* now register it to export list */
+	hyper_dmabuf_register_exported(exported);
+
+	export_remote_attr->hid = exported->hid;
+
+	ret = send_export_msg(exported, pg_info);
+
+	if (ret < 0) {
+		dev_err(hy_drv_priv->dev,
+			"failed to send out the export request\n");
+		goto fail_send_request;
+	}
+
+	/* free pg_info */
+	kfree(pg_info->pgs);
+	kfree(pg_info);
+
+	exported->filp = filp;
+
+	return ret;
+
+/* Clean-up if error occurs */
+
+fail_send_request:
+	hyper_dmabuf_remove_exported(exported->hid);
+
+	/* free pg_info */
+	kfree(pg_info->pgs);
+	kfree(pg_info);
+
+fail_export:
+	kfree(exported->va_vmapped);
+
+fail_map_va_vmapped:
+	kfree(exported->va_kmapped);
+
+fail_map_va_kmapped:
+	kfree(exported->active_attached);
+
+fail_map_active_attached:
+	kfree(exported->active_sgts);
+	kfree(exported);
+
+fail_map_active_sgts:
+fail_sgt_info_creation:
+	dma_buf_unmap_attachment(attachment, sgt,
+				 DMA_BIDIRECTIONAL);
+
+fail_map_attachment:
+	dma_buf_detach(dma_buf, attachment);
+
+fail_attach:
+	dma_buf_put(dma_buf);
+
+	return ret;
+}
+
+static int hyper_dmabuf_export_fd_ioctl(struct file *filp, void *data)
+{
+	struct ioctl_hyper_dmabuf_export_fd *export_fd_attr =
+			(struct ioctl_hyper_dmabuf_export_fd *)data;
+	struct hyper_dmabuf_bknd_ops *bknd_ops = hy_drv_priv->bknd_ops;
+	struct imported_sgt_info *imported;
+	struct hyper_dmabuf_req *req;
+	struct page **data_pgs;
+	int op[4];
+	int i;
+	int ret = 0;
+
+	dev_dbg(hy_drv_priv->dev, "%s entry\n", __func__);
+
+	/* look for dmabuf for the id */
+	imported = hyper_dmabuf_find_imported(export_fd_attr->hid);
+
+	/* can't find sgt from the table */
+	if (!imported) {
+		dev_err(hy_drv_priv->dev, "can't find the entry\n");
+		return -ENOENT;
+	}
+
+	mutex_lock(&hy_drv_priv->lock);
+
+	imported->importers++;
+
+	/* send notification for export_fd to exporter */
+	op[0] = imported->hid.id;
+
+	for (i = 0; i < 3; i++)
+		op[i+1] = imported->hid.rng_key[i];
+
+	dev_dbg(hy_drv_priv->dev, "Export FD of buffer {id:%d key:%d %d %d}\n",
+		imported->hid.id, imported->hid.rng_key[0],
+		imported->hid.rng_key[1], imported->hid.rng_key[2]);
+
+	req = kcalloc(1, sizeof(*req), GFP_KERNEL);
+
+	if (!req) {
+		mutex_unlock(&hy_drv_priv->lock);
+		return -ENOMEM;
+	}
+
+	hyper_dmabuf_create_req(req, HYPER_DMABUF_EXPORT_FD, &op[0]);
+
+	ret = bknd_ops->send_req(HYPER_DMABUF_DOM_ID(imported->hid), req, true);
+
+	if (ret < 0) {
+		/* in case of timeout other end eventually will receive request,
+		 * so we need to undo it
+		 */
+		hyper_dmabuf_create_req(req, HYPER_DMABUF_EXPORT_FD_FAILED,
+					&op[0]);
+		bknd_ops->send_req(HYPER_DMABUF_DOM_ID(imported->hid),
+				   req, false);
+		kfree(req);
+		dev_err(hy_drv_priv->dev,
+			"Failed to create sgt or notify exporter\n");
+		imported->importers--;
+		mutex_unlock(&hy_drv_priv->lock);
+		return ret;
+	}
+
+	kfree(req);
+
+	if (ret == HYPER_DMABUF_REQ_ERROR) {
+		dev_err(hy_drv_priv->dev,
+			"Buffer invalid {id:%d key:%d %d %d}, cannot import\n",
+			imported->hid.id, imported->hid.rng_key[0],
+			imported->hid.rng_key[1], imported->hid.rng_key[2]);
+
+		imported->importers--;
+		mutex_unlock(&hy_drv_priv->lock);
+		return -EINVAL;
+	}
+
+	ret = 0;
+
+	dev_dbg(hy_drv_priv->dev,
+		"Found buffer gref %d off %d\n",
+		imported->ref_handle, imported->frst_ofst);
+
+	dev_dbg(hy_drv_priv->dev,
+		"last len %d nents %d domain %d\n",
+		imported->last_len, imported->nents,
+		HYPER_DMABUF_DOM_ID(imported->hid));
+
+	if (!imported->sgt) {
+		dev_dbg(hy_drv_priv->dev,
+			"buffer {id:%d key:%d %d %d} pages not mapped yet\n",
+			imported->hid.id, imported->hid.rng_key[0],
+			imported->hid.rng_key[1], imported->hid.rng_key[2]);
+
+		data_pgs = bknd_ops->map_shared_pages(imported->ref_handle,
+					HYPER_DMABUF_DOM_ID(imported->hid),
+					imported->nents,
+					&imported->refs_info);
+
+		if (!data_pgs) {
+			dev_err(hy_drv_priv->dev,
+				"can't map pages hid {id:%d key:%d %d %d}\n",
+				imported->hid.id, imported->hid.rng_key[0],
+				imported->hid.rng_key[1],
+				imported->hid.rng_key[2]);
+
+			imported->importers--;
+
+			req = kcalloc(1, sizeof(*req), GFP_KERNEL);
+
+			if (!req) {
+				mutex_unlock(&hy_drv_priv->lock);
+				return -ENOMEM;
+			}
+
+			hyper_dmabuf_create_req(req,
+						HYPER_DMABUF_EXPORT_FD_FAILED,
+						&op[0]);
+
+			bknd_ops->send_req(HYPER_DMABUF_DOM_ID(imported->hid),
+					   req, false);
+			kfree(req);
+			mutex_unlock(&hy_drv_priv->lock);
+			return -EINVAL;
+		}
+
+		imported->sgt = hyper_dmabuf_create_sgt(data_pgs,
+							imported->frst_ofst,
+							imported->last_len,
+							imported->nents);
+
+	}
+
+	export_fd_attr->fd = hyper_dmabuf_export_fd(imported,
+						    export_fd_attr->flags);
+
+	if (export_fd_attr->fd < 0) {
+		/* fail to get fd */
+		ret = export_fd_attr->fd;
+	}
+
+	mutex_unlock(&hy_drv_priv->lock);
+
+	dev_dbg(hy_drv_priv->dev, "%s exit\n", __func__);
+	return ret;
+}
+
+/* unexport dmabuf from the database and send int req to the source domain
+ * to unmap it.
+ */
+static void delayed_unexport(struct work_struct *work)
+{
+	struct hyper_dmabuf_req *req;
+	struct hyper_dmabuf_bknd_ops *bknd_ops = hy_drv_priv->bknd_ops;
+	struct exported_sgt_info *exported =
+		container_of(work, struct exported_sgt_info, unexport.work);
+	int op[4];
+	int i, ret;
+
+	if (!exported)
+		return;
+
+	dev_dbg(hy_drv_priv->dev,
+		"Marking buffer {id:%d key:%d %d %d} as invalid\n",
+		exported->hid.id, exported->hid.rng_key[0],
+		exported->hid.rng_key[1], exported->hid.rng_key[2]);
+
+	/* no longer valid */
+	exported->valid = false;
+
+	req = kcalloc(1, sizeof(*req), GFP_KERNEL);
+
+	if (!req)
+		return;
+
+	op[0] = exported->hid.id;
+
+	for (i = 0; i < 3; i++)
+		op[i+1] = exported->hid.rng_key[i];
+
+	hyper_dmabuf_create_req(req, HYPER_DMABUF_NOTIFY_UNEXPORT, &op[0]);
+
+	/* Now send unexport request to remote domain, marking
+	 * that buffer should not be used anymore
+	 */
+	ret = bknd_ops->send_req(exported->rdomid, req, true);
+	if (ret < 0) {
+		dev_err(hy_drv_priv->dev,
+			"unexport message for buffer {id:%d key:%d %d %d} failed\n",
+			exported->hid.id, exported->hid.rng_key[0],
+			exported->hid.rng_key[1], exported->hid.rng_key[2]);
+	}
+
+	kfree(req);
+	exported->unexport_sched = false;
+
+	/* Immediately clean-up if it has never been exported by importer
+	 * (so no SGT is constructed on importer).
+	 * clean it up later in remote sync when final release ops
+	 * is called (importer does this only when there's no
+	 * no consumer of locally exported FDs)
+	 */
+	if (exported->active == 0) {
+		dev_dbg(hy_drv_priv->dev,
+			"claning up buffer {id:%d key:%d %d %d} completly\n",
+			exported->hid.id, exported->hid.rng_key[0],
+			exported->hid.rng_key[1], exported->hid.rng_key[2]);
+
+		hyper_dmabuf_cleanup_sgt_info(exported, false);
+		hyper_dmabuf_remove_exported(exported->hid);
+
+		/* register hyper_dmabuf_id to the list for reuse */
+		hyper_dmabuf_store_hid(exported->hid);
+
+		kfree(exported);
+	}
+}
+
+/* Schedule unexport of dmabuf.
+ */
+int hyper_dmabuf_unexport_ioctl(struct file *filp, void *data)
+{
+	struct ioctl_hyper_dmabuf_unexport *unexport_attr =
+			(struct ioctl_hyper_dmabuf_unexport *)data;
+	struct exported_sgt_info *exported;
+
+	dev_dbg(hy_drv_priv->dev, "%s entry\n", __func__);
+
+	/* find dmabuf in export list */
+	exported = hyper_dmabuf_find_exported(unexport_attr->hid);
+
+	dev_dbg(hy_drv_priv->dev,
+		"scheduling unexport of buffer {id:%d key:%d %d %d}\n",
+		unexport_attr->hid.id, unexport_attr->hid.rng_key[0],
+		unexport_attr->hid.rng_key[1], unexport_attr->hid.rng_key[2]);
+
+	/* failed to find corresponding entry in export list */
+	if (exported == NULL) {
+		unexport_attr->status = -ENOENT;
+		return -ENOENT;
+	}
+
+	if (exported->unexport_sched)
+		return 0;
+
+	exported->unexport_sched = true;
+	INIT_DELAYED_WORK(&exported->unexport, delayed_unexport);
+	schedule_delayed_work(&exported->unexport,
+			      msecs_to_jiffies(unexport_attr->delay_ms));
+
+	dev_dbg(hy_drv_priv->dev, "%s exit\n", __func__);
+	return 0;
+}
+
+const struct hyper_dmabuf_ioctl_desc hyper_dmabuf_ioctls[] = {
+	HYPER_DMABUF_IOCTL_DEF(IOCTL_HYPER_DMABUF_TX_CH_SETUP,
+			       hyper_dmabuf_tx_ch_setup_ioctl, 0),
+	HYPER_DMABUF_IOCTL_DEF(IOCTL_HYPER_DMABUF_RX_CH_SETUP,
+			       hyper_dmabuf_rx_ch_setup_ioctl, 0),
+	HYPER_DMABUF_IOCTL_DEF(IOCTL_HYPER_DMABUF_EXPORT_REMOTE,
+			       hyper_dmabuf_export_remote_ioctl, 0),
+	HYPER_DMABUF_IOCTL_DEF(IOCTL_HYPER_DMABUF_EXPORT_FD,
+			       hyper_dmabuf_export_fd_ioctl, 0),
+	HYPER_DMABUF_IOCTL_DEF(IOCTL_HYPER_DMABUF_UNEXPORT,
+			       hyper_dmabuf_unexport_ioctl, 0),
+};
+
+long hyper_dmabuf_ioctl(struct file *filp,
+			unsigned int cmd, unsigned long param)
+{
+	const struct hyper_dmabuf_ioctl_desc *ioctl = NULL;
+	unsigned int nr = _IOC_NR(cmd);
+	int ret;
+	hyper_dmabuf_ioctl_t func;
+	char *kdata;
+
+	if (nr > ARRAY_SIZE(hyper_dmabuf_ioctls)) {
+		dev_err(hy_drv_priv->dev, "invalid ioctl\n");
+		return -EINVAL;
+	}
+
+	ioctl = &hyper_dmabuf_ioctls[nr];
+
+	func = ioctl->func;
+
+	if (unlikely(!func)) {
+		dev_err(hy_drv_priv->dev, "no function\n");
+		return -EINVAL;
+	}
+
+	kdata = kmalloc(_IOC_SIZE(cmd), GFP_KERNEL);
+	if (!kdata)
+		return -ENOMEM;
+
+	if (copy_from_user(kdata, (void __user *)param,
+			   _IOC_SIZE(cmd)) != 0) {
+		dev_err(hy_drv_priv->dev,
+			"failed to copy from user arguments\n");
+		ret = -EFAULT;
+		goto ioctl_error;
+	}
+
+	ret = func(filp, kdata);
+
+	if (copy_to_user((void __user *)param, kdata,
+			 _IOC_SIZE(cmd)) != 0) {
+		dev_err(hy_drv_priv->dev,
+			"failed to copy to user arguments\n");
+		ret = -EFAULT;
+		goto ioctl_error;
+	}
+
+ioctl_error:
+	kfree(kdata);
+
+	return ret;
+}
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.h b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.h
new file mode 100644
index 000000000000..d8090900ffa2
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.h
@@ -0,0 +1,52 @@
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
+ * SPDX-License-Identifier: (MIT OR GPL-2.0)
+ *
+ */
+
+#ifndef __HYPER_DMABUF_IOCTL_H__
+#define __HYPER_DMABUF_IOCTL_H__
+
+typedef int (*hyper_dmabuf_ioctl_t)(struct file *filp, void *data);
+
+struct hyper_dmabuf_ioctl_desc {
+	unsigned int cmd;
+	int flags;
+	hyper_dmabuf_ioctl_t func;
+	const char *name;
+};
+
+#define HYPER_DMABUF_IOCTL_DEF(ioctl, _func, _flags)	\
+	[_IOC_NR(ioctl)] = {				\
+			.cmd = ioctl,			\
+			.func = _func,			\
+			.flags = _flags,		\
+			.name = #ioctl			\
+	}
+
+long hyper_dmabuf_ioctl(struct file *filp,
+			unsigned int cmd, unsigned long param);
+
+int hyper_dmabuf_unexport_ioctl(struct file *filp, void *data);
+
+#endif //__HYPER_DMABUF_IOCTL_H__
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_list.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_list.c
new file mode 100644
index 000000000000..f2f65a8ec47f
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_list.c
@@ -0,0 +1,294 @@
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
+ * SPDX-License-Identifier: (MIT OR GPL-2.0)
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
+#include <linux/cdev.h>
+#include <linux/hashtable.h>
+#include "hyper_dmabuf_drv.h"
+#include "hyper_dmabuf_list.h"
+#include "hyper_dmabuf_id.h"
+
+DECLARE_HASHTABLE(hyper_dmabuf_hash_imported, MAX_ENTRY_IMPORTED);
+DECLARE_HASHTABLE(hyper_dmabuf_hash_exported, MAX_ENTRY_EXPORTED);
+
+#ifdef CONFIG_HYPER_DMABUF_SYSFS
+static ssize_t hyper_dmabuf_imported_show(struct device *drv,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct list_entry_imported *info_entry;
+	int bkt;
+	ssize_t count = 0;
+	size_t total = 0;
+
+	hash_for_each(hyper_dmabuf_hash_imported, bkt, info_entry, node) {
+		hyper_dmabuf_id_t hid = info_entry->imported->hid;
+		int nents = info_entry->imported->nents;
+		bool valid = info_entry->imported->valid;
+		int num_importers = info_entry->imported->importers;
+
+		total += nents;
+		count += scnprintf(buf + count, PAGE_SIZE - count,
+				"hid:{%d %d %d %d}, nent:%d, v:%c, numi:%d\n",
+				hid.id, hid.rng_key[0], hid.rng_key[1],
+				hid.rng_key[2], nents, (valid ? 't' : 'f'),
+				num_importers);
+	}
+	count += scnprintf(buf + count, PAGE_SIZE - count,
+			   "total nents: %lu\n", total);
+
+	return count;
+}
+
+static ssize_t hyper_dmabuf_exported_show(struct device *drv,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct list_entry_exported *info_entry;
+	int bkt;
+	ssize_t count = 0;
+	size_t total = 0;
+
+	hash_for_each(hyper_dmabuf_hash_exported, bkt, info_entry, node) {
+		hyper_dmabuf_id_t hid = info_entry->exported->hid;
+		int nents = info_entry->exported->nents;
+		bool valid = info_entry->exported->valid;
+		int importer_exported = info_entry->exported->active;
+
+		total += nents;
+		count += scnprintf(buf + count, PAGE_SIZE - count,
+				   "hid:{%d %d %d %d}, nent:%d, v:%c, ie:%d\n",
+				   hid.id, hid.rng_key[0], hid.rng_key[1],
+				   hid.rng_key[2], nents, (valid ? 't' : 'f'),
+				   importer_exported);
+	}
+	count += scnprintf(buf + count, PAGE_SIZE - count,
+			   "total nents: %lu\n", total);
+
+	return count;
+}
+
+static DEVICE_ATTR(imported, 0400, hyper_dmabuf_imported_show, NULL);
+static DEVICE_ATTR(exported, 0400, hyper_dmabuf_exported_show, NULL);
+
+int hyper_dmabuf_register_sysfs(struct device *dev)
+{
+	int err;
+
+	err = device_create_file(dev, &dev_attr_imported);
+	if (err < 0)
+		goto err1;
+	err = device_create_file(dev, &dev_attr_exported);
+	if (err < 0)
+		goto err2;
+
+	return 0;
+err2:
+	device_remove_file(dev, &dev_attr_imported);
+err1:
+	return -1;
+}
+
+int hyper_dmabuf_unregister_sysfs(struct device *dev)
+{
+	device_remove_file(dev, &dev_attr_imported);
+	device_remove_file(dev, &dev_attr_exported);
+	return 0;
+}
+
+#endif
+
+int hyper_dmabuf_table_init(void)
+{
+	hash_init(hyper_dmabuf_hash_imported);
+	hash_init(hyper_dmabuf_hash_exported);
+	return 0;
+}
+
+int hyper_dmabuf_table_destroy(void)
+{
+	/* TODO: cleanup hyper_dmabuf_hash_imported
+	 * and hyper_dmabuf_hash_exported
+	 */
+	return 0;
+}
+
+int hyper_dmabuf_register_exported(struct exported_sgt_info *exported)
+{
+	struct list_entry_exported *info_entry;
+
+	info_entry = kmalloc(sizeof(*info_entry), GFP_KERNEL);
+
+	if (!info_entry)
+		return -ENOMEM;
+
+	info_entry->exported = exported;
+
+	hash_add(hyper_dmabuf_hash_exported, &info_entry->node,
+		 info_entry->exported->hid.id);
+
+	return 0;
+}
+
+int hyper_dmabuf_register_imported(struct imported_sgt_info *imported)
+{
+	struct list_entry_imported *info_entry;
+
+	info_entry = kmalloc(sizeof(*info_entry), GFP_KERNEL);
+
+	if (!info_entry)
+		return -ENOMEM;
+
+	info_entry->imported = imported;
+
+	hash_add(hyper_dmabuf_hash_imported, &info_entry->node,
+		 info_entry->imported->hid.id);
+
+	return 0;
+}
+
+struct exported_sgt_info *hyper_dmabuf_find_exported(hyper_dmabuf_id_t hid)
+{
+	struct list_entry_exported *info_entry;
+	int bkt;
+
+	hash_for_each(hyper_dmabuf_hash_exported, bkt, info_entry, node)
+		/* checking hid.id first */
+		if (info_entry->exported->hid.id == hid.id) {
+			/* then key is compared */
+			if (hyper_dmabuf_hid_keycomp(info_entry->exported->hid,
+						    hid))
+				return info_entry->exported;
+
+			/* if key is unmatched, given HID is invalid,
+			 * so returning NULL
+			 */
+			break;
+		}
+
+	return NULL;
+}
+
+/* search for pre-exported sgt and return id of it if it exist */
+hyper_dmabuf_id_t hyper_dmabuf_find_hid_exported(struct dma_buf *dmabuf,
+						 int domid)
+{
+	struct list_entry_exported *info_entry;
+	hyper_dmabuf_id_t hid = {-1, {0, 0, 0} };
+	int bkt;
+
+	hash_for_each(hyper_dmabuf_hash_exported, bkt, info_entry, node)
+		if (info_entry->exported->dma_buf == dmabuf &&
+		    info_entry->exported->rdomid == domid)
+			return info_entry->exported->hid;
+
+	return hid;
+}
+
+struct imported_sgt_info *hyper_dmabuf_find_imported(hyper_dmabuf_id_t hid)
+{
+	struct list_entry_imported *info_entry;
+	int bkt;
+
+	hash_for_each(hyper_dmabuf_hash_imported, bkt, info_entry, node)
+		/* checking hid.id first */
+		if (info_entry->imported->hid.id == hid.id) {
+			/* then key is compared */
+			if (hyper_dmabuf_hid_keycomp(info_entry->imported->hid,
+						    hid))
+				return info_entry->imported;
+			/* if key is unmatched, given HID is invalid,
+			 * so returning NULL
+			 */
+			break;
+		}
+
+	return NULL;
+}
+
+int hyper_dmabuf_remove_exported(hyper_dmabuf_id_t hid)
+{
+	struct list_entry_exported *info_entry;
+	int bkt;
+
+	hash_for_each(hyper_dmabuf_hash_exported, bkt, info_entry, node)
+		/* checking hid.id first */
+		if (info_entry->exported->hid.id == hid.id) {
+			/* then key is compared */
+			if (hyper_dmabuf_hid_keycomp(info_entry->exported->hid,
+						    hid)) {
+				hash_del(&info_entry->node);
+				kfree(info_entry);
+				return 0;
+			}
+
+			break;
+		}
+
+	return -ENOENT;
+}
+
+int hyper_dmabuf_remove_imported(hyper_dmabuf_id_t hid)
+{
+	struct list_entry_imported *info_entry;
+	int bkt;
+
+	hash_for_each(hyper_dmabuf_hash_imported, bkt, info_entry, node)
+		/* checking hid.id first */
+		if (info_entry->imported->hid.id == hid.id) {
+			/* then key is compared */
+			if (hyper_dmabuf_hid_keycomp(info_entry->imported->hid,
+						    hid)) {
+				hash_del(&info_entry->node);
+				kfree(info_entry);
+				return 0;
+			}
+
+			break;
+		}
+
+	return -ENOENT;
+}
+
+void hyper_dmabuf_foreach_exported(
+	void (*func)(struct exported_sgt_info *, void *attr),
+	void *attr)
+{
+	struct list_entry_exported *info_entry;
+	struct hlist_node *tmp;
+	int bkt;
+
+	hash_for_each_safe(hyper_dmabuf_hash_exported, bkt, tmp,
+			info_entry, node) {
+		func(info_entry->exported, attr);
+	}
+}
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_list.h b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_list.h
new file mode 100644
index 000000000000..3c6a23ef80c6
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_list.h
@@ -0,0 +1,73 @@
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
+ * SPDX-License-Identifier: (MIT OR GPL-2.0)
+ *
+ */
+
+#ifndef __HYPER_DMABUF_LIST_H__
+#define __HYPER_DMABUF_LIST_H__
+
+#include "hyper_dmabuf_struct.h"
+
+/* number of bits to be used for exported dmabufs hash table */
+#define MAX_ENTRY_EXPORTED 7
+/* number of bits to be used for imported dmabufs hash table */
+#define MAX_ENTRY_IMPORTED 7
+
+struct list_entry_exported {
+	struct exported_sgt_info *exported;
+	struct hlist_node node;
+};
+
+struct list_entry_imported {
+	struct imported_sgt_info *imported;
+	struct hlist_node node;
+};
+
+int hyper_dmabuf_table_init(void);
+
+int hyper_dmabuf_table_destroy(void);
+
+int hyper_dmabuf_register_exported(struct exported_sgt_info *info);
+
+/* search for pre-exported sgt and return id of it if it exist */
+hyper_dmabuf_id_t hyper_dmabuf_find_hid_exported(struct dma_buf *dmabuf,
+						 int domid);
+
+int hyper_dmabuf_register_imported(struct imported_sgt_info *info);
+
+struct exported_sgt_info *hyper_dmabuf_find_exported(hyper_dmabuf_id_t hid);
+
+struct imported_sgt_info *hyper_dmabuf_find_imported(hyper_dmabuf_id_t hid);
+
+int hyper_dmabuf_remove_exported(hyper_dmabuf_id_t hid);
+
+int hyper_dmabuf_remove_imported(hyper_dmabuf_id_t hid);
+
+void hyper_dmabuf_foreach_exported(void (*func)(struct exported_sgt_info *,
+				   void *attr), void *attr);
+
+int hyper_dmabuf_register_sysfs(struct device *dev);
+int hyper_dmabuf_unregister_sysfs(struct device *dev);
+
+#endif /* __HYPER_DMABUF_LIST_H__ */
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c
new file mode 100644
index 000000000000..129b2ff2af2b
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c
@@ -0,0 +1,320 @@
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
+ * SPDX-License-Identifier: (MIT OR GPL-2.0)
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
+#include <linux/workqueue.h>
+#include "hyper_dmabuf_drv.h"
+#include "hyper_dmabuf_msg.h"
+#include "hyper_dmabuf_list.h"
+
+struct cmd_process {
+	struct work_struct work;
+	struct hyper_dmabuf_req *rq;
+	int domid;
+};
+
+void hyper_dmabuf_create_req(struct hyper_dmabuf_req *req,
+			     enum hyper_dmabuf_command cmd, int *op)
+{
+	int i;
+
+	req->stat = HYPER_DMABUF_REQ_NOT_RESPONDED;
+	req->cmd = cmd;
+
+	switch (cmd) {
+	/* as exporter, commands to importer */
+	case HYPER_DMABUF_EXPORT:
+		/* exporting pages for dmabuf */
+		/* command : HYPER_DMABUF_EXPORT,
+		 * op0~op3 : hyper_dmabuf_id
+		 * op4 : number of pages to be shared
+		 * op5 : offset of data in the first page
+		 * op6 : length of data in the last page
+		 * op7 : top-level reference number for shared pages
+		 */
+
+		memcpy(&req->op[0], &op[0], 8 * sizeof(int) + op[8]);
+		break;
+
+	case HYPER_DMABUF_NOTIFY_UNEXPORT:
+		/* destroy sg_list for hyper_dmabuf_id on remote side */
+		/* command : DMABUF_DESTROY,
+		 * op0~op3 : hyper_dmabuf_id_t hid
+		 */
+
+		for (i = 0; i < 4; i++)
+			req->op[i] = op[i];
+		break;
+
+	case HYPER_DMABUF_EXPORT_FD:
+	case HYPER_DMABUF_EXPORT_FD_FAILED:
+		/* dmabuf fd is being created on imported side or importing
+		 * failed
+		 *
+		 * command : HYPER_DMABUF_EXPORT_FD or
+		 *	     HYPER_DMABUF_EXPORT_FD_FAILED,
+		 * op0~op3 : hyper_dmabuf_id
+		 */
+
+		for (i = 0; i < 4; i++)
+			req->op[i] = op[i];
+		break;
+
+	default:
+		/* no command found */
+		return;
+	}
+}
+
+static void cmd_process_work(struct work_struct *work)
+{
+	struct imported_sgt_info *imported;
+	struct cmd_process *proc = container_of(work,
+						struct cmd_process, work);
+	struct hyper_dmabuf_req *req;
+	int domid;
+	int i;
+
+	req = proc->rq;
+	domid = proc->domid;
+
+	switch (req->cmd) {
+	case HYPER_DMABUF_EXPORT:
+		/* exporting pages for dmabuf */
+		/* command : HYPER_DMABUF_EXPORT,
+		 * op0~op3 : hyper_dmabuf_id
+		 * op4 : number of pages to be shared
+		 * op5 : offset of data in the first page
+		 * op6 : length of data in the last page
+		 * op7 : top-level reference number for shared pages
+		 */
+
+		/* if nents == 0, it means it is a message only for
+		 * priv synchronization. for existing imported_sgt_info
+		 * so not creating a new one
+		 */
+		if (req->op[4] == 0) {
+			hyper_dmabuf_id_t exist = {req->op[0],
+						   {req->op[1], req->op[2],
+						   req->op[3] } };
+
+			imported = hyper_dmabuf_find_imported(exist);
+
+			if (!imported) {
+				dev_err(hy_drv_priv->dev,
+					"Can't find imported sgt_info\n");
+				break;
+			}
+
+			break;
+		}
+
+		imported = kcalloc(1, sizeof(*imported), GFP_KERNEL);
+
+		if (!imported)
+			break;
+
+		imported->hid.id = req->op[0];
+
+		for (i = 0; i < 3; i++)
+			imported->hid.rng_key[i] = req->op[i+1];
+
+		imported->nents = req->op[4];
+		imported->frst_ofst = req->op[5];
+		imported->last_len = req->op[6];
+		imported->ref_handle = req->op[7];
+
+		dev_dbg(hy_drv_priv->dev, "DMABUF was exported\n");
+		dev_dbg(hy_drv_priv->dev, "\thid{id:%d key:%d %d %d}\n",
+			req->op[0], req->op[1], req->op[2],
+			req->op[3]);
+		dev_dbg(hy_drv_priv->dev, "\tnents %d\n", req->op[4]);
+		dev_dbg(hy_drv_priv->dev, "\tfirst offset %d\n", req->op[5]);
+		dev_dbg(hy_drv_priv->dev, "\tlast len %d\n", req->op[6]);
+		dev_dbg(hy_drv_priv->dev, "\tgrefid %d\n", req->op[7]);
+
+		imported->valid = true;
+		hyper_dmabuf_register_imported(imported);
+
+		break;
+
+	default:
+		/* shouldn't get here */
+		break;
+	}
+
+	kfree(req);
+	kfree(proc);
+}
+
+int hyper_dmabuf_msg_parse(int domid, struct hyper_dmabuf_req *req)
+{
+	struct cmd_process *proc;
+	struct hyper_dmabuf_req *temp_req;
+	struct imported_sgt_info *imported;
+	struct exported_sgt_info *exported;
+	hyper_dmabuf_id_t hid;
+
+	if (!req) {
+		dev_err(hy_drv_priv->dev, "request is NULL\n");
+		return -EINVAL;
+	}
+
+	hid.id = req->op[0];
+	hid.rng_key[0] = req->op[1];
+	hid.rng_key[1] = req->op[2];
+	hid.rng_key[2] = req->op[3];
+
+	if ((req->cmd < HYPER_DMABUF_EXPORT) ||
+		(req->cmd > HYPER_DMABUF_NOTIFY_UNEXPORT)) {
+		dev_err(hy_drv_priv->dev, "invalid command\n");
+		return -EINVAL;
+	}
+
+	req->stat = HYPER_DMABUF_REQ_PROCESSED;
+
+	/* HYPER_DMABUF_DESTROY requires immediate
+	 * follow up so can't be processed in workqueue
+	 */
+	if (req->cmd == HYPER_DMABUF_NOTIFY_UNEXPORT) {
+		/* destroy sg_list for hyper_dmabuf_id on remote side */
+		/* command : HYPER_DMABUF_NOTIFY_UNEXPORT,
+		 * op0~3 : hyper_dmabuf_id
+		 */
+		dev_dbg(hy_drv_priv->dev,
+			"processing HYPER_DMABUF_NOTIFY_UNEXPORT\n");
+
+		imported = hyper_dmabuf_find_imported(hid);
+
+		if (imported) {
+			/* if anything is still using dma_buf */
+			if (imported->importers) {
+				/* Buffer is still in  use, just mark that
+				 * it should not be allowed to export its fd
+				 * anymore.
+				 */
+				imported->valid = false;
+			} else {
+				/* No one is using buffer, remove it from
+				 * imported list
+				 */
+				hyper_dmabuf_remove_imported(hid);
+				kfree(imported);
+			}
+		} else {
+			req->stat = HYPER_DMABUF_REQ_ERROR;
+		}
+
+		return req->cmd;
+	}
+
+	/* synchronous dma_buf_fd export */
+	if (req->cmd == HYPER_DMABUF_EXPORT_FD) {
+		/* find a corresponding SGT for the id */
+		dev_dbg(hy_drv_priv->dev,
+			"HYPER_DMABUF_EXPORT_FD for {id:%d key:%d %d %d}\n",
+			hid.id, hid.rng_key[0], hid.rng_key[1], hid.rng_key[2]);
+
+		exported = hyper_dmabuf_find_exported(hid);
+
+		if (!exported) {
+			dev_err(hy_drv_priv->dev,
+				"buffer {id:%d key:%d %d %d} not found\n",
+				hid.id, hid.rng_key[0], hid.rng_key[1],
+				hid.rng_key[2]);
+
+			req->stat = HYPER_DMABUF_REQ_ERROR;
+		} else if (!exported->valid) {
+			dev_dbg(hy_drv_priv->dev,
+				"Buffer no longer valid {id:%d key:%d %d %d}\n",
+				hid.id, hid.rng_key[0], hid.rng_key[1],
+				hid.rng_key[2]);
+
+			req->stat = HYPER_DMABUF_REQ_ERROR;
+		} else {
+			dev_dbg(hy_drv_priv->dev,
+				"Buffer still valid {id:%d key:%d %d %d}\n",
+				hid.id, hid.rng_key[0], hid.rng_key[1],
+				hid.rng_key[2]);
+
+			exported->active++;
+			req->stat = HYPER_DMABUF_REQ_PROCESSED;
+		}
+		return req->cmd;
+	}
+
+	if (req->cmd == HYPER_DMABUF_EXPORT_FD_FAILED) {
+		dev_dbg(hy_drv_priv->dev,
+			"HYPER_DMABUF_EXPORT_FD_FAILED for {id:%d key:%d %d %d}\n",
+			hid.id, hid.rng_key[0], hid.rng_key[1], hid.rng_key[2]);
+
+		exported = hyper_dmabuf_find_exported(hid);
+
+		if (!exported) {
+			dev_err(hy_drv_priv->dev,
+				"buffer {id:%d key:%d %d %d} not found\n",
+				hid.id, hid.rng_key[0], hid.rng_key[1],
+				hid.rng_key[2]);
+
+			req->stat = HYPER_DMABUF_REQ_ERROR;
+		} else {
+			exported->active--;
+			req->stat = HYPER_DMABUF_REQ_PROCESSED;
+		}
+		return req->cmd;
+	}
+
+	dev_dbg(hy_drv_priv->dev,
+		"%s: putting request to workqueue\n", __func__);
+	temp_req = kmalloc(sizeof(*temp_req), GFP_KERNEL);
+
+	if (!temp_req)
+		return -ENOMEM;
+
+	memcpy(temp_req, req, sizeof(*temp_req));
+
+	proc = kcalloc(1, sizeof(struct cmd_process), GFP_KERNEL);
+
+	if (!proc) {
+		kfree(temp_req);
+		return -ENOMEM;
+	}
+
+	proc->rq = temp_req;
+	proc->domid = domid;
+
+	INIT_WORK(&(proc->work), cmd_process_work);
+
+	queue_work(hy_drv_priv->work_queue, &(proc->work));
+
+	return req->cmd;
+}
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.h b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.h
new file mode 100644
index 000000000000..59f1528e9b1e
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.h
@@ -0,0 +1,87 @@
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
+ * SPDX-License-Identifier: (MIT OR GPL-2.0)
+ *
+ */
+
+#ifndef __HYPER_DMABUF_MSG_H__
+#define __HYPER_DMABUF_MSG_H__
+
+#define MAX_NUMBER_OF_OPERANDS 8
+
+struct hyper_dmabuf_req {
+	unsigned int req_id;
+	unsigned int stat;
+	unsigned int cmd;
+	unsigned int op[MAX_NUMBER_OF_OPERANDS];
+};
+
+struct hyper_dmabuf_resp {
+	unsigned int resp_id;
+	unsigned int stat;
+	unsigned int cmd;
+	unsigned int op[MAX_NUMBER_OF_OPERANDS];
+};
+
+enum hyper_dmabuf_command {
+	HYPER_DMABUF_EXPORT = 0x10,
+	HYPER_DMABUF_EXPORT_FD,
+	HYPER_DMABUF_EXPORT_FD_FAILED,
+	HYPER_DMABUF_NOTIFY_UNEXPORT,
+};
+
+enum hyper_dmabuf_ops {
+	HYPER_DMABUF_OPS_ATTACH = 0x1000,
+	HYPER_DMABUF_OPS_DETACH,
+	HYPER_DMABUF_OPS_MAP,
+	HYPER_DMABUF_OPS_UNMAP,
+	HYPER_DMABUF_OPS_RELEASE,
+	HYPER_DMABUF_OPS_BEGIN_CPU_ACCESS,
+	HYPER_DMABUF_OPS_END_CPU_ACCESS,
+	HYPER_DMABUF_OPS_KMAP_ATOMIC,
+	HYPER_DMABUF_OPS_KUNMAP_ATOMIC,
+	HYPER_DMABUF_OPS_KMAP,
+	HYPER_DMABUF_OPS_KUNMAP,
+	HYPER_DMABUF_OPS_MMAP,
+	HYPER_DMABUF_OPS_VMAP,
+	HYPER_DMABUF_OPS_VUNMAP,
+};
+
+enum hyper_dmabuf_req_feedback {
+	HYPER_DMABUF_REQ_PROCESSED = 0x100,
+	HYPER_DMABUF_REQ_NEEDS_FOLLOW_UP,
+	HYPER_DMABUF_REQ_ERROR,
+	HYPER_DMABUF_REQ_NOT_RESPONDED
+};
+
+/* create a request packet with given command and operands */
+void hyper_dmabuf_create_req(struct hyper_dmabuf_req *req,
+				 enum hyper_dmabuf_command command,
+				 int *operands);
+
+/* parse incoming request packet (or response) and take
+ * appropriate actions for those
+ */
+int hyper_dmabuf_msg_parse(int domid, struct hyper_dmabuf_req *req);
+
+#endif // __HYPER_DMABUF_MSG_H__
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ops.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ops.c
new file mode 100644
index 000000000000..b4d3c2caad73
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ops.c
@@ -0,0 +1,264 @@
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
+ * SPDX-License-Identifier: (MIT OR GPL-2.0)
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
+#include <linux/dma-buf.h>
+#include "hyper_dmabuf_drv.h"
+#include "hyper_dmabuf_struct.h"
+#include "hyper_dmabuf_ops.h"
+#include "hyper_dmabuf_sgl_proc.h"
+#include "hyper_dmabuf_id.h"
+#include "hyper_dmabuf_msg.h"
+#include "hyper_dmabuf_list.h"
+
+#define WAIT_AFTER_SYNC_REQ 0
+#define REFS_PER_PAGE (PAGE_SIZE/sizeof(grant_ref_t))
+
+static int dmabuf_refcount(struct dma_buf *dma_buf)
+{
+	if ((dma_buf != NULL) && (dma_buf->file != NULL))
+		return file_count(dma_buf->file);
+
+	return -EINVAL;
+}
+
+static int hyper_dmabuf_ops_attach(struct dma_buf *dmabuf,
+				   struct device *dev,
+				   struct dma_buf_attachment *attach)
+{
+	return 0;
+}
+
+static void hyper_dmabuf_ops_detach(struct dma_buf *dmabuf,
+				    struct dma_buf_attachment *attach)
+{
+}
+
+static struct sg_table *hyper_dmabuf_ops_map(
+				struct dma_buf_attachment *attachment,
+				enum dma_data_direction dir)
+{
+	struct sg_table *st;
+	struct imported_sgt_info *imported;
+	struct pages_info *pg_info;
+
+	if (!attachment->dmabuf->priv)
+		return NULL;
+
+	imported = (struct imported_sgt_info *)attachment->dmabuf->priv;
+
+	/* extract pages from sgt */
+	pg_info = hyper_dmabuf_ext_pgs(imported->sgt);
+
+	if (!pg_info)
+		return NULL;
+
+	/* create a new sg_table with extracted pages */
+	st = hyper_dmabuf_create_sgt(pg_info->pgs, pg_info->frst_ofst,
+				     pg_info->last_len, pg_info->nents);
+	if (!st)
+		goto err_free_sg;
+
+	if (!dma_map_sg(attachment->dev, st->sgl, st->nents, dir))
+		goto err_free_sg;
+
+	kfree(pg_info->pgs);
+	kfree(pg_info);
+
+	return st;
+
+err_free_sg:
+	if (st) {
+		sg_free_table(st);
+		kfree(st);
+	}
+
+	kfree(pg_info->pgs);
+	kfree(pg_info);
+
+	return NULL;
+}
+
+static void hyper_dmabuf_ops_unmap(struct dma_buf_attachment *attachment,
+				   struct sg_table *sg,
+				   enum dma_data_direction dir)
+{
+	struct imported_sgt_info *imported;
+
+	if (!attachment->dmabuf->priv)
+		return;
+
+	imported = (struct imported_sgt_info *)attachment->dmabuf->priv;
+
+	dma_unmap_sg(attachment->dev, sg->sgl, sg->nents, dir);
+
+	sg_free_table(sg);
+	kfree(sg);
+}
+
+static void hyper_dmabuf_ops_release(struct dma_buf *dma_buf)
+{
+	struct imported_sgt_info *imported;
+	struct hyper_dmabuf_bknd_ops *bknd_ops = hy_drv_priv->bknd_ops;
+	int finish;
+
+	if (!dma_buf->priv)
+		return;
+
+	imported = (struct imported_sgt_info *)dma_buf->priv;
+
+	if (!dmabuf_refcount(imported->dma_buf))
+		imported->dma_buf = NULL;
+
+	imported->importers--;
+
+	if (imported->importers == 0) {
+		bknd_ops->unmap_shared_pages(&imported->refs_info,
+					     imported->nents);
+
+		if (imported->sgt) {
+			sg_free_table(imported->sgt);
+			kfree(imported->sgt);
+			imported->sgt = NULL;
+		}
+	}
+
+	finish = imported && !imported->valid &&
+		 !imported->importers;
+
+	/*
+	 * Check if buffer is still valid and if not remove it
+	 * from imported list. That has to be done after sending
+	 * sync request
+	 */
+	if (finish) {
+		hyper_dmabuf_remove_imported(imported->hid);
+		kfree(imported);
+	}
+}
+
+static int hyper_dmabuf_ops_begin_cpu_access(struct dma_buf *dmabuf,
+					     enum dma_data_direction dir)
+{
+	return 0;
+}
+
+static int hyper_dmabuf_ops_end_cpu_access(struct dma_buf *dmabuf,
+					   enum dma_data_direction dir)
+{
+	return 0;
+}
+
+static void *hyper_dmabuf_ops_kmap_atomic(struct dma_buf *dmabuf,
+					  unsigned long pgnum)
+{
+	/* TODO: NULL for now. Need to return the addr of mapped region */
+	return NULL;
+}
+
+static void hyper_dmabuf_ops_kunmap_atomic(struct dma_buf *dmabuf,
+					   unsigned long pgnum, void *vaddr)
+{
+}
+
+static void *hyper_dmabuf_ops_kmap(struct dma_buf *dmabuf, unsigned long pgnum)
+{
+	/* for now NULL.. need to return the address of mapped region */
+	return NULL;
+}
+
+static void hyper_dmabuf_ops_kunmap(struct dma_buf *dmabuf, unsigned long pgnum,
+				    void *vaddr)
+{
+}
+
+static int hyper_dmabuf_ops_mmap(struct dma_buf *dmabuf,
+				 struct vm_area_struct *vma)
+{
+	return 0;
+}
+
+static void *hyper_dmabuf_ops_vmap(struct dma_buf *dmabuf)
+{
+	return NULL;
+}
+
+static void hyper_dmabuf_ops_vunmap(struct dma_buf *dmabuf, void *vaddr)
+{
+}
+
+static const struct dma_buf_ops hyper_dmabuf_ops = {
+	.attach = hyper_dmabuf_ops_attach,
+	.detach = hyper_dmabuf_ops_detach,
+	.map_dma_buf = hyper_dmabuf_ops_map,
+	.unmap_dma_buf = hyper_dmabuf_ops_unmap,
+	.release = hyper_dmabuf_ops_release,
+	.begin_cpu_access = (void *)hyper_dmabuf_ops_begin_cpu_access,
+	.end_cpu_access = (void *)hyper_dmabuf_ops_end_cpu_access,
+	.map_atomic = hyper_dmabuf_ops_kmap_atomic,
+	.unmap_atomic = hyper_dmabuf_ops_kunmap_atomic,
+	.map = hyper_dmabuf_ops_kmap,
+	.unmap = hyper_dmabuf_ops_kunmap,
+	.mmap = hyper_dmabuf_ops_mmap,
+	.vmap = hyper_dmabuf_ops_vmap,
+	.vunmap = hyper_dmabuf_ops_vunmap,
+};
+
+/* exporting dmabuf as fd */
+int hyper_dmabuf_export_fd(struct imported_sgt_info *imported, int flags)
+{
+	int fd = -1;
+
+	/* call hyper_dmabuf_export_dmabuf and create
+	 * and bind a handle for it then release
+	 */
+	hyper_dmabuf_export_dma_buf(imported);
+
+	if (imported->dma_buf)
+		fd = dma_buf_fd(imported->dma_buf, flags);
+
+	return fd;
+}
+
+void hyper_dmabuf_export_dma_buf(struct imported_sgt_info *imported)
+{
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+
+	exp_info.ops = &hyper_dmabuf_ops;
+
+	/* multiple of PAGE_SIZE, not considering offset */
+	exp_info.size = imported->sgt->nents * PAGE_SIZE;
+	exp_info.flags = /* not sure about flag */ 0;
+	exp_info.priv = imported;
+
+	imported->dma_buf = dma_buf_export(&exp_info);
+}
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ops.h b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ops.h
new file mode 100644
index 000000000000..b30367f2836b
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ops.h
@@ -0,0 +1,34 @@
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
+ * SPDX-License-Identifier: (MIT OR GPL-2.0)
+ *
+ */
+
+#ifndef __HYPER_DMABUF_OPS_H__
+#define __HYPER_DMABUF_OPS_H__
+
+int hyper_dmabuf_export_fd(struct imported_sgt_info *imported, int flags);
+
+void hyper_dmabuf_export_dma_buf(struct imported_sgt_info *imported);
+
+#endif /* __HYPER_DMABUF_IMP_H__ */
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_sgl_proc.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_sgl_proc.c
new file mode 100644
index 000000000000..d92ae13d8a30
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_sgl_proc.c
@@ -0,0 +1,256 @@
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
+ * SPDX-License-Identifier: (MIT OR GPL-2.0)
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
+#include <linux/dma-buf.h>
+#include "hyper_dmabuf_drv.h"
+#include "hyper_dmabuf_struct.h"
+#include "hyper_dmabuf_sgl_proc.h"
+
+#define REFS_PER_PAGE (PAGE_SIZE/sizeof(grant_ref_t))
+
+/* return total number of pages referenced by a sgt
+ * for pre-calculation of # of pages behind a given sgt
+ */
+static int get_num_pgs(struct sg_table *sgt)
+{
+	struct scatterlist *sgl;
+	int length, i;
+	/* at least one page */
+	int num_pages = 1;
+
+	sgl = sgt->sgl;
+
+	length = sgl->length - PAGE_SIZE + sgl->offset;
+
+	/* round-up */
+	num_pages += ((length + PAGE_SIZE - 1)/PAGE_SIZE);
+
+	for (i = 1; i < sgt->nents; i++) {
+		sgl = sg_next(sgl);
+
+		/* round-up */
+		num_pages += ((sgl->length + PAGE_SIZE - 1) /
+			     PAGE_SIZE); /* round-up */
+	}
+
+	return num_pages;
+}
+
+/* extract pages directly from struct sg_table */
+struct pages_info *hyper_dmabuf_ext_pgs(struct sg_table *sgt)
+{
+	struct pages_info *pg_info;
+	int i, j, k;
+	int length;
+	struct scatterlist *sgl;
+
+	pg_info = kmalloc(sizeof(*pg_info), GFP_KERNEL);
+	if (!pg_info)
+		return NULL;
+
+	pg_info->pgs = kmalloc_array(get_num_pgs(sgt),
+				     sizeof(struct page *),
+				     GFP_KERNEL);
+
+	if (!pg_info->pgs) {
+		kfree(pg_info);
+		return NULL;
+	}
+
+	sgl = sgt->sgl;
+
+	pg_info->nents = 1;
+	pg_info->frst_ofst = sgl->offset;
+	pg_info->pgs[0] = sg_page(sgl);
+	length = sgl->length - PAGE_SIZE + sgl->offset;
+	i = 1;
+
+	while (length > 0) {
+		pg_info->pgs[i] = nth_page(sg_page(sgl), i);
+		length -= PAGE_SIZE;
+		pg_info->nents++;
+		i++;
+	}
+
+	for (j = 1; j < sgt->nents; j++) {
+		sgl = sg_next(sgl);
+		pg_info->pgs[i++] = sg_page(sgl);
+		length = sgl->length - PAGE_SIZE;
+		pg_info->nents++;
+		k = 1;
+
+		while (length > 0) {
+			pg_info->pgs[i++] = nth_page(sg_page(sgl), k++);
+			length -= PAGE_SIZE;
+			pg_info->nents++;
+		}
+	}
+
+	/*
+	 * lenght at that point will be 0 or negative,
+	 * so to calculate last page size just add it to PAGE_SIZE
+	 */
+	pg_info->last_len = PAGE_SIZE + length;
+
+	return pg_info;
+}
+
+/* create sg_table with given pages and other parameters */
+struct sg_table *hyper_dmabuf_create_sgt(struct page **pgs,
+					 int frst_ofst, int last_len,
+					 int nents)
+{
+	struct sg_table *sgt;
+	struct scatterlist *sgl;
+	int i, ret;
+
+	sgt = kmalloc(sizeof(struct sg_table), GFP_KERNEL);
+	if (!sgt)
+		return NULL;
+
+	ret = sg_alloc_table(sgt, nents, GFP_KERNEL);
+	if (ret) {
+		if (sgt) {
+			sg_free_table(sgt);
+			kfree(sgt);
+		}
+
+		return NULL;
+	}
+
+	sgl = sgt->sgl;
+
+	sg_set_page(sgl, pgs[0], PAGE_SIZE-frst_ofst, frst_ofst);
+
+	for (i = 1; i < nents-1; i++) {
+		sgl = sg_next(sgl);
+		sg_set_page(sgl, pgs[i], PAGE_SIZE, 0);
+	}
+
+	if (nents > 1) /* more than one page */ {
+		sgl = sg_next(sgl);
+		sg_set_page(sgl, pgs[i], last_len, 0);
+	}
+
+	return sgt;
+}
+
+int hyper_dmabuf_cleanup_sgt_info(struct exported_sgt_info *exported,
+				  int force)
+{
+	struct sgt_list *sgtl;
+	struct attachment_list *attachl;
+	struct kmap_vaddr_list *va_kmapl;
+	struct vmap_vaddr_list *va_vmapl;
+	struct hyper_dmabuf_bknd_ops *bknd_ops = hy_drv_priv->bknd_ops;
+
+	if (!exported) {
+		dev_err(hy_drv_priv->dev, "invalid hyper_dmabuf_id\n");
+		return -EINVAL;
+	}
+
+	/* if force != 1, sgt_info can be released only if
+	 * there's no activity on exported dma-buf on importer
+	 * side.
+	 */
+	if (!force &&
+	    exported->active) {
+		dev_warn(hy_drv_priv->dev,
+			 "dma-buf is used by importer\n");
+
+		return -EPERM;
+	}
+
+	/* force == 1 is not recommended */
+	while (!list_empty(&exported->va_kmapped->list)) {
+		va_kmapl = list_first_entry(&exported->va_kmapped->list,
+					    struct kmap_vaddr_list, list);
+
+		dma_buf_kunmap(exported->dma_buf, 1, va_kmapl->vaddr);
+		list_del(&va_kmapl->list);
+		kfree(va_kmapl);
+	}
+
+	while (!list_empty(&exported->va_vmapped->list)) {
+		va_vmapl = list_first_entry(&exported->va_vmapped->list,
+					    struct vmap_vaddr_list, list);
+
+		dma_buf_vunmap(exported->dma_buf, va_vmapl->vaddr);
+		list_del(&va_vmapl->list);
+		kfree(va_vmapl);
+	}
+
+	while (!list_empty(&exported->active_sgts->list)) {
+		attachl = list_first_entry(&exported->active_attached->list,
+					   struct attachment_list, list);
+
+		sgtl = list_first_entry(&exported->active_sgts->list,
+					struct sgt_list, list);
+
+		dma_buf_unmap_attachment(attachl->attach, sgtl->sgt,
+					 DMA_BIDIRECTIONAL);
+		list_del(&sgtl->list);
+		kfree(sgtl);
+	}
+
+	while (!list_empty(&exported->active_sgts->list)) {
+		attachl = list_first_entry(&exported->active_attached->list,
+					   struct attachment_list, list);
+
+		dma_buf_detach(exported->dma_buf, attachl->attach);
+		list_del(&attachl->list);
+		kfree(attachl);
+	}
+
+	/* Start cleanup of buffer in reverse order to exporting */
+	bknd_ops->unshare_pages(&exported->refs_info, exported->nents);
+
+	/* unmap dma-buf */
+	dma_buf_unmap_attachment(exported->active_attached->attach,
+				 exported->active_sgts->sgt,
+				 DMA_BIDIRECTIONAL);
+
+	/* detatch dma-buf */
+	dma_buf_detach(exported->dma_buf, exported->active_attached->attach);
+
+	/* close connection to dma-buf completely */
+	dma_buf_put(exported->dma_buf);
+	exported->dma_buf = NULL;
+
+	kfree(exported->active_sgts);
+	kfree(exported->active_attached);
+	kfree(exported->va_kmapped);
+	kfree(exported->va_vmapped);
+
+	return 0;
+}
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_sgl_proc.h b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_sgl_proc.h
new file mode 100644
index 000000000000..8dbc9c3dfda4
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_sgl_proc.h
@@ -0,0 +1,43 @@
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
+ * SPDX-License-Identifier: (MIT OR GPL-2.0)
+ *
+ */
+
+#ifndef __HYPER_DMABUF_IMP_H__
+#define __HYPER_DMABUF_IMP_H__
+
+/* extract pages directly from struct sg_table */
+struct pages_info *hyper_dmabuf_ext_pgs(struct sg_table *sgt);
+
+/* create sg_table with given pages and other parameters */
+struct sg_table *hyper_dmabuf_create_sgt(struct page **pgs,
+					 int frst_ofst, int last_len,
+					 int nents);
+
+int hyper_dmabuf_cleanup_sgt_info(struct exported_sgt_info *exported,
+				  int force);
+
+void hyper_dmabuf_free_sgt(struct sg_table *sgt);
+
+#endif /* __HYPER_DMABUF_IMP_H__ */
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_struct.h b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_struct.h
new file mode 100644
index 000000000000..144e3821fbc2
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_struct.h
@@ -0,0 +1,131 @@
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
+ * SPDX-License-Identifier: (MIT OR GPL-2.0)
+ *
+ */
+
+#ifndef __HYPER_DMABUF_STRUCT_H__
+#define __HYPER_DMABUF_STRUCT_H__
+
+/* stack of mapped sgts */
+struct sgt_list {
+	struct sg_table *sgt;
+	struct list_head list;
+};
+
+/* stack of attachments */
+struct attachment_list {
+	struct dma_buf_attachment *attach;
+	struct list_head list;
+};
+
+/* stack of vaddr mapped via kmap */
+struct kmap_vaddr_list {
+	void *vaddr;
+	struct list_head list;
+};
+
+/* stack of vaddr mapped via vmap */
+struct vmap_vaddr_list {
+	void *vaddr;
+	struct list_head list;
+};
+
+/* Exporter builds pages_info before sharing pages */
+struct pages_info {
+	int frst_ofst;
+	int last_len;
+	int nents;
+	struct page **pgs;
+};
+
+
+/* Exporter stores references to sgt in a hash table
+ * Exporter keeps these references for synchronization
+ * and tracking purposes
+ */
+struct exported_sgt_info {
+	hyper_dmabuf_id_t hid;
+
+	/* VM ID of importer */
+	int rdomid;
+
+	struct dma_buf *dma_buf;
+	int nents;
+
+	/* list for tracking activities on dma_buf */
+	struct sgt_list *active_sgts;
+	struct attachment_list *active_attached;
+	struct kmap_vaddr_list *va_kmapped;
+	struct vmap_vaddr_list *va_vmapped;
+
+	/* set to 0 when unexported. Importer doesn't
+	 * do a new mapping of buffer if valid == false
+	 */
+	bool valid;
+
+	/* active == true if the buffer is actively used
+	 * (mapped) by importer
+	 */
+	int active;
+
+	/* hypervisor specific reference data for shared pages */
+	void *refs_info;
+
+	struct delayed_work unexport;
+	bool unexport_sched;
+
+	/* list for file pointers associated with all user space
+	 * application that have exported this same buffer to
+	 * another VM. This needs to be tracked to know whether
+	 * the buffer can be completely freed.
+	 */
+	struct file *filp;
+};
+
+/* imported_sgt_info contains information about imported DMA_BUF
+ * this info is kept in IMPORT list and asynchorously retrieved and
+ * used to map DMA_BUF on importer VM's side upon export fd ioctl
+ * request from user-space
+ */
+
+struct imported_sgt_info {
+	hyper_dmabuf_id_t hid; /* unique id for shared dmabuf imported */
+
+	/* hypervisor-specific handle to pages */
+	int ref_handle;
+
+	/* offset and size info of DMA_BUF */
+	int frst_ofst;
+	int last_len;
+	int nents;
+
+	struct dma_buf *dma_buf;
+	struct sg_table *sgt;
+
+	void *refs_info;
+	bool valid;
+	int importers;
+};
+
+#endif /* __HYPER_DMABUF_STRUCT_H__ */
diff --git a/include/uapi/linux/hyper_dmabuf.h b/include/uapi/linux/hyper_dmabuf.h
new file mode 100644
index 000000000000..caaae2da9d4d
--- /dev/null
+++ b/include/uapi/linux/hyper_dmabuf.h
@@ -0,0 +1,87 @@
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
+#ifndef __LINUX_PUBLIC_HYPER_DMABUF_H__
+#define __LINUX_PUBLIC_HYPER_DMABUF_H__
+
+typedef struct {
+	int id;
+	int rng_key[3]; /* 12bytes long random number */
+} hyper_dmabuf_id_t;
+
+#define IOCTL_HYPER_DMABUF_TX_CH_SETUP \
+_IOC(_IOC_NONE, 'G', 0, sizeof(struct ioctl_hyper_dmabuf_tx_ch_setup))
+struct ioctl_hyper_dmabuf_tx_ch_setup {
+	/* IN parameters */
+	/* Remote domain id */
+	int remote_domain;
+};
+
+#define IOCTL_HYPER_DMABUF_RX_CH_SETUP \
+_IOC(_IOC_NONE, 'G', 1, sizeof(struct ioctl_hyper_dmabuf_rx_ch_setup))
+struct ioctl_hyper_dmabuf_rx_ch_setup {
+	/* IN parameters */
+	/* Source domain id */
+	int source_domain;
+};
+
+#define IOCTL_HYPER_DMABUF_EXPORT_REMOTE \
+_IOC(_IOC_NONE, 'G', 2, sizeof(struct ioctl_hyper_dmabuf_export_remote))
+struct ioctl_hyper_dmabuf_export_remote {
+	/* IN parameters */
+	/* DMA buf fd to be exported */
+	int dmabuf_fd;
+	/* Domain id to which buffer should be exported */
+	int remote_domain;
+	/* exported dma buf id */
+	hyper_dmabuf_id_t hid;
+};
+
+#define IOCTL_HYPER_DMABUF_EXPORT_FD \
+_IOC(_IOC_NONE, 'G', 3, sizeof(struct ioctl_hyper_dmabuf_export_fd))
+struct ioctl_hyper_dmabuf_export_fd {
+	/* IN parameters */
+	/* hyper dmabuf id to be imported */
+	hyper_dmabuf_id_t hid;
+	/* flags */
+	int flags;
+	/* OUT parameters */
+	/* exported dma buf fd */
+	int fd;
+};
+
+#define IOCTL_HYPER_DMABUF_UNEXPORT \
+_IOC(_IOC_NONE, 'G', 4, sizeof(struct ioctl_hyper_dmabuf_unexport))
+struct ioctl_hyper_dmabuf_unexport {
+	/* IN parameters */
+	/* hyper dmabuf id to be unexported */
+	hyper_dmabuf_id_t hid;
+	/* delay in ms by which unexport processing will be postponed */
+	int delay_ms;
+	/* OUT parameters */
+	/* Status of request */
+	int status;
+};
+
+#endif //__LINUX_PUBLIC_HYPER_DMABUF_H__
-- 
2.16.1
