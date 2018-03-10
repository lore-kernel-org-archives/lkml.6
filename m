Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELufIMFqa8tIvOjoAFK4qy/5NhOXj3kTzaffE4abKhHoQJUEdGdHkdrfXJ6nysRyLjeatn1N
ARC-Seal: i=1; a=rsa-sha256; t=1520641239; cv=none;
        d=google.com; s=arc-20160816;
        b=wy4RFgtcnhgwNk3qYbKoW0Thd4zcPMs4L+cwsY1qw4dpLgZVF3AJ7DiE2LqvW1p1ml
         OZ17kLjw9NZXn5fJh1BXoNarguCyZQFkaE+4rFBvHMwwDfMeMVWBXEhs2E9UVLuBsg7G
         HatnjWMZf6my29oMox5H/Inm3KSnFICzcWfXLRHLcTSaKMrpCQL24+s16fkD+ATLMrLS
         s70USfFdsp+SRxN6cCKBSA/Kzv68YkDxmZdcl/QncIJkWhTjBDqGQwMF4yiAD3AG+yWB
         K1Fdwb+Q19pzTmfO54UD5ef7s7/r/hHp/SPFlSCQVYWCGsTK1XFRGpXRmDmjBpkFD2MR
         x1lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1yPXVAMJYGM0ljkIAy3P2iD7ZyG8ZPz3eCOq7KQJMY0=;
        b=hCTHrDvif6HB0xcMN5naH0E1xix/3cCBdUM2aO2IPJhx0uM7d5REfMaa/hgKiOqmqs
         FpPNNnyRku8rYJ5vvhttRUFebXAEvoq0XqndPkT/WmYbkZmbGhrb6ozkTTWoblWwHjfw
         sMVg52fAI+Gce1NXF9+fcPgfXsrQGMAtjaTpDEOBl9vVl74Uob4FOFOaT0wVdu3nngYX
         TSzUh1124RUNNgpDovVXmMWbiAuHBfga8Yg0NW/s6R5Wyjt3qghFU2NM9Mr0GnvDnw45
         2a/MhlFOmH3yaPqyecffI8mlkOpv7fx0QJ11nSjPAXFDflU1EkTzzf65ew2o5R2ISDAH
         Medg==
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
Subject: [PATCH 4.4 26/36] udplite: fix partial checksum initialization
Date: Fri,  9 Mar 2018 16:18:42 -0800
Message-Id: <20180310001808.796588951@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507822208256184?=
X-GMAIL-MSGID: =?utf-8?q?1594507908261792641?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1744,6 +1744,11 @@ static inline int udp4_csum_init(struct
 		err = udplite_checksum_init(skb, uh);
 		if (err)
 			return err;
+
+		if (UDP_SKB_CB(skb)->partial_cov) {
+			skb->csum = inet_compute_pseudo(skb, proto);
+			return 0;
+		}
 	}
 
 	return skb_checksum_init_zero_check(skb, proto, uh->check,
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
