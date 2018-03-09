Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeCIGu6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 01:50:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751572AbeCIGuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 01:50:55 -0500
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: glider@google.com, dvyukov@google.com
Subject: [PATCH net 3/3] vhost_net: examine pointer types during un-producing
Date: Fri,  9 Mar 2018 14:50:34 +0800
Message-Id: <1520578234-5565-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1520578234-5565-1-git-send-email-jasowang@redhat.com>
References: <1520578234-5565-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit fc72d1d54dd9 ("tuntap: XDP transmission"), we can
actually queueing XDP pointers in the pointer ring, so we should
examine the pointer type before freeing the pointer.

Fixes: fc72d1d54dd9 ("tuntap: XDP transmission")
Reported-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c      | 3 ++-
 drivers/vhost/net.c    | 2 +-
 include/linux/if_tun.h | 4 ++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 7433bb2..28cfa64 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -655,7 +655,7 @@ static struct tun_struct *tun_enable_queue(struct tun_file *tfile)
 	return tun;
 }
 
-static void tun_ptr_free(void *ptr)
+void tun_ptr_free(void *ptr)
 {
 	if (!ptr)
 		return;
@@ -667,6 +667,7 @@ static void tun_ptr_free(void *ptr)
 		__skb_array_destroy_skb(ptr);
 	}
 }
+EXPORT_SYMBOL_GPL(tun_ptr_free);
 
 static void tun_queue_purge(struct tun_file *tfile)
 {
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index efb9306..8139bc7 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -170,7 +170,7 @@ static void vhost_net_buf_unproduce(struct vhost_net_virtqueue *nvq)
 	if (nvq->rx_ring && !vhost_net_buf_is_empty(rxq)) {
 		ptr_ring_unconsume(nvq->rx_ring, rxq->queue + rxq->head,
 				   vhost_net_buf_get_size(rxq),
-				   __skb_array_destroy_skb);
+				   tun_ptr_free);
 		rxq->head = rxq->tail = 0;
 	}
 }
diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
index c5b0a75..fd00170 100644
--- a/include/linux/if_tun.h
+++ b/include/linux/if_tun.h
@@ -25,6 +25,7 @@ struct ptr_ring *tun_get_tx_ring(struct file *file);
 bool tun_is_xdp_buff(void *ptr);
 void *tun_xdp_to_ptr(void *ptr);
 void *tun_ptr_to_xdp(void *ptr);
+void tun_ptr_free(void *ptr);
 #else
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -50,5 +51,8 @@ static inline void *tun_ptr_to_xdp(void *ptr)
 {
 	return NULL;
 }
+static inline void tun_ptr_free(void *ptr)
+{
+}
 #endif /* CONFIG_TUN */
 #endif /* __IF_TUN_H */
-- 
2.7.4
