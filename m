Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1697EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE9120578
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130669;
	bh=r5jvxL4GdKv+JM0pUZrunkxB6IaCk+7uURrU/1h1eoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JvIrgxZOEJrH5ethMV8OhvzQHExqdqnKxt71+0LCoJbNv+pc7o8qXkLK6fmGs3WqE
	 cDqflIFaMJKyf9gnw4Tq5Hqrj73EZdotad2j67TSKMhKvmj4Aw5ss6LvVJFUz3xxjc
	 ZO8Zhw1Vc89drixs+BDFXBTLg/O+emrxNCa7dEoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733247AbfBYVhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:37:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727616AbfBYVhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:37:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3892920578;
        Mon, 25 Feb 2019 21:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130659;
        bh=r5jvxL4GdKv+JM0pUZrunkxB6IaCk+7uURrU/1h1eoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nmptiPQwtbKf4bNlLxqX1efJENAKsnYZdLgB3wONB2DN0U+UR/JhIon6/LcP+WTRn
         JHohTKsRm5QdcRRuLfivJ/LUXrj0LGB8W9TX882upKlFEmifytGD2CNBux+aG5P+rK
         nNVqw4G6oQBSyFFAigWvSJW+8QLRGryMGRQiBVjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.20 179/183] netfilter: nft_compat: use-after-free when deleting targets
Date:   Mon, 25 Feb 2019 22:12:32 +0100
Message-Id: <20190225195125.306063658@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 753c111f655e38bbd52fc01321266633f022ebe2 upstream.

Fetch pointer to module before target object is released.

Fixes: 29e3880109e3 ("netfilter: nf_tables: fix use-after-free when deleting compat expressions")
Fixes: 0ca743a55991 ("netfilter: nf_tables: add compatibility layer for x_tables")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nft_compat.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -282,6 +282,7 @@ nft_target_destroy(const struct nft_ctx
 {
 	struct xt_target *target = expr->ops->data;
 	void *info = nft_expr_priv(expr);
+	struct module *me = target->me;
 	struct xt_tgdtor_param par;
 
 	par.net = ctx->net;
@@ -292,7 +293,7 @@ nft_target_destroy(const struct nft_ctx
 		par.target->destroy(&par);
 
 	if (nft_xt_put(container_of(expr->ops, struct nft_xt, ops)))
-		module_put(target->me);
+		module_put(me);
 }
 
 static int nft_extension_dump_info(struct sk_buff *skb, int attr,


