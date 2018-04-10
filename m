Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49vmmmhFnse1iNMguYm3HeaLjgQNvc5WbuIqguGk/nRNIprpYhpakJejtAYGp6ARSDnMw/L
ARC-Seal: i=1; a=rsa-sha256; t=1523399057; cv=none;
        d=google.com; s=arc-20160816;
        b=EXCuDgFVMkQ9KPWFy77XXHklHht8szJsLKU06giJfiCMEm5Im1GeRjycx8etoiSXXr
         dQOrs//5ea0UHoDE1ewgk3Twnl1vWh4HbZ9xQ1601HsHs7w4jr2Tds3zuu0STdphs5Eq
         xuRMLH4UXwwlGKhfG8gbLzwStt/TtsyB0W36XUPbDtNqQP7/5YJSRaFkUMWnOtNL1+lF
         QUUma1r0dLwHoDjEgLZwByQ3BIdPFZKvuqFnxzpmkZn85O/YDajWjiibepVig/8lfZ4p
         BP1xwO2fps0oXqN3cYMKMCv8bs2Jch7M5sFI3YszTMH9sp33MT+iUwCVhtoeFqCa46OM
         Ko3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=knhYDf/PmtRsb8DOaIMKBOD7kR+3AxCuRzvn6UvisAg=;
        b=r5Kod/znSHH0+MqlUwV8LnxmqMM7O3gVbB0Lp0L0x77sn3Bvc9Lal03vTG6MpI80sC
         PYjIm6khUYuP0EXRr043l25MDt/mtciZGp3ZINUWOgRYxMYqLaiGnmM2A9fi/0Yk1P9o
         DRFZVpVExLtI8xQHgKCVCWn+Ra5kfBqmVepG+sd9W59TzVHmxeFzrILi7AV/sOVrdwfg
         juL6ilbVRayko/tEp8ECDsXCMcpdNMndJ/qzGubZNvnBHbOWOZTFmb/tticeeuFU594V
         BKm28Nq/eTJKepyDYe2b3VNBrRKGp6lFB2zLHzeDq9tevrN7sJc+q0xZDfYdTOiZMvRX
         iuwQ==
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
Subject: [PATCH 4.16 04/18] net/ipv6: Increment OUTxxx counters after netfilter hook
Date: Wed, 11 Apr 2018 00:23:39 +0200
Message-Id: <20180410212758.789994485@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212758.564682823@linuxfoundation.org>
References: <20180410212758.564682823@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399689892438728?=
X-GMAIL-MSGID: =?utf-8?q?1597399689892438728?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 
@@ -569,8 +574,6 @@ int ip6_forward(struct sk_buff *skb)
 
 	hdr->hop_limit--;
 
-	__IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTFORWDATAGRAMS);
-	__IP6_ADD_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTOCTETS, skb->len);
 	return NF_HOOK(NFPROTO_IPV6, NF_INET_FORWARD,
 		       net, NULL, skb, skb->dev, dst->dev,
 		       ip6_forward_finish);
