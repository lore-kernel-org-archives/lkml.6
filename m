Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeCZDj4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 23:39:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752192AbeCZDjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 23:39:51 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH V2 5/8] vhost: vhost_put_user() can accept metadata type
Date: Mon, 26 Mar 2018 11:38:50 +0800
Message-Id: <1522035533-11786-6-git-send-email-jasowang@redhat.com>
In-Reply-To: <1522035533-11786-1-git-send-email-jasowang@redhat.com>
References: <1522035533-11786-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We assumes used ring update is the only user for vhost_put_user() in
the past. This may not be the case for the incoming packed ring which
may update the descriptor ring for used. So introduce a new type
parameter.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 65954d6..dcac4d4 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -847,7 +847,7 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
 	return __vhost_get_user_slow(vq, addr, size, type);
 }
 
-#define vhost_put_user(vq, x, ptr)		\
+#define vhost_put_user(vq, x, ptr, type)		\
 ({ \
 	int ret = -EFAULT; \
 	if (!vq->iotlb) { \
@@ -855,7 +855,7 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
 	} else { \
 		__typeof__(ptr) to = \
 			(__typeof__(ptr)) __vhost_get_user(vq, ptr,	\
-					  sizeof(*ptr), VHOST_ADDR_USED); \
+					  sizeof(*ptr), type); \
 		if (to != NULL) \
 			ret = __put_user(x, to); \
 		else \
@@ -1716,7 +1716,7 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
 {
 	void __user *used;
 	if (vhost_put_user(vq, cpu_to_vhost16(vq, vq->used_flags),
-			   &vq->used->flags) < 0)
+			   &vq->used->flags, VHOST_ADDR_USED) < 0)
 		return -EFAULT;
 	if (unlikely(vq->log_used)) {
 		/* Make sure the flag is seen before log. */
@@ -1735,7 +1735,7 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
 static int vhost_update_avail_event(struct vhost_virtqueue *vq, u16 avail_event)
 {
 	if (vhost_put_user(vq, cpu_to_vhost16(vq, vq->avail_idx),
-			   vhost_avail_event(vq)))
+			   vhost_avail_event(vq), VHOST_ADDR_USED))
 		return -EFAULT;
 	if (unlikely(vq->log_used)) {
 		void __user *used;
@@ -2218,12 +2218,12 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
 	used = vq->used->ring + start;
 	for (i = 0; i < count; i++) {
 		if (unlikely(vhost_put_user(vq, heads[i].elem.id,
-					    &used[i].id))) {
+					    &used[i].id, VHOST_ADDR_USED))) {
 			vq_err(vq, "Failed to write used id");
 			return -EFAULT;
 		}
 		if (unlikely(vhost_put_user(vq, heads[i].elem.len,
-					    &used[i].len))) {
+					    &used[i].len, VHOST_ADDR_USED))) {
 			vq_err(vq, "Failed to write used len");
 			return -EFAULT;
 		}
@@ -2269,7 +2269,7 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vhost_used_elem *heads,
 	/* Make sure buffer is written before we update index. */
 	smp_wmb();
 	if (vhost_put_user(vq, cpu_to_vhost16(vq, vq->last_used_idx),
-			   &vq->used->idx)) {
+			   &vq->used->idx, VHOST_ADDR_USED)) {
 		vq_err(vq, "Failed to increment used idx");
 		return -EFAULT;
 	}
-- 
2.7.4
