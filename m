Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48+NSKs4UdnK2gdP8SSEt7xwJf73j8pzd0qmxOYR04yujH/Uu0PONZdtcTKN/ysUxW08MTD
ARC-Seal: i=1; a=rsa-sha256; t=1523399894; cv=none;
        d=google.com; s=arc-20160816;
        b=K+77yoiP0m/fLwfuWGQY2tG9e0Dcp6h5fEwDIqtxK083uTnWQE5NP8ZWcjZXsDodPZ
         DKzkg/VNRTjZ80fGQRCRlCcZJC1OmPqqykUWO6Ih8y+tQUP6jlp2d4JpbBU8RkzhLri5
         TmfADAhTI/vUfM+qfwDoJDLBQeSLN22WxHo+LNw4Z6w5GG3xiHl1ljssZGzS0No7ezq/
         /65tjuqcVDw1cK+NZYzXfw6S3G7bGAln9McdHgeu/uQ9y1TUjipNL6UfWC9UVNnhsO0U
         K5g0ZVUGXgGLZmdhjarITqbObECFef8EeE323vYlLp5z1oDJNAYUnbfo3ZhKkp/r9KB9
         M1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ibBD+VNWdCk/jTrOoA0Q3ZUkwXfYPS4r+LwukZDIB8k=;
        b=T/e3oqntls3nBbi8JUXFo7+hmj+gloxDpS3GhWFW7rd2OBC4EUTIIR0w+VY9KStW6K
         YECh352KJLNqja+C0en+5rlDbCKeyKPwUO472Ybv024Qe6PlgmXHSe44ZJ22DRonnpmT
         3F1wjJb1CEcIt9CFqdKRBvPEFNXO94nxtWycivERhKbUaFi1tIW5ADHo2SWpgB0qyUt0
         zYa78ij8lp3cgDsO3CvriIwTjMWx/UP69CL/6JpL8tGMP+Z+i/3WBDmTUDwTX9oXGyYu
         Qvv6t3PG+Hl1dXpIRa4x3UXhPZ1ziEsGRmJaxBg3LiAM7fzE9UHZXtOfImXMeL+EyfOT
         2Tbw==
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
Subject: [PATCH 4.14 102/138] net/ipv6: Increment OUTxxx counters after netfilter hook
Date: Wed, 11 Apr 2018 00:24:52 +0200
Message-Id: <20180410212914.058912689@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399689892438728?=
X-GMAIL-MSGID: =?utf-8?q?1597400568297752601?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
