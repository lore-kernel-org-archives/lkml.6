Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DCAC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951CD20835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951CD20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbeJNXNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:13:24 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36393 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728254AbeJNXMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:07 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLu-0004co-CK; Sun, 14 Oct 2018 16:30:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0000Si-J9; Sun, 14 Oct 2018 16:30:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.53454328@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 222/366] virtio_console: don't tie bufs to a vq
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Michael S. Tsirkin" <mst@redhat.com>

commit 2855b33514d290c51d52d94e25d3ef942cd4d578 upstream.

an allocated buffer doesn't need to be tied to a vq -
only vq->vdev is ever used. Pass the function the
just what it needs - the vdev.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/char/virtio_console.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -417,7 +417,7 @@ static void reclaim_dma_bufs(void)
 	}
 }
 
-static struct port_buffer *alloc_buf(struct virtqueue *vq, size_t buf_size,
+static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size,
 				     int pages)
 {
 	struct port_buffer *buf;
@@ -440,7 +440,7 @@ static struct port_buffer *alloc_buf(str
 		return buf;
 	}
 
-	if (is_rproc_serial(vq->vdev)) {
+	if (is_rproc_serial(vdev)) {
 		/*
 		 * Allocate DMA memory from ancestor. When a virtio
 		 * device is created by remoteproc, the DMA memory is
@@ -450,9 +450,9 @@ static struct port_buffer *alloc_buf(str
 		 * DMA_MEMORY_INCLUDES_CHILDREN had been supported
 		 * in dma-coherent.c
 		 */
-		if (!vq->vdev->dev.parent || !vq->vdev->dev.parent->parent)
+		if (!vdev->dev.parent || !vdev->dev.parent->parent)
 			goto free_buf;
-		buf->dev = vq->vdev->dev.parent->parent;
+		buf->dev = vdev->dev.parent->parent;
 
 		/* Increase device refcnt to avoid freeing it */
 		get_device(buf->dev);
@@ -834,7 +834,7 @@ static ssize_t port_fops_write(struct fi
 
 	count = min((size_t)(32 * 1024), count);
 
-	buf = alloc_buf(port->out_vq, count, 0);
+	buf = alloc_buf(port->portdev->vdev, count, 0);
 	if (!buf)
 		return -ENOMEM;
 
@@ -953,7 +953,7 @@ static ssize_t port_fops_splice_write(st
 	if (ret < 0)
 		goto error_out;
 
-	buf = alloc_buf(port->out_vq, 0, pipe->nrbufs);
+	buf = alloc_buf(port->portdev->vdev, 0, pipe->nrbufs);
 	if (!buf) {
 		ret = -ENOMEM;
 		goto error_out;
@@ -1370,7 +1370,7 @@ static unsigned int fill_queue(struct vi
 
 	nr_added_bufs = 0;
 	do {
-		buf = alloc_buf(vq, PAGE_SIZE, 0);
+		buf = alloc_buf(vq->vdev, PAGE_SIZE, 0);
 		if (!buf)
 			break;
 

