Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF23EC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9501820840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhn6vELU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9501820840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeKIIXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:23:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:46854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbeKIHcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:32:01 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5819A20840;
        Thu,  8 Nov 2018 21:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714074;
        bh=A/+8OXv3pdO8Ao6ZZWHngfvpq8iTvPDgU7Kyv5Ggfio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nhn6vELUO32M3UOyHyUFqyb+P9fi+wI0EsRUuIgnXrSI9EpuZqy7Z5BFpmJWnmefG
         eYMXYuzVIH0yQ0XodnkqKkUR+9BShiwq0aQRLY9srlMGnXpgwmkpw6ZV8JHOJE8CC3
         hMetnOTPW8dPBqoYSeEq3z5kpqlUEW+wSB6iCLEg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 013/144] net: mvpp2: Extract the correct ethtype from the skb for tx csum offload
Date:   Thu,  8 Nov 2018 13:49:44 -0800
Message-Id: <20181108215055.753712631@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -27,6 +27,7 @@
 #include <linux/of_address.h>
 #include <linux/phy.h>
 #include <linux/clk.h>
+#include <linux/if_vlan.h>
 #include <uapi/linux/ppp_defs.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
@@ -4246,7 +4247,7 @@ static void mvpp2_txq_desc_put(struct mv
 }
 
 /* Set Tx descriptors fields relevant for CSUM calculation */
-static u32 mvpp2_txq_desc_csum(int l3_offs, int l3_proto,
+static u32 mvpp2_txq_desc_csum(int l3_offs, __be16 l3_proto,
 			       int ip_hdr_len, int l4_proto)
 {
 	u32 command;
@@ -4957,14 +4958,15 @@ static u32 mvpp2_skb_tx_csum(struct mvpp
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
@@ -4976,7 +4978,7 @@ static u32 mvpp2_skb_tx_csum(struct mvpp
 		}
 
 		return mvpp2_txq_desc_csum(skb_network_offset(skb),
-				skb->protocol, ip_hdr_len, l4_proto);
+					   l3_proto, ip_hdr_len, l4_proto);
 	}
 
 	return MVPP2_TXD_L4_CSUM_NOT | MVPP2_TXD_IP_CSUM_DISABLE;


