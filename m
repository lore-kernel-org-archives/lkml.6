Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBF3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45582084E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45582084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbeGTBB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:01:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727615AbeGTBB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:01:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2C85401DEC7;
        Fri, 20 Jul 2018 00:15:55 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C34A2026D6B;
        Fri, 20 Jul 2018 00:15:52 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 7/9] vhost_net: rename vhost_rx_signal_used() to vhost_net_signal_used()
Date:   Fri, 20 Jul 2018 08:15:19 +0800
Message-Id: <1532045721-4958-8-git-send-email-jasowang@redhat.com>
In-Reply-To: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
References: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 20 Jul 2018 00:15:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 20 Jul 2018 00:15:55 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename for reusing this for TX.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 9cef0b2..53d305b 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -741,7 +741,7 @@ static int sk_has_rx_data(struct sock *sk)
 	return skb_queue_empty(&sk->sk_receive_queue);
 }
 
-static void vhost_rx_signal_used(struct vhost_net_virtqueue *nvq)
+static void vhost_net_signal_used(struct vhost_net_virtqueue *nvq)
 {
 	struct vhost_virtqueue *vq = &nvq->vq;
 	struct vhost_dev *dev = vq->dev;
@@ -765,7 +765,7 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
 
 	if (!len && tvq->busyloop_timeout) {
 		/* Flush batched heads first */
-		vhost_rx_signal_used(rnvq);
+		vhost_net_signal_used(rnvq);
 		/* Both tx vq and rx socket were polled here */
 		mutex_lock_nested(&tvq->mutex, 1);
 		vhost_disable_notify(&net->dev, tvq);
@@ -1008,7 +1008,7 @@ static void handle_rx(struct vhost_net *net)
 		}
 		nvq->done_idx += headcount;
 		if (nvq->done_idx > VHOST_RX_BATCH)
-			vhost_rx_signal_used(nvq);
+			vhost_net_signal_used(nvq);
 		if (unlikely(vq_log))
 			vhost_log_write(vq, vq_log, log, vhost_len);
 		total_len += vhost_len;
@@ -1022,7 +1022,7 @@ static void handle_rx(struct vhost_net *net)
 	else
 		vhost_net_enable_vq(net, vq);
 out:
-	vhost_rx_signal_used(nvq);
+	vhost_net_signal_used(nvq);
 	mutex_unlock(&vq->mutex);
 }
 
-- 
2.7.4

