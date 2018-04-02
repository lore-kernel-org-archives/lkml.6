Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754695AbeDBW7V (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 18:59:21 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43962 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754522AbeDBW7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 18:59:10 -0400
X-Google-Smtp-Source: AIpwx48YxtfBe0EiI4q/MN+IDwrkUrs+qOOmfVJJQVvi2bGRxyq9iUeuYylKq79UJ70ewXuHwJiziw==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 2/2] net: systemport: Fix sparse warnings in bcm_sysport_insert_tsb()
Date: Mon,  2 Apr 2018 15:58:56 -0700
Message-Id: <20180402225856.4351-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180402225856.4351-1-f.fainelli@gmail.com>
References: <20180402225856.4351-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb->protocol is a __be16 which we would be calling htons() against,
while this is not wrong per-se as it correctly results in swapping the
value on LE hosts, this still upsets sparse. Adopt a similar pattern to
what other drivers do and just assign ip_ver to skb->protocol, and then
use htons() against the different constants such that the compiler can
resolve the values at build time.

Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet MAC driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 3fc549b88c43..879db1c700bd 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1133,7 +1133,7 @@ static struct sk_buff *bcm_sysport_insert_tsb(struct sk_buff *skb,
 	u32 csum_info;
 	u8 ip_proto;
 	u16 csum_start;
-	u16 ip_ver;
+	__be16 ip_ver;
 
 	/* Re-allocate SKB if needed */
 	if (unlikely(skb_headroom(skb) < sizeof(*tsb))) {
@@ -1152,12 +1152,12 @@ static struct sk_buff *bcm_sysport_insert_tsb(struct sk_buff *skb,
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
@@ -1171,7 +1171,8 @@ static struct sk_buff *bcm_sysport_insert_tsb(struct sk_buff *skb,
 
 		if (ip_proto == IPPROTO_TCP || ip_proto == IPPROTO_UDP) {
 			csum_info |= L4_LENGTH_VALID;
-			if (ip_proto == IPPROTO_UDP && ip_ver == ETH_P_IP)
+			if (ip_proto == IPPROTO_UDP &&
+			    ip_ver == htons(ETH_P_IP))
 				csum_info |= L4_UDP;
 		} else {
 			csum_info = 0;
-- 
2.14.1
