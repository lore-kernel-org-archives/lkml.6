Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA1AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D4E20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfBAWQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:16:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfBAWQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:16:03 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C7228E58B;
        Fri,  1 Feb 2019 22:16:03 +0000 (UTC)
Received: from redhat.com (ovpn-122-191.rdu2.redhat.com [10.10.122.191])
        by smtp.corp.redhat.com (Postfix) with SMTP id EBCE619936;
        Fri,  1 Feb 2019 22:16:01 +0000 (UTC)
Date:   Fri, 1 Feb 2019 17:16:01 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tiwei Bie <tiwei.bie@intel.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio: drop internal struct from UAPI
Message-ID: <20190201221553.7210-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 01 Feb 2019 22:16:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason to expose struct vring_packed in UAPI - if we do we
won't be able to change or drop it, and it's not part of any interface.

Let's move it to virtio_ring.c

Cc: Tiwei Bie <tiwei.bie@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c     |  7 ++++++-
 include/uapi/linux/virtio_ring.h | 10 ----------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 412e0c431d87..1c85b3423182 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -152,7 +152,12 @@ struct vring_virtqueue {
 		/* Available for packed ring */
 		struct {
 			/* Actual memory layout for this queue. */
-			struct vring_packed vring;
+			struct {
+				unsigned int num;
+				struct vring_packed_desc *desc;
+				struct vring_packed_desc_event *driver;
+				struct vring_packed_desc_event *device;
+			} vring;
 
 			/* Driver ring wrap counter. */
 			bool avail_wrap_counter;
diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 2414f8af26b3..4c4e24c291a5 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -213,14 +213,4 @@ struct vring_packed_desc {
 	__le16 flags;
 };
 
-struct vring_packed {
-	unsigned int num;
-
-	struct vring_packed_desc *desc;
-
-	struct vring_packed_desc_event *driver;
-
-	struct vring_packed_desc_event *device;
-};
-
 #endif /* _UAPI_LINUX_VIRTIO_RING_H */
-- 
MST
