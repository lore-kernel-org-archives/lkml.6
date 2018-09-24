Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69610C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E16520833
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E16520833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbeIXR51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:57:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51900 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbeIXR51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:57:27 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 35FF41072;
        Mon, 24 Sep 2018 11:55:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Knister <aaron.s.knister@nasa.gov>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.4 32/70] IB/ipoib: Avoid a race condition between start_xmit and cm_rep_handler
Date:   Mon, 24 Sep 2018 13:52:31 +0200
Message-Id: <20180924113102.437212825@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113058.420454070@linuxfoundation.org>
References: <20180924113058.420454070@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Knister <aaron.s.knister@nasa.gov>
Tested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/ipoib/ipoib_cm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -992,12 +992,14 @@ static int ipoib_cm_rep_handler(struct i
 
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


