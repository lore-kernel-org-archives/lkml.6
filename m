Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935338AbeCTAlt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 20:41:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933689AbeCTAlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 20:41:47 -0400
Date: Tue, 20 Mar 2018 02:41:45 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] ptr_ring: fix build
Message-ID: <1521506496-455194-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes after recent use of kvmalloc

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/ringtest/ptr_ring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/virtio/ringtest/ptr_ring.c b/tools/virtio/ringtest/ptr_ring.c
index 477899c..2d566fb 100644
--- a/tools/virtio/ringtest/ptr_ring.c
+++ b/tools/virtio/ringtest/ptr_ring.c
@@ -17,6 +17,8 @@
 #define likely(x)    (__builtin_expect(!!(x), 1))
 #define ALIGN(x, a) (((x) + (a) - 1) / (a) * (a))
 #define SIZE_MAX        (~(size_t)0)
+#define KMALLOC_MAX_SIZE SIZE_MAX
+#define BUG_ON(x) assert(x)
 
 typedef pthread_spinlock_t  spinlock_t;
 
@@ -57,6 +59,9 @@ static void kfree(void *p)
 		free(p);
 }
 
+#define kvmalloc_array kmalloc_array
+#define kvfree kfree
+
 static void spin_lock_init(spinlock_t *lock)
 {
 	int r = pthread_spin_init(lock, 0);
-- 
MST
