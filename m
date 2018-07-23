Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B493ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA26820854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA26820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbeGWN2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:28:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45480 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387940AbeGWN2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:28:37 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 32FB9BB3;
        Mon, 23 Jul 2018 12:27:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Greg Rose <gvrose8192@gmail.com>,
        William Tu <u9012063@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 51/63] net: ip6_gre: get ipv6hdr after skb_cow_head()
Date:   Mon, 23 Jul 2018 14:24:57 +0200
Message-Id: <20180723122448.292357671@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>

[ Upstream commit b7ed879425be371905d856410d19e9a42a62bcf3 ]

A KASAN:use-after-free bug was found related to ip6-erspan
while running selftests/net/ip6_gre_headroom.sh

It happens because of following sequence:
- ipv6hdr pointer is obtained from skb
- skb_cow_head() is called, skb->head memory is reallocated
- old data is accessed using ipv6hdr pointer

skb_cow_head() call was added in e41c7c68ea77 ("ip6erspan: make sure
enough headroom at xmit."), but looking at the history there was a
chance of similar bug because gre_handle_offloads() and pskb_trim()
can also reallocate skb->head memory. Fixes tag points to commit
which introduced possibility of this bug.

This patch moves ipv6hdr pointer assignment after skb_cow_head() call.

Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Signed-off-by: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
Reviewed-by: Greg Rose <gvrose8192@gmail.com>
Acked-by: William Tu <u9012063@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_gre.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -927,7 +927,6 @@ tx_err:
 static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 					 struct net_device *dev)
 {
-	struct ipv6hdr *ipv6h = ipv6_hdr(skb);
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct dst_entry *dst = skb_dst(skb);
 	struct net_device_stats *stats;
@@ -998,6 +997,8 @@ static netdev_tx_t ip6erspan_tunnel_xmit
 			goto tx_err;
 		}
 	} else {
+		struct ipv6hdr *ipv6h = ipv6_hdr(skb);
+
 		switch (skb->protocol) {
 		case htons(ETH_P_IP):
 			memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));


