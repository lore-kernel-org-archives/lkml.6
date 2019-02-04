Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85778C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D5620823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277904;
	bh=yL0fhssSMViH8zr+pf8PB+HcUXuGnrCUzWbcTwqoDoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y43ofmCzsJt+F5OobCX9bQjOqQyIDu8EFpkBlkfGdj/qjpLUmk5sMFyKSNHJ60BNG
	 lUftLPiQ7HLUZtmPrv/h3VQUFlt79I0DxUw/c2ZKJtxsMYhZBWm2fYZK7OKomfW9op
	 LnkCsVJMd5hONTlBrBVMjPzrJzJ7i6gLh2/hgYtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732762AbfBDK6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:58:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731886AbfBDKu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:50:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85DE92070C;
        Mon,  4 Feb 2019 10:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277456;
        bh=yL0fhssSMViH8zr+pf8PB+HcUXuGnrCUzWbcTwqoDoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DEmhv2J9FnafHehztZgHRs8dzxEKw84uQ9zyvciShgLreYBChKOEjweoCU4cvZRbK
         TuQWLZfMUiwpoDM1KYcYJhJ9p/LsDDlAv9xVCggS75FgEKymZgGZVII/vVynpqx8Ot
         FIxix+CO4W/ZpzkabBvp8JzZN6hz4kyiCPGyrtxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 18/80] net: ip6_gre: always reports o_key to userspace
Date:   Mon,  4 Feb 2019 11:36:38 +0100
Message-Id: <20190204103622.843158471@linuxfoundation.org>
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

[ Upstream commit c706863bc8902d0c2d1a5a27ac8e1ead5d06b79d ]

As Erspan_v4, Erspan_v6 protocol relies on o_key to configure
session id header field. However TUNNEL_KEY bit is cleared in
ip6erspan_tunnel_xmit since ERSPAN protocol does not set the key field
of the external GRE header and so the configured o_key is not reported
to userspace. The issue can be triggered with the following reproducer:

$ip link add ip6erspan1 type ip6erspan local 2000::1 remote 2000::2 \
    key 1 seq erspan_ver 1
$ip link set ip6erspan1 up
ip -d link sh ip6erspan1

ip6erspan1@NONE: <BROADCAST,MULTICAST> mtu 1422 qdisc noop state DOWN mode DEFAULT
    link/ether ba:ff:09:24:c3:0e brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 1500
    ip6erspan remote 2000::2 local 2000::1 encaplimit 4 flowlabel 0x00000 ikey 0.0.0.1 iseq oseq

Fix the issue adding TUNNEL_KEY bit to the o_flags parameter in
ip6gre_fill_info

Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_gre.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2102,12 +2102,17 @@ static int ip6gre_fill_info(struct sk_bu
 {
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct __ip6_tnl_parm *p = &t->parms;
+	__be16 o_flags = p->o_flags;
+
+	if ((p->erspan_ver == 1 || p->erspan_ver == 2) &&
+	    !p->collect_md)
+		o_flags |= TUNNEL_KEY;
 
 	if (nla_put_u32(skb, IFLA_GRE_LINK, p->link) ||
 	    nla_put_be16(skb, IFLA_GRE_IFLAGS,
 			 gre_tnl_flags_to_gre_flags(p->i_flags)) ||
 	    nla_put_be16(skb, IFLA_GRE_OFLAGS,
-			 gre_tnl_flags_to_gre_flags(p->o_flags)) ||
+			 gre_tnl_flags_to_gre_flags(o_flags)) ||
 	    nla_put_be32(skb, IFLA_GRE_IKEY, p->i_key) ||
 	    nla_put_be32(skb, IFLA_GRE_OKEY, p->o_key) ||
 	    nla_put_in6_addr(skb, IFLA_GRE_LOCAL, &p->laddr) ||


