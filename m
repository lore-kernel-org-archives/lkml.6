Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqJPB1X8bbczfHsQ5RKXWTq8tmHpC6crMkG1DNceXmeJChUfq1A7zgfyRdg1oROrjf0OWUq
ARC-Seal: i=1; a=rsa-sha256; t=1526631424; cv=none;
        d=google.com; s=arc-20160816;
        b=sJUh69c3/Wxhnhl4wtwuJ5kzY3oCDFHt6kZW99V7O/4oL/6ax/zjU7hJuBtShyw4Ij
         oOW5SuuUKNH9o1P/+uJ1GSbJXaTif3KjEAYqGUaR0ICWwndXv4bsAyngk5K6OEH1kqLX
         qwjgn65bTthJiHFb7w6AnSbO9R60UuWRDgCh1dfOyc1GzkUz88h3m1iRkQV3KQo1EFUa
         b6WK3qzp2sN+6k0ILr1naqYGMrxRWOhJgt7uPSAPWX+az7fLEcJXT1wK1b3GAS2tnbD/
         I/ymDxz4IsUEKX5Jwgq0a2B6JLvGbtQog6bFLxdbsk2FcJALnsHVsQyJXcvYgpdIFiNA
         fOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=3knebTEk/V60tP8VUCaV8+YuolJXdgQgUwHSge6uo9w=;
        b=E5zQonwiU4bi+lzQMcnTt/E2NK9Yc4FKFRVrUvorXiac6nYTBThjOtdgrsNS+xrjNF
         TKXStdag5DFza9X0muM24IoubxzhU7pc1S1M6Gv50PilNvEK0123McOj3JNpWtqzWF5H
         3hSVeNR0TsjMgXp2K5N5sLdPhBgAUOn2OqIl9baJnnbq4Bn5UuCF4nn/mziogAXvmSJy
         LcaQxOHVCvBLREGpnWE6KzuLiJq/H/PR7zuN+bHxshitB74IUFO+1kuxeC0lmmzw70FN
         iw5wtZ8zG2Rmy4J3+BjEPq2t7a/gIOxUSfw7A6+0eueiOqjtmkSJulzE1TUXPt2TEopZ
         fzeg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kmsRhbx7;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kmsRhbx7;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Ahern <dsahern@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Julian Anastasov <ja@ssi.bg>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 04/55] ipv4: fix fnhe usage by non-cached routes
Date: Fri, 18 May 2018 10:15:00 +0200
Message-Id: <20180518081457.609687515@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789072443629663?=
X-GMAIL-MSGID: =?utf-8?q?1600789072443629663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Anastasov <ja@ssi.bg>

[ Upstream commit 94720e3aee6884d8c8beb678001629da60ec6366 ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/route.c |  118 ++++++++++++++++++++++++-------------------------------
 1 file changed, 53 insertions(+), 65 deletions(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -710,7 +710,7 @@ static void update_or_create_fnhe(struct
 		fnhe->fnhe_gw = gw;
 		fnhe->fnhe_pmtu = pmtu;
 		fnhe->fnhe_mtu_locked = lock;
-		fnhe->fnhe_expires = expires;
+		fnhe->fnhe_expires = max(1UL, expires);
 
 		/* Exception created; mark the cached routes for the nexthop
 		 * stale, so anyone caching it rechecks if this exception
@@ -1298,6 +1298,36 @@ static unsigned int ipv4_mtu(const struc
 	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
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
 	struct fnhe_hash_bucket *hash = rcu_dereference(nh->nh_exceptions);
@@ -1311,8 +1341,14 @@ static struct fib_nh_exception *find_exc
 
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
@@ -1638,36 +1674,6 @@ static void ip_handle_martian_source(str
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
 static void set_lwt_redirect(struct rtable *rth)
 {
 	if (lwtunnel_output_redirect(rth->dst.lwtstate)) {
@@ -1734,20 +1740,10 @@ static int __mkroute_input(struct sk_buf
 
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
@@ -2224,39 +2220,31 @@ static struct rtable *__mkroute_output(c
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
 		if (rt_cache_valid(rth) && dst_hold_safe(&rth->dst))
 			return rth;
 	}
