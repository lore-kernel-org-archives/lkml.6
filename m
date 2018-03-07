Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtfjm+RPl/kh19xT3iqdjlqMw6Y9j7cyL38WjPsgFq66ftdKt3iUEgENKiNB6Qn4usgJhOP
ARC-Seal: i=1; a=rsa-sha256; t=1520452063; cv=none;
        d=google.com; s=arc-20160816;
        b=KowgC3ECRwyF4ZPGSuWpHC1ZLtwJux+sb1RUzmkGIUVZEi4wXM86QuSWExlsi4tuWI
         /tJa0tLp3CvZVWoZt+aNONagW7xfMFFRUxbvXlG3z8ElzvseS54C5myxt/vGb6bblUtX
         656E9SkT1l5+50YEN/QAN9zvdDFuw9NIhacpEa/1A8VyiLvy26fQupTyQHprOUcotzxM
         MBtgXEv042Z1jNzQ6R8DdNKwf6XSQd4U7P0gQtekk3K/ZPy3GT9YxoV5na0KL4lMqWb4
         EIA+QltZkjug7KkEQ9PeZVX7J3iKRGTlfv0GNABlE70U5P0eFJkzYNmGLBjRzBhM8O4a
         88Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7NBTpl5LDl7MjrowVWOW5h/NknECHPVU2jm3qSifR7w=;
        b=p9NQ1MpYcF/0SBLQkZOI2jk5IrwLj+RtVfdFUXJNHzQlWiJsEcjpUgE/HBAcZGBKUO
         Pc8ukdI1MbyLTUtmHcjuBDsoEdudETDST+YaKrV38nd2IQP+Vzlc1Wv3NcaJ4hUnmmo5
         hPw2ryBLh0ejIbnpWoHvM9GHLOMPqf6naovhzGUsrgb4S6X6jzyNKzkmqOSiqkJ0mOC3
         wHvBOHtjMHvk941h2J2fc9AxbR+UQEaQjFPWjHlXMqBz0ujMTWAI6T2BsHCBMO2hittX
         93DLudxN4EzBHZwsGxK9ZQIAvMT9ZexT6wnkImXd0BYcJbX9vlafagkj5sR+pj8Dva/u
         me5A==
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
Subject: [PATCH 4.14 056/110] net/mlx5e: Fix loopback self test when GRO is off
Date: Wed,  7 Mar 2018 11:38:39 -0800
Message-Id: <20180307191046.788870637@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309168354776299?=
X-GMAIL-MSGID: =?utf-8?q?1594309542898810784?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
