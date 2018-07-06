Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C40C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7619C208D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7619C208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933965AbeGFFuk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:50:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60892 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933878AbeGFFui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:50:38 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4573186A;
        Fri,  6 Jul 2018 05:50:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 24/61] netfilter: nft_compat: prepare for indirect info storage
Date:   Fri,  6 Jul 2018 07:46:48 +0200
Message-Id: <20180706054713.263969548@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 8bdf164744b2c7f63561846c01cff3db597f282d upstream.

Next patch will make it possible for *info to be stored in
a separate allocation instead of the expr private area.

This removes the 'expr priv area is info blob' assumption
from the match init/destroy/eval functions.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nft_compat.c |   47 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -324,11 +324,11 @@ static int nft_target_validate(const str
 	return 0;
 }
 
-static void nft_match_eval(const struct nft_expr *expr,
-			   struct nft_regs *regs,
-			   const struct nft_pktinfo *pkt)
+static void __nft_match_eval(const struct nft_expr *expr,
+			     struct nft_regs *regs,
+			     const struct nft_pktinfo *pkt,
+			     void *info)
 {
-	void *info = nft_expr_priv(expr);
 	struct xt_match *match = expr->ops->data;
 	struct sk_buff *skb = pkt->skb;
 	bool ret;
@@ -352,6 +352,13 @@ static void nft_match_eval(const struct
 	}
 }
 
+static void nft_match_eval(const struct nft_expr *expr,
+			   struct nft_regs *regs,
+			   const struct nft_pktinfo *pkt)
+{
+	__nft_match_eval(expr, regs, pkt, nft_expr_priv(expr));
+}
+
 static const struct nla_policy nft_match_policy[NFTA_MATCH_MAX + 1] = {
 	[NFTA_MATCH_NAME]	= { .type = NLA_NUL_STRING },
 	[NFTA_MATCH_REV]	= { .type = NLA_U32 },
@@ -412,10 +419,10 @@ static void match_compat_from_user(struc
 }
 
 static int
-nft_match_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
-		const struct nlattr * const tb[])
+__nft_match_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
+		 const struct nlattr * const tb[],
+		 void *info)
 {
-	void *info = nft_expr_priv(expr);
 	struct xt_match *match = expr->ops->data;
 	struct xt_mtchk_param par;
 	size_t size = XT_ALIGN(nla_len(tb[NFTA_MATCH_INFO]));
@@ -444,11 +451,18 @@ nft_match_init(const struct nft_ctx *ctx
 	return 0;
 }
 
+static int
+nft_match_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
+	       const struct nlattr * const tb[])
+{
+	return __nft_match_init(ctx, expr, tb, nft_expr_priv(expr));
+}
+
 static void
-nft_match_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr)
+__nft_match_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr,
+		    void *info)
 {
 	struct xt_match *match = expr->ops->data;
-	void *info = nft_expr_priv(expr);
 	struct xt_mtdtor_param par;
 
 	par.net = ctx->net;
@@ -462,9 +476,15 @@ nft_match_destroy(const struct nft_ctx *
 		module_put(match->me);
 }
 
-static int nft_match_dump(struct sk_buff *skb, const struct nft_expr *expr)
+static void
+nft_match_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr)
+{
+	__nft_match_destroy(ctx, expr, nft_expr_priv(expr));
+}
+
+static int __nft_match_dump(struct sk_buff *skb, const struct nft_expr *expr,
+			    void *info)
 {
-	void *info = nft_expr_priv(expr);
 	struct xt_match *match = expr->ops->data;
 
 	if (nla_put_string(skb, NFTA_MATCH_NAME, match->name) ||
@@ -478,6 +498,11 @@ nla_put_failure:
 	return -1;
 }
 
+static int nft_match_dump(struct sk_buff *skb, const struct nft_expr *expr)
+{
+	return __nft_match_dump(skb, expr, nft_expr_priv(expr));
+}
+
 static int nft_match_validate(const struct nft_ctx *ctx,
 			      const struct nft_expr *expr,
 			      const struct nft_data **data)


