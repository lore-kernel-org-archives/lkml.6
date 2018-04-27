Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZowwR2nOLmBZdN2Qz7MJ3+HSwsFvLbfdFSu6A5/td2zhaqu59b9+l0GqXNvYEP0ykz2GXmL
ARC-Seal: i=1; a=rsa-sha256; t=1524838313; cv=none;
        d=google.com; s=arc-20160816;
        b=Neato1PSvDPEVijika2T4rYYVKD2a1EPE2AT82swWj3XqipZxcIgbDO+2LYn8hLj7q
         fO9QpCw8V9ZcxXMnERUxpNPZ4UAlwikeQ5PgRzBGJj2xObqPotxBHC9ae3TQTXjaaB9B
         cJrr47Rrg7BzFWGr5oq+GAypN4FNTonGcIspapA7iih2XFDnLThoUWamgRva2vO4RGWm
         79dluhEQ0xQC7womjl0tkUrJU94Vfx/T/9dHl6nck+uNlbTG0U3T3B07vi8ss9PiTdK5
         tnKe1e3mazZshOygPwSlwN3HRB6RMzdfC0wuKIRieKT/9Nb5JJef8O6IGxi6EqUpfjRf
         7zpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=/bJRV0AsMq3nE9CW3J7FQnRkVNaw6uV9KgIcYyXxlkQ=;
        b=NFxCjRpftwod/pXF7XmPsBoaJ0dJqTirrO6p8HtkD4u9fMrVvd02yJiX4uByeaKWPU
         /yyfgXb3M//bb7/4FJABqPh/w/cuWo7SkTab7bWwHn0rbZ/l000zdobkW//Jt3s0FvxO
         Agok1odtwwCA7T4Z0a2tZKKf5eAc64WXtO9b1dA4dCG15tn5cFF4P+HxY7PLnuZmON+X
         MB2QORevgznrde/+DqjxgMIV5QhRTu6DVLKsJGEeGGhiDVNsrlirXSK0P666Af+O7XfR
         iBiFJB0QR/K1deCd7Ty8kDaD1lq9dvxXoDNQ9ouF/r5hohairC7ZJS3MqJnkXFCqIpXI
         Q4yg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04AA62189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 58/81] virtio_net: split out ctrl buffer
Date: Fri, 27 Apr 2018 15:59:00 +0200
Message-Id: <20180427135746.782095480@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908670301526268?=
X-GMAIL-MSGID: =?utf-8?q?1598908859563846825?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Michael S. Tsirkin" <mst@redhat.com>


[ Upstream commit 12e571693837d6164bda61e316b1944972ee0d97 ]

When sending control commands, virtio net sets up several buffers for
DMA. The buffers are all part of the net device which means it's
actually allocated by kvmalloc so it's in theory (on extreme memory
pressure) possible to get a vmalloc'ed buffer which on some platforms
means we can't DMA there.

Fix up by moving the DMA buffers into a separate structure.

Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Suggested-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |   68 ++++++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

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
@@ -1461,25 +1465,25 @@ static bool virtnet_send_command(struct
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
@@ -1488,7 +1492,7 @@ static bool virtnet_send_command(struct
 	       !virtqueue_is_broken(vi->cvq))
 		cpu_relax();
 
-	return vi->ctrl_status == VIRTIO_NET_OK;
+	return vi->ctrl->status == VIRTIO_NET_OK;
 }
 
 static int virtnet_set_mac_address(struct net_device *dev, void *p)
@@ -1600,8 +1604,8 @@ static int _virtnet_set_queues(struct vi
 	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
 		return 0;
 
-	vi->ctrl_mq.virtqueue_pairs = cpu_to_virtio16(vi->vdev, queue_pairs);
-	sg_init_one(&sg, &vi->ctrl_mq, sizeof(vi->ctrl_mq));
+	vi->ctrl->mq.virtqueue_pairs = cpu_to_virtio16(vi->vdev, queue_pairs);
+	sg_init_one(&sg, &vi->ctrl->mq, sizeof(vi->ctrl->mq));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
 				  VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET, &sg)) {
@@ -1660,22 +1664,22 @@ static void virtnet_set_rx_mode(struct n
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
@@ -1721,8 +1725,8 @@ static int virtnet_vlan_rx_add_vid(struc
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct scatterlist sg;
 
-	vi->ctrl_vid = vid;
-	sg_init_one(&sg, &vi->ctrl_vid, sizeof(vi->ctrl_vid));
+	vi->ctrl->vid = vid;
+	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
 				  VIRTIO_NET_CTRL_VLAN_ADD, &sg))
@@ -1736,8 +1740,8 @@ static int virtnet_vlan_rx_kill_vid(stru
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct scatterlist sg;
 
-	vi->ctrl_vid = vid;
-	sg_init_one(&sg, &vi->ctrl_vid, sizeof(vi->ctrl_vid));
+	vi->ctrl->vid = vid;
+	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
 				  VIRTIO_NET_CTRL_VLAN_DEL, &sg))
@@ -2133,9 +2137,9 @@ static int virtnet_restore_up(struct vir
 static int virtnet_set_guest_offloads(struct virtnet_info *vi, u64 offloads)
 {
 	struct scatterlist sg;
-	vi->ctrl_offloads = cpu_to_virtio64(vi->vdev, offloads);
+	vi->ctrl->offloads = cpu_to_virtio64(vi->vdev, offloads);
 
-	sg_init_one(&sg, &vi->ctrl_offloads, sizeof(vi->ctrl_offloads));
+	sg_init_one(&sg, &vi->ctrl->offloads, sizeof(vi->ctrl->offloads));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_GUEST_OFFLOADS,
 				  VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET, &sg)) {
@@ -2358,6 +2362,7 @@ static void virtnet_free_queues(struct v
 
 	kfree(vi->rq);
 	kfree(vi->sq);
+	kfree(vi->ctrl);
 }
 
 static void _free_receive_bufs(struct virtnet_info *vi)
@@ -2550,6 +2555,9 @@ static int virtnet_alloc_queues(struct v
 {
 	int i;
 
+	vi->ctrl = kzalloc(sizeof(*vi->ctrl), GFP_KERNEL);
+	if (!vi->ctrl)
+		goto err_ctrl;
 	vi->sq = kzalloc(sizeof(*vi->sq) * vi->max_queue_pairs, GFP_KERNEL);
 	if (!vi->sq)
 		goto err_sq;
@@ -2578,6 +2586,8 @@ static int virtnet_alloc_queues(struct v
 err_rq:
 	kfree(vi->sq);
 err_sq:
+	kfree(vi->ctrl);
+err_ctrl:
 	return -ENOMEM;
 }
 
