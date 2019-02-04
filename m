Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B91C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3498C217FA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277519;
	bh=z2BKhT0yjtyBiIgQVLFqNB7NX5HTjGgMcc9vsFu8ogE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tiy2/wdqgTxem9lZpFn562GTxSb8/x8i44YybKyQzIxYWxXOBu0k0f6Wd072OGwK2
	 VYu8+PXip96AbqiR1QK3x+g38Sn0+pP79pIA/aZmmXUsvcv9eugtULqQYFc4pL8/QX
	 7E4hW+SOqLCwPEO6FjYpgTir+OEV7T6N7KHA3wzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732507AbfBDKv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:51:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731975AbfBDKvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:51:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7381B2070C;
        Mon,  4 Feb 2019 10:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277512;
        bh=z2BKhT0yjtyBiIgQVLFqNB7NX5HTjGgMcc9vsFu8ogE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCWr5cHSGdtzoaJrLZk98+KA6JniEIHadMYzoBUCng3Y/n/cFxunGlvhitw2b1mQr
         oT7mS2uHEtXc5XEobe+gCtDsKeTabzVnElbPcWuJV9l6yroXpreIvrHGIlwhqXINgQ
         E43NONVRM9Jnngo8qIYYh5alwK98rKSYS++lS7uk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 07/80] net: ip_gre: use erspan key field for tunnel lookup
Date:   Mon,  4 Feb 2019 11:36:27 +0100
Message-Id: <20190204103621.183382128@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit cb73ee40b1b381eaf3749e6dbeed567bb38e5258 ]

Use ERSPAN key header field as tunnel key in gre_parse_header routine
since ERSPAN protocol sets the key field of the external GRE header to
0 resulting in a tunnel lookup fail in ip6gre_err.
In addition remove key field parsing and pskb_may_pull check in
erspan_rcv and ip6erspan_rcv

Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/gre_demux.c |   17 +++++++++++++++++
 net/ipv4/ip_gre.c    |    9 ---------
 net/ipv6/ip6_gre.c   |    4 ----
 3 files changed, 17 insertions(+), 13 deletions(-)

--- a/net/ipv4/gre_demux.c
+++ b/net/ipv4/gre_demux.c
@@ -25,6 +25,7 @@
 #include <linux/spinlock.h>
 #include <net/protocol.h>
 #include <net/gre.h>
+#include <net/erspan.h>
 
 #include <net/icmp.h>
 #include <net/route.h>
@@ -119,6 +120,22 @@ int gre_parse_header(struct sk_buff *skb
 			hdr_len += 4;
 	}
 	tpi->hdr_len = hdr_len;
+
+	/* ERSPAN ver 1 and 2 protocol sets GRE key field
+	 * to 0 and sets the configured key in the
+	 * inner erspan header field
+	 */
+	if (greh->protocol == htons(ETH_P_ERSPAN) ||
+	    greh->protocol == htons(ETH_P_ERSPAN2)) {
+		struct erspan_base_hdr *ershdr;
+
+		if (!pskb_may_pull(skb, nhs + hdr_len + sizeof(*ershdr)))
+			return -EINVAL;
+
+		ershdr = (struct erspan_base_hdr *)options;
+		tpi->key = cpu_to_be32(get_session_id(ershdr));
+	}
+
 	return hdr_len;
 }
 EXPORT_SYMBOL(gre_parse_header);
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -266,20 +266,11 @@ static int erspan_rcv(struct sk_buff *sk
 	int len;
 
 	itn = net_generic(net, erspan_net_id);
-	len = gre_hdr_len + sizeof(*ershdr);
-
-	/* Check based hdr len */
-	if (unlikely(!pskb_may_pull(skb, len)))
-		return PACKET_REJECT;
 
 	iph = ip_hdr(skb);
 	ershdr = (struct erspan_base_hdr *)(skb->data + gre_hdr_len);
 	ver = ershdr->ver;
 
-	/* The original GRE header does not have key field,
-	 * Use ERSPAN 10-bit session ID as key.
-	 */
-	tpi->key = cpu_to_be32(get_session_id(ershdr));
 	tunnel = ip_tunnel_lookup(itn, skb->dev->ifindex,
 				  tpi->flags | TUNNEL_KEY,
 				  iph->saddr, iph->daddr, tpi->key);
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -532,13 +532,9 @@ static int ip6erspan_rcv(struct sk_buff
 	struct ip6_tnl *tunnel;
 	u8 ver;
 
-	if (unlikely(!pskb_may_pull(skb, sizeof(*ershdr))))
-		return PACKET_REJECT;
-
 	ipv6h = ipv6_hdr(skb);
 	ershdr = (struct erspan_base_hdr *)skb->data;
 	ver = ershdr->ver;
-	tpi->key = cpu_to_be32(get_session_id(ershdr));
 
 	tunnel = ip6gre_tunnel_lookup(skb->dev,
 				      &ipv6h->saddr, &ipv6h->daddr, tpi->key,


