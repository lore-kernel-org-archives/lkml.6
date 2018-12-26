Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BEDC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48B621741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863795;
	bh=eaB6zTWiRhLQKC41KnAq4StHY58D5xcNzLitDqaJ/6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MgeIed5Fk8szdqLIvHFyfWBftdT1zvAkqtys6XuZpRqyPGkjMHSwE7GVW4y6kkQcG
	 WLdvm6VAYASwX3LNf7X2ygywo0CQUvK4Bg+Wm/qVZeyZEM8q3pq6301dFnuYSxAom6
	 wz2wbNoDmAPrrEzOShStObt6zUU7zxVSHzqz9nG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeLZWgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:36:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbeLZWgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D645E21741;
        Wed, 26 Dec 2018 22:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863790;
        bh=eaB6zTWiRhLQKC41KnAq4StHY58D5xcNzLitDqaJ/6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J6WQrOwAQQImV1G/4PGe4pNrIe0bWWzqr3vD9Bk65t+tcFVwtIHSR3j6fjsXtthCj
         +dzN+mS3M9o14FpGHCPlKz92Em78XW8eij64AsoAjmRQFq9ADH7HT/MLZ2xejjMKN1
         sH+KjA3/lapIiImygSWVpf6O+n/PXg3AJG0NhAqc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 21/97] netfilter: seqadj: re-load tcp header pointer after possible head reallocation
Date:   Wed, 26 Dec 2018 17:34:41 -0500
Message-Id: <20181226223557.149329-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
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
index a975efd6b8c3..9da303461069 100644
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

