Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsATj+hHKGT9kM0Vc1CTDebGHQYRKCbcm3+J6gDWbt74ZSNU7PuladLnIEhNKTLI9YSkNRk
ARC-Seal: i=1; a=rsa-sha256; t=1519981237; cv=none;
        d=google.com; s=arc-20160816;
        b=Jicn2LzEOUeIG/iDgVDsLqmGo73Ckt8cfuWYY7rAS1qksvk1Hs+12bw4GNDhLLzu+8
         JcQnjI0OTZeKfzE4ZY4mpVoLSfQHkKNu31cERmin1LTcsswhjllwwuEs/jK2Tj36/V1O
         0qyOaEOmDAtWjGGpPkrH0VVcDoyoM9/8pVLIBdkbDqxxc8XPQKQwLm03ir6I0iwDk1Dx
         7jlHGEv9sFvsM3Ltng8SqvML+RHGdVNis6UEEpifZSMSdVHa+CNdsVUXlITJMkJ0Qybm
         3YFYBdZhI9QqT0KDxbXpfSleIi11QZsJpk6cWhTOZkHYSKPb0KSuqPeJetIGdKJB2IYJ
         qg5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=udr7a0Ftb0ETNgXPbdDfOfRQ7bOeg061WJK7V7Lqn3c=;
        b=N/2cuiDqhM1I0JqIl7FKiYgY5bgPyU9gZ6+1W7rn1AJwFZDXuDhbLUFYGZoAFiYkdy
         CF+Kyv78UM5iut+AxrV56nekboelfW6qMxh202Ei1pWSC7LbNVf2CngylW9zu1CQSq0M
         80MEAmT+kV1UeRLCJEakbQoAwmk4Ie43CCvXOnpAYSpcy2/aZfjPFJQqS7EbH5f1Kbst
         9/WkQH88HobkdxdzCKS5hpby/BxVxi+ALWI8jwPxsDSn195hVFuVT1YM+1vErxsfU+Ak
         ZjqDIMNrmrnvWgyWD9DbpAQIqijmmZp279Jeatn1VmZ2uJ21VUmfM93wCGk3FtgRUOjT
         Agig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 032/115] vxlan: update skb dst pmtu on tx path
Date: Fri,  2 Mar 2018 09:50:35 +0100
Message-Id: <20180302084505.178420842@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815845709943715?=
X-GMAIL-MSGID: =?utf-8?q?1593815845709943715?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit a93bf0ff449064e6b7f44e58522e940f88c0d966 ]

Unlike ip tunnels, now vxlan doesn't do any pmtu update for
upper dst pmtu, even if it doesn't match the lower dst pmtu
any more.

The problem can be reproduced when reducing the vxlan lower
dev's pmtu when running netperf. In jianlin's testing, the
performance went to 1/7 of the previous.

This patch is to update the upper dst pmtu to match the lower
dst pmtu on tx path so that packets can be sent out even when
lower dev's pmtu has been changed.

It also works for metadata dst.

Note that this patch doesn't process any pmtu icmp packet.
But even in the future, the support for pmtu icmp packets
process of udp tunnels will also needs this.

The same thing will be done for geneve in another patch.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vxlan.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2155,6 +2155,13 @@ static void vxlan_xmit_one(struct sk_buf
 		}
 
 		ndst = &rt->dst;
+		if (skb_dst(skb)) {
+			int mtu = dst_mtu(ndst) - VXLAN_HEADROOM;
+
+			skb_dst(skb)->ops->update_pmtu(skb_dst(skb), NULL,
+						       skb, mtu);
+		}
+
 		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
 		ttl = ttl ? : ip4_dst_hoplimit(&rt->dst);
 		err = vxlan_build_skb(skb, ndst, sizeof(struct iphdr),
@@ -2190,6 +2197,13 @@ static void vxlan_xmit_one(struct sk_buf
 				goto out_unlock;
 		}
 
+		if (skb_dst(skb)) {
+			int mtu = dst_mtu(ndst) - VXLAN6_HEADROOM;
+
+			skb_dst(skb)->ops->update_pmtu(skb_dst(skb), NULL,
+						       skb, mtu);
+		}
+
 		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
 		ttl = ttl ? : ip6_dst_hoplimit(ndst);
 		skb_scrub_packet(skb, xnet);
