Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu3onVWRgWv5YHXhzmEzJmlpt3uoAc5ZjFgHe33UG+yITiChvvpWgmgXInxR7fPSOTlubTl
ARC-Seal: i=1; a=rsa-sha256; t=1519981246; cv=none;
        d=google.com; s=arc-20160816;
        b=zIl5JrqKsRZzlHKhE310zzvWgKQrk98HdaVuWCw5HMecP0OduIVEya7iqkOmZNGqvi
         sbudKbn6EcZaovR5Z2tpZ0rwCHkkPExUbE9YfQjxQp+3ju01GrnxCtAL9iHXziKeHomG
         ip99an0xSCqoLSH5QDFQQGYkXS/Vkc8pDkshEcGN6PjpYU8ZXdtzgaz6/VlbemeEgRc/
         NdQ8wLAwa5PKEpnzqff2F3b6DnT679KMV9OslqayiCF0Qkg55EWRb0OpfkvLBva6QH89
         kXxwEIyzkxb9QBCghRd0ACn6Har2Y4YCzn9Ssm0DOVsfWo3BFAAUQm7e5M9iP7Nlg8Od
         dcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AFqBoBEddIB1GtEY3MeFYU1ZW9Cf66eeZb6GRRPonVw=;
        b=Ic9SujY7Lm4yWVNfiSK/JaukknFBVduBtd0ugstmmSAjmvNt5hfho2UmfkeE5rXn+f
         Rrk9eIi5pAWD/it0JopR3lB/d3iMqbZ/8IFJe3wFPssehlZLLRwj5xOK4FEmv4YRDHjj
         x4CtSBjxMIdnxI4ku3MMqcyM8HCx/XC9563OkcQTb8LZrGij9vwtT5FqkFpL6iBIFVMW
         DokTPImmQC5Kwk1Ilh064VUV4bBgj8QblJ+g8d1MB0ADLICrejBS0lvJhgb2pK5bHhUj
         bVvTmLaFg8XM711ISUliOABcoOWsyo6/Zb1JWuM33oxPUb3cMInhZyY55bdcyd6kDIy/
         L87Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jianlin Shi <jishi@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 035/115] ip6_tunnel: get the min mtu properly in ip6_tnl_xmit
Date: Fri,  2 Mar 2018 09:50:38 +0100
Message-Id: <20180302084505.297424141@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815595887426622?=
X-GMAIL-MSGID: =?utf-8?q?1593815855711562542?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit c9fefa08190fc879fb2e681035d7774e0a8c5170 ]

Now it's using IPV6_MIN_MTU as the min mtu in ip6_tnl_xmit, but
IPV6_MIN_MTU actually only works when the inner packet is ipv6.

With IPV6_MIN_MTU for ipv4 packets, the new pmtu for inner dst
couldn't be set less than 1280. It would cause tx_err and the
packet to be dropped when the outer dst pmtu is close to 1280.

Jianlin found it by running ipv4 traffic with the topo:

  (client) gre6 <---> eth1 (route) eth2 <---> gre6 (server)

After changing eth2 mtu to 1300, the performance became very
low, or the connection was even broken. The issue also affects
ip4ip6 and ip6ip6 tunnels.

So if the inner packet is ipv4, 576 should be considered as the
min mtu.

Note that for ip4ip6 and ip6ip6 tunnels, the inner packet can
only be ipv4 or ipv6, but for gre6 tunnel, it may also be ARP.
This patch using 576 as the min mtu for non-ipv6 packet works
for all those cases.

Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_tunnel.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1131,8 +1131,13 @@ route_lookup:
 		max_headroom += 8;
 		mtu -= 8;
 	}
-	if (mtu < IPV6_MIN_MTU)
-		mtu = IPV6_MIN_MTU;
+	if (skb->protocol == htons(ETH_P_IPV6)) {
+		if (mtu < IPV6_MIN_MTU)
+			mtu = IPV6_MIN_MTU;
+	} else if (mtu < 576) {
+		mtu = 576;
+	}
+
 	if (skb_dst(skb) && !t->parms.collect_md)
 		skb_dst(skb)->ops->update_pmtu(skb_dst(skb), NULL, skb, mtu);
 	if (skb->len - t->tun_hlen - eth_hlen > mtu && !skb_is_gso(skb)) {
