Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB936C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8346C21934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026426;
	bh=bhU7YcELDwIlinlHmP1+OaghpVJwFvXTRX4afthp7II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w3ijAcMVsDC5EvJb1BH0sNry08Id2SBiogfMQx5e8KZyDaEeVbYxtKfI9pz1GrTOS
	 /fGFkHMZQNz+VAsqFiIB30Z1OS3i68BgnCbAleyESMrC57rG7YGFUhPIE0kLsdYNnf
	 IqAyNPDIEXSnTUqKmgZPDHCRosaCqu1sy+Zomq2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389956AbfBMCxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:53:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:41714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732565AbfBMCiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:38:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9018C222C7;
        Wed, 13 Feb 2019 02:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025490;
        bh=bhU7YcELDwIlinlHmP1+OaghpVJwFvXTRX4afthp7II=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=klRqry6kpF4tXdBoXM2BMQTsub6ThZFPNfVS+GYg3qBJJQObB22yGw+3uFdwoDuQO
         BBOjMav7dB53CpPaxwlxwWTwAl5g5zdBM7KyT0Fb70zES7jl6tXgs7ty778aDpg7ID
         jdlBQM337qtEunknsLy6viXWcvqwuMruQliEGg7M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     wenxu <wenxu@ucloud.cn>, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 41/83] netfilter: nft_flow_offload: fix interaction with vrf slave device
Date:   Tue, 12 Feb 2019 21:36:19 -0500
Message-Id: <20190213023701.20286-41-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
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
index 0e355f4a3d76..0a3de10c6dec 100644
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
index d8125616edc7..e1537ace2b90 100644
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
index e0c04851a349..4d7cf943fff2 100644
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

