Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236C9C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84682082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84682082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeLJRNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:13:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbeLJRNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07C8E13A9D;
        Mon, 10 Dec 2018 17:13:36 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5C5F605CB;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id B9C1622427A; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 46/52] virtio-fs: Retrieve shm capabilities for version table
Date:   Mon, 10 Dec 2018 12:13:12 -0500
Message-Id: <20181210171318.16998-47-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 10 Dec 2018 17:13:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Retrieve the capabilities needed to find the journal and version table.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 fs/fuse/virtio_fs.c            | 26 ++++++++++++++++++++++++--
 include/uapi/linux/virtio_fs.h |  2 ++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index c71bc47395b4..c18f406b61cd 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -589,8 +589,11 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 	phys_addr_t phys_addr;
 	size_t bar_len;
 	int ret;
-	u8 have_cache, cache_bar;
-	u64 cache_offset, cache_len;
+        u8 have_cache, have_journal, have_vertab;
+        u8 cache_bar, journal_bar, vertab_bar;
+        u64 cache_offset, cache_len;
+        u64 journal_offset, journal_len;
+        u64 vertab_offset, vertab_len;
 
 	if (!IS_ENABLED(CONFIG_DAX_DRIVER))
 		return 0;
@@ -619,6 +622,25 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 				cache_bar, cache_len, cache_offset);
         }
 
+        have_journal = virtio_pci_find_shm_cap(pci_dev,
+                                             VIRTIO_FS_PCI_SHMCAP_ID_JOURNAL,
+                                             &journal_bar, &journal_offset,
+                                             &journal_len);
+        if (have_journal) {
+                dev_notice(&vdev->dev, "Journal bar: %d len: 0x%llx @ 0x%llx\n",
+                           journal_bar, journal_len, journal_offset);
+        }
+
+        have_vertab = virtio_pci_find_shm_cap(pci_dev,
+                                             VIRTIO_FS_PCI_SHMCAP_ID_VERTAB,
+                                             &vertab_bar, &vertab_offset,
+                                             &vertab_len);
+        if (have_vertab) {
+                dev_notice(&vdev->dev, "Version table bar: %d len: 0x%llx @ 0x%llx\n",
+                           vertab_bar, vertab_len, vertab_offset);
+        }
+
+
 	/* TODO handle case where device doesn't expose BAR? */
 	ret = pci_request_region(pci_dev, cache_bar, "virtio-fs-window");
 	if (ret < 0) {
diff --git a/include/uapi/linux/virtio_fs.h b/include/uapi/linux/virtio_fs.h
index 65a9d4a0dac0..e70741ab14a8 100644
--- a/include/uapi/linux/virtio_fs.h
+++ b/include/uapi/linux/virtio_fs.h
@@ -40,5 +40,7 @@ struct virtio_fs_config {
 
 /* For the id field in virtio_pci_shm_cap */
 #define VIRTIO_FS_PCI_SHMCAP_ID_CACHE 0
+#define VIRTIO_FS_PCI_SHMCAP_ID_VERTAB 1
+#define VIRTIO_FS_PCI_SHMCAP_ID_JOURNAL 2
 
 #endif /* _UAPI_LINUX_VIRTIO_FS_H */
-- 
2.13.6

