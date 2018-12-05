Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A4CC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939B120892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939B120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeLESOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:14:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbeLESOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:14:31 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AF0030832C7;
        Wed,  5 Dec 2018 18:14:30 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.32.181.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C9981001F54;
        Wed,  5 Dec 2018 18:14:29 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/4] net: use indirect call wrappers at GRO transport layer
Date:   Wed,  5 Dec 2018 19:13:41 +0100
Message-Id: <fa7128969d8739cca9018c9577120fed8f44433a.1544032300.git.pabeni@redhat.com>
In-Reply-To: <cover.1544032300.git.pabeni@redhat.com>
References: <cover.1544032300.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 05 Dec 2018 18:14:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids an indirect call in the receive path for TCP and UDP
packets. TCP takes precedence on UDP, so that we have a single
additional conditional in the common case.

v1 -> v2:
 - adapted to INDIRECT_CALL_ changes

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/inet_common.h |  7 +++++++
 net/ipv4/af_inet.c        | 13 +++++++++++--
 net/ipv4/tcp_offload.c    |  6 ++++--
 net/ipv4/udp_offload.c    |  7 ++++---
 net/ipv6/ip6_offload.c    | 12 ++++++++++--
 net/ipv6/tcpv6_offload.c  |  7 ++++---
 net/ipv6/udp_offload.c    |  7 ++++---
 7 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index 56e7592811ea..975901a95c0f 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -56,4 +56,11 @@ static inline void inet_ctl_sock_destroy(struct sock *sk)
 		sock_release(sk->sk_socket);
 }
 
+#define indirect_call_gro_receive(f2, f1, cb, head, skb)	\
+({								\
+	unlikely(gro_recursion_inc_test(skb)) ?			\
+		NAPI_GRO_CB(skb)->flush |= 1, NULL :		\
+		INDIRECT_CALL_2(cb, f2, f1, head, skb);		\
+})
+
 #endif
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 326c422c22f8..0dfb72c46671 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1385,6 +1385,10 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 }
 EXPORT_SYMBOL(inet_gso_segment);
 
+INDIRECT_CALLABLE_DECLARE(struct sk_buff *tcp4_gro_receive(struct list_head *,
+							   struct sk_buff *));
+INDIRECT_CALLABLE_DECLARE(struct sk_buff *udp4_gro_receive(struct list_head *,
+							   struct sk_buff *));
 struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 {
 	const struct net_offload *ops;
@@ -1494,7 +1498,8 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 	skb_gro_pull(skb, sizeof(*iph));
 	skb_set_transport_header(skb, skb_gro_offset(skb));
 
-	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
+	pp = indirect_call_gro_receive(tcp4_gro_receive, udp4_gro_receive,
+				       ops->callbacks.gro_receive, head, skb);
 
 out_unlock:
 	rcu_read_unlock();
@@ -1556,6 +1561,8 @@ int inet_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 	return -EINVAL;
 }
 
+INDIRECT_CALLABLE_DECLARE(int tcp4_gro_complete(struct sk_buff *, int));
+INDIRECT_CALLABLE_DECLARE(int udp4_gro_complete(struct sk_buff *, int));
 int inet_gro_complete(struct sk_buff *skb, int nhoff)
 {
 	__be16 newlen = htons(skb->len - nhoff);
@@ -1581,7 +1588,9 @@ int inet_gro_complete(struct sk_buff *skb, int nhoff)
 	 * because any hdr with option will have been flushed in
 	 * inet_gro_receive().
 	 */
-	err = ops->callbacks.gro_complete(skb, nhoff + sizeof(*iph));
+	err = INDIRECT_CALL_2(ops->callbacks.gro_complete,
+			      tcp4_gro_complete, udp4_gro_complete,
+			      skb, nhoff + sizeof(*iph));
 
 out_unlock:
 	rcu_read_unlock();
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 870b0a335061..0fbf7d4df9da 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -10,6 +10,7 @@
  *	TCPv4 GSO/GRO support
  */
 
+#include <linux/indirect_call_wrapper.h>
 #include <linux/skbuff.h>
 #include <net/tcp.h>
 #include <net/protocol.h>
@@ -305,7 +306,8 @@ int tcp_gro_complete(struct sk_buff *skb)
 }
 EXPORT_SYMBOL(tcp_gro_complete);
 
-static struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
+INDIRECT_CALLABLE_SCOPE
+struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 {
 	/* Don't bother verifying checksum if we're going to flush anyway. */
 	if (!NAPI_GRO_CB(skb)->flush &&
@@ -318,7 +320,7 @@ static struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *
 	return tcp_gro_receive(head, skb);
 }
 
-static int tcp4_gro_complete(struct sk_buff *skb, int thoff)
+INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 {
 	const struct iphdr *iph = ip_hdr(skb);
 	struct tcphdr *th = tcp_hdr(skb);
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 0646d61f4fa8..9a141a6cf1a0 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -13,6 +13,7 @@
 #include <linux/skbuff.h>
 #include <net/udp.h>
 #include <net/protocol.h>
+#include <net/inet_common.h>
 
 static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
 	netdev_features_t features,
@@ -451,8 +452,8 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(udp_gro_receive);
 
-static struct sk_buff *udp4_gro_receive(struct list_head *head,
-					struct sk_buff *skb)
+INDIRECT_CALLABLE_SCOPE
+struct sk_buff *udp4_gro_receive(struct list_head *head, struct sk_buff *skb)
 {
 	struct udphdr *uh = udp_gro_udphdr(skb);
 
@@ -525,7 +526,7 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 }
 EXPORT_SYMBOL(udp_gro_complete);
 
-static int udp4_gro_complete(struct sk_buff *skb, int nhoff)
+INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 {
 	const struct iphdr *iph = ip_hdr(skb);
 	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index ff8b484d2258..e92837bd873b 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -164,6 +164,10 @@ static int ipv6_exthdrs_len(struct ipv6hdr *iph,
 	return len;
 }
 
+INDIRECT_CALLABLE_DECLARE(struct sk_buff *tcp6_gro_receive(struct list_head *,
+							   struct sk_buff *));
+INDIRECT_CALLABLE_DECLARE(struct sk_buff *udp6_gro_receive(struct list_head *,
+							   struct sk_buff *));
 INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 							 struct sk_buff *skb)
 {
@@ -260,7 +264,8 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 
 	skb_gro_postpull_rcsum(skb, iph, nlen);
 
-	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
+	pp = indirect_call_gro_receive(tcp6_gro_receive, udp6_gro_receive,
+				       ops->callbacks.gro_receive, head, skb);
 
 out_unlock:
 	rcu_read_unlock();
@@ -301,6 +306,8 @@ static struct sk_buff *ip4ip6_gro_receive(struct list_head *head,
 	return inet_gro_receive(head, skb);
 }
 
+INDIRECT_CALLABLE_DECLARE(int tcp6_gro_complete(struct sk_buff *, int));
+INDIRECT_CALLABLE_DECLARE(int udp6_gro_complete(struct sk_buff *, int));
 INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
 {
 	const struct net_offload *ops;
@@ -320,7 +327,8 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
 		goto out_unlock;
 
-	err = ops->callbacks.gro_complete(skb, nhoff);
+	err = INDIRECT_CALL_2(ops->callbacks.gro_complete,
+			      tcp6_gro_complete, udp6_gro_complete, skb, nhoff);
 
 out_unlock:
 	rcu_read_unlock();
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index e72947c99454..3179c425d7ff 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -9,14 +9,15 @@
  *
  *      TCPv6 GSO/GRO support
  */
+#include <linux/indirect_call_wrapper.h>
 #include <linux/skbuff.h>
 #include <net/protocol.h>
 #include <net/tcp.h>
 #include <net/ip6_checksum.h>
 #include "ip6_offload.h"
 
-static struct sk_buff *tcp6_gro_receive(struct list_head *head,
-					struct sk_buff *skb)
+INDIRECT_CALLABLE_SCOPE
+struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 {
 	/* Don't bother verifying checksum if we're going to flush anyway. */
 	if (!NAPI_GRO_CB(skb)->flush &&
@@ -29,7 +30,7 @@ static struct sk_buff *tcp6_gro_receive(struct list_head *head,
 	return tcp_gro_receive(head, skb);
 }
 
-static int tcp6_gro_complete(struct sk_buff *skb, int thoff)
+INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
 {
 	const struct ipv6hdr *iph = ipv6_hdr(skb);
 	struct tcphdr *th = tcp_hdr(skb);
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 828b2457f97b..83b11d0ac091 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -11,6 +11,7 @@
  */
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
+#include <linux/indirect_call_wrapper.h>
 #include <net/protocol.h>
 #include <net/ipv6.h>
 #include <net/udp.h>
@@ -114,8 +115,8 @@ static struct sk_buff *udp6_ufo_fragment(struct sk_buff *skb,
 	return segs;
 }
 
-static struct sk_buff *udp6_gro_receive(struct list_head *head,
-					struct sk_buff *skb)
+INDIRECT_CALLABLE_SCOPE
+struct sk_buff *udp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 {
 	struct udphdr *uh = udp_gro_udphdr(skb);
 
@@ -142,7 +143,7 @@ static struct sk_buff *udp6_gro_receive(struct list_head *head,
 	return NULL;
 }
 
-static int udp6_gro_complete(struct sk_buff *skb, int nhoff)
+INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 {
 	const struct ipv6hdr *ipv6h = ipv6_hdr(skb);
 	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
-- 
2.19.2

