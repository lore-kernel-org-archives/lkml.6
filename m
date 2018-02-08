Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeBHDVv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 22:21:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752020AbeBHDVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 22:21:48 -0500
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH net V2 2/2] ptr_ring: fail on large queue size (>64K)
Date: Thu,  8 Feb 2018 11:21:41 +0800
Message-Id: <1518060101-19071-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1518060101-19071-1-git-send-email-jasowang@redhat.com>
References: <1518060101-19071-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need limit the maximum size of queue, otherwise it may cause
several side effects e.g slab will warn when the size exceeds
KMALLOC_MAX_SIZE. Using KMALLOC_MAX_SIZE still looks too so this patch
tries to limit it to 64K. This value could be revisited if we found a
real case that needs more.

Reported-by: syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com
Fixes: 2e0ab8ca83c12 ("ptr_ring: array based FIFO for pointers")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/ptr_ring.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 9c3b748..2520daa 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -44,6 +44,8 @@ struct ptr_ring {
 	void **queue;
 };
 
+#define PTR_RING_MAX_ALLOC 65536
+
 /* Note: callers invoking this in a loop must use a compiler barrier,
  * for example cpu_relax().
  *
@@ -466,6 +468,8 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
 
 static inline void **__ptr_ring_init_queue_alloc(unsigned int size, gfp_t gfp)
 {
+	if (size > PTR_RING_MAX_ALLOC)
+		return NULL;
 	return kvmalloc_array(size, sizeof(void *), gfp | __GFP_ZERO);
 }
 
-- 
2.7.4
