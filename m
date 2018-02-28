Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeB1KUL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:20:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752082AbeB1KUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:20:09 -0500
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] virtio-net: disable NAPI only when enabled during XDP set
Date: Wed, 28 Feb 2018 18:20:04 +0800
Message-Id: <1519813204-10002-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We try to disable NAPI to prevent a single XDP TX queue being used by
multiple cpus. But we don't check if device is up (NAPI is enabled),
this could result stall because of infinite wait in
napi_disable(). Fixing this by checking device state through
netif_running() before.

Fixes: 4941d472bf95b ("virtio-net: do not reset during XDP set")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9bb9e56..2d54123 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2185,8 +2185,9 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	}
 
 	/* Make sure NAPI is not using any XDP TX queues for RX. */
-	for (i = 0; i < vi->max_queue_pairs; i++)
-		napi_disable(&vi->rq[i].napi);
+	if (netif_running(dev))
+		for (i = 0; i < vi->max_queue_pairs; i++)
+			napi_disable(&vi->rq[i].napi);
 
 	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
 	err = _virtnet_set_queues(vi, curr_qp + xdp_qp);
@@ -2205,7 +2206,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		}
 		if (old_prog)
 			bpf_prog_put(old_prog);
-		virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
+		if (netif_running(dev))
+			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
 	}
 
 	return 0;
-- 
2.7.4
