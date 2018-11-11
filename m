Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E135C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8962080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8962080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbeKLGF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:05:58 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53168 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731143AbeKLGF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:05:57 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt8-0000l4-K7; Sun, 11 Nov 2018 19:59:18 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001Rz-Rl; Sun, 11 Nov 2018 19:58:33 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Evgenii Smirnov" <evgenii.smirnov@profitbricks.com>,
        "Doug Ledford" <dledford@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.361146864@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 074/366] RDMA/ipoib: Update paths on CLIENT_REREG/SM_CHANGE
 events
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

From: Doug Ledford <dledford@redhat.com>

commit fa9391dbad4b868512ed22a7e41765f881a8a935 upstream.

We do a light flush on CLIENT_REREG and SM_CHANGE events.  This goes
through and marks paths invalid. But we weren't always checking for this
validity when we needed to, and so we could keep using a path marked
invalid.  What's more, once we establish a path with a valid ah, we put
a pointer to the ah in the neigh struct directly, so even if we mark the
path as invalid, as long as the neigh has a direct pointer to the ah, it
keeps using the old, outdated ah.

To fix this we do several things.

1) Put the valid flag in the ah instead of the path struct, so when we
put the ah pointer directly in the neigh struct, we can easily check the
validity of the ah on send events.
2) Check the neigh->ah and neigh->ah->valid elements in the needed
places, and if we have an ah, but it's invalid, then invoke a refresh of
the ah.
3) Fix the various places that check for path, but didn't check for
path->valid (now path->ah && path->ah->valid).

Reported-by: Evgenii Smirnov <evgenii.smirnov@profitbricks.com>
Fixes: ee1e2c82c245 ("IPoIB: Refresh paths instead of flushing them on SM change events")
Signed-off-by: Doug Ledford <dledford@redhat.com>
[bwh: Backported to 3.16:
 - s/phdr->hwaddr/cb->hdwaddr/
 - s/ipoib_priv/netdev_priv/
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/ulp/ipoib/ipoib.h      |  2 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 33 ++++++++++++++++++-----
 2 files changed, 28 insertions(+), 7 deletions(-)

--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -384,6 +384,7 @@ struct ipoib_ah {
 	struct list_head   list;
 	struct kref	   ref;
 	unsigned	   last_send;
+	int  		   valid;
 };
 
 struct ipoib_path {
@@ -400,7 +401,6 @@ struct ipoib_path {
 
 	struct rb_node	      rb_node;
 	struct list_head      list;
-	int  		      valid;
 };
 
 struct ipoib_neigh {
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -426,7 +426,8 @@ void ipoib_mark_paths_invalid(struct net
 		ipoib_dbg(priv, "mark path LID 0x%04x GID %pI6 invalid\n",
 			be16_to_cpu(path->pathrec.dlid),
 			path->pathrec.dgid.raw);
-		path->valid =  0;
+		if (path->ah)
+			path->ah->valid = 0;
 	}
 
 	spin_unlock_irq(&priv->lock);
@@ -535,7 +536,7 @@ static void path_rec_completion(int stat
 			while ((skb = __skb_dequeue(&neigh->queue)))
 				__skb_queue_tail(&skqueue, skb);
 		}
-		path->valid = 1;
+		path->ah->valid = 1;
 	}
 
 	path->query = NULL;
@@ -615,6 +616,24 @@ static int path_rec_start(struct net_dev
 	return 0;
 }
 
+static void neigh_refresh_path(struct ipoib_neigh *neigh, u8 *daddr,
+			       struct net_device *dev)
+{
+	struct ipoib_dev_priv *priv = netdev_priv(dev);
+	struct ipoib_path *path;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	path = __path_find(dev, daddr + 4);
+	if (!path)
+		goto out;
+	if (!path->query)
+		path_rec_start(dev, path);
+out:
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
 static struct ipoib_neigh *neigh_add_path(struct sk_buff *skb, u8 *daddr,
 					  struct net_device *dev)
 {
@@ -651,7 +670,7 @@ static struct ipoib_neigh *neigh_add_pat
 
 	list_add_tail(&neigh->list, &path->neigh_list);
 
-	if (path->ah) {
+	if (path->ah && path->ah->valid) {
 		kref_get(&path->ah->ref);
 		neigh->ah = path->ah;
 
@@ -710,7 +729,7 @@ static void unicast_arp_send(struct sk_b
 	spin_lock_irqsave(&priv->lock, flags);
 
 	path = __path_find(dev, cb->hwaddr + 4);
-	if (!path || !path->valid) {
+	if (!path || !path->ah || !path->ah->valid) {
 		int new_path = 0;
 
 		if (!path) {
@@ -736,7 +755,7 @@ static void unicast_arp_send(struct sk_b
 		return;
 	}
 
-	if (path->ah) {
+	if (path->ah && path->ah->valid) {
 		ipoib_dbg(priv, "Send unicast ARP to %04x\n",
 			  be16_to_cpu(path->pathrec.dlid));
 
@@ -818,9 +837,11 @@ send_using_neigh:
 			ipoib_cm_send(dev, skb, ipoib_cm_get(neigh));
 			goto unref;
 		}
-	} else if (neigh->ah) {
+	} else if (neigh->ah && neigh->ah->valid) {
 		ipoib_send(dev, skb, neigh->ah, IPOIB_QPN(cb->hwaddr));
 		goto unref;
+	} else if (neigh->ah) {
+		neigh_refresh_path(neigh, cb->hwaddr, dev);
 	}
 
 	if (skb_queue_len(&neigh->queue) < IPOIB_MAX_PATH_REC_QUEUE) {

