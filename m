Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4913AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D12E20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D12E20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbeICVhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:37:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42606 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbeICVhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:37:40 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 390C4D02;
        Mon,  3 Sep 2018 17:16:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 030/165] netfilter: nf_tables: dont allow to rename to already-pending name
Date:   Mon,  3 Sep 2018 18:55:16 +0200
Message-Id: <20180903165656.599549018@linuxfoundation.org>
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

[ Upstream commit c6cc94df65c3174be92afbee638f11cbb5e606a7 ]

Its possible to rename two chains to the same name in one
transaction:

nft add chain t c1
nft add chain t c2
nft 'rename chain t c1 c3;rename chain t c2 c3'

This creates two chains named 'c3'.

Appears to be harmless, both chains can still be deleted both
by name or handle, but, nevertheless, its a bug.

Walk transaction log and also compare vs. the pending renames.

Both chains can still be deleted, but nevertheless it is a bug as
we don't allow to create chains with identical names, so we should
prevent this from happening-by-rename too.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |   42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1480,7 +1480,6 @@ static int nf_tables_updchain(struct nft
 	struct nft_base_chain *basechain;
 	struct nft_stats *stats = NULL;
 	struct nft_chain_hook hook;
-	const struct nlattr *name;
 	struct nf_hook_ops *ops;
 	struct nft_trans *trans;
 	int err, i;
@@ -1531,12 +1530,11 @@ static int nf_tables_updchain(struct nft
 			return PTR_ERR(stats);
 	}
 
+	err = -ENOMEM;
 	trans = nft_trans_alloc(ctx, NFT_MSG_NEWCHAIN,
 				sizeof(struct nft_trans_chain));
-	if (trans == NULL) {
-		free_percpu(stats);
-		return -ENOMEM;
-	}
+	if (trans == NULL)
+		goto err;
 
 	nft_trans_chain_stats(trans) = stats;
 	nft_trans_chain_update(trans) = true;
@@ -1546,19 +1544,37 @@ static int nf_tables_updchain(struct nft
 	else
 		nft_trans_chain_policy(trans) = -1;
 
-	name = nla[NFTA_CHAIN_NAME];
-	if (nla[NFTA_CHAIN_HANDLE] && name) {
-		nft_trans_chain_name(trans) =
-			nla_strdup(name, GFP_KERNEL);
-		if (!nft_trans_chain_name(trans)) {
-			kfree(trans);
-			free_percpu(stats);
-			return -ENOMEM;
+	if (nla[NFTA_CHAIN_HANDLE] &&
+	    nla[NFTA_CHAIN_NAME]) {
+		struct nft_trans *tmp;
+		char *name;
+
+		err = -ENOMEM;
+		name = nla_strdup(nla[NFTA_CHAIN_NAME], GFP_KERNEL);
+		if (!name)
+			goto err;
+
+		err = -EEXIST;
+		list_for_each_entry(tmp, &ctx->net->nft.commit_list, list) {
+			if (tmp->msg_type == NFT_MSG_NEWCHAIN &&
+			    tmp->ctx.table == table &&
+			    nft_trans_chain_update(tmp) &&
+			    nft_trans_chain_name(tmp) &&
+			    strcmp(name, nft_trans_chain_name(tmp)) == 0) {
+				kfree(name);
+				goto err;
+			}
 		}
+
+		nft_trans_chain_name(trans) = name;
 	}
 	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
 
 	return 0;
+err:
+	free_percpu(stats);
+	kfree(trans);
+	return err;
 }
 
 static int nf_tables_newchain(struct net *net, struct sock *nlsk,


