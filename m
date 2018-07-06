Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA119C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F78208D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F78208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933984AbeGFFup (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:50:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32836 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933878AbeGFFul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:50:41 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DA4DA86A;
        Fri,  6 Jul 2018 05:50:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 25/61] netfilter: nft_compat: fix handling of large matchinfo size
Date:   Fri,  6 Jul 2018 07:46:49 +0200
Message-Id: <20180706054713.298925078@linuxfoundation.org>
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

commit 732a8049f365f514d0607e03938491bf6cb0d620 upstream.

currently matchinfo gets stored in the expression, but some xt matches
are very large.

To handle those we either need to switch nft core to kvmalloc and increase
size limit, or allocate the info blob of large matches separately.

This does the latter, this limits the scope of the changes to
nft_compat.

I picked a threshold of 192, this allows most matches to work as before and
handle only few ones via separate alloation (cgroup, u32, sctp, rt).

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nft_compat.c |   64 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -36,6 +36,13 @@ struct nft_xt {
 	struct rcu_head		rcu_head;
 };
 
+/* Used for matches where *info is larger than X byte */
+#define NFT_MATCH_LARGE_THRESH	192
+
+struct nft_xt_match_priv {
+	void *info;
+};
+
 static bool nft_xt_put(struct nft_xt *xt)
 {
 	if (--xt->refcnt == 0) {
@@ -352,6 +359,15 @@ static void __nft_match_eval(const struc
 	}
 }
 
+static void nft_match_large_eval(const struct nft_expr *expr,
+				 struct nft_regs *regs,
+				 const struct nft_pktinfo *pkt)
+{
+	struct nft_xt_match_priv *priv = nft_expr_priv(expr);
+
+	__nft_match_eval(expr, regs, pkt, priv->info);
+}
+
 static void nft_match_eval(const struct nft_expr *expr,
 			   struct nft_regs *regs,
 			   const struct nft_pktinfo *pkt)
@@ -458,6 +474,24 @@ nft_match_init(const struct nft_ctx *ctx
 	return __nft_match_init(ctx, expr, tb, nft_expr_priv(expr));
 }
 
+static int
+nft_match_large_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
+		     const struct nlattr * const tb[])
+{
+	struct nft_xt_match_priv *priv = nft_expr_priv(expr);
+	struct xt_match *m = expr->ops->data;
+	int ret;
+
+	priv->info = kmalloc(XT_ALIGN(m->matchsize), GFP_KERNEL);
+	if (!priv->info)
+		return -ENOMEM;
+
+	ret = __nft_match_init(ctx, expr, tb, priv->info);
+	if (ret)
+		kfree(priv->info);
+	return ret;
+}
+
 static void
 __nft_match_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr,
 		    void *info)
@@ -482,6 +516,15 @@ nft_match_destroy(const struct nft_ctx *
 	__nft_match_destroy(ctx, expr, nft_expr_priv(expr));
 }
 
+static void
+nft_match_large_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr)
+{
+	struct nft_xt_match_priv *priv = nft_expr_priv(expr);
+
+	__nft_match_destroy(ctx, expr, priv->info);
+	kfree(priv->info);
+}
+
 static int __nft_match_dump(struct sk_buff *skb, const struct nft_expr *expr,
 			    void *info)
 {
@@ -503,6 +546,13 @@ static int nft_match_dump(struct sk_buff
 	return __nft_match_dump(skb, expr, nft_expr_priv(expr));
 }
 
+static int nft_match_large_dump(struct sk_buff *skb, const struct nft_expr *e)
+{
+	struct nft_xt_match_priv *priv = nft_expr_priv(e);
+
+	return __nft_match_dump(skb, e, priv->info);
+}
+
 static int nft_match_validate(const struct nft_ctx *ctx,
 			      const struct nft_expr *expr,
 			      const struct nft_data **data)
@@ -670,6 +720,7 @@ nft_match_select_ops(const struct nft_ct
 {
 	struct nft_xt *nft_match;
 	struct xt_match *match;
+	unsigned int matchsize;
 	char *mt_name;
 	u32 rev, family;
 	int err;
@@ -709,7 +760,6 @@ nft_match_select_ops(const struct nft_ct
 
 	nft_match->refcnt = 0;
 	nft_match->ops.type = &nft_match_type;
-	nft_match->ops.size = NFT_EXPR_SIZE(XT_ALIGN(match->matchsize));
 	nft_match->ops.eval = nft_match_eval;
 	nft_match->ops.init = nft_match_init;
 	nft_match->ops.destroy = nft_match_destroy;
@@ -717,6 +767,18 @@ nft_match_select_ops(const struct nft_ct
 	nft_match->ops.validate = nft_match_validate;
 	nft_match->ops.data = match;
 
+	matchsize = NFT_EXPR_SIZE(XT_ALIGN(match->matchsize));
+	if (matchsize > NFT_MATCH_LARGE_THRESH) {
+		matchsize = NFT_EXPR_SIZE(sizeof(struct nft_xt_match_priv));
+
+		nft_match->ops.eval = nft_match_large_eval;
+		nft_match->ops.init = nft_match_large_init;
+		nft_match->ops.destroy = nft_match_large_destroy;
+		nft_match->ops.dump = nft_match_large_dump;
+	}
+
+	nft_match->ops.size = matchsize;
+
 	list_add(&nft_match->head, &nft_match_list);
 
 	return &nft_match->ops;


