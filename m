Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeEVDp7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:45:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752637AbeEVDor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 23:44:47 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH net V2 2/4] virtio-net: correctly transmit XDP buff after linearizing
Date: Tue, 22 May 2018 11:44:29 +0800
Message-Id: <1526960671-11782-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1526960671-11782-1-git-send-email-jasowang@redhat.com>
References: <1526960671-11782-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should not go for the error path after successfully transmitting a
XDP buffer after linearizing. Since the error path may try to pop and
drop next packet and increase the drop counters. Fixing this by simply
drop the refcnt of original page and go for xmit path.

Fixes: 72979a6c3590 ("virtio_net: xdp, add slowpath case for non contiguous buffers")
Cc: John Fastabend <john.fastabend@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c15d240..6260d65 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -775,7 +775,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			}
 			*xdp_xmit = true;
 			if (unlikely(xdp_page != page))
-				goto err_xdp;
+				put_page(page);
 			rcu_read_unlock();
 			goto xdp_xmit;
 		case XDP_REDIRECT:
-- 
2.7.4
