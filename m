Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009CCC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD7D2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8VIem1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD7D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeLEJhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:37:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbeLEJhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:37:00 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 056F520851;
        Wed,  5 Dec 2018 09:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002620;
        bh=tXID5gLhV2vKTJF4qySFQh0HFYYQhGIVKNDP5gO8dpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8VIem1aXq4Mj2/YjYUpSgMKo83V/kG2TkseZJxX7jQl30PqhrGUXxNNbo4/QdNMA
         QcZrQBfHAaf7TcQlz8pWuvnB3w/OfiZJE3116uVENf/WrnCFYmAX07AzE2pF/anPVW
         sskJ+kwqAZO4zsyQ4xhKYjpMRzRmfSS2L63V2eNQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 020/123] netfilter: nf_tables: don't skip inactive chains during update
Date:   Wed,  5 Dec 2018 04:34:12 -0500
Message-Id: <20181205093555.5386-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 0fb39bbe43d4481fcf300d2b5822de60942fd189 ]

There is no synchronization between packet path and the configuration plane.

The packet path uses two arrays with rules, one contains the current (active)
generation.  The other either contains the last (obsolete) generation or
the future one.

Consider:
cpu1               cpu2
                   nft_do_chain(c);
delete c
net->gen++;
                   genbit = !!net->gen;
                   rules = c->rg[genbit];

cpu1 ignores c when updating if c is not active anymore in the new
generation.

On cpu2, we now use rules from wrong generation, as c->rg[old]
contains the rules matching 'c' whereas c->rg[new] was not updated and
can even point to rules that have been free'd already, causing a crash.

To fix this, make sure that 'current' to the 'next' generation are
identical for chains that are going away so that c->rg[new] will just
use the matching rules even if genbit was incremented already.

Fixes: 0cbc06b3faba7 ("netfilter: nf_tables: remove synchronize_rcu in commit phase")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 2cfb173cd0b2..4c016b49fe2b 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6277,7 +6277,7 @@ static void nf_tables_commit_chain_free_rules_old(struct nft_rule **rules)
 	call_rcu(&old->h, __nf_tables_commit_chain_free_rules_old);
 }
 
-static void nf_tables_commit_chain_active(struct net *net, struct nft_chain *chain)
+static void nf_tables_commit_chain(struct net *net, struct nft_chain *chain)
 {
 	struct nft_rule **g0, **g1;
 	bool next_genbit;
@@ -6363,11 +6363,8 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 
 	/* step 2.  Make rules_gen_X visible to packet path */
 	list_for_each_entry(table, &net->nft.tables, list) {
-		list_for_each_entry(chain, &table->chains, list) {
-			if (!nft_is_active_next(net, chain))
-				continue;
-			nf_tables_commit_chain_active(net, chain);
-		}
+		list_for_each_entry(chain, &table->chains, list)
+			nf_tables_commit_chain(net, chain);
 	}
 
 	/*
-- 
2.17.1

