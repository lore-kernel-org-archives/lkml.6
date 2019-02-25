Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAC6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C585020652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131273;
	bh=cSaJ9mrxLxX1IF6EOprS+u2E1Pcue6qg1mFCV9bnp28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NUao83GkHARt9xxxVL8y/7TZ6lsx+Nnb3i7hF4SMuxyNg7s5rL/2fdvJatqAlyjQl
	 55RTgyVcuRMpNn9c1enOGasznRUtw0TgcFmfQDGFg1b90MQlkXcmsZQZCCPsxOYBQD
	 9qFRgO9uNg+Obq3AygOsOaWmyf+TNG7fq5ipazwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbfBYV1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:27:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730296AbfBYV1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:27:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BB202087C;
        Mon, 25 Feb 2019 21:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130035;
        bh=cSaJ9mrxLxX1IF6EOprS+u2E1Pcue6qg1mFCV9bnp28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=psvE6MG1z7TXGxHwzrMmlAXMv0cACFxjq1VQ1PiYvk7QLid70i1bsdzrSb52aMElH
         I5zP37+Vyfz4HdmTxp3I7SydHXQTQrERATh4Qh7Ska+VV+XTebbfjQUhqgo7znNGHL
         YYrq89CgUkQrgKHDycGekjXv47sv+1VEmoTg+xF4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 147/152] netfilter: nft_compat: use-after-free when deleting targets
Date:   Mon, 25 Feb 2019 22:12:19 +0100
Message-Id: <20190225195054.821731926@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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
 
 static int nft_target_dump(struct sk_buff *skb, const struct nft_expr *expr)


