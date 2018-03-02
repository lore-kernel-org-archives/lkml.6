Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtfoHlTtHebCRZU5tsVCTSXMfr79ig6DWZueaFgyRfbdbviP1p1MXuund4L9yL6z37QU3w2
ARC-Seal: i=1; a=rsa-sha256; t=1519981370; cv=none;
        d=google.com; s=arc-20160816;
        b=SDyJntLG7JOvBqkSZRmA44BxjLQfzFu7YXuHCGXMC+PkGGDuP98GTOS9OBwjD1Wh7O
         19EZdPMmj+N9wX5JgHm/hlg0NiW776WcgCFn3QeuMohJvhw8kbHSqH5BocKAn3D534l4
         cI87f2O9D1pKNf2RR5JxFpQb6ZVrzrp4NY+jRuKoqm6IZkKVyJibj9S0jIJxbzI8QmTd
         Her8Z5z0Es0N6VoIGh7GFmZfBIBggsf8XR1u4QgnqoaUOZ3/ByBkkHuZ7/J+HaGW6yoE
         50PFJrHiMbdBLXo5WgrqX3qUnWajhGjE2JhtZ7Y6CPBizF9SfUBKoWRR1HIhA3vZ5zV9
         PTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=feqZLO9OnWGgua9Z2O27d9WvlzplHtvQItKzui/ZxTo=;
        b=UBuGxTslkNwYyYkL59kFRhYJTO3SPbz/+e9+FR0FNfNQj3T4YR2dDlBAcBOBlTurwT
         X9DqGYky65KkVIt9p22dofyAMoyPqG5i3GxCXuEtuseuA+gjkBKTnRcYaK+dQPPrgQFm
         c91r8wp1psxDBZtqud1Tc0CcW0iRBWW86PVZyTLPoJ3Qruq990rabJT90427hakGwRNl
         w5Y32I/SSqseD27LH/Qu+57VPtNyj26ToZKVS2WFoCPkTBGWP9J6x4Wqumadj1bD1R+s
         unaMCGgFcTGDs4cadxdtJ3D8jnjM+m8p8taiDVgXOvEa9Wt4kUl/ryjxSaV4QMEoPKuF
         7CdQ==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 071/115] IB/ipoib: Fix race condition in neigh creation
Date: Fri,  2 Mar 2018 09:51:14 +0100
Message-Id: <20180302084506.736021770@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815468895692685?=
X-GMAIL-MSGID: =?utf-8?q?1593815986160347529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |   25 ++++++++++++++++++-------
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |    5 ++++-
 2 files changed, 22 insertions(+), 8 deletions(-)

--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -903,8 +903,8 @@ static int path_rec_start(struct net_dev
 	return 0;
 }
 
-static void neigh_add_path(struct sk_buff *skb, u8 *daddr,
-			   struct net_device *dev)
+static struct ipoib_neigh *neigh_add_path(struct sk_buff *skb, u8 *daddr,
+					  struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 	struct rdma_netdev *rn = netdev_priv(dev);
@@ -918,7 +918,15 @@ static void neigh_add_path(struct sk_buf
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
@@ -957,7 +965,7 @@ static void neigh_add_path(struct sk_buf
 			path->ah->last_send = rn->send(dev, skb, path->ah->ah,
 						       IPOIB_QPN(daddr));
 			ipoib_neigh_put(neigh);
-			return;
+			return NULL;
 		}
 	} else {
 		neigh->ah  = NULL;
@@ -974,7 +982,7 @@ static void neigh_add_path(struct sk_buf
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 	ipoib_neigh_put(neigh);
-	return;
+	return NULL;
 
 err_path:
 	ipoib_neigh_free(neigh);
@@ -984,6 +992,8 @@ err_drop:
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 	ipoib_neigh_put(neigh);
+
+	return NULL;
 }
 
 static void unicast_arp_send(struct sk_buff *skb, struct net_device *dev,
@@ -1092,8 +1102,9 @@ static int ipoib_start_xmit(struct sk_bu
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
@@ -816,7 +816,10 @@ void ipoib_mcast_send(struct net_device
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
