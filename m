Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B31DC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB4620870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB4620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeLMC2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:28:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:51162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726381AbeLMC2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:28:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 459C3ABE2;
        Thu, 13 Dec 2018 02:28:01 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 9D298E1116; Thu, 13 Dec 2018 03:28:00 +0100 (CET)
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net] net: ipv4: do not handle duplicate fragments as
 overlapping
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Oskolkov <posk@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Gustavo Figueira <gfigueira@suse.com>
Message-Id: <20181213022800.9D298E1116@unicorn.suse.cz>
Date:   Thu, 13 Dec 2018 03:28:00 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7969e5c40dfd ("ip: discard IPv4 datagrams with overlapping
segments.") IPv4 reassembly code drops the whole queue whenever an
overlapping fragment is received. However, the test is written in a way
which detects duplicate fragments as overlapping so that in environments
with many duplicate packets, fragmented packets may be undeliverable.

Add an extra test and for (potentially) duplicate fragment, only drop the
new fragment rather than the whole queue. Only starting offset and length
are checked, not the contents of the fragments as that would be too
expensive.  Check for duplicity with last (tail) fragment first as in real
life scenarios this should be the most frequent case and we would have to
iterate through the whole "run" otherwise.

Fixes: 7969e5c40dfd ("ip: discard IPv4 datagrams with overlapping segments.")
Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 net/ipv4/ip_fragment.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index aa0b22697998..f09e3683b209 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -436,6 +436,10 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
 			ip4_frag_append_to_last_run(&qp->q, skb);
 		else
 			ip4_frag_create_run(&qp->q, skb);
+	} else if (offset == prev_tail->ip_defrag_offset &&
+		   skb->len == prev_tail->len) {
+		/* potential duplicate of last fragment */
+		goto err;
 	} else {
 		/* Binary search. Note that skb can become the first fragment,
 		 * but not the last (covered above).
@@ -449,8 +453,16 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
 			else if (offset >= skb1->ip_defrag_offset +
 						FRAG_CB(skb1)->frag_run_len)
 				rbn = &parent->rb_right;
-			else /* Found an overlap with skb1. */
+			else {
+				/* check for potential duplicate */
+				while (skb1 && skb1->ip_defrag_offset < offset)
+					skb1 = FRAG_CB(skb1)->next_frag;
+				if (skb1 && offset == skb1->ip_defrag_offset &&
+				    skb->len == skb1->len)
+					goto err;
+				/* Found an overlap */
 				goto overlap;
+			}
 		} while (*rbn);
 		/* Here we have parent properly set, and rbn pointing to
 		 * one of its NULL left/right children. Insert skb.
-- 
2.19.2

