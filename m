Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA59C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D9620892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791322;
	bh=Cc/SZgIIKXBXVQD3FWSL8yOSX7pggb+RWRzv5bxOKUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fnxnKsM3sXecwgpOTG2jliUNATG9wa+Qycq+J5Z7WWCKLr/fzkfRwBmLV6qeGiIYY
	 2UpKli82chQtRBWghiSndIFF3zb7T7s41pcd0vtgn6LDUSsDQ777z7425A1OLDnfXM
	 uEm5KXmsnMnra3ZqbXLHnVnv0IBAgBVNl5JoLnws=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D9620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbeLNMmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:42:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:46446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730239AbeLNMDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:03:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B90F2145D;
        Fri, 14 Dec 2018 12:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788989;
        bh=Cc/SZgIIKXBXVQD3FWSL8yOSX7pggb+RWRzv5bxOKUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vFIHkDiDwaOdigj3gnK3PiPAtfmvsAsBfyzTPnn5AkQ+Tu4LZS2rTGW+ahEQtl911
         JwxdLUkaGQUuGjyoVM36MkVpnCMDGLvCFinSrNFbETRcWRgHBQoOLvGJ8Xx+XsbN4p
         8LmOj2CZrhK/7W58yBcpO9igivt/+N4ClfnJAEZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 043/142] netfilter: nf_tables: fix use-after-free when deleting compat expressions
Date:   Fri, 14 Dec 2018 12:58:48 +0100
Message-Id: <20181214115748.771491078@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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
index 4c016b49fe2b..06ed55cef962 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2432,7 +2432,7 @@ static int nf_tables_getrule(struct net *net, struct sock *nlsk,
 static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
 				   struct nft_rule *rule)
 {
-	struct nft_expr *expr;
+	struct nft_expr *expr, *next;
 
 	lockdep_assert_held(&ctx->net->nft.commit_mutex);
 	/*
@@ -2441,8 +2441,9 @@ static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
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
index ad2fe6a7e47d..29d6fc73caf9 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -501,6 +501,7 @@ __nft_match_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		    void *info)
 {
 	struct xt_match *match = expr->ops->data;
+	struct module *me = match->me;
 	struct xt_mtdtor_param par;
 
 	par.net = ctx->net;
@@ -511,7 +512,7 @@ __nft_match_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		par.match->destroy(&par);
 
 	if (nft_xt_put(container_of(expr->ops, struct nft_xt, ops)))
-		module_put(match->me);
+		module_put(me);
 }
 
 static void
-- 
2.19.1



