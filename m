Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8ECC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D998B206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D998B206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeIKMCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:02:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:38346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726455AbeIKMCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:02:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BD2EAEC6;
        Tue, 11 Sep 2018 07:04:51 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     davem@davemloft.net, boris.ostrovsky@oracle.com,
        Juergen Gross <jgross@suse.com>, stable@vger.kernel.org
Subject: [PATCH] xen/netfront: don't bug in case of too many frags
Date:   Tue, 11 Sep 2018 09:04:48 +0200
Message-Id: <20180911070448.3958-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 57f230ab04d291 ("xen/netfront: raise max number of slots in
xennet_get_responses()") raised the max number of allowed slots by one.
This seems to be problematic in some configurations with netback using
a larger MAX_SKB_FRAGS value (e.g. old Linux kernel with MAX_SKB_FRAGS
defined as 18 instead of nowadays 17).

Instead of BUG_ON() in this case just fall back to retransmission.

Fixes: 57f230ab04d291 ("xen/netfront: raise max number of slots in xennet_get_responses()")
Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/net/xen-netfront.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 9407acbd19a9..f17f602e6171 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -908,7 +908,11 @@ static RING_IDX xennet_fill_frags(struct netfront_queue *queue,
 			BUG_ON(pull_to <= skb_headlen(skb));
 			__pskb_pull_tail(skb, pull_to - skb_headlen(skb));
 		}
-		BUG_ON(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS);
+		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS)) {
+			queue->rx.rsp_cons = ++cons;
+			kfree_skb(nskb);
+			return ~0U;
+		}
 
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 				skb_frag_page(nfrag),
@@ -1045,6 +1049,8 @@ static int xennet_poll(struct napi_struct *napi, int budget)
 		skb->len += rx->status;
 
 		i = xennet_fill_frags(queue, skb, &tmpq);
+		if (unlikely(i == ~0U))
+			goto err;
 
 		if (rx->flags & XEN_NETRXF_csum_blank)
 			skb->ip_summed = CHECKSUM_PARTIAL;
-- 
2.16.4

