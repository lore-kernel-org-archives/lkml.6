Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291FDC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42EF20876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42EF20876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbeJNXYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:24:38 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36992 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbeJNXYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:24:37 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM9-0004cf-Fp; Sun, 14 Oct 2018 16:31:01 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLQ-0000Gt-Kv; Sun, 14 Oct 2018 16:30:16 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.594826878@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 098/366] net: systemport: Fix sparse warnings in
 bcm_sysport_insert_tsb()
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

commit c0eb05585d4184596453622b5abba7d13dd20667 upstream.

skb->protocol is a __be16 which we would be calling htons() against,
while this is not wrong per-se as it correctly results in swapping the
value on LE hosts, this still upsets sparse. Adopt a similar pattern to
what other drivers do and just assign ip_ver to skb->protocol, and then
use htons() against the different constants such that the compiler can
resolve the values at build time.

Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet MAC driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -772,7 +772,7 @@ static struct sk_buff *bcm_sysport_inser
 	u32 csum_info;
 	u8 ip_proto;
 	u16 csum_start;
-	u16 ip_ver;
+	__be16 ip_ver;
 
 	/* Re-allocate SKB if needed */
 	if (unlikely(skb_headroom(skb) < sizeof(*tsb))) {
@@ -791,12 +791,12 @@ static struct sk_buff *bcm_sysport_inser
 	memset(tsb, 0, sizeof(*tsb));
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		ip_ver = htons(skb->protocol);
+		ip_ver = skb->protocol;
 		switch (ip_ver) {
-		case ETH_P_IP:
+		case htons(ETH_P_IP):
 			ip_proto = ip_hdr(skb)->protocol;
 			break;
-		case ETH_P_IPV6:
+		case htons(ETH_P_IPV6):
 			ip_proto = ipv6_hdr(skb)->nexthdr;
 			break;
 		default:
@@ -810,7 +810,8 @@ static struct sk_buff *bcm_sysport_inser
 
 		if (ip_proto == IPPROTO_TCP || ip_proto == IPPROTO_UDP) {
 			csum_info |= L4_LENGTH_VALID;
-			if (ip_proto == IPPROTO_UDP && ip_ver == ETH_P_IP)
+			if (ip_proto == IPPROTO_UDP &&
+			    ip_ver == htons(ETH_P_IP))
 				csum_info |= L4_UDP;
 		} else
 			csum_info = 0;

