Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A8DECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ED620673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2ED620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbeGTBBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:01:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727615AbeGTBBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:01:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D64EE400225D;
        Fri, 20 Jul 2018 00:15:59 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A325B2026D6B;
        Fri, 20 Jul 2018 00:15:56 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 8/9] vhost_net: rename VHOST_RX_BATCH to VHOST_NET_BATCH
Date:   Fri, 20 Jul 2018 08:15:20 +0800
Message-Id: <1532045721-4958-9-git-send-email-jasowang@redhat.com>
In-Reply-To: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
References: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 20 Jul 2018 00:15:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 20 Jul 2018 00:15:59 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A more generic name which could be used for TX as well.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 53d305b..2fd2f0e3 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -94,7 +94,7 @@ struct vhost_net_ubuf_ref {
 	struct vhost_virtqueue *vq;
 };
 
-#define VHOST_RX_BATCH 64
+#define VHOST_NET_BATCH 64
 struct vhost_net_buf {
 	void **queue;
 	int tail;
@@ -168,7 +168,7 @@ static int vhost_net_buf_produce(struct vhost_net_virtqueue *nvq)
 
 	rxq->head = 0;
 	rxq->tail = ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
-					      VHOST_RX_BATCH);
+					      VHOST_NET_BATCH);
 	return rxq->tail;
 }
 
@@ -1007,7 +1007,7 @@ static void handle_rx(struct vhost_net *net)
 			goto out;
 		}
 		nvq->done_idx += headcount;
-		if (nvq->done_idx > VHOST_RX_BATCH)
+		if (nvq->done_idx > VHOST_NET_BATCH)
 			vhost_net_signal_used(nvq);
 		if (unlikely(vq_log))
 			vhost_log_write(vq, vq_log, log, vhost_len);
@@ -1075,7 +1075,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 		return -ENOMEM;
 	}
 
-	queue = kmalloc_array(VHOST_RX_BATCH, sizeof(void *),
+	queue = kmalloc_array(VHOST_NET_BATCH, sizeof(void *),
 			      GFP_KERNEL);
 	if (!queue) {
 		kfree(vqs);
-- 
2.7.4

