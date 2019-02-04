Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40507C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DF42075C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278497;
	bh=1m1pk6iEgsqfDS0+izzv0cgkAkrpYbzWhPUTFrxsmPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1lB2zFisD1tt7KO5xtLqmVF2aj4max4tVlswQ9AwBgYniXY2cwkKL1GFfLJA0iWoK
	 uc0qsRQ4xmtyQyJjJo/o+9wB5PBbrgl2uF3Br1UhcWUpIAuwhPD8QGV0bZ3MaL6X1T
	 q2f60HVhYZI5RI/fLQkl036d9XbV2jaTAqnsc1SY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfBDKl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:41:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:39802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730391AbfBDKlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:41:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81F7B217D6;
        Mon,  4 Feb 2019 10:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276911;
        bh=1m1pk6iEgsqfDS0+izzv0cgkAkrpYbzWhPUTFrxsmPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qB0senRVD6WbJz1atJBd1RYzbCC6HQVk89xh4jmCTsXvogxLtR5LHjdRv28mR73lp
         SLCgAoHSlg3E9jkc+IiUrgX4UywIq3PEdR1oQVEcHXq7Sw+PLLBymnvaye+VfymlC5
         kFXyAuOcgzOvqsoRYypS9MT6NYMDwL7mZuApEMbY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Peter Oskolkov <posk@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Westphal <fw@strlen.de>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Mao Wenan <maowenan@huawei.com>
Subject: [PATCH 4.4 56/65] ip: discard IPv4 datagrams with overlapping segments.
Date:   Mon,  4 Feb 2019 11:36:49 +0100
Message-Id: <20190204103619.834813196@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
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

From: Peter Oskolkov <posk@google.com>

commit 7969e5c40dfd04799d4341f1b7cd266b6e47f227 upstream.

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
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/snmp.h |    1 
 net/ipv4/ip_fragment.c    |   73 ++++++++++++----------------------------------
 net/ipv4/proc.c           |    1 
 3 files changed, 22 insertions(+), 53 deletions(-)

--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -55,6 +55,7 @@ enum
 	IPSTATS_MIB_ECT1PKTS,			/* InECT1Pkts */
 	IPSTATS_MIB_ECT0PKTS,			/* InECT0Pkts */
 	IPSTATS_MIB_CEPKTS,			/* InCEPkts */
+	IPSTATS_MIB_REASM_OVERLAPS,		/* ReasmOverlaps */
 	__IPSTATS_MIB_MAX
 };
 
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -342,6 +342,7 @@ static int ip_frag_reinit(struct ipq *qp
 /* Add new segment to existing queue. */
 static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
 {
+	struct net *net = container_of(qp->q.net, struct net, ipv4.frags);
 	struct sk_buff *prev, *next;
 	struct net_device *dev;
 	unsigned int fragsize;
@@ -422,60 +423,22 @@ static int ip_frag_queue(struct ipq *qp,
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
-		int i = (FRAG_CB(prev)->offset + prev->len) - offset;
-
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
-	while (next && FRAG_CB(next)->offset < end) {
-		int i = end - FRAG_CB(next)->offset; /* overlap is 'i' bytes */
-
-		if (i < next->len) {
-			/* Eat head of the next overlapped fragment
-			 * and leave the loop. The next ones cannot overlap.
-			 */
-			if (!pskb_pull(next, i))
-				goto err;
-			FRAG_CB(next)->offset += i;
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
+	    (FRAG_CB(prev)->offset + prev->len) > offset)
+		goto discard_qp;
+
+	/* Is there an overlap with the next fragment? */
+	if (next && FRAG_CB(next)->offset < end)
+		goto discard_qp;
 
 	FRAG_CB(skb)->offset = offset;
 
@@ -522,6 +485,10 @@ found:
 	skb_dst_drop(skb);
 	return -EINPROGRESS;
 
+discard_qp:
+	ipq_kill(qp);
+	err = -EINVAL;
+	IP_INC_STATS(net, IPSTATS_MIB_REASM_OVERLAPS);
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
 


