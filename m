Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEB0C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9255C217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277449;
	bh=6Du+53EM1a2o7uvP0baMg7mv9tfRPiidMHFmkD5rOlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TSMawfStS5BHViGOLGys5dDSGm6WPKkTaJP8JSEuLX7q/ImOoCQH3jOApgy4GYtLC
	 Kx6bRhv6uAnzAH4vVjoAaxhth91up9MbMja6Qfhy+XLMZI6gs08px1YOxz6ONEvq9f
	 8Jg5F5LOIobrcmpyFsfv1h9zHSWwucZXA/41zGKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbfBDKur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:50:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731608AbfBDKuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:50:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 937B5217D6;
        Mon,  4 Feb 2019 10:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277444;
        bh=6Du+53EM1a2o7uvP0baMg7mv9tfRPiidMHFmkD5rOlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdTg/dM9BQwnBZCFhIETtZzqccj5PiLtFS0AfDCttUhEEtwC8qDhVvq6F/Y1iv9jJ
         z2VDxqJVX/jEFEbjaqyF1Ac3LBpoxgY/iD+oOz+prSus6lZqxBlaVfV1nhzRrex9Ih
         UaKXKHNSJMVERWV2ZF979/KSbWh6RqNkUAcKlFQ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 06/80] net: ip_gre: always reports o_key to userspace
Date:   Mon,  4 Feb 2019 11:36:26 +0100
Message-Id: <20190204103620.983956439@linuxfoundation.org>
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

[ Upstream commit feaf5c796b3f0240f10d0d6d0b686715fd58a05b ]

Erspan protocol (version 1 and 2) relies on o_key to configure
session id header field. However TUNNEL_KEY bit is cleared in
erspan_xmit since ERSPAN protocol does not set the key field
of the external GRE header and so the configured o_key is not reported
to userspace. The issue can be triggered with the following reproducer:

$ip link add erspan1 type erspan local 192.168.0.1 remote 192.168.0.2 \
    key 1 seq erspan_ver 1
$ip link set erspan1 up
$ip -d link sh erspan1

erspan1@NONE: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc pfifo_fast state UNKNOWN mode DEFAULT
  link/ether 52:aa:99:95:9a:b5 brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 1500
  erspan remote 192.168.0.2 local 192.168.0.1 ttl inherit ikey 0.0.0.1 iseq oseq erspan_index 0

Fix the issue adding TUNNEL_KEY bit to the o_flags parameter in
ipgre_fill_info

Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_gre.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1468,12 +1468,17 @@ static int ipgre_fill_info(struct sk_buf
 {
 	struct ip_tunnel *t = netdev_priv(dev);
 	struct ip_tunnel_parm *p = &t->parms;
+	__be16 o_flags = p->o_flags;
+
+	if ((t->erspan_ver == 1 || t->erspan_ver == 2) &&
+	    !t->collect_md)
+		o_flags |= TUNNEL_KEY;
 
 	if (nla_put_u32(skb, IFLA_GRE_LINK, p->link) ||
 	    nla_put_be16(skb, IFLA_GRE_IFLAGS,
 			 gre_tnl_flags_to_gre_flags(p->i_flags)) ||
 	    nla_put_be16(skb, IFLA_GRE_OFLAGS,
-			 gre_tnl_flags_to_gre_flags(p->o_flags)) ||
+			 gre_tnl_flags_to_gre_flags(o_flags)) ||
 	    nla_put_be32(skb, IFLA_GRE_IKEY, p->i_key) ||
 	    nla_put_be32(skb, IFLA_GRE_OKEY, p->o_key) ||
 	    nla_put_in_addr(skb, IFLA_GRE_LOCAL, p->iph.saddr) ||


