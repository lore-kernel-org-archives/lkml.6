Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752911AbeCaHFu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 03:05:50 -0400
Received: from smtprelay0011.hostedemail.com ([216.40.44.11]:52173 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752422AbeCaHFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 03:05:47 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:541:800:960:968:973:988:989:1260:1345:1359:1437:1534:1541:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3352:3865:3868:4321:4419:5007:6119:6261:7903:10004:10848:11026:11473:11658:11914:12043:12296:12438:12555:12895:12986:13069:13311:13357:14181:14384:14394:14721:21080:21627:30054:30075,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: idea48_898d745d89849
X-Filterd-Recvd-Size: 2296
From: Joe Perches <joe@perches.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] bridge: netfilter: Use the new global ether_<foo>_addr arrays
Date: Sat, 31 Mar 2018 00:05:19 -0700
Message-Id: <df70bafdca663db034626f4f1525826ea263bf2c.1522479607.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1522479607.git.joe@perches.com>
References: <cover.1522479607.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the local consts and use the new globals.

Signed-off-by: Joe Perches <joe@perches.com>
---
 net/bridge/netfilter/ebt_stp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bridge/netfilter/ebt_stp.c b/net/bridge/netfilter/ebt_stp.c
index 3140eb912d7e..2b7479cc0140 100644
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
+	    (!ether_addr_equal(e->destmac, ether_stp_addr) ||
+	     !ether_addr_equal(e->destmsk, ether_broadcast_addr) ||
 	     !(e->bitmask & EBT_DESTMAC)))
 		return -EINVAL;
 
-- 
2.15.0
