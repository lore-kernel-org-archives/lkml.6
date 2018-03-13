Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsWgPvks+43uY5xOCWrxaAIzTH8P7BKfRzrIEdqOMyYDfMPIr7Mj61+Fdq4LZrg+03Gv2/8
ARC-Seal: i=1; a=rsa-sha256; t=1520955344; cv=none;
        d=google.com; s=arc-20160816;
        b=xInGJHlI+U/Vq9B4NYEyIadA8bIBR7ADuMezGbfcezr/rHdP03ARA1cTo8bsOYKLfi
         /n1hl6wfZaTKd4UCx+p+d7giIabHTFk9gwr6yATANJOnH56hC29oBjgxmmrJHSW66hcF
         PWnSq9ZQhoLAXfAeqrKHQi1/rEjlm6+xS2RdJRw6Y+e7x0VXvssAaThSgygrkjzc8lUU
         y3tclBAGmsbWqq/f9T0lhsth+2ogGef1mmrVbBF+mtQ6e2ABJbajWwdhUg2m62tLH5sx
         QaY6kxEM5pNIkn9oEofaUevClmEmk6Aj3Ypu03c+QYWbh+pJNob3nf5xEKXttoLixcuN
         uLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=E+mDxCkaB8K0Lm/7tXEAN5sApYLbVd6UKF0NJ/N2cL8=;
        b=0bcePoi692E5y3UMMHMrgnEoSekvHlFqLX8ZYBYN4TSCD6d3D7Ok98FAk1dR9sMmbI
         2yGprJB41K9Hn4UEkkTttWeThuJHdbGqbiWSyNZ7Cwk3CORHf6/TISBio5VJdUMG70G/
         ytofA/E/H7Dm3Tqe+tZ6gGKjb2dM7vO47DYfR3E2z1SeM17WhOUQFGkK1Twksi1Q+//q
         kvzpy/0DAMQv2NQqBYZALw1wFbXIawuVNwWSmyO1D8yRsueHjhMZRw5EK3ZqIq5G5Lru
         WTuGLxWzIFpP78d+BJalNU+NEPIDdGhbB9o8B/NotUmhyiIb+wLoUZeDDdc3nhZlDlnD
         pkeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 018/140] netfilter: use skb_to_full_sk in ip6_route_me_harder
Date: Tue, 13 Mar 2018 16:23:41 +0100
Message-Id: <20180313152459.318892977@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837103220060055?=
X-GMAIL-MSGID: =?utf-8?q?1594837271542565982?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 7d98386d55a5afaa65de77e1e9197edeb8a42079 upstream.

For some reason, Florian forgot to apply to ip6_route_me_harder
the fix that went in commit 29e09229d9f2 ("netfilter: use
skb_to_full_sk in ip_route_me_harder")

Fixes: ca6fb0651883 ("tcp: attach SYNACK messages to request sockets instead of listener") 
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv6/netfilter.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -21,18 +21,19 @@
 int ip6_route_me_harder(struct net *net, struct sk_buff *skb)
 {
 	const struct ipv6hdr *iph = ipv6_hdr(skb);
+	struct sock *sk = sk_to_full_sk(skb->sk);
 	unsigned int hh_len;
 	struct dst_entry *dst;
 	struct flowi6 fl6 = {
-		.flowi6_oif = skb->sk ? skb->sk->sk_bound_dev_if : 0,
+		.flowi6_oif = sk ? sk->sk_bound_dev_if : 0,
 		.flowi6_mark = skb->mark,
-		.flowi6_uid = sock_net_uid(net, skb->sk),
+		.flowi6_uid = sock_net_uid(net, sk),
 		.daddr = iph->daddr,
 		.saddr = iph->saddr,
 	};
 	int err;
 
-	dst = ip6_route_output(net, skb->sk, &fl6);
+	dst = ip6_route_output(net, sk, &fl6);
 	err = dst->error;
 	if (err) {
 		IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTNOROUTES);
@@ -50,7 +51,7 @@ int ip6_route_me_harder(struct net *net,
 	if (!(IP6CB(skb)->flags & IP6SKB_XFRM_TRANSFORMED) &&
 	    xfrm_decode_session(skb, flowi6_to_flowi(&fl6), AF_INET6) == 0) {
 		skb_dst_set(skb, NULL);
-		dst = xfrm_lookup(net, dst, flowi6_to_flowi(&fl6), skb->sk, 0);
+		dst = xfrm_lookup(net, dst, flowi6_to_flowi(&fl6), sk, 0);
 		if (IS_ERR(dst))
 			return PTR_ERR(dst);
 		skb_dst_set(skb, dst);
