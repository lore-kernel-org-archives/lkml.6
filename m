Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42666C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C7F214F1
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C7F214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbeKLFsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:12 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49684 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730055AbeKLFsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:10 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0000oP-Ca; Sun, 11 Nov 2018 19:58:40 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0001ao-1c; Sun, 11 Nov 2018 19:58:37 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "David Vrabel" <david.vrabel@citrix.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.313847014@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 164/366] xen-netfront: release per-queue Tx and Rx
 resource when disconnecting
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Vrabel <david.vrabel@citrix.com>

commit a5b5dc3ce4df4f05f4d81c7d3c56a7604b242093 upstream.

Since netfront may reconnect to a backend with a different number of
queues, all per-queue Rx and Tx resources (skbs and grant references)
should be freed when disconnecting.

Without this fix, the Tx and Rx grant refs are not released and
netfront will exhaust them after only a few reconnections.  netfront
will fail to connect when no free grant references are available.

Since all Rx bufs are freed and reallocated instead of reused this
will add some additional delay to the reconnection but this is
expected to be small compared to the time taken by any backend hotplug
scripts etc.

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/xen-netfront.c | 68 ++++----------------------------------
 1 file changed, 7 insertions(+), 61 deletions(-)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1194,22 +1194,6 @@ static void xennet_release_rx_bufs(struc
 	spin_unlock_bh(&queue->rx_lock);
 }
 
-static void xennet_uninit(struct net_device *dev)
-{
-	struct netfront_info *np = netdev_priv(dev);
-	unsigned int num_queues = dev->real_num_tx_queues;
-	struct netfront_queue *queue;
-	unsigned int i;
-
-	for (i = 0; i < num_queues; ++i) {
-		queue = &np->queues[i];
-		xennet_release_tx_bufs(queue);
-		xennet_release_rx_bufs(queue);
-		gnttab_free_grant_references(queue->gref_tx_head);
-		gnttab_free_grant_references(queue->gref_rx_head);
-	}
-}
-
 static netdev_features_t xennet_fix_features(struct net_device *dev,
 	netdev_features_t features)
 {
@@ -1311,7 +1295,6 @@ static void xennet_poll_controller(struc
 
 static const struct net_device_ops xennet_netdev_ops = {
 	.ndo_open            = xennet_open,
-	.ndo_uninit          = xennet_uninit,
 	.ndo_stop            = xennet_close,
 	.ndo_start_xmit      = xennet_start_xmit,
 	.ndo_change_mtu	     = xennet_change_mtu,
@@ -1454,6 +1437,11 @@ static void xennet_disconnect_backend(st
 		if (netif_running(info->netdev))
 			napi_synchronize(&queue->napi);
 
+		xennet_release_tx_bufs(queue);
+		xennet_release_rx_bufs(queue);
+		gnttab_free_grant_references(queue->gref_tx_head);
+		gnttab_free_grant_references(queue->gref_rx_head);
+
 		/* End access and free the pages */
 		xennet_end_access(queue->tx_ring_ref, queue->tx.sring);
 		xennet_end_access(queue->rx_ring_ref, queue->rx.sring);
@@ -2009,10 +1997,7 @@ static int xennet_connect(struct net_dev
 {
 	struct netfront_info *np = netdev_priv(dev);
 	unsigned int num_queues = 0;
-	int i, requeue_idx, err;
-	struct sk_buff *skb;
-	grant_ref_t ref;
-	struct xen_netif_rx_request *req;
+	int err;
 	unsigned int feature_rx_copy;
 	unsigned int j = 0;
 	struct netfront_queue *queue = NULL;
@@ -2039,47 +2024,8 @@ static int xennet_connect(struct net_dev
 	netdev_update_features(dev);
 	rtnl_unlock();
 
-	/* By now, the queue structures have been set up */
-	for (j = 0; j < num_queues; ++j) {
-		queue = &np->queues[j];
-
-		/* Step 1: Discard all pending TX packet fragments. */
-		spin_lock_irq(&queue->tx_lock);
-		xennet_release_tx_bufs(queue);
-		spin_unlock_irq(&queue->tx_lock);
-
-		/* Step 2: Rebuild the RX buffer freelist and the RX ring itself. */
-		spin_lock_bh(&queue->rx_lock);
-
-		for (requeue_idx = 0, i = 0; i < NET_RX_RING_SIZE; i++) {
-			skb_frag_t *frag;
-			const struct page *page;
-			if (!queue->rx_skbs[i])
-				continue;
-
-			skb = queue->rx_skbs[requeue_idx] = xennet_get_rx_skb(queue, i);
-			ref = queue->grant_rx_ref[requeue_idx] = xennet_get_rx_ref(queue, i);
-			req = RING_GET_REQUEST(&queue->rx, requeue_idx);
-
-			frag = &skb_shinfo(skb)->frags[0];
-			page = skb_frag_page(frag);
-			gnttab_grant_foreign_access_ref(
-				ref, queue->info->xbdev->otherend_id,
-				pfn_to_mfn(page_to_pfn(page)),
-				0);
-			req->gref = ref;
-			req->id   = requeue_idx;
-
-			requeue_idx++;
-		}
-
-		queue->rx.req_prod_pvt = requeue_idx;
-
-		spin_unlock_bh(&queue->rx_lock);
-	}
-
 	/*
-	 * Step 3: All public and private state should now be sane.  Get
+	 * All public and private state should now be sane.  Get
 	 * ready to start sending and receiving packets and give the driver
 	 * domain a kick because we've probably just requeued some
 	 * packets.

