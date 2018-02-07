Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753471AbeBGIIc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 03:08:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750815AbeBGIIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 03:08:31 -0500
From: Jason Wang <jasowang@redhat.com>
To: linux-kernel@vger.kernel.org, mst@redhat.com
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] ptr_ring: fail early if queue occupies more than KMALLOC_MAX_SIZE
Date: Wed,  7 Feb 2018 16:08:25 +0800
Message-Id: <1517990905-15737-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid slab to warn about exceeded size, fail early if queue
occupies more than KMALLOC_MAX_SIZE.

Reported-by: syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/ptr_ring.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 1883d61..4b862da 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -466,6 +466,8 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
 
 static inline void **__ptr_ring_init_queue_alloc(unsigned int size, gfp_t gfp)
 {
+	if (size > KMALLOC_MAX_SIZE)
+		return NULL;
 	return kcalloc(size, sizeof(void *), gfp);
 }
 
-- 
2.7.4
