Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635A1C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29378240A7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29378240A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934085AbeGFFu7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:50:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33128 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933976AbeGFFu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:50:56 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5CCC9C8D;
        Fri,  6 Jul 2018 05:50:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 28/61] netfilter: nft_meta: fix wrong value dereference in nft_meta_set_eval
Date:   Fri,  6 Jul 2018 07:46:52 +0200
Message-Id: <20180706054713.416984485@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Taehee Yoo <ap420073@gmail.com>

commit 97a0549b15a0b466c47f6a0143a490a082c64b4e upstream.

In the nft_meta_set_eval, nftrace value is dereferenced as u32 from sreg.
But correct type is u8. so that sometimes incorrect value is dereferenced.

Steps to reproduce:

   %nft add table ip filter
   %nft add chain ip filter input { type filter hook input priority 4\; }
   %nft add rule ip filter input nftrace set 0
   %nft monitor

Sometimes, we can see trace messages.

   trace id 16767227 ip filter input packet: iif "enp2s0"
   ether saddr xx:xx:xx:xx:xx:xx ether daddr xx:xx:xx:xx:xx:xx
   ip saddr 192.168.0.1 ip daddr 255.255.255.255 ip dscp cs0
   ip ecn not-ect ip
   trace id 16767227 ip filter input rule nftrace set 0 (verdict continue)
   trace id 16767227 ip filter input verdict continue
   trace id 16767227 ip filter input

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nft_meta.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -229,7 +229,7 @@ void nft_meta_set_eval(const struct nft_
 	struct sk_buff *skb = pkt->skb;
 	u32 *sreg = &regs->data[meta->sreg];
 	u32 value = *sreg;
-	u8 pkt_type;
+	u8 value8;
 
 	switch (meta->key) {
 	case NFT_META_MARK:
@@ -239,15 +239,17 @@ void nft_meta_set_eval(const struct nft_
 		skb->priority = value;
 		break;
 	case NFT_META_PKTTYPE:
-		pkt_type = nft_reg_load8(sreg);
+		value8 = nft_reg_load8(sreg);
 
-		if (skb->pkt_type != pkt_type &&
-		    skb_pkt_type_ok(pkt_type) &&
+		if (skb->pkt_type != value8 &&
+		    skb_pkt_type_ok(value8) &&
 		    skb_pkt_type_ok(skb->pkt_type))
-			skb->pkt_type = pkt_type;
+			skb->pkt_type = value8;
 		break;
 	case NFT_META_NFTRACE:
-		skb->nf_trace = !!value;
+		value8 = nft_reg_load8(sreg);
+
+		skb->nf_trace = !!value8;
 		break;
 	default:
 		WARN_ON(1);


