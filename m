Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E779C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19CC2082A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyaFP8D+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19CC2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbeKMPrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:47:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731441AbeKMPrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:47:05 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 447EC22513;
        Tue, 13 Nov 2018 05:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088237;
        bh=626VPZqTF4I4yzmjBzHfGeNsx97jmzm1Rct1ccTIGVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UyaFP8D+U8k0yiIX8lfYbLs1Q+GQMX4fr5Qz5e46NUsjX/v7RMchQMSyfCh3PX9eA
         0sDy2OKRfR3U1WMOszT3Y7J6wzWpmZ9Mkvqh0ZNJKvNmf+ZgMyLYDadmGxJiXVHjKp
         a0be7O/32mZxRSlYwBzJmi4X4TuTaZkegvwvIqZU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 36/44] clk: ti: fix OF child-node lookup
Date:   Tue, 13 Nov 2018 00:49:42 -0500
Message-Id: <20181113054950.77898-36-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113054950.77898-1-sashal@kernel.org>
References: <20181113054950.77898-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 00a461cc32ec27fa7bd9c874a7b36b0c6c542c12 ]

Fix child-node lookup which by using the wrong OF helper was searching
the whole tree depth-first, something which could end up matching an
unrelated node.

Also fix the related node-reference leaks.

Fixes: 5b385a45e001 ("clk: ti: add support for clkctrl aliases")
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ti/clk.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 7d22e1af2247..27e0979b3158 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -129,7 +129,7 @@ int ti_clk_setup_ll_ops(struct ti_clk_ll_ops *ops)
 void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 {
 	struct ti_dt_clk *c;
-	struct device_node *node;
+	struct device_node *node, *parent;
 	struct clk *clk;
 	struct of_phandle_args clkspec;
 	char buf[64];
@@ -164,8 +164,12 @@ void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 			continue;
 
 		node = of_find_node_by_name(NULL, buf);
-		if (num_args)
-			node = of_find_node_by_name(node, "clk");
+		if (num_args) {
+			parent = node;
+			node = of_get_child_by_name(parent, "clk");
+			of_node_put(parent);
+		}
+
 		clkspec.np = node;
 		clkspec.args_count = num_args;
 		for (i = 0; i < num_args; i++) {
@@ -173,11 +177,12 @@ void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 			if (ret) {
 				pr_warn("Bad tag in %s at %d: %s\n",
 					c->node_name, i, tags[i]);
+				of_node_put(node);
 				return;
 			}
 		}
 		clk = of_clk_get_from_provider(&clkspec);
-
+		of_node_put(node);
 		if (!IS_ERR(clk)) {
 			c->lk.clk = clk;
 			clkdev_add(&c->lk);
-- 
2.17.1

