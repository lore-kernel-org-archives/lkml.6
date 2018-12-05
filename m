Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027A2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB10F20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB10F20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeLESOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:14:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbeLESO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:14:29 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1670D8BD23;
        Wed,  5 Dec 2018 18:14:29 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.32.181.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1C851001F54;
        Wed,  5 Dec 2018 18:14:27 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/4] net: use indirect call wrappers at GRO network layer
Date:   Wed,  5 Dec 2018 19:13:40 +0100
Message-Id: <bb128e449438274c93fa5d9db439c3e4e866336a.1544032300.git.pabeni@redhat.com>
In-Reply-To: <cover.1544032300.git.pabeni@redhat.com>
References: <cover.1544032300.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 05 Dec 2018 18:14:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids an indirect calls for L3 GRO receive path, both
for ipv4 and ipv6, if the latter is not compiled as a module.

Note that when IPv6 is compiled as builtin, it will be checked first,
so we have a single additional compare for the more common path.

v1 -> v2:
 - adapted to INDIRECT_CALL_ changes

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/inet_common.h |  2 ++
 net/core/dev.c            | 15 +++++++++++++--
 net/ipv6/ip6_offload.c    |  6 +++---
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index 3ca969cbd161..56e7592811ea 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -2,6 +2,8 @@
 #ifndef _INET_COMMON_H
 #define _INET_COMMON_H
 
+#include <linux/indirect_call_wrapper.h>
+
 extern const struct proto_ops inet_stream_ops;
 extern const struct proto_ops inet_dgram_ops;
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 04a6b7100aac..97c5ae41fd65 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -145,6 +145,7 @@
 #include <linux/sctp.h>
 #include <net/udp_tunnel.h>
 #include <linux/net_namespace.h>
+#include <linux/indirect_call_wrapper.h>
 
 #include "net-sysfs.h"
 
@@ -5320,6 +5321,8 @@ static void flush_all_backlogs(void)
 	put_online_cpus();
 }
 
+INDIRECT_CALLABLE_DECLARE(int inet_gro_complete(struct sk_buff *, int));
+INDIRECT_CALLABLE_DECLARE(int ipv6_gro_complete(struct sk_buff *, int));
 static int napi_gro_complete(struct sk_buff *skb)
 {
 	struct packet_offload *ptype;
@@ -5339,7 +5342,9 @@ static int napi_gro_complete(struct sk_buff *skb)
 		if (ptype->type != type || !ptype->callbacks.gro_complete)
 			continue;
 
-		err = ptype->callbacks.gro_complete(skb, 0);
+		err = INDIRECT_CALL_INET(ptype->callbacks.gro_complete,
+					 ipv6_gro_complete, inet_gro_complete,
+					 skb, 0);
 		break;
 	}
 	rcu_read_unlock();
@@ -5486,6 +5491,10 @@ static void gro_flush_oldest(struct list_head *head)
 	napi_gro_complete(oldest);
 }
 
+INDIRECT_CALLABLE_DECLARE(struct sk_buff *inet_gro_receive(struct list_head *,
+							   struct sk_buff *));
+INDIRECT_CALLABLE_DECLARE(struct sk_buff *ipv6_gro_receive(struct list_head *,
+							   struct sk_buff *));
 static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff *skb)
 {
 	u32 hash = skb_get_hash_raw(skb) & (GRO_HASH_BUCKETS - 1);
@@ -5535,7 +5544,9 @@ static enum gro_result dev_gro_receive(struct napi_struct *napi, struct sk_buff
 			NAPI_GRO_CB(skb)->csum_valid = 0;
 		}
 
-		pp = ptype->callbacks.gro_receive(gro_head, skb);
+		pp = INDIRECT_CALL_INET(ptype->callbacks.gro_receive,
+					ipv6_gro_receive, inet_gro_receive,
+					gro_head, skb);
 		break;
 	}
 	rcu_read_unlock();
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 70f525c33cb6..ff8b484d2258 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -164,8 +164,8 @@ static int ipv6_exthdrs_len(struct ipv6hdr *iph,
 	return len;
 }
 
-static struct sk_buff *ipv6_gro_receive(struct list_head *head,
-					struct sk_buff *skb)
+INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
+							 struct sk_buff *skb)
 {
 	const struct net_offload *ops;
 	struct sk_buff *pp = NULL;
@@ -301,7 +301,7 @@ static struct sk_buff *ip4ip6_gro_receive(struct list_head *head,
 	return inet_gro_receive(head, skb);
 }
 
-static int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
+INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
 {
 	const struct net_offload *ops;
 	struct ipv6hdr *iph = (struct ipv6hdr *)(skb->data + nhoff);
-- 
2.19.2

