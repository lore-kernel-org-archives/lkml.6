Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF995C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F91F20869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F91F20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbeKLG1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:27:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49668 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730057AbeKLFsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:10 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0000oO-BI; Sun, 11 Nov 2018 19:58:40 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0001at-2K; Sun, 11 Nov 2018 19:58:37 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Dmitry Piotrovsky" <piotrovskydmitry@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "David Vrabel" <david.vrabel@citrix.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.805475330@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 165/366] xen-netfront: use different locks for Rx and
 Tx stats
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

commit 900e183301b54f8ca17a86d9835e9569090d182a upstream.

In netfront the Rx and Tx path are independent and use different
locks.  The Tx lock is held with hard irqs disabled, but Rx lock is
held with only BH disabled.  Since both sides use the same stats lock,
a deadlock may occur.

  [ INFO: possible irq lock inversion dependency detected ]
  3.16.2 #16 Not tainted
  ---------------------------------------------------------
  swapper/0/0 just changed the state of lock:
   (&(&queue->tx_lock)->rlock){-.....}, at: [<c03adec8>]
  xennet_tx_interrupt+0x14/0x34
  but this lock took another, HARDIRQ-unsafe lock in the past:
   (&stat->syncp.seq#2){+.-...}
  and interrupts could create inverse lock ordering between them.
  other info that might help us debug this:
   Possible interrupt unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    lock(&stat->syncp.seq#2);
                                 local_irq_disable();
                                 lock(&(&queue->tx_lock)->rlock);
                                 lock(&stat->syncp.seq#2);
    <Interrupt>
      lock(&(&queue->tx_lock)->rlock);

Using separate locks for the Rx and Tx stats fixes this deadlock.

Reported-by: Dmitry Piotrovsky <piotrovskydmitry@gmail.com>
Signed-off-by: David Vrabel <david.vrabel@citrix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/xen-netfront.c | 71 ++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 29 deletions(-)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -86,10 +86,8 @@ struct netfront_cb {
 #define IRQ_NAME_SIZE (QUEUE_NAME_SIZE + 3)
 
 struct netfront_stats {
-	u64			rx_packets;
-	u64			tx_packets;
-	u64			rx_bytes;
-	u64			tx_bytes;
+	u64			packets;
+	u64			bytes;
 	struct u64_stats_sync	syncp;
 };
 
@@ -165,7 +163,8 @@ struct netfront_info {
 	struct netfront_queue *queues;
 
 	/* Statistics */
-	struct netfront_stats __percpu *stats;
+	struct netfront_stats __percpu *rx_stats;
+	struct netfront_stats __percpu *tx_stats;
 
 	atomic_t rx_gso_checksum_fixup;
 };
@@ -588,7 +587,7 @@ static int xennet_start_xmit(struct sk_b
 {
 	unsigned short id;
 	struct netfront_info *np = netdev_priv(dev);
-	struct netfront_stats *stats = this_cpu_ptr(np->stats);
+	struct netfront_stats *tx_stats = this_cpu_ptr(np->tx_stats);
 	struct xen_netif_tx_request *tx;
 	char *data = skb->data;
 	RING_IDX i;
@@ -695,10 +694,10 @@ static int xennet_start_xmit(struct sk_b
 	if (notify)
 		notify_remote_via_irq(queue->tx_irq);
 
-	u64_stats_update_begin(&stats->syncp);
-	stats->tx_bytes += skb->len;
-	stats->tx_packets++;
-	u64_stats_update_end(&stats->syncp);
+	u64_stats_update_begin(&tx_stats->syncp);
+	tx_stats->bytes += skb->len;
+	tx_stats->packets++;
+	u64_stats_update_end(&tx_stats->syncp);
 
 	/* Note: It is not safe to access skb after xennet_tx_buf_gc()! */
 	xennet_tx_buf_gc(queue);
@@ -954,7 +953,7 @@ static int checksum_setup(struct net_dev
 static int handle_incoming_queue(struct netfront_queue *queue,
 				 struct sk_buff_head *rxq)
 {
-	struct netfront_stats *stats = this_cpu_ptr(queue->info->stats);
+	struct netfront_stats *rx_stats = this_cpu_ptr(queue->info->rx_stats);
 	int packets_dropped = 0;
 	struct sk_buff *skb;
 
@@ -975,10 +974,10 @@ static int handle_incoming_queue(struct
 			continue;
 		}
 
-		u64_stats_update_begin(&stats->syncp);
-		stats->rx_packets++;
-		stats->rx_bytes += skb->len;
-		u64_stats_update_end(&stats->syncp);
+		u64_stats_update_begin(&rx_stats->syncp);
+		rx_stats->packets++;
+		rx_stats->bytes += skb->len;
+		u64_stats_update_end(&rx_stats->syncp);
 
 		/* Pass it up. */
 		napi_gro_receive(&queue->napi, skb);
@@ -1113,18 +1112,22 @@ static struct rtnl_link_stats64 *xennet_
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
-		struct netfront_stats *stats = per_cpu_ptr(np->stats, cpu);
+		struct netfront_stats *rx_stats = per_cpu_ptr(np->rx_stats, cpu);
+		struct netfront_stats *tx_stats = per_cpu_ptr(np->tx_stats, cpu);
 		u64 rx_packets, rx_bytes, tx_packets, tx_bytes;
 		unsigned int start;
 
 		do {
-			start = u64_stats_fetch_begin_irq(&stats->syncp);
+			start = u64_stats_fetch_begin_irq(&tx_stats->syncp);
+			tx_packets = tx_stats->packets;
+			tx_bytes = tx_stats->bytes;
+		} while (u64_stats_fetch_retry_irq(&tx_stats->syncp, start));
 
-			rx_packets = stats->rx_packets;
-			tx_packets = stats->tx_packets;
-			rx_bytes = stats->rx_bytes;
-			tx_bytes = stats->tx_bytes;
-		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
+		do {
+			start = u64_stats_fetch_begin_irq(&rx_stats->syncp);
+			rx_packets = rx_stats->packets;
+			rx_bytes = rx_stats->bytes;
+		} while (u64_stats_fetch_retry_irq(&rx_stats->syncp, start));
 
 		tot->rx_packets += rx_packets;
 		tot->tx_packets += tx_packets;
@@ -1309,6 +1312,15 @@ static const struct net_device_ops xenne
 #endif
 };
 
+static void xennet_free_netdev(struct net_device *netdev)
+{
+	struct netfront_info *np = netdev_priv(netdev);
+
+	free_percpu(np->rx_stats);
+	free_percpu(np->tx_stats);
+	free_netdev(netdev);
+}
+
 static struct net_device *xennet_create_dev(struct xenbus_device *dev)
 {
 	int err;
@@ -1329,8 +1341,11 @@ static struct net_device *xennet_create_
 	np->queues = NULL;
 
 	err = -ENOMEM;
-	np->stats = netdev_alloc_pcpu_stats(struct netfront_stats);
-	if (np->stats == NULL)
+	np->rx_stats = netdev_alloc_pcpu_stats(struct netfront_stats);
+	if (np->rx_stats == NULL)
+		goto exit;
+	np->tx_stats = netdev_alloc_pcpu_stats(struct netfront_stats);
+	if (np->tx_stats == NULL)
 		goto exit;
 
 	netdev->netdev_ops	= &xennet_netdev_ops;
@@ -1359,7 +1374,7 @@ static struct net_device *xennet_create_
 	return netdev;
 
  exit:
-	free_netdev(netdev);
+	xennet_free_netdev(netdev);
 	return ERR_PTR(err);
 }
 
@@ -1401,7 +1416,7 @@ static int netfront_probe(struct xenbus_
 	return 0;
 
  fail:
-	free_netdev(netdev);
+	xennet_free_netdev(netdev);
 	dev_set_drvdata(&dev->dev, NULL);
 	return err;
 }
@@ -2322,9 +2337,7 @@ static int xennet_remove(struct xenbus_d
 		info->queues = NULL;
 	}
 
-	free_percpu(info->stats);
-
-	free_netdev(info->netdev);
+	xennet_free_netdev(info->netdev);
 
 	return 0;
 }

