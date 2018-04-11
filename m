Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+nsqSj/FwOsIJDNIWKuStbQ/830X5ajUCFqgH/XcJXAg5FADwUEUwrkWRiBZAt8Bx3j9Nb
ARC-Seal: i=1; a=rsa-sha256; t=1523472727; cv=none;
        d=google.com; s=arc-20160816;
        b=hNOEiKvM68/PRRTfN4rQUKBq/a2KVdsWQx5JtHQmKt67y56EMpwqjXEpGy6DyjqZiF
         ptr10TGNujoVtUSgrAK9FhDvlEtO3KnJpqRCsQb5MOBhqpLwHki9lbnGXRN92JUk8i17
         X32LSAMKg362XG7RF3OtohFPZezfpFu4wviQV3lXFdXV2Hh+N+A4CUEzepbBNLRHzgzo
         RBgyhIuJuZXULNIlHXRsoIvP4ggA8cWb6alU7g3f4ZA7E9KLPnQ09Ez7pnlH47052UgN
         HAfqvXSh37RZOzP2T89E9ApB+JbxImtcg7Iw3n5KhG/mtMBdg4AjWRxtFSh8TQ+b0lyX
         iiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=v99LmmLmHtT/JbdlaVW6iseUYHEm3X2s04JS+g29rNk=;
        b=N23gjHzzjVcUKIckQhFVlApUmd3OPjaKRdH6GZzpRO34ONQad11yevwW3DDS1eUxcg
         BBdHabwYZ33wOUG4eiFk2ecOVFRmXwdV3VLFWB6i4VzCWoYrMmC5fFQJmtQElXeRKAoW
         e7F1lj2doEPXFl2201ZIWxRaQ/VvOLiK/6oEbxkeUQCEzrNCx3FWbrUi1mjyI+xfcKc6
         HUa+KVNVZL6fMaY48WKN0gAZkdanFZZH2G2BPSuwvjm2tMY9cGf4Z0kQK6a+G+3Ub4Yb
         o9moOJiilgLIsJ6+rux4rVts5UBmZIR4UGglxR1IC9YE9yKUszKD4wj3fini0s8A7x7Z
         NMOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jeff Barnhill <0xeffeff@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 188/190] net/ipv6: Increment OUTxxx counters after netfilter hook
Date: Wed, 11 Apr 2018 20:37:14 +0200
Message-Id: <20180411183604.545567177@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476938428823719?=
X-GMAIL-MSGID: =?utf-8?q?1597476938428823719?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Barnhill <0xeffeff@gmail.com>


[ Upstream commit 71a1c915238c970cd9bdd5bf158b1279d6b6d55b ]

At the end of ip6_forward(), IPSTATS_MIB_OUTFORWDATAGRAMS and
IPSTATS_MIB_OUTOCTETS are incremented immediately before the NF_HOOK call
for NFPROTO_IPV6 / NF_INET_FORWARD.  As a result, these counters get
incremented regardless of whether or not the netfilter hook allows the
packet to continue being processed.  This change increments the counters
in ip6_forward_finish() so that it will not happen if the netfilter hook
chooses to terminate the packet, which is similar to how IPv4 works.

Signed-off-by: Jeff Barnhill <0xeffeff@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_output.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -340,6 +340,10 @@ static int ip6_forward_proxy_check(struc
 static inline int ip6_forward_finish(struct net *net, struct sock *sk,
 				     struct sk_buff *skb)
 {
+	struct dst_entry *dst = skb_dst(skb);
+
+	IP6_INC_STATS_BH(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTFORWDATAGRAMS);
+	IP6_ADD_STATS_BH(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTOCTETS, skb->len);
 	skb_sender_cpu_clear(skb);
 	return dst_output(net, sk, skb);
 }
@@ -534,8 +538,6 @@ int ip6_forward(struct sk_buff *skb)
 
 	hdr->hop_limit--;
 
-	IP6_INC_STATS_BH(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTFORWDATAGRAMS);
-	IP6_ADD_STATS_BH(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTOCTETS, skb->len);
 	return NF_HOOK(NFPROTO_IPV6, NF_INET_FORWARD,
 		       net, NULL, skb, skb->dev, dst->dev,
 		       ip6_forward_finish);
