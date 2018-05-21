Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbeEUJFF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:05:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751727AbeEUJFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:05:02 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 05/12] vhost_net: batch update used ring for datacopy TX
Date: Mon, 21 May 2018 17:04:26 +0800
Message-Id: <1526893473-20128-6-git-send-email-jasowang@redhat.com>
In-Reply-To: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like commit e2b3b35eb989 ("vhost_net: batch used ring update in rx"),
this patches implements batch used ring update for datacopy TX
(zerocopy has already done some kind of batching).

Testpmd transmission from guest to ixgbe via XDP_REDIRECT shows about
15% improvement from 2.8Mpps to 3.2Mpps.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 4682fcc..f0639d7 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -511,6 +511,7 @@ static void handle_tx_copy(struct vhost_net *net)
 	struct socket *sock;
 	struct vhost_net_ubuf_ref *uninitialized_var(ubufs);
 	int sent_pkts = 0;
+	s16 nheads = 0;
 
 	mutex_lock(&vq->mutex);
 	sock = vq->private_data;
@@ -550,6 +551,9 @@ static void handle_tx_copy(struct vhost_net *net)
 		if (len < 0)
 			break;
 
+		vq->heads[nheads].id = cpu_to_vhost32(vq, head);
+		vq->heads[nheads].len = 0;
+
 		total_len += len;
 		if (total_len < VHOST_NET_WEIGHT &&
 		    vhost_has_more_pkts(net, vq)) {
@@ -568,13 +572,20 @@ static void handle_tx_copy(struct vhost_net *net)
 		if (err != len)
 			pr_debug("Truncated TX packet: "
 				 " len %d != %zd\n", err, len);
-		vhost_add_used_and_signal(&net->dev, vq, head, 0);
+		if (++nheads == VHOST_RX_BATCH) {
+			vhost_add_used_and_signal_n(&net->dev, vq, vq->heads,
+						    nheads);
+			nheads = 0;
+		}
 		if (vhost_exceeds_weight(++sent_pkts, total_len)) {
 			vhost_poll_queue(&vq->poll);
 			break;
 		}
 	}
 out:
+	if (nheads)
+		vhost_add_used_and_signal_n(&net->dev, vq, vq->heads,
+					    nheads);
 	mutex_unlock(&vq->mutex);
 }
 
-- 
2.7.4
