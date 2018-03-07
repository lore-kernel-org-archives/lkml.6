Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt9z3ATGgsw+7ldD6ircIgpp3+FqT+D894ZxJXQDp5hIYW1BpWBHdocVfp01DbEhKm4EBTy
ARC-Seal: i=1; a=rsa-sha256; t=1520451958; cv=none;
        d=google.com; s=arc-20160816;
        b=PfTcHg8vzCSXJfPblUXkxfrueQtz0Iqlcv5dpaPDIMgXgA4aAU0BqguiOUDERTtNo0
         vfCGQJQtWnuQ43zn70XjvzP5KzCD89vGTL+HPuswXYT+Ie+sFxAd8z/K2Zk7T5Oj3X1y
         CITpa9LOMVXr2FSBDVRrrx8STxs9F4RRjr6cO8mBGCfEnjzUfzndtyn2LuCDT4cAqGXi
         mCzCkOa495C7/Ml3OHNIUJQSVQwYb3xDkqULxGc3y2Za6eA+1RQfsB53z0u726TJenl3
         qldwO/ZGdgdm9p2tbWtGF5UKhcweBFFVd6q2pcq8fBIcBsCcgOp0SZp7Vsis/xa8BirX
         UN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YdbJhbYDuh0cyoQpx4MiP74rC7UKei8WwO8cL9qHalA=;
        b=AManAR0CiODlCE4uTZ+a7aPHXr/Rbe59YlnlCYmS82lNWbqr9H7hOplRIFi/vVqVL2
         pnwCHZyhxZdsBs4gmQh+gbKYHnAFW4OPtVOvq865nLaTaIxYBu8hH6bxnHW2fm9AtRek
         7Q+IVYEnD9sFDt5yGn5tFoCdsjrAkoavLOOBDpBjEhWAX4tdpzZs/kSMNMpwiupu1/sL
         AQUoNv6aYJtjoN/jm6W5tx26k6fY5Jb0UKdrOXoJR/TcanNLY2goHSJ51Nm3ToW2Xkcv
         ivqhMjDv69D2V8/oofFjvkirNBSnZi6xYSGIF1eLPNgoOXgzgimNtNs1+/2/BMv3sjmA
         2EpA==
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
Subject: [PATCH 4.14 046/110] udplite: fix partial checksum initialization
Date: Wed,  7 Mar 2018 11:38:29 -0800
Message-Id: <20180307191045.610732732@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309143307548548?=
X-GMAIL-MSGID: =?utf-8?q?1594309432734232067?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -64,6 +64,7 @@ static inline int udplite_checksum_init(
 		UDP_SKB_CB(skb)->cscov = cscov;
 		if (skb->ip_summed == CHECKSUM_COMPLETE)
 			skb->ip_summed = CHECKSUM_NONE;
+		skb->csum_valid = 0;
         }
 
 	return 0;
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2032,6 +2032,11 @@ static inline int udp4_csum_init(struct
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
@@ -73,6 +73,11 @@ int udp6_csum_init(struct sk_buff *skb,
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
