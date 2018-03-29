Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48YmhBjScF4Z1mL8q42KFNM0K6Jgm3PTltowMqNGOE0RqF9igXX6n9lQX2tC7FHR+wKUfAy
ARC-Seal: i=1; a=rsa-sha256; t=1522346509; cv=none;
        d=google.com; s=arc-20160816;
        b=jqua/iKgXoQJTKElA2PxeZinLc0xDicwO+VRgR1nsFLnfopP5jt2ykzKA6iLWjBH4g
         o5xc0c/VSIo45VFjj2VIS4RRkf9p7eNTMH+0YcVytjeAu0+gH+v3/1FTuYGk61qfh+EH
         xJ2jPN9lDkwuBRcJZ5iuNlOybDG9fXKECwEemz/2tIGdg5owhhg392INZenVngk/5mCV
         UxvqxrecvZnjkdsSzAKXbfQnla50ta0GoXPMTNS59fE4xLWOhCnB4fukvJV4J6x2dp0O
         wZV3x5wc5MMXGy9JBhdytSNHvqmdLwYTkLVzvA1/X1ZRN5vyhwelR1I6l1kXuQ+H532o
         PQPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jj6b/lNP5FGP7PdlBcpHOXxrEDAD+8X5ObGaVrRnmyA=;
        b=VxgYdzRmRWlKk+ai/jfGYpq/MgBvG/fK+65Rwf+Qg5o1NqWyi2MNiSej8tO4pct9Rq
         RYPeYApZHgIa8xMu/GN4r0ZYVaXPnWqTY/1P7lsWgM+6Bk/5Sb0Y+fCIELzLj4m7HDQ/
         SxDky2GN4JexaL6Tovnl5ujKtMJP1gDki+KJUqJKyUraNAO/edBdK59lVxrWY7hZw81N
         C4rawfZNveDfdd+SImUQcElSbqwJCjs8ydq1LbgU1z39tfj8tN4+0JOg4TmRLEU/VY8U
         zai4dxBPXSsRNA1mxj3T3MumjS6zxM1fGlF75B9WCYh74Qtch4MzV4ZZU0OVjUyRE5oO
         cf6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Zhou <azhou@ovn.org>,
	zhangliping <zhangliping02@baidu.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 02/47] openvswitch: meter: fix the incorrect calculation of max delta_t
Date: Thu, 29 Mar 2018 19:59:43 +0200
Message-Id: <20180329175729.354922414@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296012812155932?=
X-GMAIL-MSGID: =?utf-8?q?1596296012812155932?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: zhangliping <zhangliping02@baidu.com>


[ Usptream commit ddc502dfed600bff0b61d899f70d95b76223fdfc ]

Max delat_t should be the full_bucket/rate instead of the full_bucket.
Also report EINVAL if the rate is zero.

Fixes: 96fbc13d7e77 ("openvswitch: Add meter infrastructure")
Cc: Andy Zhou <azhou@ovn.org>
Signed-off-by: zhangliping <zhangliping02@baidu.com>
Acked-by: Pravin B Shelar <pshelar@ovn.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/openvswitch/meter.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/net/openvswitch/meter.c
+++ b/net/openvswitch/meter.c
@@ -242,14 +242,20 @@ static struct dp_meter *dp_meter_create(
 
 		band->type = nla_get_u32(attr[OVS_BAND_ATTR_TYPE]);
 		band->rate = nla_get_u32(attr[OVS_BAND_ATTR_RATE]);
+		if (band->rate == 0) {
+			err = -EINVAL;
+			goto exit_free_meter;
+		}
+
 		band->burst_size = nla_get_u32(attr[OVS_BAND_ATTR_BURST]);
 		/* Figure out max delta_t that is enough to fill any bucket.
 		 * Keep max_delta_t size to the bucket units:
 		 * pkts => 1/1000 packets, kilobits => bits.
+		 *
+		 * Start with a full bucket.
 		 */
-		band_max_delta_t = (band->burst_size + band->rate) * 1000;
-		/* Start with a full bucket. */
-		band->bucket = band_max_delta_t;
+		band->bucket = (band->burst_size + band->rate) * 1000;
+		band_max_delta_t = band->bucket / band->rate;
 		if (band_max_delta_t > meter->max_delta_t)
 			meter->max_delta_t = band_max_delta_t;
 		band++;
