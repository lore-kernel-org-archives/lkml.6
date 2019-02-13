Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C49C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709322190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026962;
	bh=NCTugAhZs0oD+umXlB77YMA1bmFXhvdhFt/3y46fW90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tyOcSCHpaOk06PMSWdXkxFwRZfGLA0Jx+Dg529TJkQQbcBjLC4n34RrtPYnUrPHAg
	 hYnc9+LdByX8gKqwKWrGb4td1d2fnPAFvyv2kPeB3UazF4Dluo5kpAWKIb7vJ/UWUb
	 6CL/BXZXdngNpNoR3mnJcmHy+H+ukDrskRQbf07k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390367AbfBMDCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:02:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387836AbfBMCew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:34:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20D53222C2;
        Wed, 13 Feb 2019 02:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025291;
        bh=NCTugAhZs0oD+umXlB77YMA1bmFXhvdhFt/3y46fW90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ARXCIGGbua2I3mQ5BMg9CKdzUlaafj7hvNqnrSjZq2l+dyfI4RpsXT7O0kU7O7NBr
         Ctp8Cs0V1naIFT/SBwb1AXsPRbm2unE3k3YCFO5MlYJHMCsPpj09HlqlDqpKyvIzzQ
         L3UWXnV17fYvJqIAN1gPULrzwdlhYNqYUHcSKkwM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     wenxu <wenxu@ucloud.cn>, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 049/105] netfilter: nft_flow_offload: fix interaction with vrf slave device
Date:   Tue, 12 Feb 2019 21:32:40 -0500
Message-Id: <20190213023336.19019-49-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

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
index 77e2761d4f2f..ff4eb9869e5b 100644
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
index b7a4816add76..cc91b4d6aa22 100644
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
index ccdb8f5ababb..188c6bbf4e16 100644
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

