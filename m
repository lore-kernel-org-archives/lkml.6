Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBDEC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742032084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfBCN6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:58:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53762 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728348AbfBCNt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:59 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9k-0003tv-KJ; Sun, 03 Feb 2019 13:49:56 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9g-0007BU-GF; Sun, 03 Feb 2019 14:49:52 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Florian Westphal" <fw@strlen.de>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.595827012@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 190/305] netfilter: nf_tables: don't use position
 attribute on rule replacement
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

commit 447750f281abef547be44fdcfe3bc4447b3115a8 upstream.

Its possible to set both HANDLE and POSITION when replacing a rule.
In this case, the rule at POSITION gets replaced using the
userspace-provided handle.  Rule handles are supposed to be generated
by the kernel only.

Duplicate handles should be harmless, however better disable this "feature"
by only checking for the POSITION attribute on insert operations.

Fixes: 5e94846686d0 ("netfilter: nf_tables: add insert operation")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[bwh: Backported to 3.16:
 - Don't use extack
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1767,16 +1767,13 @@ static int nf_tables_newrule(struct sock
 
 		if (chain->use == UINT_MAX)
 			return -EOVERFLOW;
-	}
-
-	if (nla[NFTA_RULE_POSITION]) {
-		if (!(nlh->nlmsg_flags & NLM_F_CREATE))
-			return -EOPNOTSUPP;
 
-		pos_handle = be64_to_cpu(nla_get_be64(nla[NFTA_RULE_POSITION]));
-		old_rule = __nf_tables_rule_lookup(chain, pos_handle);
-		if (IS_ERR(old_rule))
-			return PTR_ERR(old_rule);
+		if (nla[NFTA_RULE_POSITION]) {
+			pos_handle = be64_to_cpu(nla_get_be64(nla[NFTA_RULE_POSITION]));
+			old_rule = __nf_tables_rule_lookup(chain, pos_handle);
+			if (IS_ERR(old_rule))
+				return PTR_ERR(old_rule);
+		}
 	}
 
 	nft_ctx_init(&ctx, skb, nlh, afi, table, chain, nla);

