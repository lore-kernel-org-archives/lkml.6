Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3726165-1519676338-2-4254499247350940148
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519676337; b=UUxohEfX/q0x9ZSoWJTQR1Cbw6/Ha9YsJH99mFrC5eDxZJi
    e+lYkZTHKHuG/4cfVvs5B2QsswhFWjnScrmBVAGxm5e2/lRAtgaMBCUNtPbeSwA7
    y2h+o/3jcSYWqzEA9GJpbtIwTh0jl3JSCcHYvz1zDXd0ZxGS4RSZ7vN+bogMJUgr
    JNSNc4EesD6LBf+OQawwTJfr1S5UKjlTGKAMawcITedDzD7RgER2pEcS045/NGZp
    O/YMS5yVgfbxOb90veplSgVHMW0OxsJInDJNZ3h/4rpjXu2gJPSuSD9ljhjifF/8
    cRi1H3yE2jFhXU0/Vg9Da4vtC7lavM8P0wMpCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519676337; bh=jv6/mz5uTwVy7AstFoJ9C76zKJ
    9+QOWjVOBOTViBw4o=; b=TFtIyI1wg3f65F41Zr8z2n557D2BqaDABiVIwDF6jx
    DZOelkA24bzw5SjEiRdyXiYkVJWqcaQpkmOKbtup5PvPa8QtlKbMEpae/pZAE6dg
    MiCXDfq/ikd+g4siGk6XGlWTyK9K/pOFCHDI7Y7P+G/Sgu/A4scKVH2+HR+Z2Ip+
    GJEUDTjNDrWiEiyHu5/pZvJQjRXC49GQHYrrtbp+HucMnGomNAOgGmYiSwmNYzi/
    ZoCCrZcC3t2cVB32k7RG3mSVv0BXz9YLu4GiNX1Oewyny/TDyf6Snuj1ANuBZ2V1
    QHseG033Ehja//RISGY7BSxRI32OZYGr3vDW0ZZmalkA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeBZURX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:17:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59838 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeBZURV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:17:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 04/22] ip_tunnel: replace dst_cache with generic implementation
Date: Mon, 26 Feb 2018 21:16:04 +0100
Message-Id: <20180226201558.929968812@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit e09acddf873bf775b208b452a4c3a3fd26fa9427 upstream.

The current ip_tunnel cache implementation is prone to a race
that will cause the wrong dst to be cached on cuncurrent dst cache
miss and ip tunnel update via netlink.

Replacing with the generic implementation fix the issue.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Suggested-and-acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/ip_tunnels.h |    9 +----
 net/ipv4/Kconfig         |    1 
 net/ipv4/ip_tunnel.c     |   78 +++++++----------------------------------------
 net/ipv6/sit.c           |   17 +++++-----
 4 files changed, 25 insertions(+), 80 deletions(-)

--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -13,6 +13,7 @@
 #include <net/netns/generic.h>
 #include <net/rtnetlink.h>
 #include <net/lwtunnel.h>
+#include <net/dst_cache.h>
 
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ipv6.h>
@@ -85,11 +86,6 @@ struct ip_tunnel_prl_entry {
 	struct rcu_head			rcu_head;
 };
 
-struct ip_tunnel_dst {
-	struct dst_entry __rcu 		*dst;
-	__be32				 saddr;
-};
-
 struct metadata_dst;
 
 struct ip_tunnel {
@@ -108,7 +104,7 @@ struct ip_tunnel {
 	int		tun_hlen;	/* Precalculated header length */
 	int		mlink;
 
-	struct ip_tunnel_dst __percpu *dst_cache;
+	struct dst_cache dst_cache;
 
 	struct ip_tunnel_parm parms;
 
@@ -248,7 +244,6 @@ int ip_tunnel_changelink(struct net_devi
 int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
 		      struct ip_tunnel_parm *p);
 void ip_tunnel_setup(struct net_device *dev, int net_id);
-void ip_tunnel_dst_reset_all(struct ip_tunnel *t);
 int ip_tunnel_encap_setup(struct ip_tunnel *t,
 			  struct ip_tunnel_encap *ipencap);
 
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -186,6 +186,7 @@ config NET_IPGRE_DEMUX
 
 config NET_IP_TUNNEL
 	tristate
+	select DST_CACHE
 	default n
 
 config NET_IPGRE
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -69,61 +69,6 @@ static unsigned int ip_tunnel_hash(__be3
 			 IP_TNL_HASH_BITS);
 }
 
-static void __tunnel_dst_set(struct ip_tunnel_dst *idst,
-			     struct dst_entry *dst, __be32 saddr)
-{
-	struct dst_entry *old_dst;
-
-	dst_clone(dst);
-	old_dst = xchg((__force struct dst_entry **)&idst->dst, dst);
-	dst_release(old_dst);
-	idst->saddr = saddr;
-}
-
-static noinline void tunnel_dst_set(struct ip_tunnel *t,
-			   struct dst_entry *dst, __be32 saddr)
-{
-	__tunnel_dst_set(raw_cpu_ptr(t->dst_cache), dst, saddr);
-}
-
-static void tunnel_dst_reset(struct ip_tunnel *t)
-{
-	tunnel_dst_set(t, NULL, 0);
-}
-
-void ip_tunnel_dst_reset_all(struct ip_tunnel *t)
-{
-	int i;
-
-	for_each_possible_cpu(i)
-		__tunnel_dst_set(per_cpu_ptr(t->dst_cache, i), NULL, 0);
-}
-EXPORT_SYMBOL(ip_tunnel_dst_reset_all);
-
-static struct rtable *tunnel_rtable_get(struct ip_tunnel *t,
-					u32 cookie, __be32 *saddr)
-{
-	struct ip_tunnel_dst *idst;
-	struct dst_entry *dst;
-
-	rcu_read_lock();
-	idst = raw_cpu_ptr(t->dst_cache);
-	dst = rcu_dereference(idst->dst);
-	if (dst && !atomic_inc_not_zero(&dst->__refcnt))
-		dst = NULL;
-	if (dst) {
-		if (!dst->obsolete || dst->ops->check(dst, cookie)) {
-			*saddr = idst->saddr;
-		} else {
-			tunnel_dst_reset(t);
-			dst_release(dst);
-			dst = NULL;
-		}
-	}
-	rcu_read_unlock();
-	return (struct rtable *)dst;
-}
-
 static bool ip_tunnel_key_match(const struct ip_tunnel_parm *p,
 				__be16 flags, __be32 key)
 {
@@ -382,7 +327,8 @@ static int ip_tunnel_bind_dev(struct net
 
 		if (!IS_ERR(rt)) {
 			tdev = rt->dst.dev;
-			tunnel_dst_set(tunnel, &rt->dst, fl4.saddr);
+			dst_cache_set_ip4(&tunnel->dst_cache, &rt->dst,
+					  fl4.saddr);
 			ip_rt_put(rt);
 		}
 		if (dev->type != ARPHRD_ETHER)
@@ -733,7 +679,8 @@ void ip_tunnel_xmit(struct sk_buff *skb,
 	if (ip_tunnel_encap(skb, tunnel, &protocol, &fl4) < 0)
 		goto tx_error;
 
-	rt = connected ? tunnel_rtable_get(tunnel, 0, &fl4.saddr) : NULL;
+	rt = connected ? dst_cache_get_ip4(&tunnel->dst_cache, &fl4.saddr) :
+			 NULL;
 
 	if (!rt) {
 		rt = ip_route_output_key(tunnel->net, &fl4);
@@ -743,7 +690,8 @@ void ip_tunnel_xmit(struct sk_buff *skb,
 			goto tx_error;
 		}
 		if (connected)
-			tunnel_dst_set(tunnel, &rt->dst, fl4.saddr);
+			dst_cache_set_ip4(&tunnel->dst_cache, &rt->dst,
+					  fl4.saddr);
 	}
 
 	if (rt->dst.dev == dev) {
@@ -841,7 +789,7 @@ static void ip_tunnel_update(struct ip_t
 		if (set_mtu)
 			dev->mtu = mtu;
 	}
-	ip_tunnel_dst_reset_all(t);
+	dst_cache_reset(&t->dst_cache);
 	netdev_state_change(dev);
 }
 
@@ -980,7 +928,7 @@ static void ip_tunnel_dev_free(struct ne
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 
 	gro_cells_destroy(&tunnel->gro_cells);
-	free_percpu(tunnel->dst_cache);
+	dst_cache_destroy(&tunnel->dst_cache);
 	free_percpu(dev->tstats);
 	free_netdev(dev);
 }
@@ -1174,15 +1122,15 @@ int ip_tunnel_init(struct net_device *de
 	if (!dev->tstats)
 		return -ENOMEM;
 
-	tunnel->dst_cache = alloc_percpu(struct ip_tunnel_dst);
-	if (!tunnel->dst_cache) {
+	err = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
+	if (err) {
 		free_percpu(dev->tstats);
-		return -ENOMEM;
+		return err;
 	}
 
 	err = gro_cells_init(&tunnel->gro_cells, dev);
 	if (err) {
-		free_percpu(tunnel->dst_cache);
+		dst_cache_destroy(&tunnel->dst_cache);
 		free_percpu(dev->tstats);
 		return err;
 	}
@@ -1212,7 +1160,7 @@ void ip_tunnel_uninit(struct net_device
 	if (itn->fb_tunnel_dev != dev)
 		ip_tunnel_del(itn, netdev_priv(dev));
 
-	ip_tunnel_dst_reset_all(tunnel);
+	dst_cache_reset(&tunnel->dst_cache);
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_uninit);
 
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -475,7 +475,7 @@ static void ipip6_tunnel_uninit(struct n
 		ipip6_tunnel_unlink(sitn, tunnel);
 		ipip6_tunnel_del_prl(tunnel, NULL);
 	}
-	ip_tunnel_dst_reset_all(tunnel);
+	dst_cache_reset(&tunnel->dst_cache);
 	dev_put(dev);
 }
 
@@ -1098,7 +1098,7 @@ static void ipip6_tunnel_update(struct i
 		t->parms.link = p->link;
 		ipip6_tunnel_bind_dev(t->dev);
 	}
-	ip_tunnel_dst_reset_all(t);
+	dst_cache_reset(&t->dst_cache);
 	netdev_state_change(t->dev);
 }
 
@@ -1129,7 +1129,7 @@ static int ipip6_tunnel_update_6rd(struc
 	t->ip6rd.relay_prefix = relay_prefix;
 	t->ip6rd.prefixlen = ip6rd->prefixlen;
 	t->ip6rd.relay_prefixlen = ip6rd->relay_prefixlen;
-	ip_tunnel_dst_reset_all(t);
+	dst_cache_reset(&t->dst_cache);
 	netdev_state_change(t->dev);
 	return 0;
 }
@@ -1283,7 +1283,7 @@ ipip6_tunnel_ioctl(struct net_device *de
 			err = ipip6_tunnel_add_prl(t, &prl, cmd == SIOCCHGPRL);
 			break;
 		}
-		ip_tunnel_dst_reset_all(t);
+		dst_cache_reset(&t->dst_cache);
 		netdev_state_change(dev);
 		break;
 
@@ -1344,7 +1344,7 @@ static void ipip6_dev_free(struct net_de
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
 
-	free_percpu(tunnel->dst_cache);
+	dst_cache_destroy(&tunnel->dst_cache);
 	free_percpu(dev->tstats);
 	free_netdev(dev);
 }
@@ -1377,6 +1377,7 @@ static void ipip6_tunnel_setup(struct ne
 static int ipip6_tunnel_init(struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
+	int err;
 
 	tunnel->dev = dev;
 	tunnel->net = dev_net(dev);
@@ -1387,11 +1388,11 @@ static int ipip6_tunnel_init(struct net_
 	if (!dev->tstats)
 		return -ENOMEM;
 
-	tunnel->dst_cache = alloc_percpu(struct ip_tunnel_dst);
-	if (!tunnel->dst_cache) {
+	err = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
+	if (err) {
 		free_percpu(dev->tstats);
 		dev->tstats = NULL;
-		return -ENOMEM;
+		return err;
 	}
 
 	return 0;
