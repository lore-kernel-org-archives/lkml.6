Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9545FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A39205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeL1H4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 02:56:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731819AbeL1Hzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 02:55:54 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 55F96C05D40E;
        Fri, 28 Dec 2018 07:55:53 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-196.pek2.redhat.com [10.72.12.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E1C95D9CC;
        Fri, 28 Dec 2018 07:55:48 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V2 2/3] vhost: fine grain userspace memory accessors
Date:   Fri, 28 Dec 2018 15:55:36 +0800
Message-Id: <20181228075537.21402-3-jasowang@redhat.com>
In-Reply-To: <20181228075537.21402-1-jasowang@redhat.com>
References: <20181228075537.21402-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 28 Dec 2018 07:55:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used to hide the metadata address from virtqueue helpers. This
will allow to implement a vmap based fast accessing to metadata.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 94 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 77 insertions(+), 17 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index f179b5ee14c4..337ce6f5a098 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -868,6 +868,34 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
 	ret; \
 })
 
+static inline int vhost_put_avail_event(struct vhost_virtqueue *vq)
+{
+	return vhost_put_user(vq, cpu_to_vhost16(vq, vq->avail_idx),
+			      vhost_avail_event(vq));
+}
+
+static inline int vhost_put_used(struct vhost_virtqueue *vq,
+				 struct vring_used_elem *head, int idx,
+				 int count)
+{
+	return vhost_copy_to_user(vq, vq->used->ring + idx, head,
+				  count * sizeof(*head));
+}
+
+static inline int vhost_put_used_flags(struct vhost_virtqueue *vq)
+
+{
+	return vhost_put_user(vq, cpu_to_vhost16(vq, vq->used_flags),
+			      &vq->used->flags);
+}
+
+static inline int vhost_put_used_idx(struct vhost_virtqueue *vq)
+
+{
+	return vhost_put_user(vq, cpu_to_vhost16(vq, vq->last_used_idx),
+			      &vq->used->idx);
+}
+
 #define vhost_get_user(vq, x, ptr, type)		\
 ({ \
 	int ret; \
@@ -906,6 +934,43 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
 		mutex_unlock(&d->vqs[i]->mutex);
 }
 
+static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq,
+				      __virtio16 *idx)
+{
+	return vhost_get_avail(vq, *idx, &vq->avail->idx);
+}
+
+static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
+				       __virtio16 *head, int idx)
+{
+	return vhost_get_avail(vq, *head,
+			       &vq->avail->ring[idx & (vq->num - 1)]);
+}
+
+static inline int vhost_get_avail_flags(struct vhost_virtqueue *vq,
+					__virtio16 *flags)
+{
+	return vhost_get_avail(vq, *flags, &vq->avail->flags);
+}
+
+static inline int vhost_get_used_event(struct vhost_virtqueue *vq,
+				       __virtio16 *event)
+{
+	return vhost_get_avail(vq, *event, vhost_used_event(vq));
+}
+
+static inline int vhost_get_used_idx(struct vhost_virtqueue *vq,
+				     __virtio16 *idx)
+{
+	return vhost_get_used(vq, *idx, &vq->used->idx);
+}
+
+static inline int vhost_get_desc(struct vhost_virtqueue *vq,
+				 struct vring_desc *desc, int idx)
+{
+	return vhost_copy_from_user(vq, desc, vq->desc + idx, sizeof(*desc));
+}
+
 static int vhost_new_umem_range(struct vhost_umem *umem,
 				u64 start, u64 size, u64 end,
 				u64 userspace_addr, int perm)
@@ -1761,8 +1826,7 @@ EXPORT_SYMBOL_GPL(vhost_log_write);
 static int vhost_update_used_flags(struct vhost_virtqueue *vq)
 {
 	void __user *used;
-	if (vhost_put_user(vq, cpu_to_vhost16(vq, vq->used_flags),
-			   &vq->used->flags) < 0)
+	if (vhost_put_used_flags(vq))
 		return -EFAULT;
 	if (unlikely(vq->log_used)) {
 		/* Make sure the flag is seen before log. */
@@ -1780,8 +1844,7 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
 
 static int vhost_update_avail_event(struct vhost_virtqueue *vq, u16 avail_event)
 {
-	if (vhost_put_user(vq, cpu_to_vhost16(vq, vq->avail_idx),
-			   vhost_avail_event(vq)))
+	if (vhost_put_avail_event(vq))
 		return -EFAULT;
 	if (unlikely(vq->log_used)) {
 		void __user *used;
@@ -1818,7 +1881,7 @@ int vhost_vq_init_access(struct vhost_virtqueue *vq)
 		r = -EFAULT;
 		goto err;
 	}
-	r = vhost_get_used(vq, last_used_idx, &vq->used->idx);
+	r = vhost_get_used_idx(vq, &last_used_idx);
 	if (r) {
 		vq_err(vq, "Can't access used idx at %p\n",
 		       &vq->used->idx);
@@ -2017,7 +2080,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 	last_avail_idx = vq->last_avail_idx;
 
 	if (vq->avail_idx == vq->last_avail_idx) {
-		if (unlikely(vhost_get_avail(vq, avail_idx, &vq->avail->idx))) {
+		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
 			vq_err(vq, "Failed to access avail idx at %p\n",
 				&vq->avail->idx);
 			return -EFAULT;
@@ -2044,8 +2107,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 
 	/* Grab the next descriptor number they're advertising, and increment
 	 * the index we've seen. */
-	if (unlikely(vhost_get_avail(vq, ring_head,
-		     &vq->avail->ring[last_avail_idx & (vq->num - 1)]))) {
+	if (unlikely(vhost_get_avail_head(vq, &ring_head, last_avail_idx))) {
 		vq_err(vq, "Failed to read head: idx %d address %p\n",
 		       last_avail_idx,
 		       &vq->avail->ring[last_avail_idx % vq->num]);
@@ -2080,8 +2142,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 			       i, vq->num, head);
 			return -EINVAL;
 		}
-		ret = vhost_copy_from_user(vq, &desc, vq->desc + i,
-					   sizeof desc);
+		ret = vhost_get_desc(vq, &desc, i);
 		if (unlikely(ret)) {
 			vq_err(vq, "Failed to get descriptor: idx %d addr %p\n",
 			       i, vq->desc + i);
@@ -2174,7 +2235,7 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
 
 	start = vq->last_used_idx & (vq->num - 1);
 	used = vq->used->ring + start;
-	if (vhost_copy_to_user(vq, used, heads, count * sizeof *used)) {
+	if (vhost_put_used(vq, heads, start, count)) {
 		vq_err(vq, "Failed to write used");
 		return -EFAULT;
 	}
@@ -2218,8 +2279,7 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
 
 	/* Make sure buffer is written before we update index. */
 	smp_wmb();
-	if (vhost_put_user(vq, cpu_to_vhost16(vq, vq->last_used_idx),
-			   &vq->used->idx)) {
+	if (vhost_put_used_idx(vq)) {
 		vq_err(vq, "Failed to increment used idx");
 		return -EFAULT;
 	}
@@ -2253,7 +2313,7 @@ static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 
 	if (!vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX)) {
 		__virtio16 flags;
-		if (vhost_get_avail(vq, flags, &vq->avail->flags)) {
+		if (vhost_get_avail_flags(vq, &flags)) {
 			vq_err(vq, "Failed to get flags");
 			return true;
 		}
@@ -2267,7 +2327,7 @@ static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 	if (unlikely(!v))
 		return true;
 
-	if (vhost_get_avail(vq, event, vhost_used_event(vq))) {
+	if (vhost_get_used_event(vq, &event)) {
 		vq_err(vq, "Failed to get used event idx");
 		return true;
 	}
@@ -2312,7 +2372,7 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 	if (vq->avail_idx != vq->last_avail_idx)
 		return false;
 
-	r = vhost_get_avail(vq, avail_idx, &vq->avail->idx);
+	r = vhost_get_avail_idx(vq, &avail_idx);
 	if (unlikely(r))
 		return false;
 	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
@@ -2348,7 +2408,7 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 	/* They could have slipped one in as we were doing that: make
 	 * sure it's written, then check again. */
 	smp_mb();
-	r = vhost_get_avail(vq, avail_idx, &vq->avail->idx);
+	r = vhost_get_avail_idx(vq, &avail_idx);
 	if (r) {
 		vq_err(vq, "Failed to check avail idx at %p: %d\n",
 		       &vq->avail->idx, r);
-- 
2.17.1

