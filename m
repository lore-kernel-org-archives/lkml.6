Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeCTRf4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:35:56 -0400
Received: from smtprelay0095.hostedemail.com ([216.40.44.95]:34082 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751334AbeCTRfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:35:52 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:800:960:968:973:988:989:1260:1345:1437:1534:1541:1711:1730:1747:1777:1792:2393:2553:2559:2562:3138:3139:3140:3141:3142:3352:3653:3865:3867:3868:3871:4321:4605:5007:6119:6261:8603:9592:10004:10848:11026:11473:11658:11914:12043:12296:12555:12679:12895:13069:13311:13357:14181:14384:14394:14721:21080:21433:21451:21627:30054:30090,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: nerve58_32c1c4a0d804c
X-Filterd-Recvd-Size: 2707
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH] netfilter: ipset: Use is_zero_ether_addr instead of static and memcmp
Date: Tue, 20 Mar 2018 10:35:47 -0700
Message-Id: <687a4edaed07441681d3bfe3b63aa4feb55b9d61.1521567319.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the test a bit clearer and to reduce object size a little.

Miscellanea:

o remove now unnecessary static const array

$ size ip_set_hash_mac.o*
   text	   data	    bss	    dec	    hex	filename
  22822	   4619	     64	  27505	   6b71	ip_set_hash_mac.o.allyesconfig.new
  22932	   4683	     64	  27679	   6c1f	ip_set_hash_mac.o.allyesconfig.old
  10443	   1040	      0	  11483	   2cdb	ip_set_hash_mac.o.defconfig.new
  10507	   1040	      0	  11547	   2d1b	ip_set_hash_mac.o.defconfig.old

Signed-off-by: Joe Perches <joe@perches.com>
---
 net/netfilter/ipset/ip_set_hash_mac.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_hash_mac.c b/net/netfilter/ipset/ip_set_hash_mac.c
index 8f004edad396..f9d5a2a1e3d0 100644
--- a/net/netfilter/ipset/ip_set_hash_mac.c
+++ b/net/netfilter/ipset/ip_set_hash_mac.c
@@ -72,9 +72,6 @@ hash_mac4_data_next(struct hash_mac4_elem *next,
 #define IP_SET_PROTO_UNDEF
 #include "ip_set_hash_gen.h"
 
-/* Zero valued element is not supported */
-static const unsigned char invalid_ether[ETH_ALEN] = { 0 };
-
 static int
 hash_mac4_kadt(struct ip_set *set, const struct sk_buff *skb,
 	       const struct xt_action_param *par,
@@ -93,7 +90,7 @@ hash_mac4_kadt(struct ip_set *set, const struct sk_buff *skb,
 		return -EINVAL;
 
 	ether_addr_copy(e.ether, eth_hdr(skb)->h_source);
-	if (memcmp(e.ether, invalid_ether, ETH_ALEN) == 0)
+	if (is_zero_ether_addr(e.ether))
 		return -EINVAL;
 	return adtfn(set, &e, &ext, &opt->ext, opt->cmdflags);
 }
@@ -118,7 +115,7 @@ hash_mac4_uadt(struct ip_set *set, struct nlattr *tb[],
 	if (ret)
 		return ret;
 	ether_addr_copy(e.ether, nla_data(tb[IPSET_ATTR_ETHER]));
-	if (memcmp(e.ether, invalid_ether, ETH_ALEN) == 0)
+	if (is_zero_ether_addr(e.ether))
 		return -IPSET_ERR_HASH_ELEM;
 
 	return adtfn(set, &e, &ext, &ext, flags);
-- 
2.15.0
