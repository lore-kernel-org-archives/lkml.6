Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA043C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6B921EA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6B921EA2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbeHIRHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:07:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:45948 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730419AbeHIRHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:07:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B0271ACD8;
        Thu,  9 Aug 2018 14:42:19 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        netdev@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, davem@davemloft.net,
        Juergen Gross <jgross@suse.com>, stable@vger.kernel.org
Subject: [PATCH] xen/netfront: don't cache skb_shinfo()
Date:   Thu,  9 Aug 2018 16:42:16 +0200
Message-Id: <20180809144216.18856-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb_shinfo() can change when calling __pskb_pull_tail(): Don't cache
its return value.

Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/net/xen-netfront.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 2d8812dd1534..9dd2ca62d84a 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -894,7 +894,6 @@ static RING_IDX xennet_fill_frags(struct netfront_queue *queue,
 				  struct sk_buff *skb,
 				  struct sk_buff_head *list)
 {
-	struct skb_shared_info *shinfo = skb_shinfo(skb);
 	RING_IDX cons = queue->rx.rsp_cons;
 	struct sk_buff *nskb;
 
@@ -903,15 +902,16 @@ static RING_IDX xennet_fill_frags(struct netfront_queue *queue,
 			RING_GET_RESPONSE(&queue->rx, ++cons);
 		skb_frag_t *nfrag = &skb_shinfo(nskb)->frags[0];
 
-		if (shinfo->nr_frags == MAX_SKB_FRAGS) {
+		if (skb_shinfo(skb)->nr_frags == MAX_SKB_FRAGS) {
 			unsigned int pull_to = NETFRONT_SKB_CB(skb)->pull_to;
 
 			BUG_ON(pull_to <= skb_headlen(skb));
 			__pskb_pull_tail(skb, pull_to - skb_headlen(skb));
 		}
-		BUG_ON(shinfo->nr_frags >= MAX_SKB_FRAGS);
+		BUG_ON(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS);
 
-		skb_add_rx_frag(skb, shinfo->nr_frags, skb_frag_page(nfrag),
+		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+				skb_frag_page(nfrag),
 				rx->offset, rx->status, PAGE_SIZE);
 
 		skb_shinfo(nskb)->nr_frags = 0;
-- 
2.13.7

