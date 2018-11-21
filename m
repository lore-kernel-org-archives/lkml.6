Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B11C04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48B9214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="14q5h5kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48B9214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387638AbeKVFma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:42:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387566AbeKVFm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:42:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B052C214F1;
        Wed, 21 Nov 2018 19:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827217;
        bh=Id1vDuhxW12rABgRnXalbX6dcgJuZQpdkbM7DvNOLd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=14q5h5kxAYZkYF9NWmSxG7izJ376/MKG7xL+GRxPXcFbRM92oxPbgS0hW8hPiG5Gv
         kxmgijf3QkQp1OK++m12l0WDmV7r34swhYRasl0tkzlr2BkGFPMP/eImqq0v5AnhIR
         a10wMIaOS5iKlOxVexFmpyORclnuUGzpuxsUOIzA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
        Slava Ovsiienko <viacheslavo@mellanox.com>,
        Jianbo Liu <jianbol@mellanox.com>,
        Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 18/42] net/mlx5e: Dont match on vlan non-existence if ethertype is wildcarded
Date:   Wed, 21 Nov 2018 20:05:54 +0100
Message-Id: <20181121183148.823781248@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Or Gerlitz <ogerlitz@mellanox.com>

[ Upstream commit d3a80bb5a3eac311ddf28387402593977574460d ]

For the "all" ethertype we should not care whether the packet has
vlans. Besides being wrong, the way we did it caused FW error
for rules such as:

tc filter add dev eth0 protocol all parent ffff: \
	prio 1 flower skip_sw action drop

b/c the matching meta-data (outer headers bit in struct mlx5_flow_spec)
wasn't set. Fix that by matching on vlan non-existence only if we were
also told to match on the ethertype.

Fixes: cee26487620b ('net/mlx5e: Set vlan masks for all offloaded TC rules')
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Reported-by: Slava Ovsiienko <viacheslavo@mellanox.com>
Reviewed-by: Jianbo Liu <jianbol@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |   63 ++++++++++++------------
 1 file changed, 32 insertions(+), 31 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1310,31 +1310,21 @@ static int __parse_cls_flower(struct mlx
 					 inner_headers);
 	}
 
-	if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
-		struct flow_dissector_key_eth_addrs *key =
+	if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_BASIC)) {
+		struct flow_dissector_key_basic *key =
 			skb_flow_dissector_target(f->dissector,
-						  FLOW_DISSECTOR_KEY_ETH_ADDRS,
+						  FLOW_DISSECTOR_KEY_BASIC,
 						  f->key);
-		struct flow_dissector_key_eth_addrs *mask =
+		struct flow_dissector_key_basic *mask =
 			skb_flow_dissector_target(f->dissector,
-						  FLOW_DISSECTOR_KEY_ETH_ADDRS,
+						  FLOW_DISSECTOR_KEY_BASIC,
 						  f->mask);
+		MLX5_SET(fte_match_set_lyr_2_4, headers_c, ethertype,
+			 ntohs(mask->n_proto));
+		MLX5_SET(fte_match_set_lyr_2_4, headers_v, ethertype,
+			 ntohs(key->n_proto));
 
-		ether_addr_copy(MLX5_ADDR_OF(fte_match_set_lyr_2_4, headers_c,
-					     dmac_47_16),
-				mask->dst);
-		ether_addr_copy(MLX5_ADDR_OF(fte_match_set_lyr_2_4, headers_v,
-					     dmac_47_16),
-				key->dst);
-
-		ether_addr_copy(MLX5_ADDR_OF(fte_match_set_lyr_2_4, headers_c,
-					     smac_47_16),
-				mask->src);
-		ether_addr_copy(MLX5_ADDR_OF(fte_match_set_lyr_2_4, headers_v,
-					     smac_47_16),
-				key->src);
-
-		if (!is_zero_ether_addr(mask->src) || !is_zero_ether_addr(mask->dst))
+		if (mask->n_proto)
 			*match_level = MLX5_MATCH_L2;
 	}
 
@@ -1368,9 +1358,10 @@ static int __parse_cls_flower(struct mlx
 
 			*match_level = MLX5_MATCH_L2;
 		}
-	} else {
+	} else if (*match_level != MLX5_MATCH_NONE) {
 		MLX5_SET(fte_match_set_lyr_2_4, headers_c, svlan_tag, 1);
 		MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
+		*match_level = MLX5_MATCH_L2;
 	}
 
 	if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_CVLAN)) {
@@ -1408,21 +1399,31 @@ static int __parse_cls_flower(struct mlx
 		}
 	}
 
-	if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_BASIC)) {
-		struct flow_dissector_key_basic *key =
+	if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
+		struct flow_dissector_key_eth_addrs *key =
 			skb_flow_dissector_target(f->dissector,
-						  FLOW_DISSECTOR_KEY_BASIC,
+						  FLOW_DISSECTOR_KEY_ETH_ADDRS,
 						  f->key);
-		struct flow_dissector_key_basic *mask =
+		struct flow_dissector_key_eth_addrs *mask =
 			skb_flow_dissector_target(f->dissector,
-						  FLOW_DISSECTOR_KEY_BASIC,
+						  FLOW_DISSECTOR_KEY_ETH_ADDRS,
 						  f->mask);
-		MLX5_SET(fte_match_set_lyr_2_4, headers_c, ethertype,
-			 ntohs(mask->n_proto));
-		MLX5_SET(fte_match_set_lyr_2_4, headers_v, ethertype,
-			 ntohs(key->n_proto));
 
-		if (mask->n_proto)
+		ether_addr_copy(MLX5_ADDR_OF(fte_match_set_lyr_2_4, headers_c,
+					     dmac_47_16),
+				mask->dst);
+		ether_addr_copy(MLX5_ADDR_OF(fte_match_set_lyr_2_4, headers_v,
+					     dmac_47_16),
+				key->dst);
+
+		ether_addr_copy(MLX5_ADDR_OF(fte_match_set_lyr_2_4, headers_c,
+					     smac_47_16),
+				mask->src);
+		ether_addr_copy(MLX5_ADDR_OF(fte_match_set_lyr_2_4, headers_v,
+					     smac_47_16),
+				key->src);
+
+		if (!is_zero_ether_addr(mask->src) || !is_zero_ether_addr(mask->dst))
 			*match_level = MLX5_MATCH_L2;
 	}
 


