Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE96C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A24221907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539847;
	bh=1q6ACRP4drC5sRnQIE1+3l8VTZnWbOW28my+CDcCFCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZJYMXaaEzhoTAck5CY8tU0qbxSqiBBqrL8Ci0T4FqoHVkYxXYpx8HJ6usygJshy8W
	 1JgtK3NYjvZOlhl0ylaj/GXKRmbvfeZXXu0wzyvc33V9wpa3JnIaLpnGhWjIU/CPx4
	 Ksu76jdP4d38dqzcnTKULlX0eGLhLcNoeIuqpvH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfBGLoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:44:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbfBGLoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:44:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C98FD2080A;
        Thu,  7 Feb 2019 11:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539842;
        bh=1q6ACRP4drC5sRnQIE1+3l8VTZnWbOW28my+CDcCFCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7vkpUcInwf71H/lFFJmXbcjEIcz+VzsoYXRr0lREzt0iI+2Ww6E4JYKQ4NHtxxLz
         +93kxcA68xcJNXu/ftr36Et5ZeYZ9mnTQGjGiiPMzxMbqzo+U2CiPRkUrRKPqt4eui
         6H/s9R4+CaIyKALM+pj7Jt1ABURXki/H7qailgWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>,
        Mao Wenan <maowenan@huawei.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 33/34] net: ipv4: do not handle duplicate fragments as overlapping
Date:   Thu,  7 Feb 2019 12:42:15 +0100
Message-Id: <20190207113026.832381171@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207113025.552605181@linuxfoundation.org>
References: <20190207113025.552605181@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Kubecek <mkubecek@suse.cz>

commit ade446403bfb79d3528d56071a84b15351a139ad upstream.

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
Signed-off-by: Mao Wenan <maowenan@huawei.com>
[bwh: Backported to 4.4:
 - goto discard_qp, not err, in case of overlap
 - Set err earlier variable, as done upstream in commit 0ff89efb5246
   "ip: fail fast on IP defrag errors"]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_fragment.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

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
 
@@ -420,9 +420,12 @@ static int ip_frag_queue(struct ipq *qp,
 	 *   overlapping fragment, the entire datagram (and any constituent
 	 *   fragments) MUST be silently discarded.
 	 *
-	 * We do the same here for IPv4 (and increment an snmp counter).
+	 * We do the same here for IPv4 (and increment an snmp counter) but
+	 * we do not want to drop the whole queue in response to a duplicate
+	 * fragment.
 	 */
 
+	err = -EINVAL;
 	/* Find out where to put this fragment.  */
 	prev_tail = qp->q.fragments_tail;
 	if (!prev_tail)
@@ -444,13 +447,17 @@ static int ip_frag_queue(struct ipq *qp,
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
@@ -495,7 +502,6 @@ static int ip_frag_queue(struct ipq *qp,
 
 discard_qp:
 	inet_frag_kill(&qp->q);
-	err = -EINVAL;
 	IP_INC_STATS_BH(net, IPSTATS_MIB_REASM_OVERLAPS);
 err:
 	kfree_skb(skb);


