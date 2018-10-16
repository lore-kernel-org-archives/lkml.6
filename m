Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8506BC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DC920658
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/+PqLen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DC920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731885AbeJQBQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:16:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:16:34 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3A2B20658;
        Tue, 16 Oct 2018 17:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710708;
        bh=UGo6ONMXMNCFmMn5h5v+fXtqdnrfH9AmmDWAmr+76o0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b/+PqLenmUfAy6VTlTg71FXV1nQchKmXGMQXP5MGD2NfpZYaLqtcqL5m+vF5jvlNe
         /NX5suPBiZxVwqOO1f1ra+Kz+Xh88uK+DQp4jheI7o2h89clgEH+eLlEYKtLQ/Rjy+
         dA56csiEIIBY4qCSc5AbMsjTJj3X7VWUYF8NxZSo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Peter Oskolkov <posk@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Westphal <fw@strlen.de>,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 4.9 61/71] ip: discard IPv4 datagrams with overlapping segments.
Date:   Tue, 16 Oct 2018 19:09:58 +0200
Message-Id: <20181016170542.451084535@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -55,6 +55,7 @@ enum
 	IPSTATS_MIB_ECT1PKTS,			/* InECT1Pkts */
 	IPSTATS_MIB_ECT0PKTS,			/* InECT0Pkts */
 	IPSTATS_MIB_CEPKTS,			/* InCEPkts */
+	IPSTATS_MIB_REASM_OVERLAPS,		/* ReasmOverlaps */
 	__IPSTATS_MIB_MAX
 };
 
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -275,6 +275,7 @@ static int ip_frag_reinit(struct ipq *qp
 /* Add new segment to existing queue. */
 static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
 {
+	struct net *net = container_of(qp->q.net, struct net, ipv4.frags);
 	struct sk_buff *prev, *next;
 	struct net_device *dev;
 	unsigned int fragsize;
@@ -355,65 +356,23 @@ static int ip_frag_queue(struct ipq *qp,
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
@@ -461,6 +420,10 @@ found:
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
@@ -134,6 +134,7 @@ static const struct snmp_mib snmp4_ipext
 	SNMP_MIB_ITEM("InECT1Pkts", IPSTATS_MIB_ECT1PKTS),
 	SNMP_MIB_ITEM("InECT0Pkts", IPSTATS_MIB_ECT0PKTS),
 	SNMP_MIB_ITEM("InCEPkts", IPSTATS_MIB_CEPKTS),
+	SNMP_MIB_ITEM("ReasmOverlaps", IPSTATS_MIB_REASM_OVERLAPS),
 	SNMP_MIB_SENTINEL
 };
 


