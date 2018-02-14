Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966477AbeBNBv2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 20:51:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:56116 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966450AbeBNBvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 20:51:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,510,1511856000";
   d="scan'208";a="34498944"
From: Dongwon Kim <dongwon.kim@intel.com>
To: linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        xen-devel@lists.xenproject.org
Cc: dri-devel@lists.freedesktop.org, dongwon.kim@intel.com,
        mateuszx.potrola@intel.com, sumit.semwal@linaro.org
Subject: [RFC PATCH v2 4/9] hyper_dmabuf: user private data attached to hyper_DMABUF
Date: Tue, 13 Feb 2018 17:50:03 -0800
Message-Id: <20180214015008.9513-5-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180214015008.9513-1-dongwon.kim@intel.com>
References: <20180214015008.9513-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a private data (e.g. meta data for the buffer) attached to
each hyper_DMABUF structure. This data is provided by userapace via
export_remote IOCTL and its size can be up to 192 bytes.

Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Signed-off-by: Mateusz Polrola <mateuszx.potrola@intel.com>
---
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.c  | 83 ++++++++++++++++++++--
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c    | 36 +++++++++-
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.h    |  2 +-
 .../dma-buf/hyper_dmabuf/hyper_dmabuf_sgl_proc.c   |  1 +
 drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_struct.h | 12 ++++
 include/uapi/linux/hyper_dmabuf.h                  |  4 ++
 6 files changed, 132 insertions(+), 6 deletions(-)

diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.c
index 020a5590a254..168ccf98f710 100644
--- a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.c
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_ioctl.c
@@ -103,6 +103,11 @@ static int send_export_msg(struct exported_sgt_info *exported,
 		}
 	}
 
+	op[8] = exported->sz_priv;
+
+	/* driver/application specific private info */
+	memcpy(&op[9], exported->priv, op[8]);
+
 	req = kcalloc(1, sizeof(*req), GFP_KERNEL);
 
 	if (!req)
@@ -120,8 +125,9 @@ static int send_export_msg(struct exported_sgt_info *exported,
 
 /* Fast path exporting routine in case same buffer is already exported.
  *
- * If same buffer is still valid and exist in EXPORT LIST it returns 0 so
- * that remaining normal export process can be skipped.
+ * If same buffer is still valid and exist in EXPORT LIST, it only updates
+ * user-private data for the buffer and returns 0 so that that it can skip
+ * normal export process.
  *
  * If "unexport" is scheduled for the buffer, it cancels it since the buffer
  * is being re-exported.
@@ -129,7 +135,7 @@ static int send_export_msg(struct exported_sgt_info *exported,
  * return '1' if reexport is needed, return '0' if succeeds, return
  * Kernel error code if something goes wrong
  */
-static int fastpath_export(hyper_dmabuf_id_t hid)
+static int fastpath_export(hyper_dmabuf_id_t hid, int sz_priv, char *priv)
 {
 	int reexport = 1;
 	int ret = 0;
@@ -155,6 +161,46 @@ static int fastpath_export(hyper_dmabuf_id_t hid)
 		exported->unexport_sched = false;
 	}
 
+	/* if there's any change in size of private data.
+	 * we reallocate space for private data with new size
+	 */
+	if (sz_priv != exported->sz_priv) {
+		kfree(exported->priv);
+
+		/* truncating size */
+		if (sz_priv > MAX_SIZE_PRIV_DATA)
+			exported->sz_priv = MAX_SIZE_PRIV_DATA;
+		else
+			exported->sz_priv = sz_priv;
+
+		exported->priv = kcalloc(1, exported->sz_priv,
+					 GFP_KERNEL);
+
+		if (!exported->priv) {
+			hyper_dmabuf_remove_exported(exported->hid);
+			hyper_dmabuf_cleanup_sgt_info(exported, true);
+			kfree(exported);
+			return -ENOMEM;
+		}
+	}
+
+	/* update private data in sgt_info with new ones */
+	ret = copy_from_user(exported->priv, priv, exported->sz_priv);
+	if (ret) {
+		dev_err(hy_drv_priv->dev,
+			"Failed to load a new private data\n");
+		ret = -EINVAL;
+	} else {
+		/* send an export msg for updating priv in importer */
+		ret = send_export_msg(exported, NULL);
+
+		if (ret < 0) {
+			dev_err(hy_drv_priv->dev,
+				"Failed to send a new private data\n");
+			ret = -EBUSY;
+		}
+	}
+
 	return ret;
 }
 
@@ -191,7 +237,8 @@ static int hyper_dmabuf_export_remote_ioctl(struct file *filp, void *data)
 					     export_remote_attr->remote_domain);
 
 	if (hid.id != -1) {
-		ret = fastpath_export(hid);
+		ret = fastpath_export(hid, export_remote_attr->sz_priv,
+				      export_remote_attr->priv);
 
 		/* return if fastpath_export succeeds or
 		 * gets some fatal error
@@ -225,6 +272,24 @@ static int hyper_dmabuf_export_remote_ioctl(struct file *filp, void *data)
 		goto fail_sgt_info_creation;
 	}
 
+	/* possible truncation */
+	if (export_remote_attr->sz_priv > MAX_SIZE_PRIV_DATA)
+		exported->sz_priv = MAX_SIZE_PRIV_DATA;
+	else
+		exported->sz_priv = export_remote_attr->sz_priv;
+
+	/* creating buffer for private data of buffer */
+	if (exported->sz_priv != 0) {
+		exported->priv = kcalloc(1, exported->sz_priv, GFP_KERNEL);
+
+		if (!exported->priv) {
+			ret = -ENOMEM;
+			goto fail_priv_creation;
+		}
+	} else {
+		dev_err(hy_drv_priv->dev, "size is 0\n");
+	}
+
 	exported->hid = hyper_dmabuf_get_hid();
 
 	/* no more exported dmabuf allowed */
@@ -279,6 +344,10 @@ static int hyper_dmabuf_export_remote_ioctl(struct file *filp, void *data)
 	INIT_LIST_HEAD(&exported->va_kmapped->list);
 	INIT_LIST_HEAD(&exported->va_vmapped->list);
 
+	/* copy private data to sgt_info */
+	ret = copy_from_user(exported->priv, export_remote_attr->priv,
+			     exported->sz_priv);
+
 	if (ret) {
 		dev_err(hy_drv_priv->dev,
 			"failed to load private data\n");
@@ -337,6 +406,9 @@ static int hyper_dmabuf_export_remote_ioctl(struct file *filp, void *data)
 
 fail_map_active_attached:
 	kfree(exported->active_sgts);
+	kfree(exported->priv);
+
+fail_priv_creation:
 	kfree(exported);
 
 fail_map_active_sgts:
@@ -567,6 +639,9 @@ static void delayed_unexport(struct work_struct *work)
 		/* register hyper_dmabuf_id to the list for reuse */
 		hyper_dmabuf_store_hid(exported->hid);
 
+		if (exported->sz_priv > 0 && !exported->priv)
+			kfree(exported->priv);
+
 		kfree(exported);
 	}
 }
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c
index 129b2ff2af2b..7176fa8fb139 100644
--- a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.c
@@ -60,9 +60,12 @@ void hyper_dmabuf_create_req(struct hyper_dmabuf_req *req,
 		 * op5 : offset of data in the first page
 		 * op6 : length of data in the last page
 		 * op7 : top-level reference number for shared pages
+		 * op8 : size of private data (from op9)
+		 * op9 ~ : Driver-specific private data
+		 *	   (e.g. graphic buffer's meta info)
 		 */
 
-		memcpy(&req->op[0], &op[0], 8 * sizeof(int) + op[8]);
+		memcpy(&req->op[0], &op[0], 9 * sizeof(int) + op[8]);
 		break;
 
 	case HYPER_DMABUF_NOTIFY_UNEXPORT:
@@ -116,6 +119,9 @@ static void cmd_process_work(struct work_struct *work)
 		 * op5 : offset of data in the first page
 		 * op6 : length of data in the last page
 		 * op7 : top-level reference number for shared pages
+		 * op8 : size of private data (from op9)
+		 * op9 ~ : Driver-specific private data
+		 *         (e.g. graphic buffer's meta info)
 		 */
 
 		/* if nents == 0, it means it is a message only for
@@ -135,6 +141,24 @@ static void cmd_process_work(struct work_struct *work)
 				break;
 			}
 
+			/* if size of new private data is different,
+			 * we reallocate it.
+			 */
+			if (imported->sz_priv != req->op[8]) {
+				kfree(imported->priv);
+				imported->sz_priv = req->op[8];
+				imported->priv = kcalloc(1, req->op[8],
+							 GFP_KERNEL);
+				if (!imported->priv) {
+					/* set it invalid */
+					imported->valid = 0;
+					break;
+				}
+			}
+
+			/* updating priv data */
+			memcpy(imported->priv, &req->op[9], req->op[8]);
+
 			break;
 		}
 
@@ -143,6 +167,14 @@ static void cmd_process_work(struct work_struct *work)
 		if (!imported)
 			break;
 
+		imported->sz_priv = req->op[8];
+		imported->priv = kcalloc(1, req->op[8], GFP_KERNEL);
+
+		if (!imported->priv) {
+			kfree(imported);
+			break;
+		}
+
 		imported->hid.id = req->op[0];
 
 		for (i = 0; i < 3; i++)
@@ -162,6 +194,8 @@ static void cmd_process_work(struct work_struct *work)
 		dev_dbg(hy_drv_priv->dev, "\tlast len %d\n", req->op[6]);
 		dev_dbg(hy_drv_priv->dev, "\tgrefid %d\n", req->op[7]);
 
+		memcpy(imported->priv, &req->op[9], req->op[8]);
+
 		imported->valid = true;
 		hyper_dmabuf_register_imported(imported);
 
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.h b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.h
index 59f1528e9b1e..63a39d068d69 100644
--- a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.h
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_msg.h
@@ -27,7 +27,7 @@
 #ifndef __HYPER_DMABUF_MSG_H__
 #define __HYPER_DMABUF_MSG_H__
 
-#define MAX_NUMBER_OF_OPERANDS 8
+#define MAX_NUMBER_OF_OPERANDS 64
 
 struct hyper_dmabuf_req {
 	unsigned int req_id;
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_sgl_proc.c b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_sgl_proc.c
index d92ae13d8a30..9032f89e0cd0 100644
--- a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_sgl_proc.c
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_sgl_proc.c
@@ -251,6 +251,7 @@ int hyper_dmabuf_cleanup_sgt_info(struct exported_sgt_info *exported,
 	kfree(exported->active_attached);
 	kfree(exported->va_kmapped);
 	kfree(exported->va_vmapped);
+	kfree(exported->priv);
 
 	return 0;
 }
diff --git a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_struct.h b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_struct.h
index 144e3821fbc2..a1220bbf8d0c 100644
--- a/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_struct.h
+++ b/drivers/dma-buf/hyper_dmabuf/hyper_dmabuf_struct.h
@@ -101,6 +101,12 @@ struct exported_sgt_info {
 	 * the buffer can be completely freed.
 	 */
 	struct file *filp;
+
+	/* size of private */
+	size_t sz_priv;
+
+	/* private data associated with the exported buffer */
+	char *priv;
 };
 
 /* imported_sgt_info contains information about imported DMA_BUF
@@ -126,6 +132,12 @@ struct imported_sgt_info {
 	void *refs_info;
 	bool valid;
 	int importers;
+
+	/* size of private */
+	size_t sz_priv;
+
+	/* private data associated with the exported buffer */
+	char *priv;
 };
 
 #endif /* __HYPER_DMABUF_STRUCT_H__ */
diff --git a/include/uapi/linux/hyper_dmabuf.h b/include/uapi/linux/hyper_dmabuf.h
index caaae2da9d4d..36794a4af811 100644
--- a/include/uapi/linux/hyper_dmabuf.h
+++ b/include/uapi/linux/hyper_dmabuf.h
@@ -25,6 +25,8 @@
 #ifndef __LINUX_PUBLIC_HYPER_DMABUF_H__
 #define __LINUX_PUBLIC_HYPER_DMABUF_H__
 
+#define MAX_SIZE_PRIV_DATA 192
+
 typedef struct {
 	int id;
 	int rng_key[3]; /* 12bytes long random number */
@@ -56,6 +58,8 @@ struct ioctl_hyper_dmabuf_export_remote {
 	int remote_domain;
 	/* exported dma buf id */
 	hyper_dmabuf_id_t hid;
+	int sz_priv;
+	char *priv;
 };
 
 #define IOCTL_HYPER_DMABUF_EXPORT_FD \
-- 
2.16.1
