Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966505AbeBNBvb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 20:51:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:56116 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966456AbeBNBv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 20:51:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,510,1511856000";
   d="scan'208";a="34498954"
From: Dongwon Kim <dongwon.kim@intel.com>
To: linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        xen-devel@lists.xenproject.org
Cc: dri-devel@lists.freedesktop.org, dongwon.kim@intel.com,
        mateuszx.potrola@intel.com, sumit.semwal@linaro.org
Subject: [RFC PATCH v2 7/9] hyper_dmabuf: query ioctl for retreiving various hyper_DMABUF info
Date: Tue, 13 Feb 2018 17:50:06 -0800
Message-Id: <20180214015008.9513-8-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180214015008.9513-1-dongwon.kim@intel.com>
References: <20180214015008.9513-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new ioctl, "IOCTL_HYPER_DMABUF_QUERY" for the userspace to
retreive various information about hyper_DMABUF, currently being shared
across VMs.

Supported query items are as followed:

enum hyper_dmabuf_query {
        HYPER_DMABUF_QUERY_TYPE = 0x10,
        HYPER_DMABUF_QUERY_EXPORTER,
        HYPER_DMABUF_QUERY_IMPORTER,
        HYPER_DMABUF_QUERY_SIZE,
        HYPER_DMABUF_QUERY_BUSY,
        HYPER_DMABUF_QUERY_UNEXPORTED,
        HYPER_DMABUF_QUERY_DELAYED_UNEXPORTED,
        HYPER_DMABUF_QUERY_PRIV_INFO_SIZE,
        HYPER_DMABUF_QUERY_PRIV_INFO,
};

Query IOCTL call with each query item above returns,

HYPER_DMABUF_QUERY_TYPE - type - EXPORTED/IMPORTED of hyper_DMABUF from
current VM's perspective.

HYPER_DMABUF_QUERY_EXPORTER - ID of exporting VM

HYPER_DMABUF_QUERY_IMPORTER - ID of importing VM

HYPER_DMABUF_QUERY_SIZE - size of shared buffer in byte

HYPER_DMABUF_QUERY_BUSY - true if hyper_DMABUF is being actively used
(e.g. attached and mapped by end-consumer)

HYPER_DMABUF_QUERY_UNEXPORTED - true if hyper_DMABUF has been unexported
on exporting VM's side.

HYPER_DMABUF_QUERY_DELAYED_UNEXPORTED - true if hyper_DMABUF is scheduled
to be unexported (still valid but will be unexported soon)

HYPER_DMABUF_QUERY_PRIV_INFO_SIZE - size of private information (given by
user application on exporter's side) attached to hyper_DMABUF

HYPER_DMABUF_QUERY_PRIV_INFO - private information attached to hyper_DMABUF

Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Signed-off-by: Mateusz Polrola <mateuszx.potrola@intel.com>
---
 drivers/dma-buf/hyper_dmabuf/Makefile             |   1 +
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.c |  49 +++++-
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_query.c | 174 ++++++++++++++++++++++
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_query.h |  36 +++++
 include/uapi/linux/hyper_dmabuf.h                 |  32 ++++
 5 files changed, 291 insertions(+), 1 deletion(-)
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_query.c
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_query.h

diff --git a/drivers/dma-buf/hyper_dmabuf/Makefile b/drivers/dma-buf/hyper_dmabuf/Makefile
index 702696f29215..578a669a0d3e 100644
--- a/drivers/dma-buf/hyper_dmabuf/Makefile
+++ b/drivers/dma-buf/hyper_dmabuf/Makefile
@@ -10,6 +10,7 @@ ifneq ($(KERNELRELEASE),)
 				 hyper_dmabuf_msg.o \
 				 hyper_dmabuf_id.o \
 				 hyper_dmabuf_remote_sync.o \
+				 hyper_dmabuf_query.o \
 
 ifeq ($(CONFIG_HYPER_DMABUF_XEN), y)
 	$(TARGET_MODULE)-objs += backends/xen/hyper_dmabuf_xen_comm.o \
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.c
index 168ccf98f710..e90e59cd0568 100644
--- a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.c
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.c
@@ -41,6 +41,7 @@
 #include "hyper_dmabuf_msg.h"
 #include "hyper_dmabuf_sgl_proc.h"
 #include "hyper_dmabuf_ops.h"
+#include "hyper_dmabuf_query.h"
 
 static int hyper_dmabuf_tx_ch_setup_ioctl(struct file *filp, void *data)
 {
@@ -543,7 +544,6 @@ static int hyper_dmabuf_export_fd_ioctl(struct file *filp, void *data)
 			hyper_dmabuf_create_req(req,
 						HYPER_DMABUF_EXPORT_FD_FAILED,
 						&op[0]);
-
 			bknd_ops->send_req(HYPER_DMABUF_DOM_ID(imported->hid),
 					   req, false);
 			kfree(req);
@@ -682,6 +682,51 @@ int hyper_dmabuf_unexport_ioctl(struct file *filp, void *data)
 	return 0;
 }
 
+static int hyper_dmabuf_query_ioctl(struct file *filp, void *data)
+{
+	struct ioctl_hyper_dmabuf_query *query_attr =
+			(struct ioctl_hyper_dmabuf_query *)data;
+	struct exported_sgt_info *exported = NULL;
+	struct imported_sgt_info *imported = NULL;
+	int ret = 0;
+
+	if (HYPER_DMABUF_DOM_ID(query_attr->hid) == hy_drv_priv->domid) {
+		/* query for exported dmabuf */
+		exported = hyper_dmabuf_find_exported(query_attr->hid);
+		if (exported) {
+			ret = hyper_dmabuf_query_exported(exported,
+							  query_attr->item,
+							  &query_attr->info);
+		} else {
+			dev_err(hy_drv_priv->dev,
+				"hid {id:%d key:%d %d %d} not in exp list\n",
+				query_attr->hid.id,
+				query_attr->hid.rng_key[0],
+				query_attr->hid.rng_key[1],
+				query_attr->hid.rng_key[2]);
+			return -ENOENT;
+		}
+	} else {
+		/* query for imported dmabuf */
+		imported = hyper_dmabuf_find_imported(query_attr->hid);
+		if (imported) {
+			ret = hyper_dmabuf_query_imported(imported,
+							  query_attr->item,
+							  &query_attr->info);
+		} else {
+			dev_err(hy_drv_priv->dev,
+				"hid {id:%d key:%d %d %d} not in imp list\n",
+				query_attr->hid.id,
+				query_attr->hid.rng_key[0],
+				query_attr->hid.rng_key[1],
+				query_attr->hid.rng_key[2]);
+			return -ENOENT;
+		}
+	}
+
+	return ret;
+}
+
 const struct hyper_dmabuf_ioctl_desc hyper_dmabuf_ioctls[] = {
 	HYPER_DMABUF_IOCTL_DEF(IOCTL_HYPER_DMABUF_TX_CH_SETUP,
 			       hyper_dmabuf_tx_ch_setup_ioctl, 0),
@@ -693,6 +738,8 @@ const struct hyper_dmabuf_ioctl_desc hyper_dmabuf_ioctls[] = {
 			       hyper_dmabuf_export_fd_ioctl, 0),
 	HYPER_DMABUF_IOCTL_DEF(IOCTL_HYPER_DMABUF_UNEXPORT,
 			       hyper_dmabuf_unexport_ioctl, 0),
+	HYPER_DMABUF_IOCTL_DEF(IOCTL_HYPER_DMABUF_QUERY,
+			       hyper_dmabuf_query_ioctl, 0),
 };
 
 long hyper_dmabuf_ioctl(struct file *filp,
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_query.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_query.c
new file mode 100644
index 000000000000..edf92318d4cd
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_query.c
@@ -0,0 +1,174 @@
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
+#include <linux/dma-buf.h>
+#include <linux/uaccess.h>
+#include "hyper_dmabuf_drv.h"
+#include "hyper_dmabuf_struct.h"
+#include "hyper_dmabuf_id.h"
+
+#define HYPER_DMABUF_SIZE(nents, first_offset, last_len) \
+	((nents)*PAGE_SIZE - (first_offset) - PAGE_SIZE + (last_len))
+
+int hyper_dmabuf_query_exported(struct exported_sgt_info *exported,
+				int query, unsigned long *info)
+{
+	switch (query) {
+	case HYPER_DMABUF_QUERY_TYPE:
+		*info = EXPORTED;
+		break;
+
+	/* exporting domain of this specific dmabuf*/
+	case HYPER_DMABUF_QUERY_EXPORTER:
+		*info = HYPER_DMABUF_DOM_ID(exported->hid);
+		break;
+
+	/* importing domain of this specific dmabuf */
+	case HYPER_DMABUF_QUERY_IMPORTER:
+		*info = exported->rdomid;
+		break;
+
+	/* size of dmabuf in byte */
+	case HYPER_DMABUF_QUERY_SIZE:
+		*info = exported->dma_buf->size;
+		break;
+
+	/* whether the buffer is used by importer */
+	case HYPER_DMABUF_QUERY_BUSY:
+		*info = (exported->active > 0);
+		break;
+
+	/* whether the buffer is unexported */
+	case HYPER_DMABUF_QUERY_UNEXPORTED:
+		*info = !exported->valid;
+		break;
+
+	/* whether the buffer is scheduled to be unexported */
+	case HYPER_DMABUF_QUERY_DELAYED_UNEXPORTED:
+		*info = !exported->unexport_sched;
+		break;
+
+	/* size of private info attached to buffer */
+	case HYPER_DMABUF_QUERY_PRIV_INFO_SIZE:
+		*info = exported->sz_priv;
+		break;
+
+	/* copy private info attached to buffer */
+	case HYPER_DMABUF_QUERY_PRIV_INFO:
+		if (exported->sz_priv > 0) {
+			int n;
+
+			n = copy_to_user((void __user *) *info,
+					exported->priv,
+					exported->sz_priv);
+			if (n != 0)
+				return -EINVAL;
+		}
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
+int hyper_dmabuf_query_imported(struct imported_sgt_info *imported,
+				int query, unsigned long *info)
+{
+	switch (query) {
+	case HYPER_DMABUF_QUERY_TYPE:
+		*info = IMPORTED;
+		break;
+
+	/* exporting domain of this specific dmabuf*/
+	case HYPER_DMABUF_QUERY_EXPORTER:
+		*info = HYPER_DMABUF_DOM_ID(imported->hid);
+		break;
+
+	/* importing domain of this specific dmabuf */
+	case HYPER_DMABUF_QUERY_IMPORTER:
+		*info = hy_drv_priv->domid;
+		break;
+
+	/* size of dmabuf in byte */
+	case HYPER_DMABUF_QUERY_SIZE:
+		if (imported->dma_buf) {
+			/* if local dma_buf is created (if it's
+			 * ever mapped), retrieve it directly
+			 * from struct dma_buf *
+			 */
+			*info = imported->dma_buf->size;
+		} else {
+			/* calcuate it from given nents, frst_ofst
+			 * and last_len
+			 */
+			*info = HYPER_DMABUF_SIZE(imported->nents,
+						  imported->frst_ofst,
+						  imported->last_len);
+		}
+		break;
+
+	/* whether the buffer is used or not */
+	case HYPER_DMABUF_QUERY_BUSY:
+		/* checks if it's used by importer */
+		*info = (imported->importers > 0);
+		break;
+
+	/* whether the buffer is unexported */
+	case HYPER_DMABUF_QUERY_UNEXPORTED:
+		*info = !imported->valid;
+		break;
+
+	/* size of private info attached to buffer */
+	case HYPER_DMABUF_QUERY_PRIV_INFO_SIZE:
+		*info = imported->sz_priv;
+		break;
+
+	/* copy private info attached to buffer */
+	case HYPER_DMABUF_QUERY_PRIV_INFO:
+		if (imported->sz_priv > 0) {
+			int n;
+
+			n = copy_to_user((void __user *)*info,
+					imported->priv,
+					imported->sz_priv);
+			if (n != 0)
+				return -EINVAL;
+		}
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_query.h b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_query.h
new file mode 100644
index 000000000000..b9687db7e7d5
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_query.h
@@ -0,0 +1,36 @@
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
+#ifndef __HYPER_DMABUF_QUERY_H__
+#define __HYPER_DMABUF_QUERY_H__
+
+int hyper_dmabuf_query_imported(struct imported_sgt_info *imported,
+				int query, unsigned long *info);
+
+int hyper_dmabuf_query_exported(struct exported_sgt_info *exported,
+				int query, unsigned long *info);
+
+#endif // __HYPER_DMABUF_QUERY_H__
diff --git a/include/uapi/linux/hyper_dmabuf.h b/include/uapi/linux/hyper_dmabuf.h
index 36794a4af811..4f8e8ac0375b 100644
--- a/include/uapi/linux/hyper_dmabuf.h
+++ b/include/uapi/linux/hyper_dmabuf.h
@@ -88,4 +88,36 @@ struct ioctl_hyper_dmabuf_unexport {
 	int status;
 };
 
+#define IOCTL_HYPER_DMABUF_QUERY \
+_IOC(_IOC_NONE, 'G', 5, sizeof(struct ioctl_hyper_dmabuf_query))
+struct ioctl_hyper_dmabuf_query {
+	/* in parameters */
+	/* hyper dmabuf id to be queried */
+	hyper_dmabuf_id_t hid;
+	/* item to be queried */
+	int item;
+	/* OUT parameters */
+	/* Value of queried item */
+	unsigned long info;
+};
+
+/* DMABUF query */
+
+enum hyper_dmabuf_query {
+	HYPER_DMABUF_QUERY_TYPE = 0x10,
+	HYPER_DMABUF_QUERY_EXPORTER,
+	HYPER_DMABUF_QUERY_IMPORTER,
+	HYPER_DMABUF_QUERY_SIZE,
+	HYPER_DMABUF_QUERY_BUSY,
+	HYPER_DMABUF_QUERY_UNEXPORTED,
+	HYPER_DMABUF_QUERY_DELAYED_UNEXPORTED,
+	HYPER_DMABUF_QUERY_PRIV_INFO_SIZE,
+	HYPER_DMABUF_QUERY_PRIV_INFO,
+};
+
+enum hyper_dmabuf_status {
+	EXPORTED = 0x01,
+	IMPORTED,
+};
+
 #endif //__LINUX_PUBLIC_HYPER_DMABUF_H__
-- 
2.16.1
