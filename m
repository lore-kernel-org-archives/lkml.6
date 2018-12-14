Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3C3C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C593E208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790761;
	bh=rEATTkx2UkX8phiMbMZKFxoj4ObMoKih62cQ6AAkjvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ObDcdTOIn6sz+GonuLEVn9+kngjSTy/DPO9iC/PGXE5gzYl9z0lRPnFLT4EtG6WeH
	 1K3VuC0COLVDe3JDy/MWXVkJ5pBrICocSvIatM2cxT2rgNyNhBmmA/FV9mEUYBtv7j
	 QqVK7uSru/FMHXaXJQ1+WkqASKFTz7Hm0mOTLqZQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C593E208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbeLNMck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:32:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730274AbeLNMJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:09:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4B19214AE;
        Fri, 14 Dec 2018 12:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789341;
        bh=rEATTkx2UkX8phiMbMZKFxoj4ObMoKih62cQ6AAkjvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQNA0AId35fKZ1LljqsLuK20TbRN6XTiUwDhP7+yaVwWydLndmiaM9nQZyCLEkfPs
         AatyEVS2uZ0ycJ+a/yi5rUv+GyHgT3y2jv/SlDzxsAx9fTpq+CsWtuGQPpMN9dcM+h
         O+oMNrVQpxuemq3QZjf7rovJfTMWEmg3Ywqc7AEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 23/89] netfilter: nf_tables: fix use-after-free when deleting compat expressions
Date:   Fri, 14 Dec 2018 12:59:36 +0100
Message-Id: <20181214115730.826913856@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



