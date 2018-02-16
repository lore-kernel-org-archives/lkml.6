Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935212AbeBPLGb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:06:31 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55675 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934998AbeBPLG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:06:28 -0500
X-Google-Smtp-Source: AH8x227UjoqL0qqLy04Zo/G4VbgHfBJLdnI7HYZTDzqiCGk/JrySPuea8aXDij3zcu3NXioXpvR3mA==
From: Andrea Parri <parri.andrea@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: [PATCH] ptr_ring: Remove now-redundant smp_read_barrier_depends()
Date: Fri, 16 Feb 2018 12:06:13 +0100
Message-Id: <1518779173-30812-1-git-send-email-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because READ_ONCE() now implies smp_read_barrier_depends(), the
smp_read_barrier_depends() in __ptr_ring_consume() is redundant;
this commit removes it and updates the comments.

Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: <linux-kernel@vger.kernel.org>
Cc: <netdev@vger.kernel.org>
---
 include/linux/ptr_ring.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index b884b7794187e..ddfed1dce9369 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -296,13 +296,14 @@ static inline void *__ptr_ring_consume(struct ptr_ring *r)
 {
 	void *ptr;
 
+	/* The READ_ONCE in __ptr_ring_peek guarantees that anyone
+	 * accessing data through the pointer is up to date. Pairs
+	 * with smp_wmb in __ptr_ring_produce.
+	 */
 	ptr = __ptr_ring_peek(r);
 	if (ptr)
 		__ptr_ring_discard_one(r);
 
-	/* Make sure anyone accessing data through the pointer is up to date. */
-	/* Pairs with smp_wmb in __ptr_ring_produce. */
-	smp_read_barrier_depends();
 	return ptr;
 }
 
-- 
2.7.4
