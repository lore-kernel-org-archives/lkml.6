Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966543AbeBNBwe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 20:52:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:56121 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966455AbeBNBv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 20:51:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,510,1511856000";
   d="scan'208";a="34498951"
From: Dongwon Kim <dongwon.kim@intel.com>
To: linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        xen-devel@lists.xenproject.org
Cc: dri-devel@lists.freedesktop.org, dongwon.kim@intel.com,
        mateuszx.potrola@intel.com, sumit.semwal@linaro.org
Subject: [RFC PATCH v2 6/9] hyper_dmabuf: hyper_DMABUF synchronization across VM
Date: Tue, 13 Feb 2018 17:50:05 -0800
Message-Id: <20180214015008.9513-7-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180214015008.9513-1-dongwon.kim@intel.com>
References: <20180214015008.9513-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of hyper_DMABUF operations now (hyper_dmabuf_ops.c) send a message
to the exporting VM for synchronization between two VMs. For this, every
mapping done by importer will make exporter perform shadow mapping of
original DMA-BUF. Then all consecutive DMA-BUF operations (attach, detach,
map/unmap and so on) will be mimicked on this shadowed DMA-BUF for tracking
and synchronization purpose (e.g. +-reference count to check the status).

Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Signed-off-by: Mateusz Polrola <mateuszx.potrola@intel.com>
---
 drivers/dma-buf/hyper_dmabuf/Makefile              |   1 +
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c    |  53 +++-
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.h    |   2 +
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ops.c    | 157 +++++++++-
 .../hyper_dmabuf/hyper_dmabuf_remote_sync.c        | 324 +++++++++++++++++++++
 .../hyper_dmabuf/hyper_dmabuf_remote_sync.h        |  32 ++
 6 files changed, 565 insertions(+), 4 deletions(-)
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_remote_sync.c
 create mode 100644 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_remote_sync.h

diff --git a/drivers/dma-buf/hyper_dmabuf/Makefile b/drivers/dma-buf/hyper_dmabuf/Makefile
index b9ab4eeca6f2..702696f29215 100644
--- a/drivers/dma-buf/hyper_dmabuf/Makefile
+++ b/drivers/dma-buf/hyper_dmabuf/Makefile
@@ -9,6 +9,7 @@ ifneq ($(KERNELRELEASE),)
 				 hyper_dmabuf_ops.o \
 				 hyper_dmabuf_msg.o \
 				 hyper_dmabuf_id.o \
+				 hyper_dmabuf_remote_sync.o \
 
 ifeq ($(CONFIG_HYPER_DMABUF_XEN), y)
 	$(TARGET_MODULE)-objs += backends/xen/hyper_dmabuf_xen_comm.o \
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c
index 7176fa8fb139..1592d5cfaa52 100644
--- a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c
@@ -34,6 +34,7 @@
 #include <linux/workqueue.h>
 #include "hyper_dmabuf_drv.h"
 #include "hyper_dmabuf_msg.h"
+#include "hyper_dmabuf_remote_sync.h"
 #include "hyper_dmabuf_list.h"
 
 struct cmd_process {
@@ -92,6 +93,25 @@ void hyper_dmabuf_create_req(struct hyper_dmabuf_req *req,
 			req->op[i] = op[i];
 		break;
 
+	case HYPER_DMABUF_OPS_TO_REMOTE:
+		/* notifying dmabuf map/unmap to importer (probably not needed)
+		 * for dmabuf synchronization
+		 */
+		break;
+
+	case HYPER_DMABUF_OPS_TO_SOURCE:
+		/* notifying dmabuf map/unmap to exporter, map will make
+		 * the driver to do shadow mapping or unmapping for
+		 * synchronization with original exporter (e.g. i915)
+		 *
+		 * command : DMABUF_OPS_TO_SOURCE.
+		 * op0~3 : hyper_dmabuf_id
+		 * op4 : map(=1)/unmap(=2)/attach(=3)/detach(=4)
+		 */
+		for (i = 0; i < 5; i++)
+			req->op[i] = op[i];
+		break;
+
 	default:
 		/* no command found */
 		return;
@@ -201,6 +221,12 @@ static void cmd_process_work(struct work_struct *work)
 
 		break;
 
+	case HYPER_DMABUF_OPS_TO_REMOTE:
+		/* notifying dmabuf map/unmap to importer
+		 * (probably not needed) for dmabuf synchronization
+		 */
+		break;
+
 	default:
 		/* shouldn't get here */
 		break;
@@ -217,6 +243,7 @@ int hyper_dmabuf_msg_parse(int domid, struct hyper_dmabuf_req *req)
 	struct imported_sgt_info *imported;
 	struct exported_sgt_info *exported;
 	hyper_dmabuf_id_t hid;
+	int ret;
 
 	if (!req) {
 		dev_err(hy_drv_priv->dev, "request is NULL\n");
@@ -229,7 +256,7 @@ int hyper_dmabuf_msg_parse(int domid, struct hyper_dmabuf_req *req)
 	hid.rng_key[2] = req->op[3];
 
 	if ((req->cmd < HYPER_DMABUF_EXPORT) ||
-		(req->cmd > HYPER_DMABUF_NOTIFY_UNEXPORT)) {
+		(req->cmd > HYPER_DMABUF_OPS_TO_SOURCE)) {
 		dev_err(hy_drv_priv->dev, "invalid command\n");
 		return -EINVAL;
 	}
@@ -271,6 +298,30 @@ int hyper_dmabuf_msg_parse(int domid, struct hyper_dmabuf_req *req)
 		return req->cmd;
 	}
 
+	/* dma buf remote synchronization */
+	if (req->cmd == HYPER_DMABUF_OPS_TO_SOURCE) {
+		/* notifying dmabuf map/unmap to exporter, map will
+		 * make the driver to do shadow mapping
+		 * or unmapping for synchronization with original
+		 * exporter (e.g. i915)
+		 *
+		 * command : DMABUF_OPS_TO_SOURCE.
+		 * op0~3 : hyper_dmabuf_id
+		 * op1 : enum hyper_dmabuf_ops {....}
+		 */
+		dev_dbg(hy_drv_priv->dev,
+			"%s: HYPER_DMABUF_OPS_TO_SOURCE\n", __func__);
+
+		ret = hyper_dmabuf_remote_sync(hid, req->op[4]);
+
+		if (ret)
+			req->stat = HYPER_DMABUF_REQ_ERROR;
+		else
+			req->stat = HYPER_DMABUF_REQ_PROCESSED;
+
+		return req->cmd;
+	}
+
 	/* synchronous dma_buf_fd export */
 	if (req->cmd == HYPER_DMABUF_EXPORT_FD) {
 		/* find a corresponding SGT for the id */
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.h b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.h
index 63a39d068d69..82d2900d3077 100644
--- a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.h
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.h
@@ -48,6 +48,8 @@ enum hyper_dmabuf_command {
 	HYPER_DMABUF_EXPORT_FD,
 	HYPER_DMABUF_EXPORT_FD_FAILED,
 	HYPER_DMABUF_NOTIFY_UNEXPORT,
+	HYPER_DMABUF_OPS_TO_REMOTE,
+	HYPER_DMABUF_OPS_TO_SOURCE,
 };
 
 enum hyper_dmabuf_ops {
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ops.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ops.c
index b4d3c2caad73..02d42c099ad9 100644
--- a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ops.c
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ops.c
@@ -51,16 +51,71 @@ static int dmabuf_refcount(struct dma_buf *dma_buf)
 	return -EINVAL;
 }
 
+static int sync_request(hyper_dmabuf_id_t hid, int dmabuf_ops)
+{
+	struct hyper_dmabuf_req *req;
+	struct hyper_dmabuf_bknd_ops *bknd_ops = hy_drv_priv->bknd_ops;
+	int op[5];
+	int i;
+	int ret;
+
+	op[0] = hid.id;
+
+	for (i = 0; i < 3; i++)
+		op[i+1] = hid.rng_key[i];
+
+	op[4] = dmabuf_ops;
+
+	req = kcalloc(1, sizeof(*req), GFP_KERNEL);
+
+	if (!req)
+		return -ENOMEM;
+
+	hyper_dmabuf_create_req(req, HYPER_DMABUF_OPS_TO_SOURCE, &op[0]);
+
+	/* send request and wait for a response */
+	ret = bknd_ops->send_req(HYPER_DMABUF_DOM_ID(hid), req,
+				 WAIT_AFTER_SYNC_REQ);
+
+	if (ret < 0) {
+		dev_dbg(hy_drv_priv->dev,
+			"dmabuf sync request failed:%d\n", req->op[4]);
+	}
+
+	kfree(req);
+
+	return ret;
+}
+
 static int hyper_dmabuf_ops_attach(struct dma_buf *dmabuf,
 				   struct device *dev,
 				   struct dma_buf_attachment *attach)
 {
-	return 0;
+	struct imported_sgt_info *imported;
+	int ret;
+
+	if (!attach->dmabuf->priv)
+		return -EINVAL;
+
+	imported = (struct imported_sgt_info *)attach->dmabuf->priv;
+
+	ret = sync_request(imported->hid, HYPER_DMABUF_OPS_ATTACH);
+
+	return ret;
 }
 
 static void hyper_dmabuf_ops_detach(struct dma_buf *dmabuf,
 				    struct dma_buf_attachment *attach)
 {
+	struct imported_sgt_info *imported;
+	int ret;
+
+	if (!attach->dmabuf->priv)
+		return;
+
+	imported = (struct imported_sgt_info *)attach->dmabuf->priv;
+
+	ret = sync_request(imported->hid, HYPER_DMABUF_OPS_DETACH);
 }
 
 static struct sg_table *hyper_dmabuf_ops_map(
@@ -70,6 +125,7 @@ static struct sg_table *hyper_dmabuf_ops_map(
 	struct sg_table *st;
 	struct imported_sgt_info *imported;
 	struct pages_info *pg_info;
+	int ret;
 
 	if (!attachment->dmabuf->priv)
 		return NULL;
@@ -91,6 +147,8 @@ static struct sg_table *hyper_dmabuf_ops_map(
 	if (!dma_map_sg(attachment->dev, st->sgl, st->nents, dir))
 		goto err_free_sg;
 
+	ret = sync_request(imported->hid, HYPER_DMABUF_OPS_MAP);
+
 	kfree(pg_info->pgs);
 	kfree(pg_info);
 
@@ -113,6 +171,7 @@ static void hyper_dmabuf_ops_unmap(struct dma_buf_attachment *attachment,
 				   enum dma_data_direction dir)
 {
 	struct imported_sgt_info *imported;
+	int ret;
 
 	if (!attachment->dmabuf->priv)
 		return;
@@ -123,12 +182,15 @@ static void hyper_dmabuf_ops_unmap(struct dma_buf_attachment *attachment,
 
 	sg_free_table(sg);
 	kfree(sg);
+
+	ret = sync_request(imported->hid, HYPER_DMABUF_OPS_UNMAP);
 }
 
 static void hyper_dmabuf_ops_release(struct dma_buf *dma_buf)
 {
 	struct imported_sgt_info *imported;
 	struct hyper_dmabuf_bknd_ops *bknd_ops = hy_drv_priv->bknd_ops;
+	int ret;
 	int finish;
 
 	if (!dma_buf->priv)
@@ -155,6 +217,8 @@ static void hyper_dmabuf_ops_release(struct dma_buf *dma_buf)
 	finish = imported && !imported->valid &&
 		 !imported->importers;
 
+	ret = sync_request(imported->hid, HYPER_DMABUF_OPS_RELEASE);
+
 	/*
 	 * Check if buffer is still valid and if not remove it
 	 * from imported list. That has to be done after sending
@@ -169,18 +233,48 @@ static void hyper_dmabuf_ops_release(struct dma_buf *dma_buf)
 static int hyper_dmabuf_ops_begin_cpu_access(struct dma_buf *dmabuf,
 					     enum dma_data_direction dir)
 {
-	return 0;
+	struct imported_sgt_info *imported;
+	int ret;
+
+	if (!dmabuf->priv)
+		return -EINVAL;
+
+	imported = (struct imported_sgt_info *)dmabuf->priv;
+
+	ret = sync_request(imported->hid, HYPER_DMABUF_OPS_BEGIN_CPU_ACCESS);
+
+	return ret;
 }
 
 static int hyper_dmabuf_ops_end_cpu_access(struct dma_buf *dmabuf,
 					   enum dma_data_direction dir)
 {
+	struct imported_sgt_info *imported;
+	int ret;
+
+	if (!dmabuf->priv)
+		return -EINVAL;
+
+	imported = (struct imported_sgt_info *)dmabuf->priv;
+
+	ret = sync_request(imported->hid, HYPER_DMABUF_OPS_END_CPU_ACCESS);
+
 	return 0;
 }
 
 static void *hyper_dmabuf_ops_kmap_atomic(struct dma_buf *dmabuf,
 					  unsigned long pgnum)
 {
+	struct imported_sgt_info *imported;
+	int ret;
+
+	if (!dmabuf->priv)
+		return NULL;
+
+	imported = (struct imported_sgt_info *)dmabuf->priv;
+
+	ret = sync_request(imported->hid, HYPER_DMABUF_OPS_KMAP_ATOMIC);
+
 	/* TODO: NULL for now. Need to return the addr of mapped region */
 	return NULL;
 }
@@ -188,10 +282,29 @@ static void *hyper_dmabuf_ops_kmap_atomic(struct dma_buf *dmabuf,
 static void hyper_dmabuf_ops_kunmap_atomic(struct dma_buf *dmabuf,
 					   unsigned long pgnum, void *vaddr)
 {
+	struct imported_sgt_info *imported;
+	int ret;
+
+	if (!dmabuf->priv)
+		return;
+
+	imported = (struct imported_sgt_info *)dmabuf->priv;
+
+	ret = sync_request(imported->hid, HYPER_DMABUF_OPS_KUNMAP_ATOMIC);
 }
 
 static void *hyper_dmabuf_ops_kmap(struct dma_buf *dmabuf, unsigned long pgnum)
 {
+	struct imported_sgt_info *imported;
+	int ret;
+
+	if (!dmabuf->priv)
+		return NULL;
+
+	imported = (struct imported_sgt_info *)dmabuf->priv;
+
+	ret = sync_request(imported->hid, HYPER_DMABUF_OPS_KMAP);
+
 	/* for now NULL.. need to return the address of mapped region */
 	return NULL;
 }
@@ -199,21 +312,59 @@ static void *hyper_dmabuf_ops_kmap(struct dma_buf *dmabuf, unsigned long pgnum)
 static void hyper_dmabuf_ops_kunmap(struct dma_buf *dmabuf, unsigned long pgnum,
 				    void *vaddr)
 {
+	struct imported_sgt_info *imported;
+	int ret;
+
+	if (!dmabuf->priv)
+		return;
+
+	imported = (struct imported_sgt_info *)dmabuf->priv;
+
+	ret = sync_request(imported->hid, HYPER_DMABUF_OPS_KUNMAP);
 }
 
 static int hyper_dmabuf_ops_mmap(struct dma_buf *dmabuf,
 				 struct vm_area_struct *vma)
 {
-	return 0;
+	struct imported_sgt_info *imported;
+	int ret;
+
+	if (!dmabuf->priv)
+		return -EINVAL;
+
+	imported = (struct imported_sgt_info *)dmabuf->priv;
+
+	ret = sync_request(imported->hid, HYPER_DMABUF_OPS_MMAP);
+
+	return ret;
 }
 
 static void *hyper_dmabuf_ops_vmap(struct dma_buf *dmabuf)
 {
+	struct imported_sgt_info *imported;
+	int ret;
+
+	if (!dmabuf->priv)
+		return NULL;
+
+	imported = (struct imported_sgt_info *)dmabuf->priv;
+
+	ret = sync_request(imported->hid, HYPER_DMABUF_OPS_VMAP);
+
 	return NULL;
 }
 
 static void hyper_dmabuf_ops_vunmap(struct dma_buf *dmabuf, void *vaddr)
 {
+	struct imported_sgt_info *imported;
+	int ret;
+
+	if (!dmabuf->priv)
+		return;
+
+	imported = (struct imported_sgt_info *)dmabuf->priv;
+
+	ret = sync_request(imported->hid, HYPER_DMABUF_OPS_VUNMAP);
 }
 
 static const struct dma_buf_ops hyper_dmabuf_ops = {
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_remote_sync.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_remote_sync.c
new file mode 100644
index 000000000000..55c2c1828859
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_remote_sync.c
@@ -0,0 +1,324 @@
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
+#include "hyper_dmabuf_list.h"
+#include "hyper_dmabuf_msg.h"
+#include "hyper_dmabuf_id.h"
+#include "hyper_dmabuf_sgl_proc.h"
+
+/* Whenever importer does dma operations from remote domain,
+ * a notification is sent to the exporter so that exporter
+ * issues equivalent dma operation on the original dma buf
+ * for indirect synchronization via shadow operations.
+ *
+ * All ptrs and references (e.g struct sg_table*,
+ * struct dma_buf_attachment) created via these operations on
+ * exporter's side are kept in stack (implemented as circular
+ * linked-lists) separately so that those can be re-referenced
+ * later when unmapping operations are invoked to free those.
+ *
+ * The very first element on the bottom of each stack holds
+ * is what is created when initial exporting is issued so it
+ * should not be modified or released by this fuction.
+ */
+int hyper_dmabuf_remote_sync(hyper_dmabuf_id_t hid, int ops)
+{
+	struct exported_sgt_info *exported;
+	struct sgt_list *sgtl;
+	struct attachment_list *attachl;
+	struct kmap_vaddr_list *va_kmapl;
+	struct vmap_vaddr_list *va_vmapl;
+	int ret;
+
+	/* find a coresponding SGT for the id */
+	exported = hyper_dmabuf_find_exported(hid);
+
+	if (!exported) {
+		dev_err(hy_drv_priv->dev,
+			"dmabuf remote sync::can't find exported list\n");
+		return -ENOENT;
+	}
+
+	switch (ops) {
+	case HYPER_DMABUF_OPS_ATTACH:
+		attachl = kcalloc(1, sizeof(*attachl), GFP_KERNEL);
+
+		if (!attachl)
+			return -ENOMEM;
+
+		attachl->attach = dma_buf_attach(exported->dma_buf,
+						 hy_drv_priv->dev);
+
+		if (!attachl->attach) {
+			kfree(attachl);
+			dev_err(hy_drv_priv->dev,
+				"remote sync::HYPER_DMABUF_OPS_ATTACH\n");
+			return -ENOMEM;
+		}
+
+		list_add(&attachl->list, &exported->active_attached->list);
+		break;
+
+	case HYPER_DMABUF_OPS_DETACH:
+		if (list_empty(&exported->active_attached->list)) {
+			dev_err(hy_drv_priv->dev,
+				"remote sync::HYPER_DMABUF_OPS_DETACH\n");
+			dev_err(hy_drv_priv->dev,
+				"no more dmabuf attachment left to be detached\n");
+			return -EFAULT;
+		}
+
+		attachl = list_first_entry(&exported->active_attached->list,
+					   struct attachment_list, list);
+
+		dma_buf_detach(exported->dma_buf, attachl->attach);
+		list_del(&attachl->list);
+		kfree(attachl);
+		break;
+
+	case HYPER_DMABUF_OPS_MAP:
+		if (list_empty(&exported->active_attached->list)) {
+			dev_err(hy_drv_priv->dev,
+				"remote sync::HYPER_DMABUF_OPS_MAP\n");
+			dev_err(hy_drv_priv->dev,
+				"no more dmabuf attachment left to be mapped\n");
+			return -EFAULT;
+		}
+
+		attachl = list_first_entry(&exported->active_attached->list,
+					   struct attachment_list, list);
+
+		sgtl = kcalloc(1, sizeof(*sgtl), GFP_KERNEL);
+
+		if (!sgtl)
+			return -ENOMEM;
+
+		sgtl->sgt = dma_buf_map_attachment(attachl->attach,
+						   DMA_BIDIRECTIONAL);
+		if (!sgtl->sgt) {
+			kfree(sgtl);
+			dev_err(hy_drv_priv->dev,
+				"remote sync::HYPER_DMABUF_OPS_MAP\n");
+			return -ENOMEM;
+		}
+		list_add(&sgtl->list, &exported->active_sgts->list);
+		break;
+
+	case HYPER_DMABUF_OPS_UNMAP:
+		if (list_empty(&exported->active_sgts->list) ||
+		    list_empty(&exported->active_attached->list)) {
+			dev_err(hy_drv_priv->dev,
+				"remote sync::HYPER_DMABUF_OPS_UNMAP\n");
+			dev_err(hy_drv_priv->dev,
+				"no SGT or attach left to be unmapped\n");
+			return -EFAULT;
+		}
+
+		attachl = list_first_entry(&exported->active_attached->list,
+					   struct attachment_list, list);
+		sgtl = list_first_entry(&exported->active_sgts->list,
+					struct sgt_list, list);
+
+		dma_buf_unmap_attachment(attachl->attach, sgtl->sgt,
+					 DMA_BIDIRECTIONAL);
+		list_del(&sgtl->list);
+		kfree(sgtl);
+		break;
+
+	case HYPER_DMABUF_OPS_RELEASE:
+		dev_dbg(hy_drv_priv->dev,
+			"id:%d key:%d %d %d} released, ref left: %d\n",
+			 exported->hid.id, exported->hid.rng_key[0],
+			 exported->hid.rng_key[1], exported->hid.rng_key[2],
+			 exported->active - 1);
+
+		exported->active--;
+
+		/* If there are still importers just break, if no then
+		 * continue with final cleanup
+		 */
+		if (exported->active)
+			break;
+
+		/* Importer just released buffer fd, check if there is
+		 * any other importer still using it.
+		 * If not and buffer was unexported, clean up shared
+		 * data and remove that buffer.
+		 */
+		dev_dbg(hy_drv_priv->dev,
+			"Buffer {id:%d key:%d %d %d} final released\n",
+			exported->hid.id, exported->hid.rng_key[0],
+			exported->hid.rng_key[1], exported->hid.rng_key[2]);
+
+		if (!exported->valid && !exported->active &&
+		    !exported->unexport_sched) {
+			hyper_dmabuf_cleanup_sgt_info(exported, false);
+			hyper_dmabuf_remove_exported(hid);
+			kfree(exported);
+			/* store hyper_dmabuf_id in the list for reuse */
+			hyper_dmabuf_store_hid(hid);
+		}
+
+		break;
+
+	case HYPER_DMABUF_OPS_BEGIN_CPU_ACCESS:
+		ret = dma_buf_begin_cpu_access(exported->dma_buf,
+					       DMA_BIDIRECTIONAL);
+		if (ret) {
+			dev_err(hy_drv_priv->dev,
+				"HYPER_DMABUF_OPS_BEGIN_CPU_ACCESS\n");
+			return ret;
+		}
+		break;
+
+	case HYPER_DMABUF_OPS_END_CPU_ACCESS:
+		ret = dma_buf_end_cpu_access(exported->dma_buf,
+					     DMA_BIDIRECTIONAL);
+		if (ret) {
+			dev_err(hy_drv_priv->dev,
+				"HYPER_DMABUF_OPS_END_CPU_ACCESS\n");
+			return ret;
+		}
+		break;
+
+	case HYPER_DMABUF_OPS_KMAP_ATOMIC:
+	case HYPER_DMABUF_OPS_KMAP:
+		va_kmapl = kcalloc(1, sizeof(*va_kmapl), GFP_KERNEL);
+		if (!va_kmapl)
+			return -ENOMEM;
+
+		/* dummy kmapping of 1 page */
+		if (ops == HYPER_DMABUF_OPS_KMAP_ATOMIC)
+			va_kmapl->vaddr = dma_buf_kmap_atomic(
+						exported->dma_buf, 1);
+		else
+			va_kmapl->vaddr = dma_buf_kmap(
+						exported->dma_buf, 1);
+
+		if (!va_kmapl->vaddr) {
+			kfree(va_kmapl);
+			dev_err(hy_drv_priv->dev,
+				"HYPER_DMABUF_OPS_KMAP(_ATOMIC)\n");
+			return -ENOMEM;
+		}
+		list_add(&va_kmapl->list, &exported->va_kmapped->list);
+		break;
+
+	case HYPER_DMABUF_OPS_KUNMAP_ATOMIC:
+	case HYPER_DMABUF_OPS_KUNMAP:
+		if (list_empty(&exported->va_kmapped->list)) {
+			dev_err(hy_drv_priv->dev,
+				"HYPER_DMABUF_OPS_KUNMAP(_ATOMIC)\n");
+			dev_err(hy_drv_priv->dev,
+				"no more dmabuf VA to be freed\n");
+			return -EFAULT;
+		}
+
+		va_kmapl = list_first_entry(&exported->va_kmapped->list,
+					    struct kmap_vaddr_list, list);
+		if (!va_kmapl->vaddr) {
+			dev_err(hy_drv_priv->dev,
+				"HYPER_DMABUF_OPS_KUNMAP(_ATOMIC)\n");
+			return PTR_ERR(va_kmapl->vaddr);
+		}
+
+		/* unmapping 1 page */
+		if (ops == HYPER_DMABUF_OPS_KUNMAP_ATOMIC)
+			dma_buf_kunmap_atomic(exported->dma_buf,
+					      1, va_kmapl->vaddr);
+		else
+			dma_buf_kunmap(exported->dma_buf,
+				       1, va_kmapl->vaddr);
+
+		list_del(&va_kmapl->list);
+		kfree(va_kmapl);
+		break;
+
+	case HYPER_DMABUF_OPS_MMAP:
+		/* currently not supported: looking for a way to create
+		 * a dummy vma
+		 */
+		dev_warn(hy_drv_priv->dev,
+			 "remote sync::sychronized mmap is not supported\n");
+		break;
+
+	case HYPER_DMABUF_OPS_VMAP:
+		va_vmapl = kcalloc(1, sizeof(*va_vmapl), GFP_KERNEL);
+
+		if (!va_vmapl)
+			return -ENOMEM;
+
+		/* dummy vmapping */
+		va_vmapl->vaddr = dma_buf_vmap(exported->dma_buf);
+
+		if (!va_vmapl->vaddr) {
+			kfree(va_vmapl);
+			dev_err(hy_drv_priv->dev,
+				"remote sync::HYPER_DMABUF_OPS_VMAP\n");
+			return -ENOMEM;
+		}
+		list_add(&va_vmapl->list, &exported->va_vmapped->list);
+		break;
+
+	case HYPER_DMABUF_OPS_VUNMAP:
+		if (list_empty(&exported->va_vmapped->list)) {
+			dev_err(hy_drv_priv->dev,
+				"remote sync::HYPER_DMABUF_OPS_VUNMAP\n");
+			dev_err(hy_drv_priv->dev,
+				"no more dmabuf VA to be freed\n");
+			return -EFAULT;
+		}
+		va_vmapl = list_first_entry(&exported->va_vmapped->list,
+					struct vmap_vaddr_list, list);
+		if (!va_vmapl || va_vmapl->vaddr == NULL) {
+			dev_err(hy_drv_priv->dev,
+				"remote sync::HYPER_DMABUF_OPS_VUNMAP\n");
+			return -EFAULT;
+		}
+
+		dma_buf_vunmap(exported->dma_buf, va_vmapl->vaddr);
+
+		list_del(&va_vmapl->list);
+		kfree(va_vmapl);
+		break;
+
+	default:
+		/* program should not get here */
+		break;
+	}
+
+	return 0;
+}
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_remote_sync.h b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_remote_sync.h
new file mode 100644
index 000000000000..a659c83c8f27
--- /dev/null
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_remote_sync.h
@@ -0,0 +1,32 @@
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
+#ifndef __HYPER_DMABUF_REMOTE_SYNC_H__
+#define __HYPER_DMABUF_REMOTE_SYNC_H__
+
+int hyper_dmabuf_remote_sync(hyper_dmabuf_id_t hid, int ops);
+
+#endif // __HYPER_DMABUF_REMOTE_SYNC_H__
-- 
2.16.1
