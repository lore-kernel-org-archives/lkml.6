Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447BFC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BEE2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BEE2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbeLJRNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:13:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40865 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbeLJRNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:35 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98A7B307D975;
        Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47DE01054FD3;
        Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 44268223C1A; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 16/52] virtio-fs: Add VIRTIO_PCI_CAP_SHARED_MEMORY_CFG and utility to find them
Date:   Mon, 10 Dec 2018 12:12:42 -0500
Message-Id: <20181210171318.16998-17-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The shm cap defines a capability to allow 64bit size chunks at 64 bit
size offsets into a bar.  There can be multiple such chunks on any one
device.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 fs/fuse/virtio_fs.c             | 69 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_pci.h | 10 ++++++
 2 files changed, 79 insertions(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 87b7e42a6763..cd916943205e 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/virtio.h>
 #include <linux/virtio_fs.h>
+#include <uapi/linux/virtio_pci.h>
 #include "fuse_i.h"
 
 enum {
@@ -57,6 +58,74 @@ struct virtio_fs {
 	size_t window_len;
 };
 
+/* TODO: This should be in a PCI file somewhere */
+static int virtio_pci_find_shm_cap(struct pci_dev *dev,
+                                   u8 required_id,
+                                   u8 *bar, u64 *offset, u64 *len)
+{
+	int pos;
+
+        for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
+             pos > 0;
+             pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
+		u8 type, cap_len, id;
+                u32 tmp32;
+                u64 res_offset, res_length;
+
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+                                                         cfg_type),
+                                     &type);
+                if (type != VIRTIO_PCI_CAP_SHARED_MEMORY_CFG)
+                        continue;
+
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+                                                         cap_len),
+                                     &cap_len);
+                if (cap_len != sizeof(struct virtio_pci_shm_cap)) {
+		        printk(KERN_ERR "%s: shm cap with bad size offset: %d size: %d\n",
+                               __func__, pos, cap_len);
+                        continue;
+                };
+
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_shm_cap,
+                                                         id),
+                                     &id);
+                if (id != required_id)
+                        continue;
+
+                /* Type, and ID match, looks good */
+                pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+                                                         bar),
+                                     bar);
+
+                /* Read the lower 32bit of length and offset */
+                pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap, offset),
+                                      &tmp32);
+                res_offset = tmp32;
+                pci_read_config_dword(dev, pos + offsetof(struct virtio_pci_cap, length),
+                                      &tmp32);
+                res_length = tmp32;
+
+                /* and now the top half */
+                pci_read_config_dword(dev,
+                                      pos + offsetof(struct virtio_pci_shm_cap,
+                                                     offset_hi),
+                                      &tmp32);
+                res_offset |= ((u64)tmp32) << 32;
+                pci_read_config_dword(dev,
+                                      pos + offsetof(struct virtio_pci_shm_cap,
+                                                     length_hi),
+                                      &tmp32);
+                res_length |= ((u64)tmp32) << 32;
+
+                *offset = res_offset;
+                *len = res_length;
+
+                return pos;
+        }
+        return 0;
+}
+
 static inline struct virtio_fs_vq *vq_to_fsvq(struct virtqueue *vq)
 {
 	struct virtio_fs *fs = vq->vdev->priv;
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 90007a1abcab..2e6072b5a7c9 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -113,6 +113,8 @@
 #define VIRTIO_PCI_CAP_DEVICE_CFG	4
 /* PCI configuration access */
 #define VIRTIO_PCI_CAP_PCI_CFG		5
+/* Additional shared memory capability */
+#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
 
 /* This is the PCI capability header: */
 struct virtio_pci_cap {
@@ -163,6 +165,14 @@ struct virtio_pci_cfg_cap {
 	__u8 pci_cfg_data[4]; /* Data for BAR access. */
 };
 
+/* Fields in VIRTIO_PCI_CAP_SHARED_MEMORY_CFG */
+struct virtio_pci_shm_cap {
+	struct virtio_pci_cap cap;
+	__le32 offset_hi;             /* Most sig 32 bits of offset */
+	__le32 length_hi;             /* Most sig 32 bits of length */
+        __u8   id;                    /* To distinguish shm chunks */
+};
+
 /* Macro versions of offsets for the Old Timers! */
 #define VIRTIO_PCI_CAP_VNDR		0
 #define VIRTIO_PCI_CAP_NEXT		1
-- 
2.13.6

