Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B18C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930122082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930122082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbeLJRR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:17:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbeLJRNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AC18307D96D;
        Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5790E600D6;
        Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4BC33223C23; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 18/52] virtio-fs: Map cache using the values from the capabilities
Date:   Mon, 10 Dec 2018 12:12:44 -0500
Message-Id: <20181210171318.16998-19-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of assuming we had the fixed bar for the cache, use the
value from the capabilities.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 fs/fuse/virtio_fs.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 60d496c16841..55bac1465536 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -14,11 +14,6 @@
 #include <uapi/linux/virtio_pci.h>
 #include "fuse_i.h"
 
-enum {
-	/* PCI BAR number of the virtio-fs DAX window */
-	VIRTIO_FS_WINDOW_BAR = 2,
-};
-
 /* List of virtio-fs device instances and a lock for the list */
 static DEFINE_MUTEX(virtio_fs_mutex);
 static LIST_HEAD(virtio_fs_instances);
@@ -518,7 +513,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 	struct dev_pagemap *pgmap;
 	struct pci_dev *pci_dev;
 	phys_addr_t phys_addr;
-	size_t len;
+	size_t bar_len;
 	int ret;
 	u8 have_cache, cache_bar;
 	u64 cache_offset, cache_len;
@@ -551,17 +546,13 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
         }
 
 	/* TODO handle case where device doesn't expose BAR? */
-	ret = pci_request_region(pci_dev, VIRTIO_FS_WINDOW_BAR,
-				 "virtio-fs-window");
+	ret = pci_request_region(pci_dev, cache_bar, "virtio-fs-window");
 	if (ret < 0) {
 		dev_err(&vdev->dev, "%s: failed to request window BAR\n",
 			__func__);
 		return ret;
 	}
 
-	phys_addr = pci_resource_start(pci_dev, VIRTIO_FS_WINDOW_BAR);
-	len = pci_resource_len(pci_dev, VIRTIO_FS_WINDOW_BAR);
-
 	mi = devm_kzalloc(&pci_dev->dev, sizeof(*mi), GFP_KERNEL);
 	if (!mi)
 		return -ENOMEM;
@@ -586,6 +577,17 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 	pgmap->ref = &mi->ref;
 	pgmap->type = MEMORY_DEVICE_FS_DAX;
 
+	phys_addr = pci_resource_start(pci_dev, cache_bar);
+	bar_len = pci_resource_len(pci_dev, cache_bar);
+
+	if (cache_offset + cache_len > bar_len) {
+		dev_err(&vdev->dev,
+			"%s: cache bar shorter than cap offset+len\n",
+			__func__);
+		return -EINVAL;
+	}
+	phys_addr += cache_offset;
+
 	/* Ideally we would directly use the PCI BAR resource but
 	 * devm_memremap_pages() wants its own copy in pgmap.  So
 	 * initialize a struct resource from scratch (only the start
@@ -594,7 +596,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 	pgmap->res = (struct resource){
 		.name = "virtio-fs dax window",
 		.start = phys_addr,
-		.end = phys_addr + len,
+		.end = phys_addr + cache_len,
 	};
 
 	fs->window_kaddr = devm_memremap_pages(&pci_dev->dev, pgmap);
@@ -607,10 +609,10 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 		return ret;
 
 	fs->window_phys_addr = phys_addr;
-	fs->window_len = len;
+	fs->window_len = cache_len;
 
-	dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx len %zu\n",
-		__func__, fs->window_kaddr, phys_addr, len);
+	dev_dbg(&vdev->dev, "%s: cache kaddr 0x%px phys_addr 0x%llx len %llx\n",
+		__func__, fs->window_kaddr, phys_addr, cache_len);
 
 	fs->dax_dev = alloc_dax(fs, NULL, &virtio_fs_dax_ops);
 	if (!fs->dax_dev)
-- 
2.13.6

