Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeEUJE4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:04:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751557AbeEUJEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:04:45 -0400
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 01/12] vhost_net: introduce helper to initialize tx iov iter
Date: Mon, 21 May 2018 17:04:22 +0800
Message-Id: <1526893473-20128-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
References: <1526893473-20128-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index c4b49fc..15d191a 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -459,6 +459,26 @@ static bool vhost_exceeds_maxpend(struct vhost_net *net)
 	       min_t(unsigned int, VHOST_MAX_PEND, vq->num >> 2);
 }
 
+static size_t init_iov_iter(struct vhost_virtqueue *vq, struct iov_iter *iter,
+			    size_t hdr_size, int out)
+{
+	/* Skip header. TODO: support TSO. */
+	size_t len = iov_length(vq->iov, out);
+
+	iov_iter_init(iter, WRITE, vq->iov, out, len);
+	iov_iter_advance(iter, hdr_size);
+	/* Sanity check */
+	if (!iov_iter_count(iter)) {
+		vq_err(vq, "Unexpected header len for TX: "
+			"%zd expected %zd\n",
+			len, hdr_size);
+		return -EFAULT;
+	}
+	len = iov_iter_count(iter);
+
+	return len;
+}
+
 /* Expects to be always run from workqueue - which acts as
  * read-size critical section for our kind of RCU. */
 static void handle_tx(struct vhost_net *net)
@@ -521,18 +541,10 @@ static void handle_tx(struct vhost_net *net)
 			       "out %d, int %d\n", out, in);
 			break;
 		}
-		/* Skip header. TODO: support TSO. */
-		len = iov_length(vq->iov, out);
-		iov_iter_init(&msg.msg_iter, WRITE, vq->iov, out, len);
-		iov_iter_advance(&msg.msg_iter, hdr_size);
-		/* Sanity check */
-		if (!msg_data_left(&msg)) {
-			vq_err(vq, "Unexpected header len for TX: "
-			       "%zd expected %zd\n",
-			       len, hdr_size);
+
+		len = init_iov_iter(vq, &msg.msg_iter, hdr_size, out);
+		if (len < 0)
 			break;
-		}
-		len = msg_data_left(&msg);
 
 		zcopy_used = zcopy && len >= VHOST_GOODCOPY_LEN
 				   && !vhost_exceeds_maxpend(net)
-- 
2.7.4
