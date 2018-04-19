Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753339AbeDSFay (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 01:30:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752325AbeDSFau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 01:30:50 -0400
Date: Thu, 19 Apr 2018 08:30:49 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>, Thomas Huth <thuth@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH v2 net 2/3] virtio_net: fix adding vids on big-endian
Message-ID: <1524115776-334953-3-git-send-email-mst@redhat.com>
References: <1524115776-334953-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524115776-334953-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Programming vids (adding or removing them) still passes
guest-endian values in the DMA buffer. That's wrong
if guest is big-endian and when virtio 1 is enabled.

Note: this is on top of a previous patch:
	virtio_net: split out ctrl buffer

Fixes: 9465a7a6f ("virtio_net: enable v1.0 support")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3d0eff53..f84fe04 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -154,7 +154,7 @@ struct control_buf {
 	struct virtio_net_ctrl_mq mq;
 	u8 promisc;
 	u8 allmulti;
-	u16 vid;
+	__virtio16 vid;
 	u64 offloads;
 };
 
@@ -1718,7 +1718,7 @@ static int virtnet_vlan_rx_add_vid(struct net_device *dev,
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct scatterlist sg;
 
-	vi->ctrl->vid = vid;
+	vi->ctrl->vid = cpu_to_virtio16(vi->vdev, vid);
 	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
@@ -1733,7 +1733,7 @@ static int virtnet_vlan_rx_kill_vid(struct net_device *dev,
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct scatterlist sg;
 
-	vi->ctrl->vid = vid;
+	vi->ctrl->vid = cpu_to_virtio16(vi->vdev, vid);
 	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
-- 
MST
