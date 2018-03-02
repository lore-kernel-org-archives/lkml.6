Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv+1Sz+8sykEkPA3wpz8Oxh+a4dKaJzcf1W51bw2woXIWdzJzRc84IVPMRlBwxGDI+BC/Q9
ARC-Seal: i=1; a=rsa-sha256; t=1519980998; cv=none;
        d=google.com; s=arc-20160816;
        b=eqOMNGEao272Cv7foezMLhTk875QhFtC9RSOkcDeBsgrfxDMp0bgTnv3NdeZ169Ww3
         NsPtAzPRQBOx5N6FVfcNA2WI8n6dJY8NnKveVLUtLoNsODaYN2moGXiR5/C2tLP/ne+q
         /CyWG906RZVewiI2TYenmqrR85R7P1vtqJ4zOFkby191rSnUC1CFCDl06Ipys/F1EY62
         C+m8HIh5Ub46yg3Q7VDyhyVb+RqR/v/Ql3tRPUpwW4WuGzVwFNKUvr4b1ARREc4Owh6e
         U8xXrGVtDCBKEfpP/iiz2uvZI6+pHzstWgoIVoXgnNXfUMjFrrUWmf1UKAQfs6/veLy7
         3ysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4wLwVlQIM3CGpx6UeH2XjMVhvqhSMenuqTEvKydJmMs=;
        b=FmFCITlT4e6tTugcnw3UDCPsnOX0oGvSMdfiJCUXgqDdQdnn4L8IeiMTnMZooSpwG7
         rNZFOGBfrprHqqmngPfwPJ9SV8QhLQvq7+HmOyKzF4itEosclpSrJMGijdJLnyyAX/BU
         gyCYSTy+t6rSqdanZlVBeFR6pkmVtfGZN34AO3aIiUEdj3WD6ElOK8QBDutQkwyLO8BM
         jF/llyztUqZPq/xo0CrhB+axMqd9hzndvvh3ukW7B7whMcfOC0jhSMspAp1uEbeh1SIR
         tpeTJllSr6n2bg7gX19pSWcpQ96E7iP17DaryDmM+Ui9uxOMhY4WGoK+vzkPpUklFqww
         j53w==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 20/56] ip6_tunnel: get the min mtu properly in ip6_tnl_xmit
Date: Fri,  2 Mar 2018 09:51:06 +0100
Message-Id: <20180302084450.627458283@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815595887426622?=
X-GMAIL-MSGID: =?utf-8?q?1593815595887426622?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_tunnel.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1127,8 +1127,13 @@ route_lookup:
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
