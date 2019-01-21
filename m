Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060CDC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF29920879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078506;
	bh=P5uaf15BJdJpfkmZNRLqeceTHtFDDYIym1XKNYjBN8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cGDNt6wWxRI8JWGmYNBW8isSb1GRQRfNjcylHkrxDXT+0Ct76YIbSCha2E8FAe4PU
	 hDbUEbif66kTJ+Qbd9w0JzCF46QmzfsI4mDaXhpW5MjkPvDwkK9949nIn/c9hmA3FL
	 fiSpLkQ5ST+5HLspjTVfrDpJ2zfG8EnYBEDWajuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfAUNsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:48:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729910AbfAUNsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:48:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A07B120861;
        Mon, 21 Jan 2019 13:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078502;
        bh=P5uaf15BJdJpfkmZNRLqeceTHtFDDYIym1XKNYjBN8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zPLjniD601sAAC0VtUVCSaQ3olw9K+pjhQKLcnMX8iMg2ewvOs/yHCGFuoklu+wmQ
         9S8lowrqAblI18lrw14qw9wndZ1Kb9hsMuVZP/4MG8GFA/zCjkJAA3IIGx9NNx//aU
         kJBNdKpx0V7lIdGe5FiZb8rGNrqK5FVI2A9OxDEw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.20 047/111] virtio-balloon: tweak config_changed implementation
Date:   Mon, 21 Jan 2019 14:42:41 +0100
Message-Id: <20190121122501.157819352@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Wang <wei.w.wang@intel.com>

commit bf4dc0b2beebfd9338df7c0bcf473b356f67cf66 upstream.

virtio-ccw has deadlock issues with reading the config space inside the
interrupt context, so we tweak the virtballoon_changed implementation
by moving the config read operations into the related workqueue contexts.
The config_read_bitmap is used as a flag to the workqueue callbacks
about the related config fields that need to be read.

The cmd_id_received is also renamed to cmd_id_received_cache, and
the value should be obtained via virtio_balloon_cmd_id_received.

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virtio/virtio_balloon.c |   98 ++++++++++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 33 deletions(-)

--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -61,6 +61,10 @@ enum virtio_balloon_vq {
 	VIRTIO_BALLOON_VQ_MAX
 };
 
+enum virtio_balloon_config_read {
+	VIRTIO_BALLOON_CONFIG_READ_CMD_ID = 0,
+};
+
 struct virtio_balloon {
 	struct virtio_device *vdev;
 	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq;
@@ -77,14 +81,20 @@ struct virtio_balloon {
 	/* Prevent updating balloon when it is being canceled. */
 	spinlock_t stop_update_lock;
 	bool stop_update;
+	/* Bitmap to indicate if reading the related config fields are needed */
+	unsigned long config_read_bitmap;
 
 	/* The list of allocated free pages, waiting to be given back to mm */
 	struct list_head free_page_list;
 	spinlock_t free_page_list_lock;
 	/* The number of free page blocks on the above list */
 	unsigned long num_free_page_blocks;
-	/* The cmd id received from host */
-	u32 cmd_id_received;
+	/*
+	 * The cmd id received from host.
+	 * Read it via virtio_balloon_cmd_id_received to get the latest value
+	 * sent from host.
+	 */
+	u32 cmd_id_received_cache;
 	/* The cmd id that is actively in use */
 	__virtio32 cmd_id_active;
 	/* Buffer to store the stop sign */
@@ -390,37 +400,31 @@ static unsigned long return_free_pages_t
 	return num_returned;
 }
 
+static void virtio_balloon_queue_free_page_work(struct virtio_balloon *vb)
+{
+	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
+		return;
+
+	/* No need to queue the work if the bit was already set. */
+	if (test_and_set_bit(VIRTIO_BALLOON_CONFIG_READ_CMD_ID,
+			     &vb->config_read_bitmap))
+		return;
+
+	queue_work(vb->balloon_wq, &vb->report_free_page_work);
+}
+
 static void virtballoon_changed(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb = vdev->priv;
 	unsigned long flags;
-	s64 diff = towards_target(vb);
 
-	if (diff) {
-		spin_lock_irqsave(&vb->stop_update_lock, flags);
-		if (!vb->stop_update)
-			queue_work(system_freezable_wq,
-				   &vb->update_balloon_size_work);
-		spin_unlock_irqrestore(&vb->stop_update_lock, flags);
-	}
-
-	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
-		virtio_cread(vdev, struct virtio_balloon_config,
-			     free_page_report_cmd_id, &vb->cmd_id_received);
-		if (vb->cmd_id_received == VIRTIO_BALLOON_CMD_ID_DONE) {
-			/* Pass ULONG_MAX to give back all the free pages */
-			return_free_pages_to_mm(vb, ULONG_MAX);
-		} else if (vb->cmd_id_received != VIRTIO_BALLOON_CMD_ID_STOP &&
-			   vb->cmd_id_received !=
-			   virtio32_to_cpu(vdev, vb->cmd_id_active)) {
-			spin_lock_irqsave(&vb->stop_update_lock, flags);
-			if (!vb->stop_update) {
-				queue_work(vb->balloon_wq,
-					   &vb->report_free_page_work);
-			}
-			spin_unlock_irqrestore(&vb->stop_update_lock, flags);
-		}
+	spin_lock_irqsave(&vb->stop_update_lock, flags);
+	if (!vb->stop_update) {
+		queue_work(system_freezable_wq,
+			   &vb->update_balloon_size_work);
+		virtio_balloon_queue_free_page_work(vb);
 	}
+	spin_unlock_irqrestore(&vb->stop_update_lock, flags);
 }
 
 static void update_balloon_size(struct virtio_balloon *vb)
@@ -527,6 +531,17 @@ static int init_vqs(struct virtio_balloo
 	return 0;
 }
 
+static u32 virtio_balloon_cmd_id_received(struct virtio_balloon *vb)
+{
+	if (test_and_clear_bit(VIRTIO_BALLOON_CONFIG_READ_CMD_ID,
+			       &vb->config_read_bitmap))
+		virtio_cread(vb->vdev, struct virtio_balloon_config,
+			     free_page_report_cmd_id,
+			     &vb->cmd_id_received_cache);
+
+	return vb->cmd_id_received_cache;
+}
+
 static int send_cmd_id_start(struct virtio_balloon *vb)
 {
 	struct scatterlist sg;
@@ -537,7 +552,8 @@ static int send_cmd_id_start(struct virt
 	while (virtqueue_get_buf(vq, &unused))
 		;
 
-	vb->cmd_id_active = cpu_to_virtio32(vb->vdev, vb->cmd_id_received);
+	vb->cmd_id_active = virtio32_to_cpu(vb->vdev,
+					virtio_balloon_cmd_id_received(vb));
 	sg_init_one(&sg, &vb->cmd_id_active, sizeof(vb->cmd_id_active));
 	err = virtqueue_add_outbuf(vq, &sg, 1, &vb->cmd_id_active, GFP_KERNEL);
 	if (!err)
@@ -620,7 +636,8 @@ static int send_free_pages(struct virtio
 		 * stop the reporting.
 		 */
 		cmd_id_active = virtio32_to_cpu(vb->vdev, vb->cmd_id_active);
-		if (cmd_id_active != vb->cmd_id_received)
+		if (unlikely(cmd_id_active !=
+			     virtio_balloon_cmd_id_received(vb)))
 			break;
 
 		/*
@@ -637,11 +654,9 @@ static int send_free_pages(struct virtio
 	return 0;
 }
 
-static void report_free_page_func(struct work_struct *work)
+static void virtio_balloon_report_free_page(struct virtio_balloon *vb)
 {
 	int err;
-	struct virtio_balloon *vb = container_of(work, struct virtio_balloon,
-						 report_free_page_work);
 	struct device *dev = &vb->vdev->dev;
 
 	/* Start by sending the received cmd id to host with an outbuf. */
@@ -659,6 +674,23 @@ static void report_free_page_func(struct
 		dev_err(dev, "Failed to send a stop id, err = %d\n", err);
 }
 
+static void report_free_page_func(struct work_struct *work)
+{
+	struct virtio_balloon *vb = container_of(work, struct virtio_balloon,
+						 report_free_page_work);
+	u32 cmd_id_received;
+
+	cmd_id_received = virtio_balloon_cmd_id_received(vb);
+	if (cmd_id_received == VIRTIO_BALLOON_CMD_ID_DONE) {
+		/* Pass ULONG_MAX to give back all the free pages */
+		return_free_pages_to_mm(vb, ULONG_MAX);
+	} else if (cmd_id_received != VIRTIO_BALLOON_CMD_ID_STOP &&
+		   cmd_id_received !=
+		   virtio32_to_cpu(vb->vdev, vb->cmd_id_active)) {
+		virtio_balloon_report_free_page(vb);
+	}
+}
+
 #ifdef CONFIG_BALLOON_COMPACTION
 /*
  * virtballoon_migratepage - perform the balloon page migration on behalf of
@@ -885,7 +917,7 @@ static int virtballoon_probe(struct virt
 			goto out_del_vqs;
 		}
 		INIT_WORK(&vb->report_free_page_work, report_free_page_func);
-		vb->cmd_id_received = VIRTIO_BALLOON_CMD_ID_STOP;
+		vb->cmd_id_received_cache = VIRTIO_BALLOON_CMD_ID_STOP;
 		vb->cmd_id_active = cpu_to_virtio32(vb->vdev,
 						  VIRTIO_BALLOON_CMD_ID_STOP);
 		vb->cmd_id_stop = cpu_to_virtio32(vb->vdev,


