Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbeCEWFj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:05:39 -0500
Received: from gateway33.websitewelcome.com ([192.185.145.190]:39163 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753067AbeCEWFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:05:38 -0500
Date: Mon, 5 Mar 2018 16:05:37 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] caif_dev: use true and false for boolean values
Message-ID: <20180305220537.GA15924@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.245.224
X-Source-L: No
X-Exim-ID: 1esyEj-002CHP-6k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-245-224.static.axtel.net (embeddedor) [187.162.245.224]:41312
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 net/caif/caif_dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/caif/caif_dev.c b/net/caif/caif_dev.c
index e0adcd1..f2848d6 100644
--- a/net/caif/caif_dev.c
+++ b/net/caif/caif_dev.c
@@ -139,7 +139,7 @@ static void caif_flow_cb(struct sk_buff *skb)
 
 	spin_lock_bh(&caifd->flow_lock);
 	send_xoff = caifd->xoff;
-	caifd->xoff = 0;
+	caifd->xoff = false;
 	dtor = caifd->xoff_skb_dtor;
 
 	if (WARN_ON(caifd->xoff_skb != skb))
@@ -213,7 +213,7 @@ static int transmit(struct cflayer *layer, struct cfpkt *pkt)
 	pr_debug("queue has stopped(%d) or is full (%d > %d)\n",
 			netif_queue_stopped(caifd->netdev),
 			qlen, high);
-	caifd->xoff = 1;
+	caifd->xoff = true;
 	caifd->xoff_skb = skb;
 	caifd->xoff_skb_dtor = skb->destructor;
 	skb->destructor = caif_flow_cb;
@@ -400,7 +400,7 @@ static int caif_device_notify(struct notifier_block *me, unsigned long what,
 			break;
 		}
 
-		caifd->xoff = 0;
+		caifd->xoff = false;
 		cfcnfg_set_phy_state(cfg, &caifd->layer, true);
 		rcu_read_unlock();
 
@@ -435,7 +435,7 @@ static int caif_device_notify(struct notifier_block *me, unsigned long what,
 		if (caifd->xoff_skb_dtor != NULL && caifd->xoff_skb != NULL)
 			caifd->xoff_skb->destructor = caifd->xoff_skb_dtor;
 
-		caifd->xoff = 0;
+		caifd->xoff = false;
 		caifd->xoff_skb_dtor = NULL;
 		caifd->xoff_skb = NULL;
 
-- 
2.7.4
