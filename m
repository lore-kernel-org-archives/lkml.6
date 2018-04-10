Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49KkowAOuBjV/+eqOnXMaUib8FMvlgVJKlqKWX2yidmbzuz6SRbmHqCIqSBf01stTpOkBtl
ARC-Seal: i=1; a=rsa-sha256; t=1523399491; cv=none;
        d=google.com; s=arc-20160816;
        b=HWKrSZU/HtAp23yqdRGvOsYROSPjp/c1gVgJLzAfjpnAMcYreXWyomQmcumLseQaZk
         VupX+LGF6oqK7Hu8tvrF7fzXQrduIO7mhn6+Y3vZgdw/3dHXlzMl/MN/0u7TQlcnKcho
         pLwdw/R2av4wxQYnbadYFhKTi8BMSBuy70QcHWarPX7p9JH/c+jV/05cDUEOvqrFGNh3
         3req+RNhDgwfy/vKXzi2RT+q7xobB0g3thSYGMAOia6EXDMdN6hQLI3ZIUoLmEvztZmF
         FW+o0gReQfEhhZdV3DtvYrvzxwLwhJRLnYP7WMoILd9OKDrc7oEZRKo5yC4ws95YKAqs
         Z/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9Q2Zup5QH9JLba60XqV0jXnjiKhV0PPEUQCUo4T2HHQ=;
        b=WA73zAYYf7Tyx2CJWhqqMEl8ye0ju9vIFPL/XXlhd98Bs8vOy56Qm0hN1UuHXJiyaa
         RtF3po50ud97Ck8fGBf7poL95OAL1XDA7TSRwPG0uWjXbv5bNENDAcFeMqDd1W29Xdpq
         S0cqnXZlALx77JSCXAOoQOT2+QqYKQe3SOmiZ2gQTrNmDk4Nrsmo9Y+lcNUfRF9B9LIp
         hqXtECKigyhkPZoG6pwfstI8SY6HmmldX7Ru89eEFziKw2FnmwFv5w31vkLvZmaEuMlh
         OjfstZVDIO09hUih3o2o8/bpAACgHlC/wuv06JprJjTCIk2JuQ1lYcBDiWvnrHSQIFuI
         rlPA==
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
Subject: [PATCH 4.15 127/168] net/ipv6: Increment OUTxxx counters after netfilter hook
Date: Wed, 11 Apr 2018 00:24:29 +0200
Message-Id: <20180410212806.167316209@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399689892438728?=
X-GMAIL-MSGID: =?utf-8?q?1597400144977752224?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 net/ipv6/ip6_output.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -375,6 +375,11 @@ static int ip6_forward_proxy_check(struc
 static inline int ip6_forward_finish(struct net *net, struct sock *sk,
 				     struct sk_buff *skb)
 {
+	struct dst_entry *dst = skb_dst(skb);
+
+	__IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTFORWDATAGRAMS);
+	__IP6_ADD_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTOCTETS, skb->len);
+
 	return dst_output(net, sk, skb);
 }
 
@@ -568,8 +573,6 @@ int ip6_forward(struct sk_buff *skb)
 
 	hdr->hop_limit--;
 
-	__IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTFORWDATAGRAMS);
-	__IP6_ADD_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTOCTETS, skb->len);
 	return NF_HOOK(NFPROTO_IPV6, NF_INET_FORWARD,
 		       net, NULL, skb, skb->dev, dst->dev,
 		       ip6_forward_finish);
