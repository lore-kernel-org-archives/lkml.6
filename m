Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29171C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D9020837
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpn4qxud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D9020837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbeKCDyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:54:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729000AbeKCDyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:54:55 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBAD620837;
        Fri,  2 Nov 2018 18:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184401;
        bh=/8OwurWux3Erhbt4REnxnyNEPAot1DYUKC8DTFpBAiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jpn4qxudsVNSZ2MMTnaRqxym+abUvEQn+lcYXG4zlmuibMs2Yetw81ZMNt9oytM9F
         u06ibSn/PIy/RbSsgBj1M0TgJSLjUZiUCOwVBsA4Biq1H6nAmj/KrW6wa9l1o02JN8
         CC2M70HvEhdDMPtK0iLfAO0HQl+SWFCh7VDRRP7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 124/150] ip6_tunnel: Fix encapsulation layout
Date:   Fri,  2 Nov 2018 19:34:46 +0100
Message-Id: <20181102182911.546443387@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Brivio <sbrivio@redhat.com>

[ Upstream commit d4d576f5ab7edcb757bb33e6a5600666a0b1232d ]

Commit 058214a4d1df ("ip6_tun: Add infrastructure for doing
encapsulation") added the ip6_tnl_encap() call in ip6_tnl_xmit(), before
the call to ipv6_push_frag_opts() to append the IPv6 Tunnel Encapsulation
Limit option (option 4, RFC 2473, par. 5.1) to the outer IPv6 header.

As long as the option didn't actually end up in generated packets, this
wasn't an issue. Then commit 89a23c8b528b ("ip6_tunnel: Fix missing tunnel
encapsulation limit option") fixed sending of this option, and the
resulting layout, e.g. for FoU, is:

.-------------------.------------.----------.-------------------.----- - -
| Outer IPv6 Header | UDP header | Option 4 | Inner IPv6 Header | Payload
'-------------------'------------'----------'-------------------'----- - -

Needless to say, FoU and GUE (at least) won't work over IPv6. The option
is appended by default, and I couldn't find a way to disable it with the
current iproute2.

Turn this into a more reasonable:

.-------------------.----------.------------.-------------------.----- - -
| Outer IPv6 Header | Option 4 | UDP header | Inner IPv6 Header | Payload
'-------------------'----------'------------'-------------------'----- - -

With this, and with 84dad55951b0 ("udp6: fix encap return code for
resubmitting"), FoU and GUE work again over IPv6.

Fixes: 058214a4d1df ("ip6_tun: Add infrastructure for doing encapsulation")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_tunnel.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1184,10 +1184,6 @@ route_lookup:
 	}
 	skb_dst_set(skb, dst);
 
-	if (encap_limit >= 0) {
-		init_tel_txopt(&opt, encap_limit);
-		ipv6_push_frag_opts(skb, &opt.ops, &proto);
-	}
 	hop_limit = hop_limit ? : ip6_dst_hoplimit(dst);
 
 	/* Calculate max headroom for all the headers and adjust
@@ -1202,6 +1198,11 @@ route_lookup:
 	if (err)
 		return err;
 
+	if (encap_limit >= 0) {
+		init_tel_txopt(&opt, encap_limit);
+		ipv6_push_frag_opts(skb, &opt.ops, &proto);
+	}
+
 	skb_push(skb, sizeof(struct ipv6hdr));
 	skb_reset_network_header(skb);
 	ipv6h = ipv6_hdr(skb);


