Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330799-1519988928-2-14925835136530547453
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519988927; b=myi1Z440OuIk0bQcsv0REh3RPwwrhoJZweYFV4HUPxYoUN5
    6XUYDOhC9u80JQE+V8PrrdUN21yHQyO2KxqPpq32enUigF32Wa5Ns1zUmZXGhuVW
    5O5UFY74Gw8bqOcoyyfDEacN6JABSGcsQzb/UpTSsV87G9t4APfED0CAKAiJQZsO
    ofQ7ppRgmiq8b9tZj7wCc1n/gEGcmjwDmr3Ea8wJtv2TN021MX5TsAb73H/Rpo4g
    //6kFANVUbLD1XRag/ludQVt7cf656OTmH3B1j9GhJueMWROta0bIGt0xEWGBWVJ
    fswaYV7FYoQ9XqDmk1vd+IUoXdmLANOfyX/IHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519988927; bh=Onctbg6hCGlDSatGc5d4LFQhzS
    4zi0fEtxzu988Lrzs=; b=hki3Xd2DN1H/PvEbczgF4vNIiTCDuTcTIDfrsW4bR5
    MF1KQPCo3fiARVlrfvpgkkPk0r4kMAkjnbUSXZBzHu6hG3mHwsD1zo3xghIK7wjd
    OkMsdNS4LWfiI6f9/Grjm6eOgd4+TZaYrLpAwRPIsmL/O2UNjKoWSoBk2SM9buZc
    yvK2E0HnCJ9pAzHJl03Wxd0Qv2/YbnkVYbtm1SOWv+12GG/Le9W4ZH1WS0EGOaFG
    yzMnui3EunD4M2YOp2Z9XatcEqh/Q9W9ueEGf3OE0Oox5Dj7hKdjKMY/L/89DQSd
    VNfXhU2wVXt4k/kbq6XmCFYFcW9nVN+M/V4qh/HZ01pQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423533AbeCBIyj (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:54:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50492 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423524AbeCBIyg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:54:36 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erez Shitrit <erezsh@mellanox.com>,
        Alex Vesker <valex@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 19/34] IB/ipoib: Fix race condition in neigh creation
Date: Fri,  2 Mar 2018 09:51:15 +0100
Message-Id: <20180302084437.207591502@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -844,8 +844,8 @@ static int path_rec_start(struct net_dev
 	return 0;
 }
 
-static void neigh_add_path(struct sk_buff *skb, u8 *daddr,
-			   struct net_device *dev)
+static struct ipoib_neigh *neigh_add_path(struct sk_buff *skb, u8 *daddr,
+					  struct net_device *dev)
 {
 	struct ipoib_dev_priv *priv = netdev_priv(dev);
 	struct ipoib_path *path;
@@ -858,7 +858,15 @@ static void neigh_add_path(struct sk_buf
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
@@ -896,7 +904,7 @@ static void neigh_add_path(struct sk_buf
 			spin_unlock_irqrestore(&priv->lock, flags);
 			ipoib_send(dev, skb, path->ah, IPOIB_QPN(daddr));
 			ipoib_neigh_put(neigh);
-			return;
+			return NULL;
 		}
 	} else {
 		neigh->ah  = NULL;
@@ -913,7 +921,7 @@ static void neigh_add_path(struct sk_buf
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 	ipoib_neigh_put(neigh);
-	return;
+	return NULL;
 
 err_path:
 	ipoib_neigh_free(neigh);
@@ -923,6 +931,8 @@ err_drop:
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 	ipoib_neigh_put(neigh);
+
+	return NULL;
 }
 
 static void unicast_arp_send(struct sk_buff *skb, struct net_device *dev,
@@ -1028,8 +1038,9 @@ static int ipoib_start_xmit(struct sk_bu
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
@@ -775,7 +775,10 @@ void ipoib_mcast_send(struct net_device
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
