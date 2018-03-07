Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsnxUtGW3CTJC0YSUTRbogRXixewfbDG5ZMg+vxfckr+pjwgLiIQS58KChy/omfY8VB4R4N
ARC-Seal: i=1; a=rsa-sha256; t=1520451682; cv=none;
        d=google.com; s=arc-20160816;
        b=wwOosQtypP2oihdqHAivj12dLMGFi5KB016ESos1uOqkslsikiqSPQQVh4jit5SWkg
         NN0QrhoeAMNrMSbrLoi7eCNC8nLv3mtqRX5FF9h+guSB69Wf5YQXiLzilgrliXbWccry
         8Qoh4fJbH1805lwpQHy16YHTuU22L7SZXtMeEn9OhqhVe7Y6U0NePT9jejUmf0ZWF6vM
         AkVagI5nS6o657yj3747pNcFz4YGeZZHxoRSBp5+oH6c/haX4ke6rDop7HMiMDZ5eGdr
         OEKAaW8MH1HaprTsDZCXPMxFS6RHuvoBa10KEAL7HuLSDq9KIeMGRbGF/hIeRQJOcqmF
         COqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zt3usaZtKk1wCalrDcbSFpjwa27FHn1bltb1yNaWi9M=;
        b=Rh219xUF/fHH0oG2ldhwotRMVjSVucoA/yLr6e9hfU6ibMlzRI/DkdW07G1g2Y98KO
         FZRBZoX0LVFjtCIRhBtad94kxEq8Dj2ZQ05IpN1QoowVMHn7ynECaiAnbo+wFkgYN0xF
         C4nmq3gf5b5/UCMyJMQxUKgW0HkBJkCiAjzy7+6OKFKr+RdtuJtKqBcEz1OrZBbet9bv
         T2cVuBdnRDjSVasEjxrNMtDLI8LrwXLsAq8gMMkGLG56v877Iri2vyo72kAt/XZfSiE9
         bv+ZNIjrxlqQ3ysE/3ahrMUlNyxdVHg9xu7UsbXjOfycfIxYY8w5ANl2jfrtWmYtbVpU
         o5Qg==
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
Subject: [PATCH 4.15 051/122] udplite: fix partial checksum initialization
Date: Wed,  7 Mar 2018 11:37:43 -0800
Message-Id: <20180307191736.460270737@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309143307548548?=
X-GMAIL-MSGID: =?utf-8?q?1594309143307548548?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2031,6 +2031,11 @@ static inline int udp4_csum_init(struct
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
