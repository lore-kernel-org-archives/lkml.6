Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FBDECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA8420856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA8420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbeGTBBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:01:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727615AbeGTBBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:01:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C2D74059FFD;
        Fri, 20 Jul 2018 00:15:44 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 338FB2026D6B;
        Fri, 20 Jul 2018 00:15:40 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/9] vhost_net: introduce get_tx_bufs()
Date:   Fri, 20 Jul 2018 08:15:16 +0800
Message-Id: <1532045721-4958-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
References: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 20 Jul 2018 00:15:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 20 Jul 2018 00:15:44 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out logic of getting tx buffer and iov iter
initialization. This will be used for reducing codes duplication in
the future.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index b9e1674..a014ca0 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -484,6 +484,36 @@ static bool vhost_exceeds_weight(int pkts, int total_len)
 	       pkts >= VHOST_NET_PKT_WEIGHT;
 }
 
+static int get_tx_bufs(struct vhost_net *net,
+		       struct vhost_net_virtqueue *nvq,
+		       struct msghdr *msg,
+		       unsigned int *out, unsigned int *in,
+		       size_t *len, bool *busyloop_intr)
+{
+	struct vhost_virtqueue *vq = &nvq->vq;
+	int ret;
+
+	ret = vhost_net_tx_get_vq_desc(net, vq, out, in, busyloop_intr);
+	if (ret < 0 || ret == vq->num)
+		return ret;
+
+	if (*in) {
+		vq_err(vq, "Unexpected descriptor format for TX: out %d, int %d\n",
+			*out, *in);
+		return -EFAULT;
+	}
+
+	/* Sanity check */
+	*len = init_iov_iter(vq, &msg->msg_iter, nvq->vhost_hlen, *out);
+	if (*len == 0) {
+		vq_err(vq, "Unexpected header len for TX: %zd expected %zd\n",
+			*len, nvq->vhost_hlen);
+		return -EFAULT;
+	}
+
+	return ret;
+}
+
 /* Expects to be always run from workqueue - which acts as
  * read-size critical section for our kind of RCU. */
 static void handle_tx(struct vhost_net *net)
@@ -501,7 +531,6 @@ static void handle_tx(struct vhost_net *net)
 	};
 	size_t len, total_len = 0;
 	int err;
-	size_t hdr_size;
 	struct socket *sock;
 	struct vhost_net_ubuf_ref *uninitialized_var(ubufs);
 	bool zcopy, zcopy_used;
@@ -518,7 +547,6 @@ static void handle_tx(struct vhost_net *net)
 	vhost_disable_notify(&net->dev, vq);
 	vhost_net_disable_vq(net, vq);
 
-	hdr_size = nvq->vhost_hlen;
 	zcopy = nvq->ubufs;
 
 	for (;;) {
@@ -529,8 +557,8 @@ static void handle_tx(struct vhost_net *net)
 			vhost_zerocopy_signal_used(net, vq);
 
 		busyloop_intr = false;
-		head = vhost_net_tx_get_vq_desc(net, vq, &out, &in,
-						&busyloop_intr);
+		head = get_tx_bufs(net, nvq, &msg, &out, &in, &len,
+				   &busyloop_intr);
 		/* On error, stop handling until the next kick. */
 		if (unlikely(head < 0))
 			break;
@@ -544,19 +572,6 @@ static void handle_tx(struct vhost_net *net)
 			}
 			break;
 		}
-		if (in) {
-			vq_err(vq, "Unexpected descriptor format for TX: "
-			       "out %d, int %d\n", out, in);
-			break;
-		}
-
-		/* Sanity check */
-		len = init_iov_iter(vq, &msg.msg_iter, hdr_size, out);
-		if (!len) {
-			vq_err(vq, "Unexpected header len for TX: %zd expected %zd\n",
-			len, hdr_size);
-			break;
-		}
 
 		zcopy_used = zcopy && len >= VHOST_GOODCOPY_LEN
 				   && !vhost_exceeds_maxpend(net)
-- 
2.7.4

