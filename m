Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BB3C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410092089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCnPv1JX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410092089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbeJQBIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:08:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbeJQBIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:08:38 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D5332089E;
        Tue, 16 Oct 2018 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710234;
        bh=2yMEa+o4LUnpio0Ctf0oq3rL0jXmCLo77csplXKRKd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UCnPv1JXIwke6THHFhPMKMlMdsfXBE75owlqz0a5EUvMh6r6z32SdmnIggGWHw4Lh
         IvsJXlxQ7WLEsjouVWimmkSzGKM2EHnKMVs0Vg3/0QLVtJQ0Sjk7scJtq6YvYwrm9L
         J0h5aJYRFeosy6Z9XhdbmUfiRD3MoCzZ5U4NEnHs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 013/109] net: mvpp2: Extract the correct ethtype from the skb for tx csum offload
Date:   Tue, 16 Oct 2018 19:04:41 +0200
Message-Id: <20181016170525.661430343@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
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

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

[ Upstream commit 35f3625c21852ad839f20c91c7d81c4c1101e207 ]

When offloading the L3 and L4 csum computation on TX, we need to extract
the l3_proto from the ethtype, independently of the presence of a vlan
tag.

The actual driver uses skb->protocol as-is, resulting in packets with
the wrong L4 checksum being sent when there's a vlan tag in the packet
header and checksum offloading is enabled.

This commit makes use of vlan_protocol_get() to get the correct ethtype
regardless the presence of a vlan tag.

Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 network unit")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvpp2.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -33,6 +33,7 @@
 #include <linux/hrtimer.h>
 #include <linux/ktime.h>
 #include <linux/regmap.h>
+#include <linux/if_vlan.h>
 #include <uapi/linux/ppp_defs.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
@@ -5101,7 +5102,7 @@ static void mvpp2_txq_desc_put(struct mv
 }
 
 /* Set Tx descriptors fields relevant for CSUM calculation */
-static u32 mvpp2_txq_desc_csum(int l3_offs, int l3_proto,
+static u32 mvpp2_txq_desc_csum(int l3_offs, __be16 l3_proto,
 			       int ip_hdr_len, int l4_proto)
 {
 	u32 command;
@@ -6065,14 +6066,15 @@ static u32 mvpp2_skb_tx_csum(struct mvpp
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		int ip_hdr_len = 0;
 		u8 l4_proto;
+		__be16 l3_proto = vlan_get_protocol(skb);
 
-		if (skb->protocol == htons(ETH_P_IP)) {
+		if (l3_proto == htons(ETH_P_IP)) {
 			struct iphdr *ip4h = ip_hdr(skb);
 
 			/* Calculate IPv4 checksum and L4 checksum */
 			ip_hdr_len = ip4h->ihl;
 			l4_proto = ip4h->protocol;
-		} else if (skb->protocol == htons(ETH_P_IPV6)) {
+		} else if (l3_proto == htons(ETH_P_IPV6)) {
 			struct ipv6hdr *ip6h = ipv6_hdr(skb);
 
 			/* Read l4_protocol from one of IPv6 extra headers */
@@ -6084,7 +6086,7 @@ static u32 mvpp2_skb_tx_csum(struct mvpp
 		}
 
 		return mvpp2_txq_desc_csum(skb_network_offset(skb),
-				skb->protocol, ip_hdr_len, l4_proto);
+					   l3_proto, ip_hdr_len, l4_proto);
 	}
 
 	return MVPP2_TXD_L4_CSUM_NOT | MVPP2_TXD_IP_CSUM_DISABLE;


