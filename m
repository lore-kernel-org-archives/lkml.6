Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +sbyC1w9GVvCPwAAmS7hNA
	; Thu, 07 Jun 2018 14:13:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C5DAA608C1; Thu,  7 Jun 2018 14:13:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 579FF602FC;
	Thu,  7 Jun 2018 14:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 579FF602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932854AbeFGOLt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:11:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39557 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933169AbeFGOJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:41 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbF-0005hO-OD; Thu, 07 Jun 2018 15:09:13 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003F2-Mi; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David Ahern" <dsa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.310650612@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 352/410] net: Refactor rtable initialization
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

From: David Ahern <dsa@cumulusnetworks.com>

commit d08c4f355403840fad98d9918db51a7113f38ee8 upstream.

All callers to rt_dst_alloc have nearly the same initialization following
a successful allocation. Consolidate it into rt_dst_alloc.

Signed-off-by: David Ahern <dsa@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1435,12 +1435,33 @@ static void rt_set_nexthop(struct rtable
 }
 
 static struct rtable *rt_dst_alloc(struct net_device *dev,
+				   unsigned int flags, u16 type,
 				   bool nopolicy, bool noxfrm, bool will_cache)
 {
-	return dst_alloc(&ipv4_dst_ops, dev, 1, DST_OBSOLETE_FORCE_CHK,
-			 (will_cache ? 0 : (DST_HOST | DST_NOCACHE)) |
-			 (nopolicy ? DST_NOPOLICY : 0) |
-			 (noxfrm ? DST_NOXFRM : 0));
+	struct rtable *rt;
+
+	rt = dst_alloc(&ipv4_dst_ops, dev, 1, DST_OBSOLETE_FORCE_CHK,
+		       (will_cache ? 0 : (DST_HOST | DST_NOCACHE)) |
+		       (nopolicy ? DST_NOPOLICY : 0) |
+		       (noxfrm ? DST_NOXFRM : 0));
+
+	if (rt) {
+		rt->rt_genid = rt_genid_ipv4(dev_net(dev));
+		rt->rt_flags = flags;
+		rt->rt_type = type;
+		rt->rt_is_input = 0;
+		rt->rt_iif = 0;
+		rt->rt_pmtu = 0;
+		rt->rt_gateway = 0;
+		rt->rt_uses_gateway = 0;
+		INIT_LIST_HEAD(&rt->rt_uncached);
+
+		rt->dst.output = ip_output;
+		if (flags & RTCF_LOCAL)
+			rt->dst.input = ip_local_deliver;
+	}
+
+	return rt;
 }
 
 /* called in rcu_read_lock() section */
@@ -1480,6 +1501,7 @@ static int ip_route_input_mc(struct sk_b
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
 	struct rtable *rth;
+	unsigned int flags = RTCF_MULTICAST;
 	u32 itag = 0;
 	int err;
 
@@ -1487,7 +1509,10 @@ static int ip_route_input_mc(struct sk_b
 	if (err)
 		return err;
 
-	rth = rt_dst_alloc(dev_net(dev)->loopback_dev,
+	if (our)
+		flags |= RTCF_LOCAL;
+
+	rth = rt_dst_alloc(dev_net(dev)->loopback_dev, flags, RTN_MULTICAST,
 			   IN_DEV_CONF_GET(in_dev, NOPOLICY), false, false);
 	if (!rth)
 		return -ENOBUFS;
@@ -1496,20 +1521,7 @@ static int ip_route_input_mc(struct sk_b
 	rth->dst.tclassid = itag;
 #endif
 	rth->dst.output = ip_rt_bug;
-
-	rth->rt_genid	= rt_genid_ipv4(dev_net(dev));
-	rth->rt_flags	= RTCF_MULTICAST;
-	rth->rt_type	= RTN_MULTICAST;
 	rth->rt_is_input= 1;
-	rth->rt_iif	= 0;
-	rth->rt_pmtu	= 0;
-	rth->rt_gateway	= 0;
-	rth->rt_uses_gateway = 0;
-	INIT_LIST_HEAD(&rth->rt_uncached);
-	if (our) {
-		rth->dst.input= ip_local_deliver;
-		rth->rt_flags |= RTCF_LOCAL;
-	}
 
 #ifdef CONFIG_IP_MROUTE
 	if (!ipv4_is_local_multicast(daddr) && IN_DEV_MFORWARD(in_dev))
@@ -1650,7 +1662,7 @@ rt_cache:
 		}
 	}
 
-	rth = rt_dst_alloc(out_dev->dev,
+	rth = rt_dst_alloc(out_dev->dev, 0, res->type,
 			   IN_DEV_CONF_GET(in_dev, NOPOLICY),
 			   IN_DEV_CONF_GET(out_dev, NOXFRM), do_cache);
 	if (!rth) {
@@ -1658,19 +1670,10 @@ rt_cache:
 		goto cleanup;
 	}
 
-	rth->rt_genid = rt_genid_ipv4(dev_net(rth->dst.dev));
-	rth->rt_flags = 0;
-	rth->rt_type = res->type;
 	rth->rt_is_input = 1;
-	rth->rt_iif 	= 0;
-	rth->rt_pmtu	= 0;
-	rth->rt_gateway	= 0;
-	rth->rt_uses_gateway = 0;
-	INIT_LIST_HEAD(&rth->rt_uncached);
 	RT_CACHE_STAT_INC(in_slow_tot);
 
 	rth->dst.input = ip_forward;
-	rth->dst.output = ip_output;
 
 	rt_set_nexthop(rth, daddr, res, fnhe, res->fi, res->type, itag);
 	skb_dst_set(skb, &rth->dst);
@@ -1821,26 +1824,17 @@ local_input:
 		}
 	}
 
-	rth = rt_dst_alloc(net->loopback_dev,
+	rth = rt_dst_alloc(net->loopback_dev, flags | RTCF_LOCAL, res.type,
 			   IN_DEV_CONF_GET(in_dev, NOPOLICY), false, do_cache);
 	if (!rth)
 		goto e_nobufs;
 
-	rth->dst.input= ip_local_deliver;
 	rth->dst.output= ip_rt_bug;
 #ifdef CONFIG_IP_ROUTE_CLASSID
 	rth->dst.tclassid = itag;
 #endif
-
-	rth->rt_genid = rt_genid_ipv4(net);
-	rth->rt_flags 	= flags|RTCF_LOCAL;
-	rth->rt_type	= res.type;
 	rth->rt_is_input = 1;
-	rth->rt_iif	= 0;
-	rth->rt_pmtu	= 0;
-	rth->rt_gateway	= 0;
-	rth->rt_uses_gateway = 0;
-	INIT_LIST_HEAD(&rth->rt_uncached);
+
 	RT_CACHE_STAT_INC(in_slow_tot);
 	if (res.type == RTN_UNREACHABLE) {
 		rth->dst.input= ip_error;
@@ -2037,29 +2031,16 @@ rt_cache:
 	}
 
 add:
-	rth = rt_dst_alloc(dev_out,
+	rth = rt_dst_alloc(dev_out, flags, type,
 			   IN_DEV_CONF_GET(in_dev, NOPOLICY),
 			   IN_DEV_CONF_GET(in_dev, NOXFRM),
 			   do_cache);
 	if (!rth)
 		return ERR_PTR(-ENOBUFS);
 
-	rth->dst.output = ip_output;
-
-	rth->rt_genid = rt_genid_ipv4(dev_net(dev_out));
-	rth->rt_flags	= flags;
-	rth->rt_type	= type;
-	rth->rt_is_input = 0;
 	rth->rt_iif	= orig_oif ? : 0;
-	rth->rt_pmtu	= 0;
-	rth->rt_gateway = 0;
-	rth->rt_uses_gateway = 0;
-	INIT_LIST_HEAD(&rth->rt_uncached);
-
 	RT_CACHE_STAT_INC(out_slow_tot);
 
-	if (flags & RTCF_LOCAL)
-		rth->dst.input = ip_local_deliver;
 	if (flags & (RTCF_BROADCAST | RTCF_MULTICAST)) {
 		if (flags & RTCF_LOCAL &&
 		    !(dev_out->flags & IFF_LOOPBACK)) {
