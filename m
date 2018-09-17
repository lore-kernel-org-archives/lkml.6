Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3E2ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F95020867
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F95020867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbeIREfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:35:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbeIREfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:35:09 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 02AF5C77;
        Mon, 17 Sep 2018 23:05:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Peter Oskolkov <posk@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Westphal <fw@strlen.de>,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 4.14 111/126] ip: discard IPv4 datagrams with overlapping segments.
Date:   Tue, 18 Sep 2018 00:42:39 +0200
Message-Id: <20180917211711.239007767@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Oskolkov <posk@google.com>

This behavior is required in IPv6, and there is little need
to tolerate overlapping fragments in IPv4. This change
simplifies the code and eliminates potential DDoS attack vectors.

Tested: ran ip_defrag selftest (not yet available uptream).

Suggested-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Peter Oskolkov <posk@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 7969e5c40dfd04799d4341f1b7cd266b6e47f227)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/snmp.h |    1 
 net/ipv4/ip_fragment.c    |   77 +++++++++++-----------------------------------
 net/ipv4/proc.c           |    1 
 3 files changed, 22 insertions(+), 57 deletions(-)

--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -56,6 +56,7 @@ enum
 	IPSTATS_MIB_ECT1PKTS,			/* InECT1Pkts */
 	IPSTATS_MIB_ECT0PKTS,			/* InECT0Pkts */
 	IPSTATS_MIB_CEPKTS,			/* InCEPkts */
+	IPSTATS_MIB_REASM_OVERLAPS,		/* ReasmOverlaps */
 	__IPSTATS_MIB_MAX
 };
 
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -277,6 +277,7 @@ static int ip_frag_reinit(struct ipq *qp
 /* Add new segment to existing queue. */
 static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
 {
+	struct net *net = container_of(qp->q.net, struct net, ipv4.frags);
 	struct sk_buff *prev, *next;
 	struct net_device *dev;
 	unsigned int fragsize;
@@ -357,65 +358,23 @@ static int ip_frag_queue(struct ipq *qp,
 	}
 
 found:
-	/* We found where to put this one.  Check for overlap with
-	 * preceding fragment, and, if needed, align things so that
-	 * any overlaps are eliminated.
+	/* RFC5722, Section 4, amended by Errata ID : 3089
+	 *                          When reassembling an IPv6 datagram, if
+	 *   one or more its constituent fragments is determined to be an
+	 *   overlapping fragment, the entire datagram (and any constituent
+	 *   fragments) MUST be silently discarded.
+	 *
+	 * We do the same here for IPv4.
 	 */
-	if (prev) {
-		int i = (prev->ip_defrag_offset + prev->len) - offset;
 
-		if (i > 0) {
-			offset += i;
-			err = -EINVAL;
-			if (end <= offset)
-				goto err;
-			err = -ENOMEM;
-			if (!pskb_pull(skb, i))
-				goto err;
-			if (skb->ip_summed != CHECKSUM_UNNECESSARY)
-				skb->ip_summed = CHECKSUM_NONE;
-		}
-	}
-
-	err = -ENOMEM;
-
-	while (next && next->ip_defrag_offset < end) {
-		int i = end - next->ip_defrag_offset; /* overlap is 'i' bytes */
-
-		if (i < next->len) {
-			int delta = -next->truesize;
-
-			/* Eat head of the next overlapped fragment
-			 * and leave the loop. The next ones cannot overlap.
-			 */
-			if (!pskb_pull(next, i))
-				goto err;
-			delta += next->truesize;
-			if (delta)
-				add_frag_mem_limit(qp->q.net, delta);
-			next->ip_defrag_offset += i;
-			qp->q.meat -= i;
-			if (next->ip_summed != CHECKSUM_UNNECESSARY)
-				next->ip_summed = CHECKSUM_NONE;
-			break;
-		} else {
-			struct sk_buff *free_it = next;
-
-			/* Old fragment is completely overridden with
-			 * new one drop it.
-			 */
-			next = next->next;
-
-			if (prev)
-				prev->next = next;
-			else
-				qp->q.fragments = next;
-
-			qp->q.meat -= free_it->len;
-			sub_frag_mem_limit(qp->q.net, free_it->truesize);
-			kfree_skb(free_it);
-		}
-	}
+	/* Is there an overlap with the previous fragment? */
+	if (prev &&
+	    (prev->ip_defrag_offset + prev->len) > offset)
+		goto discard_qp;
+
+	/* Is there an overlap with the next fragment? */
+	if (next && next->ip_defrag_offset < end)
+		goto discard_qp;
 
 	/* Note : skb->ip_defrag_offset and skb->dev share the same location */
 	dev = skb->dev;
@@ -463,6 +422,10 @@ found:
 	skb_dst_drop(skb);
 	return -EINPROGRESS;
 
+discard_qp:
+	inet_frag_kill(&qp->q);
+	err = -EINVAL;
+	__IP_INC_STATS(net, IPSTATS_MIB_REASM_OVERLAPS);
 err:
 	kfree_skb(skb);
 	return err;
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -132,6 +132,7 @@ static const struct snmp_mib snmp4_ipext
 	SNMP_MIB_ITEM("InECT1Pkts", IPSTATS_MIB_ECT1PKTS),
 	SNMP_MIB_ITEM("InECT0Pkts", IPSTATS_MIB_ECT0PKTS),
 	SNMP_MIB_ITEM("InCEPkts", IPSTATS_MIB_CEPKTS),
+	SNMP_MIB_ITEM("ReasmOverlaps", IPSTATS_MIB_REASM_OVERLAPS),
 	SNMP_MIB_SENTINEL
 };
 


