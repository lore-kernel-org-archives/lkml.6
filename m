Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1046C282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32972073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278124;
	bh=GDM1QoBsjciIsnhvmxrcyUuVcQ4f/JUvuz1xXZ9Si04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AtgwTui88GpkKcEYWq1akmlgtxZU9BHdRQU+WMegniHQ8JAV2k9BPQnLETmOBFYzM
	 BccWLbk5XShggrE97Sffg3hZ7O1WaDip37YkOm2abqEXQz9HCglZwO2Y2nKp3kfx4p
	 9bjGT0ux03Z2kgsqklxzUW60yfcfXvRZftfKVZgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbfBDKre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:47:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731177AbfBDKrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:47:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60C172087C;
        Mon,  4 Feb 2019 10:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277250;
        bh=GDM1QoBsjciIsnhvmxrcyUuVcQ4f/JUvuz1xXZ9Si04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yrI2JFNHuoOVQXu4HGqi4soaNYi4db2Ou/v+d6z2/+i2HN0JjsmfBKlpaluYo2DBM
         6N94lIMCdBb8Ony3tyV/kiAHcehbe5c9Q6Gy9liLxeh5XpOMmNFrk5W6BCOGBErsYj
         nti58hibx30Yz/MLaG32tRlWI3an/guIXW//e7c0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 08/74] net: ip_gre: always reports o_key to userspace
Date:   Mon,  4 Feb 2019 11:36:21 +0100
Message-Id: <20190204103620.574475141@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1471,12 +1471,17 @@ static int ipgre_fill_info(struct sk_buf
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


