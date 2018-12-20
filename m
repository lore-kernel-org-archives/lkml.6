Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A67C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016BD20449
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298480;
	bh=GhPge2/92qPQmmdxaOFk/BfPenVxyxKs9h/XOIYUYts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NqCqFeM405478n6jisPzORRSz3j5oAOnAoO/6mfkuO54GCY5EI+Wz6Llj/x5r1yTU
	 O50yXMgM43evknBXE+C+/DfYHizmyq12B4aJI9DlrdUYsQoN/HlZq5c5Iu8S55vHGH
	 6Sl5S5/ZB3G0VvLqSVMDljUCDyyOFAxXrbG+Xho8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbeLTJ3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:29:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732454AbeLTJ2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:28:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 003A020656;
        Thu, 20 Dec 2018 09:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298091;
        bh=GhPge2/92qPQmmdxaOFk/BfPenVxyxKs9h/XOIYUYts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j23ZUrPwBPvG0M8ilMvGbICCd9bnpREE/o1dA42Lpd5Oi3qUi5Dgj+xr5smzRBKgW
         /33A2UrPPSZ3p5XUEZEXTsWIx4zuCwHlOHLgvKvjoYocrLRekwLdT8RDz7qPsGbqQ1
         eR2cLpBZv7/+CfuGXMFO5KHgkPRhRDkImUHaN0Lg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 31/72] netfilter: ipset: Fix wraparound in hash:*net* types
Date:   Thu, 20 Dec 2018 10:18:30 +0100
Message-Id: <20181220085923.568987700@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0b8d9073539e217f79ec1bff65eb205ac796723d ]

Fix wraparound bug which could lead to memory exhaustion when adding an
x.x.x.x-255.255.255.255 range to any hash:*net* types.

Fixes Netfilter's bugzilla id #1212, reported by Thomas Schwark.

Fixes: 48596a8ddc46 ("netfilter: ipset: Fix adding an IPv4 range containing more than 2^31 addresses")
Signed-off-by: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipset/ip_set_hash_ipportnet.c  | 26 +++++++--------
 net/netfilter/ipset/ip_set_hash_net.c        |  9 +++--
 net/netfilter/ipset/ip_set_hash_netiface.c   |  9 +++--
 net/netfilter/ipset/ip_set_hash_netnet.c     | 28 ++++++++--------
 net/netfilter/ipset/ip_set_hash_netport.c    | 19 ++++++-----
 net/netfilter/ipset/ip_set_hash_netportnet.c | 35 ++++++++++----------
 6 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_hash_ipportnet.c b/net/netfilter/ipset/ip_set_hash_ipportnet.c
index a2f19b9906e9..543518384aa7 100644
--- a/net/netfilter/ipset/ip_set_hash_ipportnet.c
+++ b/net/netfilter/ipset/ip_set_hash_ipportnet.c
@@ -168,7 +168,7 @@ hash_ipportnet4_uadt(struct ip_set *set, struct nlattr *tb[],
 	struct hash_ipportnet4_elem e = { .cidr = HOST_MASK - 1 };
 	struct ip_set_ext ext = IP_SET_INIT_UEXT(set);
 	u32 ip = 0, ip_to = 0, p = 0, port, port_to;
-	u32 ip2_from = 0, ip2_to = 0, ip2_last, ip2;
+	u32 ip2_from = 0, ip2_to = 0, ip2;
 	bool with_ports = false;
 	u8 cidr;
 	int ret;
@@ -269,22 +269,21 @@ hash_ipportnet4_uadt(struct ip_set *set, struct nlattr *tb[],
 		ip_set_mask_from_to(ip2_from, ip2_to, e.cidr + 1);
 	}
 
-	if (retried)
+	if (retried) {
 		ip = ntohl(h->next.ip);
+		p = ntohs(h->next.port);
+		ip2 = ntohl(h->next.ip2);
+	} else {
+		p = port;
+		ip2 = ip2_from;
+	}
 	for (; ip <= ip_to; ip++) {
 		e.ip = htonl(ip);
-		p = retried && ip == ntohl(h->next.ip) ? ntohs(h->next.port)
-						       : port;
 		for (; p <= port_to; p++) {
 			e.port = htons(p);
-			ip2 = retried &&
-			      ip == ntohl(h->next.ip) &&
-			      p == ntohs(h->next.port)
-				? ntohl(h->next.ip2) : ip2_from;
-			while (ip2 <= ip2_to) {
+			do {
 				e.ip2 = htonl(ip2);
-				ip2_last = ip_set_range_to_cidr(ip2, ip2_to,
-								&cidr);
+				ip2 = ip_set_range_to_cidr(ip2, ip2_to, &cidr);
 				e.cidr = cidr - 1;
 				ret = adtfn(set, &e, &ext, &ext, flags);
 
@@ -292,9 +291,10 @@ hash_ipportnet4_uadt(struct ip_set *set, struct nlattr *tb[],
 					return ret;
 
 				ret = 0;
-				ip2 = ip2_last + 1;
-			}
+			} while (ip2++ < ip2_to);
+			ip2 = ip2_from;
 		}
+		p = port;
 	}
 	return ret;
 }
diff --git a/net/netfilter/ipset/ip_set_hash_net.c b/net/netfilter/ipset/ip_set_hash_net.c
index 1c67a1761e45..5449e23af13a 100644
--- a/net/netfilter/ipset/ip_set_hash_net.c
+++ b/net/netfilter/ipset/ip_set_hash_net.c
@@ -143,7 +143,7 @@ hash_net4_uadt(struct ip_set *set, struct nlattr *tb[],
 	ipset_adtfn adtfn = set->variant->adt[adt];
 	struct hash_net4_elem e = { .cidr = HOST_MASK };
 	struct ip_set_ext ext = IP_SET_INIT_UEXT(set);
-	u32 ip = 0, ip_to = 0, last;
+	u32 ip = 0, ip_to = 0;
 	int ret;
 
 	if (tb[IPSET_ATTR_LINENO])
@@ -193,16 +193,15 @@ hash_net4_uadt(struct ip_set *set, struct nlattr *tb[],
 	}
 	if (retried)
 		ip = ntohl(h->next.ip);
-	while (ip <= ip_to) {
+	do {
 		e.ip = htonl(ip);
-		last = ip_set_range_to_cidr(ip, ip_to, &e.cidr);
+		ip = ip_set_range_to_cidr(ip, ip_to, &e.cidr);
 		ret = adtfn(set, &e, &ext, &ext, flags);
 		if (ret && !ip_set_eexist(ret, flags))
 			return ret;
 
 		ret = 0;
-		ip = last + 1;
-	}
+	} while (ip++ < ip_to);
 	return ret;
 }
 
diff --git a/net/netfilter/ipset/ip_set_hash_netiface.c b/net/netfilter/ipset/ip_set_hash_netiface.c
index d417074f1c1a..f5164c1efce2 100644
--- a/net/netfilter/ipset/ip_set_hash_netiface.c
+++ b/net/netfilter/ipset/ip_set_hash_netiface.c
@@ -200,7 +200,7 @@ hash_netiface4_uadt(struct ip_set *set, struct nlattr *tb[],
 	ipset_adtfn adtfn = set->variant->adt[adt];
 	struct hash_netiface4_elem e = { .cidr = HOST_MASK, .elem = 1 };
 	struct ip_set_ext ext = IP_SET_INIT_UEXT(set);
-	u32 ip = 0, ip_to = 0, last;
+	u32 ip = 0, ip_to = 0;
 	int ret;
 
 	if (tb[IPSET_ATTR_LINENO])
@@ -255,17 +255,16 @@ hash_netiface4_uadt(struct ip_set *set, struct nlattr *tb[],
 
 	if (retried)
 		ip = ntohl(h->next.ip);
-	while (ip <= ip_to) {
+	do {
 		e.ip = htonl(ip);
-		last = ip_set_range_to_cidr(ip, ip_to, &e.cidr);
+		ip = ip_set_range_to_cidr(ip, ip_to, &e.cidr);
 		ret = adtfn(set, &e, &ext, &ext, flags);
 
 		if (ret && !ip_set_eexist(ret, flags))
 			return ret;
 
 		ret = 0;
-		ip = last + 1;
-	}
+	} while (ip++ < ip_to);
 	return ret;
 }
 
diff --git a/net/netfilter/ipset/ip_set_hash_netnet.c b/net/netfilter/ipset/ip_set_hash_netnet.c
index 7f9ae2e9645b..5a2b923bd81f 100644
--- a/net/netfilter/ipset/ip_set_hash_netnet.c
+++ b/net/netfilter/ipset/ip_set_hash_netnet.c
@@ -169,8 +169,8 @@ hash_netnet4_uadt(struct ip_set *set, struct nlattr *tb[],
 	ipset_adtfn adtfn = set->variant->adt[adt];
 	struct hash_netnet4_elem e = { };
 	struct ip_set_ext ext = IP_SET_INIT_UEXT(set);
-	u32 ip = 0, ip_to = 0, last;
-	u32 ip2 = 0, ip2_from = 0, ip2_to = 0, last2;
+	u32 ip = 0, ip_to = 0;
+	u32 ip2 = 0, ip2_from = 0, ip2_to = 0;
 	int ret;
 
 	if (tb[IPSET_ATTR_LINENO])
@@ -247,27 +247,27 @@ hash_netnet4_uadt(struct ip_set *set, struct nlattr *tb[],
 		ip_set_mask_from_to(ip2_from, ip2_to, e.cidr[1]);
 	}
 
-	if (retried)
+	if (retried) {
 		ip = ntohl(h->next.ip[0]);
+		ip2 = ntohl(h->next.ip[1]);
+	} else {
+		ip2 = ip2_from;
+	}
 
-	while (ip <= ip_to) {
+	do {
 		e.ip[0] = htonl(ip);
-		last = ip_set_range_to_cidr(ip, ip_to, &e.cidr[0]);
-		ip2 = (retried &&
-		       ip == ntohl(h->next.ip[0])) ? ntohl(h->next.ip[1])
-						   : ip2_from;
-		while (ip2 <= ip2_to) {
+		ip = ip_set_range_to_cidr(ip, ip_to, &e.cidr[0]);
+		do {
 			e.ip[1] = htonl(ip2);
-			last2 = ip_set_range_to_cidr(ip2, ip2_to, &e.cidr[1]);
+			ip2 = ip_set_range_to_cidr(ip2, ip2_to, &e.cidr[1]);
 			ret = adtfn(set, &e, &ext, &ext, flags);
 			if (ret && !ip_set_eexist(ret, flags))
 				return ret;
 
 			ret = 0;
-			ip2 = last2 + 1;
-		}
-		ip = last + 1;
-	}
+		} while (ip2++ < ip2_to);
+		ip2 = ip2_from;
+	} while (ip++ < ip_to);
 	return ret;
 }
 
diff --git a/net/netfilter/ipset/ip_set_hash_netport.c b/net/netfilter/ipset/ip_set_hash_netport.c
index e6ef382febe4..1a187be9ebc8 100644
--- a/net/netfilter/ipset/ip_set_hash_netport.c
+++ b/net/netfilter/ipset/ip_set_hash_netport.c
@@ -161,7 +161,7 @@ hash_netport4_uadt(struct ip_set *set, struct nlattr *tb[],
 	ipset_adtfn adtfn = set->variant->adt[adt];
 	struct hash_netport4_elem e = { .cidr = HOST_MASK - 1 };
 	struct ip_set_ext ext = IP_SET_INIT_UEXT(set);
-	u32 port, port_to, p = 0, ip = 0, ip_to = 0, last;
+	u32 port, port_to, p = 0, ip = 0, ip_to = 0;
 	bool with_ports = false;
 	u8 cidr;
 	int ret;
@@ -239,25 +239,26 @@ hash_netport4_uadt(struct ip_set *set, struct nlattr *tb[],
 		ip_set_mask_from_to(ip, ip_to, e.cidr + 1);
 	}
 
-	if (retried)
+	if (retried) {
 		ip = ntohl(h->next.ip);
-	while (ip <= ip_to) {
+		p = ntohs(h->next.port);
+	} else {
+		p = port;
+	}
+	do {
 		e.ip = htonl(ip);
-		last = ip_set_range_to_cidr(ip, ip_to, &cidr);
+		ip = ip_set_range_to_cidr(ip, ip_to, &cidr);
 		e.cidr = cidr - 1;
-		p = retried && ip == ntohl(h->next.ip) ? ntohs(h->next.port)
-						       : port;
 		for (; p <= port_to; p++) {
 			e.port = htons(p);
 			ret = adtfn(set, &e, &ext, &ext, flags);
-
 			if (ret && !ip_set_eexist(ret, flags))
 				return ret;
 
 			ret = 0;
 		}
-		ip = last + 1;
-	}
+		p = port;
+	} while (ip++ < ip_to);
 	return ret;
 }
 
diff --git a/net/netfilter/ipset/ip_set_hash_netportnet.c b/net/netfilter/ipset/ip_set_hash_netportnet.c
index 0e6e40c6f652..613e18e720a4 100644
--- a/net/netfilter/ipset/ip_set_hash_netportnet.c
+++ b/net/netfilter/ipset/ip_set_hash_netportnet.c
@@ -184,8 +184,8 @@ hash_netportnet4_uadt(struct ip_set *set, struct nlattr *tb[],
 	ipset_adtfn adtfn = set->variant->adt[adt];
 	struct hash_netportnet4_elem e = { };
 	struct ip_set_ext ext = IP_SET_INIT_UEXT(set);
-	u32 ip = 0, ip_to = 0, ip_last, p = 0, port, port_to;
-	u32 ip2_from = 0, ip2_to = 0, ip2_last, ip2;
+	u32 ip = 0, ip_to = 0, p = 0, port, port_to;
+	u32 ip2_from = 0, ip2_to = 0, ip2;
 	bool with_ports = false;
 	int ret;
 
@@ -288,33 +288,34 @@ hash_netportnet4_uadt(struct ip_set *set, struct nlattr *tb[],
 		ip_set_mask_from_to(ip2_from, ip2_to, e.cidr[1]);
 	}
 
-	if (retried)
+	if (retried) {
 		ip = ntohl(h->next.ip[0]);
+		p = ntohs(h->next.port);
+		ip2 = ntohl(h->next.ip[1]);
+	} else {
+		p = port;
+		ip2 = ip2_from;
+	}
 
-	while (ip <= ip_to) {
+	do {
 		e.ip[0] = htonl(ip);
-		ip_last = ip_set_range_to_cidr(ip, ip_to, &e.cidr[0]);
-		p = retried && ip == ntohl(h->next.ip[0]) ? ntohs(h->next.port)
-							  : port;
+		ip = ip_set_range_to_cidr(ip, ip_to, &e.cidr[0]);
 		for (; p <= port_to; p++) {
 			e.port = htons(p);
-			ip2 = (retried && ip == ntohl(h->next.ip[0]) &&
-			       p == ntohs(h->next.port)) ? ntohl(h->next.ip[1])
-							 : ip2_from;
-			while (ip2 <= ip2_to) {
+			do {
 				e.ip[1] = htonl(ip2);
-				ip2_last = ip_set_range_to_cidr(ip2, ip2_to,
-								&e.cidr[1]);
+				ip2 = ip_set_range_to_cidr(ip2, ip2_to,
+							   &e.cidr[1]);
 				ret = adtfn(set, &e, &ext, &ext, flags);
 				if (ret && !ip_set_eexist(ret, flags))
 					return ret;
 
 				ret = 0;
-				ip2 = ip2_last + 1;
-			}
+			} while (ip2++ < ip2_to);
+			ip2 = ip2_from;
 		}
-		ip = ip_last + 1;
-	}
+		p = port;
+	} while (ip++ < ip_to);
 	return ret;
 }
 
-- 
2.19.1



