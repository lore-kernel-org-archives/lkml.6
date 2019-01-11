Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DCEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148112063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217352;
	bh=NBWqRQglnpvjbE1B1hIoVAx5WQV9bjDWL6XPT5CtI0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0o1i/kxa6y1hDGC96HcFD4h5fTuFmezw3vQIlQA7g4aLhweK/OxediU55qDU7va2f
	 xe2LZisF8VT2HRU3uPaPFH8sFwR8iLo6NEMyaPsuOoRgUZcgl60UUPYHPp7AT0O0SG
	 xf6SdTsMpmkzKK7lSV2JL4LxxmpHZcyyI1fiOH2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390243AbfAKOfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:35:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390230AbfAKOfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:35:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E8862063F;
        Fri, 11 Jan 2019 14:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217348;
        bh=NBWqRQglnpvjbE1B1hIoVAx5WQV9bjDWL6XPT5CtI0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M9yONG/RJdh0pSI3RPMJcorcWhZWuqTcZBmKi63AxJSXY128d06Lh+ikqG8ZwNrJY
         +pUTKFM5OrnHWffK6jjLds4+QrtP2EeK+6KcjI6yWnjINB3ULcFDlWb2n6Z74W152P
         htR+f2xokfLwRJe4xIETihANqk677XrDGRlmC1pk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neel Mehta <nmehta@google.com>,
        Shane Huntley <shuntley@google.com>,
        Heather Adkins <argv@google.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 021/148] netfilter: seqadj: re-load tcp header pointer after possible head reallocation
Date:   Fri, 11 Jan 2019 15:13:19 +0100
Message-Id: <20190111131115.167895873@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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



