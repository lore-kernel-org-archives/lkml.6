Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeEUJIv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:08:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39974 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751778AbeEUJEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:04:52 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 03/12] vhost_net: introduce vhost_has_more_pkts()
Date: Mon, 21 May 2018 17:04:24 +0800
Message-Id: <1526893473-20128-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index de544ee..4ebac76 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -485,6 +485,13 @@ static bool vhost_exceeds_weight(int pkts, int total_len)
 	       unlikely(pkts >= VHOST_NET_PKT_WEIGHT);
 }
 
+static bool vhost_has_more_pkts(struct vhost_net *net,
+				struct vhost_virtqueue *vq)
+{
+	return !vhost_vq_avail_empty(&net->dev, vq) &&
+	       likely(!vhost_exceeds_maxpend(net));
+}
+
 /* Expects to be always run from workqueue - which acts as
  * read-size critical section for our kind of RCU. */
 static void handle_tx(struct vhost_net *net)
@@ -578,8 +585,7 @@ static void handle_tx(struct vhost_net *net)
 		}
 		total_len += len;
 		if (total_len < VHOST_NET_WEIGHT &&
-		    !vhost_vq_avail_empty(&net->dev, vq) &&
-		    likely(!vhost_exceeds_maxpend(net))) {
+		    vhost_has_more_pkts(net, vq)) {
 			msg.msg_flags |= MSG_MORE;
 		} else {
 			msg.msg_flags &= ~MSG_MORE;
@@ -605,7 +611,7 @@ static void handle_tx(struct vhost_net *net)
 		else
 			vhost_zerocopy_signal_used(net, vq);
 		vhost_net_tx_packet(net);
-		if (unlikely(vhost_exceeds_weight(++sent_pkts, total_len))) {
+		if (vhost_exceeds_weight(++sent_pkts, total_len)) {
 			vhost_poll_queue(&vq->poll);
 			break;
 		}
-- 
2.7.4
