Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbeBIJqA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:46:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752135AbeBIJp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 04:45:57 -0500
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V4 2/2] ptr_ring: try vmalloc() when kmalloc() fails
Date: Fri,  9 Feb 2018 17:45:50 +0800
Message-Id: <1518169550-5987-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1518169550-5987-1-git-send-email-jasowang@redhat.com>
References: <1518169550-5987-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switch to use kvmalloc_array() for using a vmalloc()
fallback to help in case kmalloc() fails.

Reported-by: syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com
Fixes: 2e0ab8ca83c12 ("ptr_ring: array based FIFO for pointers")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/ptr_ring.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 6051a5f..b884b77 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -464,11 +464,14 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
 	__PTR_RING_PEEK_CALL_v; \
 })
 
+/* Not all gfp_t flags (besides GFP_KERNEL) are allowed. See
+ * documentation for vmalloc for which of them are legal.
+ */
 static inline void **__ptr_ring_init_queue_alloc(unsigned int size, gfp_t gfp)
 {
 	if (size * sizeof(void *) > KMALLOC_MAX_SIZE)
 		return NULL;
-	return kcalloc(size, sizeof(void *), gfp);
+	return kvmalloc_array(size, sizeof(void *), gfp | __GFP_ZERO);
 }
 
 static inline void __ptr_ring_set_size(struct ptr_ring *r, int size)
@@ -603,7 +606,7 @@ static inline int ptr_ring_resize(struct ptr_ring *r, int size, gfp_t gfp,
 	spin_unlock(&(r)->producer_lock);
 	spin_unlock_irqrestore(&(r)->consumer_lock, flags);
 
-	kfree(old);
+	kvfree(old);
 
 	return 0;
 }
@@ -643,7 +646,7 @@ static inline int ptr_ring_resize_multiple(struct ptr_ring **rings,
 	}
 
 	for (i = 0; i < nrings; ++i)
-		kfree(queues[i]);
+		kvfree(queues[i]);
 
 	kfree(queues);
 
@@ -651,7 +654,7 @@ static inline int ptr_ring_resize_multiple(struct ptr_ring **rings,
 
 nomem:
 	while (--i >= 0)
-		kfree(queues[i]);
+		kvfree(queues[i]);
 
 	kfree(queues);
 
@@ -666,7 +669,7 @@ static inline void ptr_ring_cleanup(struct ptr_ring *r, void (*destroy)(void *))
 	if (destroy)
 		while ((ptr = ptr_ring_consume(r)))
 			destroy(ptr);
-	kfree(r->queue);
+	kvfree(r->queue);
 }
 
 #endif /* _LINUX_PTR_RING_H  */
-- 
2.7.4
