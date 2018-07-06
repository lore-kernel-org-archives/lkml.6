Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00DAC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FA0208D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FA0208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934019AbeGFFuw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:50:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33038 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933976AbeGFFup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:50:45 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5A2EFC8D;
        Fri,  6 Jul 2018 05:50:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 26/61] netfilter: nf_tables: dont assume chain stats are set when jumplabel is set
Date:   Fri,  6 Jul 2018 07:46:50 +0200
Message-Id: <20180706054713.338228961@linuxfoundation.org>
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

commit 009240940e84c1c089af88b454f7e804a4c5bd1b upstream.

nft_chain_stats_replace() and all other spots assume ->stats can be
NULL, but nft_update_chain_stats does not.  It must do this check,
just because the jump label is set doesn't mean all basechains have stats
assigned.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_tables_core.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -119,15 +119,22 @@ DEFINE_STATIC_KEY_FALSE(nft_counters_ena
 static noinline void nft_update_chain_stats(const struct nft_chain *chain,
 					    const struct nft_pktinfo *pkt)
 {
+	struct nft_base_chain *base_chain;
 	struct nft_stats *stats;
 
-	local_bh_disable();
-	stats = this_cpu_ptr(rcu_dereference(nft_base_chain(chain)->stats));
-	u64_stats_update_begin(&stats->syncp);
-	stats->pkts++;
-	stats->bytes += pkt->skb->len;
-	u64_stats_update_end(&stats->syncp);
-	local_bh_enable();
+	base_chain = nft_base_chain(chain);
+	if (!base_chain->stats)
+		return;
+
+	stats = this_cpu_ptr(rcu_dereference(base_chain->stats));
+	if (stats) {
+		local_bh_disable();
+		u64_stats_update_begin(&stats->syncp);
+		stats->pkts++;
+		stats->bytes += pkt->skb->len;
+		u64_stats_update_end(&stats->syncp);
+		local_bh_enable();
+	}
 }
 
 struct nft_jumpstack {


