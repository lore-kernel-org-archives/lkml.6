Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78935C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8D82252D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0A3d9sFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8D82252D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeKOI1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:27:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:34402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbeKOI1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:17 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E250B22520;
        Wed, 14 Nov 2018 22:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234134;
        bh=nRZ14k4xayMx1HEyuM3NhnBPX8LO+9RGM7qst4AnBCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0A3d9sFu94hnpzevLLP74hr6TNlRW6wkjObVnUEjuiwQTaVUdEVpiNBBG8J/d0tlP
         weoTEdwQDWlfzNka9+l+xlEP8NFh+DCLRerMlOFRNJPFbJGcNpD1h9pNDAsHyi+VGB
         vK6+fj6ytPlJne4/PfUCJAnmP10gzd/KxUIYMLmY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 23/73] netfilter: nft_compat: ebtables 'nat' table is normal chain type
Date:   Wed, 14 Nov 2018 17:21:17 -0500
Message-Id: <20181114222207.98701-23-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit e4844c9c62a0fe47980d6c3d4b7a096a5d755925 ]

Unlike ip(6)tables, the ebtables nat table has no special properties.
This bug causes 'ebtables -A' to fail when using a target such as
'snat' (ebt_snat target sets ".table = "nat"').  Targets that have
no table restrictions work fine.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_compat.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 32535eea51b2..ad2fe6a7e47d 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -54,9 +54,11 @@ static bool nft_xt_put(struct nft_xt *xt)
 	return false;
 }
 
-static int nft_compat_chain_validate_dependency(const char *tablename,
-						const struct nft_chain *chain)
+static int nft_compat_chain_validate_dependency(const struct nft_ctx *ctx,
+						const char *tablename)
 {
+	enum nft_chain_types type = NFT_CHAIN_T_DEFAULT;
+	const struct nft_chain *chain = ctx->chain;
 	const struct nft_base_chain *basechain;
 
 	if (!tablename ||
@@ -64,9 +66,12 @@ static int nft_compat_chain_validate_dependency(const char *tablename,
 		return 0;
 
 	basechain = nft_base_chain(chain);
-	if (strcmp(tablename, "nat") == 0 &&
-	    basechain->type->type != NFT_CHAIN_T_NAT)
-		return -EINVAL;
+	if (strcmp(tablename, "nat") == 0) {
+		if (ctx->family != NFPROTO_BRIDGE)
+			type = NFT_CHAIN_T_NAT;
+		if (basechain->type->type != type)
+			return -EINVAL;
+	}
 
 	return 0;
 }
@@ -323,8 +328,7 @@ static int nft_target_validate(const struct nft_ctx *ctx,
 		if (target->hooks && !(hook_mask & target->hooks))
 			return -EINVAL;
 
-		ret = nft_compat_chain_validate_dependency(target->table,
-							   ctx->chain);
+		ret = nft_compat_chain_validate_dependency(ctx, target->table);
 		if (ret < 0)
 			return ret;
 	}
@@ -570,8 +574,7 @@ static int nft_match_validate(const struct nft_ctx *ctx,
 		if (match->hooks && !(hook_mask & match->hooks))
 			return -EINVAL;
 
-		ret = nft_compat_chain_validate_dependency(match->table,
-							   ctx->chain);
+		ret = nft_compat_chain_validate_dependency(ctx, match->table);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.17.1

