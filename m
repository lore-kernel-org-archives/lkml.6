Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C6BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719F92145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxpbS+Lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719F92145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbeKOIve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:51:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbeKOI1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:14 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75ABC2251A;
        Wed, 14 Nov 2018 22:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234130;
        bh=SEbdy5TgLMAGR/zNkjj63tbnvvH0bocc/mOe7CwlPgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxpbS+LulRhOGWvaOfZ90uvnPdsGrtgNCt4KKq7bakxWyHQKjKXdLUaalS5LXKIfD
         Nl9/rRJ7jl+Op3nwKVnifXHf7aJYUK87wdpEbxzqXRRp+LqSKLuhY4aM3jjM2ooNhq
         okUMdejfvKerwa3oq/im2Lhqq2Nb9gaAHy/s3cCQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Laura Garcia Liebana <nevola@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 09/73] Revert "netfilter: nft_numgen: add map lookups for numgen random operations"
Date:   Wed, 14 Nov 2018 17:21:03 -0500
Message-Id: <20181114222207.98701-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 4269fea768a11a447d8de620ce420f2214d4685c ]

Laura found a better way to do this from userspace without requiring
kernel infrastructure, revert this.

Fixes: 978d8f9055c3 ("netfilter: nft_numgen: add map lookups for numgen random operations")
Signed-off-by: Laura Garcia Liebana <nevola@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/netfilter/nf_tables.h |   4 +-
 net/netfilter/nft_numgen.c               | 127 -----------------------
 2 files changed, 2 insertions(+), 129 deletions(-)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index e23290ffdc77..325ec6ef0a76 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1581,8 +1581,8 @@ enum nft_ng_attributes {
 	NFTA_NG_MODULUS,
 	NFTA_NG_TYPE,
 	NFTA_NG_OFFSET,
-	NFTA_NG_SET_NAME,
-	NFTA_NG_SET_ID,
+	NFTA_NG_SET_NAME,	/* deprecated */
+	NFTA_NG_SET_ID,		/* deprecated */
 	__NFTA_NG_MAX
 };
 #define NFTA_NG_MAX	(__NFTA_NG_MAX - 1)
diff --git a/net/netfilter/nft_numgen.c b/net/netfilter/nft_numgen.c
index 649d1700ec5b..3cc1b3dc3c3c 100644
--- a/net/netfilter/nft_numgen.c
+++ b/net/netfilter/nft_numgen.c
@@ -24,7 +24,6 @@ struct nft_ng_inc {
 	u32			modulus;
 	atomic_t		counter;
 	u32			offset;
-	struct nft_set		*map;
 };
 
 static u32 nft_ng_inc_gen(struct nft_ng_inc *priv)
@@ -48,34 +47,11 @@ static void nft_ng_inc_eval(const struct nft_expr *expr,
 	regs->data[priv->dreg] = nft_ng_inc_gen(priv);
 }
 
-static void nft_ng_inc_map_eval(const struct nft_expr *expr,
-				struct nft_regs *regs,
-				const struct nft_pktinfo *pkt)
-{
-	struct nft_ng_inc *priv = nft_expr_priv(expr);
-	const struct nft_set *map = priv->map;
-	const struct nft_set_ext *ext;
-	u32 result;
-	bool found;
-
-	result = nft_ng_inc_gen(priv);
-	found = map->ops->lookup(nft_net(pkt), map, &result, &ext);
-
-	if (!found)
-		return;
-
-	nft_data_copy(&regs->data[priv->dreg],
-		      nft_set_ext_data(ext), map->dlen);
-}
-
 static const struct nla_policy nft_ng_policy[NFTA_NG_MAX + 1] = {
 	[NFTA_NG_DREG]		= { .type = NLA_U32 },
 	[NFTA_NG_MODULUS]	= { .type = NLA_U32 },
 	[NFTA_NG_TYPE]		= { .type = NLA_U32 },
 	[NFTA_NG_OFFSET]	= { .type = NLA_U32 },
-	[NFTA_NG_SET_NAME]	= { .type = NLA_STRING,
-				    .len = NFT_SET_MAXNAMELEN - 1 },
-	[NFTA_NG_SET_ID]	= { .type = NLA_U32 },
 };
 
 static int nft_ng_inc_init(const struct nft_ctx *ctx,
@@ -101,22 +77,6 @@ static int nft_ng_inc_init(const struct nft_ctx *ctx,
 					   NFT_DATA_VALUE, sizeof(u32));
 }
 
-static int nft_ng_inc_map_init(const struct nft_ctx *ctx,
-			       const struct nft_expr *expr,
-			       const struct nlattr * const tb[])
-{
-	struct nft_ng_inc *priv = nft_expr_priv(expr);
-	u8 genmask = nft_genmask_next(ctx->net);
-
-	nft_ng_inc_init(ctx, expr, tb);
-
-	priv->map = nft_set_lookup_global(ctx->net, ctx->table,
-					  tb[NFTA_NG_SET_NAME],
-					  tb[NFTA_NG_SET_ID], genmask);
-
-	return PTR_ERR_OR_ZERO(priv->map);
-}
-
 static int nft_ng_dump(struct sk_buff *skb, enum nft_registers dreg,
 		       u32 modulus, enum nft_ng_types type, u32 offset)
 {
@@ -143,27 +103,10 @@ static int nft_ng_inc_dump(struct sk_buff *skb, const struct nft_expr *expr)
 			   priv->offset);
 }
 
-static int nft_ng_inc_map_dump(struct sk_buff *skb,
-			       const struct nft_expr *expr)
-{
-	const struct nft_ng_inc *priv = nft_expr_priv(expr);
-
-	if (nft_ng_dump(skb, priv->dreg, priv->modulus,
-			NFT_NG_INCREMENTAL, priv->offset) ||
-	    nla_put_string(skb, NFTA_NG_SET_NAME, priv->map->name))
-		goto nla_put_failure;
-
-	return 0;
-
-nla_put_failure:
-	return -1;
-}
-
 struct nft_ng_random {
 	enum nft_registers      dreg:8;
 	u32			modulus;
 	u32			offset;
-	struct nft_set		*map;
 };
 
 static u32 nft_ng_random_gen(struct nft_ng_random *priv)
@@ -183,25 +126,6 @@ static void nft_ng_random_eval(const struct nft_expr *expr,
 	regs->data[priv->dreg] = nft_ng_random_gen(priv);
 }
 
-static void nft_ng_random_map_eval(const struct nft_expr *expr,
-				   struct nft_regs *regs,
-				   const struct nft_pktinfo *pkt)
-{
-	struct nft_ng_random *priv = nft_expr_priv(expr);
-	const struct nft_set *map = priv->map;
-	const struct nft_set_ext *ext;
-	u32 result;
-	bool found;
-
-	result = nft_ng_random_gen(priv);
-	found = map->ops->lookup(nft_net(pkt), map, &result, &ext);
-	if (!found)
-		return;
-
-	nft_data_copy(&regs->data[priv->dreg],
-		      nft_set_ext_data(ext), map->dlen);
-}
-
 static int nft_ng_random_init(const struct nft_ctx *ctx,
 			      const struct nft_expr *expr,
 			      const struct nlattr * const tb[])
@@ -226,21 +150,6 @@ static int nft_ng_random_init(const struct nft_ctx *ctx,
 					   NFT_DATA_VALUE, sizeof(u32));
 }
 
-static int nft_ng_random_map_init(const struct nft_ctx *ctx,
-				  const struct nft_expr *expr,
-				  const struct nlattr * const tb[])
-{
-	struct nft_ng_random *priv = nft_expr_priv(expr);
-	u8 genmask = nft_genmask_next(ctx->net);
-
-	nft_ng_random_init(ctx, expr, tb);
-	priv->map = nft_set_lookup_global(ctx->net, ctx->table,
-					  tb[NFTA_NG_SET_NAME],
-					  tb[NFTA_NG_SET_ID], genmask);
-
-	return PTR_ERR_OR_ZERO(priv->map);
-}
-
 static int nft_ng_random_dump(struct sk_buff *skb, const struct nft_expr *expr)
 {
 	const struct nft_ng_random *priv = nft_expr_priv(expr);
@@ -249,22 +158,6 @@ static int nft_ng_random_dump(struct sk_buff *skb, const struct nft_expr *expr)
 			   priv->offset);
 }
 
-static int nft_ng_random_map_dump(struct sk_buff *skb,
-				  const struct nft_expr *expr)
-{
-	const struct nft_ng_random *priv = nft_expr_priv(expr);
-
-	if (nft_ng_dump(skb, priv->dreg, priv->modulus,
-			NFT_NG_RANDOM, priv->offset) ||
-	    nla_put_string(skb, NFTA_NG_SET_NAME, priv->map->name))
-		goto nla_put_failure;
-
-	return 0;
-
-nla_put_failure:
-	return -1;
-}
-
 static struct nft_expr_type nft_ng_type;
 static const struct nft_expr_ops nft_ng_inc_ops = {
 	.type		= &nft_ng_type,
@@ -274,14 +167,6 @@ static const struct nft_expr_ops nft_ng_inc_ops = {
 	.dump		= nft_ng_inc_dump,
 };
 
-static const struct nft_expr_ops nft_ng_inc_map_ops = {
-	.type		= &nft_ng_type,
-	.size		= NFT_EXPR_SIZE(sizeof(struct nft_ng_inc)),
-	.eval		= nft_ng_inc_map_eval,
-	.init		= nft_ng_inc_map_init,
-	.dump		= nft_ng_inc_map_dump,
-};
-
 static const struct nft_expr_ops nft_ng_random_ops = {
 	.type		= &nft_ng_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_ng_random)),
@@ -290,14 +175,6 @@ static const struct nft_expr_ops nft_ng_random_ops = {
 	.dump		= nft_ng_random_dump,
 };
 
-static const struct nft_expr_ops nft_ng_random_map_ops = {
-	.type		= &nft_ng_type,
-	.size		= NFT_EXPR_SIZE(sizeof(struct nft_ng_random)),
-	.eval		= nft_ng_random_map_eval,
-	.init		= nft_ng_random_map_init,
-	.dump		= nft_ng_random_map_dump,
-};
-
 static const struct nft_expr_ops *
 nft_ng_select_ops(const struct nft_ctx *ctx, const struct nlattr * const tb[])
 {
@@ -312,12 +189,8 @@ nft_ng_select_ops(const struct nft_ctx *ctx, const struct nlattr * const tb[])
 
 	switch (type) {
 	case NFT_NG_INCREMENTAL:
-		if (tb[NFTA_NG_SET_NAME])
-			return &nft_ng_inc_map_ops;
 		return &nft_ng_inc_ops;
 	case NFT_NG_RANDOM:
-		if (tb[NFTA_NG_SET_NAME])
-			return &nft_ng_random_map_ops;
 		return &nft_ng_random_ops;
 	}
 
-- 
2.17.1

