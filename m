Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv+KB5yWlS+z6pZDC7EUmVVPR3/fIa7ee8Qgw9siSCKZ/m0xbkukqdXq+3JQ1wzILbshAyg
ARC-Seal: i=1; a=rsa-sha256; t=1520451705; cv=none;
        d=google.com; s=arc-20160816;
        b=G3REq74sXBSpG9j6Ee1HuqemgeB8ha2vHyhIHFmlPKGQUxSvrRxGPSakvcCE4Qr71H
         prW1psr2sza7Kq90IrJOrt0310UDzWnnwPHbil6YieZpZMi5oRzWVqO/fwqp4tUCecaY
         CpB/7ct1MYktAg7lqVR8wfq50W5Ln0txY7S9WByxFSRA9aTfBM/qUoc3I9vLL3VX6Zrn
         hG0XBIZOcu6p+maTySGcxNhrJYbv6KYpUczWESHF6kYu1eONcubmLciYE18Jl85xW0nb
         GDXJUs/BjcjuKgZ9zMMBgtZCvywb3RrDECow7WxdHMKp02ny7OqkWW7CChtKkIOYXybB
         qoLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BSSnzmx+i8rNfNmk7twkXOHq0CdiELuPKNdQtxrnQuw=;
        b=mSJu0eQVUusiunNfxVi+vr6tpE68TO60VFo4tmMp8Qazf0NvApY01bOhF1w+G+qTz9
         qKeB83GriipSnVK95/zQ0uBsq6D/Ky/CJ2lLpPxY8TVBoojW010sL5faU45tHCqRYswS
         95Vu9HHpkjnhNLC87kgEVHom4R4xz+LioIPPTmUIej4cwr8LWaGLnlx+u/mHaw1G4L0v
         SuwVUczSKkHjkrhSHq6tt+mt1hp7OXoIxcKhEmnlutAxwZMSjmXFE0ykQGxEprMUFB7r
         lew5ag9R/AbPxOlyhF/h2rk5bnQzp6qbwOfpgd/1AwOQ8+MkAt3hx1MPfiy/SEMxTCwU
         u72A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Inbar Karmy <inbark@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.15 061/122] net/mlx5e: Fix loopback self test when GRO is off
Date: Wed,  7 Mar 2018 11:37:53 -0800
Message-Id: <20180307191738.106418286@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309168354776299?=
X-GMAIL-MSGID: =?utf-8?q?1594309168354776299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Inbar Karmy <inbark@mellanox.com>


[ Upstream commit ef7a3518f7dd4f4cf5e5b5358c93d1eb78df28fb ]

When GRO is off, the transport header pointer in sk_buff is
initialized to network's header.

To find the udp header, instead of using udp_hdr() which assumes
skb_network_header was set, manually calculate the udp header offset.

Fixes: 0952da791c97 ("net/mlx5e: Add support for loopback selftest")
Signed-off-by: Inbar Karmy <inbark@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
@@ -216,7 +216,8 @@ mlx5e_test_loopback_validate(struct sk_b
 	if (iph->protocol != IPPROTO_UDP)
 		goto out;
 
-	udph = udp_hdr(skb);
+	/* Don't assume skb_transport_header() was set */
+	udph = (struct udphdr *)((u8 *)iph + 4 * iph->ihl);
 	if (udph->dest != htons(9))
 		goto out;
 
