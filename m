Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E81C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD862077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD862077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbeICVhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:37:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42590 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbeICVhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:37:36 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8F749D06;
        Mon,  3 Sep 2018 17:16:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 029/165] netfilter: nf_tables: fix memory leaks on chain rename
Date:   Mon,  3 Sep 2018 18:55:15 +0200
Message-Id: <20180903165656.542127492@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
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

[ Upstream commit 9f8aac0be21ed5f99bd5ba0ff315d710737d1794 ]

The new name is stored in the transaction metadata, on commit,
the pointers to the old and new names are swapped.

Therefore in abort and commit case we have to free the
pointer in the chain_trans container.

In commit case, the pointer can be used by another cpu that
is currently dumping the renamed chain, thus kfree needs to
happen after waiting for rcu readers to complete.

Fixes: b7263e071a ("netfilter: nf_tables: Allow chain name of up to 255 chars")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5043,6 +5043,9 @@ static void nf_tables_commit_release(str
 	case NFT_MSG_DELTABLE:
 		nf_tables_table_destroy(&trans->ctx);
 		break;
+	case NFT_MSG_NEWCHAIN:
+		kfree(nft_trans_chain_name(trans));
+		break;
 	case NFT_MSG_DELCHAIN:
 		nf_tables_chain_destroy(trans->ctx.chain);
 		break;
@@ -5100,13 +5103,15 @@ static int nf_tables_commit(struct net *
 			nf_tables_table_notify(&trans->ctx, NFT_MSG_DELTABLE);
 			break;
 		case NFT_MSG_NEWCHAIN:
-			if (nft_trans_chain_update(trans))
+			if (nft_trans_chain_update(trans)) {
 				nft_chain_commit_update(trans);
-			else
+				nf_tables_chain_notify(&trans->ctx, NFT_MSG_NEWCHAIN);
+				/* trans destroyed after rcu grace period */
+			} else {
 				nft_clear(net, trans->ctx.chain);
-
-			nf_tables_chain_notify(&trans->ctx, NFT_MSG_NEWCHAIN);
-			nft_trans_destroy(trans);
+				nf_tables_chain_notify(&trans->ctx, NFT_MSG_NEWCHAIN);
+				nft_trans_destroy(trans);
+			}
 			break;
 		case NFT_MSG_DELCHAIN:
 			list_del_rcu(&trans->ctx.chain->list);
@@ -5246,7 +5251,7 @@ static int nf_tables_abort(struct net *n
 		case NFT_MSG_NEWCHAIN:
 			if (nft_trans_chain_update(trans)) {
 				free_percpu(nft_trans_chain_stats(trans));
-
+				kfree(nft_trans_chain_name(trans));
 				nft_trans_destroy(trans);
 			} else {
 				trans->ctx.table->use--;


