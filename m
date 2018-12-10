Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBB2C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FECA2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FECA2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbeLJRUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:20:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:61683 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbeLJRNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 374233091791;
        Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4E0C6012B;
        Mon, 10 Dec 2018 17:13:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3316D223C0F; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 12/52] virtio_fs: Set up dax_device
Date:   Mon, 10 Dec 2018 12:12:38 -0500
Message-Id: <20181210171318.16998-13-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

Setup a dax device.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/virtio_fs.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 225eb729656f..fd914f2c6209 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -5,6 +5,8 @@
  */
 
 #include <linux/fs.h>
+#include <linux/dax.h>
+#include <linux/pfn_t.h>
 #include <linux/module.h>
 #include <linux/virtio.h>
 #include <linux/virtio_fs.h>
@@ -29,6 +31,11 @@ struct virtio_fs {
 	struct virtio_fs_vq *vqs;
 	unsigned nvqs;            /* number of virtqueues */
 	unsigned num_queues;      /* number of request queues */
+	struct dax_device *dax_dev;
+
+	/* DAX memory window where file contents are mapped */
+	void *window_kaddr;
+	phys_addr_t window_phys_addr;
 };
 
 static inline struct virtio_fs_vq *vq_to_fsvq(struct virtqueue *vq)
@@ -350,6 +357,44 @@ static void virtio_fs_cleanup_vqs(struct virtio_device *vdev,
 	vdev->config->del_vqs(vdev);
 }
 
+/* Map a window offset to a page frame number.  The window offset will have
+ * been produced by .iomap_begin(), which maps a file offset to a window
+ * offset.
+ */
+static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
+				    long nr_pages, void **kaddr, pfn_t *pfn)
+{
+	struct virtio_fs *fs = dax_get_private(dax_dev);
+	phys_addr_t offset = PFN_PHYS(pgoff);
+
+	if (kaddr)
+		*kaddr = fs->window_kaddr + offset;
+	if (pfn)
+		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset,
+					PFN_DEV | PFN_MAP);
+	return nr_pages;
+}
+
+static size_t virtio_fs_copy_from_iter(struct dax_device *dax_dev,
+				       pgoff_t pgoff, void *addr,
+				       size_t bytes, struct iov_iter *i)
+{
+	return copy_from_iter(addr, bytes, i);
+}
+
+static size_t virtio_fs_copy_to_iter(struct dax_device *dax_dev,
+				       pgoff_t pgoff, void *addr,
+				       size_t bytes, struct iov_iter *i)
+{
+	return copy_to_iter(addr, bytes, i);
+}
+
+static const struct dax_operations virtio_fs_dax_ops = {
+	.direct_access = virtio_fs_direct_access,
+	.copy_from_iter = virtio_fs_copy_from_iter,
+	.copy_to_iter = virtio_fs_copy_to_iter,
+};
+
 static int virtio_fs_probe(struct virtio_device *vdev)
 {
 	struct virtio_fs *fs;
@@ -371,6 +416,17 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 	/* TODO vq affinity */
 	/* TODO populate notifications vq */
 
+	if (IS_ENABLED(CONFIG_DAX_DRIVER)) {
+		/* TODO map window */
+		fs->window_kaddr = NULL;
+		fs->window_phys_addr = 0;
+
+		fs->dax_dev = alloc_dax(fs, NULL, &virtio_fs_dax_ops);
+		if (!fs->dax_dev)
+			goto out_vqs; /* TODO handle case where device doesn't expose
+					 BAR */
+	}
+
 	/* Bring the device online in case the filesystem is mounted and
 	 * requests need to be sent before we return.
 	 */
@@ -386,6 +442,12 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 	vdev->config->reset(vdev);
 	virtio_fs_cleanup_vqs(vdev, fs);
 
+	if (fs->dax_dev) {
+		kill_dax(fs->dax_dev);
+		put_dax(fs->dax_dev);
+		fs->dax_dev = NULL;
+	}
+
 out:
 	vdev->priv = NULL;
 	return ret;
@@ -404,6 +466,12 @@ static void virtio_fs_remove(struct virtio_device *vdev)
 	list_del(&fs->list);
 	mutex_unlock(&virtio_fs_mutex);
 
+	if (fs->dax_dev) {
+		kill_dax(fs->dax_dev);
+		put_dax(fs->dax_dev);
+		fs->dax_dev = NULL;
+	}
+
 	vdev->priv = NULL;
 }
 
-- 
2.13.6

