Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbeFBIFh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 04:05:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:34679 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750756AbeFBIFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 04:05:30 -0400
From: Michal Kubecek <mkubecek@suse.cz>
Date: Sat, 2 Jun 2018 09:40:34 +0200
Subject: [PATCH net v2] ipv6: omit traffic class when calculating flow hash
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Tom Herbert <tom@herbertland.com>, David Ahern <dsahern@gmail.com>,
        Ido Schimmel <idosch@idosch.org>
Message-Id: <20180602080528.54B27A0C48@unicorn.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the code paths calculating flow hash for IPv6 use flowlabel member
of struct flowi6 which, despite its name, encodes both flow label and
traffic class. If traffic class changes within a TCP connection (as e.g.
ssh does), ECMP route can switch between path. It's also incosistent with
other code paths where ip6_flowlabel() (returning only flow label) is used
to feed the key.

Use only flow label everywhere, including one place where hash key is set
using ip6_flowinfo().

Fixes: 51ebd3181572 ("ipv6: add support of equal cost multipath (ECMP)")
Fixes: f70ea018da06 ("net: Add functions to get skb->hash based on flow structures")
Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
v2: introduce and use an inline helper as suggested by David Ahern

 include/net/ipv6.h        | 5 +++++
 net/core/flow_dissector.c | 2 +-
 net/ipv6/route.c          | 4 ++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 836f31af1369..7fbdc3e9e25d 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -906,6 +906,11 @@ static inline __be32 ip6_make_flowinfo(unsigned int tclass, __be32 flowlabel)
 	return htonl(tclass << IPV6_TCLASS_SHIFT) | flowlabel;
 }
 
+static inline u32 flowi6_get_flowlabel(const struct flowi6 *fl6)
+{
+	return (__force u32)(fl6->flowlabel & IPV6_FLOWLABEL_MASK);
+}
+
 /*
  *	Prototypes exported by ipv6
  */
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index d29f09bc5ff9..64e5cb8c0b3e 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1334,7 +1334,7 @@ __u32 __get_hash_from_flowi6(const struct flowi6 *fl6, struct flow_keys *keys)
 	keys->ports.src = fl6->fl6_sport;
 	keys->ports.dst = fl6->fl6_dport;
 	keys->keyid.keyid = fl6->fl6_gre_key;
-	keys->tags.flow_label = (__force u32)fl6->flowlabel;
+	keys->tags.flow_label = flowi6_get_flowlabel(fl6);
 	keys->basic.ip_proto = fl6->flowi6_proto;
 
 	return flow_hash_from_keys(keys);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index f4d61736c41a..b208cd597510 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1868,7 +1868,7 @@ static void ip6_multipath_l3_keys(const struct sk_buff *skb,
 	} else {
 		keys->addrs.v6addrs.src = key_iph->saddr;
 		keys->addrs.v6addrs.dst = key_iph->daddr;
-		keys->tags.flow_label = ip6_flowinfo(key_iph);
+		keys->tags.flow_label = ip6_flowlabel(key_iph);
 		keys->basic.ip_proto = key_iph->nexthdr;
 	}
 }
@@ -1889,7 +1889,7 @@ u32 rt6_multipath_hash(const struct net *net, const struct flowi6 *fl6,
 		} else {
 			hash_keys.addrs.v6addrs.src = fl6->saddr;
 			hash_keys.addrs.v6addrs.dst = fl6->daddr;
-			hash_keys.tags.flow_label = (__force u32)fl6->flowlabel;
+			hash_keys.tags.flow_label = flowi6_get_flowlabel(fl6);
 			hash_keys.basic.ip_proto = fl6->flowi6_proto;
 		}
 		break;
-- 
2.17.1
