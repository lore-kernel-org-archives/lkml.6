Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+ivxQBO8ekOmpu1Sz9U+fXenTVdryfGfMDBTREceXwZDiaAoUQDAs+0xBPug9dps/y+Gel
ARC-Seal: i=1; a=rsa-sha256; t=1523399178; cv=none;
        d=google.com; s=arc-20160816;
        b=QqX8Mrx9auWjbNJgZTDyk7bTwWr4waV49eDbTbiQakP45P83rKaGIK6uHmSk8eqHJI
         Rozmd906kv2d48PDVOqj4HGLPhRh1CpjwdMOBFzFC/Dqn6wO/hfPCuUjLQRRlWYn4MRd
         2hr7oC+NWDKviB7EtZQMmWdAXgQHLbShT2N3FYAt5HzjRL6zVatxXX922Xbt5+Ss0kuw
         2vcmuO8KdlfTOaoDfjnMHEXSGXGbtIdrHl6tvjyH0fXAunH/5/oEilr0mF808iU0VGa9
         DY2RIZZk5dy1oMr8+bv83YFVXqFBAmaCu88H2s28nJdF2Djak1UXArdvGJOSOMNxHzzq
         m3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sW316FLomJkUk+i/sOFG9Sao4fzBExtnsBoOK7R/dZU=;
        b=EARGw13KIbNVQ36frOlpKq8WfqR+nTROlmTjOfzDvGQgu2bF91r0mkeIWg8zUL6HIh
         o5YYnZH+2gvIgNq5hBl7LpDjTmKO20FgBL5A2xIETHInzda+4pwEHD6eiTwheKJcj/RQ
         2jVuYz/pPUueM6qph5v6ZOVMoUgAEXM713a3bus3ntjY4BMVQu45gApNmAUgYCJS3bin
         XqDwf/7la6c6lvx8TkWqJbpjQjFgdUoaOqNxvpfgwhIwTaEXBbIKiKD9raJK+3otWKr/
         3XBhb1o6vy8Zrd0HMmyPsJVL4ZI8fXIXzXVzRDMqYi2H+LSJbGU2JPHH8v6MKC8OEcRJ
         5eoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tobias Brunner <tobias@strongswan.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 007/168] ipv6: Reinject IPv6 packets if IPsec policy matches after SNAT
Date: Wed, 11 Apr 2018 00:22:29 +0200
Message-Id: <20180410212800.540615075@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399817081333121?=
X-GMAIL-MSGID: =?utf-8?q?1597399817081333121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tobias Brunner <tobias@strongswan.org>


[ Upstream commit 09ee9dba9611cd382fd360a99ad1c2fa23bfdca8 ]

If SNAT modifies the source address the resulting packet might match
an IPsec policy, reinject the packet if that's the case.

The exact same thing is already done for IPv4.

Signed-off-by: Tobias Brunner <tobias@strongswan.org>
Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_output.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -138,6 +138,14 @@ static int ip6_finish_output(struct net
 		return ret;
 	}
 
+#if defined(CONFIG_NETFILTER) && defined(CONFIG_XFRM)
+	/* Policy lookup after SNAT yielded a new policy */
+	if (skb_dst(skb)->xfrm) {
+		IPCB(skb)->flags |= IPSKB_REROUTED;
+		return dst_output(net, sk, skb);
+	}
+#endif
+
 	if ((skb->len > ip6_skb_dst_mtu(skb) && !skb_is_gso(skb)) ||
 	    dst_allfrag(skb_dst(skb)) ||
 	    (IP6CB(skb)->frag_max_size && skb->len > IP6CB(skb)->frag_max_size))
