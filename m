Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B51C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E4823F9F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E4823F9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934664AbeGFFwm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:52:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33942 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934578AbeGFFwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:52:39 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 82B2BB14;
        Fri,  6 Jul 2018 05:52:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 49/61] netfilter: nft_limit: fix packet ratelimiting
Date:   Fri,  6 Jul 2018 07:47:13 +0200
Message-Id: <20180706054714.220952655@linuxfoundation.org>
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

[ Upstream commit 3e0f64b7dd3149f75e8652ff1df56cffeedc8fc1 ]

Credit calculations for the packet ratelimiting are not correct, as per
the applied ratelimit of 25/second and burst 8, a total of 33 packets
should have been accepted.  This is true in iptables(33) but not in
nftables (~65). For packet ratelimiting, use:

	div_u64(limit->nsecs, limit->rate) * limit->burst;

to calculate credit, just like in iptables' xt_limit does.

Moreover, use default burst in iptables, users are expecting similar
behaviour.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nft_limit.c |   38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

--- a/net/netfilter/nft_limit.c
+++ b/net/netfilter/nft_limit.c
@@ -51,10 +51,13 @@ static inline bool nft_limit_eval(struct
 	return !limit->invert;
 }
 
+/* Use same default as in iptables. */
+#define NFT_LIMIT_PKT_BURST_DEFAULT	5
+
 static int nft_limit_init(struct nft_limit *limit,
-			  const struct nlattr * const tb[])
+			  const struct nlattr * const tb[], bool pkts)
 {
-	u64 unit;
+	u64 unit, tokens;
 
 	if (tb[NFTA_LIMIT_RATE] == NULL ||
 	    tb[NFTA_LIMIT_UNIT] == NULL)
@@ -68,18 +71,25 @@ static int nft_limit_init(struct nft_lim
 
 	if (tb[NFTA_LIMIT_BURST])
 		limit->burst = ntohl(nla_get_be32(tb[NFTA_LIMIT_BURST]));
-	else
-		limit->burst = 0;
+
+	if (pkts && limit->burst == 0)
+		limit->burst = NFT_LIMIT_PKT_BURST_DEFAULT;
 
 	if (limit->rate + limit->burst < limit->rate)
 		return -EOVERFLOW;
 
-	/* The token bucket size limits the number of tokens can be
-	 * accumulated. tokens_max specifies the bucket size.
-	 * tokens_max = unit * (rate + burst) / rate.
-	 */
-	limit->tokens = div_u64(limit->nsecs * (limit->rate + limit->burst),
-				limit->rate);
+	if (pkts) {
+		tokens = div_u64(limit->nsecs, limit->rate) * limit->burst;
+	} else {
+		/* The token bucket size limits the number of tokens can be
+		 * accumulated. tokens_max specifies the bucket size.
+		 * tokens_max = unit * (rate + burst) / rate.
+		 */
+		tokens = div_u64(limit->nsecs * (limit->rate + limit->burst),
+				 limit->rate);
+	}
+
+	limit->tokens = tokens;
 	limit->tokens_max = limit->tokens;
 
 	if (tb[NFTA_LIMIT_FLAGS]) {
@@ -144,7 +154,7 @@ static int nft_limit_pkts_init(const str
 	struct nft_limit_pkts *priv = nft_expr_priv(expr);
 	int err;
 
-	err = nft_limit_init(&priv->limit, tb);
+	err = nft_limit_init(&priv->limit, tb, true);
 	if (err < 0)
 		return err;
 
@@ -185,7 +195,7 @@ static int nft_limit_bytes_init(const st
 {
 	struct nft_limit *priv = nft_expr_priv(expr);
 
-	return nft_limit_init(priv, tb);
+	return nft_limit_init(priv, tb, false);
 }
 
 static int nft_limit_bytes_dump(struct sk_buff *skb,
@@ -246,7 +256,7 @@ static int nft_limit_obj_pkts_init(const
 	struct nft_limit_pkts *priv = nft_obj_data(obj);
 	int err;
 
-	err = nft_limit_init(&priv->limit, tb);
+	err = nft_limit_init(&priv->limit, tb, true);
 	if (err < 0)
 		return err;
 
@@ -289,7 +299,7 @@ static int nft_limit_obj_bytes_init(cons
 {
 	struct nft_limit *priv = nft_obj_data(obj);
 
-	return nft_limit_init(priv, tb);
+	return nft_limit_init(priv, tb, false);
 }
 
 static int nft_limit_obj_bytes_dump(struct sk_buff *skb,


