Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeCULDe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 07:03:34 -0400
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:53402 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751737AbeCULD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 07:03:27 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:541:800:960:973:981:988:989:1260:1345:1437:1534:1541:1711:1730:1747:1777:1792:1978:1981:2194:2199:2393:2553:2559:2562:3138:3139:3140:3141:3142:3352:3865:3866:3867:4605:5007:6119:6261:7903:8603:10004:10848:11026:11473:11658:11914:12043:12296:12438:12555:12895:13069:13311:13357:14181:14384:14394:14721:21080:21433:21627:30054:30075:30090,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: pest50_1dd7825961f5e
X-Filterd-Recvd-Size: 2468
From: Joe Perches <joe@perches.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bridge: netfilter: ebt_stp: Use generic functions for comparisons
Date: Wed, 21 Mar 2018 04:03:22 -0700
Message-Id: <c22b7398816c4533a65ff57aaa44629729fc7254.1521630169.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of unnecessary const declarations, use the generic functions to
save a little object space.

$ size net/bridge/netfilter/ebt_stp.o*
   text	   data	    bss	    dec	    hex	filename
   1250	    144	      0	   1394	    572	net/bridge/netfilter/ebt_stp.o.new
   1344	    144	      0	   1488	    5d0	net/bridge/netfilter/ebt_stp.o.old

Signed-off-by: Joe Perches <joe@perches.com>
---
 net/bridge/netfilter/ebt_stp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bridge/netfilter/ebt_stp.c b/net/bridge/netfilter/ebt_stp.c
index 3140eb912d7e..47ba98db145d 100644
--- a/net/bridge/netfilter/ebt_stp.c
+++ b/net/bridge/netfilter/ebt_stp.c
@@ -153,8 +153,6 @@ ebt_stp_mt(const struct sk_buff *skb, struct xt_action_param *par)
 static int ebt_stp_mt_check(const struct xt_mtchk_param *par)
 {
 	const struct ebt_stp_info *info = par->matchinfo;
-	const u8 bridge_ula[6] = {0x01, 0x80, 0xc2, 0x00, 0x00, 0x00};
-	const u8 msk[6] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	const struct ebt_entry *e = par->entryinfo;
 
 	if (info->bitmask & ~EBT_STP_MASK || info->invflags & ~EBT_STP_MASK ||
@@ -162,8 +160,8 @@ static int ebt_stp_mt_check(const struct xt_mtchk_param *par)
 		return -EINVAL;
 	/* Make sure the match only receives stp frames */
 	if (!par->nft_compat &&
-	    (!ether_addr_equal(e->destmac, bridge_ula) ||
-	     !ether_addr_equal(e->destmsk, msk) ||
+	    (!ether_addr_equal(e->destmac, eth_stp_addr) ||
+	     !is_broadcast_ether_addr(e->destmsk) ||
 	     !(e->bitmask & EBT_DESTMAC)))
 		return -EINVAL;
 
-- 
2.15.0
