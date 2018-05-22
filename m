Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeEVDot (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:44:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50698 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752556AbeEVDon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 23:44:43 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net V2 1/4] virtio-net: correctly redirect linearized packet
Date: Tue, 22 May 2018 11:44:28 +0800
Message-Id: <1526960671-11782-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1526960671-11782-1-git-send-email-jasowang@redhat.com>
References: <1526960671-11782-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a linearized packet was redirected by XDP, we should not go for
the err path which will try to pop buffers for the next packet and
increase the drop counter. Fixing this by just drop the page refcnt
for the original page.

Fixes: 186b3c998c50 ("virtio-net: support XDP_REDIRECT")
Reported-by: David Ahern <dsahern@gmail.com>
Tested-by: David Ahern <dsahern@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 770422e..c15d240 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -787,7 +787,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			}
 			*xdp_xmit = true;
 			if (unlikely(xdp_page != page))
-				goto err_xdp;
+				put_page(page);
 			rcu_read_unlock();
 			goto xdp_xmit;
 		default:
-- 
2.7.4
