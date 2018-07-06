Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91506C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4717F20896
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4717F20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934285AbeGFGB0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:01:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33094 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933878AbeGFFus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:50:48 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0C0AD86A;
        Fri,  6 Jul 2018 05:50:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 27/61] netfilter: nf_tables: bogus EBUSY in chain deletions
Date:   Fri,  6 Jul 2018 07:46:51 +0200
Message-Id: <20180706054713.378287311@linuxfoundation.org>
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

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit bb7b40aecbf778c0c83a5bd62b0f03ca9f49a618 upstream.

When removing a rule that jumps to chain and such chain in the same
batch, this bogusly hits EBUSY. Add activate and deactivate operations
to expression that can be called from the preparation and the
commit/abort phases.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/netfilter/nf_tables.h |    5 ++++
 net/netfilter/nf_tables_api.c     |   46 ++++++++++++++++++++++++++++++++++----
 net/netfilter/nft_immediate.c     |   15 +++++++++---
 3 files changed, 59 insertions(+), 7 deletions(-)

--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -177,6 +177,7 @@ struct nft_data_desc {
 int nft_data_init(const struct nft_ctx *ctx,
 		  struct nft_data *data, unsigned int size,
 		  struct nft_data_desc *desc, const struct nlattr *nla);
+void nft_data_hold(const struct nft_data *data, enum nft_data_types type);
 void nft_data_release(const struct nft_data *data, enum nft_data_types type);
 int nft_data_dump(struct sk_buff *skb, int attr, const struct nft_data *data,
 		  enum nft_data_types type, unsigned int len);
@@ -731,6 +732,10 @@ struct nft_expr_ops {
 	int				(*init)(const struct nft_ctx *ctx,
 						const struct nft_expr *expr,
 						const struct nlattr * const tb[]);
+	void				(*activate)(const struct nft_ctx *ctx,
+						    const struct nft_expr *expr);
+	void				(*deactivate)(const struct nft_ctx *ctx,
+						      const struct nft_expr *expr);
 	void				(*destroy)(const struct nft_ctx *ctx,
 						   const struct nft_expr *expr);
 	int				(*dump)(struct sk_buff *skb,
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -220,6 +220,34 @@ static int nft_delchain(struct nft_ctx *
 	return err;
 }
 
+static void nft_rule_expr_activate(const struct nft_ctx *ctx,
+				   struct nft_rule *rule)
+{
+	struct nft_expr *expr;
+
+	expr = nft_expr_first(rule);
+	while (expr != nft_expr_last(rule) && expr->ops) {
+		if (expr->ops->activate)
+			expr->ops->activate(ctx, expr);
+
+		expr = nft_expr_next(expr);
+	}
+}
+
+static void nft_rule_expr_deactivate(const struct nft_ctx *ctx,
+				     struct nft_rule *rule)
+{
+	struct nft_expr *expr;
+
+	expr = nft_expr_first(rule);
+	while (expr != nft_expr_last(rule) && expr->ops) {
+		if (expr->ops->deactivate)
+			expr->ops->deactivate(ctx, expr);
+
+		expr = nft_expr_next(expr);
+	}
+}
+
 static int
 nf_tables_delrule_deactivate(struct nft_ctx *ctx, struct nft_rule *rule)
 {
@@ -265,6 +293,7 @@ static int nft_delrule(struct nft_ctx *c
 		nft_trans_destroy(trans);
 		return err;
 	}
+	nft_rule_expr_deactivate(ctx, rule);
 
 	return 0;
 }
@@ -2218,6 +2247,13 @@ static void nf_tables_rule_destroy(const
 	kfree(rule);
 }
 
+static void nf_tables_rule_release(const struct nft_ctx *ctx,
+				   struct nft_rule *rule)
+{
+	nft_rule_expr_deactivate(ctx, rule);
+	nf_tables_rule_destroy(ctx, rule);
+}
+
 #define NFT_RULE_MAXEXPRS	128
 
 static struct nft_expr_info *info;
@@ -2385,7 +2421,7 @@ static int nf_tables_newrule(struct net
 	return 0;
 
 err2:
-	nf_tables_rule_destroy(&ctx, rule);
+	nf_tables_rule_release(&ctx, rule);
 err1:
 	for (i = 0; i < n; i++) {
 		if (info[i].ops != NULL)
@@ -4054,7 +4090,7 @@ static int nf_tables_newsetelem(struct n
  *	NFT_GOTO verdicts. This function must be called on active data objects
  *	from the second phase of the commit protocol.
  */
-static void nft_data_hold(const struct nft_data *data, enum nft_data_types type)
+void nft_data_hold(const struct nft_data *data, enum nft_data_types type)
 {
 	if (type == NFT_DATA_VERDICT) {
 		switch (data->verdict.code) {
@@ -5221,10 +5257,12 @@ static int nf_tables_abort(struct net *n
 		case NFT_MSG_NEWRULE:
 			trans->ctx.chain->use--;
 			list_del_rcu(&nft_trans_rule(trans)->list);
+			nft_rule_expr_deactivate(&trans->ctx, nft_trans_rule(trans));
 			break;
 		case NFT_MSG_DELRULE:
 			trans->ctx.chain->use++;
 			nft_clear(trans->ctx.net, nft_trans_rule(trans));
+			nft_rule_expr_activate(&trans->ctx, nft_trans_rule(trans));
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWSET:
@@ -5798,7 +5836,7 @@ int __nft_release_basechain(struct nft_c
 	list_for_each_entry_safe(rule, nr, &ctx->chain->rules, list) {
 		list_del(&rule->list);
 		ctx->chain->use--;
-		nf_tables_rule_destroy(ctx, rule);
+		nf_tables_rule_release(ctx, rule);
 	}
 	list_del(&ctx->chain->list);
 	ctx->table->use--;
@@ -5832,7 +5870,7 @@ static void __nft_release_afinfo(struct
 			list_for_each_entry_safe(rule, nr, &chain->rules, list) {
 				list_del(&rule->list);
 				chain->use--;
-				nf_tables_rule_destroy(&ctx, rule);
+				nf_tables_rule_release(&ctx, rule);
 			}
 		}
 		list_for_each_entry_safe(set, ns, &table->sets, list) {
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -69,8 +69,16 @@ err1:
 	return err;
 }
 
-static void nft_immediate_destroy(const struct nft_ctx *ctx,
-				  const struct nft_expr *expr)
+static void nft_immediate_activate(const struct nft_ctx *ctx,
+				   const struct nft_expr *expr)
+{
+	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
+
+	return nft_data_hold(&priv->data, nft_dreg_to_type(priv->dreg));
+}
+
+static void nft_immediate_deactivate(const struct nft_ctx *ctx,
+				     const struct nft_expr *expr)
 {
 	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
 
@@ -108,7 +116,8 @@ static const struct nft_expr_ops nft_imm
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_immediate_expr)),
 	.eval		= nft_immediate_eval,
 	.init		= nft_immediate_init,
-	.destroy	= nft_immediate_destroy,
+	.activate	= nft_immediate_activate,
+	.deactivate	= nft_immediate_deactivate,
 	.dump		= nft_immediate_dump,
 	.validate	= nft_immediate_validate,
 };


