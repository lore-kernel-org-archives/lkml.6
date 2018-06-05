Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeFELlW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 07:41:22 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:36225 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbeFELlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 07:41:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: =?UTF-8?q?M=C3=A1t=C3=A9=20Eckl?= <ecklm94@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] netfilter: provide udp*_lib_lookup for nf_tproxy
Date: Tue,  5 Jun 2018 13:40:34 +0200
Message-Id: <20180605114056.1239571-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:wYkpbO36jcC5A4WjzmMP9ax+aFAXTqmEryXoaUE8v855ScIsXaI
 SD2me0ADicawpT0vfjCl0Yi711ekZ69d/voZqW0rhSUjyhSQBo/pO2OQDaOgqMCq9hxw7vi
 N4Ek5nuXl/0Ijs7IS7z98Vurm6OpSxVLtFXeXM+T4vpGDtsUvc2Xlq31Ccq4nASVre2qP6X
 VaudNr0cm52fayeCDigew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B+qjXnKI+lE=:BBYuU06P97XgNzKq7TIrTw
 M6/XPLAntVIV+NJWyvACbD04cab0C7Hnzxi+T27OCCFagjLjfv/0nrrOVVlkmQg/JkrpCaTty
 GC9lPBFHs7rk0jJfYy6a7sXGM8iD2KJag0MA28py0nLWpamJZrYp1pe/fTAsREIOMlpk7RsWj
 qCoSfxRVhMaIeG/THpfz15XE3Pe817eSKd1NfxDCsqmMOEFKwFvb0tphwy7kF0gmC3u2oRZ1E
 s0LEjpitQ1RaTGJb2W+PeTFrPEUDQLEVSV8XVt7M0MER3bbCdxGpoS5ZWidBLMMMvGda0yz3K
 xICup0VgAS6hjfq9z7P9T+meLWkE9NdrR9j5zh0Bmptqje1f/kdI/GGjhFw02ViFF0dNiYmkc
 zlGiAIyCpf1PjLgtgsGaIlViuuIjChgJDK+JiRwKaAESph1betUU5oEdMecc/sRZIYuz4n31d
 q2AXlEWQuxPtGL8bxLUxH+VkPrRI6GWGxYiCovjpDfiMzLD1vFJuKvE8GWGcrJi2AHBCAn1QT
 6GcEHGJLKYjxWDzuGhIf5/1lwLfeLQMjDwlUewERZlD64KleyXNglu4Oy4d15Rr9CyBYT60WS
 Gwc0DJYjcXe/9n1Aa1IXkEEphMs8PQ63wQtHVJ1Qqymfp0rf9mt/kcsvlip67JtmPAovvoGgS
 T2oshrkpLj52SBmFUA2k00zsnF1HPWLg9Ads/q6rWmtCMOyHqxfBR/zfT1mjx3NVwq+s=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is now possible to enable the libified nf_tproxy modules without
also enabling NETFILTER_XT_TARGET_TPROXY, which throws off the
ifdef logic in the udp core code:

net/ipv6/netfilter/nf_tproxy_ipv6.o: In function `nf_tproxy_get_sock_v6':
nf_tproxy_ipv6.c:(.text+0x1a8): undefined reference to `udp6_lib_lookup'
net/ipv4/netfilter/nf_tproxy_ipv4.o: In function `nf_tproxy_get_sock_v4':
nf_tproxy_ipv4.c:(.text+0x3d0): undefined reference to `udp4_lib_lookup'

We can actually simplify the conditions now to provide the two functions
exactly when they are needed.

Fixes: 45ca4e0cf273 ("netfilter: Libify xt_TPROXY")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/ipv4/udp.c | 4 +---
 net/ipv6/udp.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 4f16e5d71875..3365362cac88 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -544,9 +544,7 @@ EXPORT_SYMBOL_GPL(udp4_lib_lookup_skb);
 /* Must be called under rcu_read_lock().
  * Does increment socket refcount.
  */
-#if IS_ENABLED(CONFIG_NETFILTER_XT_MATCH_SOCKET) || \
-    IS_ENABLED(CONFIG_NETFILTER_XT_TARGET_TPROXY) || \
-    IS_ENABLED(CONFIG_NF_SOCKET_IPV4)
+#if IS_ENABLED(CONFIG_NF_TPROXY_IPV4) || IS_ENABLED(CONFIG_NF_SOCKET_IPV4)
 struct sock *udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport,
 			     __be32 daddr, __be16 dport, int dif)
 {
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 967acff95bbe..164afd31aebf 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -285,9 +285,7 @@ EXPORT_SYMBOL_GPL(udp6_lib_lookup_skb);
 /* Must be called under rcu_read_lock().
  * Does increment socket refcount.
  */
-#if IS_ENABLED(CONFIG_NETFILTER_XT_MATCH_SOCKET) || \
-    IS_ENABLED(CONFIG_NETFILTER_XT_TARGET_TPROXY) || \
-    IS_ENABLED(CONFIG_NF_SOCKET_IPV6)
+#if IS_ENABLED(CONFIG_NF_TPROXY_IPV6) || IS_ENABLED(CONFIG_NF_SOCKET_IPV6)
 struct sock *udp6_lib_lookup(struct net *net, const struct in6_addr *saddr, __be16 sport,
 			     const struct in6_addr *daddr, __be16 dport, int dif)
 {
-- 
2.9.0
