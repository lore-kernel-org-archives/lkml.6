Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DC6C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E19222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025525;
	bh=Vs+gYFy4G/lZQ6H1hD7s7EbUwA8vd3ah9IZw+/KbQpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QQunExnem6uOfGyefWzvXXF33dYmVYNl+7IONimG6Fk011GcYaLAmilRPGTn+R/dg
	 xa/8Uvum/bMNFdDVkidQFdmAtveIgc/S+c5CxaG6r6YePlTmvhb9J2Ggf51yOvVmPg
	 c2o7RusFaxf04DQKLFf7m1/2w4Utvj5r+RbZJt4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388597AbfBMCio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:38:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732636AbfBMCih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:38:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02B26222C2;
        Wed, 13 Feb 2019 02:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025516;
        bh=Vs+gYFy4G/lZQ6H1hD7s7EbUwA8vd3ah9IZw+/KbQpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5DSHqplnubWgzPzlAnB4HxR844XKCER6PrbRAYqY4TbHOWtJLE4r0M7UCQIvhATI
         yDKqWYd6wBl7qDWu+UBl3pDyFbb1zGCqE/OTlKL0X2wd2wm4E5ejuE4K8frzdpnRzh
         xom1jetBIwqxPGaj+iYZsc/uC1XLgEcLM56L+ZHQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Henry Yen <henry.yen@mediatek.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 56/83] netfilter: nft_flow_offload: fix checking method of conntrack helper
Date:   Tue, 12 Feb 2019 21:36:34 -0500
Message-Id: <20190213023701.20286-56-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henry Yen <henry.yen@mediatek.com>

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
index 4d7cf943fff2..436cc14cfc59 100644
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

