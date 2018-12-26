Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E822C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB792070B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865218;
	bh=+z7bDEYtvNBGGsFlgMMPjBtTW0WLpE2tcdsT7w9cS58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xQfKAaQqtnSzh65vvsHx6k8OFlmSCeeeAfVNNY0CDFj6qjTkyToOoOmwIkvyjvuxz
	 Oph6KXA0iddDtyzgbXbotQVzolsOrCIDflrV0zCbn81NltkkDT4jM/NfznoLe4EjQQ
	 LWXcfiah4ZZ3FDAvwaNab0SK8KBNMmJojP+ZOD2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbeLZXAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 18:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729989AbeLZWx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:53:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 408DF218E2;
        Wed, 26 Dec 2018 22:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864839;
        bh=+z7bDEYtvNBGGsFlgMMPjBtTW0WLpE2tcdsT7w9cS58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rCDZAvVoOSbRtJIrrP8dL+roSPj5x3B40bH+iPg6h1ufqPsXcR0a4VAmRP9B16Nml
         OifBhfaBpiShS/hAAhFlttsRR9SlGRIlrw1HJsBqnHrQhMtU/tdjLNsNYRW7u07MEr
         ToDR7ZiYtP9lufvS5wXj2ou6wDzpMnGTqD45TSjU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 08/35] netfilter: seqadj: re-load tcp header pointer after possible head reallocation
Date:   Wed, 26 Dec 2018 17:41:15 -0500
Message-Id: <20181226224142.150866-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226224142.150866-1-sashal@kernel.org>
References: <20181226224142.150866-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 530aad77010b81526586dfc09130ec875cd084e4 ]

When adjusting sack block sequence numbers, skb_make_writable() gets
called to make sure tcp options are all in the linear area, and buffer
is not shared.

This can cause tcp header pointer to get reallocated, so we must
reaload it to avoid memory corruption.

This bug pre-dates git history.

Reported-by: Neel Mehta <nmehta@google.com>
Reported-by: Shane Huntley <shuntley@google.com>
Reported-by: Heather Adkins <argv@google.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_seqadj.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_conntrack_seqadj.c b/net/netfilter/nf_conntrack_seqadj.c
index ef7063eced7c..dad08b9eaf62 100644
--- a/net/netfilter/nf_conntrack_seqadj.c
+++ b/net/netfilter/nf_conntrack_seqadj.c
@@ -115,12 +115,12 @@ static void nf_ct_sack_block_adjust(struct sk_buff *skb,
 /* TCP SACK sequence number adjustment */
 static unsigned int nf_ct_sack_adjust(struct sk_buff *skb,
 				      unsigned int protoff,
-				      struct tcphdr *tcph,
 				      struct nf_conn *ct,
 				      enum ip_conntrack_info ctinfo)
 {
-	unsigned int dir, optoff, optend;
+	struct tcphdr *tcph = (void *)skb->data + protoff;
 	struct nf_conn_seqadj *seqadj = nfct_seqadj(ct);
+	unsigned int dir, optoff, optend;
 
 	optoff = protoff + sizeof(struct tcphdr);
 	optend = protoff + tcph->doff * 4;
@@ -128,6 +128,7 @@ static unsigned int nf_ct_sack_adjust(struct sk_buff *skb,
 	if (!skb_make_writable(skb, optend))
 		return 0;
 
+	tcph = (void *)skb->data + protoff;
 	dir = CTINFO2DIR(ctinfo);
 
 	while (optoff < optend) {
@@ -207,7 +208,7 @@ int nf_ct_seq_adjust(struct sk_buff *skb,
 		 ntohl(newack));
 	tcph->ack_seq = newack;
 
-	res = nf_ct_sack_adjust(skb, protoff, tcph, ct, ctinfo);
+	res = nf_ct_sack_adjust(skb, protoff, ct, ctinfo);
 out:
 	spin_unlock_bh(&ct->lock);
 
-- 
2.19.1

