Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 23DDCC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6E620693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 06:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6E620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933209AbeFLG6A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 02:58:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:59203 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932637AbeFLG56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 02:57:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 52DC9ADD2;
        Tue, 12 Jun 2018 06:57:57 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        netdev@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, davem@davemloft.net,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH v2] xen/netfront: raise max number of slots in xennet_get_responses()
Date:   Tue, 12 Jun 2018 08:57:53 +0200
Message-Id: <20180612065753.10569-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max number of slots used in xennet_get_responses() is set to
MAX_SKB_FRAGS + (rx->status <= RX_COPY_THRESHOLD).

In old kernel-xen MAX_SKB_FRAGS was 18, while nowadays it is 17. This
difference is resulting in frequent messages "too many slots" and a
reduced network throughput for some workloads (factor 10 below that of
a kernel-xen based guest).

Replacing MAX_SKB_FRAGS by XEN_NETIF_NR_SLOTS_MIN for calculation of
the max number of slots to use solves that problem (tests showed no
more messages "too many slots" and throughput was as high as with the
kernel-xen based guest system).

Replace MAX_SKB_FRAGS-2 by XEN_NETIF_NR_SLOTS_MIN-1 in
netfront_tx_slot_available() for making it clearer what is really being
tested without actually modifying the tested value.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/net/xen-netfront.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 679da1abd73c..922ce0abf5cf 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -239,7 +239,7 @@ static void rx_refill_timeout(struct timer_list *t)
 static int netfront_tx_slot_available(struct netfront_queue *queue)
 {
 	return (queue->tx.req_prod_pvt - queue->tx.rsp_cons) <
-		(NET_TX_RING_SIZE - MAX_SKB_FRAGS - 2);
+		(NET_TX_RING_SIZE - XEN_NETIF_NR_SLOTS_MIN - 1);
 }
 
 static void xennet_maybe_wake_tx(struct netfront_queue *queue)
@@ -790,7 +790,7 @@ static int xennet_get_responses(struct netfront_queue *queue,
 	RING_IDX cons = queue->rx.rsp_cons;
 	struct sk_buff *skb = xennet_get_rx_skb(queue, cons);
 	grant_ref_t ref = xennet_get_rx_ref(queue, cons);
-	int max = MAX_SKB_FRAGS + (rx->status <= RX_COPY_THRESHOLD);
+	int max = XEN_NETIF_NR_SLOTS_MIN + (rx->status <= RX_COPY_THRESHOLD);
 	int slots = 1;
 	int err = 0;
 	unsigned long ret;
-- 
2.13.7

