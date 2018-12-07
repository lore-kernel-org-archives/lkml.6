Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7ADC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A8220837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y8QccUdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A8220837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeLGQf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:35:28 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38373 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbeLGQfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:35:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so4390364wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 08:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7ztlxgaaKMqUIDeki3W+ij7QaeiY1jkJ4bd1JObo+A=;
        b=Y8QccUdjSjXxiylMXTAJLs2UsJvmUzRkSH+OXpispczd4AJC3UCID3uERp6VVDlwFF
         Hw6glsUxhAl0JloeOK/BUDlSUWt8lVAs2gF6PKALSZZCyS83Skf/QhBa/B/mmcNcA1xA
         fhneyaacfodPhUV2qDJrSJQeqVObJUQ5Mch8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7ztlxgaaKMqUIDeki3W+ij7QaeiY1jkJ4bd1JObo+A=;
        b=sNeKFfy8CYIA8YgKLdUe2jPMXrTtlacpjcqsbUOEnMcOLPXtoalOEsKbh6jcAI7jZ0
         Z61KKzYHiO2+0lwvHW+6o4mj1G/oNETfIox3hFeOtkVppJSLkKi67h8FEbsGR+YsJvez
         XfWKbp6EeoAeQg4nemiQrR/zLD6RnVtsI29QkkNuKTnGO0VHQdS0zaqeeR1v1hE+etDT
         nv7TI/thU9fPR+tlz7kUxV4Rv4o7T+U30cdu8jfaIdAZaGYRN3RalAqTd/AxDK2AWjLL
         MYqxc+FhTLwnpmWICciTGla1sdRXNNLfU5FkdjRR9eYJHwb5AQnoMDeMKbxisLeCQ74h
         1SFA==
X-Gm-Message-State: AA+aEWbS15Qtd87qjRaKm8MTpthcnQCxi35aG4PJFwj/AebXNIgMRPPJ
        3pWLIOnXvBIL4NsNoarrEIsgfw==
X-Google-Smtp-Source: AFSGD/VDaV3fy5x517PDpdWlhXSGl4jelc8eYKGSkzi5YGRQmwt75eGV6TAcX5TFYbSkO4RV20DQAw==
X-Received: by 2002:adf:db51:: with SMTP id f17mr2257639wrj.90.1544200521315;
        Fri, 07 Dec 2018 08:35:21 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id w6sm4268752wme.46.2018.12.07.08.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Dec 2018 08:35:20 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, bkumar@qti.qualcomm.com,
        thierry.escande@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/6] misc: fastrpc: Add support for context Invoke method
Date:   Fri,  7 Dec 2018 16:35:10 +0000
Message-Id: <20181207163513.16412-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
References: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to compute context invoke method
on the remote processor (DSP).
This involves setting up the functions input and output arguments,
input and output handles and mapping the dmabuf fd for the
argument/handle buffers.

Most of the work is derived from various downstream Qualcomm kernels.
Credits to various Qualcomm authors who have contributed to this code.
Specially Tharun Kumar Merugu <mtharu@codeaurora.org>

Co-developed-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c      | 716 ++++++++++++++++++++++++++++++++++++
 include/uapi/misc/fastrpc.h |  22 ++
 2 files changed, 738 insertions(+)
 create mode 100644 include/uapi/misc/fastrpc.h

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 7fc2b381074d..46435813785d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2,7 +2,9 @@
 // Copyright (c) 2011-2018, The Linux Foundation. All rights reserved.
 // Copyright (c) 2018, Linaro Limited
 
+#include <linux/completion.h>
 #include <linux/device.h>
+#include <linux/dma-buf.h>
 #include <linux/dma-mapping.h>
 #include <linux/idr.h>
 #include <linux/list.h>
@@ -14,6 +16,7 @@
 #include <linux/rpmsg.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include <uapi/misc/fastrpc.h>
 
 #define ADSP_DOMAIN_ID (0)
 #define MDSP_DOMAIN_ID (1)
@@ -21,14 +24,119 @@
 #define CDSP_DOMAIN_ID (3)
 #define FASTRPC_DEV_MAX		4 /* adsp, mdsp, slpi, cdsp*/
 #define FASTRPC_MAX_SESSIONS	9 /*8 compute, 1 cpz*/
+#define FASTRPC_ALIGN		128
+#define FASTRPC_MAX_FDLIST	16
+#define FASTRPC_MAX_CRCLIST	64
+#define FASTRPC_PHYS(p)	((p) & 0xffffffff)
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_CTXID_MASK (0xFF0)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
 
+/* Retrives number of input buffers from the scalars parameter */
+#define REMOTE_SCALARS_INBUFS(sc)	(((sc) >> 16) & 0x0ff)
+
+/* Retrives number of output buffers from the scalars parameter */
+#define REMOTE_SCALARS_OUTBUFS(sc)	(((sc) >> 8) & 0x0ff)
+
+/* Retrives number of input handles from the scalars parameter */
+#define REMOTE_SCALARS_INHANDLES(sc)	(((sc) >> 4) & 0x0f)
+
+/* Retrives number of output handles from the scalars parameter */
+#define REMOTE_SCALARS_OUTHANDLES(sc)	((sc) & 0x0f)
+
+#define REMOTE_SCALARS_LENGTH(sc)	(REMOTE_SCALARS_INBUFS(sc) +   \
+					 REMOTE_SCALARS_OUTBUFS(sc) +  \
+					 REMOTE_SCALARS_INHANDLES(sc)+ \
+					 REMOTE_SCALARS_OUTHANDLES(sc))
+
+#define FASTRPC_BUILD_SCALARS(attr, method, in, out, oin, oout) \
+		((((uint32_t)  (attr) & 0x07) << 29) | \
+		(((uint32_t) (method) & 0x1f) << 24) | \
+		(((uint32_t)     (in) & 0xff) << 16) | \
+		(((uint32_t)    (out) & 0xff) <<  8) | \
+		(((uint32_t)    (oin) & 0x0f) <<  4) | \
+		((uint32_t)    (oout) & 0x0f))
+
+#define FASTRPC_SCALARS(method, in, out) \
+		FASTRPC_BUILD_SCALARS(0, method, in, out, 0, 0)
+
 #define miscdev_to_cctx(d) container_of(d, struct fastrpc_channel_ctx, miscdev)
 
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
 						"sdsp", "cdsp"};
+struct fastrpc_phy_page {
+	uint64_t addr;		/* physical address */
+	uint64_t size;		/* size of contiguous region */
+};
+
+struct fastrpc_invoke_buf {
+	int num;		/* number of contiguous regions */
+	int pgidx;		/* index to start of contiguous region */
+};
+
+struct fastrpc_remote_arg {
+	uint64_t pv;
+	uint64_t len;
+};
+
+struct fastrpc_msg {
+	uint32_t pid;		/* process group id */
+	uint32_t tid;		/* thread id */
+	uint64_t ctx;		/* invoke caller context */
+	uint32_t handle;	/* handle to invoke */
+	uint32_t sc;		/* scalars structure describing the data */
+	uint64_t addr;		/* physical address */
+	uint64_t size;		/* size of contiguous region */
+};
+
+struct fastrpc_invoke_rsp {
+	uint64_t ctx;		/* invoke caller context */
+	int retval;		/* invoke return value */
+};
+
+struct fastrpc_buf {
+	struct fastrpc_user *fl;
+	struct device *dev;
+	void *virt;
+	uint64_t phys;
+	size_t size;
+};
+
+struct fastrpc_map {
+	struct list_head node;
+	struct fastrpc_user *fl;
+	int fd;
+	struct dma_buf *buf;
+	struct sg_table *table;
+	struct dma_buf_attachment *attach;
+	uint64_t phys;
+	size_t size;
+	void *va;
+	size_t len;
+	struct kref refcount;
+};
+
+struct fastrpc_invoke_ctx {
+	struct fastrpc_user *fl;
+	struct list_head node; /* list of ctxs */
+	struct completion work;
+	int retval;
+	int pid;
+	int tgid;
+	uint32_t sc;
+	struct fastrpc_msg msg;
+	uint64_t ctxid;
+	size_t used_sz;
+
+	int nscalars;
+	int nbufs;
+	uint32_t *crc;
+
+	struct fastrpc_remote_arg *rpra;
+	struct fastrpc_map **maps;
+	struct fastrpc_buf *buf;
+	struct fastrpc_invoke_args *args;
+};
 
 struct fastrpc_session_ctx {
 	struct device *dev;
@@ -56,6 +164,7 @@ struct fastrpc_user {
 
 	struct fastrpc_channel_ctx *cctx;
 	struct fastrpc_session_ctx *sctx;
+	struct fastrpc_buf *init_mem;
 
 	int tgid;
 	int pd;
@@ -65,6 +174,508 @@ struct fastrpc_user {
 	struct mutex mutex;
 };
 
+static void fastrpc_free_map(struct kref *ref)
+{
+	struct fastrpc_map *map;
+
+	map = container_of(ref, struct fastrpc_map, refcount);
+
+	list_del(&map->node);
+
+	if (map->table) {
+		dma_buf_unmap_attachment(map->attach, map->table,
+					 DMA_BIDIRECTIONAL);
+		dma_buf_detach(map->buf, map->attach);
+		dma_buf_put(map->buf);
+	}
+
+	kfree(map);
+}
+
+static void fastrpc_map_put(struct fastrpc_map *map)
+{
+	struct fastrpc_user *fl;
+
+	if (map) {
+		fl = map->fl;
+		mutex_lock(&fl->mutex);
+		kref_put(&map->refcount, fastrpc_free_map);
+		mutex_unlock(&fl->mutex);
+	}
+}
+
+static int fastrpc_map_get(struct fastrpc_user *fl, int fd, size_t len,
+			   struct fastrpc_map **ppmap)
+{
+	struct fastrpc_map *map = NULL, *n;
+
+	mutex_lock(&fl->mutex);
+	list_for_each_entry_safe(map, n, &fl->maps, node) {
+		if (map->fd == fd) {
+			kref_get(&map->refcount);
+			*ppmap = map;
+			mutex_unlock(&fl->mutex);
+			return 0;
+		}
+	}
+	mutex_unlock(&fl->mutex);
+
+	return -ENOENT;
+}
+
+static void fastrpc_buf_free(struct fastrpc_buf *buf)
+{
+	dma_free_coherent(buf->dev, buf->size, buf->virt,
+			  FASTRPC_PHYS(buf->phys));
+	kfree(buf);
+}
+
+static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
+			     size_t size, struct fastrpc_buf **obuf)
+{
+	struct fastrpc_buf *buf;
+
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf->fl = fl;
+	buf->virt = NULL;
+	buf->phys = 0;
+	buf->size = size;
+	buf->dev = dev;
+
+	buf->virt = dma_alloc_coherent(dev, buf->size, (dma_addr_t *)&buf->phys,
+				       GFP_KERNEL);
+	if (!buf->virt)
+		return -ENOMEM;
+
+	if (fl->sctx && fl->sctx->sid)
+		buf->phys += ((uint64_t)fl->sctx->sid << 32);
+
+	*obuf = buf;
+
+	return 0;
+}
+
+static void fastrpc_context_free(struct fastrpc_invoke_ctx *ctx)
+{
+	struct fastrpc_channel_ctx *cctx = ctx->fl->cctx;
+	struct fastrpc_user *user = ctx->fl;
+	int scalars = REMOTE_SCALARS_LENGTH(ctx->sc);
+	int i;
+
+	spin_lock(&user->lock);
+	list_del(&ctx->node);
+	spin_unlock(&user->lock);
+
+	for (i = 0; i < scalars; i++) {
+		if (ctx->maps[i])
+			fastrpc_map_put(ctx->maps[i]);
+	}
+
+	if (ctx->buf)
+		fastrpc_buf_free(ctx->buf);
+
+	spin_lock(&cctx->lock);
+	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
+	spin_unlock(&cctx->lock);
+
+	kfree(ctx->maps);
+	kfree(ctx);
+}
+
+static struct fastrpc_invoke_ctx *
+fastrpc_context_alloc(struct fastrpc_user *user, uint32_t kernel,
+		      struct fastrpc_invoke *inv)
+{
+	struct fastrpc_channel_ctx *cctx = user->cctx;
+	struct fastrpc_invoke_ctx *ctx = NULL;
+	int bufs, ret;
+	int err = 0;
+
+	bufs = REMOTE_SCALARS_LENGTH(inv->sc);
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&ctx->node);
+	ctx->fl = user;
+	ctx->nscalars = bufs;
+	ctx->nbufs = REMOTE_SCALARS_INBUFS(inv->sc) +
+		     REMOTE_SCALARS_OUTBUFS(inv->sc);
+
+	if (ctx->nscalars) {
+		ctx->maps = kcalloc(ctx->nscalars,
+				    sizeof(*ctx->maps), GFP_KERNEL);
+		if (!ctx->maps) {
+			kfree(ctx);
+			return ERR_PTR(-ENOMEM);
+		}
+		ctx->args = inv->args;
+	}
+
+	ctx->sc = inv->sc;
+	ctx->retval = -1;
+	ctx->pid = current->pid;
+	ctx->tgid = user->tgid;
+	init_completion(&ctx->work);
+
+	spin_lock(&user->lock);
+	list_add_tail(&ctx->node, &user->pending);
+	spin_unlock(&user->lock);
+
+	spin_lock(&cctx->lock);
+	ret = idr_alloc_cyclic(&cctx->ctx_idr, ctx, 1,
+			       FASTRPC_CTX_MAX, GFP_ATOMIC);
+	if (ret < 0) {
+		spin_unlock(&cctx->lock);
+		err = ret;
+		goto err_idr;
+	}
+	ctx->ctxid = ret << 4;
+	spin_unlock(&cctx->lock);
+
+	return ctx;
+err_idr:
+	spin_lock(&user->lock);
+	list_del(&ctx->node);
+	spin_unlock(&user->lock);
+	kfree(ctx->maps);
+	kfree(ctx);
+
+	return ERR_PTR(err);
+}
+
+static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
+			      size_t len, struct fastrpc_map **ppmap)
+{
+	struct fastrpc_session_ctx *sess = fl->sctx;
+	struct fastrpc_map *map = NULL;
+	int err = 0;
+
+	if (!fastrpc_map_get(fl, fd, len, ppmap))
+		return 0;
+
+	map = kzalloc(sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&map->node);
+	map->fl = fl;
+	map->fd = fd;
+	map->buf = dma_buf_get(fd);
+	if (!map->buf) {
+		err = -EINVAL;
+		goto get_err;
+	}
+
+	map->attach = dma_buf_attach(map->buf, sess->dev);
+	if (IS_ERR(map->attach)) {
+		dev_err(sess->dev, "Failed to attach dmabuf\n");
+		err = PTR_ERR(map->attach);
+		goto attach_err;
+	}
+
+	map->table = dma_buf_map_attachment(map->attach, DMA_BIDIRECTIONAL);
+	if (IS_ERR(map->table)) {
+		err = PTR_ERR(map->table);
+		goto map_err;
+	}
+
+	map->phys = sg_dma_address(map->table->sgl);
+	map->phys += ((uint64_t)fl->sctx->sid << 32);
+	map->size = len;
+	map->va = sg_virt(map->table->sgl);
+	map->len = len;
+	kref_init(&map->refcount);
+
+	spin_lock(&fl->lock);
+	list_add_tail(&map->node, &fl->maps);
+	spin_unlock(&fl->lock);
+	*ppmap = map;
+
+	return 0;
+
+map_err:
+	dma_buf_detach(map->buf, map->attach);
+attach_err:
+	dma_buf_put(map->buf);
+get_err:
+	kfree(map);
+
+	return err;
+}
+
+/*
+ * Fastrpc payload buffer with metadata looks like:
+ *
+ * >>>>>>  START of METADATA <<<<<<<<<
+ * +---------------------------------+
+ * |           Arguments             |
+ * | type:(struct fastrpc_remote_arg)|
+ * |             (0 - N)             |
+ * +---------------------------------+
+ * |         Invoke Buffer list      |
+ * | type:(struct fastrpc_invoke_buf)|
+ * |           (0 - N)               |
+ * +---------------------------------+
+ * |         Page info list          |
+ * | type:(struct fastrpc_phy_page)  |
+ * |             (0 - N)             |
+ * +---------------------------------+
+ * |         Optional info           |
+ * |(can be specific to SoC/Firmware)|
+ * +---------------------------------+
+ * >>>>>>>>  END of METADATA <<<<<<<<<
+ * +---------------------------------+
+ * |         Inline ARGS             |
+ * |            (0-N)                |
+ * +---------------------------------+
+ */
+
+static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
+{
+	int size = 0;
+
+	size = (sizeof(struct fastrpc_remote_arg) +
+		sizeof(struct fastrpc_invoke_buf) +
+		sizeof(struct fastrpc_phy_page)) * ctx->nscalars +
+		sizeof(uint64_t) * FASTRPC_MAX_FDLIST +
+		sizeof(uint32_t) * FASTRPC_MAX_CRCLIST;
+
+	return size;
+}
+
+static int fastrpc_get_payload_size(struct fastrpc_invoke_ctx *ctx, int metalen)
+{
+	int i, size = 0;
+
+	size = ALIGN(metalen, FASTRPC_ALIGN);
+	for (i = 0; i < ctx->nscalars; i++) {
+		if (ctx->args[i].fd == 0 || ctx->args[i].fd == -1) {
+			size = ALIGN(size, FASTRPC_ALIGN);
+			size += ctx->args[i].length;
+		}
+	}
+
+	return size;
+}
+
+static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
+{
+	struct device *dev = ctx->fl->sctx->dev;
+	int i, err;
+
+	for (i = 0; i < ctx->nscalars; ++i) {
+		if (ctx->args[i].fd == 0 || ctx->args[i].fd == -1 ||
+		    ctx->args[i].length == 0)
+			continue;
+
+		err = fastrpc_map_create(ctx->fl, ctx->args[i].fd,
+					 ctx->args[i].length, &ctx->maps[i]);
+		if (err) {
+			dev_err(dev, "Error Creating map %d\n", err);
+			return -EINVAL;
+		}
+
+	}
+	return 0;
+}
+
+static int fastrpc_get_args(uint32_t kernel, struct fastrpc_invoke_ctx *ctx)
+{
+	struct device *dev = ctx->fl->sctx->dev;
+	struct fastrpc_remote_arg *rpra;
+	struct fastrpc_invoke_buf *list;
+	struct fastrpc_phy_page *pages;
+	uintptr_t args;
+	size_t rlen = 0, pkt_size = 0, metalen = 0;
+	int inbufs, i, err = 0;
+
+	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
+	metalen = fastrpc_get_meta_size(ctx);
+	pkt_size = fastrpc_get_payload_size(ctx, metalen);
+	fastrpc_create_maps(ctx);
+	ctx->used_sz = pkt_size;
+
+	err = fastrpc_buf_alloc(ctx->fl, dev, pkt_size, &ctx->buf);
+	if (err)
+		goto bail;
+
+	rpra = ctx->buf->virt;
+	list = ctx->buf->virt + ctx->nscalars * sizeof(*rpra);
+	pages = ctx->buf->virt + ctx->nscalars * (sizeof(*list) +
+		sizeof(*rpra));
+	args = (uintptr_t)ctx->buf->virt + metalen;
+	rlen = pkt_size - metalen;
+	ctx->rpra = rpra;
+
+	for (i = 0; i < ctx->nbufs; ++i) {
+		size_t len = ctx->args[i].length;
+
+		rpra[i].pv = 0;
+		rpra[i].len = len;
+		list[i].num = len ? 1 : 0;
+		list[i].pgidx = i;
+
+		if (!len)
+			continue;
+
+		pages[i].size = roundup(len, PAGE_SIZE);
+
+		if (ctx->maps[i]) {
+			rpra[i].pv = (uint64_t) ctx->args[i].ptr;
+			pages[i].addr = ctx->maps[i]->phys;
+		} else {
+			rlen -= ALIGN(args, FASTRPC_ALIGN) - args;
+			args = ALIGN(args, FASTRPC_ALIGN);
+			if (rlen < len)
+				goto bail;
+
+			rpra[i].pv = (args);
+			pages[i].addr = ctx->buf->phys + (pkt_size - rlen);
+			pages[i].addr = pages[i].addr &	PAGE_MASK;
+			args = args + len;
+			rlen -= len;
+		}
+
+		if (i < inbufs && !ctx->maps[i]) {
+			if (!kernel) {
+				err = copy_from_user((void *)rpra[i].pv,
+					     (void __user *)ctx->args[i].ptr,
+					     ctx->args[i].length);
+				if (err)
+					goto bail;
+			} else {
+				memcpy((void *)rpra[i].pv, ctx->args[i].ptr,
+				       ctx->args[i].length);
+			}
+		}
+	}
+
+	for (i = ctx->nbufs; i < ctx->nscalars; ++i) {
+		rpra[i].pv = (uint64_t) ctx->args[i].ptr;
+		rpra[i].len = ctx->args[i].length;
+		list[i].num = ctx->args[i].length ? 1 : 0;
+		list[i].pgidx = i;
+		pages[i].addr = ctx->maps[i]->phys;
+		pages[i].size = ctx->maps[i]->size;
+	}
+
+bail:
+	if (err)
+		dev_err(dev, "Error: get invoke args failed:%d\n", err);
+
+	return err;
+}
+
+static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
+			    uint32_t kernel)
+{
+	struct fastrpc_remote_arg *rpra = ctx->rpra;
+	struct device *dev = ctx->fl->sctx->dev;
+	int i, inbufs, err;
+
+	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
+
+	for (i = inbufs; i < ctx->nbufs; ++i) {
+		if (ctx->maps[i]) {
+			fastrpc_map_put(ctx->maps[i]);
+			ctx->maps[i] = NULL;
+			continue;
+		}
+
+		if (!kernel) {
+			err = copy_to_user((void __user *)ctx->args[i].ptr,
+					  (void  *)rpra[i].pv, rpra[i].len);
+			if (err) {
+				dev_err(dev, "Error: copy buffer %d\n", err);
+				return err;
+			}
+		} else {
+			memcpy(ctx->args[i].ptr, (void *)rpra[i].pv,
+			       rpra[i].len);
+		}
+	}
+
+	return 0;
+}
+
+static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
+			       struct fastrpc_invoke_ctx *ctx,
+			       uint32_t kernel, uint32_t handle)
+{
+	struct fastrpc_channel_ctx *cctx;
+	struct fastrpc_user *fl = ctx->fl;
+	struct fastrpc_msg *msg = &ctx->msg;
+
+	cctx = fl->cctx;
+	msg->pid = fl->tgid;
+	msg->tid = current->pid;
+
+	if (kernel)
+		msg->pid = 0;
+
+	msg->ctx = ctx->ctxid | fl->pd;
+	msg->handle = handle;
+	msg->sc = ctx->sc;
+	msg->addr = ctx->buf ? ctx->buf->phys : 0;
+	msg->size = roundup(ctx->used_sz, PAGE_SIZE);
+
+	return rpmsg_send(cctx->rpdev->ept, (void *)msg, sizeof(*msg));
+}
+
+static int fastrpc_internal_invoke(struct fastrpc_user *fl,
+				   uint32_t kernel,
+				   struct fastrpc_invoke *inv)
+{
+	struct fastrpc_invoke_ctx *ctx = NULL;
+	int err = 0;
+
+	if (!fl->sctx)
+		return -EINVAL;
+
+	ctx = fastrpc_context_alloc(fl, kernel, inv);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	if (ctx->nscalars) {
+		err = fastrpc_get_args(kernel, ctx);
+		if (err)
+			goto bail;
+	}
+	/* Send invoke buffer to remote dsp */
+	err = fastrpc_invoke_send(fl->sctx, ctx, kernel, inv->handle);
+	if (err)
+		goto bail;
+
+	/* Wait for remote dsp to respond or time out */
+	err = wait_for_completion_interruptible(&ctx->work);
+	if (err)
+		goto bail;
+
+	/* Check the response from remote dsp */
+	err = ctx->retval;
+	if (err)
+		goto bail;
+
+	/* populate all the output buffers with results */
+	err = fastrpc_put_args(ctx, kernel);
+	if (err)
+		goto bail;
+
+	/* We are done with this compute, release it now! */
+bail:
+	if (ctx)
+		fastrpc_context_free(ctx);
+
+	if (err)
+		dev_err(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
+
+	return err;
+}
+
 static struct fastrpc_session_ctx *fastrpc_session_alloc(
 					struct fastrpc_channel_ctx *cctx,
 					int secure)
@@ -98,11 +709,22 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 {
 	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
 	struct fastrpc_channel_ctx *cctx = fl->cctx;
+	struct fastrpc_invoke_ctx *ctx, *n;
+	struct fastrpc_map *map, *m;
 
 	spin_lock(&cctx->lock);
 	list_del(&fl->user);
 	spin_unlock(&cctx->lock);
 
+	if (fl->init_mem)
+		fastrpc_buf_free(fl->init_mem);
+
+	list_for_each_entry_safe(ctx, n, &fl->pending, node)
+		fastrpc_context_free(ctx);
+
+	list_for_each_entry_safe(map, m, &fl->maps, node)
+		fastrpc_map_put(map);
+
 	fastrpc_session_free(fl->cctx, fl->sctx);
 
 	mutex_destroy(&fl->mutex);
@@ -137,9 +759,62 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static long fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
+{
+	struct fastrpc_invoke_args *args = NULL;
+	struct fastrpc_invoke inv;
+	int nscalars, err;
+
+	if (copy_from_user(&inv, argp, sizeof(inv)))
+		return -EFAULT;
+
+	nscalars = REMOTE_SCALARS_LENGTH(inv.sc);
+	if (nscalars) {
+		args = kcalloc(nscalars, sizeof(*args), GFP_KERNEL);
+		if (!args)
+			return -ENOMEM;
+
+		if (copy_from_user(args, (void __user *)inv.args,
+				   nscalars * sizeof(*args))) {
+			kfree(args);
+			return -EFAULT;
+		}
+	}
+
+	inv.args = args;
+	err = fastrpc_internal_invoke(fl, 0, &inv);
+	kfree(args);
+
+	return err;
+}
+
+static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
+				 unsigned long arg)
+{
+	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
+	char __user *argp = (char __user *)arg;
+	int err;
+
+	switch (cmd) {
+	case FASTRPC_IOCTL_INVOKE:
+		err = fastrpc_invoke(fl, argp);
+		break;
+	default:
+		err = -ENOTTY;
+		dev_err(fl->sctx->dev, "bad ioctl: %d\n", cmd);
+		break;
+	}
+
+	if (err)
+		dev_err(fl->sctx->dev, "Error: IOCTL Failed with %d\n", err);
+
+	return err;
+}
+
 static const struct file_operations fastrpc_fops = {
 	.open = fastrpc_device_open,
 	.release = fastrpc_device_release,
+	.unlocked_ioctl = fastrpc_device_ioctl,
 };
 
 static int fastrpc_cb_probe(struct platform_device *pdev)
@@ -256,9 +931,25 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	return of_platform_populate(rdev->of_node, NULL, NULL, rdev);
 }
 
+static void fastrpc_notify_users(struct fastrpc_user *user)
+{
+	struct fastrpc_invoke_ctx *ctx, *n;
+
+	spin_lock(&user->lock);
+	list_for_each_entry_safe(ctx, n, &user->pending, node)
+		complete(&ctx->work);
+	spin_unlock(&user->lock);
+}
+
 static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
+	struct fastrpc_user *user, *n;
+
+	spin_lock(&cctx->lock);
+	list_for_each_entry_safe(user, n, &cctx->users, user)
+		fastrpc_notify_users(user);
+	spin_unlock(&cctx->lock);
 
 	misc_deregister(&cctx->miscdev);
 	of_platform_depopulate(&rpdev->dev);
@@ -268,6 +959,31 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 				  int len, void *priv, u32 addr)
 {
+	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
+	struct fastrpc_invoke_rsp *rsp = data;
+	struct fastrpc_invoke_ctx *ctx;
+	unsigned long flags;
+	int ctxid;
+
+	if (rsp && len < sizeof(*rsp)) {
+		dev_err(&rpdev->dev, "invalid response or context\n");
+		return -EINVAL;
+	}
+
+	ctxid = (uint32_t)((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
+
+	spin_lock_irqsave(&cctx->lock, flags);
+	ctx = idr_find(&cctx->ctx_idr, ctxid);
+	spin_unlock_irqrestore(&cctx->lock, flags);
+
+	if (!ctx) {
+		dev_err(&rpdev->dev, "No context ID matches response\n");
+		return -ENOENT;
+	}
+
+	ctx->retval = rsp->retval;
+	complete(&ctx->work);
+
 	return 0;
 }
 
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
new file mode 100644
index 000000000000..0b408ba62482
--- /dev/null
+++ b/include/uapi/misc/fastrpc.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __QCOM_FASTRPC_H__
+#define __QCOM_FASTRPC_H__
+
+#include <linux/types.h>
+
+#define FASTRPC_IOCTL_INVOKE		_IOWR('R', 3, struct fastrpc_invoke)
+
+struct fastrpc_invoke_args {
+	__s32 fd;
+	size_t length;
+	void *ptr;
+};
+
+struct fastrpc_invoke {
+	__u32 handle;
+	__u32 sc;
+	struct fastrpc_invoke_args *args;
+};
+
+#endif /* __QCOM_FASTRPC_H__ */
-- 
2.19.2

