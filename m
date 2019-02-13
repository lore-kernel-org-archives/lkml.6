Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210FEC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E550221B68
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026858;
	bh=RQU30As3xSfIPvZkakasWO6gvoloSxpi8+9p2jDGVps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pbc/YrWDSsLoRGr0tBf4pK1Vq8s3lvCenn/Oa5Hx5CVItSdK1l33JKxKpU6iTwcVb
	 4dpNhDm2lKmmZbrzOPvINJxvQLHkRgOFoagujSykx/NY8VWF/YLuSFsYUDujwh7evy
	 vThZW/Lb1r0hxMI/PMNupwV00w7S6p48agQpQcWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390305AbfBMDAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:00:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:38954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731769AbfBMCfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:35:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D90A222C2;
        Wed, 13 Feb 2019 02:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025318;
        bh=RQU30As3xSfIPvZkakasWO6gvoloSxpi8+9p2jDGVps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bg9bSgKjBZpyIMOxSzjXsQm5Y7EoiVhj0ro87g2Rrfnuwn9ss8VVrBV3OlASu/eiM
         qJtI1b9OzFCZRf+MTDqPznNXq+wdVVH7kkhPO2Py2o1iQIl0Q420l5RIFYxmGvNUMo
         Qyp/6oAjRDj8NEN0kXrggZ2nR5g5nBxlBrnQBpAA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Henry Yen <henry.yen@mediatek.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 065/105] netfilter: nft_flow_offload: fix checking method of conntrack helper
Date:   Tue, 12 Feb 2019 21:32:56 -0500
Message-Id: <20190213023336.19019-65-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
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
index 188c6bbf4e16..6e6b9adf7d38 100644
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

