Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E2DC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7378A217C6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7378A217C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbeHDLFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:05:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48804 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbeHDLFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:05:34 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2168289C;
        Sat,  4 Aug 2018 09:05:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 20/32] ipv4: frags: handle possible skb truesize change
Date:   Sat,  4 Aug 2018 11:01:10 +0200
Message-Id: <20180804082650.974341571@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082649.908295462@linuxfoundation.org>
References: <20180804082649.908295462@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 4672694bd4f1aebdab0ad763ae4716e89cb15221 ]

ip_frag_queue() might call pskb_pull() on one skb that
is already in the fragment queue.

We need to take care of possible truesize change, or we
might have an imbalance of the netns frags memory usage.

IPv6 is immune to this bug, because RFC5722, Section 4,
amended by Errata ID 3089 states :

  When reassembling an IPv6 datagram, if
  one or more its constituent fragments is determined to be an
  overlapping fragment, the entire datagram (and any constituent
  fragments) MUST be silently discarded.

Fixes: 158f323b9868 ("net: adjust skb->truesize in pskb_expand_head()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_fragment.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -446,11 +446,16 @@ found:
 		int i = end - FRAG_CB(next)->offset; /* overlap is 'i' bytes */
 
 		if (i < next->len) {
+			int delta = -next->truesize;
+
 			/* Eat head of the next overlapped fragment
 			 * and leave the loop. The next ones cannot overlap.
 			 */
 			if (!pskb_pull(next, i))
 				goto err;
+			delta += next->truesize;
+			if (delta)
+				add_frag_mem_limit(qp->q.net, delta);
 			FRAG_CB(next)->offset += i;
 			qp->q.meat -= i;
 			if (next->ip_summed != CHECKSUM_UNNECESSARY)


