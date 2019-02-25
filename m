Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDC9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F1421852
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129803;
	bh=wMzs+VyI+SmbSjop3+f+PvKy7o1TQb8bzS1usiM/uDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yc+AfYpS83mgQqKevxTOKqygj/gVltLaFHDMVyRBTUe1lza7Lfm+7eQ0IoAqgOLN3
	 sjlL9MQ/MHzgtlsmFmfo4RYEiI4oDcOQ1FCP6mWQ3s3yZ6fkgN+r8myZW7lO1sHlIx
	 wx2dTNX7pWj7gAhohpQc8zxEEt1bIPvLYI8jvZJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbfBYVXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:23:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730408AbfBYVXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:23:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 534C421852;
        Mon, 25 Feb 2019 21:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129796;
        bh=wMzs+VyI+SmbSjop3+f+PvKy7o1TQb8bzS1usiM/uDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VIIFc09hnc1eMbglm6fARBnCJ6kR/bMUE4msGaVkLirYI7fXlU6I2fwj5O55XcHtw
         fs0XNLJ+g+S745wUMWclutjYQGfsXzZCP/oTebrg31YlF1nqyZNsEiEyWi9wwrn3Q+
         rJxKgGJajJTtDbuTNYpT/PETgJFRuYfjOwwDupZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henry Yen <henry.yen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 071/152] netfilter: nft_flow_offload: fix checking method of conntrack helper
Date:   Mon, 25 Feb 2019 22:11:03 +0100
Message-Id: <20190225195048.148024189@linuxfoundation.org>
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

[ Upstream commit 2314e879747e82896f51cce4488f6a00f3e1af7b ]

This patch uses nfct_help() to detect whether an established connection
needs conntrack helper instead of using test_bit(IPS_HELPER_BIT,
&ct->status).

The reason is that IPS_HELPER_BIT is only set when using explicit CT
target.

However, in the case that a device enables conntrack helper via command
"echo 1 > /proc/sys/net/netfilter/nf_conntrack_helper", the status of
IPS_HELPER_BIT will not present any change, and consequently it loses
the checking ability in the context.

Signed-off-by: Henry Yen <henry.yen@mediatek.com>
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Tested-by: John Crispin <john@phrozen.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_flow_offload.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 4d7cf943fff2c..436cc14cfc59b 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -12,6 +12,7 @@
 #include <net/netfilter/nf_conntrack_core.h>
 #include <linux/netfilter/nf_conntrack_common.h>
 #include <net/netfilter/nf_flow_table.h>
+#include <net/netfilter/nf_conntrack_helper.h>
 
 struct nft_flow_offload {
 	struct nft_flowtable	*flowtable;
@@ -66,6 +67,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 {
 	struct nft_flow_offload *priv = nft_expr_priv(expr);
 	struct nf_flowtable *flowtable = &priv->flowtable->data;
+	const struct nf_conn_help *help;
 	enum ip_conntrack_info ctinfo;
 	struct nf_flow_route route;
 	struct flow_offload *flow;
@@ -88,7 +90,8 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 		goto out;
 	}
 
-	if (test_bit(IPS_HELPER_BIT, &ct->status))
+	help = nfct_help(ct);
+	if (help)
 		goto out;
 
 	if (ctinfo == IP_CT_NEW ||
-- 
2.19.1



