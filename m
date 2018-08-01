Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B370C43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E8020894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E8020894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733033AbeHAD51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 23:57:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10197 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732944AbeHAD51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 23:57:27 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BF46F736A4ABC;
        Wed,  1 Aug 2018 10:14:10 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 10:14:06 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <pablo@netfilter.org>,
        <kadlec@blackhole.kfki.hu>, <fw@strlen.de>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] netfilter: nf_tables: remove redundant variables 'create' and 'ext'
Date:   Wed, 1 Aug 2018 10:14:00 +0800
Message-ID: <20180801021400.13020-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables 'create' and 'ext'  are being assigned but are never used hence
they are redundant and can be removed.

Cleans up clang warnings:
net/netfilter/nf_tables_api.c:3364:7: warning: variable ‘create’ set but not used [-Wunused-but-set-variable]
net/netfilter/nf_tables_api.c:4032:28: warning: variable ‘ext’ set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/netfilter/nf_tables_api.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index f180856..4a3085f 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3361,7 +3361,6 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 	struct nft_ctx ctx;
 	char *name;
 	unsigned int size;
-	bool create;
 	u64 timeout;
 	u32 ktype, dtype, flags, policy, gc_int, objtype;
 	struct nft_set_desc desc;
@@ -3462,8 +3461,6 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 			return err;
 	}
 
-	create = nlh->nlmsg_flags & NLM_F_CREATE ? true : false;
-
 	table = nft_table_lookup(net, nla[NFTA_SET_TABLE], family, genmask);
 	if (IS_ERR(table)) {
 		NL_SET_BAD_ATTR(extack, nla[NFTA_SET_TABLE]);
@@ -4029,7 +4026,6 @@ static int nft_get_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			    const struct nlattr *attr)
 {
 	struct nlattr *nla[NFTA_SET_ELEM_MAX + 1];
-	const struct nft_set_ext *ext;
 	struct nft_data_desc desc;
 	struct nft_set_elem elem;
 	struct sk_buff *skb;
@@ -4063,7 +4059,6 @@ static int nft_get_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		return PTR_ERR(priv);
 
 	elem.priv = priv;
-	ext = nft_set_elem_ext(set, &elem);
 
 	err = -ENOMEM;
 	skb = nlmsg_new(NLMSG_GOODSIZE, GFP_ATOMIC);
-- 
2.7.0


