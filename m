Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4581BC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AC42087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AC42087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbeLMQXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:23:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:37384 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728059AbeLMQXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:23:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 939E3AF0D;
        Thu, 13 Dec 2018 16:23:33 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id E426FE1116; Thu, 13 Dec 2018 17:23:32 +0100 (CET)
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net v2] net: ipv4: do not handle duplicate fragments as
 overlapping
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Oskolkov <posk@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Gustavo Figueira <gfigueira@suse.com>
Message-Id: <20181213162332.E426FE1116@unicorn.suse.cz>
Date:   Thu, 13 Dec 2018 17:23:32 +0100 (CET)
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
expensive. For similar reason, linear list ("run") of a rbtree node is not
iterated, we only check if the new fragment is a subset of the interval
covered by existing consecutive fragments.

Fixes: 7969e5c40dfd ("ip: discard IPv4 datagrams with overlapping segments.")
Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

v2: instead of an exact check iterating through linear list of an rbtree
node, only check if the new fragment is subset of the "run" (suggested
by Eric Dumazet)
---
 net/ipv4/ip_fragment.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index aa0b22697998..867be8f7f1fa 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -346,10 +346,10 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
 	struct net *net = container_of(qp->q.net, struct net, ipv4.frags);
 	struct rb_node **rbn, *parent;
 	struct sk_buff *skb1, *prev_tail;
+	int ihl, end, skb1_run_end;
 	struct net_device *dev;
 	unsigned int fragsize;
 	int flags, offset;
-	int ihl, end;
 	int err = -ENOENT;
 	u8 ecn;
 
@@ -419,7 +419,9 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
 	 *   overlapping fragment, the entire datagram (and any constituent
 	 *   fragments) MUST be silently discarded.
 	 *
-	 * We do the same here for IPv4 (and increment an snmp counter).
+	 * We do the same here for IPv4 (and increment an snmp counter) but
+	 * we do not want to drop the whole queue in response to a duplicate
+	 * fragment.
 	 */
 
 	err = -EINVAL;
@@ -444,13 +446,17 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
 		do {
 			parent = *rbn;
 			skb1 = rb_to_skb(parent);
+			skb1_run_end = skb1->ip_defrag_offset +
+				       FRAG_CB(skb1)->frag_run_len;
 			if (end <= skb1->ip_defrag_offset)
 				rbn = &parent->rb_left;
-			else if (offset >= skb1->ip_defrag_offset +
-						FRAG_CB(skb1)->frag_run_len)
+			else if (offset >= skb1_run_end)
 				rbn = &parent->rb_right;
-			else /* Found an overlap with skb1. */
-				goto overlap;
+			else if (offset >= skb1->ip_defrag_offset &&
+				 end <= skb1_run_end)
+				goto err; /* No new data, potential duplicate */
+			else
+				goto overlap; /* Found an overlap */
 		} while (*rbn);
 		/* Here we have parent properly set, and rbn pointing to
 		 * one of its NULL left/right children. Insert skb.
-- 
2.19.2

