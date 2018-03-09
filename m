Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeCIGuy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 01:50:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751275AbeCIGuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 01:50:50 -0500
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: glider@google.com, dvyukov@google.com
Subject: [PATCH net 2/3] vhost_net: keep private_data and rx_ring synced
Date: Fri,  9 Mar 2018 14:50:33 +0800
Message-Id: <1520578234-5565-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1520578234-5565-1-git-send-email-jasowang@redhat.com>
References: <1520578234-5565-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get pointer ring from the exported sock, this means we should keep
rx_ring and vq->private synced during both vq stop and backend set,
otherwise we may see stale rx_ring.

Fixes: c67df11f6e480 ("vhost_net: try batch dequing from skb array")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 60f1080..efb9306 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -973,6 +973,7 @@ static struct socket *vhost_net_stop_vq(struct vhost_net *n,
 	vhost_net_disable_vq(n, vq);
 	vq->private_data = NULL;
 	vhost_net_buf_unproduce(nvq);
+	nvq->rx_ring = NULL;
 	mutex_unlock(&vq->mutex);
 	return sock;
 }
@@ -1162,14 +1163,14 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 		vhost_net_disable_vq(n, vq);
 		vq->private_data = sock;
 		vhost_net_buf_unproduce(nvq);
-		if (index == VHOST_NET_VQ_RX)
-			nvq->rx_ring = get_tap_ptr_ring(fd);
 		r = vhost_vq_init_access(vq);
 		if (r)
 			goto err_used;
 		r = vhost_net_enable_vq(n, vq);
 		if (r)
 			goto err_used;
+		if (index == VHOST_NET_VQ_RX)
+			nvq->rx_ring = get_tap_ptr_ring(fd);
 
 		oldubufs = nvq->ubufs;
 		nvq->ubufs = ubufs;
-- 
2.7.4
