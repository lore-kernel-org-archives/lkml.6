Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbeCZPgD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:36:03 -0400
Received: from smtprelay0083.hostedemail.com ([216.40.44.83]:59223 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752173AbeCZPfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:35:05 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:69:355:379:541:800:901:960:966:967:968:973:988:989:1260:1263:1345:1437:1534:1543:1711:1730:1747:1777:1792:2196:2199:2393:2525:2553:2560:2563:2682:2685:2859:2899:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3657:3865:3866:3867:3868:3870:3871:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4385:4419:4605:5007:6261:9025:9388:9592:10004:10049:10848:11026:11232:11473:11658:11914:12043:12296:12438:12555:12679:12895:12986:13095:13437:13972:14181:14394:14721:14915:21080:21433:21451:21627:21740:21781:30012:30029:30054:30056:30090,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: offer58_494f74d4be121
X-Filterd-Recvd-Size: 4038
From: Joe Perches <joe@perches.com>
To: "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6: addrconf: Use normal debugging style
Date: Mon, 26 Mar 2018 08:35:01 -0700
Message-Id: <40e88b53c25ddb95d36bb7a061806f2f95f5ccf2.1522078288.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove local ADBG macro and use netdev_dbg/pr_debug

Miscellanea:

o Remove unnecessary debug message after allocation failure as there
  already is a dump_stack() on the failure paths
o Leave the allocation failure message on snmp6_alloc_dev as there
  is one code path that does not do a dump_stack()

Signed-off-by: Joe Perches <joe@perches.com>
---

Remerged resend of http://patchwork.ozlabs.org/patch/826028/
back in October 2017

 net/ipv6/addrconf.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 6fd4bbdc444f..0d104bd74934 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -94,15 +94,6 @@
 #include <linux/seq_file.h>
 #include <linux/export.h>
 
-/* Set to 3 to get tracing... */
-#define ACONF_DEBUG 2
-
-#if ACONF_DEBUG >= 3
-#define ADBG(fmt, ...) printk(fmt, ##__VA_ARGS__)
-#else
-#define ADBG(fmt, ...) do { if (0) printk(fmt, ##__VA_ARGS__); } while (0)
-#endif
-
 #define	INFINITY_LIFE_TIME	0xFFFFFFFF
 
 #define IPV6_MAX_STRLEN \
@@ -409,9 +400,8 @@ static struct inet6_dev *ipv6_add_dev(struct net_device *dev)
 	dev_hold(dev);
 
 	if (snmp6_alloc_dev(ndev) < 0) {
-		ADBG(KERN_WARNING
-			"%s: cannot allocate memory for statistics; dev=%s.\n",
-			__func__, dev->name);
+		netdev_dbg(dev, "%s: cannot allocate memory for statistics\n",
+			   __func__);
 		neigh_parms_release(&nd_tbl, ndev->nd_parms);
 		dev_put(dev);
 		kfree(ndev);
@@ -419,9 +409,8 @@ static struct inet6_dev *ipv6_add_dev(struct net_device *dev)
 	}
 
 	if (snmp6_register_dev(ndev) < 0) {
-		ADBG(KERN_WARNING
-			"%s: cannot create /proc/net/dev_snmp6/%s\n",
-			__func__, dev->name);
+		netdev_dbg(dev, "%s: cannot create /proc/net/dev_snmp6/%s\n",
+			   __func__, dev->name);
 		goto err_release;
 	}
 
@@ -984,7 +973,7 @@ static int ipv6_add_addr_hash(struct net_device *dev, struct inet6_ifaddr *ifa)
 
 	/* Ignore adding duplicate addresses on an interface */
 	if (ipv6_chk_same_addr(dev_net(dev), &ifa->addr, dev, hash)) {
-		ADBG("ipv6_add_addr: already assigned\n");
+		netdev_dbg(dev, "ipv6_add_addr: already assigned\n");
 		err = -EEXIST;
 	} else {
 		hlist_add_head_rcu(&ifa->addr_lst, &inet6_addr_lst[hash]);
@@ -1044,7 +1033,6 @@ ipv6_add_addr(struct inet6_dev *idev, const struct in6_addr *addr,
 
 	ifa = kzalloc(sizeof(*ifa), gfp_flags);
 	if (!ifa) {
-		ADBG("ipv6_add_addr: malloc failed\n");
 		err = -ENOBUFS;
 		goto out;
 	}
@@ -2618,7 +2606,7 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *opt, int len, bool sllao)
 	pinfo = (struct prefix_info *) opt;
 
 	if (len < sizeof(struct prefix_info)) {
-		ADBG("addrconf: prefix option too short\n");
+		netdev_dbg(dev, "addrconf: prefix option too short\n");
 		return;
 	}
 
@@ -4446,8 +4434,8 @@ static void addrconf_verify_rtnl(void)
 	if (time_before(next_sched, jiffies + ADDRCONF_TIMER_FUZZ_MAX))
 		next_sched = jiffies + ADDRCONF_TIMER_FUZZ_MAX;
 
-	ADBG(KERN_DEBUG "now = %lu, schedule = %lu, rounded schedule = %lu => %lu\n",
-	      now, next, next_sec, next_sched);
+	pr_debug("now = %lu, schedule = %lu, rounded schedule = %lu => %lu\n",
+		 now, next, next_sec, next_sched);
 	mod_delayed_work(addrconf_wq, &addr_chk_work, next_sched - now);
 	rcu_read_unlock_bh();
 }
-- 
2.15.0
