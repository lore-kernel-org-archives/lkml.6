Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDF1C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3127D20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791368;
	bh=XrauvEOa53ikCGFVJHyx06BItSS9t0SpFyB/1npC0B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MaSyrtnDaKy0g25LJvR8oqoGiuWv0NLnUdX/VRdIG4UYN6Mg7otG8sJRr4LfPvfC5
	 R+8L09NqQAhvfMuCj4NLybqq/MljvupDZ8szyH2Hc5jUjKQiZjzEtxn7+n7skCvdna
	 bknmw1F25J5+j1jmUQ9Lkl9PUoojqtyBWexvSDlo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3127D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbeLNMCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:02:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730102AbeLNMCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F1942145D;
        Fri, 14 Dec 2018 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788961;
        bh=XrauvEOa53ikCGFVJHyx06BItSS9t0SpFyB/1npC0B0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LCrMh5JbR25Sh4o4lWoH+pNHs9qXXye9FMHldRmoziIOOPP6/mSerzAJsieZnroxL
         cTHkpSmD+M+GutzzCqZjrBhYJ2qe5mmN7F25HSIUMwGzoxa63T3g6aS/NY0HbXWL1d
         JLu4Qrv0J849Qr1FAHn2tHAhDww9wqo3Uu5xcsNk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 039/142] netfilter: nf_tables: dont skip inactive chains during update
Date:   Fri, 14 Dec 2018 12:58:44 +0100
Message-Id: <20181214115748.612121736@linuxfoundation.org>
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
2.19.1



