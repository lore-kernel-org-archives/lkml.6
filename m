Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51275C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB082082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB082082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbeLJRT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:19:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbeLJRNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 268763154861;
        Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E178F600D7;
        Mon, 10 Dec 2018 17:13:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 2FEB8223C0D; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 11/52] fuse: implement FUSE_FORGET for virtio-fs
Date:   Mon, 10 Dec 2018 12:12:37 -0500
Message-Id: <20181210171318.16998-12-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

Sent single FUSE_FORGET requests on the hiprio queue.  In the future it
may be possible to do FUSE_BATCH_FORGET but that is tricky since
virtio-fs gets called synchronously when forgets are queued.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/virtio_fs.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index fa99a31ee930..225eb729656f 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -140,10 +140,26 @@ static void virtio_fs_notifications_done_work(struct work_struct *work)
 	return;
 }
 
-static void virtio_fs_hiprio_done(struct virtqueue *vq)
+/* Work function for hiprio completion */
+static void virtio_fs_hiprio_done_work(struct work_struct *work)
 {
-	/* TODO */
-	dev_dbg(&vq->vdev->dev, "%s\n", __func__);
+	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
+						 done_work);
+	struct fuse_pqueue *fpq = &fsvq->fud->pq;
+	struct virtqueue *vq = fsvq->vq;
+
+	/* Free completed FUSE_FORGET requests */
+	spin_lock(&fpq->lock);
+	do {
+		unsigned len;
+		void *req;
+
+		virtqueue_disable_cb(vq);
+
+		while ((req = virtqueue_get_buf(vq, &len)) != NULL)
+			kfree(req);
+	} while (!virtqueue_enable_cb(vq) && likely(!virtqueue_is_broken(vq)));
+	spin_unlock(&fpq->lock);
 }
 
 /* Allocate and copy args into req->argbuf */
@@ -302,6 +318,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	callbacks[1] = virtio_fs_vq_done;
 	snprintf(fs->vqs[1].name, sizeof(fs->vqs[1].name), "hiprio");
 	names[1] = fs->vqs[1].name;
+	INIT_WORK(&fs->vqs[1].done_work, virtio_fs_hiprio_done_work);
 
 	/* Initialize the requests virtqueues */
 	for (i = 2; i < fs->nvqs; i++) {
@@ -424,11 +441,79 @@ static struct virtio_driver virtio_fs_driver = {
 #endif
 };
 
+struct virtio_fs_forget {
+	struct fuse_in_header ih;
+	struct fuse_forget_in arg;
+};
+
 static void virtio_fs_wake_forget_and_unlock(struct fuse_iqueue *fiq)
 __releases(fiq->waitq.lock)
 {
-	/* TODO */
+	struct fuse_forget_link *link;
+	struct virtio_fs_forget *forget;
+	struct fuse_pqueue *fpq;
+	struct scatterlist sg;
+	struct scatterlist *sgs[] = {&sg};
+	struct virtio_fs *fs;
+	struct virtqueue *vq;
+	bool notify;
+	u64 unique;
+	int ret;
+
+	BUG_ON(!fiq->forget_list_head.next);
+	link = fiq->forget_list_head.next;
+	BUG_ON(link->next);
+	fiq->forget_list_head.next = NULL;
+	fiq->forget_list_tail = &fiq->forget_list_head;
+
+	unique = fuse_get_unique(fiq);
+
+	fs = fiq->priv;
+
 	spin_unlock(&fiq->waitq.lock);
+
+	/* Allocate a buffer for the request */
+	forget = kmalloc(sizeof(*forget), GFP_ATOMIC);
+	if (!forget) {
+		pr_err("virtio-fs: dropped FORGET: kmalloc failed\n");
+		goto out; /* TODO avoid dropping it? */
+	}
+
+	forget->ih = (struct fuse_in_header){
+		.opcode = FUSE_FORGET,
+		.nodeid = link->forget_one.nodeid,
+		.unique = unique,
+		.len = sizeof(*forget),
+	};
+	forget->arg = (struct fuse_forget_in){
+		.nlookup = link->forget_one.nlookup,
+	};
+
+	sg_init_one(&sg, forget, sizeof(*forget));
+
+	/* Enqueue the request */
+	vq = fs->vqs[1].vq;
+	dev_dbg(&vq->vdev->dev, "%s\n", __func__);
+	fpq = vq_to_fpq(vq);
+	spin_lock(&fpq->lock);
+
+	ret = virtqueue_add_sgs(vq, sgs, 1, 0, forget, GFP_ATOMIC);
+	if (ret < 0) {
+		pr_err("virtio-fs: dropped FORGET: queue full\n");
+		/* TODO handle full virtqueue */
+		spin_unlock(&fpq->lock);
+		goto out;
+	}
+
+	notify = virtqueue_kick_prepare(vq);
+
+	spin_unlock(&fpq->lock);
+
+	if (notify)
+		virtqueue_notify(vq);
+
+out:
+	kfree(link);
 }
 
 static void virtio_fs_wake_interrupt_and_unlock(struct fuse_iqueue *fiq)
-- 
2.13.6

