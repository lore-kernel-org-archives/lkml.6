Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D180EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942D4208A6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942D4208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390645AbeHATjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:39:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49812 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406017AbeHATIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:41 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 40A8C1357;
        Wed,  1 Aug 2018 17:13:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 021/246] xen/netfront: raise max number of slots in xennet_get_responses()
Date:   Wed,  1 Aug 2018 18:48:51 +0200
Message-Id: <20180801165012.715542128@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

[ Upstream commit 57f230ab04d2910a06d17d988f1c4d7586a59113 ]

The max number of slots used in xennet_get_responses() is set to
MAX_SKB_FRAGS + (rx->status <= RX_COPY_THRESHOLD).

In old kernel-xen MAX_SKB_FRAGS was 18, while nowadays it is 17. This
difference is resulting in frequent messages "too many slots" and a
reduced network throughput for some workloads (factor 10 below that of
a kernel-xen based guest).

Replacing MAX_SKB_FRAGS by XEN_NETIF_NR_SLOTS_MIN for calculation of
the max number of slots to use solves that problem (tests showed no
more messages "too many slots" and throughput was as high as with the
kernel-xen based guest system).

Replace MAX_SKB_FRAGS-2 by XEN_NETIF_NR_SLOTS_MIN-1 in
netfront_tx_slot_available() for making it clearer what is really being
tested without actually modifying the tested value.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/xen-netfront.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -239,7 +239,7 @@ static void rx_refill_timeout(unsigned l
 static int netfront_tx_slot_available(struct netfront_queue *queue)
 {
 	return (queue->tx.req_prod_pvt - queue->tx.rsp_cons) <
-		(NET_TX_RING_SIZE - MAX_SKB_FRAGS - 2);
+		(NET_TX_RING_SIZE - XEN_NETIF_NR_SLOTS_MIN - 1);
 }
 
 static void xennet_maybe_wake_tx(struct netfront_queue *queue)
@@ -790,7 +790,7 @@ static int xennet_get_responses(struct n
 	RING_IDX cons = queue->rx.rsp_cons;
 	struct sk_buff *skb = xennet_get_rx_skb(queue, cons);
 	grant_ref_t ref = xennet_get_rx_ref(queue, cons);
-	int max = MAX_SKB_FRAGS + (rx->status <= RX_COPY_THRESHOLD);
+	int max = XEN_NETIF_NR_SLOTS_MIN + (rx->status <= RX_COPY_THRESHOLD);
 	int slots = 1;
 	int err = 0;
 	unsigned long ret;


