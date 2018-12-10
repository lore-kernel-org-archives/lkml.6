Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE84DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E4E2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E4E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeLJRSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:18:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728367AbeLJRNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:35 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 892D830043EC;
        Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4972B1057041;
        Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 40AE0223C18; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 15/52] fuse: map virtio_fs DAX window BAR
Date:   Mon, 10 Dec 2018 12:12:41 -0500
Message-Id: <20181210171318.16998-16-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

Experimental QEMU code introduces an MMIO BAR for mapping portions of
files in the virtio-fs device.  Map this BAR so that FUSE DAX can access
file contents from the host page cache.

The DAX window is accessed by the fs/dax.c infrastructure and must have
struct pages (at least on x86).  Use devm_memremap_pages() to map the
DAX window PCI BAR and allocate struct page.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/virtio_fs.c | 166 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 143 insertions(+), 23 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index ba615ec2603e..87b7e42a6763 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -6,12 +6,18 @@
 
 #include <linux/fs.h>
 #include <linux/dax.h>
+#include <linux/pci.h>
 #include <linux/pfn_t.h>
 #include <linux/module.h>
 #include <linux/virtio.h>
 #include <linux/virtio_fs.h>
 #include "fuse_i.h"
 
+enum {
+	/* PCI BAR number of the virtio-fs DAX window */
+	VIRTIO_FS_WINDOW_BAR = 2,
+};
+
 /* List of virtio-fs device instances and a lock for the list */
 static DEFINE_MUTEX(virtio_fs_mutex);
 static LIST_HEAD(virtio_fs_instances);
@@ -24,6 +30,18 @@ struct virtio_fs_vq {
 	char name[24];
 } ____cacheline_aligned_in_smp;
 
+/* State needed for devm_memremap_pages().  This API is called on the
+ * underlying pci_dev instead of struct virtio_fs (layering violation).  Since
+ * the memremap release function only gets called when the pci_dev is released,
+ * keep the associated state separate from struct virtio_fs (it has a different
+ * lifecycle from pci_dev).
+ */
+struct virtio_fs_memremap_info {
+	struct dev_pagemap pgmap;
+	struct percpu_ref ref;
+	struct completion completion;
+};
+
 /* A virtio-fs device instance */
 struct virtio_fs {
 	struct list_head list;    /* on virtio_fs_instances */
@@ -36,6 +54,7 @@ struct virtio_fs {
 	/* DAX memory window where file contents are mapped */
 	void *window_kaddr;
 	phys_addr_t window_phys_addr;
+	size_t window_len;
 };
 
 static inline struct virtio_fs_vq *vq_to_fsvq(struct virtqueue *vq)
@@ -395,6 +414,127 @@ static const struct dax_operations virtio_fs_dax_ops = {
 	.copy_to_iter = virtio_fs_copy_to_iter,
 };
 
+static void virtio_fs_percpu_release(struct percpu_ref *ref)
+{
+	struct virtio_fs_memremap_info *mi =
+		container_of(ref, struct virtio_fs_memremap_info, ref);
+
+	complete(&mi->completion);
+}
+
+static void virtio_fs_percpu_exit(void *data)
+{
+	struct virtio_fs_memremap_info *mi = data;
+
+	wait_for_completion(&mi->completion);
+	percpu_ref_exit(&mi->ref);
+}
+
+static void virtio_fs_percpu_kill(void *data)
+{
+	percpu_ref_kill(data);
+}
+
+static void virtio_fs_cleanup_dax(void *data)
+{
+	struct virtio_fs *fs = data;
+
+	kill_dax(fs->dax_dev);
+	put_dax(fs->dax_dev);
+}
+
+static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
+{
+	struct virtio_fs_memremap_info *mi;
+	struct dev_pagemap *pgmap;
+	struct pci_dev *pci_dev;
+	phys_addr_t phys_addr;
+	size_t len;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_DAX_DRIVER))
+		return 0;
+
+	/* HACK implement VIRTIO shared memory regions instead of
+	 * directly accessing the PCI BAR from a virtio device driver.
+	 */
+	pci_dev = container_of(vdev->dev.parent, struct pci_dev, dev);
+
+	/* TODO Is this safe - the virtio_pci_* driver doesn't use managed
+	 * device APIs? */
+	ret = pcim_enable_device(pci_dev);
+	if (ret < 0)
+		return ret;
+
+	/* TODO handle case where device doesn't expose BAR? */
+	ret = pci_request_region(pci_dev, VIRTIO_FS_WINDOW_BAR,
+				 "virtio-fs-window");
+	if (ret < 0) {
+		dev_err(&vdev->dev, "%s: failed to request window BAR\n",
+			__func__);
+		return ret;
+	}
+
+	phys_addr = pci_resource_start(pci_dev, VIRTIO_FS_WINDOW_BAR);
+	len = pci_resource_len(pci_dev, VIRTIO_FS_WINDOW_BAR);
+
+	mi = devm_kzalloc(&pci_dev->dev, sizeof(*mi), GFP_KERNEL);
+	if (!mi)
+		return -ENOMEM;
+
+	init_completion(&mi->completion);
+	ret = percpu_ref_init(&mi->ref, virtio_fs_percpu_release, 0,
+			      GFP_KERNEL);
+	if (ret < 0) {
+		dev_err(&vdev->dev, "%s: percpu_ref_init failed (%d)\n",
+			__func__, ret);
+		return ret;
+	}
+
+	ret = devm_add_action(&pci_dev->dev, virtio_fs_percpu_exit, mi);
+	if (ret < 0) {
+		percpu_ref_exit(&mi->ref);
+		return ret;
+	}
+
+	pgmap = &mi->pgmap;
+	pgmap->altmap_valid = false;
+	pgmap->ref = &mi->ref;
+	pgmap->type = MEMORY_DEVICE_FS_DAX;
+
+	/* Ideally we would directly use the PCI BAR resource but
+	 * devm_memremap_pages() wants its own copy in pgmap.  So
+	 * initialize a struct resource from scratch (only the start
+	 * and end fields will be used).
+	 */
+	pgmap->res = (struct resource){
+		.name = "virtio-fs dax window",
+		.start = phys_addr,
+		.end = phys_addr + len,
+	};
+
+	fs->window_kaddr = devm_memremap_pages(&pci_dev->dev, pgmap);
+	if (IS_ERR(fs->window_kaddr))
+		return PTR_ERR(fs->window_kaddr);
+
+	ret = devm_add_action_or_reset(&pci_dev->dev, virtio_fs_percpu_kill,
+				       &mi->ref);
+	if (ret < 0)
+		return ret;
+
+	fs->window_phys_addr = phys_addr;
+	fs->window_len = len;
+
+	dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx len %zu\n",
+		__func__, fs->window_kaddr, phys_addr, len);
+
+	fs->dax_dev = alloc_dax(fs, NULL, &virtio_fs_dax_ops);
+	if (!fs->dax_dev)
+		return -ENOMEM;
+
+	return devm_add_action_or_reset(&vdev->dev, virtio_fs_cleanup_dax, fs);
+}
+
 static int virtio_fs_probe(struct virtio_device *vdev)
 {
 	struct virtio_fs *fs;
@@ -416,16 +556,9 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 	/* TODO vq affinity */
 	/* TODO populate notifications vq */
 
-	if (IS_ENABLED(CONFIG_DAX_DRIVER)) {
-		/* TODO map window */
-		fs->window_kaddr = NULL;
-		fs->window_phys_addr = 0;
-
-		fs->dax_dev = alloc_dax(fs, NULL, &virtio_fs_dax_ops);
-		if (!fs->dax_dev)
-			goto out_vqs; /* TODO handle case where device doesn't expose
-					 BAR */
-	}
+	ret = virtio_fs_setup_dax(vdev, fs);
+	if (ret < 0)
+		goto out_vqs;
 
 	/* Bring the device online in case the filesystem is mounted and
 	 * requests need to be sent before we return.
@@ -441,13 +574,6 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 out_vqs:
 	vdev->config->reset(vdev);
 	virtio_fs_cleanup_vqs(vdev, fs);
-
-	if (fs->dax_dev) {
-		kill_dax(fs->dax_dev);
-		put_dax(fs->dax_dev);
-		fs->dax_dev = NULL;
-	}
-
 out:
 	vdev->priv = NULL;
 	return ret;
@@ -466,12 +592,6 @@ static void virtio_fs_remove(struct virtio_device *vdev)
 	list_del(&fs->list);
 	mutex_unlock(&virtio_fs_mutex);
 
-	if (fs->dax_dev) {
-		kill_dax(fs->dax_dev);
-		put_dax(fs->dax_dev);
-		fs->dax_dev = NULL;
-	}
-
 	vdev->priv = NULL;
 }
 
-- 
2.13.6

