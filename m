Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A835C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35B9218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGHlg8rd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbfAaPmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:42:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42878 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfAaPmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:42:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so1499249pga.9;
        Thu, 31 Jan 2019 07:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I8VVx1Bzqq4HqI1/o34OWmPP0PQlH5I+uT7NAiVx8YY=;
        b=BGHlg8rdJ2f0xnz4wMoxGFF4pPkb/EAmLQeWaYvSEfKHSF7/9iVvhGWR+m3bnm+ulV
         l7k8kRLFInHEtde9/lnFvBPuE3fcoPsXsYTVcEJym5ee+7/5yaZ8jAmKWq7WrYXZjU/6
         NJKLa576+bI7GpbGCdj8Yv7gtpGSizfMU0uZYBbOKmEellLzQ0QSjWlrFk3g7kc/RFS9
         naz6sW9xsZPZM4mWSSr0jwiT0+yN4XSn0vzrgynS79SNgH2yzeMcL6OwM5VNMCShe7Je
         vcnzDBmBLpugPIGE9BPYAbWOHTRy8e64B0Of3sC965i2I9SBtdLxn27wpm29tYgPVPSX
         lLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I8VVx1Bzqq4HqI1/o34OWmPP0PQlH5I+uT7NAiVx8YY=;
        b=bumxVoVWBgwd45jlIeAFcc5F3UzRnSoHbH7h/aG39TUJ5AJklaXRRktYNVUHOufFG1
         kB7MVsYKs0IB10ekxh5CCL1DMJFm5xNRuiSDoYmfsHzBhr/BVBD8SnlZRG3USnw1MsGv
         nNHpeFRu2ojUSPzhtakLmX6nPSfEg0KquCiNt1wT9ADLClgKUrzzQSceyPJlJqrrOlby
         jS6oobh74000FPdJeMfhV4kJOYoObtmN/QIibn4IVi/k12OVSh7LX4AP+7lGVZfHQxBp
         ARYky/6T4H+bAW5bCZ1TvR59pDGh9/X3Uii7h5rC30w0pF1vmusn60d2c/IgIzfIyEtd
         Lg8g==
X-Gm-Message-State: AJcUukeUjvDZUtMoVKE7QlcHwK8nNU0Xh+Ycz7XdcrmcSEob86xW9xq2
        VGaEYIZLNUceRz3mgccUebY=
X-Google-Smtp-Source: ALg8bN7VGZpNB38CnkW6VNZY5oZnMyaEqG/MPE3tcIz5mx+d3/8pKpRavkzgt/MwzZgu3zQpZhqolg==
X-Received: by 2002:a63:f241:: with SMTP id d1mr32136038pgk.2.1548949320309;
        Thu, 31 Jan 2019 07:42:00 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id b2sm6622435pgg.87.2019.01.31.07.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jan 2019 07:41:59 -0800 (PST)
From:   Xiang Xiao <xiaoxiang781216@gmail.com>
X-Google-Original-From: Xiang Xiao <xiaoxiang@xiaomi.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        wendy.liang@xilinx.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: [PATCH 3/3] rpmsg: virtio_rpmsg_bus: get buffer size from config space
Date:   Thu, 31 Jan 2019 23:41:20 +0800
Message-Id: <1548949280-31794-4-git-send-email-xiaoxiang@xiaomi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com>
References: <1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

512 bytes isn't always suitable for all case, let firmware
maker decide the best value from resource table.
enable by VIRTIO_RPMSG_F_BUFSZ feature bit.

Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c  | 50 +++++++++++++++++++++++++--------------
 include/uapi/linux/virtio_rpmsg.h | 24 +++++++++++++++++++
 2 files changed, 56 insertions(+), 18 deletions(-)
 create mode 100644 include/uapi/linux/virtio_rpmsg.h

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 59c4554..049dd97 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -16,6 +16,7 @@
 #include <linux/virtio.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
+#include <linux/virtio_rpmsg.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
@@ -38,7 +39,8 @@
  * @sbufs:	kernel address of tx buffers
  * @num_rbufs:	total number of buffers for rx
  * @num_sbufs:	total number of buffers for tx
- * @buf_size:	size of one rx or tx buffer
+ * @rbuf_size:	size of one rx buffer
+ * @sbuf_size:	size of one tx buffer
  * @last_sbuf:	index of last tx buffer used
  * @rbufs_dma:	dma base addr of rx buffers
  * @sbufs_dma:	dma base addr of tx buffers
@@ -61,7 +63,8 @@ struct virtproc_info {
 	void *rbufs, *sbufs;
 	unsigned int num_rbufs;
 	unsigned int num_sbufs;
-	unsigned int buf_size;
+	unsigned int rbuf_size;
+	unsigned int sbuf_size;
 	int last_sbuf;
 	dma_addr_t rbufs_dma;
 	dma_addr_t sbufs_dma;
@@ -73,9 +76,6 @@ struct virtproc_info {
 	struct rpmsg_endpoint *ns_ept;
 };
 
-/* The feature bitmap for virtio rpmsg */
-#define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
-
 /**
  * struct rpmsg_hdr - common header for all rpmsg messages
  * @src: source address
@@ -452,7 +452,7 @@ static void *get_a_tx_buf(struct virtproc_info *vrp)
 
 	/* either pick the next unused tx buffer */
 	if (vrp->last_sbuf < vrp->num_sbufs)
-		ret = vrp->sbufs + vrp->buf_size * vrp->last_sbuf++;
+		ret = vrp->sbufs + vrp->sbuf_size * vrp->last_sbuf++;
 	/* or recycle a used one */
 	else
 		ret = virtqueue_get_buf(vrp->svq, &len);
@@ -578,7 +578,7 @@ static int rpmsg_send_offchannel_raw(struct rpmsg_device *rpdev,
 	 * messaging), or to improve the buffer allocator, to support
 	 * variable-length buffer sizes.
 	 */
-	if (len > vrp->buf_size - sizeof(struct rpmsg_hdr)) {
+	if (len > vrp->sbuf_size - sizeof(struct rpmsg_hdr)) {
 		dev_err(dev, "message is too big (%d)\n", len);
 		return -EMSGSIZE;
 	}
@@ -718,7 +718,7 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
 	 * We currently use fixed-sized buffers, so trivially sanitize
 	 * the reported payload length.
 	 */
-	if (len > vrp->buf_size ||
+	if (len > vrp->rbuf_size ||
 	    msg->len > (len - sizeof(struct rpmsg_hdr))) {
 		dev_warn(dev, "inbound msg too big: (%d, %d)\n", len, msg->len);
 		return -EINVAL;
@@ -751,7 +751,7 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
 		dev_warn(dev, "msg received with no recipient\n");
 
 	/* publish the real size of the buffer */
-	rpmsg_sg_init(&sg, msg, vrp->buf_size);
+	rpmsg_sg_init(&sg, msg, vrp->rbuf_size);
 
 	/* add the buffer back to the remote processor's virtqueue */
 	err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, msg, GFP_KERNEL);
@@ -907,11 +907,24 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	else
 		vrp->num_sbufs = MAX_RPMSG_NUM_BUFS;
 
-	vrp->buf_size = MAX_RPMSG_BUF_SIZE;
+	/* try to get buffer size from config space */
+	if (virtio_has_feature(vdev, VIRTIO_RPMSG_F_BUFSZ)) {
+		/* note: virtio_rpmsg_config is defined from remote view */
+		virtio_cread(vdev, struct virtio_rpmsg_config,
+			     txbuf_size, &vrp->rbuf_size);
+		virtio_cread(vdev, struct virtio_rpmsg_config,
+			     rxbuf_size, &vrp->sbuf_size);
+	}
+
+	/* use the default if resource table doesn't provide one */
+	if (!vrp->rbuf_size)
+		vrp->rbuf_size = MAX_RPMSG_BUF_SIZE;
+	if (!vrp->sbuf_size)
+		vrp->sbuf_size = MAX_RPMSG_BUF_SIZE;
 
 	/* allocate coherent memory for the buffers */
 	vrp->rbufs = dma_alloc_coherent(vdev->dev.parent->parent,
-					vrp->num_rbufs * vrp->buf_size,
+					vrp->num_rbufs * vrp->rbuf_size,
 					&vrp->rbufs_dma, GFP_KERNEL);
 	if (!vrp->rbufs) {
 		err = -ENOMEM;
@@ -922,7 +935,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
 		vrp->rbufs, &vrp->rbufs_dma);
 
 	vrp->sbufs = dma_alloc_coherent(vdev->dev.parent->parent,
-					vrp->num_sbufs * vrp->buf_size,
+					vrp->num_sbufs * vrp->sbuf_size,
 					&vrp->sbufs_dma, GFP_KERNEL);
 	if (!vrp->sbufs) {
 		err = -ENOMEM;
@@ -935,9 +948,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	/* set up the receive buffers */
 	for (i = 0; i < vrp->num_rbufs; i++) {
 		struct scatterlist sg;
-		void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
+		void *cpu_addr = vrp->rbufs + i * vrp->rbuf_size;
 
-		rpmsg_sg_init(&sg, cpu_addr, vrp->buf_size);
+		rpmsg_sg_init(&sg, cpu_addr, vrp->rbuf_size);
 
 		err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, cpu_addr,
 					  GFP_KERNEL);
@@ -984,11 +997,11 @@ static int rpmsg_probe(struct virtio_device *vdev)
 
 free_sbufs:
 	dma_free_coherent(vdev->dev.parent->parent,
-			  vrp->num_sbufs * vrp->buf_size,
+			  vrp->num_sbufs * vrp->sbuf_size,
 			  vrp->sbufs, vrp->sbufs_dma);
 free_rbufs:
 	dma_free_coherent(vdev->dev.parent->parent,
-			  vrp->num_rbufs * vrp->buf_size,
+			  vrp->num_rbufs * vrp->rbuf_size,
 			  vrp->rbufs, vrp->rbufs_dma);
 vqs_del:
 	vdev->config->del_vqs(vrp->vdev);
@@ -1023,10 +1036,10 @@ static void rpmsg_remove(struct virtio_device *vdev)
 	vdev->config->del_vqs(vrp->vdev);
 
 	dma_free_coherent(vdev->dev.parent->parent,
-			  vrp->num_sbufs * vrp->buf_size,
+			  vrp->num_sbufs * vrp->sbuf_size,
 			  vrp->sbufs, vrp->sbufs_dma);
 	dma_free_coherent(vdev->dev.parent->parent,
-			  vrp->num_rbufs * vrp->buf_size,
+			  vrp->num_rbufs * vrp->rbuf_size,
 			  vrp->rbufs, vrp->rbufs_dma);
 
 	kfree(vrp);
@@ -1039,6 +1052,7 @@ static struct virtio_device_id id_table[] = {
 
 static unsigned int features[] = {
 	VIRTIO_RPMSG_F_NS,
+	VIRTIO_RPMSG_F_BUFSZ,
 };
 
 static struct virtio_driver virtio_ipc_driver = {
diff --git a/include/uapi/linux/virtio_rpmsg.h b/include/uapi/linux/virtio_rpmsg.h
new file mode 100644
index 0000000..24fa0dd
--- /dev/null
+++ b/include/uapi/linux/virtio_rpmsg.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) Pinecone Inc. 2019
+ * Copyright (C) Xiang Xiao <xiaoxiang@pinecone.net>
+ */
+
+#ifndef _UAPI_LINUX_VIRTIO_RPMSG_H
+#define _UAPI_LINUX_VIRTIO_RPMSG_H
+
+#include <linux/types.h>
+
+/* The feature bitmap for virtio rpmsg */
+#define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
+#define VIRTIO_RPMSG_F_BUFSZ	2 /* RP get buffer size from config space */
+
+struct virtio_rpmsg_config {
+	/* The tx/rx individual buffer size(if VIRTIO_RPMSG_F_BUFSZ) */
+	__u32 txbuf_size;
+	__u32 rxbuf_size;
+	__u32 reserved[14]; /* Reserve for the future use */
+	/* Put the customize config here */
+} __attribute__((packed));
+
+#endif /* _UAPI_LINUX_VIRTIO_RPMSG_H */
-- 
2.7.4

