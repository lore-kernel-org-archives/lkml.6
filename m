Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt3MtLrjjstUWQXfrJyXdEZr3/2ShDDTCU+rrzylcQNJOhSqpy+GSzIuVkBYgLK7fEzNktW
ARC-Seal: i=1; a=rsa-sha256; t=1521214151; cv=none;
        d=google.com; s=arc-20160816;
        b=LyCFndtmEafyy3Lz7nth7K0eSQYWyn8FW4rsV6/4VDjZxAlw/Of5qItZzo2EyB1z73
         88pKrfEkfJZ3Kkgf2TvZAbfXnNdPX7WY6vz3cJi660q9T6Dtkydp0L9W6nXWU6mJrWo2
         zmei22Yj6jr7sJc4Zyg61nbBAjkgyLLaNM5u+/dKpDpszr+ZvwXoiz+AzLM69ICq/OrD
         voNrq647M9HtL81+KqA1FSQx+bQXeTI63SRuk59KmeWNBHCI9lvhk49HhiPG4ZtCU4s5
         5iZ82+llONM34RbDTAzxtkMVnMpKSuOAR+JGiqfD3JhgXC63qkMJgV62pUAOzlB1zNk8
         RXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LQu54BTznzytzXozP7DUJiIwaauL74nnSA1FxPlBJC0=;
        b=LwYEDfHIOV2bAQUZFNdspHkU67+cu4QSdeTu0HeSjJ5qqMSZVaI84PRgyVy9xy6tJ+
         mSLfj4tNMiYd+BvZINoRCw38f0HqegBUYP5Vm741UducRyb+4ddd3yNNJi8QKONvc93c
         tXH5xbPF8R7Qi84ZujdaZ2YPN6IQmhXI7F+egTxDN39qVGpi3yW86ILuSH3F7fk94HGp
         YvF2S9JI4oVCsNcRNU8WK7ySBPer4MDjLW9GXq3GwVlhXkITK2uWMwpOEWLZrY77AulQ
         gNf8prvJperlnwr30VDqc5Co+w0VOo752psMr/1u9V7V5dS5ImmzRpXT1VxkDeRr4ZPN
         iESQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Daniel J Blueman <daniel@quora.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.4 41/63] netfilter: use skb_to_full_sk in ip_route_me_harder
Date: Fri, 16 Mar 2018 16:23:13 +0100
Message-Id: <20180316152304.521252528@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108650693573632?=
X-GMAIL-MSGID: =?utf-8?q?1595108650693573632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 29e09229d9f26129a39462fae0ddabc4d9533989 upstream.

inet_sk(skb->sk) is illegal in case skb is attached to request socket.

Fixes: ca6fb0651883 ("tcp: attach SYNACK messages to request sockets instead of listener")
Reported by: Daniel J Blueman <daniel@quora.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Tested-by: Daniel J Blueman <daniel@quora.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/netfilter.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/net/ipv4/netfilter.c
+++ b/net/ipv4/netfilter.c
@@ -23,7 +23,8 @@ int ip_route_me_harder(struct net *net,
 	struct rtable *rt;
 	struct flowi4 fl4 = {};
 	__be32 saddr = iph->saddr;
-	__u8 flags = skb->sk ? inet_sk_flowi_flags(skb->sk) : 0;
+	const struct sock *sk = skb_to_full_sk(skb);
+	__u8 flags = sk ? inet_sk_flowi_flags(sk) : 0;
 	unsigned int hh_len;
 
 	if (addr_type == RTN_UNSPEC)
@@ -39,7 +40,7 @@ int ip_route_me_harder(struct net *net,
 	fl4.daddr = iph->daddr;
 	fl4.saddr = saddr;
 	fl4.flowi4_tos = RT_TOS(iph->tos);
-	fl4.flowi4_oif = skb->sk ? skb->sk->sk_bound_dev_if : 0;
+	fl4.flowi4_oif = sk ? sk->sk_bound_dev_if : 0;
 	fl4.flowi4_mark = skb->mark;
 	fl4.flowi4_flags = flags;
 	rt = ip_route_output_key(net, &fl4);
@@ -58,7 +59,7 @@ int ip_route_me_harder(struct net *net,
 	    xfrm_decode_session(skb, flowi4_to_flowi(&fl4), AF_INET) == 0) {
 		struct dst_entry *dst = skb_dst(skb);
 		skb_dst_set(skb, NULL);
-		dst = xfrm_lookup(net, dst, flowi4_to_flowi(&fl4), skb->sk, 0);
+		dst = xfrm_lookup(net, dst, flowi4_to_flowi(&fl4), sk, 0);
 		if (IS_ERR(dst))
 			return PTR_ERR(dst);
 		skb_dst_set(skb, dst);
