Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FCEC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2684C217F4
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbeL2Mr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 07:47:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727934AbeL2MrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 07:47:23 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0878AC057F38;
        Sat, 29 Dec 2018 12:47:23 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-130.pek2.redhat.com [10.72.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB7C51001F5E;
        Sat, 29 Dec 2018 12:47:17 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net
Subject: [RFC PATCH V3 3/5] vhost: rename vq_iotlb_prefetch() to vq_meta_prefetch()
Date:   Sat, 29 Dec 2018 20:46:54 +0800
Message-Id: <20181229124656.3900-4-jasowang@redhat.com>
In-Reply-To: <20181229124656.3900-1-jasowang@redhat.com>
References: <20181229124656.3900-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sat, 29 Dec 2018 12:47:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the function to be more accurate since it actually tries to
prefetch vq metadata address in IOTLB. And this will be used by
following patch to prefetch metadata virtual addresses.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c   | 4 ++--
 drivers/vhost/vhost.c | 4 ++--
 drivers/vhost/vhost.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 36f3d0f49e60..0b4b3deab5aa 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -971,7 +971,7 @@ static void handle_tx(struct vhost_net *net)
 	if (!sock)
 		goto out;
 
-	if (!vq_iotlb_prefetch(vq))
+	if (!vq_meta_prefetch(vq))
 		goto out;
 
 	vhost_disable_notify(&net->dev, vq);
@@ -1140,7 +1140,7 @@ static void handle_rx(struct vhost_net *net)
 	if (!sock)
 		goto out;
 
-	if (!vq_iotlb_prefetch(vq))
+	if (!vq_meta_prefetch(vq))
 		goto out;
 
 	vhost_disable_notify(&net->dev, vq);
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 337ce6f5a098..27b5c03feaac 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1304,7 +1304,7 @@ static bool iotlb_access_ok(struct vhost_virtqueue *vq,
 	return true;
 }
 
-int vq_iotlb_prefetch(struct vhost_virtqueue *vq)
+int vq_meta_prefetch(struct vhost_virtqueue *vq)
 {
 	size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
 	unsigned int num = vq->num;
@@ -1323,7 +1323,7 @@ int vq_iotlb_prefetch(struct vhost_virtqueue *vq)
 			       num * sizeof(*vq->used->ring) + s,
 			       VHOST_ADDR_USED);
 }
-EXPORT_SYMBOL_GPL(vq_iotlb_prefetch);
+EXPORT_SYMBOL_GPL(vq_meta_prefetch);
 
 /* Can we log writes? */
 /* Caller should have device mutex but not vq mutex */
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 466ef7542291..0d1ff977a43e 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -206,7 +206,7 @@ bool vhost_enable_notify(struct vhost_dev *, struct vhost_virtqueue *);
 
 int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
 		    unsigned int log_num, u64 len);
-int vq_iotlb_prefetch(struct vhost_virtqueue *vq);
+int vq_meta_prefetch(struct vhost_virtqueue *vq);
 
 struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type);
 void vhost_enqueue_msg(struct vhost_dev *dev,
-- 
2.17.1

