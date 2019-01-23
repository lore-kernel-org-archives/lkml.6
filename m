Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEEFC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4702420861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfAWJ4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:56:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbfAWJ4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:56:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46A0980F75;
        Wed, 23 Jan 2019 09:56:20 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFE3F6013C;
        Wed, 23 Jan 2019 09:56:16 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jasowang@redhat.com
Cc:     mst@redhat.com, kvm@vger.kernel.org
Subject: [PATCH net-next V4 4/5] vhost: introduce helpers to get the size of metadata area
Date:   Wed, 23 Jan 2019 17:55:56 +0800
Message-Id: <20190123095557.30168-5-jasowang@redhat.com>
In-Reply-To: <20190123095557.30168-1-jasowang@redhat.com>
References: <20190123095557.30168-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 23 Jan 2019 09:56:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 46 ++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 24c74c60c093..37e2cac8e8b0 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -489,6 +489,27 @@ bool vhost_dev_has_owner(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_has_owner);
 
+static size_t vhost_get_avail_size(struct vhost_virtqueue *vq, int num)
+{
+	size_t event = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
+
+	return sizeof(*vq->avail) +
+	       sizeof(*vq->avail->ring) * num + event;
+}
+
+static size_t vhost_get_used_size(struct vhost_virtqueue *vq, int num)
+{
+	size_t event = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
+
+	return sizeof(*vq->used) +
+	       sizeof(*vq->used->ring) * num + event;
+}
+
+static size_t vhost_get_desc_size(struct vhost_virtqueue *vq, int num)
+{
+	return sizeof(*vq->desc) * num;
+}
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
@@ -1252,13 +1273,9 @@ static bool vq_access_ok(struct vhost_virtqueue *vq, unsigned int num,
 			 struct vring_used __user *used)
 
 {
-	size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
-
-	return access_ok(desc, num * sizeof *desc) &&
-	       access_ok(avail,
-			 sizeof *avail + num * sizeof *avail->ring + s) &&
-	       access_ok(used,
-			sizeof *used + num * sizeof *used->ring + s);
+	return access_ok(desc, vhost_get_desc_size(vq, num)) &&
+	       access_ok(avail, vhost_get_avail_size(vq, num)) &&
+	       access_ok(used, vhost_get_used_size(vq, num));
 }
 
 static void vhost_vq_meta_update(struct vhost_virtqueue *vq,
@@ -1310,22 +1327,18 @@ static bool iotlb_access_ok(struct vhost_virtqueue *vq,
 
 int vq_meta_prefetch(struct vhost_virtqueue *vq)
 {
-	size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
 	unsigned int num = vq->num;
 
 	if (!vq->iotlb)
 		return 1;
 
 	return iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->desc,
-			       num * sizeof(*vq->desc), VHOST_ADDR_DESC) &&
+			       vhost_get_desc_size(vq, num), VHOST_ADDR_DESC) &&
 	       iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->avail,
-			       sizeof *vq->avail +
-			       num * sizeof(*vq->avail->ring) + s,
+			       vhost_get_avail_size(vq, num),
 			       VHOST_ADDR_AVAIL) &&
 	       iotlb_access_ok(vq, VHOST_ACCESS_WO, (u64)(uintptr_t)vq->used,
-			       sizeof *vq->used +
-			       num * sizeof(*vq->used->ring) + s,
-			       VHOST_ADDR_USED);
+			       vhost_get_used_size(vq, num), VHOST_ADDR_USED);
 }
 EXPORT_SYMBOL_GPL(vq_meta_prefetch);
 
@@ -1342,13 +1355,10 @@ EXPORT_SYMBOL_GPL(vhost_log_access_ok);
 static bool vq_log_access_ok(struct vhost_virtqueue *vq,
 			     void __user *log_base)
 {
-	size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
-
 	return vq_memory_access_ok(log_base, vq->umem,
 				   vhost_has_feature(vq, VHOST_F_LOG_ALL)) &&
 		(!vq->log_used || log_access_ok(log_base, vq->log_addr,
-					sizeof *vq->used +
-					vq->num * sizeof *vq->used->ring + s));
+				  vhost_get_used_size(vq, vq->num)));
 }
 
 /* Can we start vq? */
-- 
2.17.1

