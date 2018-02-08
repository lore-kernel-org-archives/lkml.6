Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeBHDVr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 22:21:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750807AbeBHDVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 22:21:46 -0500
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH net V2 1/2] ptr_ring: try vmalloc() when kmalloc() fails
Date: Thu,  8 Feb 2018 11:21:40 +0800
Message-Id: <1518060101-19071-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switch to use kvmalloc_array() for using a vmalloc()
fallback to help in case kmalloc() fails.

Reported-by: syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com
Fixes: 2e0ab8ca83c12 ("ptr_ring: array based FIFO for pointers")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/ptr_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 1883d61..9c3b748 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -466,7 +466,7 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
 
 static inline void **__ptr_ring_init_queue_alloc(unsigned int size, gfp_t gfp)
 {
-	return kcalloc(size, sizeof(void *), gfp);
+	return kvmalloc_array(size, sizeof(void *), gfp | __GFP_ZERO);
 }
 
 static inline void __ptr_ring_set_size(struct ptr_ring *r, int size)
-- 
2.7.4
