Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E91C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4552083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131587;
	bh=Mc7OF3RcnEAZgmRe9CTYFItz/1LATlg5mwxB/NVoL/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YrzFnLFdd6WnqTeSQ+O7EZUwLaOWdyrdnjq/NKyJpAT38k3E3QUSU389j7Fvv/MJ3
	 +j6TC2p6FT//81txiNCb/lH0QCKre1jU5qBp9w6FGpmqUjk4PlxdHjYleaEe19WgeY
	 ygjkcQmvZg+eKo7Bv70BTpEixLFvJ3m08XrWojj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfBYVxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:53:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730907AbfBYVWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0368A21871;
        Mon, 25 Feb 2019 21:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129755;
        bh=Mc7OF3RcnEAZgmRe9CTYFItz/1LATlg5mwxB/NVoL/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nux2+0MkTj8EvlXVZV9Iq1SgUMZzXKiSg4yqy0wKYTJ15N/SjPikfWeQ3DiONHuq1
         y1U40mRtNxxifgVKnE5EwBTSz3VrwpBrQWsOYnaEmf8SIsXR/xQksjNvX4SHiL2ebP
         Y4TlR14AI+m5QM0AMAjzjlsfuW0ejrVOuRUH0Faw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, wenxu <wenxu@ucloud.cn>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 056/152] netfilter: nft_flow_offload: fix interaction with vrf slave device
Date:   Mon, 25 Feb 2019 22:10:48 +0100
Message-Id: <20190225195047.403687538@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

[ Upstream commit 10f4e765879e514e1ce7f52ed26603047af196e2 ]

In the forward chain, the iif is changed from slave device to master vrf
device. Thus, flow offload does not find a match on the lower slave
device.

This patch uses the cached route, ie. dst->dev, to update the iif and
oif fields in the flow entry.

After this patch, the following example works fine:

 # ip addr add dev eth0 1.1.1.1/24
 # ip addr add dev eth1 10.0.0.1/24
 # ip link add user1 type vrf table 1
 # ip l set user1 up
 # ip l set dev eth0 master user1
 # ip l set dev eth1 master user1

 # nft add table firewall
 # nft add flowtable f fb1 { hook ingress priority 0 \; devices = { eth0, eth1 } \; }
 # nft add chain f ftb-all {type filter hook forward priority 0 \; policy accept \; }
 # nft add rule f ftb-all ct zone 1 ip protocol tcp flow offload @fb1
 # nft add rule f ftb-all ct zone 1 ip protocol udp flow offload @fb1

Signed-off-by: wenxu <wenxu@ucloud.cn>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_flow_table.h | 1 -
 net/netfilter/nf_flow_table_core.c    | 5 +++--
 net/netfilter/nft_flow_offload.c      | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 0e355f4a3d763..0a3de10c6dece 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -84,7 +84,6 @@ struct flow_offload {
 struct nf_flow_route {
 	struct {
 		struct dst_entry	*dst;
-		int			ifindex;
 	} tuple[FLOW_OFFLOAD_DIR_MAX];
 };
 
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index d8125616edc79..e1537ace2b90c 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -28,6 +28,7 @@ flow_offload_fill_dir(struct flow_offload *flow, struct nf_conn *ct,
 {
 	struct flow_offload_tuple *ft = &flow->tuplehash[dir].tuple;
 	struct nf_conntrack_tuple *ctt = &ct->tuplehash[dir].tuple;
+	struct dst_entry *other_dst = route->tuple[!dir].dst;
 	struct dst_entry *dst = route->tuple[dir].dst;
 
 	ft->dir = dir;
@@ -50,8 +51,8 @@ flow_offload_fill_dir(struct flow_offload *flow, struct nf_conn *ct,
 	ft->src_port = ctt->src.u.tcp.port;
 	ft->dst_port = ctt->dst.u.tcp.port;
 
-	ft->iifidx = route->tuple[dir].ifindex;
-	ft->oifidx = route->tuple[!dir].ifindex;
+	ft->iifidx = other_dst->dev->ifindex;
+	ft->oifidx = dst->dev->ifindex;
 	ft->dst_cache = dst;
 }
 
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index e0c04851a3493..4d7cf943fff2c 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -30,9 +30,11 @@ static int nft_flow_route(const struct nft_pktinfo *pkt,
 	switch (nft_pf(pkt)) {
 	case NFPROTO_IPV4:
 		fl.u.ip4.daddr = ct->tuplehash[dir].tuple.src.u3.ip;
+		fl.u.ip4.flowi4_oif = nft_in(pkt)->ifindex;
 		break;
 	case NFPROTO_IPV6:
 		fl.u.ip6.daddr = ct->tuplehash[dir].tuple.src.u3.in6;
+		fl.u.ip6.flowi6_oif = nft_in(pkt)->ifindex;
 		break;
 	}
 
@@ -41,9 +43,7 @@ static int nft_flow_route(const struct nft_pktinfo *pkt,
 		return -ENOENT;
 
 	route->tuple[dir].dst		= this_dst;
-	route->tuple[dir].ifindex	= nft_in(pkt)->ifindex;
 	route->tuple[!dir].dst		= other_dst;
-	route->tuple[!dir].ifindex	= nft_out(pkt)->ifindex;
 
 	return 0;
 }
-- 
2.19.1



