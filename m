Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELss9DdKYxX7gGMj1hSfqGj5mle7qYmJc3aXjgxrJSI5/W24wpgHagWSrHtKl2EFOhA/1k1M
ARC-Seal: i=1; a=rsa-sha256; t=1519981049; cv=none;
        d=google.com; s=arc-20160816;
        b=O34oPA2KAHePxAoQl4uCHQeA5SLZpJT8KQyzGqCYNVHApNwpjsvZQ3W3FWCTBCvQD2
         I3A3RxnhxqTNqG3wsE10tRdhDtTiQ1FZuAMeeAPQVlAojuJiCT4Kb9GxQ+93uiR3LNzd
         WN6BA3R+oJMF28s4njK1/H1Yw9UsDo+4CTY9NRxDoCJSPdPleThvySBJvLpoOVR2kdpP
         rYy8IM05qGE954hWa3fpvrBdXoFu7+LeJGrrmNRWuSvhsLiKSqDFnhSoE0yiaUvBvcem
         hJWhZ1dPGkvCQXRx8vVlh2CS3vxHQs0SLRNBo3fNTbIWBjeCNOM1GNizGUjdx4Db49m+
         Gtcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=E2WvOfoOSDeHj+Jw0zMowJGCmw2Hq0SiOsHoUHj0w0c=;
        b=JvbrbPYnwL9rFNwGjI6Ny1XsztXxJuG5qs/SlZDMFkk+eBqwkXx1yz4M2TIK87ET+A
         INy5tRy76GR5sqIhzc19A5As6OehVqA2cQ7K+Qqt7eujbxuhUGoeU9Ou2cl06/YS2O/t
         qJmJ0D1/OASlvOWRtnmIK5ZDIXSlZyVylx8xacz4NkWGI2R6+Thdt6CsucCMACwxphda
         T4f/FQuZEPWFzn2YYKVCtI4+QO5CxuM1NAIEpLIXitkSyc6mkUjJ8qddA3sKWAyFdDCF
         zx0BPqU+AcRvxuxJHv8HYM4f2NbtkovghCRCB5/5q1bUFykYSZn18bbk9rHtbOG0lIFD
         KLyw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Erez Shitrit <erezsh@mellanox.com>,
	Alex Vesker <valex@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 35/56] IB/ipoib: Fix race condition in neigh creation
Date: Fri,  2 Mar 2018 09:51:21 +0100
Message-Id: <20180302084451.354951334@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815468895692685?=
X-GMAIL-MSGID: =?utf-8?q?1593815649192063212?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erez Shitrit <erezsh@mellanox.com>


[ Upstream commit 16ba3defb8bd01a9464ba4820a487f5b196b455b ]

When using enhanced mode for IPoIB, two threads may execute xmit in
parallel to two different TX queues while the target is the same.
In this case, both of them will add the same neighbor to the path's
neigh link list and we might see the following message:

  list_add double add: new=ffff88024767a348, prev=ffff88024767a348...
  WARNING: lib/list_debug.c:31__list_add_valid+0x4e/0x70
  ipoib_start_xmit+0x477/0x680 [ib_ipoib]
  dev_hard_start_xmit+0xb9/0x3e0
  sch_direct_xmit+0xf9/0x250
  __qdisc_run+0x176/0x5d0
  __dev_queue_xmit+0x1f5/0xb10
  __dev_queue_xmit+0x55/0xb10

Analysis:
Two SKB are scheduled to be transmitted from two cores.
In ipoib_start_xmit, both gets NULL when calling ipoib_neigh_get.
Two calls to neigh_add_path are made. One thread takes the spin-lock
and calls ipoib_neigh_alloc which creates the neigh structure,
then (after the __path_find) the neigh is added to the path's neigh
link list. When the second thread enters the critical section it also
calls ipoib_neigh_alloc but in this case it gets the already allocated
ipoib_neigh structure, which is already linked to the path's neigh
link list and adds it again to the list. Which beside of triggering
the list, it creates a loop in the linked list. This loop leads to
endless loop inside path_rec_completion.

Solution:
Check list_empty(&neigh->list) before adding to the list.
Add a similar fix in "ipoib_multicast.c::ipoib_mcast_send"

Fixes: b63b70d87741 ('IPoIB: Use a private hash table for path lookup in xmit path')
Signed-off-by: Erez Shitrit <erezsh@mellanox.com>
Reviewed-by: Alex Vesker <valex@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |   25 ++++++++++++++++++-------
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    5 ++++-
 2 files changed, 22 insertions(+), 8 deletions(-)

--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -919,8 +919,8 @@ static int path_rec_start(struct net_dev
 	return 0;
 }
 
-static void neigh_add_path(struct sk_buff *skb, u8 *daddr,
-			   struct net_device *dev)
+static struct ipoib_neigh *neigh_add_path(struct sk_buff *skb, u8 *daddr,
+					  struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	struct ipoib_path *path;
@@ -933,7 +933,15 @@ static void neigh_add_path(struct sk_buf
 		spin_unlock_irqrestore(&priv->lock, flags);
 		++dev->stats.tx_dropped;
 		dev_kfree_skb_any(skb);
-		return;
+		return NULL;
+	}
+
+	/* To avoid race condition, make sure that the
+	 * neigh will be added only once.
+	 */
+	if (unlikely(!list_empty(&neigh->list))) {
+		spin_unlock_irqrestore(&priv->lock, flags);
+		return neigh;
 	}
 
 	path = __path_find(dev, daddr + 4);
@@ -971,7 +979,7 @@ static void neigh_add_path(struct sk_buf
 			spin_unlock_irqrestore(&priv->lock, flags);
 			ipoib_send(dev, skb, path->ah, IPOIB_QPN(daddr));
 			ipoib_neigh_put(neigh);
-			return;
+			return NULL;
 		}
 	} else {
 		neigh->ah  = NULL;
@@ -988,7 +996,7 @@ static void neigh_add_path(struct sk_buf
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 	ipoib_neigh_put(neigh);
-	return;
+	return NULL;
 
 err_path:
 	ipoib_neigh_free(neigh);
@@ -998,6 +1006,8 @@ err_drop:
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 	ipoib_neigh_put(neigh);
+
+	return NULL;
 }
 
 static void unicast_arp_send(struct sk_buff *skb, struct net_device *dev,
@@ -1103,8 +1113,9 @@ static int ipoib_start_xmit(struct sk_bu
 	case htons(ETH_P_TIPC):
 		neigh = ipoib_neigh_get(dev, phdr->hwaddr);
 		if (unlikely(!neigh)) {
-			neigh_add_path(skb, phdr->hwaddr, dev);
-			return NETDEV_TX_OK;
+			neigh = neigh_add_path(skb, phdr->hwaddr, dev);
+			if (likely(!neigh))
+				return NETDEV_TX_OK;
 		}
 		break;
 	case htons(ETH_P_ARP):
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -818,7 +818,10 @@ void ipoib_mcast_send(struct net_device
 		spin_lock_irqsave(&priv->lock, flags);
 		if (!neigh) {
 			neigh = ipoib_neigh_alloc(daddr, dev);
-			if (neigh) {
+			/* Make sure that the neigh will be added only
+			 * once to mcast list.
+			 */
+			if (neigh && list_empty(&neigh->list)) {
 				kref_get(&mcast->ah->ref);
 				neigh->ah	= mcast->ah;
 				list_add_tail(&neigh->list, &mcast->neigh_list);
