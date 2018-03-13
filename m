Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt0Fe+M/qA6E8PjTBOQO0KIyWxQ3DO8yJv1k3v5YleEsB3ndI9YMxkZ/eygOzf6e0DEDMDD
ARC-Seal: i=1; a=rsa-sha256; t=1520955184; cv=none;
        d=google.com; s=arc-20160816;
        b=lOxkf8gkpdVXEys8VbiHLdmojgqaSaaqBJ9GJ4uDBfmXbNZcjI1LX9/OwAggV0LRV2
         /9saVBG6G0DblV5oceBtVEIc8/ceJUvIa0OmfFmLRLL3+Dj6N4IMh2mltwPRS6PhJdxb
         gwcbu6kAwm21v7cpclHoNYzFk1B2/07z+cM/H+vpnwyAHvPDDmHfdkk6+Y1RK1adoHao
         qLw1E4qy5fDnCyDUtoeAMy4HPQKabvyCaTs9cTHYAfAsiGnd02ZheZqlEgAiAFkY+ABs
         6xMDYU4RttAIbGq/wOnpq5vhh3sBhWAeZtiq5dOpuGfS8CzkWokyTRyeLDpG2YLnICch
         6fGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CwrT9GA/hHsN8sTPkkfYZDL29NX1HTFXT7pdSdG18xw=;
        b=mam3+FEDrASqQI0mBWUZSWfd4+Ef26iCABAFoJYUOd4VpngEiDGO8SF4BvvYPRFWbd
         8yvyf8r1NuJRn/R/U8k0Zi43ybaZx2Wvh3Lkme0MfvcZsOlNRR5Cf1MdUGQzwECVC+H6
         2K8oaekLH+gNLI0c6cYmGU7Dmk/i8VIM2CPToQQgHoXYOsii+TPHgvfarSOMDJzzi6GF
         DFE8nvaM8N1FagcMVHfiMTu8/orjY/spPGK9EvU4kc1UANdIyUVhL6W8+eU1Sh90dFTs
         2oLL4b5fXMKixMgd5T7a3CkIL8ELjc3Zelo020Eg9SFj4LjqHo8WdKLQIjtAXQCpTgN4
         Bevw==
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
Subject: [PATCH 4.15 117/146] netfilter: use skb_to_full_sk in ip6_route_me_harder
Date: Tue, 13 Mar 2018 16:24:44 +0100
Message-Id: <20180313152329.376111884@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837103220060055?=
X-GMAIL-MSGID: =?utf-8?q?1594837103220060055?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
