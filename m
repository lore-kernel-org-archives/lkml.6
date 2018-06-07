Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YodmIeU9GVs4RgAAmS7hNA
	; Thu, 07 Jun 2018 14:17:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E72D4608B8; Thu,  7 Jun 2018 14:17:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2FDB56063F;
	Thu,  7 Jun 2018 14:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2FDB56063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933245AbeFGOQR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:16:17 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39597 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753535AbeFGOJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:15 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbF-0005Zm-Q6; Thu, 07 Jun 2018 15:09:13 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003F7-Nj; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Sabrina Dubroca" <sd@queasysnail.net>,
        "Stefano Brivio" <sbrivio@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.381024515@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 353/410] ipv4: lock mtu in fnhe when received PMTU <
 net.ipv4.route.min_pmtu
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

commit d52e5a7e7ca49457dd31fc8b42fb7c0d58a31221 upstream.

Prior to the rework of PMTU information storage in commit
2c8cec5c10bc ("ipv4: Cache learned PMTU information in inetpeer."),
when a PMTU event advertising a PMTU smaller than
net.ipv4.route.min_pmtu was received, we would disable setting the DF
flag on packets by locking the MTU metric, and set the PMTU to
net.ipv4.route.min_pmtu.

Since then, we don't disable DF, and set PMTU to
net.ipv4.route.min_pmtu, so the intermediate router that has this link
with a small MTU will have to drop the packets.

This patch reestablishes pre-2.6.39 behavior by splitting
rtable->rt_pmtu into a bitfield with rt_mtu_locked and rt_pmtu.
rt_mtu_locked indicates that we shouldn't set the DF bit on that path,
and is checked in ip_dont_fragment().

One possible workaround is to set net.ipv4.route.min_pmtu to a value low
enough to accommodate the lowest MTU encountered.

Fixes: 2c8cec5c10bc ("ipv4: Cache learned PMTU information in inetpeer.")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/net/ip.h        | 11 +++++++++--
 include/net/ip_fib.h    |  1 +
 include/net/route.h     |  3 ++-
 net/ipv4/route.c        | 26 +++++++++++++++++++-------
 net/ipv4/xfrm4_policy.c |  1 +
 5 files changed, 32 insertions(+), 10 deletions(-)

--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -263,12 +263,19 @@ int ip_decrease_ttl(struct iphdr *iph)
 	return --iph->ttl;
 }
 
+static inline int ip_mtu_locked(const struct dst_entry *dst)
+{
+	const struct rtable *rt = (const struct rtable *)dst;
+
+	return rt->rt_mtu_locked || dst_metric_locked(dst, RTAX_MTU);
+}
+
 static inline
 int ip_dont_fragment(struct sock *sk, struct dst_entry *dst)
 {
 	return  inet_sk(sk)->pmtudisc == IP_PMTUDISC_DO ||
 		(inet_sk(sk)->pmtudisc == IP_PMTUDISC_WANT &&
-		 !(dst_metric_locked(dst, RTAX_MTU)));
+		 !ip_mtu_locked(dst));
 }
 
 static inline bool ip_sk_accept_pmtu(const struct sock *sk)
@@ -294,7 +301,7 @@ static inline unsigned int ip_dst_mtu_ma
 	struct net *net = dev_net(dst->dev);
 
 	if (net->ipv4.sysctl_ip_fwd_use_pmtu ||
-	    dst_metric_locked(dst, RTAX_MTU) ||
+	    ip_mtu_locked(dst) ||
 	    !forwarding)
 		return dst_mtu(dst);
 
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -54,6 +54,7 @@ struct fib_nh_exception {
 	int				fnhe_genid;
 	__be32				fnhe_daddr;
 	u32				fnhe_pmtu;
+	bool				fnhe_mtu_locked;
 	__be32				fnhe_gw;
 	unsigned long			fnhe_expires;
 	struct rtable __rcu		*fnhe_rth_input;
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -61,7 +61,8 @@ struct rtable {
 	__be32			rt_gateway;
 
 	/* Miscellaneous cached information */
-	u32			rt_pmtu;
+	u32			rt_mtu_locked:1,
+				rt_pmtu:31;
 
 	struct list_head	rt_uncached;
 };
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -608,6 +608,7 @@ static inline u32 fnhe_hashfun(__be32 da
 static void fill_route_from_fnhe(struct rtable *rt, struct fib_nh_exception *fnhe)
 {
 	rt->rt_pmtu = fnhe->fnhe_pmtu;
+	rt->rt_mtu_locked = fnhe->fnhe_mtu_locked;
 	rt->dst.expires = fnhe->fnhe_expires;
 
 	if (fnhe->fnhe_gw) {
@@ -618,7 +619,7 @@ static void fill_route_from_fnhe(struct
 }
 
 static void update_or_create_fnhe(struct fib_nh *nh, __be32 daddr, __be32 gw,
-				  u32 pmtu, unsigned long expires)
+				  u32 pmtu, bool lock, unsigned long expires)
 {
 	struct fnhe_hash_bucket *hash;
 	struct fib_nh_exception *fnhe;
@@ -655,8 +656,10 @@ static void update_or_create_fnhe(struct
 			fnhe->fnhe_genid = genid;
 		if (gw)
 			fnhe->fnhe_gw = gw;
-		if (pmtu)
+		if (pmtu) {
 			fnhe->fnhe_pmtu = pmtu;
+			fnhe->fnhe_mtu_locked = lock;
+		}
 		fnhe->fnhe_expires = max(1UL, expires);
 		/* Update all cached dsts too */
 		rt = rcu_dereference(fnhe->fnhe_rth_input);
@@ -680,6 +683,7 @@ static void update_or_create_fnhe(struct
 		fnhe->fnhe_daddr = daddr;
 		fnhe->fnhe_gw = gw;
 		fnhe->fnhe_pmtu = pmtu;
+		fnhe->fnhe_mtu_locked = lock;
 		fnhe->fnhe_expires = expires;
 
 		/* Exception created; mark the cached routes for the nexthop
@@ -761,7 +765,8 @@ static void __ip_do_redirect(struct rtab
 				struct fib_nh *nh = &FIB_RES_NH(res);
 
 				update_or_create_fnhe(nh, fl4->daddr, new_gw,
-						0, jiffies + ip_rt_gc_timeout);
+						0, false,
+						jiffies + ip_rt_gc_timeout);
 			}
 			if (kill_route)
 				rt->dst.obsolete = DST_OBSOLETE_KILL;
@@ -970,15 +975,18 @@ static void __ip_rt_update_pmtu(struct r
 {
 	struct dst_entry *dst = &rt->dst;
 	struct fib_result res;
+	bool lock = false;
 
-	if (dst_metric_locked(dst, RTAX_MTU))
+	if (ip_mtu_locked(dst))
 		return;
 
 	if (dst->dev->mtu < mtu)
 		return;
 
-	if (mtu < ip_rt_min_pmtu)
+	if (mtu < ip_rt_min_pmtu) {
+		lock = true;
 		mtu = ip_rt_min_pmtu;
+	}
 
 	if (rt->rt_pmtu == mtu &&
 	    time_before(jiffies, dst->expires - ip_rt_mtu_expires / 2))
@@ -988,7 +996,7 @@ static void __ip_rt_update_pmtu(struct r
 	if (fib_lookup(dev_net(dst->dev), fl4, &res) == 0) {
 		struct fib_nh *nh = &FIB_RES_NH(res);
 
-		update_or_create_fnhe(nh, fl4->daddr, 0, mtu,
+		update_or_create_fnhe(nh, fl4->daddr, 0, mtu, lock,
 				      jiffies + ip_rt_mtu_expires);
 	}
 	rcu_read_unlock();
@@ -1243,7 +1251,7 @@ static unsigned int ipv4_mtu(const struc
 
 	mtu = dst->dev->mtu;
 
-	if (unlikely(dst_metric_locked(dst, RTAX_MTU))) {
+	if (unlikely(ip_mtu_locked(dst))) {
 		if (rt->rt_uses_gateway && mtu > 576)
 			mtu = 576;
 	}
@@ -1452,6 +1460,7 @@ static struct rtable *rt_dst_alloc(struc
 		rt->rt_is_input = 0;
 		rt->rt_iif = 0;
 		rt->rt_pmtu = 0;
+		rt->rt_mtu_locked = 0;
 		rt->rt_gateway = 0;
 		rt->rt_uses_gateway = 0;
 		INIT_LIST_HEAD(&rt->rt_uncached);
@@ -2308,6 +2317,7 @@ struct dst_entry *ipv4_blackhole_route(s
 		rt->rt_is_input = ort->rt_is_input;
 		rt->rt_iif = ort->rt_iif;
 		rt->rt_pmtu = ort->rt_pmtu;
+		rt->rt_mtu_locked = ort->rt_mtu_locked;
 
 		rt->rt_genid = rt_genid_ipv4(net);
 		rt->rt_flags = ort->rt_flags;
@@ -2411,6 +2421,8 @@ static int rt_fill_info(struct net *net,
 	memcpy(metrics, dst_metrics_ptr(&rt->dst), sizeof(metrics));
 	if (rt->rt_pmtu && expires)
 		metrics[RTAX_MTU - 1] = rt->rt_pmtu;
+	if (rt->rt_mtu_locked && expires)
+		metrics[RTAX_LOCK - 1] |= BIT(RTAX_MTU);
 	if (rtnetlink_put_metrics(skb, metrics) < 0)
 		goto nla_put_failure;
 
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -93,6 +93,7 @@ static int xfrm4_fill_dst(struct xfrm_ds
 	xdst->u.rt.rt_gateway = rt->rt_gateway;
 	xdst->u.rt.rt_uses_gateway = rt->rt_uses_gateway;
 	xdst->u.rt.rt_pmtu = rt->rt_pmtu;
+	xdst->u.rt.rt_mtu_locked = rt->rt_mtu_locked;
 	INIT_LIST_HEAD(&xdst->u.rt.rt_uncached);
 
 	return 0;
