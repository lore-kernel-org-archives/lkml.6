Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC861C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7456A20645
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h95qrU/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7456A20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbeKZV5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:57:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:41274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbeKZV5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:57:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E35620645;
        Mon, 26 Nov 2018 11:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230210;
        bh=oyLpCowr0TrPXNrAzakvHfSa1k0dB/Ffo55p6e70qd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h95qrU/0vy9JWVY+DTmtjIqZYlxouOypgFlSReRfDQ94CphHVeIz2r3fXaL5uV9fK
         JkaY5DTNXAHSqCrIKuBcZtsXUSqooHk7uXvhEzE5t1piDPuVNEeIMdNTEKx2gT/Bv+
         MIdFXGOH5qT5uOdhRkKJO39k3WDr2tM7TfPz3Y+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 050/118] netfilter: nft_compat: ebtables nat table is normal chain type
Date:   Mon, 26 Nov 2018 11:50:44 +0100
Message-Id: <20181126105102.824844415@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
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



