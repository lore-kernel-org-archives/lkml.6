Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZojGfNlpRLQd67iZiYdtpeho1dCc/pq6rqOq4jLlAPwLkQz6hpAjLLO5+GygnJOUZZPd4YR
ARC-Seal: i=1; a=rsa-sha256; t=1525767260; cv=none;
        d=google.com; s=arc-20160816;
        b=WJMWBai0EvtlxB4KA4BK+3/YwBQwfV17OUtFSLfHUhxhXHrh8khliRLFnst71quQt8
         jrWJeIciucQli0jmzzFlelZs9Sms7AH4Ker2OTCzcGoyWJTvWEcAIqtYwbLRWj6BB3xD
         lG0p2dtA103eFtsTWmcWVnSMpGK/Quar0WSEjinOyRjswIsHyQCpa399OkLoCr4eJGij
         PI56/WfkwxNqAZKz1osww8JcLEYcbkW4VR6MX7luEXIwP//X4G+AKgmwhvQxqc/DtrZp
         2coNENKVqwY1RQWy/vJnwz40iNE+4u/xWRRrLLjHDUHvN6vfBE07ebmr1XyvwqT8xBDD
         TzQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=dHa7CWqpEFRb9RItBQnZheOYDXNQ6KHcdT0pSaowl7Y=;
        b=N8934HG22ZeGCLcBoTrXNmFw6ljboepOhob10lmJQbm914EaV7zSChXbE5rSeTumFA
         DaY4wDIdzf+cvrOpQRCVR/zvmfynutPqJxdOpYOlRKqg8UTzClkc1dvdo5qbA4OqdnBa
         9yG1By6dbj46dt2cHVyonk1o+VD4X2l9TF0RBopihCBvplqtX3RtucFvanFvwQ5Kf5P9
         snevX71v/4xQq9uLvmBry9BbNhRE3FMxplugjtr4A+t3Uh4mOuxiiHdC6DczmDDkUs6o
         L4V9RbPU5hcsHn7qFEiGq/W9LOHLy/PSiYeKbu/TkPzqLeoDKO63Gp3HKd2miYlZIRIt
         qpaw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qJFjd19b;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qJFjd19b;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roman Kapl <code@rkapl.cz>,
	Xin Long <lucien.xin@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	"David S. Miller" <davem@davemloft.net>,
	Thomas Deutschmann <whissi@gentoo.org>,
	Eddie Chapman <eddie@ehuk.net>
Subject: [PATCH 4.14 02/43] net: dont call update_pmtu unconditionally
Date: Tue,  8 May 2018 10:10:21 +0200
Message-Id: <20180508074004.381523237@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882930080521873?=
X-GMAIL-MSGID: =?utf-8?q?1599882930080521873?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

commit f15ca723c1ebe6c1a06bc95fda6b62cd87b44559 upstream.

Some dst_ops (e.g. md_dst_ops)) doesn't set this handler. It may result to:
"BUG: unable to handle kernel NULL pointer dereference at           (null)"

Let's add a helper to check if update_pmtu is available before calling it.

Fixes: 52a589d51f10 ("geneve: update skb dst pmtu on tx path")
Fixes: a93bf0ff4490 ("vxlan: update skb dst pmtu on tx path")
CC: Roman Kapl <code@rkapl.cz>
CC: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Thomas Deutschmann <whissi@gentoo.org>
Cc: Eddie Chapman <eddie@ehuk.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/ipoib/ipoib_cm.c |    3 +--
 drivers/net/geneve.c                    |    4 ++--
 drivers/net/vxlan.c                     |    6 ++----
 include/net/dst.h                       |    8 ++++++++
 net/ipv4/ip_tunnel.c                    |    3 +--
 net/ipv4/ip_vti.c                       |    2 +-
 net/ipv6/ip6_tunnel.c                   |    5 ++---
 net/ipv6/ip6_vti.c                      |    2 +-
 net/ipv6/sit.c                          |    4 ++--
 9 files changed, 20 insertions(+), 17 deletions(-)

--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -1447,8 +1447,7 @@ void ipoib_cm_skb_too_long(struct net_de
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 	int e = skb_queue_empty(&priv->cm.skb_queue);
 
-	if (skb_dst(skb))
-		skb_dst(skb)->ops->update_pmtu(skb_dst(skb), NULL, skb, mtu);
+	skb_dst_update_pmtu(skb, mtu);
 
 	skb_queue_tail(&priv->cm.skb_queue, skb);
 	if (e)
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -829,7 +829,7 @@ static int geneve_xmit_skb(struct sk_buf
 		int mtu = dst_mtu(&rt->dst) - sizeof(struct iphdr) -
 			  GENEVE_BASE_HLEN - info->options_len - 14;
 
-		skb_dst(skb)->ops->update_pmtu(skb_dst(skb), NULL, skb, mtu);
+		skb_dst_update_pmtu(skb, mtu);
 	}
 
 	sport = udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
@@ -875,7 +875,7 @@ static int geneve6_xmit_skb(struct sk_bu
 		int mtu = dst_mtu(dst) - sizeof(struct ipv6hdr) -
 			  GENEVE_BASE_HLEN - info->options_len - 14;
 
-		skb_dst(skb)->ops->update_pmtu(skb_dst(skb), NULL, skb, mtu);
+		skb_dst_update_pmtu(skb, mtu);
 	}
 
 	sport = udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2158,8 +2158,7 @@ static void vxlan_xmit_one(struct sk_buf
 		if (skb_dst(skb)) {
 			int mtu = dst_mtu(ndst) - VXLAN_HEADROOM;
 
-			skb_dst(skb)->ops->update_pmtu(skb_dst(skb), NULL,
-						       skb, mtu);
+			skb_dst_update_pmtu(skb, mtu);
 		}
 
 		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
@@ -2200,8 +2199,7 @@ static void vxlan_xmit_one(struct sk_buf
 		if (skb_dst(skb)) {
 			int mtu = dst_mtu(ndst) - VXLAN6_HEADROOM;
 
-			skb_dst(skb)->ops->update_pmtu(skb_dst(skb), NULL,
-						       skb, mtu);
+			skb_dst_update_pmtu(skb, mtu);
 		}
 
 		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -520,4 +520,12 @@ static inline struct xfrm_state *dst_xfr
 }
 #endif
 
+static inline void skb_dst_update_pmtu(struct sk_buff *skb, u32 mtu)
+{
+	struct dst_entry *dst = skb_dst(skb);
+
+	if (dst && dst->ops->update_pmtu)
+		dst->ops->update_pmtu(dst, NULL, skb, mtu);
+}
+
 #endif /* _NET_DST_H */
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -521,8 +521,7 @@ static int tnl_update_pmtu(struct net_de
 	else
 		mtu = skb_dst(skb) ? dst_mtu(skb_dst(skb)) : dev->mtu;
 
-	if (skb_dst(skb))
-		skb_dst(skb)->ops->update_pmtu(skb_dst(skb), NULL, skb, mtu);
+	skb_dst_update_pmtu(skb, mtu);
 
 	if (skb->protocol == htons(ETH_P_IP)) {
 		if (!skb_is_gso(skb) &&
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -209,7 +209,7 @@ static netdev_tx_t vti_xmit(struct sk_bu
 
 	mtu = dst_mtu(dst);
 	if (skb->len > mtu) {
-		skb_dst(skb)->ops->update_pmtu(skb_dst(skb), NULL, skb, mtu);
+		skb_dst_update_pmtu(skb, mtu);
 		if (skb->protocol == htons(ETH_P_IP)) {
 			icmp_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
 				  htonl(mtu));
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -652,7 +652,7 @@ ip4ip6_err(struct sk_buff *skb, struct i
 		if (rel_info > dst_mtu(skb_dst(skb2)))
 			goto out;
 
-		skb_dst(skb2)->ops->update_pmtu(skb_dst(skb2), NULL, skb2, rel_info);
+		skb_dst_update_pmtu(skb2, rel_info);
 	}
 	if (rel_type == ICMP_REDIRECT)
 		skb_dst(skb2)->ops->redirect(skb_dst(skb2), NULL, skb2);
@@ -1141,8 +1141,7 @@ route_lookup:
 		mtu = 576;
 	}
 
-	if (skb_dst(skb) && !t->parms.collect_md)
-		skb_dst(skb)->ops->update_pmtu(skb_dst(skb), NULL, skb, mtu);
+	skb_dst_update_pmtu(skb, mtu);
 	if (skb->len - t->tun_hlen - eth_hlen > mtu && !skb_is_gso(skb)) {
 		*pmtu = mtu;
 		err = -EMSGSIZE;
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -486,7 +486,7 @@ vti6_xmit(struct sk_buff *skb, struct ne
 
 	mtu = dst_mtu(dst);
 	if (!skb->ignore_df && skb->len > mtu) {
-		skb_dst(skb)->ops->update_pmtu(dst, NULL, skb, mtu);
+		skb_dst_update_pmtu(skb, mtu);
 
 		if (skb->protocol == htons(ETH_P_IPV6)) {
 			if (mtu < IPV6_MIN_MTU)
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -925,8 +925,8 @@ static netdev_tx_t ipip6_tunnel_xmit(str
 			df = 0;
 		}
 
-		if (tunnel->parms.iph.daddr && skb_dst(skb))
-			skb_dst(skb)->ops->update_pmtu(skb_dst(skb), NULL, skb, mtu);
+		if (tunnel->parms.iph.daddr)
+			skb_dst_update_pmtu(skb, mtu);
 
 		if (skb->len > mtu && !skb_is_gso(skb)) {
 			icmpv6_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
