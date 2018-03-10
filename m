Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELteWHawM2w+Yb0swNUjptKFIqXbZ6D/c+4kbmTsQpVBkSvPl3y5qYPeUPCQ1FijTNARQ5BQ
ARC-Seal: i=1; a=rsa-sha256; t=1520641157; cv=none;
        d=google.com; s=arc-20160816;
        b=qAU8iL24se6R5L+hgnI2OJ6Mqk5AdoP4f/I8axqhBy4VXx0XTMwNCqNNmrf2KVvdzd
         yUV+sPDhZtslieQXJ+rrqrVX3fvxUu2sDNTMWcAWpwlj6e/MjKW4PTi2VpMiYJS5HV+D
         QMx0/XyY4fsJ4Rc3EmdyxLAl/XbU4V7wi+LjZRFEkskLafS8hi2og/66O2lNXoTfB6LW
         id4YLQ3Bu8MSPY9eyeQMn9p8CLkU5B0e0H855EcL5ltfaSWYFDIrebEzvXQstUFpfmEw
         LEdMLy/18+eKe++GuJzed8oUEaYXzPGSljo4HCw92Drq9JZRi07ZRg/WQx/OviCAeH3C
         CfZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A+PZuRXZqsVdW6GUV6XDc7/zIhXQRk+6JsahmrhuR0A=;
        b=D1yUwdCGMPg/gx1doVb3xrkchthBsasEwfBeieZsQszTztGLEM28YhoiiOw9pF03b4
         wr156vsnKTgoFIJ+EFpX2bfb5PnZdmkMSVAi1RXILeNORvQRgdHzmAlvGxKKrtfZup9a
         7aUoUosumH2kHCV5rAlNVjiy6nS3EncC0KStnPxaJ38SVO2bp8dvfrHHX5HEKLinQ510
         LHbLR+qWgG2xX+3gaikQyVQ4Z70Equyk6NVSJwtWY/zL/C5qPuwNVKwpe7sW2KWSB46c
         R8TrCGZt07nmNgBUrYY+FBljj62HrCGV2oTj2kbglgWqRjxML9Hm24dupS6BubO7ylJm
         z3ow==
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
Subject: [PATCH 3.18 14/21] udplite: fix partial checksum initialization
Date: Fri,  9 Mar 2018 16:18:36 -0800
Message-Id: <20180310001801.920004050@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
References: <20180310001801.045114869@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507822208256184?=
X-GMAIL-MSGID: =?utf-8?q?1594507822208256184?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -61,6 +61,7 @@ static inline int udplite_checksum_init(
 		UDP_SKB_CB(skb)->cscov = cscov;
 		if (skb->ip_summed == CHECKSUM_COMPLETE)
 			skb->ip_summed = CHECKSUM_NONE;
+		skb->csum_valid = 0;
         }
 
 	return 0;
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1718,6 +1718,11 @@ static inline int udp4_csum_init(struct
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
