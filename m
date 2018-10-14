Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FFFC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058C920645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058C920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeJNXqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:46:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35669 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727023AbeJNXLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:42 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0004cW-Ci; Sun, 14 Oct 2018 16:30:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0000MA-VQ; Sun, 14 Oct 2018 16:30:18 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Pablo Neira Ayuso" <pablo@netfilter.org>,
        "Florian Westphal" <fw@strlen.de>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.921346362@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 159/366] netfilter: nf_tables: can't fail after
 linking rule into active rule list
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 569ccae68b38654f04b6842b034aa33857f605fe upstream.

rules in nftables a free'd using kfree, but protected by rcu, i.e. we
must wait for a grace period to elapse.

Normal removal patch does this, but nf_tables_newrule() doesn't obey
this rule during error handling.

It calls nft_trans_rule_add() *after* linking rule, and, if that
fails to allocate memory, it unlinks the rule and then kfree() it --
this is unsafe.

Switch order -- first add rule to transaction list, THEN link it
to public list.

Note: nft_trans_rule_add() uses GFP_KERNEL; it will not fail so this
is not a problem in practice (spotted only during code review).

Fixes: 0628b123c96d12 ("netfilter: nfnetlink: add batch support and use it from nf_tables")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[bwh: Backported to 3.16: Some function names are different]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/netfilter/nf_tables_api.c | 59 +++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 27 deletions(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1829,41 +1829,46 @@ static int nf_tables_newrule(struct sock
 	}
 
 	if (nlh->nlmsg_flags & NLM_F_REPLACE) {
-		if (nft_rule_is_active_next(net, old_rule)) {
-			trans = nft_trans_rule_add(&ctx, NFT_MSG_DELRULE,
-						   old_rule);
-			if (trans == NULL) {
-				err = -ENOMEM;
-				goto err2;
-			}
-			nft_rule_disactivate_next(net, old_rule);
-			chain->use--;
-			list_add_tail_rcu(&rule->list, &old_rule->list);
-		} else {
+		if (!nft_rule_is_active_next(net, old_rule)) {
 			err = -ENOENT;
 			goto err2;
 		}
-	} else if (nlh->nlmsg_flags & NLM_F_APPEND)
-		if (old_rule)
-			list_add_rcu(&rule->list, &old_rule->list);
-		else
-			list_add_tail_rcu(&rule->list, &chain->rules);
-	else {
-		if (old_rule)
-			list_add_tail_rcu(&rule->list, &old_rule->list);
-		else
-			list_add_rcu(&rule->list, &chain->rules);
-	}
+		trans = nft_trans_rule_add(&ctx, NFT_MSG_DELRULE,
+					   old_rule);
+		if (trans == NULL) {
+			err = -ENOMEM;
+			goto err2;
+		}
+		nft_rule_disactivate_next(net, old_rule);
+		chain->use--;
+
+		if (nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule) == NULL) {
+			err = -ENOMEM;
+			goto err2;
+		}
 
-	if (nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule) == NULL) {
-		err = -ENOMEM;
-		goto err3;
+		list_add_tail_rcu(&rule->list, &old_rule->list);
+	} else {
+		if (nft_trans_rule_add(&ctx, NFT_MSG_NEWRULE, rule) == NULL) {
+			err = -ENOMEM;
+			goto err2;
+		}
+
+		if (nlh->nlmsg_flags & NLM_F_APPEND) {
+			if (old_rule)
+				list_add_rcu(&rule->list, &old_rule->list);
+			else
+				list_add_tail_rcu(&rule->list, &chain->rules);
+		 } else {
+			if (old_rule)
+				list_add_tail_rcu(&rule->list, &old_rule->list);
+			else
+				list_add_rcu(&rule->list, &chain->rules);
+		}
 	}
 	chain->use++;
 	return 0;
 
-err3:
-	list_del_rcu(&rule->list);
 err2:
 	nf_tables_rule_destroy(&ctx, rule);
 err1:

