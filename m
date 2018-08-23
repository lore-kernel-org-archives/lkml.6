Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ED0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F13208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F13208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388461AbeHWMaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:30:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55666 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHWMaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:30:15 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 38761C83;
        Thu, 23 Aug 2018 09:01:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 224/324] netfilter: nft_compat: explicitly reject ERROR and standard target
Date:   Thu, 23 Aug 2018 09:54:50 +0200
Message-Id: <20180823075007.362823755@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 21d5e078192d244df3d6049f9464fff2f72cfd68 ]

iptables-nft never requests these, but make this explicitly illegal.
If it were quested, kernel could oops as ->eval is NULL, furthermore,
the builtin targets have no owning module so its possible to rmmod
eb/ip/ip6_tables module even if they would be loaded.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nft_compat.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -825,10 +825,18 @@ nft_target_select_ops(const struct nft_c
 	rev = ntohl(nla_get_be32(tb[NFTA_TARGET_REV]));
 	family = ctx->family;
 
+	if (strcmp(tg_name, XT_ERROR_TARGET) == 0 ||
+	    strcmp(tg_name, XT_STANDARD_TARGET) == 0 ||
+	    strcmp(tg_name, "standard") == 0)
+		return ERR_PTR(-EINVAL);
+
 	/* Re-use the existing target if it's already loaded. */
 	list_for_each_entry(nft_target, &nft_target_list, head) {
 		struct xt_target *target = nft_target->ops.data;
 
+		if (!target->target)
+			continue;
+
 		if (nft_target_cmp(target, tg_name, rev, family))
 			return &nft_target->ops;
 	}
@@ -837,6 +845,11 @@ nft_target_select_ops(const struct nft_c
 	if (IS_ERR(target))
 		return ERR_PTR(-ENOENT);
 
+	if (!target->target) {
+		err = -EINVAL;
+		goto err;
+	}
+
 	if (target->targetsize > nla_len(tb[NFTA_TARGET_INFO])) {
 		err = -EINVAL;
 		goto err;


