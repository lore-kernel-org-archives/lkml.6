Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AA3C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A05720835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A05720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeJNXME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:12:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36278 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728157AbeJNXMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:03 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLr-0004cS-DH; Sun, 14 Oct 2018 16:30:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLX-0000VK-1V; Sun, 14 Oct 2018 16:30:23 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Xin Long" <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "David Ahern" <dsahern@gmail.com>, "Julian Anastasov" <ja@ssi.bg>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.797235942@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 254/366] ipv4: fix fnhe usage by non-cached routes
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

From: Julian Anastasov <ja@ssi.bg>

commit 94720e3aee6884d8c8beb678001629da60ec6366 upstream.

Allow some non-cached routes to use non-expired fnhe:

1. ip_del_fnhe: moved above and now called by find_exception.
The 4.5+ commit deed49df7390 expires fnhe only when caching
routes. Change that to:

1.1. use fnhe for non-cached local output routes, with the help
from (2)

1.2. allow __mkroute_input to detect expired fnhe (outdated
fnhe_gw, for example) when do_cache is false, eg. when itag!=0
for unicast destinations.

2. __mkroute_output: keep fi to allow local routes with orig_oif != 0
to use fnhe info even when the new route will not be cached into fnhe.
After commit 839da4d98960 ("net: ipv4: set orig_oif based on fib
result for local traffic") it means all local routes will be affected
because they are not cached. This change is used to solve a PMTU
problem with IPVS (and probably Netfilter DNAT) setups that redirect
local clients from target local IP (local route to Virtual IP)
to new remote IP target, eg. IPVS TUN real server. Loopback has
64K MTU and we need to create fnhe on the local route that will
keep the reduced PMTU for the Virtual IP. Without this change
fnhe_pmtu is updated from ICMP but never exposed to non-cached
local routes. This includes routes with flowi4_oif!=0 for 4.6+ and
with flowi4_oif=any for 4.14+).

3. update_or_create_fnhe: make sure fnhe_expires is not 0 for
new entries

Fixes: 839da4d98960 ("net: ipv4: set orig_oif based on fib result for local traffic")
Fixes: d6d5e999e5df ("route: do not cache fib route info on local routes with oif")
Fixes: deed49df7390 ("route: check and remove route cache when we get route")
Cc: David Ahern <dsahern@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Julian Anastasov <ja@ssi.bg>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/route.c | 118 +++++++++++++++++++++--------------------------
 1 file changed, 53 insertions(+), 65 deletions(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -684,7 +684,7 @@ static void update_or_create_fnhe(struct
 		fnhe->fnhe_gw = gw;
 		fnhe->fnhe_pmtu = pmtu;
 		fnhe->fnhe_mtu_locked = lock;
-		fnhe->fnhe_expires = expires;
+		fnhe->fnhe_expires = max(1UL, expires);
 
 		/* Exception created; mark the cached routes for the nexthop
 		 * stale, so anyone caching it rechecks if this exception
@@ -1259,6 +1259,36 @@ static unsigned int ipv4_mtu(const struc
 	return min_t(unsigned int, mtu, IP_MAX_MTU);
 }
 
+static void ip_del_fnhe(struct fib_nh *nh, __be32 daddr)
+{
+	struct fnhe_hash_bucket *hash;
+	struct fib_nh_exception *fnhe, __rcu **fnhe_p;
+	u32 hval = fnhe_hashfun(daddr);
+
+	spin_lock_bh(&fnhe_lock);
+
+	hash = rcu_dereference_protected(nh->nh_exceptions,
+					 lockdep_is_held(&fnhe_lock));
+	hash += hval;
+
+	fnhe_p = &hash->chain;
+	fnhe = rcu_dereference_protected(*fnhe_p, lockdep_is_held(&fnhe_lock));
+	while (fnhe) {
+		if (fnhe->fnhe_daddr == daddr) {
+			rcu_assign_pointer(*fnhe_p, rcu_dereference_protected(
+				fnhe->fnhe_next, lockdep_is_held(&fnhe_lock)));
+			fnhe_flush_routes(fnhe);
+			kfree_rcu(fnhe, rcu);
+			break;
+		}
+		fnhe_p = &fnhe->fnhe_next;
+		fnhe = rcu_dereference_protected(fnhe->fnhe_next,
+						 lockdep_is_held(&fnhe_lock));
+	}
+
+	spin_unlock_bh(&fnhe_lock);
+}
+
 static struct fib_nh_exception *find_exception(struct fib_nh *nh, __be32 daddr)
 {
 	struct fnhe_hash_bucket *hash = nh->nh_exceptions;
@@ -1272,8 +1302,14 @@ static struct fib_nh_exception *find_exc
 
 	for (fnhe = rcu_dereference(hash[hval].chain); fnhe;
 	     fnhe = rcu_dereference(fnhe->fnhe_next)) {
-		if (fnhe->fnhe_daddr == daddr)
+		if (fnhe->fnhe_daddr == daddr) {
+			if (fnhe->fnhe_expires &&
+			    time_after(jiffies, fnhe->fnhe_expires)) {
+				ip_del_fnhe(nh, daddr);
+				break;
+			}
 			return fnhe;
+		}
 	}
 	return NULL;
 }
@@ -1568,36 +1604,6 @@ static void ip_handle_martian_source(str
 #endif
 }
 
-static void ip_del_fnhe(struct fib_nh *nh, __be32 daddr)
-{
-	struct fnhe_hash_bucket *hash;
-	struct fib_nh_exception *fnhe, __rcu **fnhe_p;
-	u32 hval = fnhe_hashfun(daddr);
-
-	spin_lock_bh(&fnhe_lock);
-
-	hash = rcu_dereference_protected(nh->nh_exceptions,
-					 lockdep_is_held(&fnhe_lock));
-	hash += hval;
-
-	fnhe_p = &hash->chain;
-	fnhe = rcu_dereference_protected(*fnhe_p, lockdep_is_held(&fnhe_lock));
-	while (fnhe) {
-		if (fnhe->fnhe_daddr == daddr) {
-			rcu_assign_pointer(*fnhe_p, rcu_dereference_protected(
-				fnhe->fnhe_next, lockdep_is_held(&fnhe_lock)));
-			fnhe_flush_routes(fnhe);
-			kfree_rcu(fnhe, rcu);
-			break;
-		}
-		fnhe_p = &fnhe->fnhe_next;
-		fnhe = rcu_dereference_protected(fnhe->fnhe_next,
-						 lockdep_is_held(&fnhe_lock));
-	}
-
-	spin_unlock_bh(&fnhe_lock);
-}
-
 /* called in rcu_read_lock() section */
 static int __mkroute_input(struct sk_buff *skb,
 			   const struct fib_result *res,
@@ -1651,20 +1657,10 @@ static int __mkroute_input(struct sk_buf
 
 	fnhe = find_exception(&FIB_RES_NH(*res), daddr);
 	if (do_cache) {
-		if (fnhe) {
+		if (fnhe)
 			rth = rcu_dereference(fnhe->fnhe_rth_input);
-			if (rth && rth->dst.expires &&
-			    time_after(jiffies, rth->dst.expires)) {
-				ip_del_fnhe(&FIB_RES_NH(*res), daddr);
-				fnhe = NULL;
-			} else {
-				goto rt_cache;
-			}
-		}
-
-		rth = rcu_dereference(FIB_RES_NH(*res).nh_rth_input);
-
-rt_cache:
+		else
+			rth = rcu_dereference(FIB_RES_NH(*res).nh_rth_input);
 		if (rt_cache_valid(rth)) {
 			skb_dst_set_noref(skb, &rth->dst);
 			goto out;
@@ -2000,39 +1996,31 @@ static struct rtable *__mkroute_output(c
 		 * the loopback interface and the IP_PKTINFO ipi_ifindex will
 		 * be set to the loopback interface as well.
 		 */
-		fi = NULL;
+		do_cache = false;
 	}
 
 	fnhe = NULL;
 	do_cache &= fi != NULL;
-	if (do_cache) {
+	if (fi) {
 		struct rtable __rcu **prth;
 		struct fib_nh *nh = &FIB_RES_NH(*res);
 
 		fnhe = find_exception(nh, fl4->daddr);
+		if (!do_cache)
+			goto add;
 		if (fnhe) {
 			prth = &fnhe->fnhe_rth_output;
-			rth = rcu_dereference(*prth);
-			if (rth && rth->dst.expires &&
-			    time_after(jiffies, rth->dst.expires)) {
-				ip_del_fnhe(nh, fl4->daddr);
-				fnhe = NULL;
-			} else {
-				goto rt_cache;
+		} else {
+			if (unlikely(fl4->flowi4_flags &
+				     FLOWI_FLAG_KNOWN_NH &&
+				     !(nh->nh_gw &&
+				       nh->nh_scope == RT_SCOPE_LINK))) {
+				do_cache = false;
+				goto add;
 			}
+			prth = raw_cpu_ptr(nh->nh_pcpu_rth_output);
 		}
-
-		if (unlikely(fl4->flowi4_flags &
-			     FLOWI_FLAG_KNOWN_NH &&
-			     !(nh->nh_gw &&
-			       nh->nh_scope == RT_SCOPE_LINK))) {
-			do_cache = false;
-			goto add;
-		}
-		prth = raw_cpu_ptr(nh->nh_pcpu_rth_output);
 		rth = rcu_dereference(*prth);
-
-rt_cache:
 		if (rt_cache_valid(rth)) {
 			dst_hold(&rth->dst);
 			return rth;

