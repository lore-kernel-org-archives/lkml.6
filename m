Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6D9C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1676A2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbfBCOYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:24:13 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55828 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730496AbfBCOV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:27 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIeE-0006RN-Jl; Sun, 03 Feb 2019 14:21:26 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9h-0007CY-DI; Sun, 03 Feb 2019 14:49:53 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>,
        "Florian Westphal" <fw@strlen.de>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.399883084@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 199/305] netfilter: nf_tables: fix use-after-free
 when deleting compat expressions
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 29e3880109e357fdc607b4393f8308cef6af9413 upstream.

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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/netfilter/nf_tables_api.c | 5 +++--
 net/netfilter/nft_compat.c    | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1682,7 +1682,7 @@ err:
 static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
 				   struct nft_rule *rule)
 {
-	struct nft_expr *expr;
+	struct nft_expr *expr, *next;
 
 	/*
 	 * Careful: some expressions might not be initialized in case this
@@ -1690,8 +1690,9 @@ static void nf_tables_rule_destroy(const
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
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -398,6 +398,7 @@ nft_match_destroy(const struct nft_ctx *
 {
 	struct xt_match *match = expr->ops->data;
 	void *info = nft_expr_priv(expr);
+	struct module *me = match->me;
 	struct xt_mtdtor_param par;
 
 	par.net = ctx->net;
@@ -407,7 +408,7 @@ nft_match_destroy(const struct nft_ctx *
 	if (par.match->destroy != NULL)
 		par.match->destroy(&par);
 
-	module_put(match->me);
+	module_put(me);
 }
 
 static int

