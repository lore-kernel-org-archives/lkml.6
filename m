Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81B8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C43205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129562;
	bh=C7odcgRBZwuLb8O5LY+sx8OGatp9/MbpPuMwer0T4xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iuCGiYYzu4aC9dTVEf6YrhcyrDymJxeNHRvEa6Q4MbLdhYqE47UmaTbS4OfkygNwW
	 UD1+7+P7eqL2/nIUcAPOtx1+MUGyBXeg9+R1nU0poxtTRHUo6HdwXGrOnG2J2Z4wbs
	 nC5oXy8+5pnQ/gfx5FN6zmoD2wdVWeY6Kqm1mmzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfBYVTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:19:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:52250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbfBYVTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:19:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B728C205C9;
        Mon, 25 Feb 2019 21:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129558;
        bh=C7odcgRBZwuLb8O5LY+sx8OGatp9/MbpPuMwer0T4xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRWESUZ3b0vTXjgcjOHiCczI4utaZRa716QIhZ5RtgvPisGAAw/EUqXYgjhqPogZY
         Ei2p3Uja4KaCyfapY8pE9XB3Lbb2cQhwMOF22Ryok8uVEz2ifj7nA3R2Oi98/O6P7i
         NamYg7XegPtO9N9kSHHFL/TRBzsHvOCZTAkfITVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eli Cooper <elicooper@gmx.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 68/71] netfilter: ipv6: Dont preserve original oif for loopback address
Date:   Mon, 25 Feb 2019 22:12:10 +0100
Message-Id: <20190225195039.793892264@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eli Cooper <elicooper@gmx.com>

commit 15df03c661cb362366ecfc3a21820cb934f3e4ca upstream.

Commit 508b09046c0f ("netfilter: ipv6: Preserve link scope traffic
original oif") made ip6_route_me_harder() keep the original oif for
link-local and multicast packets. However, it also affected packets
for the loopback address because it used rt6_need_strict().

REDIRECT rules in the OUTPUT chain rewrite the destination to loopback
address; thus its oif should not be preserved. This commit fixes the bug
that redirected local packets are being dropped. Actually the packet was
not exactly dropped; Instead it was sent out to the original oif rather
than lo. When a packet with daddr ::1 is sent to the router, it is
effectively dropped.

Fixes: 508b09046c0f ("netfilter: ipv6: Preserve link scope traffic original oif")
Signed-off-by: Eli Cooper <elicooper@gmx.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv6/netfilter.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -24,9 +24,11 @@ int ip6_route_me_harder(struct net *net,
 	struct sock *sk = sk_to_full_sk(skb->sk);
 	unsigned int hh_len;
 	struct dst_entry *dst;
+	int strict = (ipv6_addr_type(&iph->daddr) &
+		      (IPV6_ADDR_MULTICAST | IPV6_ADDR_LINKLOCAL));
 	struct flowi6 fl6 = {
 		.flowi6_oif = sk && sk->sk_bound_dev_if ? sk->sk_bound_dev_if :
-			rt6_need_strict(&iph->daddr) ? skb_dst(skb)->dev->ifindex : 0,
+			strict ? skb_dst(skb)->dev->ifindex : 0,
 		.flowi6_mark = skb->mark,
 		.flowi6_uid = sock_net_uid(net, sk),
 		.daddr = iph->daddr,


