Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E30AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5BA2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5BA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbeLJRQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:16:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728417AbeLJRNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AE8B308213A;
        Mon, 10 Dec 2018 17:13:36 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C0375D75F;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C0F2222427B; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 47/52] virtio-fs: Map using the values from the capabilities
Date:   Mon, 10 Dec 2018 12:13:13 -0500
Message-Id: <20181210171318.16998-48-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 10 Dec 2018 17:13:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Instead of assuming we had the fixed bar for the cache, use the
value from the capabilities.
Use the other capabilities to map their memory.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 fs/fuse/virtio_fs.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index c18f406b61cd..7d5b23455639 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -53,6 +53,16 @@ struct virtio_fs {
 	void *window_kaddr;
 	phys_addr_t window_phys_addr;
 	size_t window_len;
+
+        /* Version table where version numbers can be read */
+	void *vertab_kaddr;
+	phys_addr_t vertab_phys_addr;
+	size_t vertab_len;
+
+        /* Journal */
+	void *journal_kaddr;
+	phys_addr_t journal_phys_addr;
+	size_t journal_len;
 };
 
 struct virtio_fs_forget {
@@ -684,6 +694,17 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 	}
 	phys_addr += cache_offset;
 
+	phys_addr = pci_resource_start(pci_dev, cache_bar);
+	bar_len = pci_resource_len(pci_dev, cache_bar);
+
+        if (cache_offset + cache_len > bar_len) {
+                dev_err(&vdev->dev,
+                        "%s: cache bar shorter than cap offset+len\n",
+                        __func__);
+                return -EINVAL;
+        }
+        phys_addr += cache_offset;
+
 	/* Ideally we would directly use the PCI BAR resource but
 	 * devm_memremap_pages() wants its own copy in pgmap.  So
 	 * initialize a struct resource from scratch (only the start
@@ -710,6 +731,80 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 	dev_dbg(&vdev->dev, "%s: cache kaddr 0x%px phys_addr 0x%llx len %llx\n",
 		__func__, fs->window_kaddr, phys_addr, cache_len);
 
+	/*
+	 * The journal and version table should be easier since DAX doesn't
+	 * need them
+	 */
+	if (have_journal) {
+		if (journal_bar != cache_bar) {
+			ret = pci_request_region(pci_dev, journal_bar,
+						 "virtio-fs-journal");
+			if (ret < 0) {
+				dev_err(&vdev->dev,
+					"%s: failed to request journal BAR\n",
+					__func__);
+				return ret;
+			}
+		}
+
+		phys_addr = pci_resource_start(pci_dev, journal_bar);
+		bar_len = pci_resource_len(pci_dev, journal_bar);
+
+		if (journal_offset + journal_len > bar_len) {
+			dev_err(&vdev->dev,
+				"%s: journal bar shorter than cap offset+len\n",
+				__func__);
+			return -EINVAL;
+		}
+		fs->journal_phys_addr = phys_addr + journal_offset;
+		fs->journal_len = journal_len;
+
+		fs->journal_kaddr = devm_memremap(&pci_dev->dev,
+						  fs->journal_phys_addr,
+						  journal_len, MEMREMAP_WB);
+		if (!fs->journal_kaddr) {
+			dev_err(&vdev->dev, "%s: failed to remap journal\n",
+				__func__);
+			return -ENOMEM;
+		}
+		dev_notice(&vdev->dev, "%s: journal at %px\n", __func__,
+			   fs->journal_kaddr);
+	}
+
+	if (have_vertab) {
+		if (vertab_bar != cache_bar &&
+		    vertab_bar != journal_bar) {
+			ret = pci_request_region(pci_dev, vertab_bar,
+						 "virtio-fs-vertab");
+			if (ret < 0) {
+				dev_err(&vdev->dev, "%s: failed to request"
+					" vertab BAR\n", __func__);
+				return ret;
+			}
+		}
+
+		phys_addr = pci_resource_start(pci_dev, vertab_bar);
+		bar_len = pci_resource_len(pci_dev, vertab_bar);
+
+		if (vertab_offset + vertab_len > bar_len) {
+			dev_err(&vdev->dev, "%s: version tab bar shorter than"
+				" cap offset+len\n", __func__);
+			return -EINVAL;
+		}
+		fs->vertab_phys_addr = phys_addr + vertab_offset;
+		fs->vertab_len = vertab_len;
+		fs->vertab_kaddr = devm_memremap(&pci_dev->dev,
+						 fs->vertab_phys_addr,
+						 vertab_len, MEMREMAP_WB);
+		if (!fs->vertab_kaddr) {
+			dev_err(&vdev->dev, "%s: failed to remap version"
+				" table\n", __func__);
+			return -ENOMEM;
+		}
+		dev_notice(&vdev->dev, "%s: version table at %px\n",
+				__func__, fs->vertab_kaddr);
+	}
+
 	fs->dax_dev = alloc_dax(fs, NULL, &virtio_fs_dax_ops);
 	if (!fs->dax_dev)
 		return -ENOMEM;
-- 
2.13.6

