Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686FFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE9E20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0osAphGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE9E20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbeLEJn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:43:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727882AbeLEJn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:43:56 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11D442087F;
        Wed,  5 Dec 2018 09:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003035;
        bh=TDFHSdd3biWLJ3Dh4b5TjmbRBwe3pG1OT7L3XiRnMWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0osAphGRU0nnwD9yi5xK7z1aCQOzPkztqVxb7SkN4zcdbmfvKB5Qhj1sVWnrvwa8J
         ZxSpehk+ErygqJckzGQcjCXQ1k+UwaPFg6yFeJcuVDwp68jmu+c3T4J80//wwYZscf
         sMaTPuYZdzSlHVAtSCh6dI1PP7+Np5apNQt9W3wU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 09/69] netfilter: nf_tables: fix use-after-free when deleting compat expressions
Date:   Wed,  5 Dec 2018 04:41:47 -0500
Message-Id: <20181205094247.6556-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094247.6556-1-sashal@kernel.org>
References: <20181205094247.6556-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 29e3880109e357fdc607b4393f8308cef6af9413 ]

nft_compat ops do not have static storage duration, unlike all other
expressions.

When nf_tables_expr_destroy() returns, expr->ops might have been
free'd already, so we need to store next address before calling
expression destructor.

For same reason, we can't deref match pointer after nft_xt_put().

This can be easily reproduced by adding msleep() before
nft_match_destroy() returns.

Fixes: 0ca743a55991 ("netfilter: nf_tables: add compatibility layer for x_tables")
Reported-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 5 +++--
 net/netfilter/nft_compat.c    | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3ae365f92bff..ea1e57daf50e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2252,7 +2252,7 @@ static int nf_tables_getrule(struct net *net, struct sock *nlsk,
 static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
 				   struct nft_rule *rule)
 {
-	struct nft_expr *expr;
+	struct nft_expr *expr, *next;
 
 	/*
 	 * Careful: some expressions might not be initialized in case this
@@ -2260,8 +2260,9 @@ static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
 	 */
 	expr = nft_expr_first(rule);
 	while (expr != nft_expr_last(rule) && expr->ops) {
+		next = nft_expr_next(expr);
 		nf_tables_expr_destroy(ctx, expr);
-		expr = nft_expr_next(expr);
+		expr = next;
 	}
 	kfree(rule);
 }
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 6da1cec1494a..7533c2fd6b76 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -497,6 +497,7 @@ __nft_match_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		    void *info)
 {
 	struct xt_match *match = expr->ops->data;
+	struct module *me = match->me;
 	struct xt_mtdtor_param par;
 
 	par.net = ctx->net;
@@ -507,7 +508,7 @@ __nft_match_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		par.match->destroy(&par);
 
 	if (nft_xt_put(container_of(expr->ops, struct nft_xt, ops)))
-		module_put(match->me);
+		module_put(me);
 }
 
 static void
-- 
2.17.1

