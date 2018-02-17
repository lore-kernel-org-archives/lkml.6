Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbeBQFwc (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 00:52:32 -0500
Received: from hqdc-proxy-mwg013-o.oracle.com ([148.87.23.16]:34387 "EHLO
        jhdev.us.oracle.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751042AbeBQFwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 00:52:30 -0500
From: Jonathan Helman <jonathan.helman@oracle.com>
To: mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
        Jonathan Helman <jonathan.helman@oracle.com>
Subject: [PATCH] virtio_balloon: export huge page allocation statistics
Date: Fri, 16 Feb 2018 21:44:32 -0800
Message-Id: <1518846272-5216-1-git-send-email-jonathan.helman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export statistics for successful and failed huge page allocations
from the virtio balloon driver. These 2 stats come directly from
the vm_events HTLB_BUDDY_PGALLOC and HTLB_BUDDY_PGALLOC_FAIL.

Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
---
 drivers/virtio/virtio_balloon.c     | 6 ++++++
 include/uapi/linux/virtio_balloon.h | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index dfe5684..6b237e3 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -272,6 +272,12 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 				pages_to_bytes(events[PSWPOUT]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
+#ifdef CONFIG_HUGETLB_PAGE
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
+		    events[HTLB_BUDDY_PGALLOC]);
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGFAIL,
+		    events[HTLB_BUDDY_PGALLOC_FAIL]);
+#endif
 #endif
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMFREE,
 				pages_to_bytes(i.freeram));
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 4e8b830..e3e8071 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -53,7 +53,9 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
 #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc */
 #define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
-#define VIRTIO_BALLOON_S_NR       8
+#define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Number of htlb pgalloc successes */
+#define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Number of htlb pgalloc failures */
+#define VIRTIO_BALLOON_S_NR       10
 
 /*
  * Memory statistics structure.
-- 
1.8.3.1
