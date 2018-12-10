Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17BEC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92592082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92592082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbeLJRRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:17:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728391AbeLJRNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0C7B3084042;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52DE960634;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9C1C1224272; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 38/52] Dispatch FORGET requests later instead of dropping them
Date:   Mon, 10 Dec 2018 12:13:04 -0500
Message-Id: <20181210171318.16998-39-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If virtio queue is full, then don't drop FORGET requests. Instead, wait
a bit and try to dispatch these little later using a worker thread.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 98dba3cf9d40..f436f5b3f85c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -22,6 +22,8 @@ static LIST_HEAD(virtio_fs_instances);
 struct virtio_fs_vq {
 	struct virtqueue *vq;     /* protected by fpq->lock */
 	struct work_struct done_work;
+	struct list_head queued_reqs;
+	struct delayed_work dispatch_work;
 	struct fuse_dev *fud;
 	char name[24];
 } ____cacheline_aligned_in_smp;
@@ -53,6 +55,13 @@ struct virtio_fs {
 	size_t window_len;
 };
 
+struct virtio_fs_forget {
+	struct fuse_in_header ih;
+	struct fuse_forget_in arg;
+	/* This request can be temporarily queued on virt queue */
+	struct list_head list;
+};
+
 /* TODO: This should be in a PCI file somewhere */
 static int virtio_pci_find_shm_cap(struct pci_dev *dev,
                                    u8 required_id,
@@ -189,6 +198,7 @@ static void virtio_fs_free_devs(struct virtio_fs *fs)
 			continue;
 
 		flush_work(&fsvq->done_work);
+		flush_delayed_work(&fsvq->dispatch_work);
 
 		fuse_dev_free(fsvq->fud); /* TODO need to quiesce/end_requests/decrement dev_count */
 		fsvq->fud = NULL;
@@ -252,6 +262,58 @@ static void virtio_fs_hiprio_done_work(struct work_struct *work)
 	spin_unlock(&fpq->lock);
 }
 
+static void virtio_fs_dummy_dispatch_work(struct work_struct *work)
+{
+	return;
+}
+
+static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
+{
+	struct virtio_fs_forget *forget;
+	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
+						 dispatch_work.work);
+	struct fuse_pqueue *fpq = &fsvq->fud->pq;
+	struct virtqueue *vq = fsvq->vq;
+	struct scatterlist sg;
+	struct scatterlist *sgs[] = {&sg};
+	bool notify;
+	int ret;
+
+	pr_debug("worker virtio_fs_hiprio_dispatch_work() called.\n");
+	while(1) {
+		spin_lock(&fpq->lock);
+		forget = list_first_entry_or_null(&fsvq->queued_reqs,
+					struct virtio_fs_forget, list);
+		if (!forget) {
+			spin_unlock(&fpq->lock);
+			return;
+		}
+
+		list_del(&forget->list);
+		sg_init_one(&sg, forget, sizeof(*forget));
+
+		/* Enqueue the request */
+		dev_dbg(&vq->vdev->dev, "%s\n", __func__);
+		ret = virtqueue_add_sgs(vq, sgs, 1, 0, forget, GFP_ATOMIC);
+		if (ret < 0) {
+			pr_debug("virtio-fs: Could not queue FORGET: queue full. Will try later\n");
+			list_add_tail(&forget->list, &fsvq->queued_reqs);
+			schedule_delayed_work(&fsvq->dispatch_work,
+						msecs_to_jiffies(1));
+			/* TODO handle full virtqueue */
+			spin_unlock(&fpq->lock);
+			return;
+		}
+
+		notify = virtqueue_kick_prepare(vq);
+		spin_unlock(&fpq->lock);
+
+		if (notify)
+			virtqueue_notify(vq);
+		pr_debug("worker virtio_fs_hiprio_dispatch_work() dispatched one forget request.\n");
+	}
+}
+
 /* Allocate and copy args into req->argbuf */
 static int copy_args_to_argbuf(struct fuse_req *req)
 {
@@ -404,15 +466,24 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	snprintf(fs->vqs[0].name, sizeof(fs->vqs[0].name), "notifications");
 	INIT_WORK(&fs->vqs[0].done_work, virtio_fs_notifications_done_work);
 	names[0] = fs->vqs[0].name;
+	INIT_LIST_HEAD(&fs->vqs[0].queued_reqs);
+	INIT_DELAYED_WORK(&fs->vqs[0].dispatch_work,
+			virtio_fs_dummy_dispatch_work);
 
 	callbacks[1] = virtio_fs_vq_done;
 	snprintf(fs->vqs[1].name, sizeof(fs->vqs[1].name), "hiprio");
 	names[1] = fs->vqs[1].name;
 	INIT_WORK(&fs->vqs[1].done_work, virtio_fs_hiprio_done_work);
+	INIT_LIST_HEAD(&fs->vqs[1].queued_reqs);
+	INIT_DELAYED_WORK(&fs->vqs[1].dispatch_work,
+			virtio_fs_hiprio_dispatch_work);
 
 	/* Initialize the requests virtqueues */
 	for (i = 2; i < fs->nvqs; i++) {
 		INIT_WORK(&fs->vqs[i].done_work, virtio_fs_requests_done_work);
+		INIT_DELAYED_WORK(&fs->vqs[i].dispatch_work,
+					virtio_fs_dummy_dispatch_work);
+		INIT_LIST_HEAD(&fs->vqs[i].queued_reqs);
 		snprintf(fs->vqs[i].name, sizeof(fs->vqs[i].name),
 			 "requests.%u", i - 2);
 		callbacks[i] = virtio_fs_vq_done;
@@ -718,11 +789,6 @@ static struct virtio_driver virtio_fs_driver = {
 #endif
 };
 
-struct virtio_fs_forget {
-	struct fuse_in_header ih;
-	struct fuse_forget_in arg;
-};
-
 static void virtio_fs_wake_forget_and_unlock(struct fuse_iqueue *fiq)
 __releases(fiq->waitq.lock)
 {
@@ -733,6 +799,7 @@ __releases(fiq->waitq.lock)
 	struct scatterlist *sgs[] = {&sg};
 	struct virtio_fs *fs;
 	struct virtqueue *vq;
+	struct virtio_fs_vq *fsvq;
 	bool notify;
 	u64 unique;
 	int ret;
@@ -746,7 +813,7 @@ __releases(fiq->waitq.lock)
 	unique = fuse_get_unique(fiq);
 
 	fs = fiq->priv;
-
+	fsvq = &fs->vqs[1];
 	spin_unlock(&fiq->waitq.lock);
 
 	/* Allocate a buffer for the request */
@@ -769,14 +836,17 @@ __releases(fiq->waitq.lock)
 	sg_init_one(&sg, forget, sizeof(*forget));
 
 	/* Enqueue the request */
-	vq = fs->vqs[1].vq;
+	vq = fsvq->vq;
 	dev_dbg(&vq->vdev->dev, "%s\n", __func__);
 	fpq = vq_to_fpq(vq);
 	spin_lock(&fpq->lock);
 
 	ret = virtqueue_add_sgs(vq, sgs, 1, 0, forget, GFP_ATOMIC);
 	if (ret < 0) {
-		pr_err("virtio-fs: dropped FORGET: queue full\n");
+		pr_debug("virtio-fs: Could not queue FORGET: queue full. Will try later\n");
+		list_add_tail(&forget->list, &fsvq->queued_reqs);
+		schedule_delayed_work(&fsvq->dispatch_work,
+					msecs_to_jiffies(1));
 		/* TODO handle full virtqueue */
 		spin_unlock(&fpq->lock);
 		goto out;
-- 
2.13.6

