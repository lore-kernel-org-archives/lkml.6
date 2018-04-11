Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48TddbcDPHKNtVpETY9ScfHCruX0O38bS8tElkngrgp9Ktf+KhONCc09peeqKPmWHh7paCR
ARC-Seal: i=1; a=rsa-sha256; t=1523473530; cv=none;
        d=google.com; s=arc-20160816;
        b=lYyHB4zXUCACe+cUIMbqENSPPSg2651WQPKFDDaQGTQ25aoX7WLwIpPg0HmS/eB2FF
         N143jAPc9wWnYAXt9V2MudnyS0TV2d6Wpob1/CdQKLA+qlzqj52qhy9yKooaNr6ujbtR
         LGb0p74sAc4P/3aHuPI/BhVp6v0TBpQGi+61g8499ADFFwmyI3tpVZrImIdTorfGL9c2
         QixLMZ5MoKWja+x+VotiROBsoNwN1j9nU+uOA//CiJ3rtzijneFbklgfNo6lrdwhuBRE
         9P76jt15UAqa6jSYCyy4S00+7A2bqtfSM/9bUi2h1Vt6Sw7gkLCsUpd/L71edwKEvV8M
         6YQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EpRVY6GVumQdKWOX6uJLfzOc0EUOJh5ttGIuP040aWE=;
        b=CuTlTCtG94zdVbyQc/omA9MNtY6R9BClWm1ALZtniv4zKMkfve5J33JmgkvRQ0NFxB
         puK/jdaMcYm0TSKyufuBbYa3oI4hp41hqQhB1IoW+oee322UYQDow7Uqmq5wrcFipTZD
         aFTiF4AotY63EChnM8z5THd+yGCWk9cCqXj7nXPawzst/KKG0s2XBJZ5FU+Q/EyCsGcc
         EIK5St4WZgrGIygZkERkmTVyVBjG9uphrj3aX0kyGq1irQfLf9rGNYS+to+oL2hX0/Iu
         MDgDLPhdIASIWgulYxvOSFvv2wT5rHiCQoo836AszkUdODHLkxCndoM5sNqtZIZVI3DY
         nYUQ==
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
Subject: [PATCH 4.9 280/310] net/ipv6: Increment OUTxxx counters after netfilter hook
Date: Wed, 11 Apr 2018 20:36:59 +0200
Message-Id: <20180411183634.663528011@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476938428823719?=
X-GMAIL-MSGID: =?utf-8?q?1597477780247111365?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -356,6 +356,11 @@ static int ip6_forward_proxy_check(struc
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
 
@@ -549,8 +554,6 @@ int ip6_forward(struct sk_buff *skb)
 
 	hdr->hop_limit--;
 
-	__IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTFORWDATAGRAMS);
-	__IP6_ADD_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTOCTETS, skb->len);
 	return NF_HOOK(NFPROTO_IPV6, NF_INET_FORWARD,
 		       net, NULL, skb, skb->dev, dst->dev,
 		       ip6_forward_finish);
