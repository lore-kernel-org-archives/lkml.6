Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeEVDpB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:45:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752556AbeEVDov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 23:44:51 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net V2 3/4] virtio-net: correctly check num_buf during err path
Date: Tue, 22 May 2018 11:44:30 +0800
Message-Id: <1526960671-11782-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1526960671-11782-1-git-send-email-jasowang@redhat.com>
References: <1526960671-11782-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we successfully linearize the packet, num_buf will be set to zero
which may confuse error handling path which assumes num_buf is at
least 1 and this can lead the code tries to pop the descriptor of next
buffer. Fixing this by checking num_buf against 1 before decreasing.

Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6260d65..326e247 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -875,7 +875,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	rcu_read_unlock();
 err_skb:
 	put_page(page);
-	while (--num_buf) {
+	while (num_buf-- > 1) {
 		buf = virtqueue_get_buf(rq->vq, &len);
 		if (unlikely(!buf)) {
 			pr_debug("%s: rx error: %d buffers missing\n",
-- 
2.7.4
