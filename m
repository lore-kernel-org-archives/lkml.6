Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754179AbeDWFhM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 01:37:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751516AbeDWFfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 01:35:32 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        tiwei.bie@intel.com, jfreimann@redhat.com, wexu@redhat.com
Subject: [RFC V3 PATCH 5/8] vhost: vhost_put_user() can accept metadata type
Date: Mon, 23 Apr 2018 13:34:57 +0800
Message-Id: <1524461700-5469-6-git-send-email-jasowang@redhat.com>
In-Reply-To: <1524461700-5469-1-git-send-email-jasowang@redhat.com>
References: <1524461700-5469-1-git-send-email-jasowang@redhat.com>
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
index 5cc1cdb..82a7b73 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -846,7 +846,7 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
 	return __vhost_get_user_slow(vq, addr, size, type);
 }
 
-#define vhost_put_user(vq, x, ptr)		\
+#define vhost_put_user(vq, x, ptr, type)		\
 ({ \
 	int ret = -EFAULT; \
 	if (!vq->iotlb) { \
@@ -854,7 +854,7 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
 	} else { \
 		__typeof__(ptr) to = \
 			(__typeof__(ptr)) __vhost_get_user(vq, ptr,	\
-					  sizeof(*ptr), VHOST_ADDR_USED); \
+					  sizeof(*ptr), type); \
 		if (to != NULL) \
 			ret = __put_user(x, to); \
 		else \
@@ -1715,7 +1715,7 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
 {
 	void __user *used;
 	if (vhost_put_user(vq, cpu_to_vhost16(vq, vq->used_flags),
-			   &vq->used->flags) < 0)
+			   &vq->used->flags, VHOST_ADDR_USED) < 0)
 		return -EFAULT;
 	if (unlikely(vq->log_used)) {
 		/* Make sure the flag is seen before log. */
@@ -1734,7 +1734,7 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
 static int vhost_update_avail_event(struct vhost_virtqueue *vq, u16 avail_event)
 {
 	if (vhost_put_user(vq, cpu_to_vhost16(vq, vq->avail_idx),
-			   vhost_avail_event(vq)))
+			   vhost_avail_event(vq), VHOST_ADDR_USED))
 		return -EFAULT;
 	if (unlikely(vq->log_used)) {
 		void __user *used;
@@ -2217,12 +2217,12 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
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
@@ -2268,7 +2268,7 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vhost_used_elem *heads,
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
