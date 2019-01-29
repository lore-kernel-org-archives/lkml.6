Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F777C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF502086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762668;
	bh=+rJoEsnSlb22IA9vqzEzbU7c/EWn90PE3NC+1y69dFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=soepCr4dieDEvVql1RBsFbRF6rL+50dkUASbu020kw+JZYK19eqULJbCEbRx+SX3s
	 lHOQPQIUA7NO3Z6y+6gSVSczJzZRpu93UT4pr4BUN3Z1h7c1Fksv/0QLdsUe9cEwDA
	 flC7MfVKDiJWH8tcgdWTBKDln4we8g8CvsSBCQ74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbfA2LvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:51:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731795AbfA2LvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:51:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F338B2086C;
        Tue, 29 Jan 2019 11:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762663;
        bh=+rJoEsnSlb22IA9vqzEzbU7c/EWn90PE3NC+1y69dFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPKFVgZG0XCBVBRY7sDxX3wIs9izPijaR7QdJWnT7C6IIIufuM4FBoTh2/dYBeAaJ
         CLXAW2mzHeFsbXHVkAWr6AFQQVfQiR+yuRfIYff6lH7PSbRcMnuEkeM0/ZhqvbAUAx
         9F2TcuXSNLGzaYIfrxkZU7Jy7y5LM7iifC3onP0c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Lagerwall <ross.lagerwall@citrix.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 02/44] net: Fix usage of pskb_trim_rcsum
Date:   Tue, 29 Jan 2019 12:35:57 +0100
Message-Id: <20190129113140.084104122@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
References: <20190129113139.826927690@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ross Lagerwall <ross.lagerwall@citrix.com>

[ Upstream commit 6c57f0458022298e4da1729c67bd33ce41c14e7a ]

In certain cases, pskb_trim_rcsum() may change skb pointers.
Reinitialize header pointers afterwards to avoid potential
use-after-frees. Add a note in the documentation of
pskb_trim_rcsum(). Found by KASAN.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ppp/pppoe.c                  |    1 +
 include/linux/skbuff.h                   |    1 +
 net/bridge/br_netfilter_ipv6.c           |    1 +
 net/bridge/netfilter/nft_reject_bridge.c |    1 +
 net/ipv4/ip_input.c                      |    1 +
 5 files changed, 5 insertions(+)

--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -442,6 +442,7 @@ static int pppoe_rcv(struct sk_buff *skb
 	if (pskb_trim_rcsum(skb, len))
 		goto drop;
 
+	ph = pppoe_hdr(skb);
 	pn = pppoe_pernet(dev_net(dev));
 
 	/* Note that get_item does a sock_hold(), so sk_pppox(po)
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2962,6 +2962,7 @@ int pskb_trim_rcsum_slow(struct sk_buff
  *
  *	This is exactly the same as pskb_trim except that it ensures the
  *	checksum of received packets are still valid after the operation.
+ *	It can change skb pointers.
  */
 
 static inline int pskb_trim_rcsum(struct sk_buff *skb, unsigned int len)
--- a/net/bridge/br_netfilter_ipv6.c
+++ b/net/bridge/br_netfilter_ipv6.c
@@ -131,6 +131,7 @@ int br_validate_ipv6(struct net *net, st
 					IPSTATS_MIB_INDISCARDS);
 			goto drop;
 		}
+		hdr = ipv6_hdr(skb);
 	}
 	if (hdr->nexthdr == NEXTHDR_HOP && br_nf_check_hbh_len(skb))
 		goto drop;
--- a/net/bridge/netfilter/nft_reject_bridge.c
+++ b/net/bridge/netfilter/nft_reject_bridge.c
@@ -236,6 +236,7 @@ static bool reject6_br_csum_ok(struct sk
 	    pskb_trim_rcsum(skb, ntohs(ip6h->payload_len) + sizeof(*ip6h)))
 		return false;
 
+	ip6h = ipv6_hdr(skb);
 	thoff = ipv6_skip_exthdr(skb, ((u8*)(ip6h+1) - skb->data), &proto, &fo);
 	if (thoff < 0 || thoff >= skb->len || (fo & htons(~0x7)) != 0)
 		return false;
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -475,6 +475,7 @@ int ip_rcv(struct sk_buff *skb, struct n
 		goto drop;
 	}
 
+	iph = ip_hdr(skb);
 	skb->transport_header = skb->network_header + iph->ihl*4;
 
 	/* Remove any debris in the socket control block */


