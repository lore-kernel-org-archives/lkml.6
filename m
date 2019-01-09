Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B2EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2978121726
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbfAIIF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:05:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729731AbfAIIFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:05:47 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE397C057E00;
        Wed,  9 Jan 2019 08:05:46 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-204.pek2.redhat.com [10.72.12.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B9241A917;
        Wed,  9 Jan 2019 08:05:44 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next V2 3/3] vhost: don't touch avail ring if in_order is negotiated
Date:   Wed,  9 Jan 2019 16:05:30 +0800
Message-Id: <20190109080530.18572-4-jasowang@redhat.com>
In-Reply-To: <20190109080530.18572-1-jasowang@redhat.com>
References: <20190109080530.18572-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 09 Jan 2019 08:05:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device use descriptors table in order, so there's no need to read
index from available ring. This eliminate the cache contention on
available ring completely.

Virito-user + vhost_kernel + XDP_DROP on 2.60GHz Broadwell

            Before /After
SMAP on:  4.8Mpps   5.3Mpps(+10%)
SMAP off: 6.6Mpps   7.0Mpps(+6%)

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 55e5aa662ad5..ab0d05262235 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2012,6 +2012,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 	__virtio16 avail_idx;
 	__virtio16 ring_head;
 	int ret, access;
+	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
 
 	/* Check it isn't doing very strange things with descriptor numbers. */
 	last_avail_idx = vq->last_avail_idx;
@@ -2044,15 +2045,19 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 
 	/* Grab the next descriptor number they're advertising, and increment
 	 * the index we've seen. */
-	if (unlikely(vhost_get_avail(vq, ring_head,
-		     &vq->avail->ring[last_avail_idx & (vq->num - 1)]))) {
-		vq_err(vq, "Failed to read head: idx %d address %p\n",
-		       last_avail_idx,
-		       &vq->avail->ring[last_avail_idx % vq->num]);
-		return -EFAULT;
+	if (!in_order) {
+		if (unlikely(vhost_get_avail(vq, ring_head,
+		    &vq->avail->ring[last_avail_idx & (vq->num - 1)]))) {
+			vq_err(vq, "Failed to read head: idx %d address %p\n",
+				last_avail_idx,
+				&vq->avail->ring[last_avail_idx % vq->num]);
+			return -EFAULT;
+		}
+		head = vhost16_to_cpu(vq, ring_head);
+	} else {
+		head = last_avail_idx & (vq->num - 1);
 	}
 
-	head = vhost16_to_cpu(vq, ring_head);
 
 	/* If their number is silly, that's an error. */
 	if (unlikely(head >= vq->num)) {
-- 
2.17.1

