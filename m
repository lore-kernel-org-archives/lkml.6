Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20A9C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744A7218A6
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865141;
	bh=ud7hIT5MYrCkil6O+dre7aD8NYXb8chqwjDe6z5Xz7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y7GsDIFjLkI6/ASxYAxPG0E9ya1MkplsjI/Q93LCQ5kb8rkMIeJWc3QEVzA+hr3RI
	 mgumSPb3pHkgnrnBT/p95UWDl9Kx+RkpeKS2CfTr0jguoMpeH5EKDUpMalkNulYKua
	 mA2ZlwVUyP7xHxjF1qgjFDzqT9ExKauw/FAgK3B8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfAGMpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:45:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:34940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728890AbfAGMpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:45:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C678C218A3;
        Mon,  7 Jan 2019 12:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865133;
        bh=ud7hIT5MYrCkil6O+dre7aD8NYXb8chqwjDe6z5Xz7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7smJUFnuZbLz9btFjKn+u/GbCVLEq42h4QGfkdpLPBX0qdGYDXdWsuTVXmTSF/lR
         9jXCgga1JU4kU54l2EXX9amxv9/BJLTIcPtH2iEz+X3oFKMvzWNshpnbpx/dH3VB7U
         vi9ajKuLPyHIY0nDR3WgALgMDxCSvAQNAMAAEOp8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 014/170] net: ipv4: do not handle duplicate fragments as overlapping
Date:   Mon,  7 Jan 2019 13:30:41 +0100
Message-Id: <20190107104454.713483523@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Kubecek <mkubecek@suse.cz>

[ Upstream commit ade446403bfb79d3528d56071a84b15351a139ad ]

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

v2: instead of an exact check iterating through linear list of an rbtree
node, only check if the new fragment is subset of the "run" (suggested
by Eric Dumazet)

Fixes: 7969e5c40dfd ("ip: discard IPv4 datagrams with overlapping segments.")
Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_fragment.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -347,10 +347,10 @@ static int ip_frag_queue(struct ipq *qp,
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
 
@@ -420,7 +420,9 @@ static int ip_frag_queue(struct ipq *qp,
 	 *   overlapping fragment, the entire datagram (and any constituent
 	 *   fragments) MUST be silently discarded.
 	 *
-	 * We do the same here for IPv4 (and increment an snmp counter).
+	 * We do the same here for IPv4 (and increment an snmp counter) but
+	 * we do not want to drop the whole queue in response to a duplicate
+	 * fragment.
 	 */
 
 	/* Find out where to put this fragment.  */
@@ -444,13 +446,17 @@ static int ip_frag_queue(struct ipq *qp,
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
-				goto discard_qp;
+			else if (offset >= skb1->ip_defrag_offset &&
+				 end <= skb1_run_end)
+				goto err; /* No new data, potential duplicate */
+			else
+				goto discard_qp; /* Found an overlap */
 		} while (*rbn);
 		/* Here we have parent properly set, and rbn pointing to
 		 * one of its NULL left/right children. Insert skb.


