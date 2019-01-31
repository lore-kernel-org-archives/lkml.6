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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCF0C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C0D218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPeKV09k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbfAaPl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:41:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45754 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733294AbfAaPl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:41:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so1618350pfd.12;
        Thu, 31 Jan 2019 07:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LPEnAs1s1euCAFGxf6zSo7VBhGEAMz6C30FuyvD2OCk=;
        b=IPeKV09kexzXO5G17YF+vT/FyQHcVvceIdPUHvIiVtBO7tHmOyClX3jJ6C07kfyyvP
         KE2s/7xylEh6pCjTjTRPXZWw/0n3TkayYO90KE9lgN6dXqVZ2nmyEZMPtYYr5NOu/sS6
         mOmsa55U9ktJT9SLioGX8B4VzvGwT8VAbJ3LTkoFvCoDASAq3SJBMx+loLwu2lzJi5jE
         +YZecA+5Y47ba2+DOMfTuA92qWPZOgA0TBGFoVkYh6Zw783GvCV3dSw9zRBbFwB8QrNR
         0Nr9TeTp869idkNFxUEwkzymcoTXraUvd5cNrXirSWK9eOy396ERiAt4KbFl9Wv/9/Ha
         ZMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LPEnAs1s1euCAFGxf6zSo7VBhGEAMz6C30FuyvD2OCk=;
        b=Wr/rAD/QWD2VgdAQCmzmT7chZWVrU3AHQQeN1yxUvpcavZJX4CKDh1sLEVhS54slRn
         gaPv/F4qinKPFSXSlg1PfVzEZ0tnADTnM64vHJmZCnn3RUO8RqhLqmx/loAVDJxAE+3k
         YWZY4jENc7+ks7Jofcex011zuMC6ixAoYR8TwhCWcAsoD9TbkFIKv7/3AQuZek3WVang
         WgclAcN3b7SOQ065JzE2Cm/bA9MP3MRpE6DH5zeq1CKXKzif8ioXlBTXY4CpeqOjauvT
         B+PaC0hIDBBwuFT04bQ18CsvVRMUNrr2mdDM5gmj5/QsEzPHplNK4AzhKybCrJUh3mGm
         KMhA==
X-Gm-Message-State: AJcUukf0u16pUcB5HtdVisCtNzuFBGTBfmo1zLnWygFuaeYiPlRsaCGm
        9CPwWcZUOchHbRzXqX1GH1kJqijK5mI=
X-Google-Smtp-Source: ALg8bN5HqGGemWW7RH8/B136FlEi1+H2nGm5alHHEpVbne3VbDBq7QUm0G8bM3SpGWIA1GJKb02SKw==
X-Received: by 2002:a62:8e19:: with SMTP id k25mr35280609pfe.185.1548949315498;
        Thu, 31 Jan 2019 07:41:55 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id b2sm6622435pgg.87.2019.01.31.07.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jan 2019 07:41:54 -0800 (PST)
From:   Xiang Xiao <xiaoxiang781216@gmail.com>
X-Google-Original-From: Xiang Xiao <xiaoxiang@xiaomi.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        wendy.liang@xilinx.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: [PATCH 1/3] rpmsg: virtio_rpmsg_bus: allow the different vring size for send/recv
Date:   Thu, 31 Jan 2019 23:41:18 +0800
Message-Id: <1548949280-31794-2-git-send-email-xiaoxiang@xiaomi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com>
References: <1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it's useful if the communication throughput is different from each side

Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 47 ++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 664f957..fb0d2eb 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -36,8 +36,9 @@
  * @svq:	tx virtqueue
  * @rbufs:	kernel address of rx buffers
  * @sbufs:	kernel address of tx buffers
- * @num_bufs:	total number of buffers for rx and tx
- * @buf_size:   size of one rx or tx buffer
+ * @num_rbufs:	total number of buffers for rx
+ * @num_sbufs:	total number of buffers for tx
+ * @buf_size:	size of one rx or tx buffer
  * @last_sbuf:	index of last tx buffer used
  * @bufs_dma:	dma base addr of the buffers
  * @tx_lock:	protects svq, sbufs and sleepers, to allow concurrent senders.
@@ -57,7 +58,8 @@ struct virtproc_info {
 	struct virtio_device *vdev;
 	struct virtqueue *rvq, *svq;
 	void *rbufs, *sbufs;
-	unsigned int num_bufs;
+	unsigned int num_rbufs;
+	unsigned int num_sbufs;
 	unsigned int buf_size;
 	int last_sbuf;
 	dma_addr_t bufs_dma;
@@ -136,7 +138,7 @@ struct virtio_rpmsg_channel {
 /*
  * We're allocating buffers of 512 bytes each for communications. The
  * number of buffers will be computed from the number of buffers supported
- * by the vring, upto a maximum of 512 buffers (256 in each direction).
+ * by the vring, up to a maximum of 256 in each direction.
  *
  * Each buffer will have 16 bytes for the msg header and 496 bytes for
  * the payload.
@@ -151,7 +153,7 @@ struct virtio_rpmsg_channel {
  * can change this without changing anything in the firmware of the remote
  * processor.
  */
-#define MAX_RPMSG_NUM_BUFS	(512)
+#define MAX_RPMSG_NUM_BUFS	(256)
 #define MAX_RPMSG_BUF_SIZE	(512)
 
 /*
@@ -446,11 +448,8 @@ static void *get_a_tx_buf(struct virtproc_info *vrp)
 	/* support multiple concurrent senders */
 	mutex_lock(&vrp->tx_lock);
 
-	/*
-	 * either pick the next unused tx buffer
-	 * (half of our buffers are used for sending messages)
-	 */
-	if (vrp->last_sbuf < vrp->num_bufs / 2)
+	/* either pick the next unused tx buffer */
+	if (vrp->last_sbuf < vrp->num_sbufs)
 		ret = vrp->sbufs + vrp->buf_size * vrp->last_sbuf++;
 	/* or recycle a used one */
 	else
@@ -897,19 +896,20 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	vrp->rvq = vqs[0];
 	vrp->svq = vqs[1];
 
-	/* we expect symmetric tx/rx vrings */
-	WARN_ON(virtqueue_get_vring_size(vrp->rvq) !=
-		virtqueue_get_vring_size(vrp->svq));
-
 	/* we need less buffers if vrings are small */
-	if (virtqueue_get_vring_size(vrp->rvq) < MAX_RPMSG_NUM_BUFS / 2)
-		vrp->num_bufs = virtqueue_get_vring_size(vrp->rvq) * 2;
+	if (virtqueue_get_vring_size(vrp->rvq) < MAX_RPMSG_NUM_BUFS)
+		vrp->num_rbufs = virtqueue_get_vring_size(vrp->rvq);
+	else
+		vrp->num_rbufs = MAX_RPMSG_NUM_BUFS;
+
+	if (virtqueue_get_vring_size(vrp->svq) < MAX_RPMSG_NUM_BUFS)
+		vrp->num_sbufs = virtqueue_get_vring_size(vrp->svq);
 	else
-		vrp->num_bufs = MAX_RPMSG_NUM_BUFS;
+		vrp->num_sbufs = MAX_RPMSG_NUM_BUFS;
 
 	vrp->buf_size = MAX_RPMSG_BUF_SIZE;
 
-	total_buf_space = vrp->num_bufs * vrp->buf_size;
+	total_buf_space = (vrp->num_rbufs + vrp->num_sbufs) * vrp->buf_size;
 
 	/* allocate coherent memory for the buffers */
 	bufs_va = dma_alloc_coherent(vdev->dev.parent->parent,
@@ -923,14 +923,14 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	dev_dbg(&vdev->dev, "buffers: va %p, dma %pad\n",
 		bufs_va, &vrp->bufs_dma);
 
-	/* half of the buffers is dedicated for RX */
+	/* first part of the buffers is dedicated for RX */
 	vrp->rbufs = bufs_va;
 
-	/* and half is dedicated for TX */
-	vrp->sbufs = bufs_va + total_buf_space / 2;
+	/* and second part is dedicated for TX */
+	vrp->sbufs = bufs_va + vrp->num_rbufs * vrp->buf_size;
 
 	/* set up the receive buffers */
-	for (i = 0; i < vrp->num_bufs / 2; i++) {
+	for (i = 0; i < vrp->num_rbufs; i++) {
 		struct scatterlist sg;
 		void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
 
@@ -999,7 +999,8 @@ static int rpmsg_remove_device(struct device *dev, void *data)
 static void rpmsg_remove(struct virtio_device *vdev)
 {
 	struct virtproc_info *vrp = vdev->priv;
-	size_t total_buf_space = vrp->num_bufs * vrp->buf_size;
+	unsigned int num_bufs = vrp->num_rbufs + vrp->num_sbufs;
+	size_t total_buf_space = num_bufs * vrp->buf_size;
 	int ret;
 
 	vdev->config->reset(vdev);
-- 
2.7.4

