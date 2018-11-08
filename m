Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121FCECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D5E20989
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUCvaRY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D5E20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbeKIHog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732205AbeKIHoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:44:34 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6C7321019;
        Thu,  8 Nov 2018 22:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714823;
        bh=4/WbpG9LSl9p43IBwfMMzErGKmA8pUQP9EPjMoFTsPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iUCvaRY0cIY+cY2MOvlVPdKnGR5bSyOiU2ydLhmo4EMITBd2bJK/6cPmfWOAuDc1D
         b8GKsPdoomAYhmQe6CX02id/iFzBqaRbe6v4m2PRjGmLpDhoDIB0s8oAIukqwFkKiO
         mma60tjw2+UX+x2AFgWtzAyFwoQu53iHSNaZrvvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 152/171] ip6_tunnel: Fix encapsulation layout
Date:   Thu,  8 Nov 2018 13:52:02 -0800
Message-Id: <20181108215137.811544895@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 net/ipv6/ip6_tunnel.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1185,11 +1185,6 @@ route_lookup:
 	}
 	skb_dst_set(skb, dst);
 
-	if (encap_limit >= 0) {
-		init_tel_txopt(&opt, encap_limit);
-		ipv6_push_nfrag_opts(skb, &opt.ops, &proto, NULL);
-	}
-
 	/* Calculate max headroom for all the headers and adjust
 	 * needed_headroom if necessary.
 	 */
@@ -1202,6 +1197,11 @@ route_lookup:
 	if (err)
 		return err;
 
+	if (encap_limit >= 0) {
+		init_tel_txopt(&opt, encap_limit);
+		ipv6_push_nfrag_opts(skb, &opt.ops, &proto, NULL);
+	}
+
 	skb_push(skb, sizeof(struct ipv6hdr));
 	skb_reset_network_header(skb);
 	ipv6h = ipv6_hdr(skb);


