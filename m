Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822EEC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5285E20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5285E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeLIWLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:11:37 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37710 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728257AbeLIWLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:11:35 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW735-0002iY-0J; Sun, 09 Dec 2018 21:55:39 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72g-0003Vu-Kk; Sun, 09 Dec 2018 21:55:14 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ira Weiny" <ira.weiny@intel.com>,
        "Aaron Knister" <aaron.s.knister@nasa.gov>,
        "Jason Gunthorpe" <jgg@mellanox.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.367793181@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 210/328] IB/ipoib: Avoid a race condition between
 start_xmit and cm_rep_handler
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Knister <aaron.s.knister@nasa.gov>

commit 816e846c2eb9129a3e0afa5f920c8bbc71efecaa upstream.

Inside of start_xmit() the call to check if the connection is up and the
queueing of the packets for later transmission is not atomic which leaves
a window where cm_rep_handler can run, set the connection up, dequeue
pending packets and leave the subsequently queued packets by start_xmit()
sitting on neigh->queue until they're dropped when the connection is torn
down. This only applies to connected mode. These dropped packets can
really upset TCP, for example, and cause multi-minute delays in
transmission for open connections.

Here's the code in start_xmit where we check to see if the connection is
up:

       if (ipoib_cm_get(neigh)) {
               if (ipoib_cm_up(neigh)) {
                       ipoib_cm_send(dev, skb, ipoib_cm_get(neigh));
                       goto unref;
               }
       }

The race occurs if cm_rep_handler execution occurs after the above
connection check (specifically if it gets to the point where it acquires
priv->lock to dequeue pending skb's) but before the below code snippet in
start_xmit where packets are queued.

       if (skb_queue_len(&neigh->queue) < IPOIB_MAX_PATH_REC_QUEUE) {
               push_pseudo_header(skb, phdr->hwaddr);
               spin_lock_irqsave(&priv->lock, flags);
               __skb_queue_tail(&neigh->queue, skb);
               spin_unlock_irqrestore(&priv->lock, flags);
       } else {
               ++dev->stats.tx_dropped;
               dev_kfree_skb_any(skb);
       }

The patch acquires the netif tx lock in cm_rep_handler for the section
where it sets the connection up and dequeues and retransmits deferred
skb's.

Fixes: 839fcaba355a ("IPoIB: Connected mode experimental support")
Signed-off-by: Aaron Knister <aaron.s.knister@nasa.gov>
Tested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/ulp/ipoib/ipoib_cm.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -996,12 +996,14 @@ static int ipoib_cm_rep_handler(struct i
 
 	skb_queue_head_init(&skqueue);
 
+	netif_tx_lock_bh(p->dev);
 	spin_lock_irq(&priv->lock);
 	set_bit(IPOIB_FLAG_OPER_UP, &p->flags);
 	if (p->neigh)
 		while ((skb = __skb_dequeue(&p->neigh->queue)))
 			__skb_queue_tail(&skqueue, skb);
 	spin_unlock_irq(&priv->lock);
+	netif_tx_unlock_bh(p->dev);
 
 	while ((skb = __skb_dequeue(&skqueue))) {
 		skb->dev = p->dev;

