Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeE3LXC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:23:02 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60961 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752496AbeE3LHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:06 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Jakub Kicinski" <jakub.kicinski@netronome.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.438311529@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 088/153] net: fix race on decreasing number of TX queues
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <jakub.kicinski@netronome.com>

commit ac5b70198adc25c73fba28de4f78adcee8f6be0b upstream.

netif_set_real_num_tx_queues() can be called when netdev is up.
That usually happens when user requests change of number of
channels/rings with ethtool -L.  The procedure for changing
the number of queues involves resetting the qdiscs and setting
dev->num_tx_queues to the new value.  When the new value is
lower than the old one, extra care has to be taken to ensure
ordering of accesses to the number of queues vs qdisc reset.

Currently the queues are reset before new dev->num_tx_queues
is assigned, leaving a window of time where packets can be
enqueued onto the queues going down, leading to a likely
crash in the drivers, since most drivers don't check if TX
skbs are assigned to an active queue.

Fixes: e6484930d7c7 ("net: allocate tx queues in register_netdevice")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1750,8 +1750,11 @@ static void netif_setup_tc(struct net_de
  */
 int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 {
+	bool disabling;
 	int rc;
 
+	disabling = txq < dev->real_num_tx_queues;
+
 	if (txq < 1 || txq > dev->num_tx_queues)
 		return -EINVAL;
 
@@ -1767,11 +1770,16 @@ int netif_set_real_num_tx_queues(struct
 		if (dev->num_tc)
 			netif_setup_tc(dev, txq);
 
-		if (txq < dev->real_num_tx_queues)
+		dev->real_num_tx_queues = txq;
+
+		if (disabling) {
+			synchronize_net();
 			qdisc_reset_all_tx_gt(dev, txq);
+		}
+	} else {
+		dev->real_num_tx_queues = txq;
 	}
 
-	dev->real_num_tx_queues = txq;
 	return 0;
 }
 EXPORT_SYMBOL(netif_set_real_num_tx_queues);
