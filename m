Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbeDSFBx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 01:01:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750953AbeDSFBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 01:01:51 -0400
Date: Thu, 19 Apr 2018 08:01:49 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH net] virtio_net: split out ctrl buffer
Message-ID: <1524113437-308621-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sending control commands, virtio net sets up several buffers for
DMA. The buffers are all part of the net device which means it's
actually allocated by kvmalloc so in theory (on extreme memory pressure)
it's possible to get a vmalloc'ed buffer which on some platforms means
we can't DMA there.

Fix up by moving the DMA buffers out into a separate structure.

Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Suggested-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Lightly tested.
Mikulas, does this address your problem?

 drivers/net/virtio_net.c | 68 +++++++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7b187ec..82f50e5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -147,6 +147,17 @@ struct receive_queue {
 	struct xdp_rxq_info xdp_rxq;
 };
 
+/* Control VQ buffers: protected by the rtnl lock */
+struct control_buf {
+	struct virtio_net_ctrl_hdr hdr;
+	virtio_net_ctrl_ack status;
+	struct virtio_net_ctrl_mq mq;
+	u8 promisc;
+	u8 allmulti;
+	u16 vid;
+	u64 offloads;
+};
+
 struct virtnet_info {
 	struct virtio_device *vdev;
 	struct virtqueue *cvq;
@@ -192,14 +203,7 @@ struct virtnet_info {
 	struct hlist_node node;
 	struct hlist_node node_dead;
 
-	/* Control VQ buffers: protected by the rtnl lock */
-	struct virtio_net_ctrl_hdr ctrl_hdr;
-	virtio_net_ctrl_ack ctrl_status;
-	struct virtio_net_ctrl_mq ctrl_mq;
-	u8 ctrl_promisc;
-	u8 ctrl_allmulti;
-	u16 ctrl_vid;
-	u64 ctrl_offloads;
+	struct control_buf *ctrl;
 
 	/* Ethtool settings */
 	u8 duplex;
@@ -1454,25 +1458,25 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	/* Caller should know better */
 	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
 
-	vi->ctrl_status = ~0;
-	vi->ctrl_hdr.class = class;
-	vi->ctrl_hdr.cmd = cmd;
+	vi->ctrl->status = ~0;
+	vi->ctrl->hdr.class = class;
+	vi->ctrl->hdr.cmd = cmd;
 	/* Add header */
-	sg_init_one(&hdr, &vi->ctrl_hdr, sizeof(vi->ctrl_hdr));
+	sg_init_one(&hdr, &vi->ctrl->hdr, sizeof(vi->ctrl->hdr));
 	sgs[out_num++] = &hdr;
 
 	if (out)
 		sgs[out_num++] = out;
 
 	/* Add return status. */
-	sg_init_one(&stat, &vi->ctrl_status, sizeof(vi->ctrl_status));
+	sg_init_one(&stat, &vi->ctrl->status, sizeof(vi->ctrl->status));
 	sgs[out_num] = &stat;
 
 	BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
 	virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, vi, GFP_ATOMIC);
 
 	if (unlikely(!virtqueue_kick(vi->cvq)))
-		return vi->ctrl_status == VIRTIO_NET_OK;
+		return vi->ctrl->status == VIRTIO_NET_OK;
 
 	/* Spin for a response, the kick causes an ioport write, trapping
 	 * into the hypervisor, so the request should be handled immediately.
@@ -1481,7 +1485,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	       !virtqueue_is_broken(vi->cvq))
 		cpu_relax();
 
-	return vi->ctrl_status == VIRTIO_NET_OK;
+	return vi->ctrl->status == VIRTIO_NET_OK;
 }
 
 static int virtnet_set_mac_address(struct net_device *dev, void *p)
@@ -1593,8 +1597,8 @@ static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
 		return 0;
 
-	vi->ctrl_mq.virtqueue_pairs = cpu_to_virtio16(vi->vdev, queue_pairs);
-	sg_init_one(&sg, &vi->ctrl_mq, sizeof(vi->ctrl_mq));
+	vi->ctrl->mq.virtqueue_pairs = cpu_to_virtio16(vi->vdev, queue_pairs);
+	sg_init_one(&sg, &vi->ctrl->mq, sizeof(vi->ctrl->mq));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
 				  VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET, &sg)) {
@@ -1653,22 +1657,22 @@ static void virtnet_set_rx_mode(struct net_device *dev)
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
 		return;
 
-	vi->ctrl_promisc = ((dev->flags & IFF_PROMISC) != 0);
-	vi->ctrl_allmulti = ((dev->flags & IFF_ALLMULTI) != 0);
+	vi->ctrl->promisc = ((dev->flags & IFF_PROMISC) != 0);
+	vi->ctrl->allmulti = ((dev->flags & IFF_ALLMULTI) != 0);
 
-	sg_init_one(sg, &vi->ctrl_promisc, sizeof(vi->ctrl_promisc));
+	sg_init_one(sg, &vi->ctrl->promisc, sizeof(vi->ctrl->promisc));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
 				  VIRTIO_NET_CTRL_RX_PROMISC, sg))
 		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
-			 vi->ctrl_promisc ? "en" : "dis");
+			 vi->ctrl->promisc ? "en" : "dis");
 
-	sg_init_one(sg, &vi->ctrl_allmulti, sizeof(vi->ctrl_allmulti));
+	sg_init_one(sg, &vi->ctrl->allmulti, sizeof(vi->ctrl->allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
 				  VIRTIO_NET_CTRL_RX_ALLMULTI, sg))
 		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
-			 vi->ctrl_allmulti ? "en" : "dis");
+			 vi->ctrl->allmulti ? "en" : "dis");
 
 	uc_count = netdev_uc_count(dev);
 	mc_count = netdev_mc_count(dev);
@@ -1714,8 +1718,8 @@ static int virtnet_vlan_rx_add_vid(struct net_device *dev,
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct scatterlist sg;
 
-	vi->ctrl_vid = vid;
-	sg_init_one(&sg, &vi->ctrl_vid, sizeof(vi->ctrl_vid));
+	vi->ctrl->vid = vid;
+	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
 				  VIRTIO_NET_CTRL_VLAN_ADD, &sg))
@@ -1729,8 +1733,8 @@ static int virtnet_vlan_rx_kill_vid(struct net_device *dev,
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct scatterlist sg;
 
-	vi->ctrl_vid = vid;
-	sg_init_one(&sg, &vi->ctrl_vid, sizeof(vi->ctrl_vid));
+	vi->ctrl->vid = vid;
+	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
 				  VIRTIO_NET_CTRL_VLAN_DEL, &sg))
@@ -2126,9 +2130,9 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 static int virtnet_set_guest_offloads(struct virtnet_info *vi, u64 offloads)
 {
 	struct scatterlist sg;
-	vi->ctrl_offloads = cpu_to_virtio64(vi->vdev, offloads);
+	vi->ctrl->offloads = cpu_to_virtio64(vi->vdev, offloads);
 
-	sg_init_one(&sg, &vi->ctrl_offloads, sizeof(vi->ctrl_offloads));
+	sg_init_one(&sg, &vi->ctrl->offloads, sizeof(vi->ctrl->offloads));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_GUEST_OFFLOADS,
 				  VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET, &sg)) {
@@ -2351,6 +2355,7 @@ static void virtnet_free_queues(struct virtnet_info *vi)
 
 	kfree(vi->rq);
 	kfree(vi->sq);
+	kfree(vi->err_ctrl);
 }
 
 static void _free_receive_bufs(struct virtnet_info *vi)
@@ -2543,6 +2548,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 {
 	int i;
 
+	vi->ctrl = kzalloc(sizeof(*vi->ctrl), GFP_KERNEL);
+	if (!vi->ctrl)
+		goto err_ctrl;
 	vi->sq = kzalloc(sizeof(*vi->sq) * vi->max_queue_pairs, GFP_KERNEL);
 	if (!vi->sq)
 		goto err_sq;
@@ -2571,6 +2579,8 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 err_rq:
 	kfree(vi->sq);
 err_sq:
+	kfree(vq->ctrl);
+err_ctrl:
 	return -ENOMEM;
 }
 
-- 
MST
