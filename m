Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48bC3Pp3uBMCKWNTG93ai15cxsh2DFFSMsszLzkyuR4GiGuOFYy6oP92G+MNErxMQeWsTNF
ARC-Seal: i=1; a=rsa-sha256; t=1523399687; cv=none;
        d=google.com; s=arc-20160816;
        b=Jdykm8wTLe2utfGasgDlpTwRLQGCYJsE11PogiGFpSGgXJds5XZKxqLwSig+d2LgyO
         3UOsfgk19+qZI+UtaaM9dM5rtXb8ZGuVh09nU3XPyHpkkLCvPf1JRstjk2AjRzgyK3tu
         WW9+Axmw3WUR9e4FYlSqc9fOPQinrm5V9gWtFMk3WcZOJzgSAZV+1IZeBGiXjp5ejPPX
         cuA/3bFsXt7tuszwa/+nj3DaNL1Q3dyVlsfvfoZ/vvcYj6HMwfyBstb7gFFxqdS7kcfk
         UzSFQU4BykhvKZphPXn9lns02+1X/HzIbf7ALIHFCceeeCHqIt68O+IqAtnpswwvC5ry
         ZZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=i/yjlwbJzQYgtWzstrzij0iLAzvbfw6Co49Gm+5tvoI=;
        b=DYCLQp3gt/8hBjhZkyX8uIwwH7VeNn85MELHgE66WAVO9YyUWVVQrNDs+53GY73U3p
         +07njv2A/zhMYfjD4noFosRCRzsvAWk6JJ5QSufqI5ViJbXRV9dOF8gJXUH+0Ax26Uu9
         YyjhF1gkB2jTDQZgGqyREKLLsb8GdKxQxwzeE8J1i1+lgVu9GPZuVaNKbhhuhq6wxSgp
         xo84v8AixsJidje8re0Ay+y9oPa8nMXzh+6uXwCaVuRNa1DowphCas7j0fq18EgXvWTt
         hytknQiUBPnxs1eJTJEpku0cQy2ji7O9cc9UtAhro6C2U2VkymKJ0fWXCZrwXrjib5H5
         C9Uw==
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
Subject: [PATCH 4.14 007/138] ipv6: Reinject IPv6 packets if IPsec policy matches after SNAT
Date: Wed, 11 Apr 2018 00:23:17 +0200
Message-Id: <20180410212903.008087216@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399817081333121?=
X-GMAIL-MSGID: =?utf-8?q?1597400351236356558?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
