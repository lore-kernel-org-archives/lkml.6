Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvb8OGHfeiz5yM/DS50YfWqevA0Xn1EHapPHadhFnfJK0WUiYLnvCUf3TW0a3oDfUJyQRHZ
ARC-Seal: i=1; a=rsa-sha256; t=1520641326; cv=none;
        d=google.com; s=arc-20160816;
        b=rEcuTwdL15E1uwZOnMTbnK1HOILe3u5hvBsIPQ5TVmqpOstKa8Dg+k1+9Q+D6c7Exn
         ukeY7zGtYVU3nywIebVbIDDkDdYKXdrzVuhQhWqkoUx7BGoG67jniMRnTGhxFg4EgdPv
         wV7/3h7dIpuILWBYxY2TigyPi4EqPhHYQYIcNeZv/oaDlN3jvYjHGSLo41Qo2ol4hB2d
         Dxxg4ZKokYCE7JnyPlcCS7pH+Z03YvXc+YTHQqoYjHQChTa2pMEjrZDhDbiJBO/s7/pW
         I9/c2cnOj6SfvBOaOtU0HiAHsoKdA42G49s0B3Hqkx2TwtvgFPh1ftBGIHBGEkkjzKHU
         ip3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4GtJyuHoh2E73h/B6sKwRNHvZcOjoNhCUhHXVuUr+rg=;
        b=02EIJrmUkcdM2svAp5I8Smr+bd3PrdZAdC28JiJRl8vHLD/7SoieNq3BRXzt75Yhm6
         DF00FBbou2bqGVd5n1YPv9a6N17N1BzrHQHYwwfs7N8kQkrc7ENKpeH5VtYcaBQnNWbs
         LfHlkwFqplKzUMCLQzRVSr4jiAF4ZmtCJQGAtokIQshsELoixIp4+whIlpqfsCK0fYhy
         xgDpInhN+/6bXJ17MfmRR9ccH8XFPdm/HOBxKn6VV5jydTxvboaTAXbQJAeWKPMs0MkG
         x1e04V2sOXc0KM9x6UZJiuxu3LZfFEg3GaaSEdqPNABgoragNz8hU2Jluuzq9eBCdZZk
         /DzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexey Kodanev <alexey.kodanev@oracle.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 41/65] udplite: fix partial checksum initialization
Date: Fri,  9 Mar 2018 16:18:41 -0800
Message-Id: <20180310001828.311663703@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507822208256184?=
X-GMAIL-MSGID: =?utf-8?q?1594507999368302961?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Kodanev <alexey.kodanev@oracle.com>


[ Upstream commit 15f35d49c93f4fa9875235e7bf3e3783d2dd7a1b ]

Since UDP-Lite is always using checksum, the following path is
triggered when calculating pseudo header for it:

  udp4_csum_init() or udp6_csum_init()
    skb_checksum_init_zero_check()
      __skb_checksum_validate_complete()

The problem can appear if skb->len is less than CHECKSUM_BREAK. In
this particular case __skb_checksum_validate_complete() also invokes
__skb_checksum_complete(skb). If UDP-Lite is using partial checksum
that covers only part of a packet, the function will return bad
checksum and the packet will be dropped.

It can be fixed if we skip skb_checksum_init_zero_check() and only
set the required pseudo header checksum for UDP-Lite with partial
checksum before udp4_csum_init()/udp6_csum_init() functions return.

Fixes: ed70fcfcee95 ("net: Call skb_checksum_init in IPv4")
Fixes: e4f45b7f40bd ("net: Call skb_checksum_init in IPv6")
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/udplite.h   |    1 +
 net/ipv4/udp.c          |    5 +++++
 net/ipv6/ip6_checksum.c |    5 +++++
 3 files changed, 11 insertions(+)

--- a/include/net/udplite.h
+++ b/include/net/udplite.h
@@ -62,6 +62,7 @@ static inline int udplite_checksum_init(
 		UDP_SKB_CB(skb)->cscov = cscov;
 		if (skb->ip_summed == CHECKSUM_COMPLETE)
 			skb->ip_summed = CHECKSUM_NONE;
+		skb->csum_valid = 0;
         }
 
 	return 0;
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1713,6 +1713,11 @@ static inline int udp4_csum_init(struct
 		err = udplite_checksum_init(skb, uh);
 		if (err)
 			return err;
+
+		if (UDP_SKB_CB(skb)->partial_cov) {
+			skb->csum = inet_compute_pseudo(skb, proto);
+			return 0;
+		}
 	}
 
 	/* Note, we are only interested in != 0 or == 0, thus the
--- a/net/ipv6/ip6_checksum.c
+++ b/net/ipv6/ip6_checksum.c
@@ -72,6 +72,11 @@ int udp6_csum_init(struct sk_buff *skb,
 		err = udplite_checksum_init(skb, uh);
 		if (err)
 			return err;
+
+		if (UDP_SKB_CB(skb)->partial_cov) {
+			skb->csum = ip6_compute_pseudo(skb, proto);
+			return 0;
+		}
 	}
 
 	/* To support RFC 6936 (allow zero checksum in UDP/IPV6 for tunnels)
